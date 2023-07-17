Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73617568AC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 18:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbjGQQD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 12:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjGQQDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 12:03:55 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE31E3;
        Mon, 17 Jul 2023 09:03:54 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36H6x9v0013727;
        Mon, 17 Jul 2023 16:03:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=/Ubjqz+647wg37y8LsyDkdlWOz7DaYqCOqREBCpdNjY=;
 b=kyevH8LsfqmT18hzfI7MiiXNSOO20l0u8c+Xd6HHWFhgJEY4XA/fLxqnn3T41WU8A3CU
 gFUl3u9gATEaQyJxtYrmZTPaYvZ6OCutdl5F5NK2OMhEdzuGYCz5uG7fK+q0zArEnd5w
 NJTGUAfXECSH4mUDfnE4Z+60TzxqB2AOrIr4Dx7bYcj3xuwDAC5uIF+x4PCKlqzVe0us
 Pg2UztBfV4fW/qVg8M6sB17QvcQC+54fzn0sVj9c58mWDnyyeuQcJofOzHk1gDQs+oJe
 o/Icvo3OtL92tkUs4Tf1GpNmsWIF+htUvGLnM70vodhhlZeWisAsgSZs1rSsVYG/kQTA MQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3run0auy91-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 16:03:42 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36HG3fhY009161
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 16:03:41 GMT
Received: from [10.48.240.159] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 17 Jul
 2023 09:03:41 -0700
Message-ID: <e3977212-41f3-f4c3-faf9-febf0b0667d9@quicinc.com>
Date:   Mon, 17 Jul 2023 09:03:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] wifi: rtw89: debug: fix error code in
Content-Language: en-US
To:     Zhang Shurong <zhang_shurong@foxmail.com>, <pkshih@realtek.com>,
        <Markus.Elfring@web.de>, <kuba@kernel.org>
CC:     <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <tencent_1BEE491CDD88D78E6D0583D57B7C2844A00A@qq.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <tencent_1BEE491CDD88D78E6D0583D57B7C2844A00A@qq.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4gNcLI_OGMFEBBiGyhsrOYSdhs-CKzc4
X-Proofpoint-ORIG-GUID: 4gNcLI_OGMFEBBiGyhsrOYSdhs-CKzc4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_12,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxlogscore=802 bulkscore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1011 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307170147
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/15/2023 5:51 AM, Zhang Shurong wrote:
> If there is a failure during kstrtobool_from_user()
> rtw89_debug_priv_btc_manual_set should return negative error code
> instead of returning the count driectly.

nit: s/driectly/directly/

> 
> Fix this bug with the following changes:
> - Return an error code instead of a count after a failed call
> of the function "kstrtobool_from_user".
> - Omit the label "out" with this source code correction.
> 
> Fixes: e3ec7017f6a2 ("rtw89: add Realtek 802.11ax driver")
> Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
> ---
> Changes in v2:
> - Corrected the format of this patch
> - Used variable ret instead of goto out
> Changes in v3:
> - Improved change description
> 
>   drivers/net/wireless/realtek/rtw89/debug.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
> index a4bbac916e22..ce5a9ac08145 100644
> --- a/drivers/net/wireless/realtek/rtw89/debug.c
> +++ b/drivers/net/wireless/realtek/rtw89/debug.c
> @@ -3193,12 +3193,14 @@ static ssize_t rtw89_debug_priv_btc_manual_set(struct file *filp,
>   	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
>   	struct rtw89_btc *btc = &rtwdev->btc;
>   	bool btc_manual;
> +	int ret;
>   
> -	if (kstrtobool_from_user(user_buf, count, &btc_manual))
> -		goto out;
> +	ret = kstrtobool_from_user(user_buf, count, &btc_manual);
> +	if (ret)
> +		return ret;
>   
>   	btc->ctrl.manual = btc_manual;
> -out:
> +
>   	return count;
>   }
>   

