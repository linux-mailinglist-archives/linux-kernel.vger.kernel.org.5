Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F95B7C9AE8
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 21:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjJOTGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 15:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjJOTGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 15:06:16 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3F8A9;
        Sun, 15 Oct 2023 12:06:14 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3296b3f03e5so3334421f8f.2;
        Sun, 15 Oct 2023 12:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697396773; x=1698001573; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B9VbccHDwDWP6ln//+3ptokIcB5CKr1YyKD+T3cRcQY=;
        b=VXutTTnHyfFo+D9vyKtfjVdqqGWG1BTQhqMnk6ZhDGl1qqrbXjhwhKdgQuuaOoza/u
         NIVhV3zZCkXdSW1OC4Vw6aH7+pPnxvdi89kgiCWWCK6P43E53xeCfYdNkXD0BzS95dfM
         +FggdveQNtBlKUlfQT65HdsXlyKMBPbTnWfDISu5NeUtR+YgFAFFXEpKdjK/nGzUBK5/
         JPf9Xyv+2S2xgU/dcK2FT74bNRGdvmow6tMGH7ef86TWPrrgi5rJHLTWWXhr6UDdV97k
         +wJ2wztdTJC9mu6YXz/1fXPO0ybddUKiSOS2HWDcHbkm3vmCds7jR1OGbal29+hdbdlX
         rnUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697396773; x=1698001573;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B9VbccHDwDWP6ln//+3ptokIcB5CKr1YyKD+T3cRcQY=;
        b=syNx8PeLvc1bCDd2M0EqJp+FcgWEbIlXwCY2em0ua03sVz9NycQ8HcTj6LEHDEcatN
         kE/Mwm0Y/JEmWh086ACghOV8wrknOr05KNtLjF48i1oh3RUxMXYxnSMXC8+FGnJfEapr
         oS7WwWdb86NtA2Coh2FtG4d7c2ICOoONMRruIqcFc2plOmvDdCA1LK1SS9Pa2oH+e0ow
         VMAu/sbfzeHsnoKuVSpxLMmwwQre2XCwUU4zlc5mgTbKmsYVMghb5Op8fY0N1+NZ3Nd2
         Xbk6/vyO1sGUtFsALdbXQlqB0CDdbLdDmeHLcBAXvvMggZoBl9T91CNIIWf1Y5NB5l/3
         ewJg==
X-Gm-Message-State: AOJu0Yz8BzHKdBRBAHx1KhfBEMB/tUlvC2SyIOoKI5jHB/kBkKH0zWG/
        xVsNaJqhfTsqOpX2h6PTvQY=
X-Google-Smtp-Source: AGHT+IEFwd3n4TVDQTDQIwpJJAC/+Lyu1bfhOuOd3mScnEmvGhMgt5sseD0legYG62vc5gHLhL1ZOA==
X-Received: by 2002:a05:6000:114d:b0:324:8502:6355 with SMTP id d13-20020a056000114d00b0032485026355mr26491973wrx.46.1697396772824;
        Sun, 15 Oct 2023 12:06:12 -0700 (PDT)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id p13-20020a5d68cd000000b0031ae8d86af4sm25535850wrw.103.2023.10.15.12.06.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Oct 2023 12:06:12 -0700 (PDT)
Message-ID: <fad1d01f-0ae4-4d82-afff-64a53dd4767c@gmail.com>
Date:   Sun, 15 Oct 2023 21:06:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/surface: platform_profile: Propagate error if
 profile registration fails
Content-Language: en-US
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
        markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231014235449.288702-1-W_Armin@gmx.de>
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <20231014235449.288702-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/23 01:54, Armin Wolf wrote:
> If platform_profile_register() fails, the driver does not propagate
> the error, but instead probes successfully. This means when the driver
> unbinds, the a warning might be issued by platform_profile_remove().
> 
> Fix this by propagating the error back to the caller of
> surface_platform_profile_probe().
> 
> Compile-tested only.
> 
> Fixes: b78b4982d763 ("platform/surface: Add platform profile driver")
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Thanks! Works fine on my Surface Book 2.

Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>
Tested-by: Maximilian Luz <luzmaximilian@gmail.com>

> ---
>   drivers/platform/surface/surface_platform_profile.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/surface/surface_platform_profile.c b/drivers/platform/surface/surface_platform_profile.c
> index f433a13c3689..a5a3941b3f43 100644
> --- a/drivers/platform/surface/surface_platform_profile.c
> +++ b/drivers/platform/surface/surface_platform_profile.c
> @@ -159,8 +159,7 @@ static int surface_platform_profile_probe(struct ssam_device *sdev)
>   	set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, tpd->handler.choices);
>   	set_bit(PLATFORM_PROFILE_PERFORMANCE, tpd->handler.choices);
> 
> -	platform_profile_register(&tpd->handler);
> -	return 0;
> +	return platform_profile_register(&tpd->handler);
>   }
> 
>   static void surface_platform_profile_remove(struct ssam_device *sdev)
> --
> 2.39.2
> 
