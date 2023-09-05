Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C8979245B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 17:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjIEP6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 11:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353921AbjIEIht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 04:37:49 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCEEACCB
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 01:37:43 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-450711d9bf1so65858137.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 01:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1693903063; x=1694507863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mpHFtm2THaSdixGrwHLfve5bKSsogpNgznR46/rAI8Q=;
        b=LK355mLUVlYWcVLJYzOKbCwA/c6MjFh6VpoiGz6b2DnKuzyefwo1Wv5cRvK8e75/kI
         AwHxuDc0jw+yBfN+AowhfneCMSigF1XX9y87d2PAgcLq6MOA4RtZtfwPMNamcPZxRmmJ
         xpizx0/J/D1pWZl89n7bkbixNq6A73lvoPeN0S18+zXGVTX0oGuFPTMaFKjHq5QkKks+
         xau5dvJ6U3DGa8Nm+JNmoLVvHvjinnRabyhVuGv2w1ZJWSJKUjd6ZLFNwopjNYvHpTQV
         DmeV2ZkThHXCfB9Ge8RCYvulwYy62+vP8sh0e58YgHOMjFoevG7CPWd0Lm5lOZ8+SAzs
         qSng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693903063; x=1694507863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mpHFtm2THaSdixGrwHLfve5bKSsogpNgznR46/rAI8Q=;
        b=J/pOYvbTRQHzXA78QkBNAEIW25kTpTlJcZPmahKY9KZNo75JfSftfeYSvfrVZw6ltx
         QvTcp0DTIriYHSI4plj4HZSZ1SQAWDBT6d41lYo9zGl9J0Cxf2CyxhAcCpF2tl7fO42p
         x56loxuBmJiuzUmqyZD19FyEsntNKGCvhky/Ecm95dqnsdbPOPYjXAsNuukrlHKQm7/v
         t/TkzWpViOWNnuNRXOE2lFZqlVJuvgPdHuDp5CbJbo9V7PsHyQOXMAd9gdzOCEThNcd5
         XHpA2ushK1sxW0AeR3yLKy6V/iLNbENs/MT8LaxFzt0cVpgGQmqV55p2lL0Rg1LC3EE0
         xnmA==
X-Gm-Message-State: AOJu0YyZKcutwOPnupQNzKtzYd82ORmWNutYziOeehM1ptwPp5ilhzps
        FND1QvWab/8dCreQUhurngL+HqbFd4jw1R8ywftkNgn/iFwq5UEMieo=
X-Google-Smtp-Source: AGHT+IFZqQ6NUVEHdjCmDa5Gac5UutlTevVj90aTgLVjwaCXFeHZRN+XSXCgpz0qM5EyEULv6okfGE7VoUrVAqweOQE=
X-Received: by 2002:a67:e294:0:b0:44e:ac98:c65f with SMTP id
 g20-20020a67e294000000b0044eac98c65fmr12293123vsf.21.1693903062895; Tue, 05
 Sep 2023 01:37:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230904073410.5880-1-brgl@bgdev.pl> <20230904073410.5880-2-brgl@bgdev.pl>
 <ZPWjAUzqeAwF1wro@smile.fi.intel.com>
In-Reply-To: <ZPWjAUzqeAwF1wro@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 5 Sep 2023 10:37:32 +0200
Message-ID: <CAMRc=MeMYi0KbK=1RYGX2zbUjVZyQp-Y_aXfy6+EZcEtUSEU0A@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpiolib: rename gpio_chip_hwgpio() for consistency
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 4, 2023 at 11:27=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Sep 04, 2023 at 09:34:10AM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > All other functions that manipulate a struct gpio_desc use the gpiod_
> > prefix. Follow this convention and rename gpio_chip_hwgpio() to
> > gpiod_get_hwgpio().
>
> Same comment. Also, I don't think it's good idea as it steps on the expor=
ted
> API's toes. I.o.w. I won't mix those two.
>

Even if I agreed with your other comment, gpio_chip_hwgpio() is a
terrible name and if I didn't know, I couldn't tell you what it does
just from looking at the name.

Bart
