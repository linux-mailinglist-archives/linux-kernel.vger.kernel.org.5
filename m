Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C01F47E6140
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 01:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjKIACh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 19:02:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjKIACg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 19:02:36 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9DA2685;
        Wed,  8 Nov 2023 16:02:34 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5b383b4184fso3803107b3.1;
        Wed, 08 Nov 2023 16:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699488153; x=1700092953; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=4S3hUwpEwAhRsIK33hvWrkFRJfd6iKru9dgJJTsDG6o=;
        b=ItFiPvw8bWfimT2ADSZn+NOtiad8oICm1f4A/0F3U8MdzEwszzkFU2b8Uf+77SrHWs
         gwrbm/vzLLzXGpm0wSsKWOpy/zi7e1xgnmTtvMkdGBHTTL9AVYN1AXLbr9AFDCpBjEAr
         gF5K1EXQEYbRpZ5y/hFaLjMVI3XrE2gmznAnwSRkuNZdmEL2g/aUvTUc5sRH4RSYbcgB
         X3tr65gYJl9LAQjdORPvXnq9pPq1XoG9ZL9IuYZH46d1s14UjK4W1UAbS8VP2gzAH+Mb
         W9OE5Dl+5ebSyWZoDVV6QlOumWVioU/vO4a0TPABu/ZKqLJuvEqZMZqTbka2xUjDCFZ+
         QKTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699488153; x=1700092953;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4S3hUwpEwAhRsIK33hvWrkFRJfd6iKru9dgJJTsDG6o=;
        b=u7FrwltY0KoOq8+hzGhCCnq9waHwRR7VR/GFoLqElDHzQGS2clV/zrEuEIcaEWyaZW
         5auHGKbjs34GaKZuz4oBN7rXvwlajZgI+uhUN1OuEE7ZcTCP8nQnjktFLAbm1UdiEFoM
         Q/rXekMnL03OQYZn83GFtOCB7lzEC76tBOn3x1jfDGhIkZgJLM9zkLrCFZ/tnt/GXUCC
         ug6q/FsuiznzjzO0On0PfYrNtRyqzFey2pRgLPc2kSvJKOKNATfLlsxHfClrsnywkRYj
         eVUcVxyBdSJFf5PtCMc/GzOj9UYrj5tIq7pjXWOt23CLbK3O9l+sP/SCkjGPtU6cuME/
         eDrg==
X-Gm-Message-State: AOJu0YxinkLgJs/FtEYOqz9PjkNuBKuV+lZClK1P1Hqp49XvcJLg0cav
        MfmYhAWsVm+2v9Oua23jop0=
X-Google-Smtp-Source: AGHT+IF7M4jKHrAJfyC9vLGEIV3Ibl9BE2YgD0HLpg94t/zgChrpWu+z0Mgw8Ztbp8/W5U9l7G1NZg==
X-Received: by 2002:a81:9185:0:b0:5a5:65e:b847 with SMTP id i127-20020a819185000000b005a5065eb847mr3307746ywg.34.1699488153531;
        Wed, 08 Nov 2023 16:02:33 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q16-20020a819910000000b005a20ab8a184sm7607523ywg.31.2023.11.08.16.02.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Nov 2023 16:02:32 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <44f1eaa3-a90d-42cf-9808-4f39aacbf270@roeck-us.net>
Date:   Wed, 8 Nov 2023 16:02:29 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] hwmon: (core) Add support for humidity min/max
 alarm
Content-Language: en-US
To:     Javier Carrasco <javier.carrasco.cruz@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20231020-topic-chipcap2-v2-0-f5c325966fdb@gmail.com>
 <20231020-topic-chipcap2-v2-2-f5c325966fdb@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20231020-topic-chipcap2-v2-2-f5c325966fdb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/23 07:37, Javier Carrasco wrote:
> Add min_alarm and max_alarm attributes for humidityX to support devices
> that can generate these alarms.
> Such attributes already exist for other magnitudes such as tempX.
> 
> Tested with a ChipCap 2 temperature-humidity sensor.
> 

No objection, but the new attributes also need to be added to the ABI
documentation at
Documentation/ABI/testing/sysfs-class-hwmon and
Documentation/hwmon/sysfs-interface.rst

Which made me notice that humidityX_alarm isn't documented either.
Please document that attribute as well while you are at it.

Thanks,
Guenter

> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>   drivers/hwmon/hwmon.c | 2 ++
>   include/linux/hwmon.h | 4 ++++
>   2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
> index c7dd3f5b2bd5..7f92984c37d9 100644
> --- a/drivers/hwmon/hwmon.c
> +++ b/drivers/hwmon/hwmon.c
> @@ -579,8 +579,10 @@ static const char * const hwmon_humidity_attr_templates[] = {
>   	[hwmon_humidity_input] = "humidity%d_input",
>   	[hwmon_humidity_label] = "humidity%d_label",
>   	[hwmon_humidity_min] = "humidity%d_min",
> +	[hwmon_humidity_min_alarm] = "humidity%d_min_alarm",
>   	[hwmon_humidity_min_hyst] = "humidity%d_min_hyst",
>   	[hwmon_humidity_max] = "humidity%d_max",
> +	[hwmon_humidity_max_alarm] = "humidity%d_max_alarm",
>   	[hwmon_humidity_max_hyst] = "humidity%d_max_hyst",
>   	[hwmon_humidity_alarm] = "humidity%d_alarm",
>   	[hwmon_humidity_fault] = "humidity%d_fault",
> diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
> index 8cd6a6b33593..154de35e34ac 100644
> --- a/include/linux/hwmon.h
> +++ b/include/linux/hwmon.h
> @@ -286,8 +286,10 @@ enum hwmon_humidity_attributes {
>   	hwmon_humidity_input,
>   	hwmon_humidity_label,
>   	hwmon_humidity_min,
> +	hwmon_humidity_min_alarm,
>   	hwmon_humidity_min_hyst,
>   	hwmon_humidity_max,
> +	hwmon_humidity_max_alarm,
>   	hwmon_humidity_max_hyst,
>   	hwmon_humidity_alarm,
>   	hwmon_humidity_fault,
> @@ -299,8 +301,10 @@ enum hwmon_humidity_attributes {
>   #define HWMON_H_INPUT			BIT(hwmon_humidity_input)
>   #define HWMON_H_LABEL			BIT(hwmon_humidity_label)
>   #define HWMON_H_MIN			BIT(hwmon_humidity_min)
> +#define HWMON_H_MIN_ALARM		BIT(hwmon_humidity_min_alarm)
>   #define HWMON_H_MIN_HYST		BIT(hwmon_humidity_min_hyst)
>   #define HWMON_H_MAX			BIT(hwmon_humidity_max)
> +#define HWMON_H_MAX_ALARM		BIT(hwmon_humidity_max_alarm)
>   #define HWMON_H_MAX_HYST		BIT(hwmon_humidity_max_hyst)
>   #define HWMON_H_ALARM			BIT(hwmon_humidity_alarm)
>   #define HWMON_H_FAULT			BIT(hwmon_humidity_fault)
> 

