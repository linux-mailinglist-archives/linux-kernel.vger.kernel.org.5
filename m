Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82BC3786BC6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 11:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240480AbjHXJ1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 05:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240586AbjHXJ1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 05:27:16 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2160EE7F;
        Thu, 24 Aug 2023 02:27:14 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5650ef42f6dso3788689a12.0;
        Thu, 24 Aug 2023 02:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692869233; x=1693474033;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YCJxx8nS8psFBLHIQzPylAv2ndtj0TQX7xYwOgZPKtc=;
        b=ocSBofdYuOj90ym2+Q+zmx8fd/drVOxVJGaOq9ClLnkqzJw0DhRKgRTPp05Db9X2a7
         VAVubO48ctNfiTEAECa5punamDsG60rNKn4fLgOqbhlUufNKaKa+MSr26oesjbT1urUy
         7AXwT8rRpYb3faSy9yTDy6P0AwsU/yQDS9dNEWYAI+8i8aWdgv5hqPCFNlEo9Y3HlOkV
         oLHNch4SwosC+1h9hjcL2FZTVZTZqByRISGZ42ElSNigNR/5P+vQikem2XkolRLWudi5
         bx5gk5QCXnhP/rfiHpffCqsaDy+DZfSRSwg4KMpw1AFTjHUoR/Btv5o140q6dU5ciZms
         6/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692869233; x=1693474033;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YCJxx8nS8psFBLHIQzPylAv2ndtj0TQX7xYwOgZPKtc=;
        b=A86oipBF1U03pM7J1ytTqQKoOuI3w8BxVl5agDA/3E71KI+Kfl+PyUMDaHOW+RGaxr
         uo/oGE93tYBfuSXZbEyEtx+l0URauwW1r8Ef+PhEJ5TNGv9eERdsUL4PmRs38fmuDfdC
         YIEmm6k9DZwzMnAqG0Ow7p+r4sGzeEB+jwyJr7vMChxowmkHx0wBbLlOW5eFEx8a01Xw
         7mEzK9g1LYZyoRCMiccB8k9SC1yOvEqKUgJSTGCaNR93/87VsjVCw+D8/nmzTPO0s18t
         hEKD3OlsRsYA8ViFMJeVsjSP7SzCc1wVxZdXMFOZiDAYJHmJJexXYzCgEX8Ua3HsguGk
         io8w==
X-Gm-Message-State: AOJu0Yxz1AsZx9ooFTl3KL24gfiGoGYaMGPNk3pOv9mCRByV9QG5x8Vw
        lFzWOCFfd5/NRMr1EVpya3U=
X-Google-Smtp-Source: AGHT+IHWsEA0kSxvIM4rigneafEk0G4/sToXQ5h9CDArPSfz5uv7pAB128eZqyAdMgPy6pCQo6pF+A==
X-Received: by 2002:a05:6a21:7906:b0:13e:e450:f4c9 with SMTP id bg6-20020a056a21790600b0013ee450f4c9mr12203280pzc.44.1692869233468;
        Thu, 24 Aug 2023 02:27:13 -0700 (PDT)
Received: from sol (14-203-61-235.static.tpgi.com.au. [14.203.61.235])
        by smtp.gmail.com with ESMTPSA id z12-20020aa791cc000000b00682c864f35bsm11019794pfa.140.2023.08.24.02.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 02:27:13 -0700 (PDT)
Date:   Thu, 24 Aug 2023 17:27:07 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2] gpiolib: notify user-space about line state changes
 triggered by kernel
Message-ID: <ZOcia3Nt+SzypTGm@sol>
References: <20230824085544.110417-1-brgl@bgdev.pl>
 <ZOceEeBuX+Nh7DJo@sol>
 <CAMRc=MdEqm2U9AfPiw5kerJpB1hXyvEQ1_m7EhgoFZ+G3UyDAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MdEqm2U9AfPiw5kerJpB1hXyvEQ1_m7EhgoFZ+G3UyDAA@mail.gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 11:11:18AM +0200, Bartosz Golaszewski wrote:
> On Thu, Aug 24, 2023 at 11:08 AM Kent Gibson <warthog618@gmail.com> wrote:
> >
> > On Thu, Aug 24, 2023 at 10:55:44AM +0200, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > We currently only emit CHANGED_CONFIG events when the user-space changes
> > > GPIO config. We won't be notified if changes come from in-kernel. Let's
> > > call the notifier chain whenever kernel users change direction or any of
> > > the active-low, debounce or consumer name settings. We don't notify the
> > > user-space about the persistence as the uAPI has no notion of it.
> > >
> > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > ---
> > > v1 -> v2:
> > > - use the gpiod_line_state_notify() helper
> > > - reorder the code in gpiod_set_debounce() for better readability
> > >
> > >  drivers/gpio/gpiolib.c | 16 ++++++++++++++--
> > >  1 file changed, 14 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> > > index 40a0022ea719..1cb7731550ca 100644
> > > --- a/drivers/gpio/gpiolib.c
> > > +++ b/drivers/gpio/gpiolib.c
> > > @@ -2439,6 +2439,7 @@ int gpiod_direction_input(struct gpio_desc *desc)
> > >       }
> > >       if (ret == 0) {
> > >               clear_bit(FLAG_IS_OUT, &desc->flags);
> > > +             gpiod_line_state_notify(desc, GPIO_V2_LINE_CHANGED_CONFIG);
> > >               ret = gpio_set_bias(desc);
> > >       }
> > >
> >
> > gpiod_direction_input() is called by cdev when a line is requested.
> > So requesting a line now creates two events - REQUESTED and
> > HANGED_CONFIG? Even worse - it calls gpiod_direction_input() first, so we
> > will get CHANGED_CONFIG then REQUESTED??
> >
> > And a config change from cdev can call this and then generate a
> > CHANGED_CONFIG event itself, so again double events.
> >
> > Same for output and probably debounce too (that one is a bit more
> > convoluted).
> 
> Ah, should have tested it with user-space too...
> 
> Back to the drawing board I guess. May be the reason why we're not
> doing it in the first place yet.
> 

I think we were only looking at it from the userspace PoV, so what
constitutes a "change" is only well defined when driven from userspace.
This might be difficult to generalise without redefining what
"changed" means, or providing cdev with a separate gpiolib API so you
can tell whether the change is actually part of a cdev request, or ...

So, yeah - more thought required.

Got a use case that requires this, or just a nice to have?

Cheers,
Kent.
