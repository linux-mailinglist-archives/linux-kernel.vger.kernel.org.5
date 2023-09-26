Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B547AF28C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 20:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235349AbjIZSXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 14:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjIZSXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 14:23:12 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E4EE5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 11:23:04 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5a1d0fee86aso44260327b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 11:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695752582; x=1696357382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sI3UkHqqf5WmbgSUGSm/14gRHcG/M3RotLOAmkRjLvo=;
        b=OFvQWgIcbTGASZICkY/Qt14NYxXBk9XsM6Q5o5grXFWDKk9n10eTWBYIJEeDYsfbz7
         6uQpfI7voVHvrCsMt26oOIjiERbznX2Rwr2yVSLxhitq7mA4Vfh5ItGSKMUWIUPJGB2v
         P0PcBNvnJKFUrj3NM7UkAlqP0eM1MtRiMWm5lr518R07m8u1j2JB/JK1AZEANdqxFiGs
         TIYGWhscnn8+LxHklyf3SymjrAr6G42H9dgZwXPVkgYoyQIgOiYiaQD5mK5OP51i9SkC
         +ZHlQ2KyA6QZVtwDjDk/JpG1h/lx4h3vFYkeN6v0FOtYENocc0sHdKlKy/jF38RxLtbX
         g06w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695752582; x=1696357382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sI3UkHqqf5WmbgSUGSm/14gRHcG/M3RotLOAmkRjLvo=;
        b=MBrp8hgw2pJUMNwE2fL/Jeh0gR3sti8L3dopGys2Ds19VB3S3rhOZ1DW4IVA8FsdNy
         AwKoeypGxcQGbJA4m4Ad5SOj2Y6X2SthoyeNKm5r/cBaz2olPopUOX/9NjoPYgT4Oe+Z
         igYA+7ABXXpElLl/GXqqWH/7aSEQ2SPiIEvhTKXXqld991v+FLB8qjwF9fAoK1mfbXly
         4xu7PlxfGME4dQeVdgRnP4yKYbj/P5wGaVkWOQuhhylOm3uZ3MeFO91DjauPYHm8a7ZV
         Vx5pILbBN5yr4nTwl6dsJ9FI3vZn0HVt5xdiafboG4miQALRUX3HzyIsMbzk1N7fYpll
         MCfg==
X-Gm-Message-State: AOJu0YzNNF+rvUsNaxOFl0HnZdsUqOtXEgkU1KLEaGMTSeFBfk26fxeH
        Vs4jiA1ZKxdN8L1zMrZVLdDzL+IYZlOHuBQsi9kxjQ==
X-Google-Smtp-Source: AGHT+IE0yNG+tx7WImPxoj9f0KRcQ53cWmJ0g3FEAxxLPaxWmKXC5eVpm9tXntm6ZtPdG8k3kmVG86uNIr+Y8eKDWDg=
X-Received: by 2002:a0d:c7c3:0:b0:59b:ce0b:7829 with SMTP id
 j186-20020a0dc7c3000000b0059bce0b7829mr10211941ywd.35.1695752582691; Tue, 26
 Sep 2023 11:23:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230926132336.416612-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230926132336.416612-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 26 Sep 2023 20:22:50 +0200
Message-ID: <CACRpkdZ2P7zeoRMwR=u84L_aysK2VOwVLNjFnTxvGNswd6DArw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] pinctrl: intel: Simplify code with cleanup helpers
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Raag Jadav <raag.jadav@intel.com>
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

On Tue, Sep 26, 2023 at 3:23=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Use macros defined in linux/cleanup.h to automate resource lifetime
> control in the driver.
>
> While at it, unify the variables and approach in intel_gpio_irq_*().
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Actually this is the best part:

>  drivers/pinctrl/intel/pinctrl-intel.c | 136 ++++++++++----------------
>  1 file changed, 50 insertions(+), 86 deletions(-)

So much easier to read the code, and lesser risk to do mistakes.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
