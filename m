Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58ACA7B081C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbjI0PZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232350AbjI0PZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:25:12 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD8C121;
        Wed, 27 Sep 2023 08:25:10 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38RF9bGt013931;
        Wed, 27 Sep 2023 15:24:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=4GPUWKZBZaFYZhimWD5PFmL2oSJK61nkKmWq/1HRzfE=;
 b=pGD5yYhHZPXV3FeyG3eNaMML/UeQExGT+ai7edcPW8GFAbJMrq5WuQsLABBSBh/9onkR
 qJEXWOwnsIhMT+5To2DVZ949fEsLY2pEbXikCAXRX1w+ha859lRUnJAWl57sac1Ug+Pk
 PZbAm0kNSBXnp6n5gVrOJUMtABk3ywDPTCMy6MlAULNFrVKAJuqBC23DXYzhXHS50flM
 /nr/8midSqe0+CVgvu9cSDL81aiKfqQN99l1BsqzWUeRu3Oaf6lXiPFviy95PuyX6Wqv
 IxEoEQiGuj6Ql2UQ0i4Y8YHNWbx1fbX0dRIN+ojf5GCrDCz3AQtrk/IVKHWwBw8gVhy+ Kw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tcpg40spq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 15:24:27 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38RFKfwH016987;
        Wed, 27 Sep 2023 15:24:26 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tcpg40snq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 15:24:26 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38RD7jbc008126;
        Wed, 27 Sep 2023 15:24:24 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3taaqymr5f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 15:24:24 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38RFOLkO14877436
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Sep 2023 15:24:21 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 088A42004D;
        Wed, 27 Sep 2023 15:24:21 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7A20C20040;
        Wed, 27 Sep 2023 15:24:20 +0000 (GMT)
Received: from [9.152.212.236] (unknown [9.152.212.236])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 27 Sep 2023 15:24:20 +0000 (GMT)
Message-ID: <a672b6b122c7a5f708614346885c190a6960aaea.camel@linux.ibm.com>
Subject: Re: [PATCH v12 0/6] iommu/dma: s390 DMA API conversion and
 optimized IOTLB flushing
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Krishna Reddy <vdumpa@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
        linux-doc@vger.kernel.org
Date:   Wed, 27 Sep 2023 17:24:20 +0200
In-Reply-To: <6dab29f58ac1ccd58caaee031f98f4d0d382cbcd.camel@linux.ibm.com>
References: <20230825-dma_iommu-v12-0-4134455994a7@linux.ibm.com>
         <ZRLy_AaJiXxZ2AfK@8bytes.org> <20230926160832.GM13795@ziepe.ca>
         <cfc9e9128ed5571d2e36421e347301057662a09e.camel@linux.ibm.com>
         <ZRP8CiBui7suB5D6@8bytes.org>
         <b06a14de270a63050b0d027c24b333dba25001a4.camel@linux.ibm.com>
         <e1efbbd827e34800bd7fb0ea687645cc6c65e1ab.camel@linux.ibm.com>
         <6dab29f58ac1ccd58caaee031f98f4d0d382cbcd.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1V1HFM5XJ2XYGhTpmGqGOrM8x8bKe6Pt
X-Proofpoint-GUID: MdpAhX9T9gQ4cUAJLa_z553KP9Gq2ZRV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_09,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 mlxlogscore=999
 impostorscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2309270127
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-09-27 at 16:31 +0200, Niklas Schnelle wrote:
> On Wed, 2023-09-27 at 15:20 +0200, Niklas Schnelle wrote:
> > On Wed, 2023-09-27 at 13:24 +0200, Niklas Schnelle wrote:
> > > On Wed, 2023-09-27 at 11:55 +0200, Joerg Roedel wrote:
> > > > Hi Niklas,
> > > >=20
> > > > On Wed, Sep 27, 2023 at 10:55:23AM +0200, Niklas Schnelle wrote:
> > > > > The problem is that something seems to  be broken in the iommu/co=
re
> > > > > branch. Regardless of whether I have my DMA API conversion on top=
 or
> > > > > with the base iommu/core branch I can not use ConnectX-4 VFs.
> > > >=20
> > > > Have you already tried to bisect the issue in the iommu/core branch=
?
> > > > The result might sched some light on the issue.
> > > >=20
> > > > Regards,
> > > >=20
> > > > 	Joerg
> > >=20
> > > Hi Joerg,
> > >=20
> > > Working on it, somehow I must have messed up earlier. It now looks li=
ke
> > > it might in fact be caused by my DMA API conversion rebase and the
> > > "s390/pci: Use dma-iommu layer" commit. Maybe there is some interacti=
on
> > > with Jason's patches that I haven't thought about. So sorry for any
> > > wrong blame.
> > >=20
> > > Thanks,
> > > Niklas
> >=20
> > Hi,
> >=20
> > I tracked the problem=C2=A0down from mlx5_core's alloc_cmd_page() via
> > dma_alloc_coherent(), ops->alloc, iommu_dma_alloc_remap(), and
> > __iommu_dma_alloc_noncontiguous() to a failed iommu_dma_alloc_iova().
> > The allocation here is for 4K so nothing crazy.
> >=20
> > On second look I also noticed:
> >=20
> > nvme 2007:00:00.0: Using 42-bit DMA addresses
> >=20
> > for the NVMe that is working. The problem here seems to be that we set
> > iommu_dma_forcedac =3D true in s390_iommu_probe_finalize() because we
> > have currently have a reserved region over the first 4 GiB anyway so
> > will always use IOVAs larger than that. That however is too late since
> > iommu_dma_set_pci_32bit_workaround() is already checked in
> > __iommu_probe_device() which is called just before ops-
> > > probe_finalize(). So I moved setting iommu_dma_forcedac =3D true to
> > zpci_init_iommu() and that gets rid of the notice for the NVMe but I
> > still get a failure of iommu_dma_alloc_iova() in
> > __iommu_dma_alloc_noncontiguous(). So I'll keep digging.
> >=20
> > Thanks,
> > Niklas
>=20
>=20
> Ok I think I got it and this doesn't seem strictly s390x specific but
> I'd think should happen with iommu.forcedac=3D1 everywhere.
>=20
> The reason iommu_dma_alloc_iova() fails seems to be that mlx5_core does
> dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64)) in=C2=A0
> mlx5_pci_init()->set_dma_caps() which happens after it already called
> mlx5_mdev_init()->mlx5_cmd_init()->alloc_cmd_page() so for the
> dma_alloc_coherent() in there the dev->coherent_dma_mask is still
> DMA_BIT_MASK(32) for which we can't find an IOVA because well we don't
> have IOVAs below 4 GiB. Not entirely sure what caused this not to be
> enforced before.
>=20
> Thanks,
> Niklas
>=20

Ok, another update. On trying it out again this problem actually also
occurs when applying this v12 on top of v6.6-rc3 too. Also I guess
unlike my prior thinking it probably doesn't occur with
iommu.forcedac=3D1 since that still allows IOVAs below 4 GiB and we might
be the only ones who don't support those. From my point of view this
sounds like a mlx5_core issue they really should call
dma_set_mask_and_coherent() before their first call to
dma_alloc_coherent() not after. So I guess I'll send a v13 of this
series rebased on iommu/core and with an additional mlx5 patch and then
let's hope we can get that merged in a way that doesn't leave us with
broken ConnectX VFs for too long.

Thanks,
Niklas
