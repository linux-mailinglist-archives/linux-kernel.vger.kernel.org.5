Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEE9778F37
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 14:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236210AbjHKMUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 08:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbjHKMUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 08:20:38 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F1D2D5B;
        Fri, 11 Aug 2023 05:20:26 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-3492c49c649so6573305ab.3;
        Fri, 11 Aug 2023 05:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691756426; x=1692361226;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=x0F8MyZgKmrxC30NzYBMK7jS58cwODqoqE9WYpVxgGs=;
        b=WuqUO3tLXXBMBp/NkmwPRYtiBS6WdU0uYUfp5IyXcZNlqBFyiiyiubH3tqqfOGkitO
         9PtxUV3lp0fF6ZqGVh5jnlZfUji7ELVU77HnczXeU6LrjkjvSuihONFpLeakqIDapydS
         rU7l0+g/3XE5NiKyaF1pzNBbti0a1kYTRZ6jetxNkdFFTskKc0S4bEEjIe2GD6FnQvLF
         L7mbI2Gu7Y0nKC2IU4PvljV5+1vCI2d0K8lf23tKzjkFYPyh1OroMDtAen948pIAxoMB
         hbZS6ugOfTRDP4FSKtkpSg4/KEGAZAm83FYQNe27fWf3mJjKwrUa6eOjZ/5w+0Mn7lLl
         J2Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691756426; x=1692361226;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x0F8MyZgKmrxC30NzYBMK7jS58cwODqoqE9WYpVxgGs=;
        b=PlkK84NECxFZky19jU2ag5XB/Hsb8iq9pjnRAXwQHIsjYg0ykHVK6IX4FfLhfaFp+V
         aGJcSJ+5GHDDpSqsFqI9TPMreuPwFyStTnoCzHo0bAn7cHH1LZIebtt6zOkG+n25FC8D
         0v7xT/d3thipdJyzLwgiJjmIjeZroSd+9mIaDGZVyCbZdHSBz0nLG9vVaMuX8BisdsG+
         bDEdRJWDScuAhF3K7HjsElrCge53ZeZ7G3KBCX4m5Ia67tcNde8AJa6O9XfAI2Liv4hC
         LU1Hsv3abj7hFcZQksDHam1U9tCjI+k0sjbPJREhoVXSjbFXfCxOKeR46ArnDRk/AQWk
         u0+w==
X-Gm-Message-State: AOJu0YyWwBSG+HLblnR/tHRDeAmagO2embzGNiaPbgddqSl3H8dFu8GO
        deFIUt8XKGY0Je8xbsBlhKM=
X-Google-Smtp-Source: AGHT+IEVUDVMgJQown+w1I0KKunVY5CYM2NbbPCe76Af7tAvE7Cl7Ntaouzlg5sWaCbj0q9Z/4+9Ug==
X-Received: by 2002:a05:6e02:1907:b0:349:849d:bdf7 with SMTP id w7-20020a056e02190700b00349849dbdf7mr2366982ilu.17.1691756425913;
        Fri, 11 Aug 2023 05:20:25 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b23-20020a02a597000000b0042b1cd4c096sm989699jam.74.2023.08.11.05.20.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 05:20:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a1974520-8341-cca1-866c-c24777b3ae0a@roeck-us.net>
Date:   Fri, 11 Aug 2023 05:20:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1] watchdog: intel-mid_wdt: add MODULE_ALIAS() to allow
 auto-load
Content-Language: en-US
To:     Raag Jadav <raag.jadav@intel.com>, wim@linux-watchdog.org,
        mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com
References: <20230811120220.31578-1-raag.jadav@intel.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230811120220.31578-1-raag.jadav@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/23 05:02, Raag Jadav wrote:
> When built with CONFIG_INTEL_MID_WATCHDOG=m, currently the driver
> needs to be loaded manually, for the lack of module alias.
> This causes unintended resets in cases where watchdog timer is
> set-up by bootloader and the driver is not explicitly loaded.
> Add MODULE_ALIAS() to load the driver automatically at boot and
> avoid this issue.
> 
> Fixes: 87a1ef8058d9 ("watchdog: add Intel MID watchdog driver support")
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/intel-mid_wdt.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/watchdog/intel-mid_wdt.c b/drivers/watchdog/intel-mid_wdt.c
> index 9b2173f765c8..fb7fae750181 100644
> --- a/drivers/watchdog/intel-mid_wdt.c
> +++ b/drivers/watchdog/intel-mid_wdt.c
> @@ -203,3 +203,4 @@ module_platform_driver(mid_wdt_driver);
>   MODULE_AUTHOR("David Cohen <david.a.cohen@linux.intel.com>");
>   MODULE_DESCRIPTION("Watchdog Driver for Intel MID platform");
>   MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:intel_mid_wdt");

