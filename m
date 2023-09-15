Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817867A143F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 05:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbjIODQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 23:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbjIODQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 23:16:12 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E17270C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 20:16:08 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-273527a8fdeso1366604a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 20:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694747768; x=1695352568; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zz4gnGjUeyTU905nH03PjK4abgfoxmT9GtwT2LwE9Bk=;
        b=nwtYs6B8Lehcg/KuB5fkXYQdgibjlERAEtvq7c4TIkXfGesk3OofzPh5s47EA0rkjA
         jYxO8kWVGjlLpZodCAMqIxH7IdljeOm/xD6kSyRaRKsSisymq8SmU9dSRsGWsny0q4ea
         d0ShXjA2aIzOUXoRc2/rk8k4bh4l1vrRQlYVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694747768; x=1695352568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zz4gnGjUeyTU905nH03PjK4abgfoxmT9GtwT2LwE9Bk=;
        b=dWkm4dR+27ZNQqmTBbIEE/JOW2IlMNHHofGYuB9gWV8noEf3Gg1k+yLRAxG8HKILwn
         Ccu/AFpglCePAwpxsDiM/b/0Ukupc1ZNQU1RoaLu29wVeJnLqES6UN+lyZrCUmcQYXbU
         F8Mtv27YdlSV6sk7ISb0umB15uP0bhyLKI6sHsYmsVMFwu2mxXLcfcgB4j7d2flF1OEE
         zK/ozT49Pr5vqvpldriSy5UuR0+cpje51o2i6NbobaUTd/ViuDAwDnKArL2KMKWzPRJQ
         6yK1zFikOqVKB7cUPyAfijWhW8zCYtLZganGDDVtEzXDNM4QSpW+xag+6FZiVe6RJ9Du
         Ohag==
X-Gm-Message-State: AOJu0Yw31VXfQu+RXkfF0Ib3+rEUtFIJZPz5mBWRoE76qtyElxPKvGev
        43ZQa5cHFNtWdG71TQHjCKjImw==
X-Google-Smtp-Source: AGHT+IGm6yg4wtmrv8uynHZYZRWKXZRKz7ZqoHGJK7e8aHRDN8aN5regPodQiyekgYnoYqycS8PeoA==
X-Received: by 2002:a17:90a:d30f:b0:273:ed61:a682 with SMTP id p15-20020a17090ad30f00b00273ed61a682mr335053pju.1.1694747768273;
        Thu, 14 Sep 2023 20:16:08 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ne10-20020a17090b374a00b002609cadc56esm2029293pjb.11.2023.09.14.20.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 20:16:07 -0700 (PDT)
Date:   Thu, 14 Sep 2023 20:16:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ACPI: OSI: refactor deprecated strncpy
Message-ID: <202309142015.FC86A2C@keescook>
References: <20230911-strncpy-drivers-acpi-osi-c-v1-1-ca2ec0667b18@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911-strncpy-drivers-acpi-osi-c-v1-1-ca2ec0667b18@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 08:36:44PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> We know `osi->string` is a NUL-terminated string due to its eventual use
> in `acpi_install_interface()` and `acpi_remove_interface()` which expect
> a `acpi_string` which has been specifically typedef'd as:
> |  typedef char *acpi_string;	/* Null terminated ASCII string */
> 
> ... and which also has other string functions used on it like `strlen`.
> Furthermore, padding is not needed in this instance either.

Following the callers, I agree, this doesn't need %NUL padding -- it's
always processed as a regular C string.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> 
> Due to the reasoning above a suitable replacement is `strscpy` [2] since
> it guarantees NUL-termination on the destination buffer and doesn't
> unnecessarily NUL-pad.
> 
> While there is unlikely to be a buffer overread (or other related bug)
> in this case, we should still favor a more robust and less ambiguous
> interface.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested
> ---
>  drivers/acpi/osi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/osi.c b/drivers/acpi/osi.c
> index d4405e1ca9b9..df9328c850bd 100644
> --- a/drivers/acpi/osi.c
> +++ b/drivers/acpi/osi.c
> @@ -110,7 +110,7 @@ void __init acpi_osi_setup(char *str)
>  			break;
>  		} else if (osi->string[0] == '\0') {
>  			osi->enable = enable;
> -			strncpy(osi->string, str, OSI_STRING_LENGTH_MAX);
> +			strscpy(osi->string, str, OSI_STRING_LENGTH_MAX);
>  			break;
>  		}
>  	}
> 
> ---
> base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
> change-id: 20230911-strncpy-drivers-acpi-osi-c-c801b7427987
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 

-- 
Kees Cook
