Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220127FDBC5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234767AbjK2PpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 10:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234202AbjK2PpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:45:17 -0500
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAF1D4A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 07:45:23 -0800 (PST)
Received: by mail-ua1-x92f.google.com with SMTP id a1e0cc1a2514c-7c450055f7aso1851532241.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 07:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701272722; x=1701877522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L6jMs2Axo+LfFoaIsfa4QKnclPqL7Dul1t/4aJ0KGYU=;
        b=GWxpmhzkczvo8ZUOem+a3KISEsNCtCF0m63AAgJgXJj6m3feH/lWVYlFDmzZhDPoz1
         3e4gnCnOA0Vmd+lD77NL+WC+KiYh4hlTs0BB2RaY6n8POZfiyPAXb8sYXCynV/LBPGj3
         /RKGNDuG1bt+f1hDgp676lAm5yBm5N+xcg1EN9pYH6NMOT3yWSpjG0f4WOnmDG2DRmww
         IPPMMmPCjesUwk1bEmSn+n/827aDBF8HRbtyLfLOJBudI1BTtuIz3JDnuu/d5fkV3xil
         gw5qR5prJRw+GeLjc3ULB9MeTIBAwil7AdSh5FXlKMCq/zBg/Peg6zVvQWnwFEyJPZ25
         rgOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701272722; x=1701877522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L6jMs2Axo+LfFoaIsfa4QKnclPqL7Dul1t/4aJ0KGYU=;
        b=XX/S4/gFjdXsVE5fsRxJp/2BuWGaNPTTCFrQvOs9hPbCZCF1tLd0KCNad2XBS2hbzL
         LyGj1TxZJe7kVfthP4yy0E0UeCNZYtk+FP/vJnpNHs50t6MSreTWyH2ElbeczA2sX+gl
         NVa1as8vR81bvn5X8jIQi3f5Zxy79W9lXP3w13mMNQyPYz/+FrmeyigiX66YPBFnqwup
         H3zjFvS/0hBgUAQ3S2qrSnxX6ndox2e3GBzqRHf8YwxTt7x24H8nmPjVbPqrQ1qcuUk9
         lIN4ktl1IXNXVzff0V2yOrMbV+1gfhXQ+G7tr1xL5CqnE7jf22S+Cspv/WDVYVO3Z28S
         F84g==
X-Gm-Message-State: AOJu0Yzk3XEkZ/oChKmQdndvNPboVOjvsQiKobQG+ODQFTxYDpQxLr6g
        /wdFQw743/w3Tm3Dj1E9g65qd75phuP2b8mliB5QFw==
X-Google-Smtp-Source: AGHT+IFalB9Ut8aNqDhUVR0uM7dSjewsX/mbzDOTXJln2bARbIFZLViMOgH532oONy169goiiTSZzOMIPIlbqfDhpbo=
X-Received: by 2002:a1f:c342:0:b0:4b2:8bdb:3449 with SMTP id
 t63-20020a1fc342000000b004b28bdb3449mr1609871vkf.13.1701272722205; Wed, 29
 Nov 2023 07:45:22 -0800 (PST)
MIME-Version: 1.0
References: <20231129142411.76863-1-brgl@bgdev.pl> <20231129142411.76863-2-brgl@bgdev.pl>
 <ZWdRUosYLAzXQrTT@smile.fi.intel.com>
In-Reply-To: <ZWdRUosYLAzXQrTT@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 29 Nov 2023 16:45:11 +0100
Message-ID: <CAMRc=Mc6ce_gThRfZ78DzHGWdTAO-abY=Ythbd4KRHQ=Yfd_mw@mail.gmail.com>
Subject: Re: [PATCH 01/10] gpiolib: provide gpiochip_dup_line_label()
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

On Wed, Nov 29, 2023 at 3:57=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Nov 29, 2023 at 03:24:02PM +0100, Bartosz Golaszewski wrote:
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
> > +/**
> > + * gpiochip_dup_line_label - Get a copy of the consumer label.
> > + * @gc: GPIO chip controlling this line.
> > + * @offset: Hardware offset of the line.
> > + *
> > + * Returns:
> > + * Pointer to a copy of the consumer label if the line is requested or=
 NULL
> > + * if it's not. If a valid pointer was returned, it must be freed usin=
g
> > + * kfree(). In case of a memory allocation error, the function returns=
 %ENOMEM.
>
> kfree_const() ? (see below)
>
> > + * Must not be called from atomic context.
> > + */
> > +char *gpiochip_dup_line_label(struct gpio_chip *gc, unsigned int offse=
t)
> > +{
> > +     const char *label;
> > +     char *cpy;
>
> Why not "copy"?
>
> > +
> > +     label =3D gpiochip_is_requested(gc, offset);
> > +     if (!label)
> > +             return NULL;
>
> > +     cpy =3D kstrdup(label, GFP_KERNEL);
>
> You probably want to have kstrdup_const(). However, I haven't checked
> if we have such use cases.

I thought about it but I'm thinking that it would be confusing to
users and lead to bugs. This is not used very much and only for
debugfs output. Let's keep it simple.

>
> > +     if (!cpy)
> > +             return ERR_PTR(-ENOMEM);
> > +
> > +     return cpy;
> > +}
>
> So, how does this differ from the previous one? You need to hold a refere=
nce
> to the descriptor before copying and release it after.
>

The last patch reworks it to hold the obsolete gpio_lock and the
upcoming changes will make this perform the copy under the descriptor
lock and return it once it's released.

Bart

> --
> With Best Regards,
> Andy Shevchenko
>
>
