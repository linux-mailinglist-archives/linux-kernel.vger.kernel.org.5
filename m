Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318587DD04D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 16:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344875AbjJaPQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 11:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345002AbjJaPQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 11:16:29 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B37A170C
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 08:14:57 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5a87ac9d245so57051457b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 08:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1698765297; x=1699370097; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0gKaWhoWtzsS3EARmo5lX0RoQiA/z47wvED5LOnksdU=;
        b=MLkF8ypPd+iQDdw3fovCXCREbMsvAdMhwJa5uz9E8kaN9mUQ8BBSHrsvcmHapgmA9e
         +yy5pyU6Y5fCDFFBrxbp+85vo/7zMwQNmhZg3KEmeN7b78Q2fI7dSdejLcjepMs2q/5r
         S/01D2lLLMUVu1rdFundeFjbbsq2VQmOwwNarhe6+OePPy8z4iqUTKj1z3afgxYKt/5m
         0ABhp623FAamw8rtDVnYJRF2UJOUSmE96bP8y5x/nTH6l+D4nSt9aTLqM9Xw6Ib3OWYm
         5/XPzfgF4uQV08ZzEYHiTyaFRHSipqRJvhu74ipLKoeuVnEiqoglahfffzgCDeN27fDy
         YouA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698765297; x=1699370097;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0gKaWhoWtzsS3EARmo5lX0RoQiA/z47wvED5LOnksdU=;
        b=W95N5qTH1gvRKJA9dV8ygYyYR4ZFte7Fd8K325oHa0kP2eyk1J9sujQcZhc/FNCTWd
         MOKS25oCj4RjrlpTQl7PV+Pzd4jt3Etl3wP6BDlFi12UKEUocts7R/GrTgog6C+HQ31n
         r0DgpXjfgxE+ltHhCBcfkCfS8UTrr1pB1F29McrL/uUvm45cpXPbpRe6O+s1xINbi+o8
         N0Anl+DpW20Tzgep0RYpFKyjNow9bFg42I+WIlXb/OAvrHQ2HTFzodznJYmP1y8Bm9nJ
         JDXQ87XPBiqz/Ksnt1LVbByNJf2UvfaFxsgcvMfVSvXXM2wzg7nMPMyhlEv3h1whV7WE
         IkTQ==
X-Gm-Message-State: AOJu0YxH9q83Q+7hvZryZfdtL/U5jlLpDcbnp4NX+QZhUA+rViznCeZH
        hryiEnASQ9fmIBGte0HWwBBFmhaZHmPWsZOVpiNo9Q==
X-Google-Smtp-Source: AGHT+IGbCAj82cl8RYMkfyYrmUp4qmH2/qkOaLUpDIiDOdHdyiifFC3GNpTaS5AloN6xEn+nG1UqC4y/lDKWuyjzKsA=
X-Received: by 2002:a81:e301:0:b0:5a7:c4be:3af7 with SMTP id
 q1-20020a81e301000000b005a7c4be3af7mr11859954ywl.44.1698765296918; Tue, 31
 Oct 2023 08:14:56 -0700 (PDT)
MIME-Version: 1.0
References: <20231030162114.3603829-1-mike.isely@cobaltdigital.com>
 <20231030162114.3603829-2-mike.isely@cobaltdigital.com> <20231031114339.nutx2q2vtwbaaw6h@zenone.zhora.eu>
In-Reply-To: <20231031114339.nutx2q2vtwbaaw6h@zenone.zhora.eu>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Tue, 31 Oct 2023 15:14:41 +0000
Message-ID: <CAPY8ntBQ9MVYZVwndYsGNu+w8Jed727W4zCAZmVonSbRvsf32w@mail.gmail.com>
Subject: Re: [PATCH 1/2] [i2c-bcm2835] Fully clean up hardware state machine
 after a timeout
To:     Andi Shyti <andi.shyti@kernel.org>
Cc:     mike.isely@cobaltdigital.com,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Mike Isely <isely@pobox.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike & Andi

On Tue, 31 Oct 2023 at 11:44, Andi Shyti <andi.shyti@kernel.org> wrote:
>
> Hi Mike,
>
> > When the driver detects a timeout, there's no guarantee that the ISR
> > would have fired.  Thus after a timeout, it's the foreground that
> > becomes responsible to reset the hardware state machine.  The change
> > here just duplicates what is already implemented in the ISR.
>
> Is this a fix? What failing here?
>
> Can we have a feedback from Florian, Ray or Scott here?
>
> ...
>
> >       if (!time_left) {
> > +             /* Since we can't trust the ISR to have cleaned up, do the
> > +              * full cleanup here... */
>
> Please use the
>
>         /*
>          * comment
>          * comment
>          */
>
> format
>
> >               bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_C,
> >                                  BCM2835_I2C_C_CLEAR);
> > +             bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_S, BCM2835_I2C_S_CLKT |
> > +                                BCM2835_I2C_S_ERR | BCM2835_I2C_S_DONE);
>
> I'm not sure this is really making any difference though. How
> have you tested this?
>
> Have you tried reading those registers before and understand what
> went wrong?

I guess we may have a race hazard here.
The completion has timed out. The write to I2C_C will flush the FIFOs
and mask the interrupts out, so if the transaction can complete at
that point then the ISR won't handle clearing the status flags. As the
flags are "write 1 to reset", they could still be set for the next
transfer.
It'd be down to the exact timing of hitting I2C_C_CLEAR (to clear the
FIFOs and disable the interrupts) and when that terminates the
transfer. Ensuring the status bits are cleared will do no harm, but
I'm not convinced that there is an issue in the first place that needs
fixing. Can you give any more detail of when you've seen this fail?

  Dave

> Andi
>
>
> _______________________________________________
> linux-rpi-kernel mailing list
> linux-rpi-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel
