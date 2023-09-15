Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5C77A2848
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 22:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236621AbjIOUjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 16:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237540AbjIOUjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:39:39 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB346170E;
        Fri, 15 Sep 2023 13:39:33 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38FEJ1t3024585;
        Fri, 15 Sep 2023 20:38:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=cUJUg7Dvcc0uo1bVuElb2MqCHjygzkZYsy45Az74LTg=;
 b=nLIiJ8X6RpRe37cPCbSzIg5DQPz7hj0Bpc1LJMIWsoVN5gsy3Ke9wSBCZS5lQ40xJCWn
 pzz+TeQsxs0EldY6AFygKuupPH63SZbBgL+tFpRy7pfCsXvSvqi0RhCK6imHjhU+voG1
 RXA/s8l6Qtt0QpwOlV4MAUIltwc/wILoQeh8S1c0u+fR0lhjtSVVZNnClKlBFJ62wXtP
 AqHg2Pax+GXqfzqIIlEefAxKotbIMaXt5rGrDytJNPmo82FceLjMVhntUtqghK+zAUy3
 yXAQtUH1gyBl3clZn5Hy7Cc4CNjBtQnAo+CeJimrGwUYOhkfeyaOV3boFw4rY00x+zfy Rw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t4g3na43e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 20:38:55 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38FKcs6n015194
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 20:38:54 GMT
Received: from [10.111.183.186] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 15 Sep
 2023 13:38:53 -0700
Message-ID: <ccaf9c7e-7628-4e70-a054-246b4edfbeff@quicinc.com>
Date:   Fri, 15 Sep 2023 13:38:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath10k: Annotate struct ath10k_ce_ring with
 __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, Kalle Valo <kvalo@kernel.org>
CC:     <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, <linux-kernel@vger.kernel.org>,
        <llvm@lists.linux.dev>, <linux-hardening@vger.kernel.org>
References: <20230915200636.never.762-kees@kernel.org>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230915200636.never.762-kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _uNb7NU9OXe3-rG86dkEMYBsSkzJYTJh
X-Proofpoint-ORIG-GUID: _uNb7NU9OXe3-rG86dkEMYBsSkzJYTJh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_17,2023-09-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1011 mlxscore=0 mlxlogscore=912
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309150183
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/2023 1:06 PM, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct ath10k_ce_ring.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Kalle Valo <kvalo@kernel.org>
> Cc: Jeff Johnson <quic_jjohnson@quicinc.com>
> Cc: ath10k@lists.infradead.org
> Cc: linux-wireless@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

> ---
>   drivers/net/wireless/ath/ath10k/ce.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/ce.h b/drivers/net/wireless/ath/ath10k/ce.h
> index 666ce384a1d8..27367bd64e95 100644
> --- a/drivers/net/wireless/ath/ath10k/ce.h
> +++ b/drivers/net/wireless/ath/ath10k/ce.h
> @@ -110,7 +110,7 @@ struct ath10k_ce_ring {
>   	struct ce_desc_64 *shadow_base;
>   
>   	/* keep last */
> -	void *per_transfer_context[];
> +	void *per_transfer_context[] __counted_by(nentries);
>   };
>   
>   struct ath10k_ce_pipe {

