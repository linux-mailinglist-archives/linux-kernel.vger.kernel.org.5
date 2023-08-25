Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9726788EA6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 20:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjHYSZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 14:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbjHYSY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 14:24:59 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385DCE67;
        Fri, 25 Aug 2023 11:24:57 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37PI8p3R030752;
        Fri, 25 Aug 2023 18:24:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=OtWo1IYxQ+yQcq0/+c4rIFn6MsGnI6m13i+nhycPBX4=;
 b=WD322mVrSBH+SbaXK8+7enbsVvbKw7dwRRohE0rtUoOkvoNAKbF0ntrKC0q873vERWx0
 sz5ij/xNlHyf2mBGxvkpTuWjF7N3T4J+nCKXbbYwSYLssut+p9UtZ7wzdlXpnpzYOOt0
 M6tA+/mvzuLdmi87p/GlODS5hwNKh5hi7uMGLFK+qDSAov+TmvmQtYv4/ejQcx4o9hCf
 cSm6j6KztJLRpgTrLRNQpSHLe+P0v0FdpnxRyNOwVOrSI6JHm0ZHexv7/A9uXjWHg7Hg
 N81EFs4rBxkPtXY8xqnhRecOwj3OXAwup7orw8tNSqv1OqN4yQIra490xwzrGr5ddACe cQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sq0qg93sf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Aug 2023 18:24:07 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37PI9SN0032633;
        Fri, 25 Aug 2023 18:24:06 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sq0qg93rx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Aug 2023 18:24:06 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37PHhkO9010391;
        Fri, 25 Aug 2023 18:24:05 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sn21t9ndx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Aug 2023 18:24:05 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37PIO48k65995188
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 18:24:04 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 56ADD5804B;
        Fri, 25 Aug 2023 18:24:04 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BAD0B5805B;
        Fri, 25 Aug 2023 18:23:59 +0000 (GMT)
Received: from [9.61.160.138] (unknown [9.61.160.138])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 25 Aug 2023 18:23:59 +0000 (GMT)
Message-ID: <8872cb91-2a9d-c145-614b-bcd45895d769@linux.ibm.com>
Date:   Fri, 25 Aug 2023 14:23:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v12 4/6] iommu/s390: Disable deferred flush for ISM
 devices
Content-Language: en-US
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
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
References: <20230825-dma_iommu-v12-0-4134455994a7@linux.ibm.com>
 <20230825-dma_iommu-v12-4-4134455994a7@linux.ibm.com>
From:   Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20230825-dma_iommu-v12-4-4134455994a7@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ferobBmEP6qSEiNVam69qatVrVPksXtv
X-Proofpoint-GUID: p2X-CeuZ6DxfiqnLDGhiGEluJb7HjK0L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_16,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 adultscore=0 spamscore=0 clxscore=1011 mlxlogscore=999
 bulkscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308250162
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/25/23 6:11 AM, Niklas Schnelle wrote:
> ISM devices are virtual PCI devices used for cross-LPAR communication.
> Unlike real PCI devices ISM devices do not use the hardware IOMMU but
> inspects IOMMU translation tables directly on IOTLB flush (s390 RPCIT
> instruction).
> 
> ISM devices keep their DMA allocations static and only very rarely DMA
> unmap at all. For each IOTLB flush that occurs after unmap the ISM
> devices will however inspect the area of the IOVA space indicated by the
> flush. This means that for the global IOTLB flushes used by the flush
> queue mechanism the entire IOVA space would be inspected. In principle
> this would be fine, albeit potentially unnecessarily slow, it turns out
> however that ISM devices are sensitive to seeing IOVA addresses that are
> currently in use in the IOVA range being flushed. Seeing such in-use
> IOVA addresses will cause the ISM device to enter an error state and
> become unusable.
> 
> Fix this by claiming IOMMU_CAP_DEFERRED_FLUSH only for non-ISM devices.
> This makes sure IOTLB flushes only cover IOVAs that have been unmapped
> and also restricts the range of the IOTLB flush potentially reducing
> latency spikes.
> 
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

> ---
>  drivers/iommu/s390-iommu.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
> index f6d6c60e5634..8310180a102c 100644
> --- a/drivers/iommu/s390-iommu.c
> +++ b/drivers/iommu/s390-iommu.c
> @@ -315,11 +315,13 @@ static struct s390_domain *to_s390_domain(struct iommu_domain *dom)
>  
>  static bool s390_iommu_capable(struct device *dev, enum iommu_cap cap)
>  {
> +	struct zpci_dev *zdev = to_zpci_dev(dev);
> +
>  	switch (cap) {
>  	case IOMMU_CAP_CACHE_COHERENCY:
>  		return true;
>  	case IOMMU_CAP_DEFERRED_FLUSH:
> -		return true;
> +		return zdev->pft != PCI_FUNC_TYPE_ISM;
>  	default:
>  		return false;
>  	}
> 

