Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5157EC008
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 11:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234836AbjKOJ5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 04:57:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234675AbjKOJ5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 04:57:44 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7C7C2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 01:57:40 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-da41acaea52so6750196276.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 01:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700042260; x=1700647060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gxy7nTYceeIMGjEVGQxX/YT9AqCUKCeE9lgm8uccCT4=;
        b=GpBNnTh67xn3DZXYOiGI3j2GwFNXk+1CZo4IQtku6U2v6Cef27OUTRQd1yOdJcE59n
         chrNlNf8V5qhpECroLq07tZ86J4yTZzMLd4/9DYDcUnJ1V3gUP7szw5HyecJCgO9qXFc
         YDi4j+/s3hwCUhUS5vFQERuReSlxZ/sa0eOHsfVLtRjh2Btb6jqE5UioEhNAMRb+1a2d
         3Tu8uBl+MtnTO69ZLt4LTmBkwwX23qlTeSAyvMVdxIoul3oHJwD6vl0rk5dbKSa3AY2S
         pn7nGheqm8Rl0JzpNxdsReH+LC9fM7eyzkz6tA6LT9fQ/b4zRb4EQosvzq4Cqj5O+iVG
         Ilaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700042260; x=1700647060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gxy7nTYceeIMGjEVGQxX/YT9AqCUKCeE9lgm8uccCT4=;
        b=Wici80TeboVk+abkI4zg5egvIVAV3cVwHYpIJEp/8oP+L27SEuHy6ju6bi2Mtx2EY0
         mnV0GYpLDy0Qw6fE7VlaodEfQ2ubhpiv+YvWFEoI+t43r5l5miCsUN9eNNp/7wVBKU4z
         fI9sNzgLjOXLV5FzwC0GRPP/I1J61l4SrQj1iBPmIcNdf4vzXYHhy7BJjDVSg1Oxedyg
         AL83JdwXwkW6fbyKhalNLwu69RZH/AN8UkAI7a2Up61tlYS0sGaCyTe8UbLaW4JQc0Of
         jPr16LUqaVKVAR0dQvN10HSySxFDFKWksRHKwSHzgz54RvC4/oa2i6rix5y23/CjZZsF
         nVgg==
X-Gm-Message-State: AOJu0YxnM8KmKtehNxO1e9ktrc9qHcbhAt/Q4ENkTXknaX7q0PzQ0dPs
        GLexNdQx/+W2RMAjk4i35zEOBa/sH1lV3MH7oM3PGeU1lO6oHtJ4
X-Google-Smtp-Source: AGHT+IE8l72Zgp6nDJmZC+s4rfzTpiWGu51MgRFVg3gT9ebkkrIspH3XlMc+cp/SAkSZhKB7hoQkq9kBvgdARepxof0=
X-Received: by 2002:a25:b199:0:b0:d9b:417:139c with SMTP id
 h25-20020a25b199000000b00d9b0417139cmr11369274ybj.60.1700042259999; Wed, 15
 Nov 2023 01:57:39 -0800 (PST)
MIME-Version: 1.0
References: <202311071303.JJMAOjy4-lkp@intel.com> <CACRpkdb4d9pfstqDTZoBSqOSS4d4vLOUCnS6AKcMjLZ8TTQ2Wg@mail.gmail.com>
 <20231115093742.GA32655@ediswmail.ad.cirrus.com>
In-Reply-To: <20231115093742.GA32655@ediswmail.ad.cirrus.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 15 Nov 2023 10:57:29 +0100
Message-ID: <CACRpkdYHJcx8gDsa5P2eLBh6iaVQzZY+-4eMJPKtnQTq3uR6oQ@mail.gmail.com>
Subject: Re: drivers/pinctrl/cirrus/pinctrl-lochnagar.c:52:53: error: pasting
 "LOCHNAGAR1_" and "(" does not give a valid preprocessing token
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     kernel test robot <lkp@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 10:37=E2=80=AFAM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
> On Tue, Nov 14, 2023 at 02:40:38PM +0100, Linus Walleij wrote:
> > On Tue, Nov 7, 2023 at 6:19=E2=80=AFAM kernel test robot <lkp@intel.com=
> wrote:
> >
> > > >> drivers/pinctrl/cirrus/pinctrl-lochnagar.c:52:53: error: pasting "=
LOCHNAGAR1_" and "(" does not give a valid preprocessing token
> > >       52 |         .name =3D NAME, .type =3D LN_PTYPE_GPIO, .reg =3D =
LOCHNAGAR##REV##_##REG, \
> > >          |                                                     ^~~~~~=
~~~
> > >    drivers/pinctrl/cirrus/pinctrl-lochnagar.c:67:9: note: in expansio=
n of macro 'LN_PIN_GPIO'
> > >       67 |         LN_PIN_GPIO(1, ID, NAME, REG, SHIFT, INVERT)
> > >          |         ^~~~~~~~~~~
> >
> > I looked a bit at this, can this be due to the fact that the macros use=
 defines
> > from include/dt-bindings/...* and that MIPS does not use these includes
> > somehow, such as not using the same dtc compiler?
> >
> > Rob, do you know the story of how MIPS interoperates with <dt-bindings/=
*>?
> >
>
> Is that what is going on here? I though this was the long standing
> problem that MIPS has some global define for RST so the macro that
> string pastes that in, no longer pastes in the letters RST but some
> value instead.

That sounds plausible :D

> It has somewhat been on my radar to fix at some point, but I have
> in general been a little unsure how to proceed. RST feels like
> a mega over generic macro name to be exporting, so in some ways
> feels like fixing that would be nice. On the other side, renaming
> the register on the Lochnagar side would be very easy, although it
> would mean the register naming no longer matches all the hardware
> documentation which would be kinda lame.

If MIPS breaks things like this because of weird defines I would say
it is actually fair to just quirk it in Kconfig with a comment:

  # MIPS occupy very generic defines
  depends on !MIPS

Yours,
Linus Walleij
