Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858517D29DD
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 08:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjJWGBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 02:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjJWGBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 02:01:39 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA251A4
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 23:01:37 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c509d5ab43so44388301fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 23:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1698040895; x=1698645695; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cv15uiequPHsJVyJI0xD5cCNL07pE6hRG7EicxlA4k0=;
        b=R5xDm01FD9QSos3gHqebQXThOj1mPnLHh/eXlW6Y3nGgDKbn0G/0AZmHhpwRiXePc2
         iPMItRLDKnc52TgYnpxFf95nhMBJiyw4OAWVG48CRGipZJJ8m5rQwZSwsXN8nfuQOpnD
         Viwv96b5qbxzDHy1nq8aMQxUwpwks/OQtGCGolL6x7Ub9EQAYxdorAlyqNP40IMYsS2x
         C2Q1yLLOjkWq0hp+dXoWYzYsS41K8ZJaB2cOmjFTjCfARE5RR9Z+gZBGGaHh1e1pnf94
         vfk28SshOPqzPOrzwPmgiPbiCR9MsMic7F5vvutAb682r8gLP47ENWacQLfzsKboGoFr
         UyOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698040895; x=1698645695;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cv15uiequPHsJVyJI0xD5cCNL07pE6hRG7EicxlA4k0=;
        b=d+1ltuUysj/gPJPDxb/tlBA4rXKm0MxmNJz/pjQ2hlHfstbaigrX648CgXQQkHHhFB
         VnNKOGIsYhscNEwTdBIFJwlBiLtFACyvyFTmF/Q45Q84M9reEOblviUEHr44uB+1/cl5
         0YOmYUyfSerSAr6goALAQby7zVqg1ZxK14EZlMvzOppx0rbol//6mfabhdFSU6fxIGD4
         h31OonnCFAzfRi8iUERibSRIrVemQVO485W5X8UYjSa9aspCWq0bFScZKtD3YOywwh/p
         kPD34PTWPbAKtLQ3tqngs0yz7UGNBJSnwl92Ci06LqQHte7M4iEzljcw7mnHs5hJeffP
         xUkg==
X-Gm-Message-State: AOJu0Yxkpq9V72e4+2diNbubNQfjkUJb5nMYEWf5SBGzlSZPit998oI2
        Gp7eY138BoAEPJB0Saa40CKCAA==
X-Google-Smtp-Source: AGHT+IGHa9J1rPVU8hu7HbkN6kHUmjQ9nnE1zY2dlrgozWaCnppa5ElcmSikE39peedaSHXC2Nvphg==
X-Received: by 2002:a2e:b8c7:0:b0:2c5:968:6daf with SMTP id s7-20020a2eb8c7000000b002c509686dafmr6677819ljp.39.1698040895278;
        Sun, 22 Oct 2023 23:01:35 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.185])
        by smtp.gmail.com with ESMTPSA id u13-20020a05600c19cd00b004068e09a70bsm8579309wmq.31.2023.10.22.23.01.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Oct 2023 23:01:34 -0700 (PDT)
Message-ID: <635cea61-861b-4af3-a4ee-ed048456e200@tuxon.dev>
Date:   Mon, 23 Oct 2023 09:01:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: at91: pm: set soc_pm.data.mode in
 at91_pm_secure_init()
Content-Language: en-US
To:     thomas.perrot@bootlin.com, Russell King <linux@armlinux.org.uk>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clement.leger@bootlin.com
References: <20231020130219.1255937-1-thomas.perrot@bootlin.com>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20231020130219.1255937-1-thomas.perrot@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Thomas,

On 20.10.2023 16:02, thomas.perrot@bootlin.com wrote:
> From: Thomas Perrot <thomas.perrot@bootlin.com>
> 
> In non secure mode, soc_pm.data.mode is set when entering pm in
> at91_pm_begin(). This value is used (not only) to determine if the system
> is going into slow clock mode (at91_suspend_entering_slow_clock()). This
> function is called from various drivers to check this and act accordingly.
> If not set, the driver might enter an incorrect suspend mode. When using
> secure suspend mode, at91_pm_begin() is not called and thus
> soc_pm.data.mode is not set. Since when using secure suspend, only one
> suspend mode is supported, set this value directly in
> at91_pm_secure_init().
> 
> Signed-off-by: Clément Léger <clement.leger@bootlin.com>
> Signed-off-by: Thomas Perrot <thomas.perrot@bootlin.com>
> ---
>  arch/arm/mach-at91/pm.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
> index 1a26af0fabc7..345b91dc6627 100644
> --- a/arch/arm/mach-at91/pm.c
> +++ b/arch/arm/mach-at91/pm.c
> @@ -1103,6 +1103,7 @@ static void __init at91_pm_secure_init(void)
>  	if (res.a0 == 0) {
>  		pr_info("AT91: Secure PM: suspend mode set to %s\n",
>  			pm_modes[suspend_mode].pattern);
> +		soc_pm.data.mode = suspend_mode;
>  		return;
>  	}
>  
> @@ -1112,6 +1113,7 @@ static void __init at91_pm_secure_init(void)
>  	res = sam_smccc_call(SAMA5_SMC_SIP_GET_SUSPEND_MODE, 0, 0);
>  	if (res.a0 == 0) {
>  		pr_warn("AT91: Secure PM: failed to get default mode\n");
> +		soc_pm.data.mode = -1;

As this variable's type is unsigned int setting it -1 will make
at91_suspend_entering_slow_clock() return true all the time. Is this what
you intend?

Thank you,
Claudiu Beznea

>  		return;
>  	}
>  
> @@ -1119,6 +1121,7 @@ static void __init at91_pm_secure_init(void)
>  		pm_modes[suspend_mode].pattern);
>  
>  	soc_pm.data.suspend_mode = res.a1;
> +	soc_pm.data.mode = soc_pm.data.suspend_mode;
>  }
>  static const struct of_device_id atmel_shdwc_ids[] = {
>  	{ .compatible = "atmel,sama5d2-shdwc" },
