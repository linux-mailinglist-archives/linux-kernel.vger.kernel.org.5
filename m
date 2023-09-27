Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6AC47B0D65
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 22:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjI0U0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 16:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjI0U0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 16:26:41 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B652192;
        Wed, 27 Sep 2023 13:26:30 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38RK7P9a011293;
        Wed, 27 Sep 2023 20:25:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=h1PUEk2RydOs9qTeLOD9LBjXv0RxbTCx5if1FEQd2bE=;
 b=RfXXU1JWrIeRv8ozX9Nmw67Z1W7jRB9mJo1eN0ftEUuAHQuojUYqRBuXzIY3lVQuGKyg
 /W5JqgRgMZ8r/M8AdJMPYPtSMRm2XVCBGhZdt7Y5As/swP5rvJRyqJgiDsjJsI7PzEsO
 GGodzzlbkV3IVibkOnlCWthSwaELR+cp7ta2UwtpYigPe6aIcHkGKKYfy+Bwdp5G7Odx
 EqgCD6hIdpv4+FJL32LayNsv51lMWBF4FAuqlmFDxyTH4Ve3NFkt6iqegtSBFfFlCIvA
 yshwaYtjbxuT4k0L33Rbwyjh2QESzZEFcfcDTEFot1JhRFICVL0bzfBFqWUaj/X5nQYp BQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tcu0pggq8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 20:25:37 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38RKPa4x007459;
        Wed, 27 Sep 2023 20:25:36 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tcu0pggpp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 20:25:36 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38RJvBAB030466;
        Wed, 27 Sep 2023 20:25:35 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tad21wtv5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 20:25:34 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38RKPX1B66781646
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Sep 2023 20:25:33 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AEE2058055;
        Wed, 27 Sep 2023 20:25:33 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 284835804B;
        Wed, 27 Sep 2023 20:25:29 +0000 (GMT)
Received: from [9.61.175.8] (unknown [9.61.175.8])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 27 Sep 2023 20:25:29 +0000 (GMT)
Message-ID: <a3d8cd82-91ac-0d46-d7d2-c444062a199c@linux.ibm.com>
Date:   Wed, 27 Sep 2023 16:25:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v12 0/6] iommu/dma: s390 DMA API conversion and optimized
 IOTLB flushing
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
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
References: <20230825-dma_iommu-v12-0-4134455994a7@linux.ibm.com>
 <ZRLy_AaJiXxZ2AfK@8bytes.org> <20230926160832.GM13795@ziepe.ca>
 <cfc9e9128ed5571d2e36421e347301057662a09e.camel@linux.ibm.com>
 <ZRP8CiBui7suB5D6@8bytes.org>
 <b06a14de270a63050b0d027c24b333dba25001a4.camel@linux.ibm.com>
 <e1efbbd827e34800bd7fb0ea687645cc6c65e1ab.camel@linux.ibm.com>
 <6dab29f58ac1ccd58caaee031f98f4d0d382cbcd.camel@linux.ibm.com>
 <a672b6b122c7a5f708614346885c190a6960aaea.camel@linux.ibm.com>
 <20230927154009.GN13795@ziepe.ca>
From:   Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20230927154009.GN13795@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MZTnsmsGUITwt1HRAwGX6vmSx-ob7yF1
X-Proofpoint-ORIG-GUID: Wu1NKWtULkpe9Fba-31Ww5rbudahWoCV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_12,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1011
 spamscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309270171
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/23 11:40 AM, Jason Gunthorpe wrote:
> On Wed, Sep 27, 2023 at 05:24:20PM +0200, Niklas Schnelle wrote:
> 
>> Ok, another update. On trying it out again this problem actually also
>> occurs when applying this v12 on top of v6.6-rc3 too. Also I guess
>> unlike my prior thinking it probably doesn't occur with
>> iommu.forcedac=1 since that still allows IOVAs below 4 GiB and we might
>> be the only ones who don't support those. From my point of view this
>> sounds like a mlx5_core issue they really should call
>> dma_set_mask_and_coherent() before their first call to
>> dma_alloc_coherent() not after. So I guess I'll send a v13 of this
>> series rebased on iommu/core and with an additional mlx5 patch and then
>> let's hope we can get that merged in a way that doesn't leave us with
>> broken ConnectX VFs for too long.
> 
> Yes, OK. It definitely sounds wrong that mlx5 is doing dma allocations before
> setting it's dma_set_mask_and_coherent(). Please link to this thread
> and we can get Leon or Saeed to ack it for Joerg.
> 

Hi Niklas,

I bisected the start of this issue to the following commit (only noticeable on s390 when you apply this subject series on top):

06cd555f73caec515a14d42ef052221fa2587ff9 ("net/mlx5: split mlx5_cmd_init() to probe and reload routines")

Which went in during the merge window.  Please include with your fix and/or report to the mlx5 maintainers.  Looks like the changes in this patch match what you and Jason describe; it splits up mlx5_cmd_init() and moves part of the call earlier.  The net result is we first call mlx5_mdev_init>mlx5_cmd_init->alloc_cmd_page->dma_alloc_coherent and then sometime later call mlx5_pci_init->set_dma_caps->dma_set_mask_and_coherent. 

Prior to this patch, we would not drive mlx5_cmd_init (and thus that first dma_alloc_coherent) until mlx5_init_one which happens _after_ mlx5_pci_init->set_dma_caps->dma_set_mask_and_coherent.

Thanks,
Matt

