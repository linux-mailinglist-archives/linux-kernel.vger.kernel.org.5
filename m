Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A53277B467
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234646AbjHNIl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 04:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234289AbjHNIlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:41:22 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723C510D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:41:21 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fe4ad22e36so37582925e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692002480; x=1692607280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D5aLdYoDzonLAxZ5PSMomSbWxhFnGKGGnvbysSjVTVc=;
        b=nofShKkvBm0DO7xSJvOuELrwERW3RQEALYLWsAtldEaPqBHXOHp5mq6q4Z+IIwAeGI
         YFH55cFn6nnypFsgmDfbucGvylbLdOgahjrrmYN9y0rYFtqHwd9Vc6HaqtOwFVf5b5la
         H370hVR3iiSCbWVK9CKhDvQAjetELuWJC6hTyXN2gjmnJVIPeK32XDAW5R9WmU9Q7FGh
         XWsZ9+Pgg4E/iu3mQUwWrDEPePMo5MatDfAbZsOc674cSBUbaA0nH5R/pjzziJ8ZOBI6
         ho5ASHWnT19j1Cqq5skAl8fPpQydUAX4YW4HK2V3M1SLuQjTjsUNm6QzqpXRoZbUsaQ3
         ODxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692002480; x=1692607280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D5aLdYoDzonLAxZ5PSMomSbWxhFnGKGGnvbysSjVTVc=;
        b=R0hf5AAO/kTGWdE78z6pQlED5eorlerMJ9Nae0XxhlKvXvw6wvW5lJBmzoif4Kn2hQ
         FqurqFwVgLF9ba4F7py+/MtnOkRb0vbpUqAFY1mg3jlbl1gHtgFb2WP55iKbVyrcFBtq
         PpmvIvaoRAs5AS96NFrEi5ihHNCAkEOCStaF4/hCi9GbsXOBNq1x44myYa/KP+2oiM1O
         f873w0kAJ7K1dPNrDr4TGpt4Vb/Bdw8e9vo7jXvEthixEHMJzJw0R0ma90sjAwIgJnDK
         gwJ8GdcjoAr5KiK5m/kHbQYDltizqvWhRdxwLts0gFn0oR8nQsuOLLwPhHaD1YCenfZ0
         WKeQ==
X-Gm-Message-State: AOJu0YxgZUlw2e4j289vWHn1wkxOYqDLU1Opk6GDSVgdSpSMQ3jTWlYy
        3w+zy38R0YCpkn4/NvH7PQ8xGg==
X-Google-Smtp-Source: AGHT+IEjqxBt+uF9fAJFXmoE7E2jsAgWdkYg6ku2TUxOU9VSoYR5tHOmsX19STi7JTMgtzI/v48xfg==
X-Received: by 2002:a7b:c045:0:b0:3fb:e054:903f with SMTP id u5-20020a7bc045000000b003fbe054903fmr6941460wmc.36.1692002479946;
        Mon, 14 Aug 2023 01:41:19 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id v23-20020a05600c215700b003fe1ddd6ac0sm16527413wml.35.2023.08.14.01.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 01:41:19 -0700 (PDT)
Date:   Mon, 14 Aug 2023 09:41:17 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Artur Weber <aweber.kernel@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: lp855x: fix unintialized function return
Message-ID: <20230814084117.GD5056@aspen.lan>
References: <20230811131600.2380519-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811131600.2380519-1-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 03:15:53PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> The function now returns an error code in some cases, but fails to initialize
> it in others:
>
> drivers/video/backlight/lp855x_bl.c:252:11: error: variable 'ret' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
>         else if (lp->mode == REGISTER_BASED)
>                  ^~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/video/backlight/lp855x_bl.c:256:9: note: uninitialized use occurs here
>         return ret;
>                ^~~
> drivers/video/backlight/lp855x_bl.c:252:7: note: remove the 'if' if its condition is always true
>         else if (lp->mode == REGISTER_BASED)
>              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Since this case should not actually happen, return the -EINVAL code.
>
> Fixes: 5145531be5fba ("backlight: lp855x: Catch errors when changing brightness")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I think we already received a patch for this:
https://lore.kernel.org/lkml/20230809163825.GA5056@aspen.lan/T/


Daniel.
