Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E390878FAB1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 11:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbjIAJXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 05:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjIAJXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 05:23:03 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7221980
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 02:22:45 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id 71dfb90a1353d-48d10c504a8so673913e0c.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 02:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693560165; x=1694164965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qTzp72FaKt5+/KYDM8z5KPWPzrLcXSZRzOQh4gdj+Z4=;
        b=DKP0jPhDppKBefv24NPt1TH7Bx/GTyNnCz/Lfa4qd3pbbb4ci7qa3vcBQmpOXj/qQs
         jUJIJykTD5DBQyi71dyR6IacsV1HJdYlNC3+rcl5ycFP8O2SNQK/riQmA+xzIkSLtEiB
         1MH57j9JO4+Y0RnOriTG9F+ZsVc3hFqixrHL5NYovhBNAqPaOVO174BXm85Rm8Pv8ChN
         Vav0h3rvr2OvyhWeyYR1Y2CbPRstDbtPRi7BBwXCCezLApdShfZaT9Tf7rZ08tPK+auw
         O8gaw/Hzu2krxkgBbgCaRKIzrNRyEwcW0mmeosBERobsV5EnYFIE9YjqfIdF3CbWyM1r
         LpOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693560165; x=1694164965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qTzp72FaKt5+/KYDM8z5KPWPzrLcXSZRzOQh4gdj+Z4=;
        b=U//rlyc2Rmx/BC6rBgMSoTXPfa9RbW8JyU1PkYZQK5qBncpWV8JWRtVbZ8xUBMZqtP
         c2HPoX2loU3b0cIRdqySOvaVkc+/a+FurCh9o1f9rlMwMYBTln72ImkPgelUHW7ne3I/
         Vrgc5WT0mHmgN4R3bXqv/Kw+ydzI8NpD+taQ2gyWjy0m4gd99FryB6R5+mSImJXLcGXU
         8mZ3Nm38CniuG2mLg5QZ7LbR5C6C61Y42pJeuCkySrNoFFDyBde8B0d1iExum8EUTnkV
         kHje6ZCYKHGet3UZlNbEnKc5VwhrCqhdN2g8xsVosg6qfbMxHYIbCP8OHFzMML+EdEVh
         Ye+A==
X-Gm-Message-State: AOJu0Yzn28DU1CQpoEpYUvW8XX4Epdnv6ElP6wzU4iTlbP6Z01XBBXDn
        zhycRDAj/szD6qZkVSOv8f6XozIjRmHjnoHiEbx2IA==
X-Google-Smtp-Source: AGHT+IHgf/l7rJMgcfAQ+Vq3h78H7E8n/a6xIfzX4cXBx29aryy4DTZC33H/caPyyuOBKvHszof11uB8sFAE/YnDh9U=
X-Received: by 2002:a1f:cac7:0:b0:48d:eaa:45cf with SMTP id
 a190-20020a1fcac7000000b0048d0eaa45cfmr1973675vkg.1.1693560164877; Fri, 01
 Sep 2023 02:22:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230831194934.19628-1-brgl@bgdev.pl> <ZPEhS0uBWABpaE+/@smile.fi.intel.com>
 <CAMRc=Md-6i+nqDtYiUUtZExA32c0nJxhevYsiZqmd1PP8aaMng@mail.gmail.com> <ZPGnFHgtK1wE6Ppf@smile.fi.intel.com>
In-Reply-To: <ZPGnFHgtK1wE6Ppf@smile.fi.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 1 Sep 2023 11:22:33 +0200
Message-ID: <CACRpkdbGdCFb9a5bV_aBMd3eee3N5EdWy+Bkpct-YfHUgHysVw@mail.gmail.com>
Subject: Re: [RFT PATCH] spi: bcm2835: reduce the abuse of the GPIO API
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Lukas Wunner <lukas@wunner.de>,
        Mark Brown <broonie@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-spi@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 1, 2023 at 10:55=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> > I'm not sure this is a good candidate for the GPIOLIB quirks. This is
> > the SPI setup callback (which makes me think - I should have used
> > gpiod_get(), not devm_gpiod_get() and then put the descriptor in
> > .cleanup()) and not probe. It would be great to get some background on
> > why this is even needed in the first place. The only reason I see is
> > booting the driver with an invalid device-tree that doesn't assign the
> > GPIO to the SPI controller.
>
> Maybe Lukas knows more?

He does!
The background can be found here:
https://www.spinics.net/lists/linux-gpio/msg36218.html
(hm this "spinics" archive should be imported to lore...)

Yours,
Linus Walleij
