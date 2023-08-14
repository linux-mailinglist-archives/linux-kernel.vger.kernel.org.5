Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F3577BDFE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 18:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbjHNQ3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 12:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbjHNQ3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 12:29:14 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13015E62;
        Mon, 14 Aug 2023 09:29:13 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-56ca9a337caso2890548eaf.1;
        Mon, 14 Aug 2023 09:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692030552; x=1692635352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tXuX+XLRKUCBgIrTdnNUChHqV7gJDCGrxnwU80goqho=;
        b=O93rRiNUHIGp7UPWQ8raXqlVPwGmvzNLTJ6VVFT7DPJf4FXXYUzU+NdCC3Q4xAH4Nm
         4D0qUaEYTeFyXf8FMw1QknFxGAo1g92THDSigH1U+n4yKX5avGZDiwCCg+rtq3yyX7Ho
         uySX1U7J5mgiCD9CVZlfG93GOr9asSh3yEote3AgeA2isl6nQLZXwiC0HlNGp6R1yOrH
         Crn5+2tLU0CV06kvgYLrtUa0NigLVkvfhwnDTRNu4YlIZjLrcTg19i7YDjlJOAfkj2JD
         YXJ7x2SP0yshVKdzw3xVTj+s2WyxEV56WCh94XMIM3vbZwC6QUiZH5BlKbv9SdT3Yd3+
         4lLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692030552; x=1692635352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tXuX+XLRKUCBgIrTdnNUChHqV7gJDCGrxnwU80goqho=;
        b=lhNnSiNKZQoWwVQGv5M+G3G30vkhZTmsKKph4HEIFTl1OYQZ6ohEtM0yj9v83k4X4A
         8Dcw6GU2yfctIADPd3PVLKmb1Ik6BfBWwtAUHuzRgaO+XQCMpj+bMg7R26GfG2QNNRra
         2NQlbp/h0vin9Oz6ZPv80WUQAtGG8ZKWdlUbFxb1tHHXXA0wNC7tg3g2sZEXTkyZ2QxG
         /1TL+6bA0xnt9+tDxPyzxrZJ5oUoUMmpTYBW3wsHcD/A18YiEUKA5y8swaMHXuZljqi5
         qthiEiG0GuDr9hn030n5dUZ3WMSCC8B8lndm+v6i9TpMwmLXev6oNKfuvETEX1ldkDJ8
         cxrw==
X-Gm-Message-State: AOJu0YxpKrA7hJ3suuhwbc95waIgGYIIiyTWrORJpnxhOXMJMU58LfO3
        j02Q11uWUVl8QMIuaLsHHQhaDe9CMvu0uLpWnK8=
X-Google-Smtp-Source: AGHT+IFfsfEspUV/yyJ4fUAH0At+LumMzcsJGFpuBW6E5OIqB88Izk3HskeP8Q7r63VL+8opDj0rmpx7BK3iBn8SAj4=
X-Received: by 2002:a4a:2a1d:0:b0:56c:e747:4609 with SMTP id
 k29-20020a4a2a1d000000b0056ce7474609mr7457520oof.7.1692030552269; Mon, 14 Aug
 2023 09:29:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230814112615.42448-1-andriy.shevchenko@linux.intel.com> <CAMRc=MfhoeMfC7gAcKioKpkCA1jykyqGSH4vg7Hpu9bb=yeGaA@mail.gmail.com>
In-Reply-To: <CAMRc=MfhoeMfC7gAcKioKpkCA1jykyqGSH4vg7Hpu9bb=yeGaA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 14 Aug 2023 19:28:36 +0300
Message-ID: <CAHp75VdLuj1UZB+UqfvkrBUreT6NdFY5xrXASncinj-_XVqEbA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpiolib: sysfs: Do unexport GPIO when user asks
 for it
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 7:13=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
> On Mon, Aug 14, 2023 at 1:19=E2=80=AFPM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > It seems that sysfs interface implicitly relied on the gpiod_free()
> > to unexport the line. This is not good and prone to regressions.
> > Fix it by explicitly calling gpiod_unexport().
> >
>
> I wouldn't say it's prone to regressions, it's literally just that
> gpiod_free() should not deal with sysfs.
>
> How about that for commit message (I can change it when applying):
>
> It seems that sysfs interface implicitly relied on the gpiod_free()
> to unexport the line. This is logically incorrect as core gpiolib should
> not deal with sysfs so instead of restoring it, let's call gpiod_unexport=
()
> from sysfs code.

I'm fine with it, go ahead and apply with the change. Thank you!

--=20
With Best Regards,
Andy Shevchenko
