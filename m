Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C207FF8C6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346630AbjK3RsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 12:48:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjK3RsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:48:11 -0500
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E3710F1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:48:17 -0800 (PST)
Received: by mail-vk1-xa2f.google.com with SMTP id 71dfb90a1353d-4b2a47fc7a3so220442e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701366497; x=1701971297; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oAqtBHG2ahPg5et0K/yKBX8zslm3S7ar5aqhS7JNnys=;
        b=a23VC6LJ7xky3km6XILT2ffBS39z2zuT6/FPuDsKKLKvNsbABtyNHQZ57RfCOZGadd
         v+vjLsALhcK99PuKkRnwPxmsE2YRqYLo/Zx607Rs+wO9U0GN4cHZwtY2KOcuGszSzaXC
         PqII604hCcXRKZ2KEVc7YvZv0av8mQvphK5VJvt6b/iYapg/Q0R35mCHv6bsGhxMoDyl
         NGCJxBBKF1pxgnTlNLGtG3lZsIMR9+tCIBW+8D1tOKBGYUaUDI65B7R3yuLtHJUNWcHM
         WYfUBhrqLRRjxVuTp6qvwzmKfy0bByWofl7ORdk5e/Anv7G42ft1IrrUw0SqzzZURJzJ
         8WuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701366497; x=1701971297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oAqtBHG2ahPg5et0K/yKBX8zslm3S7ar5aqhS7JNnys=;
        b=eW3yCGf/nzTlQnTABeAXDQ6YYBGlTuqrNcBZTTRWo09PyC195H7kdEc/QKr62cAbDa
         /3/z9kQ24qyaDTchvA/b5e8QZt3z7WlujqGjSXOPgCHD8r17pULLjaJGlzU0crFchoxB
         mpnxSpZSoRxO6qw6hBWlt0y+tCWkxTZgBdYWPWTrKsrya33AM1DQv0XPy1ZouEO69F5Q
         PLZ9LVs8FMmz95TVGw0P2AnS+zmXubd7o4NOZN8KtEUMptFfBxU1MatiNYxXAjDV6DMc
         xDomKdx9ObHJhB/s0K1byqx4Md2LYXER6F65a9hO8aD8Jr90yj8yY/FPbweE3/RgZANc
         v4Rw==
X-Gm-Message-State: AOJu0YzLula9kiaBHsq3nn2rKW7+ScKyyeZWnw0oRVdJtmPtGj/9dzlj
        vVKPHaDyjoN8QcJXooZxUo+TUcM9uJDLHMJO+xgA7A==
X-Google-Smtp-Source: AGHT+IF2+CmHFYiITNPkWwNX+XZDajoQkvaNMM0+I3x0956b2qIpjPDXTvMJ9Il6fvgxD0jQwOlna5HS4Im1nwmUfOM=
X-Received: by 2002:ac5:c301:0:b0:49a:a773:fe80 with SMTP id
 j1-20020ac5c301000000b0049aa773fe80mr20894517vkk.2.1701366496935; Thu, 30 Nov
 2023 09:48:16 -0800 (PST)
MIME-Version: 1.0
References: <20231130134630.18198-1-brgl@bgdev.pl> <20231130134630.18198-2-brgl@bgdev.pl>
 <ZWi34tkzNsvkCQqi@smile.fi.intel.com>
In-Reply-To: <ZWi34tkzNsvkCQqi@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 30 Nov 2023 18:48:06 +0100
Message-ID: <CAMRc=McLyT9h=VGPwserUgwmXOtNx4k2Za7j8VEwAqu7ChXZzQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] gpiolib: provide gpiochip_dup_line_label()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 5:27=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Nov 30, 2023 at 02:46:21PM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > gpiochip_is_requested() not only has a misleading name but it returns
> > a pointer to a string that is freed when the descriptor is released.
> >
> > Provide a new helper meant to replace it, which returns a copy of the
> > label string instead.
>
> ...
>
> > + * Must not be called from atomic context.
>
> Put the respective lockdep annotation.
>
> ...
>
> > +     char *cpy;
>
> So, why not naming it fully, i.e. "copy"?
>

Ekhm... let me quote the BigPinguin :)

--

C is a Spartan language, and your naming conventions should follow suit.
Unlike Modula-2 and Pascal programmers, C programmers do not use cute
names like ThisVariableIsATemporaryCounter. A C programmer would call that
variable ``tmp``, which is much easier to write, and not the least more
difficult to understand.

--

Bart

> --
> With Best Regards,
> Andy Shevchenko
>
>
