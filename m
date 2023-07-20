Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C7E75AF42
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 15:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbjGTNKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 09:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbjGTNKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 09:10:34 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7412A269D
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 06:10:33 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-316f589549cso645395f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 06:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689858632; x=1690463432;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=csFhQ6XfWBL2F/LVnpr751g3gT4RNTtnYo/4zK0OLk0=;
        b=AYUTrJHThtegFmXAf21FWbF8FkPLNfod8iIQR1PVenWxKes/7avxrVbGScXvzKy1CO
         7fUbxVzyP8Y7w5wQ33shQE9B6SuVByq/xgGu2rFqG20d03w0+INBqau49dXUNpIQE9Jg
         2jcz427S6KPPOVHeTohn9WzY7XSyPnwnDtpMr3nHuPlfOIMdUvvOLlny2o6kRDmRV0en
         5NXLFAsWd2wcsHgjrCkPHm75FXpwMB/iQjMKRvdgRiTV4hEDo9DaFIAJUr8SsWI+yFmO
         iVk7GAds1/JW8Ojz4KuI3JEXftTvnrwfqDSFv7NMd0FTQlXS37RUTR/syR78nlFOusu0
         S7Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689858632; x=1690463432;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=csFhQ6XfWBL2F/LVnpr751g3gT4RNTtnYo/4zK0OLk0=;
        b=Wy7UfCpgzlea/4vlWuJdlHFIKsKVJ0EpRIui+req2e2X6W/uvvwhRPUlY1obhXaBxs
         RkCUer923TMLN2zTX9HLQOS5n+jipnFkm0q+uZkBnW1kDFaIXp+3x3cN7sMlzHSlWJwr
         Qca+z9jnlora846j2awl+397kT6VJQHXnhIP99NOsYJbFtCULYdF65zU4UebSRi0/IYz
         rhwyXUVs8w51ViGMW9tv96qH3ok4c9tWK09J28Mt7tjF8b55oQDJ2fCQlyupBGG1AoCd
         D1MnyvE9CbwnTpAC5TEqz9WNFydQAW7fxUI/1ZX/m4Of9Ou48Amo94ap/7kQOdRs+YZ8
         DfYA==
X-Gm-Message-State: ABy/qLbsMlsG8qyu80hnkEY5Esa0BK850slk/8dHLt0AybgmM2swQU17
        UpO1oC9fOQFxK5W0VRGF4sT/qA==
X-Google-Smtp-Source: APBJJlHAQBN4QHX5GQzhjDPb1xmuMYdrMdIrZxUPkEN0IlJOj2W5MMz7ipLHhBJ3k2Q6Q703r7zH9w==
X-Received: by 2002:adf:faca:0:b0:313:f5f8:a331 with SMTP id a10-20020adffaca000000b00313f5f8a331mr1555738wrs.34.1689858631923;
        Thu, 20 Jul 2023 06:10:31 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id a15-20020adfeecf000000b00311d8c2561bsm1317303wrp.60.2023.07.20.06.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 06:10:31 -0700 (PDT)
Date:   Thu, 20 Jul 2023 14:10:29 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Ying Liu <victor.liu@nxp.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lee@kernel.org" <lee@kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "deller@gmx.de" <deller@gmx.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH] backlight: gpio_backlight: Drop output gpio direction
 check for initial power state
Message-ID: <20230720131029.GB2525277@aspen.lan>
References: <20230720061105.154821-1-victor.liu@nxp.com>
 <20230720112742.GA2525277@aspen.lan>
 <CAMRc=MfbWjWTdU4ToFMp_ZV6eGdRnjD--Y+qsN329TsLFGQYxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MfbWjWTdU4ToFMp_ZV6eGdRnjD--Y+qsN329TsLFGQYxg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 02:56:32PM +0200, Bartosz Golaszewski wrote:
> On Thu, Jul 20, 2023 at 1:27 PM Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> >
> > On Thu, Jul 20, 2023 at 06:06:27AM +0000, Ying Liu wrote:
> > > Bootloader may leave gpio direction as input and gpio value as logical low.
> > > It hints that initial backlight power state should be FB_BLANK_POWERDOWN
> > > since the gpio value is literally logical low.
> >
> > To be honest this probably "hints" that the bootloader simply didn't
> > consider the backlight at all :-) . I'd rather the patch description
> > focus on what circumstances lead to the current code making a bad
> > decision. More like:
> >
> >   If the GPIO pin is in the input state but the backlight is currently
> >   off due to default pull downs then ...
> >
> > > So, let's drop output gpio
> > > direction check and only check gpio value to set the initial power state.
> >
> > This check was specifically added by Bartosz so I'd be interested in his
> > opinion of this change (especially since he is now a GPIO maintainer)!
> >
> > What motivates (or motivated) the need to check the direction rather
> > than just read that current logic level on the pin?
> >
> >
> > Daniel.
> > [I'm done but since Bartosz and Linus were not on copy of the original
> > thread I've left the rest of the patch below as a convenience ;-) ]
> >
>
> This was done in commit: 706dc68102bc ("backlight: gpio: Explicitly
> set the direction of the GPIO").
>
> Let me quote myself from it:
> --
> The GPIO backlight driver currently requests the line 'as is', without
> actively setting its direction. This can lead to problems: if the line
> is in input mode by default, we won't be able to drive it later when
> updating the status and also reading its initial value doesn't make
> sense for backlight setting.
> --

You are perhaps quoting the wrong bit here ;-). The currently proposed
patch leaves the code to put the pin into output mode unmodified. However
there was an extra line at the bottom of your commit message:
--
Also: check the current direction and only read the value if it's output.
--

This was the bit I wanted to check on, since the proposed patch
literally reverses this!

However...


> I agree with Thomas that it's highly unlikely the bootloader "hints"
> at any specific backlight settings. That being said, the change itself
> looks correct to me. The other branch of that if will always unblank
> the backlight if the GPIO is in input mode which may not be desirable.

... if you're happy the proposed change is OK then I'm happy too!
I came to the same conclusion after reviewing the GPIO code this morning,
however I copied you in because I was worried I might have overlooked
something.


> I don't see any obvious problem with this change, just make sure the
> commit message makes more sense.

Agreed.


Daniel.
