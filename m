Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E457890B5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 23:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjHYVuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 17:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjHYVtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 17:49:43 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9336A26AF
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 14:49:41 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68bec3a9bdbso1063710b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 14:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693000181; x=1693604981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0uXX3yWMumHoz9Ne0brtDEr7hVyliwSsmYAIn+H5H/I=;
        b=hvYCQ4ck9OTuXOrSASd6reczZDZbRFWik8y5PbNupSaE5FuhFpFik+7pBpNPwHvAXJ
         J5e1fHtsPxC9WiZt9x4xoWNlEiuJp7QMKHgVO0z2VHaE8FYpq/a7/F6p0DkduKU9vwuE
         2YSP02cD/U3CDGnoTjHNp7qsrx8qcemieW6hw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693000181; x=1693604981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0uXX3yWMumHoz9Ne0brtDEr7hVyliwSsmYAIn+H5H/I=;
        b=le25nLdJH5pF0jCUhpIZ+gmPByqRqV+guUqd8todLb+ChQUwOdWWBeQ9xohsKLU1un
         GEGOCGzssW8K/c2eu/PGc499vmL8UaCDKCkHJEJ6rKyCu38o+QS93R1/4YX7XQfh9Dd0
         EEio4FMWWZ8x8AtfferNGBtHF6NR4sHtKDrIeAM8ft/mRRclbngQLGC4fDbvvtUTPMN0
         eR/8QCvCmV0ekboYlLRpZApO/34vYJVOKwvx3bcnUjVUwYCkqUwbRRxl/r7d2FGcM8LS
         7W+nNbe30jZXTV0XuaKiExq1bckacqGdG8b7UKzqk0C8PDHBq3IFuEXPvd3dpVwndxjh
         +TUw==
X-Gm-Message-State: AOJu0YzbfkTcWgkMq7g4s8DdMaKKcCNg1ApjB5TNelKKkeeLOft25o4B
        enJGX5TCIt2KeM6522AMvL21zg==
X-Google-Smtp-Source: AGHT+IFiDJhuRdMmJIDMmTKeu70VLVj2TRKI6mZc1WbmzXoLqFaEbFFsyDL3seS95GCNOAQgR/80iA==
X-Received: by 2002:a05:6a00:b8e:b0:68a:45a1:c0f3 with SMTP id g14-20020a056a000b8e00b0068a45a1c0f3mr17743593pfj.18.1693000181021;
        Fri, 25 Aug 2023 14:49:41 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d21-20020aa78695000000b0068a6972ca0esm2030543pfo.106.2023.08.25.14.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 14:49:40 -0700 (PDT)
Date:   Fri, 25 Aug 2023 14:49:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        speakup@linux-speakup.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] accessibility: speakup: refactor deprecated strncpy
Message-ID: <202308251439.36BC33ADB2@keescook>
References: <20230824-strncpy-drivers-accessibility-speakup-kobjects-c-v1-1-3a1ef1221e90@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824-strncpy-drivers-accessibility-speakup-kobjects-c-v1-1-3a1ef1221e90@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 09:44:29PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> Use `strscpy` as it guarantees NUL-termination of its destination buffer [2]
> which allows for simpler and less ambiguous code.
> 
> Also, change `strlen(buf)` to `strlen(ptr)` to be consistent with
> further usage within the scope of the function. Note that these are
> equivalent:
> |419 	const char *ptr = buf;
> 
> Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings[1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> ---
>  drivers/accessibility/speakup/kobjects.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/accessibility/speakup/kobjects.c b/drivers/accessibility/speakup/kobjects.c
> index a7522d409802..8aa416c5f3fc 100644
> --- a/drivers/accessibility/speakup/kobjects.c
> +++ b/drivers/accessibility/speakup/kobjects.c
> @@ -422,12 +422,11 @@ static ssize_t synth_direct_store(struct kobject *kobj,
>  	if (!synth)
>  		return -EPERM;
>  
> -	len = strlen(buf);
> +	len = strlen(ptr);
>  	spin_lock_irqsave(&speakup_info.spinlock, flags);
>  	while (len > 0) {
>  		bytes = min_t(size_t, len, 250);
> -		strncpy(tmp, ptr, bytes);
> -		tmp[bytes] = '\0';
> +		strscpy(tmp, ptr, bytes);
>  		string_unescape_any_inplace(tmp);
>  		synth_printf("%s", tmp);
>  		ptr += bytes;

Technically, yes, this is fine...

Reviewed-by: Kees Cook <keescook@chromium.org>

But wow do you find the most amazing code. :)

This thing is taking a buffer and chopping it up into at-most 250 byte
chunks (smaller than buf, I might add), and then sending it to
synth_printf() ... which uses a 160 byte buffer and silently
truncates...  and uses "%s" which is just a string copy...
why doesn't this just use synth_write() directly on an unescaped
buf??

I think this entire function should just be:

static ssize_t synth_direct_store(struct kobject *kobj,
                                  struct kobj_attribute *attr,
                                  const char *buf, size_t count)
{
        char *unescaped;
	char *p;

        if (!synth)
                return -EPERM;

	unescaped = kstrdup(buf, GFP_KERNEL);
	if (!unescaped)
		return -ENOMEM;

	string_unescape_any_inplace(unescaped);

        spin_lock_irqsave(&speakup_info.spinlock, flags);
	synth_write(unescaped, strlen(unescaped));
        spin_unlock_irqrestore(&speakup_info.spinlock, flags);

	kfree(unescaped);

        return count;
}

(Though honestly, why does this need unescaping anyway?)

-Kees

-- 
Kees Cook
