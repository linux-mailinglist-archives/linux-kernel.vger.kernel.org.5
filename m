Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01507B0537
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 15:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbjI0NVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 09:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbjI0NVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 09:21:01 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5A410A;
        Wed, 27 Sep 2023 06:20:59 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38RCOdCv005069;
        Wed, 27 Sep 2023 13:20:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=jv2J3s2T7OsfdnfP7xO+3G5kReH0lMyKgLkynJikBfI=;
 b=tJIYGGNUI7x+MeeJeVOcBbjIZ9cgqX/dZ9HPkBeNoUFHx0zzCrPigTsA7KPeSNVc2TlV
 aSZZAFNRXvLMnc9cKkp4H+TksK4oudv79qebAVsJSiesoktymHl8Qq4tGl1ObhMy105j
 LUPVKX8r0gSe7KenI/NO6by0jBuTUr9CLpGc0CK/y2rGBtILhqBEPlwmn8hN8GE2v64I
 VQ9BJzTe/t5LvFvuHmAdiXAHDXTPGfFyMtrMYYR+FDM33QxfGdFwNQqizZziKEZFNIZk
 TrKWWuLLepClvqBEL3FNdMYrhZfE3mX2at15iULH9drm5/lGV3qIhionZ4DbSC9hC5DT 7Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tcmcgsw85-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 13:20:14 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38RD5BuN028501;
        Wed, 27 Sep 2023 13:20:13 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tcmcgsw6v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 13:20:13 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38RB85s1011019;
        Wed, 27 Sep 2023 13:20:11 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tabukkhhn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 13:20:11 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38RDK8uR42861118
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Sep 2023 13:20:08 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3124720067;
        Wed, 27 Sep 2023 13:20:08 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 30B3420040;
        Wed, 27 Sep 2023 13:20:07 +0000 (GMT)
Received: from [9.152.212.236] (unknown [9.152.212.236])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 27 Sep 2023 13:20:07 +0000 (GMT)
Message-ID: <e1efbbd827e34800bd7fb0ea687645cc6c65e1ab.camel@linux.ibm.com>
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
Date:   Wed, 27 Sep 2023 15:20:07 +0200
In-Reply-To: <b06a14de270a63050b0d027c24b333dba25001a4.camel@linux.ibm.com>
References: <20230825-dma_iommu-v12-0-4134455994a7@linux.ibm.com>
         <ZRLy_AaJiXxZ2AfK@8bytes.org> <20230926160832.GM13795@ziepe.ca>
         <cfc9e9128ed5571d2e36421e347301057662a09e.camel@linux.ibm.com>
         <ZRP8CiBui7suB5D6@8bytes.org>
         <b06a14de270a63050b0d027c24b333dba25001a4.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VXZxHUsIjNmP_Qb7Pwq1202Mna4hsBUK
X-Proofpoint-ORIG-GUID: LYDctZpbLtyEpOclC1b66ehHlfvfc4KR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_07,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 spamscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 mlxscore=0 adultscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309270110
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-09-27 at 13:24 +0200, Niklas Schnelle wrote:
> On Wed, 2023-09-27 at 11:55 +0200, Joerg Roedel wrote:
> > Hi Niklas,
> >=20
> > On Wed, Sep 27, 2023 at 10:55:23AM +0200, Niklas Schnelle wrote:
> > > The problem is that something seems to  be broken in the iommu/core
> > > branch. Regardless of whether I have my DMA API conversion on top or
> > > with the base iommu/core branch I can not use ConnectX-4 VFs.
> >=20
> > Have you already tried to bisect the issue in the iommu/core branch?
> > The result might sched some light on the issue.
> >=20
> > Regards,
> >=20
> > 	Joerg
>=20
> Hi Joerg,
>=20
> Working on it, somehow I must have messed up earlier. It now looks like
> it might in fact be caused by my DMA API conversion rebase and the
> "s390/pci: Use dma-iommu layer" commit. Maybe there is some interaction
> with Jason's patches that I haven't thought about. So sorry for any
> wrong blame.
>=20
> Thanks,
> Niklas

Hi,

I tracked the problem=C2=A0down from mlx5_core's alloc_cmd_page() via
dma_alloc_coherent(), ops->alloc, iommu_dma_alloc_remap(), and
__iommu_dma_alloc_noncontiguous() to a failed iommu_dma_alloc_iova().
The allocation here is for 4K so nothing crazy.

On second look I also noticed:

nvme 2007:00:00.0: Using 42-bit DMA addresses

for the NVMe that is working. The problem here seems to be that we set
iommu_dma_forcedac =3D true in s390_iommu_probe_finalize() because we
have currently have a reserved region over the first 4 GiB anyway so
will always use IOVAs larger than that. That however is too late since
iommu_dma_set_pci_32bit_workaround() is already checked in
__iommu_probe_device() which is called just before ops-
>probe_finalize(). So I moved setting iommu_dma_forcedac =3D true to
zpci_init_iommu() and that gets rid of the notice for the NVMe but I
still get a failure of iommu_dma_alloc_iova() in
__iommu_dma_alloc_noncontiguous(). So I'll keep digging.

Thanks,
Niklas
