Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98CF80D464
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 18:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344639AbjLKRs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 12:48:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjLKRs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 12:48:26 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA269B;
        Mon, 11 Dec 2023 09:48:32 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BBAkHhg023669;
        Mon, 11 Dec 2023 17:47:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        qcppdkim1; bh=/WMZ34F2eL1Hcuaudzkn38FW6+BBlfdCLE6M/dsGrQg=; b=AK
        5Hi8Jk9o/bpg5WEoL8MnsX6QAMCY+60gfbO/l2Z0rJ52tx3qEJn6+2zv3dwjKcED
        IexiXv0DX3rA2jfMX6027ezdAgqv9nV6flINyyeiZtXX1mHxSA1+JLao8V+1XvAl
        GsqIGOjkgR9tD+5zaIqpKg+Kf6MswEiqGI1MUTGOvyWQbsqihgDbJsuW0WqzB68+
        8FHxJQkFK09qw3S3XFS6+66gTUVkVrYqHU1y9543gS+OSnjRHl5YuIBocjUihNGs
        7lQ2bUcxwGd5qfnTAJ53IoQ1z3bREWHBanAs2RW+Iqi6zqa7JSrjimF8/K34kOg1
        vkOUJ6qrfzyuKzZreM4w==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uvnv8bxsu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Dec 2023 17:47:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BBHlggc000501
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Dec 2023 17:47:42 GMT
Received: from [10.110.106.103] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 11 Dec
 2023 09:47:41 -0800
Message-ID: <0990dd35-30e5-4903-a243-767f27feb601@quicinc.com>
Date:   Mon, 11 Dec 2023 09:47:40 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] Documentation: kernel-parameters: remove
 noaliencache
Content-Language: en-US
To:     <sxwjean@me.com>, <vbabka@suse.cz>, <42.hyeyoo@gmail.com>,
        <cl@linux.com>, <linux-mm@kvack.org>
CC:     <penberg@kernel.org>, <rientjes@google.com>,
        <iamjoonsoo.kim@lge.com>, <roman.gushchin@linux.dev>,
        <corbet@lwn.net>, <keescook@chromium.org>, <arnd@arndb.de>,
        <akpm@linux-foundation.org>, <gregkh@linuxfoundation.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Xiongwei Song <xiongwei.song@windriver.com>
References: <20231209135203.303508-1-sxwjean@me.com>
 <20231209135203.303508-2-sxwjean@me.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231209135203.303508-2-sxwjean@me.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: cd7YlzBpQmL0P2WgvFSqsZQGBA_QUiKr
X-Proofpoint-GUID: cd7YlzBpQmL0P2WgvFSqsZQGBA_QUiKr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxlogscore=843 suspectscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 mlxscore=0 phishscore=0 clxscore=1011
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312110146
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/2023 5:52 AM, sxwjean@me.com wrote:
> From: Xiongwei Song <xiongwei.song@windriver.com>
> 
> ince slab allocator has already been removed. There is no users of

s/ince/Since/

> the noaliencachei parameter, so let's remove it.

s/noaliencachei/noaliencache/

> 
> Suggested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Xiongwei Song <xiongwei.song@windriver.com>
> ---
> v5: Collect Reviewed-by tag.
> v4: Collect Reviewed-by tag.
> v3: Remove the changes for slab_max_order.
> v2: Add changes for removing "noaliencache".
>     https://lore.kernel.org/linux-mm/20231122143603.85297-1-sxwjean@me.com/
> v1: Remove slab_max_order.
>     https://lore.kernel.org/linux-mm/20231120091214.150502-2-sxwjean@me.com/
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 65731b060e3f..9f94baeb2f82 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3740,10 +3740,6 @@
>  	no5lvl		[X86-64,RISCV] Disable 5-level paging mode. Forces
>  			kernel to use 4-level paging instead.
>  
> -	noaliencache	[MM, NUMA, SLAB] Disables the allocation of alien
> -			caches in the slab allocator.  Saves per-node memory,
> -			but will impact performance.
> -
>  	noalign		[KNL,ARM]
>  
>  	noaltinstr	[S390] Disables alternative instructions patching

