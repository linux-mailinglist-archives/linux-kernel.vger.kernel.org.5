Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2807F6898
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 22:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjKWVFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 16:05:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKWVFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 16:05:31 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA1C91
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 13:05:37 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-548034455d9so304900a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 13:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700773536; x=1701378336; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rw4Kok7jUVVa6uXmeOLPYM7OZwu0CQxt+Y+R1sPjnuc=;
        b=JBA/GjjHHaBvaOdTp0NYiF1I/mnpByicEXxy+Alu3Gjrm7W9tv5WkuufhznMQwstRG
         wBoL+uphSwLaC8+yztyyNPkt+nUytbmHs5QQv0/c8nWfJ8GFrSm9+UYTWpIxBAsa9afR
         3GceCgfwiy0PG5jLjbK7ksgaYFv77mLKB8xAn7y2/gU3TllKpPBXRLePFP1jK+A+hURC
         z38pzU655A2hy3qHq2wBzq3Drwl9IXzykDTRIiq7BqSsVecvyBGGPR0FLbyBtPy5A/AI
         +Ahn3RWnolrwRQuPpmiAj8wioDklSL9Vj1ww97D0zWsOKgHl2RSSoowyp1PTNJ8Cdlg8
         iqAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700773536; x=1701378336;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rw4Kok7jUVVa6uXmeOLPYM7OZwu0CQxt+Y+R1sPjnuc=;
        b=EbxAsdWJ3O0H8XiXhBwjCYduoFqNsR1WI18brAXjfIt8ituDgnJhJrqTtGUNSWlyUz
         KhCqVu5Frl8kKbyDKRjMr+mVJEixNpAsj5vOgbRYBJQ/nj6UHT67kA00egAfafY8IsTP
         0mVyUI08A8jxiLA1WOVAv0uwK/EHJ0o5J30hbSy0exkpbPBhWOmPrR1dRt6NOcN4Bbb0
         T4E6PdPDbMbRoPSV4hBryBTDYjYYEwO/MGxfuULgDhV/XaWGI7XK4G0iEk6GHkfNTrVR
         H6FKxAjvNm0U3fvlCgs/umoyjsIDusFVgWgawj+xcnjdlnW8FdIfGEnMKWeO4yAJNX7x
         pmfA==
X-Gm-Message-State: AOJu0YwldgToBj3MI8yi4HENdd06vtYS2P611ysSXKR0S0U6QqfwF61W
        AD3lYklGEV0VXuGPzxNCbIc=
X-Google-Smtp-Source: AGHT+IFTjWJCNmIm2tUQW+6hyPYaSjLQg37gElGwWHj+v1lMNJ2DsJfdbEpF4w7K9GOagah3vYvN7A==
X-Received: by 2002:a50:ec96:0:b0:543:6222:e37c with SMTP id e22-20020a50ec96000000b005436222e37cmr328621edr.0.1700773535794;
        Thu, 23 Nov 2023 13:05:35 -0800 (PST)
Received: from [192.168.0.104] (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id c13-20020aa7df0d000000b0054386466f56sm1011724edy.60.2023.11.23.13.05.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Nov 2023 13:05:35 -0800 (PST)
Message-ID: <4df855f1-77e9-44a2-a024-aa5c7d661642@gmail.com>
Date:   Thu, 23 Nov 2023 22:05:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] staging: rtl8192e: renamed variable
 HTIOTActIsMgntUseCCK6M
Content-Language: en-US
To:     Gary Rookard <garyrookard@fastmail.org>, gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20231123144337.13112-1-garyrookard@fastmail.org>
 <20231123144337.13112-6-garyrookard@fastmail.org>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20231123144337.13112-6-garyrookard@fastmail.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/23 15:43, Gary Rookard wrote:
> Renamed from Pascal/CamelCase to Snake case the variable
> HTIOTActIsMgntUseCCK6M.
> HTIOTActIsMgntUseCCK6M -> ht_iot_act_is_mgnt_use_cck_6m
> 
> Linux kernel coding style (cleanup), checkpatch Avoid CamelCase.
> Driver/module rtl8192e compiles.
> 
> Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
> ---
> v3: Corrected versioning fron v1 -> v3, includes change history.
> v2: v2 was Skipped over..v3 corrects this.
> v1: Style and compile issues, asked to redo.
> 
>   drivers/staging/rtl8192e/rtl819x_HTProc.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
> index 0873c19ca051..f43249fd78d7 100644
> --- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
> +++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
> @@ -207,7 +207,7 @@ static void ht_iot_peer_determine(struct rtllib_device *ieee)
>   	netdev_dbg(ieee->dev, "IOTPEER: %x\n", ht_info->IOTPeer);
>   }
>   
> -static u8 HTIOTActIsMgntUseCCK6M(struct rtllib_device *ieee,
> +static u8 ht_iot_act_is_mgnt_use_cck_6m(struct rtllib_device *ieee,
>   				 struct rtllib_network *network)

CHECK: Alignment should match open parenthesis
#33: FILE: drivers/staging/rtl8192e/rtl819x_HTProc.c:211:
+static u8 ht_iot_act_is_mgnt_use_cck_6m(struct rtllib_device *ieee,
  				 struct rtllib_network *network)

Please use checkpatch on your patches. Alignment issues can be fixed up 
by you. CamelCase oft not when the variable did not change within your 
patch.

>   {
>   	u8	retValue = 0;
> @@ -675,7 +675,7 @@ void HTResetSelfAndSavePeerSetting(struct rtllib_device *ieee,
>   		ht_iot_peer_determine(ieee);
>   
>   		ht_info->iot_action = 0;
> -		bIOTAction = HTIOTActIsMgntUseCCK6M(ieee, pNetwork);
> +		bIOTAction = ht_iot_act_is_mgnt_use_cck_6m(ieee, pNetwork);
>   		if (bIOTAction)
>   			ht_info->iot_action |= HT_IOT_ACT_MGNT_USE_CCK_6M;
>   		bIOTAction = HTIOTActIsCCDFsync(ieee);

