Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B665479B2E8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355239AbjIKV5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237175AbjIKMLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 08:11:18 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8AB193;
        Mon, 11 Sep 2023 05:11:13 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38BBcf8k020281;
        Mon, 11 Sep 2023 12:09:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=HGXHlyuW7tI3KkroRX3EwubPO1mf8HTAk2ndjhHoNFs=;
 b=PWIIEP2lmDUfa1mp9pmw/oaZwzdtcpnlqzQ75hk9+FpJGvJYDU60r9trS5Z/VtLyDHft
 9WX+n5snuJJ5jbu5vUpOHlKrmCud7gkjCafXw2JlLlwDtpuM9LO25/9hM4ZNnK9/vKhf
 l1qU1LZtGDxzxdwXmQxEa86eJVFAmwBgVfDVbQFx2Nm1Almhe4faCXCK8QzNT1ejl8yF
 QR+nEvWye7K6HENvui0bkEIhPwedV8GX8xMoeAVJHxAzGF7xr7/nFp13TH8Xj3KOQHcr
 h7xH4BM63pjFCbfz/lLveE+A3kojVUwJbk8xCa7Q1WSyEsQ7FXyRLhW42+3i3S8xCX16 Ug== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t1wuq0aj0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 12:09:50 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38BBedp6028128;
        Mon, 11 Sep 2023 12:07:02 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t1wuq08ya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 12:07:02 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38BBOZ8H002318;
        Mon, 11 Sep 2023 12:06:36 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t158jsvr1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 12:06:35 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38BC6XqU66978064
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Sep 2023 12:06:33 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E64F02004B;
        Mon, 11 Sep 2023 12:06:32 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D9F220043;
        Mon, 11 Sep 2023 12:06:30 +0000 (GMT)
Received: from [9.171.58.134] (unknown [9.171.58.134])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 11 Sep 2023 12:06:30 +0000 (GMT)
Message-ID: <c5ac1459d2967c17e472d1c51d5017beb39e4714.camel@linux.ibm.com>
Subject: Re: [PATCH v12 5/6] iommu/dma: Allow a single FQ in addition to
 per-CPU FQs
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Gerd Bayer <gbayer@linux.ibm.com>,
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
Date:   Mon, 11 Sep 2023 14:06:29 +0200
In-Reply-To: <20230825-dma_iommu-v12-5-4134455994a7@linux.ibm.com>
References: <20230825-dma_iommu-v12-0-4134455994a7@linux.ibm.com>
         <20230825-dma_iommu-v12-5-4134455994a7@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 36tUcYWsI3-kwg7TjwTB82g2_ly-u1Zp
X-Proofpoint-ORIG-GUID: CMa4t0Ot4oG8TuboxO12mxpMT2o-4HQO
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_06,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 priorityscore=1501 clxscore=1011 impostorscore=0 suspectscore=0
 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0 mlxlogscore=957
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309110110
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-08-25 at 12:11 +0200, Niklas Schnelle wrote:
> In some virtualized environments, including s390 paged memory guests,
> IOTLB flushes are used to update IOMMU shadow tables. Due to this, they
> are much more expensive than in typical bare metal environments or
> non-paged s390 guests. In addition they may parallelize poorly in
> virtualized environments. This changes the trade off for flushing IOVAs
> such that minimizing the number of IOTLB flushes trumps any benefit of
> cheaper queuing operations or increased paralellism.
>=20
> In this scenario per-CPU flush queues pose several problems. Firstly
> per-CPU memory is often quite limited prohibiting larger queues.
> Secondly collecting IOVAs per-CPU but flushing via a global timeout
> reduces the number of IOVAs flushed for each timeout especially on s390
> where PCI interrupts may not be bound to a specific CPU.
>=20
> Let's introduce a single flush queue mode that reuses the same queue
> logic but only allocates a single global queue. This mode is selected by
> dma-iommu if a newly introduced .shadow_on_flush flag is set in struct
> dev_iommu. As a first user the s390 IOMMU driver sets this flag during
> probe_device. With the unchanged small FQ size and timeouts this setting
> is worse than per-CPU queues but a follow up patch will make the FQ size
> and timeout variable. Together this allows the common IOVA flushing code
> to more closely resemble the global flush behavior used on s390's
> previous internal DMA API implementation.
>=20
> Link: https://lore.kernel.org/all/9a466109-01c5-96b0-bf03-304123f435ee@ar=
m.com/
> Acked-by: Robin Murphy <robin.murphy@arm.com>
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com> #s390
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/iommu/dma-iommu.c  | 168 ++++++++++++++++++++++++++++++++++-----=
------
>  drivers/iommu/s390-iommu.c |   3 +
>  include/linux/iommu.h      |   2 +
>  3 files changed, 134 insertions(+), 39 deletions(-)
>=20
>=20
---8<---
>=20=20
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 182cc4c71e62..c3687e066ed7 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -409,6 +409,7 @@ struct iommu_fault_param {
>   * @priv:	 IOMMU Driver private data
>   * @max_pasids:  number of PASIDs this device can consume
>   * @attach_deferred: the dma domain attachment is deferred
> + * @shadow_on_flush: IOTLB flushes are used to sync shadow tables
>   *
>   * TODO: migrate other per device data pointers under iommu_dev_data, e.=
g.
>   *	struct iommu_group	*iommu_group;
> @@ -422,6 +423,7 @@ struct dev_iommu {
>  	void				*priv;
>  	u32				max_pasids;
>  	u32				attach_deferred:1;
> +	u32				shadow_on_flush:1;

This causes a merge conflict with a48ce36e2786f ("iommu: Prevent
RESV_DIRECT devices from blocking domains"), The resolution is trivial
though in that shadow_on_flush:1 can just be added after (or before)
require_direct:1. @Joro do you want me to sent a version with this
resolution regardless or will you resolve this when applying?

>  };
>=20=20
>  int iommu_device_register(struct iommu_device *iommu,
>=20

