Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223177E0981
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 20:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376582AbjKCTg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 15:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjKCTg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 15:36:57 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E60D5C;
        Fri,  3 Nov 2023 12:36:53 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d9cbba16084so2466370276.1;
        Fri, 03 Nov 2023 12:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699040212; x=1699645012; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=zVTIOqE7WTSx8izaWl21cHuLe1YvhWC1HiEcf3Mu3r0=;
        b=BquxUYFZNrmcNOO0NNyb11TgzREQpBDU8FltTgdCUui12QBIDDq2OWXl9uRRbT+CZb
         5J6/Hq3Lb0e0X40LZStyP+ELa57mSxRu/b+fjV9c9u2bM1bYQdioIMwdw+kpcr69U2hU
         Ax4bRZJNh0N2cY7ixROvS4kxQDW0s0wqsRrUr/dve6wsjKRfNqzOe5TvW+lw+hYSwALS
         H0sdG7YCclWNdS1SWgNAHILuy0TsJ2y3vOB9IecWUEPr2I6t0k1fAcrAGS2fHAA/n4yy
         4lTkX3GMMXxYU1TFWm8hCRVxqZoymNVNvZ63wYk61ZfpInFIJK9tGQiiGSERzVnTS//2
         rwrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699040212; x=1699645012;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zVTIOqE7WTSx8izaWl21cHuLe1YvhWC1HiEcf3Mu3r0=;
        b=VSZuc7VYSECvO0W4WMZlVzqLsVpfT8mM5liMLevyFItdHcZ3mTZz91qH0XkGIugqRH
         P9PxX/ikwpiqUHqlkyozMq+skPJMUUbmdz9wHPbo8St0YaSfRNPY4K3cMFceP8E8avAo
         hM4DammeM92bLqOKYbffa51G7gjeHrRRuxlDTYuf43kKOSV1B6+7y3QgsCjkN6YnHQXt
         /kwVI2P9DpR2S3KHcYzT4gZxe9LQUX1ixrGltOPwibUFWX2SvP0TTwSNUo5HyrFBF0EI
         yfzKVic3Obw4ak/e08TGcEatrkvdof1SWbQ03p2lqJY3ZbEjacYQ+XdkKmdFcVxN/Krr
         uVog==
X-Gm-Message-State: AOJu0YyGdRC0xUaPd+mcSWfWty+hxUXv8c1riULafg3iKt4nQwlHbfC7
        0Ajpoxn3sd6uV6I2Zgr1r74=
X-Google-Smtp-Source: AGHT+IFI68ifhgWXdoC5YyWS3okYu/PGSxm7gZ+s8fTD9H5I/Jzt5tvr5kAgvoREi6IeDSPnQDqp+A==
X-Received: by 2002:a05:6902:18d2:b0:da0:4032:18b6 with SMTP id ck18-20020a05690218d200b00da0403218b6mr26766829ybb.30.1699040212335;
        Fri, 03 Nov 2023 12:36:52 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w142-20020a25c794000000b00da0c49a588asm1193444ybe.8.2023.11.03.12.36.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Nov 2023 12:36:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <dec086cc-7403-4a06-b860-aae6daf8f0e7@roeck-us.net>
Date:   Fri, 3 Nov 2023 12:36:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] hwmon: (hp-wmi-sensors) Fix failure to load on EliteDesk
 800 G6
Content-Language: en-US
To:     James Seo <james@equiv.tech>, Jean Delvare <jdelvare@suse.com>
Cc:     Lukasz Stelmach <l.stelmach@samsung.com>,
        Armin Wolf <W_Armin@gmx.de>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231103181931.677796-1-james@equiv.tech>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20231103181931.677796-1-james@equiv.tech>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/23 11:19, James Seo wrote:
> The EliteDesk 800 G6 stores a raw WMI string within the ACPI object in its
> BIOS corresponding to one instance of HPBIOS_PlatformEvents.Name. This is
> evidently a valid way of representing a WMI data item as far as the Microsoft
> ACPI-WMI mapper is concerned, but is preventing the driver from loading.
> 
> As this seems quite rare, add a machine-limited workaround for now.
> 
> Reported-by: Lukasz Stelmach <l.stelmach@samsung.com>
> Closes: https://lore.kernel.org/linux-hwmon/7850a0bd-60e7-88f8-1d6c-0bb0e3234fdc@roeck-us.net/
> Signed-off-by: James Seo <james@equiv.tech>
> ---
[ ... ]

> +static bool is_raw_wmi_string(const acpi_object_type property_map[], int prop)
> +{
> +	const char *board_name;
> +
> +	if (property_map != hp_wmi_platform_events_property_map ||
> +	    prop != HP_WMI_PLATFORM_EVENTS_PROPERTY_NAME)
> +		return false;
> +
> +	board_name = dmi_get_system_info(DMI_BOARD_NAME);
> +	if (!board_name)
> +		return false;
> +
> +	return !strcmp(board_name, HP_WMI_BOARD_NAME_ELITEDESK_800_G6);

Would it be possible to use a dmi table and dmi_check_system() ?
That would make it easier to add more platforms later on if needed.

Thanks,
Guenter

