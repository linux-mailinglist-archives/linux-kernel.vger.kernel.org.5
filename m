Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A6C79DD16
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 02:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237950AbjIMATe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 20:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237899AbjIMATc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 20:19:32 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F5518D;
        Tue, 12 Sep 2023 17:19:28 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-57355a16941so3954365eaf.2;
        Tue, 12 Sep 2023 17:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694564368; x=1695169168; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PfghF8uM8XDGpkVqp5zNnFzbHxUr4fq3CDSPLr1OUm4=;
        b=m88zUcd8670VEgvBbw32sDZZTG0H/RcXPgEiMx9JujO/Pacc7PSxSwS7InXuGIQ5E2
         WuW8YW90fdTNqNFZf/idI2STRXvzjMzlsbBQhmd5gp/gpiWI/bTYNRfnkO2qus6w8Gwf
         nccT8BxUQc9RO3YfeG987K5NUqOEpxfS/5xPn2akxmFV2gpSbX9+Atenfziq9C8TTakS
         49ECIDps5y24yuOhmnMNE/OO69K1dviscVgnvtw/JkcILHoDTK2lmUWcM9qu7hD0UGTA
         K6nvcP37ZXirXaq+QauzUFy5J2VYNFzZ8e+n2iC7f9qQig0epxtLJ1kb2BCdSPzjy3kM
         /aYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694564368; x=1695169168;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PfghF8uM8XDGpkVqp5zNnFzbHxUr4fq3CDSPLr1OUm4=;
        b=p6CWeufUy4TGJ1oyPdJ5wgiU1CC6Sb3rau3KLq9iEjJhCvKqHXBB4cWoJ8tE5YBRo8
         gZQCBqvQYGTff5JaaLAplLZDxIykhBxmS3FkpmR7UCUylVhM3sSlgcsW/7wz3orzjjM2
         jh1Uk64HUCxxo9nY0EmE50QnCgy7tGq+eL2HsQt//2h5HYKT28oeu0Pz6S+/5FSNYC7V
         U5eUV4ObqdwjCEUeWZZIjakj6vumLKcarrMKcQgH5vR+EqI5b5utK5x55ZTlpTusO2Hy
         CPzGjljMFfQhMwGvxCBJmGEiV3FlJlGDl3rHlrRRiknwt1vnFdIeKyul1zME+Dz4fA2B
         BuwA==
X-Gm-Message-State: AOJu0YxNIznxftCi4TeLMirYPy6nW4s6h9DK73suWiNTX4t7DVJjSbSi
        VorfHhSCq4Tl3jmrIKwQGyp8eGNPCA==
X-Google-Smtp-Source: AGHT+IEBrNjwofXj6G2wwq3+fhWd4+Zn4fUTHi6Gsb1GQmmfdRCAV8o1YXWULOlI5YyVG6stpJilMQ==
X-Received: by 2002:a4a:9cd6:0:b0:56e:4dea:bc5c with SMTP id d22-20020a4a9cd6000000b0056e4deabc5cmr1246154ook.8.1694564368168;
        Tue, 12 Sep 2023 17:19:28 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id a42-20020a4a98ad000000b0057327cecdd8sm4871916ooj.10.2023.09.12.17.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 17:19:27 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from mail.minyard.net (unknown [IPv6:2001:470:b8f6:1b:be75:f593:c65b:4578])
        by serve.minyard.net (Postfix) with ESMTPSA id EB8A41800E8;
        Wed, 13 Sep 2023 00:19:26 +0000 (UTC)
Date:   Tue, 12 Sep 2023 19:19:25 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] ipmi: refactor deprecated strncpy
Message-ID: <ZQEADYBl0uZ1nX60@mail.minyard.net>
Reply-To: minyard@acm.org
References: <20230912-strncpy-drivers-char-ipmi-ipmi-v1-1-cc43e0d1cae6@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912-strncpy-drivers-char-ipmi-ipmi-v1-1-cc43e0d1cae6@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 11:43:05PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> In this case, strncpy is being used specifically for its NUL-padding
> behavior (and has been commented as such). We can use a more robust and
> less ambiguous interface in `strscpy_pad` which makes the code more
> readable and even eliminates the need for that comment.
> 
> Let's also use `strnlen` instead of `strlen()` with an upper-bounds
> check as this is intrinsically a part of `strnlen`.
> 
> Also included in this patch is a simple 1:1 change of `strncpy` to
> `strscpy` for ipmi_ssif.c. If NUL-padding is wanted here as well then we
> should opt again for `strscpy_pad`.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
>  drivers/char/ipmi/ipmi_msghandler.c | 11 +++--------
>  drivers/char/ipmi/ipmi_ssif.c       |  2 +-
>  2 files changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> index 186f1fee7534..04f7622cb703 100644
> --- a/drivers/char/ipmi/ipmi_msghandler.c
> +++ b/drivers/char/ipmi/ipmi_msghandler.c
> @@ -5377,20 +5377,15 @@ static void send_panic_events(struct ipmi_smi *intf, char *str)
>  
>  	j = 0;
>  	while (*p) {
> -		int size = strlen(p);
> +		int size = strnlen(p, 11);
>  
> -		if (size > 11)
> -			size = 11;
>  		data[0] = 0;
>  		data[1] = 0;
>  		data[2] = 0xf0; /* OEM event without timestamp. */
>  		data[3] = intf->addrinfo[0].address;
>  		data[4] = j++; /* sequence # */
> -		/*
> -		 * Always give 11 bytes, so strncpy will fill
> -		 * it with zeroes for me.
> -		 */
> -		strncpy(data+5, p, 11);
> +
> +		strscpy_pad(data+5, p, 11);

This is incorrect, the destination should *not* be nil terminated if the
destination is full.  strncpy does exactly what is needed here.

A comment should be added here, this is not the first time this has been
brought up.

>  		p += size;
>  
>  		ipmi_panic_request_and_wait(intf, &addr, &msg);
> diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
> index 3b921c78ba08..edcb83765dce 100644
> --- a/drivers/char/ipmi/ipmi_ssif.c
> +++ b/drivers/char/ipmi/ipmi_ssif.c
> @@ -1940,7 +1940,7 @@ static int new_ssif_client(int addr, char *adapter_name,
>  		}
>  	}
>  
> -	strncpy(addr_info->binfo.type, DEVICE_NAME,
> +	strscpy(addr_info->binfo.type, DEVICE_NAME,
>  		sizeof(addr_info->binfo.type));

This one is good.

-corey

>  	addr_info->binfo.addr = addr;
>  	addr_info->binfo.platform_data = addr_info;
> 
> ---
> base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
> change-id: 20230912-strncpy-drivers-char-ipmi-ipmi-dda47b3773fd
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 
