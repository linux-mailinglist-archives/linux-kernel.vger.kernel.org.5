Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F0B7B32EF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 14:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbjI2M5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 08:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbjI2M5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 08:57:45 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA30C0;
        Fri, 29 Sep 2023 05:57:42 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38TCoxb4013374;
        Fri, 29 Sep 2023 12:56:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=QqTTLT9aZkvqLOeMtXOrEvkTt7kMlZSB0+m85iN5u54=;
 b=Och/FWQTgIJwiibkwBGlGRsTVsD/QPfi3WiMg33KXn9WnrnZXGt5r+QaO1ZlNYrQVdaT
 SZTg6yVNXrNvYQDLdurQLzmMP2ZUuqXfqunhs3fQc1zO+9g4+1R27YxA2v0kwNuWERkD
 WTd2iHpODkJjr93yC2xadbFRuQzK/52kK31ggGBQBMR4pGsSaR8NRPQAcvKXrLRVR73N
 r6hVD9QLzsnJyCku33qAZGQMTzQ2kSOVN3XZ+IOLK4P5kZQ+4weW/cW+CJRkWAg4CiiG
 UuuoRmBc+zdjtC7mjHIFQT2LI/KnUWrFjsVqlAwjF+6hltohqQ7NC/+8hYNGgOawKtgY 7w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tdxxnr3pm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 12:56:38 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38TCpPrI014220;
        Fri, 29 Sep 2023 12:56:37 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tdxxnr3p0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 12:56:37 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38TCZGqp008250;
        Fri, 29 Sep 2023 12:56:36 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tabbnvpnx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 12:56:36 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38TCuZgC5243498
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 12:56:35 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4648A5804B;
        Fri, 29 Sep 2023 12:56:35 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E78BB58063;
        Fri, 29 Sep 2023 12:56:30 +0000 (GMT)
Received: from [9.61.175.8] (unknown [9.61.175.8])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 29 Sep 2023 12:56:30 +0000 (GMT)
Message-ID: <2513a9d4-ac92-2e50-4861-bb65465cf1ae@linux.ibm.com>
Date:   Fri, 29 Sep 2023 08:56:30 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v13 4/6] iommu/s390: Disable deferred flush for ISM
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
References: <20230928-dma_iommu-v13-0-9e5fc4dacc36@linux.ibm.com>
 <20230928-dma_iommu-v13-4-9e5fc4dacc36@linux.ibm.com>
From:   Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20230928-dma_iommu-v13-4-9e5fc4dacc36@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uTzj7zKg3b0sQ930cOsKCPRxfgqwTFsD
X-Proofpoint-GUID: XNXEAeo9ExEttPSRC78HhL_bg28OSuTv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_10,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=999 clxscore=1015 suspectscore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309290107
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/23 10:31 AM, Niklas Schnelle wrote:
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

Looks like my review tag from v12 got dropped on accident -- no changes since prior version and still looks good to me so

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
