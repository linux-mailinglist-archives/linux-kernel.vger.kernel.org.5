Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5214B7CEEBC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 06:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbjJSEpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 00:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232571AbjJSEpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 00:45:08 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657E1129;
        Wed, 18 Oct 2023 21:45:04 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39J4N061015623;
        Thu, 19 Oct 2023 04:44:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=+ugDTtE0N5pIP+bbxhOpFwqhGnBHp8dix51AVdVNmjI=;
 b=nXh8jcJMjbwNDlgTbyO4nJVcjRiJc/JawzpuRc0IrUlnQUYa743bURCiUPGUdZXKghUe
 sFv6JARIsxdhvzuTvfCmwILcxHvnCTWRQwwFkbFwKAsm1WeFGhhIuvvZaAsIjfexmxT/
 XLKvOloHIsj0h596xV05Yb7j5gqMxfkU3iKnUab5ssaUXl9e1Dz59e8YEesPodfso2ic
 7J48ll5bv1UaRcXGenNxuOi+ChpoLkL/pkloCxTOc34pgT2T6ohwHHo4+YyAjrPI4k7P
 PTRUwjG/lTGhkBhQBaf57GTmtfRWBX6NzqxWONInX9Rtr3xAson5hsNvxDg7X8yaj0nr xw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tth2f1pm9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 04:44:42 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39J4ifLU003377
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 04:44:41 GMT
Received: from [10.216.19.246] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 18 Oct
 2023 21:44:33 -0700
Message-ID: <423c28cc-e6b0-4e82-8f38-3f4fe22076c2@quicinc.com>
Date:   Thu, 19 Oct 2023 10:14:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] dma-buf: heaps: Add MediaTek secure heap
Content-Language: en-US
To:     Yong Wu <yong.wu@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        <christian.koenig@amd.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <jstultz@google.com>, <tjmercier@google.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <jianjiao.zeng@mediatek.com>,
        <kuohong.wang@mediatek.com>
References: <20230911023038.30649-1-yong.wu@mediatek.com>
From:   Vijayanand Jitta <quic_vjitta@quicinc.com>
In-Reply-To: <20230911023038.30649-1-yong.wu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Lc4B_SAVgouSoZ-DK34n-SzwIOaz_pQs
X-Proofpoint-GUID: Lc4B_SAVgouSoZ-DK34n-SzwIOaz_pQs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_02,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 mlxlogscore=943 spamscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 clxscore=1011
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310190039
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/11/2023 8:00 AM, Yong Wu wrote:
> This patchset consists of two parts, the first is from John and TJ.
> It adds some heap interfaces, then our kernel users could allocate buffer
> from special heap. The second part is adding MTK secure heap for SVP
> (Secure Video Path). A total of two heaps are added, one is mtk_svp and
> the other is mtk_svp_cma. The mtk_svp buffer is reserved for the secure
> world after bootup and it is used for ES/working buffer, while the
> mtk_svp_cma buffer is dynamically reserved for the secure world and will
> be get ready when we start playing secure videos, this heap is used for the
> frame buffer. Once the security video playing is complete, the CMA will be
> released.
> 
> For easier viewing, I've split the new heap file into several patches.
> 
> The consumers of new heap and new interfaces are our codec and drm which
> will send upstream soon, probably this week.
> 
> Base on v6.6-rc1.
> 
> John Stultz (2):
>   dma-heap: Add proper kref handling on dma-buf heaps
>   dma-heap: Provide accessors so that in-kernel drivers can allocate
>     dmabufs from specific heaps
> 
> T.J. Mercier (1):
>   dma-buf: heaps: Deduplicate docs and adopt common format
> 
> Yong Wu (6):
>   dma-buf: heaps: Initialise MediaTek secure heap
>   dma-buf: heaps: mtk_sec_heap: Initialise tee session
>   dma-buf: heaps: mtk_sec_heap: Add tee service call for buffer
>     allocating/freeing
>   dma-buf: heaps: mtk_sec_heap: Add dma_ops
>   dt-bindings: reserved-memory: MediaTek: Add reserved memory for SVP
>   dma_buf: heaps: mtk_sec_heap: Add a new CMA heap
> 
>  .../mediatek,secure_cma_chunkmem.yaml         |  42 ++
>  drivers/dma-buf/dma-heap.c                    | 127 +++--
>  drivers/dma-buf/heaps/Kconfig                 |   8 +
>  drivers/dma-buf/heaps/Makefile                |   1 +
>  drivers/dma-buf/heaps/mtk_secure_heap.c       | 458 ++++++++++++++++++
>  include/linux/dma-heap.h                      |  42 +-
>  6 files changed, 630 insertions(+), 48 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/reserved-memory/mediatek,secure_cma_chunkmem.yaml
>  create mode 100644 drivers/dma-buf/heaps/mtk_secure_heap.c
> 

Thanks for this patch series.

In Qualcomm as well we have similar usecases which need secure heap. We are working on
posting them upstream, would share more details on usecases soon.

Have few comments on the current implementation.

1) I see most the implementation here is mtk specific, even file names ,heap names etc.
   But secure heap is a common requirement, can we keep naming as well generic may be secure_heap ?

2) secure heap has two parts, one is allocation and other one is securing the memory.
   Have few comments on making these interfaces generic, would post those on corresponding 
   patches.

Thanks,
Vijay
   

