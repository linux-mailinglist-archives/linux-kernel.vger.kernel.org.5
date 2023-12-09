Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB2380B792
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 00:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjLIXZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 18:25:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjLIXZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 18:25:15 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3E0123;
        Sat,  9 Dec 2023 15:25:21 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6d9f7b3de20so981245a34.2;
        Sat, 09 Dec 2023 15:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702164321; x=1702769121; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=FJKX/IhvX5i6ssR0lDIL/p7k2gPRLBjechmn2E2C/Ys=;
        b=FePIhVRcQizNTapsJ6RHIQasR2kwXBxNlVG0JU6s+qRVVrn+PUXrhz0lwJ30qGISoo
         BmwPA6XewMnsVFboyxzLTsfBvkBdoxoBIx9/ynTak1DqyBASUnz+jD1Ce7wkvnQNozA0
         B1oxwEtqrRkaH+f4qjUj8MizDy4f8rntdwrg/Ia06/3pB9aSgsw+EUuCwLTQQ5CR8oi7
         3GnH4TcWkS9KbZBjh7ZDfH+MD9GPfccS2NKKJlDXTOiDgb1j+e/yB4u1gx2UVUDblFjr
         ll3GcKnrD7uEbFP/P+fPlHGqRXGSH3Ct+svsfuEbw3I0lu3umuXuJHH+L/fNHKbOO4BH
         TOZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702164321; x=1702769121;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FJKX/IhvX5i6ssR0lDIL/p7k2gPRLBjechmn2E2C/Ys=;
        b=jlycDfykNkds3WIj899PPlSiJOFVUxV0u/noBzkf/Jy1ln79Q5WeyfyS5dU3eZUwVC
         i7bpJxklTOSamPQN49ybcyIV9t3aomHTY54aftrvkaepEdQXcYFbsbC5dr/wz1JVerlU
         MRW3HNUA3HLgDD9FL+o0Ti0fiSIYBoZcZO6m1fxCOTRi1yw7tkP7XiluM+TTuyTDCtB9
         8/wO7JaY2QMK+2YoXBPCvkxrqqpQNTyxmy5aI4VhCTOo1qMP/aISngvUEDeFt92bzGFY
         kLGklxb3G6kDaCT9RHsOEutZmHonbwnAybqqrzQ5edexPtruSGquf6roSXQsYjkw9QdK
         ImVw==
X-Gm-Message-State: AOJu0Yyj1QfYYn55qq+QeDWgbxS6lv+Q04/DU5dnJeekGmXWYjgczdrh
        cYwffzexWHDKUW5qaJ7f7hCZgidiHYo=
X-Google-Smtp-Source: AGHT+IH8uUR9H3V5xw4WHncTthZ4sDKF0a/KF3+XI6egvvBsGaGjhtzyU7NyZpBEymrObh2YoFnlOQ==
X-Received: by 2002:a9d:685a:0:b0:6d9:ebb5:6b0e with SMTP id c26-20020a9d685a000000b006d9ebb56b0emr2830805oto.13.1702164321085;
        Sat, 09 Dec 2023 15:25:21 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o8-20020a9d6d08000000b006d8017dcda9sm960209otp.75.2023.12.09.15.25.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Dec 2023 15:25:20 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <1c35ac10-2768-4d9b-aad8-091ea17ee92d@roeck-us.net>
Date:   Sat, 9 Dec 2023 15:25:18 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Added support for Zen 3 based AMD Threadrippers (5000WX
 series). They were previously under Zen3 SP models, but this was incorrect.
Content-Language: en-US
To:     bindkeys@gmail.com, Clemens Ladisch <clemens@ladisch.de>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231209231545.1272806-1-bindkeys@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20231209231545.1272806-1-bindkeys@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/23 15:15, bindkeys@gmail.com wrote:
> From: Jami Kurki <bindkeys@gmail.com>
> 
> Signed-off-by: Jami Kurki <bindkeys@gmail.com>

This is not an appropriate patch subject and description.

Please follow Documentation/process/submitting-patches.rst,
"The canonical patch format".

Thanks,
Guenter

> ---
>   drivers/hwmon/k10temp.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
> index bae0becfa24b..b5738dd8d442 100644
> --- a/drivers/hwmon/k10temp.c
> +++ b/drivers/hwmon/k10temp.c
> @@ -454,7 +454,8 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   		data->is_zen = true;
>   
>   		switch (boot_cpu_data.x86_model) {
> -		case 0x0 ... 0x1:	/* Zen3 SP3/TR */
> +		case 0x0 ... 0x1:	/* Zen3 SP3 */
> +		case 0x8:		/* Zen3 TR */
>   		case 0x21:		/* Zen3 Ryzen Desktop */
>   		case 0x50 ... 0x5f:	/* Green Sardine */
>   			data->ccd_offset = 0x154;

