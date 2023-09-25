Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653117ADE52
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 20:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbjIYSCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 14:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjIYSCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 14:02:13 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D9810E
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 11:02:06 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c5ff5f858dso21371245ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 11:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695664926; x=1696269726; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8eSsSBJ8Vq4Qi6ZMfaWUsInrqRpqyqKIrqUaEPasYuI=;
        b=BI5J06qjkQ7ljgnowfX42qKmMVLVqjKY9nFTkGMX+7kt2qyLHxaU8AHwc8CMMbQTHq
         EMkXck8eAHwtyetfitVwakO3E8PSKHpQ/NASXyVOj4TgzGVaeJlfZe1bE7oTHtmX9kCt
         /s5Zl8J292KOITX6AqFJbfYlWR2kjXivcBexo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695664926; x=1696269726;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8eSsSBJ8Vq4Qi6ZMfaWUsInrqRpqyqKIrqUaEPasYuI=;
        b=XWl2foavIE1vuNjbiVu6PUY+ksayEqDMHUjv5E2ujolPx4OJgfiQBtslVPqDNekdT9
         4Lu1xDVTvpVz3kw7vsuNroFcmcg5P8p1uBu/HAECNabklSeHBqiL+aI9pFF3YBgLbKYu
         vEKkCyp5o7TBw9hfgGycgRriInk3Yvdhz4wfxa6vm4sZ/iTwZCQ8ctRpyHiEm/+qt2W7
         Beu7GsWEcWNj/vYTTx6McO8LpFzPP9Eb1J4nQU2jGktNT4+UL6+XPIBHmysAsjoA9yQn
         0xA0HqclQH3FiI24N00fe7uCWaaonaGOi+32UCqnWZGnI5Jwb9M0Hzb5dkEtuyaAtxUs
         T1tQ==
X-Gm-Message-State: AOJu0YwSb9KwXaSKTQBgpktePju9RkuNUf7bVWGO55nZXXvT30r5I5rG
        BW62ZXNHwn0/2uec/UoOLiVYEA==
X-Google-Smtp-Source: AGHT+IHld3ZFV0+XNf/j9xLn/Bc27rzyru1qiqAoZ2oWmrXp9wmOwRx86JiK/FA3B/MoWE1xxRrRCg==
X-Received: by 2002:a17:903:2308:b0:1c6:2acc:62ea with SMTP id d8-20020a170903230800b001c62acc62eamr1069374plh.57.1695664926254;
        Mon, 25 Sep 2023 11:02:06 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a11-20020a170902eccb00b001bb28b9a40dsm9161300plh.11.2023.09.25.11.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 11:02:05 -0700 (PDT)
Date:   Mon, 25 Sep 2023 11:02:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4] hwmon: (acpi_power_meter) replace open-coded
 kmemdup_nul
Message-ID: <202309251101.1544F5F@keescook>
References: <20230925-strncpy-drivers-hwmon-acpi_power_meter-c-v4-1-3bac7534f10f@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925-strncpy-drivers-hwmon-acpi_power_meter-c-v4-1-3bac7534f10f@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 03:43:23AM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> Let's refactor this kcalloc() + strncpy() into a kmemdup_nul() which has
> more obvious behavior and is less error prone.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Changes in v4:
> - drop +1 from length arg (thanks Kees)
> - reword subject line (thanks Kees)
> - rebase onto 6465e260f4879080
> - Link to v3: https://lore.kernel.org/r/20230921-strncpy-drivers-hwmon-acpi_power_meter-c-v3-1-307552c6ec3f@google.com
> 
> Changes in v3:
> - refactor to use kmemdup_nul() (thanks Thomas and Kees)
> - change commit msg to reflect ^
> - rebase onto 2cf0f71562387282
> - Link to v2: https://lore.kernel.org/r/20230919-strncpy-drivers-hwmon-acpi_power_meter-c-v2-1-8348432d6442@google.com
> 
> Changes in v2:
> - use memcpy over strscpy (thanks Kees)
> - Link to v1: https://lore.kernel.org/r/20230914-strncpy-drivers-hwmon-acpi_power_meter-c-v1-1-905297479fe8@google.com
> ---
>  drivers/hwmon/acpi_power_meter.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
> index fa28d447f0df..c13b5c8a0433 100644
> --- a/drivers/hwmon/acpi_power_meter.c
> +++ b/drivers/hwmon/acpi_power_meter.c
> @@ -796,14 +796,13 @@ static int read_capabilities(struct acpi_power_meter_resource *resource)
>  			goto error;
>  		}
>  
> -		*str = kcalloc(element->string.length + 1, sizeof(u8),
> -			       GFP_KERNEL);
> +		*str = kmemdup_nul(element->string.pointer, element->string.length,
> +						 GFP_KERNEL);

This whitespace looks weird -- I'd expect this to line up with
"element", like this:

> +		*str = kmemdup_nul(element->string.pointer, element->string.length,
> +				   GFP_KERNEL);

Otherwise, yes, looks correct.

-- 
Kees Cook
