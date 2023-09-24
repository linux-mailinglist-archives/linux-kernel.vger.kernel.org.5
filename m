Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3847AC67A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 05:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjIXD33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 23:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXD31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 23:29:27 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD83B124
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 20:29:20 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-59bebd5bdadso52665187b3.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 20:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695526160; x=1696130960; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0sacnJ2cxsyUdNljEIHRMc8mGWJME3BUwqYb875zUKc=;
        b=bNPrIkdhXQsPfHHBYGX/l+QLdpOgRh0rElNTjuHlRuPh9+25cPvcdVFJ3GxVoZ2A6S
         JcPtP06Sz1Tiw/PPvXzrciZ7TQNK2V7d5YRcbrtBj8OHJVp8SprwrOMQ13JLE75KWQcG
         8xV6fsM0+mJbQMOuqS/bhspmE8cbq5/pzgGuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695526160; x=1696130960;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0sacnJ2cxsyUdNljEIHRMc8mGWJME3BUwqYb875zUKc=;
        b=pJImfGZ0s78Dt/XnGWRlwoq29PqvkzZA4q0toYEIrfdKJmrB5XJ1ptlZTlKfV44R11
         MZgA9hXVMpl9ifcED3uQzBobwr6XhnSE1W4nKOoMCdQ1Is7WDJbg5qBwe0MV1gVbfp1h
         JNry5eGlcSABQVZJwdWZTWDVB5HpTxEPV29t31/1YFhn6q9QVvow+xB40QWDV3iOlbwZ
         8tkZV117bzUni+z9+OV8gf1C+OsZh5U4GdLz07OQ4lY23TOlLGQzXBL50tZseDikXODA
         ueSD0LkNILJdIgowlLvpZWHvxTFNEWTuSWfEnFdeuyomp2qFBYamrTuhaygYCzh5fRMF
         xh1A==
X-Gm-Message-State: AOJu0YwTn2M7EV6K4CV1AUmg5FGt4H4UdtBt495gQ0Q2ptGr+ir6l6c3
        4DeDLc0nVjFepsuY6eM1gHjXww==
X-Google-Smtp-Source: AGHT+IHLetgN8Z6HYfxweRg549a0pUcJGB5rSTpFWmQXRJFkbO+pUmNPNqkjbmqo3NU1E0uzRrbQIA==
X-Received: by 2002:a0d:f685:0:b0:56d:9e2:7d9e with SMTP id g127-20020a0df685000000b0056d09e27d9emr2932368ywf.21.1695526159922;
        Sat, 23 Sep 2023 20:29:19 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id hi11-20020a17090b30cb00b00277371fd346sm1120927pjb.30.2023.09.23.20.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 20:29:19 -0700 (PDT)
Date:   Sat, 23 Sep 2023 20:29:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] Input: axp20x-pek - refactor deprecated strncpy
Message-ID: <202309232024.9A31A291@keescook>
References: <20230921-strncpy-drivers-input-misc-axp20x-pek-c-v1-1-f7f6f4a5cf81@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921-strncpy-drivers-input-misc-axp20x-pek-c-v1-1-f7f6f4a5cf81@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 09:17:25AM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> Ensuring we have a trailing NUL-byte and checking the length of bytes
> copied are both intrinsic behavior of strscpy.
> 
> Therefore, a suitable replacement is `strscpy` [2] due to the fact that
> it guarantees NUL-termination on the destination buffer without
> unnecessarily NUL-padding.
> 
> It should be noted that the original code can silently truncate and so
> can this refactoring. However, a check could be added if truncation
> is an issue:
> | len = strscpy(val_str, buf, sizeof(val_str));
> | if (len < 0) { // add this
> |   return -E2BIG; // or -EINVAL
> | }
> 
> Also, now check for `len > 0` instead of just a truthy `len` because
> `len` is now a signed type and we could run into problems if strscpy
> returned -E2BIG which would pass the truthy test.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> ---
>  drivers/input/misc/axp20x-pek.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/input/misc/axp20x-pek.c b/drivers/input/misc/axp20x-pek.c
> index 4581606a28d6..abcf78785b45 100644
> --- a/drivers/input/misc/axp20x-pek.c
> +++ b/drivers/input/misc/axp20x-pek.c
> @@ -134,16 +134,14 @@ static ssize_t axp20x_store_attr(struct device *dev,
>  {
>  	struct axp20x_pek *axp20x_pek = dev_get_drvdata(dev);
>  	char val_str[20];
> -	size_t len;
> +	ssize_t len;
>  	int ret, i;
>  	unsigned int val, idx = 0;
>  	unsigned int best_err = UINT_MAX;
>  
> -	val_str[sizeof(val_str) - 1] = '\0';
> -	strncpy(val_str, buf, sizeof(val_str) - 1);
> -	len = strlen(val_str);
> +	len = strscpy(val_str, buf, sizeof(val_str));
>  
> -	if (len && val_str[len - 1] == '\n')
> +	if (len > 0 && val_str[len - 1] == '\n')
>  		val_str[len - 1] = '\0';
>  
>  	ret = kstrtouint(val_str, 10, &val);

This code is doing a LOT of work before handing it off to kstrtouint(),
and none of it is needed. val_str is never used again, and the work is
to make sure the newline is dropped -- but kstrtouint() does this
already. I think this can just be:


diff --git a/drivers/input/misc/axp20x-pek.c b/drivers/input/misc/axp20x-pek.c
index 4581606a28d6..b1389a4c7702 100644
--- a/drivers/input/misc/axp20x-pek.c
+++ b/drivers/input/misc/axp20x-pek.c
@@ -134,19 +134,11 @@ static ssize_t axp20x_store_attr(struct device *dev,
 {
 	struct axp20x_pek *axp20x_pek = dev_get_drvdata(dev);
 	char val_str[20];
-	size_t len;
 	int ret, i;
 	unsigned int val, idx = 0;
 	unsigned int best_err = UINT_MAX;
 
-	val_str[sizeof(val_str) - 1] = '\0';
-	strncpy(val_str, buf, sizeof(val_str) - 1);
-	len = strlen(val_str);
-
-	if (len && val_str[len - 1] == '\n')
-		val_str[len - 1] = '\0';
-
-	ret = kstrtouint(val_str, 10, &val);
+	ret = kstrtouint(buf, 10, &val);
 	if (ret)
 		return ret;
 
And, [broken record] for v2, please update the Subject to better describe
the resulting change. :)

-Kees

-- 
Kees Cook
