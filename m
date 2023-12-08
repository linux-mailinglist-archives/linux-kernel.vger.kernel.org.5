Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86A480A430
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 14:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235876AbjLHNLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 08:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233428AbjLHNLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 08:11:42 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3ACB1989;
        Fri,  8 Dec 2023 05:11:48 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c9eca5bbaeso24922511fa.3;
        Fri, 08 Dec 2023 05:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702041106; x=1702645906; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:cc:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QQN7wOqaADX2FECQYklXLB5Tqg9UqwVc4LsoIF89I/E=;
        b=LFWVJKeevgHEz8Tf37Ouf5M9Qr9yYZvbUycsffJeXyyjCwJ2fN3t1z7BfFbzHauXP2
         9o4ITcFndrFWoSMcFkl4cRPjXLQohveOB2gWMMog5tWGZ+7Q0kEHwoNiOybFyAsAq/Ks
         auv+q2IKP4CsfMT6cegsaZnzlbq9+qJaVBAiMtZwJnyViaHVXHqGq4UYrw96nAn19ww2
         le2IJBm8YkjNYGisDNTe7dkSId8/2pimKmCBru8gdZVQYH8aM6Z2PQvouMJyv18O5UH0
         UzoW0x7UgeQVC8et6946uVp/qSqKH0ITSf99JZOQUqtxpnXmpGHyH/BNHdrLajGi4yIA
         J8oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702041106; x=1702645906;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:cc:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QQN7wOqaADX2FECQYklXLB5Tqg9UqwVc4LsoIF89I/E=;
        b=VVlX7N9BY/XQKLjMzOJOU/+b5Jyj8I+jlsPv3dUSoCmvoY67dFsyev2gj9yol1akT4
         A0XvQxCKZghjJpdEw00iPawuPj/0AgExtv+Lu1E8tI9Fxxp3/IKQm92FKN9bQVQY15yD
         Cd/TnTlFCKOgnHDSO5U1pZ327WEAB0X2D5wescgjwzSFii1BAZYftjLziT5T3xuSJ1+J
         R4S9b3ayNNhyYwnqLNc/UlKBMHH/7JsZGzsJCsvNHTQO+Lk+swvv2jI27bFC3slgnvGc
         drWxwLIPg00jvW9q0Ckok2yG27wVv8+CQ+9rRBSMtKlqUSwShWh19b3Jq02qwio2luJW
         GFfA==
X-Gm-Message-State: AOJu0YyYoTb/FAoftyB0L5m6Mn+OYvsOFtdycpmG8PvzFW0Js+m81Eas
        cxTdVSTx4p/RsoYMpRVW9SXC02CosvVwHg==
X-Google-Smtp-Source: AGHT+IGGkMAvYab/wZG/Zon/PUKK0rHCXJwWYAyNSleQUMOV/alanT+aFaxQxXW3pOOsIw6UCgKTAg==
X-Received: by 2002:a2e:9887:0:b0:2c9:fa05:6c02 with SMTP id b7-20020a2e9887000000b002c9fa056c02mr1192925ljj.171.1702041106220;
        Fri, 08 Dec 2023 05:11:46 -0800 (PST)
Received: from [192.168.0.28] (cable-178-148-234-71.dynamic.sbb.rs. [178.148.234.71])
        by smtp.gmail.com with ESMTPSA id sk13-20020a170906630d00b00a1d232b39b3sm990819ejc.145.2023.12.08.05.11.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Dec 2023 05:11:45 -0800 (PST)
Message-ID: <d91d4bf1-3e8d-4b63-baa9-479a91d04eb7@gmail.com>
Date:   Fri, 8 Dec 2023 14:11:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     savicaleksa83@gmail.com,
        Wilken Gottwalt <wilken.gottwalt@posteo.net>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (corsair-psu) Fix failure to load when built-in to
 kernel
To:     linux-hwmon@vger.kernel.org
References: <20231208130710.191420-1-savicaleksa83@gmail.com>
Content-Language: en-US
From:   Aleksa Savic <savicaleksa83@gmail.com>
In-Reply-To: <20231208130710.191420-1-savicaleksa83@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-12-08 14:07:10 GMT+01:00, Aleksa Savic wrote:
> When built-in to the kernel, the corsair-psu driver fails to register with
> the following message:
> 
> "Driver 'corsair-psu' was unable to register with bus_type 'hid'
> because the bus was not initialized."
> 
> Fix this by initializing the driver after the HID bus using
> late_initcall(), as hwmon is built before HID.
> 
> Fixes: d115b51e0e56 ("hwmon: add Corsair PSU HID controller driver")
> Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
> ---
>  drivers/hwmon/corsair-psu.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/corsair-psu.c b/drivers/hwmon/corsair-psu.c
> index 904890598c11..48831a528965 100644
> --- a/drivers/hwmon/corsair-psu.c
> +++ b/drivers/hwmon/corsair-psu.c
> @@ -899,7 +899,20 @@ static struct hid_driver corsairpsu_driver = {
>  	.reset_resume	= corsairpsu_resume,
>  #endif
>  };
> -module_hid_driver(corsairpsu_driver);
> +
> +static int __init corsairpsu_hid_init(void)
> +{
> +	return hid_register_driver(&corsairpsu_driver);
> +}
> +
> +static void __exit corsairpsu_hid_exit(void)
> +{
> +	hid_unregister_driver(&corsairpsu_driver);
> +}
> +
> +/* When compiled into the kernel, initialize after the hid bus */
> +late_initcall(corsairpsu_hid_init);
> +module_exit(corsairpsu_hid_exit);
>  
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Wilken Gottwalt <wilken.gottwalt@posteo.net>");


Woops! Just saw that the same fix was sent yesterday. Please disregard, sorry!

Aleksa
