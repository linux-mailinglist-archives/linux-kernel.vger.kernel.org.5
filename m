Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F16A7AC676
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 05:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjIXDSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 23:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjIXDSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 23:18:37 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6592136
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 20:18:30 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3ab29af398aso2962912b6e.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 20:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695525510; x=1696130310; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/AAy6PIqi8JA3SHRERLqm80k0JlOd55TNJFXlfS2oUI=;
        b=cQRKnkvKqAcSOxrzVTzpuX1OW1olQi4qtyFfDQJ2NOkgjZz5mZtiS8AjbSeNtQpAnH
         ns30oW41LWWtF9+TkxVPbaggze7+De9BppNUgKVAJ4e3R1C5VT2T/eMcCl/D//M5V2pr
         hOzOOBl0nq4GXkTBkk8FS4TDctBsrJ3nvEM7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695525510; x=1696130310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/AAy6PIqi8JA3SHRERLqm80k0JlOd55TNJFXlfS2oUI=;
        b=iIYUgFCTdrWkT5DtIjRXHdCYtseWunD/5viRm2wxaTehh8HSMbWjeEtIHCt4si8HeP
         vMmbTzrMHMYaOoc5jUnwiZn+ohmbJovQ9JZoOLBWRcavkWvN93wpolu7hf4RWjNhXq/5
         kpU7F3LGh1m4Mx9WTTEY57eslSDAdbZ7AQTzpvd0vMyl/UpqtkzF+ktgkLpfzwVHGtUz
         5XMYL9aynvCZRBHCQHxs0BDzE7GlGBZuJm09cRhcrVV8Pj7zyu4DT7TA9o/H8Ldt6AQd
         dhrVc3TuXpLB4L3ELUpZbxARF0NLvLj9SdfOnl4sfb7JqLb8mnej3oFBuAuxnVSjjY04
         0RDA==
X-Gm-Message-State: AOJu0YwWYG3LunOiGtAP1ifADKAS2wvX4+ZOAQUJXrVNK+Bkh35I4Ovy
        SassynlF6LgU0y3oP6KFs7plew==
X-Google-Smtp-Source: AGHT+IHxl8ow6piO8ZdhDMa7DDNx9sc75pSwTQukBg+zX/9NFg883HTo7pR+R2tuQSXm/f8dneJfjA==
X-Received: by 2002:a05:6808:bd0:b0:3a4:633:44d2 with SMTP id o16-20020a0568080bd000b003a4063344d2mr6364418oik.18.1695525510212;
        Sat, 23 Sep 2023 20:18:30 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f9-20020a170902ce8900b001b86492d724sm6053970plg.223.2023.09.23.20.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 20:18:29 -0700 (PDT)
Date:   Sat, 23 Sep 2023 20:18:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] hwmon: refactor deprecated strncpy
Message-ID: <202309232016.6D6E70983B@keescook>
References: <20230921-strncpy-drivers-hwmon-acpi_power_meter-c-v3-1-307552c6ec3f@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921-strncpy-drivers-hwmon-acpi_power_meter-c-v3-1-307552c6ec3f@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 05:41:46AM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> Let's refactor this kcalloc() + strncpy() into a kmemdup_nul() which has
> more obvious behavior and is less error prone.
> 
> To avoid truncating the last byte supply `...length + 1` to
> kmemdup_nul() as `element->string.length` does not account for the
> trailing null as made obvious from it's definition (and associated
> comment):
> |       u32 length;	/* # of bytes in string, excluding trailing null */
> 
> ... this is precisely what the original kcalloc invocation did as well.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
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
> index fa28d447f0df..146c4f09c897 100644
> --- a/drivers/hwmon/acpi_power_meter.c
> +++ b/drivers/hwmon/acpi_power_meter.c
> @@ -796,14 +796,13 @@ static int read_capabilities(struct acpi_power_meter_resource *resource)
>  			goto error;
>  		}
>  
> -		*str = kcalloc(element->string.length + 1, sizeof(u8),
> -			       GFP_KERNEL);
> +		*str = kmemdup_nul(element->string.pointer, element->string.length + 1,
> +						 GFP_KERNEL);

kmemdup_nul() already adds the "+ 1", so it's not needed here.

For v4, please improve the Subject along the lines of "...: Replace
open-coded kmemdup_nul"

-Kees

>  		if (!*str) {
>  			res = -ENOMEM;
>  			goto error;
>  		}
>  
> -		strncpy(*str, element->string.pointer, element->string.length);
>  		str++;
>  	}
>  
> 
> ---
> base-commit: 2cf0f715623872823a72e451243bbf555d10d032
> change-id: 20230914-strncpy-drivers-hwmon-acpi_power_meter-c-c9f2d8053bef
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 

-- 
Kees Cook
