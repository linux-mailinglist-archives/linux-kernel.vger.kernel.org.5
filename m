Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10FBC7AFF18
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjI0I40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjI0I4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:56:23 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91651BF;
        Wed, 27 Sep 2023 01:56:22 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38R8fwt9003378;
        Wed, 27 Sep 2023 08:55:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=lIdgU+j4pcq6jgSk/q19qdaxkwH1rtCWHqvoVCfZIT4=;
 b=gMLHMIgbd0OHt2L39u5X2z9jCc+8hmAe0RgqF5igvrD7NALxCV6PuuTIRFmhWj5AWad1
 Zo//FrrS24Bs/hyNmnq5uJSgOU9iltfJWRO2RlQjdkx/j6qlxx/5vQd4KREhF1VNV/Bo
 gEDvHIC0e3MS88IR6+zXbNXCX1pMn1rWxdby0r6gPyOwJz0SZf1nyKdGlKo4J4HfTd/g
 TI5OvYCrbxA/wdukKkUG1vkUJ9MZFHL2SzL7qbyIlWtz98kRREkCpWile4E4o1OXJJzN
 CenqSvytDspSEtB7BzEaDF7M85TKLR8Sf4seckFi5VCfOOBZvSnA/fZuwKo/G1Ua0KgY fQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tch40r8sd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 08:55:30 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38R8hiew007669;
        Wed, 27 Sep 2023 08:55:29 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tch40r8s0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 08:55:29 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38R6btJ6011003;
        Wed, 27 Sep 2023 08:55:28 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tabukhy17-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 08:55:27 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38R8tOsm22086172
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Sep 2023 08:55:24 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9702D20049;
        Wed, 27 Sep 2023 08:55:24 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E425B2004F;
        Wed, 27 Sep 2023 08:55:23 +0000 (GMT)
Received: from [9.152.212.236] (unknown [9.152.212.236])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 27 Sep 2023 08:55:23 +0000 (GMT)
Message-ID: <cfc9e9128ed5571d2e36421e347301057662a09e.camel@linux.ibm.com>
Subject: Re: [PATCH v12 0/6] iommu/dma: s390 DMA API conversion and
 optimized IOTLB flushing
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>
Cc:     Matthew Rosato <mjrosato@linux.ibm.com>,
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
Date:   Wed, 27 Sep 2023 10:55:23 +0200
In-Reply-To: <20230926160832.GM13795@ziepe.ca>
References: <20230825-dma_iommu-v12-0-4134455994a7@linux.ibm.com>
         <ZRLy_AaJiXxZ2AfK@8bytes.org> <20230926160832.GM13795@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fk640NFOtXDH3DMsOHfVdr5_SUPSgU-Z
X-Proofpoint-GUID: XCoTgBapi9PTwWMlIJs26pFRy3h2v45s
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_03,2023-09-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 malwarescore=0 clxscore=1011
 adultscore=0 spamscore=0 phishscore=0 mlxlogscore=664 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309270069
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-09-26 at 13:08 -0300, Jason Gunthorpe wrote:
> On Tue, Sep 26, 2023 at 05:04:28PM +0200, Joerg Roedel wrote:
> > Hi Niklas,
> >=20
> > On Fri, Aug 25, 2023 at 12:11:15PM +0200, Niklas Schnelle wrote:
> > > Niklas Schnelle (6):
> > >       iommu: Allow .iotlb_sync_map to fail and handle s390's -ENOMEM =
return
> > >       s390/pci: prepare is_passed_through() for dma-iommu
> > >       s390/pci: Use dma-iommu layer
> > >       iommu/s390: Disable deferred flush for ISM devices
> > >       iommu/dma: Allow a single FQ in addition to per-CPU FQs
> > >       iommu/dma: Use a large flush queue and timeout for shadow_on_fl=
ush
> >=20
> > Turned out this series has non-trivial conflicts with Jasons
> > default-domain work so I had to remove it from the IOMMU tree for now.
> > Can you please rebase it to the latest iommu/core branch and re-send? I
> > will take it into the tree again then.
>=20
> Niklas, I think you just 'take yours' to resolve this. All the
> IOMMU_DOMAIN_PLATFORM related and .default_domain =3D parts should be
> removed. Let me know if you need anything
>=20
> Thanks,
> Jason

Hi Joerg, Hi Jason,

I've run into an unfortunate problem, not with the rebase itself but
with the iommu/core branch.=C2=A0

Jason is right, I basically need to just remove the platform ops and
.default_domain ops. This seems to work fine for an NVMe both in the
host and also when using the IOMMU with vfio-pci + KVM.=C2=A0I've already
pushed the result of that to my git.kernel.org:
https://git.kernel.org/pub/scm/linux/kernel/git/niks/linux.git/log/?h=3Db4/=
dma_iommu

The problem is that something seems to  be broken in the iommu/core
branch. Regardless of whether I have my DMA API conversion on top or
with the base iommu/core branch I can not use ConnectX-4 VFs.

# lspci
111a:00:00.0 Ethernet controller: Mellanox Technologies MT27710 Family [Con=
nectX-4 Lx Virtual Function]
# dmesg | grep mlx
[    3.189749] mlx5_core 111a:00:00.0: mlx5_mdev_init:1802:(pid 464): Faile=
d initializing cmdif SW structs, aborting
[    3.189783] mlx5_core: probe of 111a:00:00.0 failed with error -12

This same card works on v6.6-rc3 both with and without my DMA API
conversion patch series applied. Looking at mlx5_mdev_init() ->=20
mlx5_cmd_init(). The -ENOMEM seems to come from the following
dma_pool_create():

cmd->pool =3D dma_pool_create("mlx5_cmd", mlx5_core_dma_dev(dev), size, ali=
gn, 0);

I'll try to debug this further but wanted to let you know already in
case you have some ideas. Either way as it doesn't seem to be related
to the DMA API conversion I can sent that out again regardless if you
want, really don't want to miss another cycle.

Thanks,
Niklas
