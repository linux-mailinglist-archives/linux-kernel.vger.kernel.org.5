Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1BB807A19
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 22:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379607AbjLFVHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 16:07:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379534AbjLFVHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 16:07:23 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC7ED69
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 13:07:29 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-2868605fa4aso256963a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 13:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701896849; x=1702501649; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZqFC5ji57tlGOgcDGhYR3koXkffw9V8OUgIHws4y0Ik=;
        b=e6l8tHe2M5qlVEEJ1DCYVDM88akxop4k1yonzqkenLnFE/utNe9Bp5mC9NOsOGgnA5
         O5w0JXVSD3uXLZZqhnCj6F/vR7z1GY9hnwE+/DmSxzjYUa0PV/ul/xOhoiUF3jTL/67C
         VqD15G+/LwwV/KhYRoLPrLxDwBW9Z6UQsZixc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701896849; x=1702501649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZqFC5ji57tlGOgcDGhYR3koXkffw9V8OUgIHws4y0Ik=;
        b=gq48yrLT4Bnriijot3f8EZ3cr0RTlI3+SbXOE56BAH/FQDXQtBj3KgzUXcA8gbGQCN
         rmAb1SUev/EpOOiAEVCjeXYtzJANGGaKM+fV3titHRUQ1pC/IrYOc5IuvN+Oamk8QkCv
         GshTgL+ufx2Uyt7quFX/0RQ5FXiHxAdFPXh25Y7apHfApwg/g89Y+uiYYtbyF1BNOYny
         WH26Bgc9x07G9E3IHkhBUSYFGCoXN+GBbSiF3ev4MIT6fOgwI/IwYNCPAdmyYtjpnVAM
         uc5obKK3xudAwPNlGo2QPf9ZZBbrnPbPktl62MFHMz4iO7jtp0VoexRZEhHgwgFkgq3I
         d0Hg==
X-Gm-Message-State: AOJu0YxVK9Cx7++1JkmfQb5spa8pa7aVau2yFzud3YHPoG8MHTdfLZpa
        0aocB9esVWwcuAKb4vCxY20aJQ==
X-Google-Smtp-Source: AGHT+IEAbbzSLQbJ/Rm3HnAGHG3fVDh0lRG/dixqNMZ39AimVhzfCgt99eehqSCc5SMeKCYoDAW9gw==
X-Received: by 2002:a17:90b:5281:b0:286:6cc0:b920 with SMTP id si1-20020a17090b528100b002866cc0b920mr1089720pjb.87.1701896848897;
        Wed, 06 Dec 2023 13:07:28 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id gq7-20020a17090b104700b0028571e2a759sm296227pjb.48.2023.12.06.13.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 13:07:28 -0800 (PST)
Date:   Wed, 6 Dec 2023 13:07:27 -0800
From:   Kees Cook <keescook@chromium.org>
To:     davidgow@google.com
Cc:     Rae Moar <rmoar@google.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxime Ripard <mripard@kernel.org>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH 2/4] fortify: test: Use kunit_device
Message-ID: <202312061306.98DA6D275D@keescook>
References: <20231205-kunit_bus-v1-0-635036d3bc13@google.com>
 <20231205-kunit_bus-v1-2-635036d3bc13@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205-kunit_bus-v1-2-635036d3bc13@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 03:31:34PM +0800, davidgow@google.com wrote:
> Using struct root_device to create fake devices for tests is something
> of a hack. The new struct kunit_device is meant for this purpose, so use
> it instead.
> 
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>  lib/fortify_kunit.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/fortify_kunit.c b/lib/fortify_kunit.c
> index c8c33cbaae9e..f7a1fce8849b 100644
> --- a/lib/fortify_kunit.c
> +++ b/lib/fortify_kunit.c
> @@ -16,6 +16,7 @@
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
>  #include <kunit/test.h>
> +#include <kunit/device.h>
>  #include <linux/device.h>
>  #include <linux/slab.h>
>  #include <linux/string.h>
> @@ -269,7 +270,7 @@ DEFINE_ALLOC_SIZE_TEST_PAIR(kvmalloc)
>  	size_t len;							\
>  									\
>  	/* Create dummy device for devm_kmalloc()-family tests. */	\
> -	dev = root_device_register(dev_name);				\
> +	dev = kunit_device_register(test, dev_name);			\
>  	KUNIT_ASSERT_FALSE_MSG(test, IS_ERR(dev),			\
>  			       "Cannot register test device\n");	\
>  									\
> @@ -303,7 +304,7 @@ DEFINE_ALLOC_SIZE_TEST_PAIR(kvmalloc)
>  	checker(len, devm_kmemdup(dev, "Ohai", len, gfp),		\
>  		devm_kfree(dev, p));					\
>  									\
> -	device_unregister(dev);						\
> +	kunit_device_unregister(test, dev);				\
>  } while (0)
>  DEFINE_ALLOC_SIZE_TEST_PAIR(devm_kmalloc)

Acked-by: Kees Cook <keescook@chromium.org>

(As an aside; shouldn't this get automatically cleaned up like other
kunit resources, though?)

-- 
Kees Cook
