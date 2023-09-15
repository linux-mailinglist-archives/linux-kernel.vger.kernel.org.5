Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F857A153C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 07:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbjIOFRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 01:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjIOFRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 01:17:37 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C708F2711
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 22:17:32 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-572a7141434so963046eaf.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 22:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694755052; x=1695359852; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NmkmWy8HC0PB4d8aL+vtauicOqu3O/LrjvNIY4PdPFI=;
        b=muXShcMNAoTCIXmobni5kuwx5Ye5EVB5tT5IjVRYHw61A6162M3dyfTvs4Zvy8wL5T
         k8jvzC4OEBuRiOK4dJnxS2HY85hoT8adZgYz7xMA2A9umGV0SDJueZUgNvtKdZFwHhP4
         mo/y4ntORGgfSgFBd/yevG4NsMJovrzGnkT9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694755052; x=1695359852;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NmkmWy8HC0PB4d8aL+vtauicOqu3O/LrjvNIY4PdPFI=;
        b=Y86wz3bcVeavsPn4z6+uSQgBUjVScl5AUir4AhlhZ+/OPD2/Czb21V40YHmUe3jcRr
         mcCVLi03Q0HKE47lKlGi8irTxxXUURdSyhmb+xXuN4zMEU63wHh4fS+IeKAfDe8+VDNG
         yCD+/E5WEYRgsVKEn6BtwOrg3kj6K7SSprpgKStEXEETa2taMnvxrxJjovoqqpTPdJuw
         lMGF8ORkdFCP1uth7BgDDkhkNy5AL7FMZNLBLNW90NJIl06M25g/GfGRoOQ8ek4/DA4Z
         mD01oVkOZjP9woAZKIr93RF0QjEfWCnEz+1V25yZD1BwFCDKZHqTIcneaxgTWpnfBxlx
         6rnA==
X-Gm-Message-State: AOJu0YyUtHeN747DTg5Oqlco+OnrH4yT0zQQQ/+pUAbzWAIqjNr1Tz9O
        iBu03XU99ae2kQfhoI5lHZ4XNQ==
X-Google-Smtp-Source: AGHT+IHQ6xOS9VCUUuWhBFNCjDXjvjiXMsqIFS9PItIDyPYaWniNfFjG2Tdc5Uo9OvriMs0Z0nl3aw==
X-Received: by 2002:a05:6358:1cb:b0:141:10f4:1cbc with SMTP id e11-20020a05635801cb00b0014110f41cbcmr645790rwa.14.1694755052061;
        Thu, 14 Sep 2023 22:17:32 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q7-20020a63ae07000000b005634343cd9esm1977741pgf.44.2023.09.14.22.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 22:17:31 -0700 (PDT)
Date:   Thu, 14 Sep 2023 22:17:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] hwmon: refactor deprecated strncpy
Message-ID: <202309142216.D52AFDF@keescook>
References: <20230914-strncpy-drivers-hwmon-acpi_power_meter-c-v1-1-905297479fe8@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914-strncpy-drivers-hwmon-acpi_power_meter-c-v1-1-905297479fe8@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 10:50:15PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> We should prefer more robust and less ambiguous string interfaces.
> 
> A suitable replacement is `strscpy` [2] due to the fact that it guarantees
> NUL-termination on the destination buffer without unnecessarily NUL-padding.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
>  drivers/hwmon/acpi_power_meter.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
> index fa28d447f0df..9bafe7c85ff7 100644
> --- a/drivers/hwmon/acpi_power_meter.c
> +++ b/drivers/hwmon/acpi_power_meter.c
> @@ -803,7 +803,7 @@ static int read_capabilities(struct acpi_power_meter_resource *resource)
>  			goto error;
>  		}
>  
> -		strncpy(*str, element->string.pointer, element->string.length);
> +		strscpy(*str, element->string.pointer, element->string.length);

This will truncate the destination by 1 training character. This is better
replaced with just memcpy() (all the size information has already been
calculated and %NUL termination space made in the kcalloc() above it.

-Kees

>  		str++;
>  	}
>  
> 
> ---
> base-commit: 3669558bdf354cd352be955ef2764cde6a9bf5ec
> change-id: 20230914-strncpy-drivers-hwmon-acpi_power_meter-c-c9f2d8053bef
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 

-- 
Kees Cook
