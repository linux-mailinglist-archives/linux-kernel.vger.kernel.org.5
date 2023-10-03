Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555FF7B7089
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 20:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbjJCSHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 14:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbjJCSHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 14:07:21 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1940AB
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 11:07:17 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-7b07719089aso59432241.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 11:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696356436; x=1696961236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=spqZVsBujegTMECRyErnNVqu+/Sb3b314/OUAZHjeek=;
        b=S0R+pnOK5D5AHGC51EnkOmGydLkV7ElJBHaetocfQZWI6FdebpC2kFaOT5/4Zivqny
         Hnu/InqUnv7uFLNzQbN9YupouYK9GATO2B3gKmgwdTwExB7is/+0mQc4yBb2u7D/h0v3
         KxhyQybrIKHjB7dfNXLlh026HdpB1erha7xX19dHsqMv3ReUIOKbfussr63inWDxfAI9
         R0UavBpL7o7MLwST2AzRJ9E7x/dNezb6EyqMnui5KlElIROLQ3zAOYz9yDjigVBz16RQ
         lCc1m/CbkyUcI3U773HR5aGpdEEQrDSOKHwkQsEAIq2hLerw9Hdbt5Imw+fYQnuYQFd1
         yZpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696356436; x=1696961236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=spqZVsBujegTMECRyErnNVqu+/Sb3b314/OUAZHjeek=;
        b=Mgat5b9KBlJczJmJVgXYmRsG/ygvoDxtk+Xh4HXED9irbcIpDroM1nmbA/yZFFkfcd
         tpnqTOo4upDy+XnfSFyZHxODbscXJ9N6Fn2wJ/99j/bVH7m9AmfSkkhQY7b3yRsYhQk1
         tbJ+ttLaepX9rVq6CQR7alTIjVNsVYoVrtq3bcBAJK6Iy3+23glfRi7/A2m6z3p9NJXg
         QSgeF38H76I/0a/oXk3x+gc2c3Y6Bs/FX589h7Ywu0wFKmgAKgVZwJ+D7mRQesQf0pcW
         lsVfIFKNf/IaAU6aSJzMAMg9chVrdSRd3JcNC9/QAfhZGf7J4FjHol0S5hMjNfyAe1lt
         R3RQ==
X-Gm-Message-State: AOJu0YzdEMOagDk8cIPPK+Gm8naV+7Oz7dg+QlVdvArzd9JDBLYblLbF
        lfawwoILKtBKsdWBkNg7VmnfU3o/dNNPk+dqBX718w==
X-Google-Smtp-Source: AGHT+IG79PPCrg9tom2aZQSDFTD1Yxtt7fGsILxaaoCGIUlTKy1HoGYcVOia05h8Sk+cKuel02Ymb8+vijQg9771EcA=
X-Received: by 2002:a1f:dd02:0:b0:496:187e:b33f with SMTP id
 u2-20020a1fdd02000000b00496187eb33fmr5035vkg.3.1696356436696; Tue, 03 Oct
 2023 11:07:16 -0700 (PDT)
MIME-Version: 1.0
References: <20231003145114.21637-1-brgl@bgdev.pl> <20231003145114.21637-5-brgl@bgdev.pl>
 <ZRwtEG1DamMLZC/3@sol> <CAHp75VdSDart2b+_d6_9E204JYa2zyFKdh_Pey6Wb4MZ-Z-L0Q@mail.gmail.com>
 <ZRwyG80u6nIf7PGU@sol>
In-Reply-To: <ZRwyG80u6nIf7PGU@sol>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 3 Oct 2023 20:07:05 +0200
Message-ID: <CAMRc=McbWU+bPph7f6treqNmqJvakj8nLzNEJPjgb8tbG_pWxQ@mail.gmail.com>
Subject: Re: [PATCH 04/36] gpio: cdev: use pinctrl_gpio_can_use_line_new()
To:     Kent Gibson <warthog618@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 3, 2023 at 5:24=E2=80=AFPM Kent Gibson <warthog618@gmail.com> w=
rote:
>
> On Tue, Oct 03, 2023 at 06:17:27PM +0300, Andy Shevchenko wrote:
> > On Tue, Oct 3, 2023 at 6:02=E2=80=AFPM Kent Gibson <warthog618@gmail.co=
m> wrote:
> > > On Tue, Oct 03, 2023 at 04:50:42PM +0200, Bartosz Golaszewski wrote:
> >
> > ...
> >
> > > I agree with the change in principle, just not comfortable with the n=
aming.
> >
> > +1 here. I proposed some names, have you seen my comment(s)?
> >
>
> I have now - any of those work for me.
> Whichever is consistent with what we are using for gpiochip functions in
> gpiolib would make most sense to me.
>

Does it really matter? It's not here to stay, it's temporary and
exists only until the whole series is applied - which given that it's
limited to gpio and pinctrl, shouldn't take more than one release
cycle.

There are plenty of examples of this naming convention for temporary
symbols - there's even an ongoing effort to replace all .remove()
callbacks with .remove_new() which will then be changed back to
.remove() treewide.

Bart
