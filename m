Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97DA17761DD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 15:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbjHIN6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 09:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232875AbjHIN6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 09:58:08 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD03A8
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 06:58:07 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 379DntfB003373;
        Wed, 9 Aug 2023 13:57:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=IBxLksRWQJNJ/J9zVQ4Q+Q6sPIraZpg7ZIon6o0L2Fs=;
 b=FApWEXJ2l8Pv+kLcvoFg/daTaPe66t2zLBicp4H8VtWyGPJN7xlCE3DASSkcRu8K1sTz
 rn8uHro/cLfUcwdKX3Ighj3JiEoCM9WmygZMZhPSq0yhvgWFAxoerArW0Uzoasv3bnPZ
 1TJ2ZussVk3pTRzca7m13lNxpG6Ch0iHYXIfhzXIQeBD+u+kqV6SaV4CjrymH4ox5jS9
 miEwVwWZ3H97PqIet7/sPwM7D4ljjKcQCB+hkhjHWYEvsFpylF0o26HvXmoPy3R46JZJ
 eb94Ea3YQJIXS6CIrjM6l6zERAl8BU7Pfz9bk3Aitzm8FrrfeT0WMmnY1leLM5bNHlWn 7g== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sbmrqjya4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 13:57:59 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 379DvwcK022879
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 9 Aug 2023 13:57:58 GMT
Received: from [10.214.227.50] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 9 Aug
 2023 06:57:56 -0700
Message-ID: <653dd444-cb47-49ac-b20c-25e256025410@quicinc.com>
Date:   Wed, 9 Aug 2023 19:27:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cma: introduce CMA_ALLOC_DEBUG config
Content-Language: en-US
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_charante@quicinc.com>
References: <20230809131640.18791-1-quic_bibekkum@quicinc.com>
From:   Bibek Kumar Patro <quic_bibekkum@quicinc.com>
In-Reply-To: <20230809131640.18791-1-quic_bibekkum@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: uyRoJB3vwoBhm_pDPqH1pz6JHFslOI25
X-Proofpoint-ORIG-GUID: uyRoJB3vwoBhm_pDPqH1pz6JHFslOI25
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-09_10,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 adultscore=0 mlxscore=0 suspectscore=0 phishscore=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308090123
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2 was added by mistake. It's first submission of the patch. Please 
ignore the v2.

regards,
Bibek

On 8/9/2023 6:46 PM, Bibek Kumar Patro wrote:
> Currently enabling CONFIG_CMA_DEBUG enables DEBUG preprocessor macro.
> If DEBUG is defined, it's equivalent to a printk with KERN_DEBUG loglevel
> flooding the dmesg buffer with pr_debug prints from mm/cma driver and from
> included files as well. This results in excessive amount of CMA logging and
> also might distract the debug teams with unrelated KERN_DEBUG prints.One of
> the ways engineers currently tackle this problem is by passing loglevel=N
> though commandline to suppress KERN_DEBUG messages. This approach can
> sometimes become tiresome due to its repetitive nature.
> This patch proposes an alternative approach by introducing a simple new
> config CONFIG_CMA_ALLOC_DEBUG which only shows the cma bit allocation
> status in case of cma failure and do not enable DEBUG preprocessor macro
> from CONFIG_CMA_DEBUG avoiding excessive CMA logging from pr_debug.
> Engineers and tech teams seeking only for bitmap status in case of cma
> failure can use this simple config instead of worrying about changing
> the loglevel or trying other similar workarounds.
> 
> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> ---
>   mm/Kconfig | 11 +++++++++++
>   mm/cma.c   |  2 +-
>   2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 09130434e30d..ad2a20576a65 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -891,12 +891,23 @@ config CMA
>   config CMA_DEBUG
>   	bool "CMA debug messages (DEVELOPMENT)"
>   	depends on DEBUG_KERNEL && CMA
> +	select CMA_ALLOC_DEBUG
>   	help
>   	  Turns on debug messages in CMA.  This produces KERN_DEBUG
>   	  messages for every CMA call as well as various messages while
>   	  processing calls such as dma_alloc_from_contiguous().
>   	  This option does not affect warning and error messages.
> 
> +config CMA_ALLOC_DEBUG
> +	bool "CMA bitmap status upon failure"
> +	depends on CMA
> +	help
> +	  Turns on bitmap dump in case of cma failures. This prints
> +	  current status of CMA bit upon failures and will appear
> +	  when cma_alloc() return no_warn argument as false and won't
> +	  flood the dmesg buffer with unrelated KERN_DEBUG prints. No
> +	  need to explicitly enable this if CMA_DEBUG is enabled.
> +
>   config CMA_DEBUGFS
>   	bool "CMA debugfs interface"
>   	depends on CMA && DEBUG_FS
> diff --git a/mm/cma.c b/mm/cma.c
> index a4cfe995e11e..0ead392769b3 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -383,7 +383,7 @@ int __init cma_declare_contiguous_nid(phys_addr_t base,
>   	return ret;
>   }
> 
> -#ifdef CONFIG_CMA_DEBUG
> +#ifdef CONFIG_CMA_ALLOC_DEBUG
>   static void cma_debug_show_areas(struct cma *cma)
>   {
>   	unsigned long next_zero_bit, next_set_bit, nr_zero;
> --
> 2.17.1
> 
