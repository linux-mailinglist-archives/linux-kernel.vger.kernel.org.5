Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC6479F0AD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 19:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjIMR4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 13:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjIMR4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 13:56:34 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0237F19AE;
        Wed, 13 Sep 2023 10:56:31 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6bf04263dc8so48410a34.3;
        Wed, 13 Sep 2023 10:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694627790; x=1695232590; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uGDdpFKCDnpc+ssHlTq66FORxZksxKD5gAg2WZYxqbQ=;
        b=lN5kZpfBpIM8u7hTHxukHolA+RRGI6UzT1xTE2jBtQsS3spMTX6Ax8MM4Y2GFbNS/B
         v0Nwa6hmFrqDZ9XxMqizQLqL5BnBBRH8HhZ2VIZqZuafOD7v67Dm+inZtjffkBUtbxL5
         auaibzIYu3EVSk3WUJ18xFaf9A+wTJJeEo3/0jS3kKn0dfXqLKLUCspFY8GFLmY9TR1Y
         czxIpTObVnUJu3mSNbzhvVlIqfELA5qmqAYtBebmfHABCV4PUjhkd6Vr/ahdfE5py0ZQ
         dJIRSdvMs/dnJR+X36suVgJYV1J+V7Vi9dG1fqbovirU/fXY35FRbSaojQwvoROBHeeg
         pkdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694627790; x=1695232590;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uGDdpFKCDnpc+ssHlTq66FORxZksxKD5gAg2WZYxqbQ=;
        b=mrvUXLQdnWxDA13LEX5eqo9Qk468FF52e7SkGydWpwKfhshNucUwJN5W/+eUGYov3p
         4GiIZQp63grgHJUUl5AB07ZxfzjpPicOrCmht+koQKyK7Dff8YajiNdQmaOt98YiCSav
         LFJ/DI5ejscRMJiAe83Fw22mkCbrghtusqrY3KJ5zlFqvELRpfcqtC09yDUKLL/kOE0K
         kSO9obD0A1x67uaW05AmXY335RzBr9qiA9UYoU3eoFxvqdV03p13sDMsG30Wg0jj6d8/
         ZU+RKEdkKvC62VoqR7+WDjZjj32kKh7St/QnM8Gs6FliCRU3qbtNUUpd/Y3xrbRPmjhd
         R3eA==
X-Gm-Message-State: AOJu0YzFWFwB2ZTwX8ipT60Lr43SGvl5QtuxZdABwNnBaJ8q2UlSQm4m
        g3fYFZ49qdS3Y/AAZnGBNcXfjdSDWg==
X-Google-Smtp-Source: AGHT+IG2h57eZ3z8FOxRhv0xL7TnrcTAAlOuEhAzkitkrKR8R0PBIDXC4CmKXEitdu5knxbKM1n2Iw==
X-Received: by 2002:a9d:4f08:0:b0:6be:fc8b:40fc with SMTP id d8-20020a9d4f08000000b006befc8b40fcmr3489799otl.36.1694627790195;
        Wed, 13 Sep 2023 10:56:30 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id v25-20020a056830141900b006b89dafb721sm5148382otp.78.2023.09.13.10.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 10:56:29 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from mail.minyard.net (unknown [IPv6:2001:470:b8f6:1b:cad6:f0ef:2bda:cb78])
        by serve.minyard.net (Postfix) with ESMTPSA id CDAA5180108;
        Wed, 13 Sep 2023 17:56:28 +0000 (UTC)
Date:   Wed, 13 Sep 2023 12:56:27 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2] ipmi: refactor deprecated strncpy
Message-ID: <ZQH3y2ONi90A2e8k@mail.minyard.net>
Reply-To: minyard@acm.org
References: <20230913-strncpy-drivers-char-ipmi-ipmi-v2-1-e3bc0f6e599f@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913-strncpy-drivers-char-ipmi-ipmi-v2-1-e3bc0f6e599f@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 05:13:04PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].

Thanks, applied to my next tree.

-corey

> 
> In this case, strncpy is being used specifically for its NUL-padding
> behavior (and has been commented as such). Moreover, the destination
> string is not required to be NUL-terminated [2].
> 
> We can use a more robust and less ambiguous interface in
> `memcpy_and_pad` which makes the code more readable and even eliminates
> the need for that comment.
> 
> Let's also use `strnlen` instead of `strlen()` with an upper-bounds
> check as this is intrinsically a part of `strnlen`.
> 
> Also included in this patch is a simple 1:1 change of `strncpy` to
> `strscpy` for ipmi_ssif.c. If NUL-padding is wanted here as well then we
> should opt again for `strscpy_pad`.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://lore.kernel.org/all/ZQEADYBl0uZ1nX60@mail.minyard.net/ [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Changes in v2:
> - use memcpy_and_pad (thanks Corey)
> - Link to v1: https://lore.kernel.org/r/20230912-strncpy-drivers-char-ipmi-ipmi-v1-1-cc43e0d1cae6@google.com
> ---
>  drivers/char/ipmi/ipmi_msghandler.c | 11 +++--------
>  drivers/char/ipmi/ipmi_ssif.c       |  2 +-
>  2 files changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> index 186f1fee7534..d6f14279684d 100644
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
> +		memcpy_and_pad(data+5, 11, p, size, '\0');
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
