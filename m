Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F217A1514
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 07:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbjIOFCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 01:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbjIOFCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 01:02:47 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC18230D6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 22:02:14 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-68fc081cd46so1673813b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 22:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694754134; x=1695358934; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WZUHT7ZncwMciXGAdkByCDy2UYR6xxoRGWT81VKP1ig=;
        b=hcH1OKLgP6A0GTmVl7Ud8QGw5hyZIVAleNVGgzN/n7nUVBRUScG7cJ2+epBOv7FfLf
         gmMnkoQEZoc4D3/Qhj3KPSCNve3tc2OUQK9VBq5qoUkQZ4dYePsCNK0lwKC+8SHcfhDh
         xNoDCGeiCgwsAgQABCoHX20aZjZWDL+Nx8j98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694754134; x=1695358934;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZUHT7ZncwMciXGAdkByCDy2UYR6xxoRGWT81VKP1ig=;
        b=c+QWBxyB2sMjnTTFKyBbsltHOzUuoBvvPS/AP0W7Yj4mWTOsQHj3TWKdDdcoMWDfea
         YIlDSykhDWXemOsgWT5OPSG5dXkQhcZkSTEB8uj6LAwypDxIwSkS49o+1gXC38H58wS5
         pc/wHK/9p9f6zvCXwR7ZsAYeKQvpXUEREC0GYv2FFQO+/M2N75DSkwUoCfI1wr7krkQS
         RfNlhrfU8eyyyDF4L5imdu077bhK1giAnsw8pg6SmEFvvLhqOO1CrwoI1uZpDUPn66VT
         Smv5Imib5R3eJ60Dw0S3vfc+b2WG4EiqFnnJAi19xOEQBlAKXgg4s0uIfgNXbSt4YU7A
         Zj6Q==
X-Gm-Message-State: AOJu0YwWzma3NeLTzP6I5H44ICtYoo1RAYnlH2zBJOJjEEpV0XTzqNrg
        D/f+77vwx/GFTwj04TECl8CkfXF98hsN4aDXv3U=
X-Google-Smtp-Source: AGHT+IGyTtLCa2sSYfpYJAobIKiqp/hb3pnaq2A04V7budd45O+mGDgvJK8UC6are2k2azYMIuIS/Q==
X-Received: by 2002:a05:6a20:54a9:b0:157:229a:db21 with SMTP id i41-20020a056a2054a900b00157229adb21mr807822pzk.56.1694754134190;
        Thu, 14 Sep 2023 22:02:14 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 18-20020a056a00073200b0067ab572c72fsm2131987pfm.84.2023.09.14.22.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 22:02:13 -0700 (PDT)
Date:   Thu, 14 Sep 2023 22:02:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] HID: prodikeys: refactor deprecated strncpy
Message-ID: <202309142201.683ED5A7FD@keescook>
References: <20230914-strncpy-drivers-hid-hid-prodikeys-c-v1-1-10c00550f2c2@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914-strncpy-drivers-hid-hid-prodikeys-c-v1-1-10c00550f2c2@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 10:20:55PM +0000, Justin Stitt wrote:
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
> Note: for some reason if NUL-padding is needed let's opt for `strscpy_pad()`
> ---
>  drivers/hid/hid-prodikeys.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hid/hid-prodikeys.c b/drivers/hid/hid-prodikeys.c
> index e4e9471d0f1e..c16d2ba6ea16 100644
> --- a/drivers/hid/hid-prodikeys.c
> +++ b/drivers/hid/hid-prodikeys.c
> @@ -639,9 +639,9 @@ static int pcmidi_snd_initialise(struct pcmidi_snd *pm)
>  		goto fail;
>  	}
>  
> -	strncpy(card->driver, shortname, sizeof(card->driver));
> -	strncpy(card->shortname, shortname, sizeof(card->shortname));
> -	strncpy(card->longname, longname, sizeof(card->longname));
> +	strscpy(card->driver, shortname, sizeof(card->driver));
> +	strscpy(card->shortname, shortname, sizeof(card->shortname));
> +	strscpy(card->longname, longname, sizeof(card->longname));

"card" is already kzalloc()ed so no _pad() is needed, good.

>  
>  	/* Set up rawmidi */
>  	err = snd_rawmidi_new(card, card->shortname, 0,
> @@ -652,7 +652,7 @@ static int pcmidi_snd_initialise(struct pcmidi_snd *pm)
>  		goto fail;
>  	}
>  	pm->rwmidi = rwmidi;
> -	strncpy(rwmidi->name, card->shortname, sizeof(rwmidi->name));
> +	strscpy(rwmidi->name, card->shortname, sizeof(rwmidi->name));
>  	rwmidi->info_flags = SNDRV_RAWMIDI_INFO_INPUT;
>  	rwmidi->private_data = pm;

Same here.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

>  
> 
> ---
> base-commit: 3669558bdf354cd352be955ef2764cde6a9bf5ec
> change-id: 20230914-strncpy-drivers-hid-hid-prodikeys-c-cf42614a21d4
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 

-- 
Kees Cook
