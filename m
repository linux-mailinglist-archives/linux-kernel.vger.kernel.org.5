Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE3C7D05A8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 02:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346750AbjJTAEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 20:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235579AbjJTAEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 20:04:22 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EE412F
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 17:04:19 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5ad5178d1bfso185501a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 17:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697760258; x=1698365058; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WyinLtXIDJ/J+W6Ws5k+7hFrel/yPirPuKlAKtlZbkQ=;
        b=SwqLfM5VRahAzpHfZU/mst5iVfVxp9PMrbBJ/ejbR6VV1D/c6WLYd14N73i4PBZUsr
         dyzmQKNB1APZuLsyHSplGtnEUdaw1kwkQaZF3zs9biOeauGbVfBzH7vI+dBsnv6GlUzQ
         bOi8Rc6v3X4bB5qShVaaYgvxY6SVrOjOz2RyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697760258; x=1698365058;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WyinLtXIDJ/J+W6Ws5k+7hFrel/yPirPuKlAKtlZbkQ=;
        b=EJfbqwtR+o5ljaI3UhbIBB5XT28dLnnSYcWVv0/ucA5BLDjnBosNxiCDHwpfy6RXfL
         P8xO2/847/jlujrC6dR1F7GsUU73oZ1LfS2Rc2f6E+dDGZRJ4IN/vXI/MUvB52RPw6r8
         k8jwFamhUc8ewvMysK6Db4Uu1uafMSFfMy7o4ORryYZ3hm2FeooyFpyDr9au7+8gKzYD
         cwfzie57s1fTUYPKkiTrsyZJKBEWpkA9lGVU20U5Twl8OWhG4R0AprWRjFCcCZRvpvOP
         3d58gyHj86pYDNs/Q8FRZ94ZRp7dmN4xcT+uFYWkONM61g9XaLJL9nNsKQZsW8aGxoa1
         LoKQ==
X-Gm-Message-State: AOJu0YwoUEJSCRffsfaGbRpL4r6uO7s0g08QkDcQEjY/sJluQMXDubPh
        2vbsSWz1ykGth4tMkK94aqwfgk6W2r7KGXtOnqw=
X-Google-Smtp-Source: AGHT+IGLdbduWG19T1e0Z4j49YgX7FlC4Q5RiYDw4z81sX/pEbOSv8eYtkL1VVbIR3nJtcknqdeW+Q==
X-Received: by 2002:a05:6a20:2451:b0:158:17e6:7a6 with SMTP id t17-20020a056a20245100b0015817e607a6mr329364pzc.42.1697760258529;
        Thu, 19 Oct 2023 17:04:18 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h13-20020a17090ac38d00b0027cbc50b826sm2116506pjt.17.2023.10.19.17.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 17:04:17 -0700 (PDT)
Date:   Thu, 19 Oct 2023 17:04:17 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] PNP: replace deprecated strncpy with memcpy
Message-ID: <202310191637.9EBDCC364@keescook>
References: <20231019-strncpy-drivers-pnp-pnpbios-rsparser-c-v1-1-e47d93b52e3e@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019-strncpy-drivers-pnp-pnpbios-rsparser-c-v1-1-e47d93b52e3e@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 11:28:32PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous
> interfaces.
> 
> After having precisely calculated the lengths and ensuring we don't
> overflow the buffer, this really decays to just a memcpy. Let's not use
> a C string api as it makes the intention of the code confusing.

This is another case where we're building a C string from a byte array.

> It'd be nice to use strscpy() in this case (as we clearly want
> NUL-termination) because it'd clean up the code a bit. However, I don't
> quite know enough about what is going on here to justify a drop-in
> replacement -- too much bit magic and why (PNP_NAME_LEN - 2)? I'm afraid
> using strscpy() may result in copying too many or too few bytes into our
> dev->name buffer resulting in different behavior. At least using
> memcpy() we can ensure the behavior is exactly the same.
> 
> Side note:
> NUL-padding is not required because insert_device() calls
> pnpbios_parse_data_stream() with a zero-allocated `dev`:
> 299 |  static int __init insert_device(struct pnp_bios_node *node) {
> ...
> 312 |  dev = pnp_alloc_dev(&pnpbios_protocol, node->handle, id);
> ...
> 316 |  pnpbios_parse_data_stream(dev, node);
> 
> then pnpbios_parse_data_stream() calls pnpbios_parse_compatible_ids().
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

tl;dr:

Reviewed-by: Kees Cook <keescook@chromium.org>

My ramblings below...

> ---
> Note: build-tested only.
> 
> Found with: $ rg "strncpy\("
> ---
>  drivers/pnp/pnpbios/rsparser.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pnp/pnpbios/rsparser.c b/drivers/pnp/pnpbios/rsparser.c
> index 2f31b212b1a5..70af7821d3fa 100644
> --- a/drivers/pnp/pnpbios/rsparser.c
> +++ b/drivers/pnp/pnpbios/rsparser.c
> @@ -454,8 +454,8 @@ static unsigned char *pnpbios_parse_compatible_ids(unsigned char *p,
>  		switch (tag) {

So we've got a fixed-sized C string as a destination:

struct pnp_dev {
	...
        char name[PNP_NAME_LEN];        /* contains a human-readable name */

include/linux/pnp.h:#define PNP_NAME_LEN                50

And a funky "source length" calculation, which appears to be effectively
a u16 (it's either the low 3 bits of a u8, or a full u16);

	int len ...

                /* determine the type of tag */
                if (p[0] & LARGE_TAG) { /* large tag */
                        len = (p[2] << 8) | p[1];
                        tag = p[0];
                } else {        /* small tag */
                        len = p[0] & 0x07;
                        tag = ((p[0] >> 3) & 0x0f);
                }

The old code was doing:

		case LARGE_TAG_ANSISTR:
			strncpy(dev->name, p + 3,
				len >= PNP_NAME_LEN ? PNP_NAME_LEN - 2 : len);
			dev->name[len >=
				  PNP_NAME_LEN ? PNP_NAME_LEN - 1 : len] = '\0';
			break;

The two conditionals are not the same -- the first is -2, the latter is
-1, but only when len >= PNP_NAME_LEN. This smells like a bug? For the
len >= PNP_NAME_LEN case, it will copy 48 bytes and then write a %NUL to
index 49 (byte 50). ... ... source byte 49 is ignored for no reason I
can see.

Regardless, the point is to copy no more than min(len, PNP_NAME_LEN - 1)
from "p + 3" to not overflow dev->name, and leaving it %NUL terminated.

So, I think what you have is identical behavior, and likely still
contains the 1 byte short bug, which I think is fine to keep as-is since
it's been like this forever and it's PNP...

-Kees

-- 
Kees Cook
