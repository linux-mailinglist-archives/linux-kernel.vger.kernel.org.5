Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1094A7CD016
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 00:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234793AbjJQWwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 18:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJQWwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 18:52:07 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828EDC6;
        Tue, 17 Oct 2023 15:52:05 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39HLmVON002294;
        Tue, 17 Oct 2023 22:52:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=q9KRRRFXAQnEA4UviYcvdtUt2o4h6YZ/UCm4wZOGuzw=;
 b=e4Y2EOcWDAv8EDEOUOa2o0/OfO7pxUcPr13eSghkk2lq4YFw+TVIRMQUROlgLOAUUXPI
 T7LDsSs1OrwDoTYOb1VZHWqDyEF2dYnFYb8pbqdiTWft0/C9surDHRr94Sxi1Bycl+Xj
 ZfaJk9CUawdZIVEykAOD9oU+0bni+0er9IPr+fdNt/ruJKBhlb4ZKiw5EScaT0Z0p9/O
 uUyPzhdykXhNYzQAV47TIz7b/xl/TpwwGdTBeWHcfYcMSjX7zVoEWBqd4KDiZShDG0c7
 zcRFaSmlcVpnjjQ7vWJ6bsqgjWUiP/Xfp+lBqFw0C/2vzywy3tQFCdoFUaQNhD1MR4Qo jg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tsv0v160j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 22:52:00 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39HMq0Mh019625
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 22:52:00 GMT
Received: from [10.111.183.229] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Tue, 17 Oct
 2023 15:51:59 -0700
Message-ID: <84ae63d1-671a-48b3-836b-7a12da54aa10@quicinc.com>
Date:   Tue, 17 Oct 2023 15:51:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] airo: replace deprecated strncpy with strscpy_pad
Content-Language: en-US
To:     Justin Stitt <justinstitt@google.com>,
        Kalle Valo <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>
References: <20231017-strncpy-drivers-net-wireless-cisco-airo-c-v1-1-e34d5b3b7e37@google.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231017-strncpy-drivers-net-wireless-cisco-airo-c-v1-1-e34d5b3b7e37@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: e7YafDeEjwbUi7N0jETZVROMWxZnKvpM
X-Proofpoint-GUID: e7YafDeEjwbUi7N0jETZVROMWxZnKvpM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-17_06,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 malwarescore=0 phishscore=0 mlxscore=0 mlxlogscore=999
 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310170193
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/2023 2:12 PM, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> `extra` is clearly supposed to be NUL-terminated which is evident by the
> manual NUL-byte assignment as well as its immediate usage with strlen().
> 
> Moreover, let's NUL-pad since there is deliberate effort (48 instances)
> made elsewhere to zero-out buffers in these getters and setters:
> 6050 | memset(local->config.nodeName, 0, sizeof(local->config.nodeName));
> 6130 | memset(local->config.rates, 0, 8);
> 6139 | memset(local->config.rates, 0, 8);
> 6414 | memset(key.key, 0, MAX_KEY_SIZE);
> 6497 | memset(extra, 0, 16);
> (to be clear, strncpy also NUL-padded -- we are matching that behavior)
> 
> Considering the above, a suitable replacement is `strscpy_pad` due to
> the fact that it guarantees both NUL-termination and NUL-padding on the
> destination buffer.
> 
> Technically, we can now copy one less byte into `extra` as we cannot
> determine the sizeof `extra` at compile time and the hard-coded value of
> 16 means that strscpy_pad() will automatically truncate and set the byte
> at offset 15 to NUL. However, the current code manually sets a
> NUL-byte at offset 16. If this is an issue, the solution is to change
> the hard-coded magic number to 17 instead of 16. I didn't do this in
> this patch because a hard-coded 17 seems bad (even more so than 16).

this function is a wext handler. In wext-core.c we have:
static const struct iw_ioctl_description standard_ioctl[] = {
...
	[IW_IOCTL_IDX(SIOCGIWNICKN)] = {
		.header_type	= IW_HEADER_TYPE_POINT,
		.token_size	= 1,
		.max_tokens	= IW_ESSID_MAX_SIZE,
	},

So the buffer size is (strangely) IW_ESSID_MAX_SIZE if you want to use 
that for the buffer size

> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> 
> Found with: $ rg "strncpy\("
> ---
>   drivers/net/wireless/cisco/airo.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/cisco/airo.c b/drivers/net/wireless/cisco/airo.c
> index dbd13f7aa3e6..8cfb1de5933e 100644
> --- a/drivers/net/wireless/cisco/airo.c
> +++ b/drivers/net/wireless/cisco/airo.c
> @@ -6067,8 +6067,7 @@ static int airo_get_nick(struct net_device *dev,
>   	struct airo_info *local = dev->ml_priv;
>   
>   	readConfigRid(local, 1);
> -	strncpy(extra, local->config.nodeName, 16);
> -	extra[16] = '\0';
> +	strscpy_pad(extra, local->config.nodeName, 16);
>   	dwrq->length = strlen(extra);
>   
>   	return 0;
> 
> ---
> base-commit: 58720809f52779dc0f08e53e54b014209d13eebb
> change-id: 20231017-strncpy-drivers-net-wireless-cisco-airo-c-d09cd0500a6e
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 

