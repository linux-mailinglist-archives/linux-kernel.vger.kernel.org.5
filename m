Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1B37D2192
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 08:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjJVGdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 02:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJVGda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 02:33:30 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C05E9
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 23:33:27 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5221bd8f62eso753282a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 23:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697956406; x=1698561206; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EKJUErbxOXHZPj/kx1d122d7DJQ0FfNFwOU0fGvvDNc=;
        b=I8VLv65UylYHu3N/fNOX8Hm6WuSq4j/X7dBSXb8nFvBXry5dklZPmgcpVSP/Q9BOcv
         NwVJu6IcbyQwc1yotYrD3A7fDV/O8IXHTxDPoL59FzO2G28OSx8v9G5c7dT63PWfp7B1
         nul8MiHs5DFUtJXkpTJZUoEhYs3Kq66jruGcAZLsk47ADg0sgFxZjG1QTWkjjBWEU41r
         7e77Y1UmcBzW6FrzpM173nBB78g2by9Y3/5WNGY1CsqiziQzxWfC7ysTfSTJl/k8nIsK
         jVjwLSiP7FBVZzXrq2u5xxnW1Vcri8u6SlbiqqgTVJ5bE4VDbcmXwKC1plAfPOTjnoki
         NxaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697956406; x=1698561206;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EKJUErbxOXHZPj/kx1d122d7DJQ0FfNFwOU0fGvvDNc=;
        b=G11kQ63fucZfwZTDixkuXmGnyljdYZdeP9ABPVgdve8Cox5EXnaxfMv1n/doi9iexZ
         EbAXiEsakzlx/GHeQqjLvnvHeuiZjWDdkyHVTK+3rEMSHjvhkMzZTGYLY3LalnPVcfFH
         3zfJRwZuvgimsOhPYozqhJa4lGClTIt92o4fnF6dJz45phnMG00d40X2oFfQl6yzJvpI
         QBI9I0/RdfFIh+yvdtAOy7jWfTYImllpOBfl05945nbHGgPoF8q0NATkXZFZ+H1sIDmk
         axR/cWnJqW28WspHRApCYH/WnOVnIrsOuFeVVvPtg/PCyn7Yxo+ccyYm5P+ncHIomAI5
         Hy+w==
X-Gm-Message-State: AOJu0YyVM2rDQZShkQdjKljfLC88upFJoORRFx63HZfsXi9d1KboQqsv
        op4L/3hFG0ypPd05hf8VWaakft+yloQ=
X-Google-Smtp-Source: AGHT+IHlp2xaWSq/I0HNXUr0JY8YObAOXsztk/HulJIAXpNgXiXcR3AR9nNhKA6nJdjaaB08yK+66Q==
X-Received: by 2002:aa7:c78f:0:b0:53f:e6a9:5b2a with SMTP id n15-20020aa7c78f000000b0053fe6a95b2amr3158992eds.2.1697956405758;
        Sat, 21 Oct 2023 23:33:25 -0700 (PDT)
Received: from [192.168.0.104] (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id i7-20020a50fc07000000b00534e791296bsm4378227edr.37.2023.10.21.23.33.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Oct 2023 23:33:25 -0700 (PDT)
Message-ID: <1cf90dc0-7b7e-4639-b71c-a2a1f7fba11f@gmail.com>
Date:   Sun, 22 Oct 2023 08:33:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: rtl8192e: renamed varaible
 HTIOTActIsDisableMCS15
To:     Gary Rookard <garyrookard@fastmail.org>, gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20231021235305.10741-1-garyrookard@fastmail.org>
Content-Language: en-US
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20231021235305.10741-1-garyrookard@fastmail.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/23 01:53, Gary Rookard wrote:
> Renamed from Pascal/CamelCase to Snake case the variable
> HTIOCActIsDisableMCS15, HTIOTActIsDisableMCS15 -> ht_ioc_act_disable_mcs15.
> 
> Linux kernel coding style (cleanup), checkpatch Avoid CamelCase
> Driver rtl8192e compiles.
> 
> Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
> ---
>   drivers/staging/rtl8192e/rtl819x_HTProc.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
> index 5dca97b07874..8868672131a1 100644
> --- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
> +++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
> @@ -212,7 +212,7 @@ static u8 ht_iot_act_is_disable_mcs14(struct rtllib_device *ieee, u8 *PeerMacAdd
>   	return 0;
>   }
>   
> -static bool HTIOTActIsDisableMCS15(struct rtllib_device *ieee)
> +static bool ht_iot_act_is_disable_mcs15(struct rtllib_device *ieee)
>   {
>   	return false;
>   }
> @@ -700,7 +700,7 @@ void HTResetSelfAndSavePeerSetting(struct rtllib_device *ieee,
>   		if (bIOTAction)
>   			ht_info->iot_action |= HT_IOT_ACT_DISABLE_MCS14;
>   
> -		bIOTAction = HTIOTActIsDisableMCS15(ieee);
> +		bIOTAction = ht_iot_act_is_disable_mcs15(ieee);
>   		if (bIOTAction)
>   			ht_info->iot_action |= HT_IOT_ACT_DISABLE_MCS15;
>   

Hi,

please use checkpatch on your patches.

WARNING: 'varaible' may be misspelled - perhaps 'variable'?
#4:
Subject: [PATCH] staging: rtl8192e: renamed varaible HTIOTActIsDisableMCS15
                                             ^^^^^^^^

Bye Philipp
