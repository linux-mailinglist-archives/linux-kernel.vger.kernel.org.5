Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B857FAA8A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 20:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbjK0Ton (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 14:44:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjK0Tol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 14:44:41 -0500
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D05E194
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 11:44:47 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id ada2fe7eead31-4629c0109a6so1465752137.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 11:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701114286; x=1701719086; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BeXFsw6k+b1yqi2ijxZf9CyVKX0PO75Po1++MiTzYuY=;
        b=FEPqbSMkLCWlHExazb8l3du43DCyK6IikRz+A4Wlja32mB1HEnRSGk5FcavHkBuJsK
         HP9tf3WVB/k11+pCOXGpG4+J9e2qgHoq9Dmu18qjoq3d3DDjkYSgyOcxQSF0WVXlzBeX
         XdfOJBbRUZSs0VqW2euyJS99CHeyBsNxvM3r0JOKWNLnP4yPut86v/PzaPt37kaH+TPG
         VtOtu2VlRYovQl8rlqPxgkvV9IqZoCEGWKGyNFSj63ZhkSlXmB4t119gqIlnrMFjbY6H
         GSVVyKWqKj/ZoJQcdwYRGLf78mWwQGZjzc894cWC4sYXNI0m5Ej4iWOIdb3v5DTMBMhx
         UzgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701114286; x=1701719086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BeXFsw6k+b1yqi2ijxZf9CyVKX0PO75Po1++MiTzYuY=;
        b=XObqk32kV1WECWdFQJtGj1/B6AUYwyb3/CqmVzp0P+IQnBslvqEUiDMPoNyDXbrLOj
         8z8snPLPrbfYSnZu737k4nCAVEZrZULbbj+UufaH2LZHmIj3fXgtpK+IRGCUcUZZ3MCj
         Qo1xj1cA6XXCemjvE6wK96ZNoRRnhEzZWQNzfHKE6yEn5GmF4sPfXGnlVK4DaeBi2N/w
         k3X0dO7WP0DtRmZy/hP6lbmhrTVwqifEweW3IwWcjCc3OOhq3aB74qsnhAnJT+a7K+Ay
         xPJy8XaTdCFVWTYMsQFhd3KLVqsgIyeS1WYGUkoMLsDjILf9gcvp/ipuHFo+k8LIuuu2
         1Z/A==
X-Gm-Message-State: AOJu0YwyW/7b9aYLCx9rQ9h4SwERPhS/JAialN0h809/McYD1dT3JHZE
        CfALpb/uSntrZGTuibJpZIj9zjp+/M5zg/9bNyvKs0SOt88/RUMIEME=
X-Google-Smtp-Source: AGHT+IGannuDIadBjq3LGczrA0Sy8LurXgG8Aq3ZjMevxPLTGPiM9CIMnc1BAsuKhetFgU9SiKLYYnJ29NUmisBPVQI=
X-Received: by 2002:a67:cd0d:0:b0:462:83ac:e6bf with SMTP id
 u13-20020a67cd0d000000b0046283ace6bfmr11630637vsl.30.1701114286325; Mon, 27
 Nov 2023 11:44:46 -0800 (PST)
MIME-Version: 1.0
References: <20231125-dropcomment-v1-1-15800415aae0@linaro.org>
 <ZWFepm7ufLdl115j@rigel> <CACRpkdZvwePEaRVQLafD8KmiOENgEGFFDBXGPqS5_WLzNi2_yA@mail.gmail.com>
 <ZWKNyFOU65IHND1k@rigel>
In-Reply-To: <ZWKNyFOU65IHND1k@rigel>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 27 Nov 2023 20:44:35 +0100
Message-ID: <CAMRc=Mfv=kgk0mdT5aVmB9VmhCBvyjr3zq2Xdrk0QY9T53ybjQ@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: Drop cargo-culted comment
To:     Kent Gibson <warthog618@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Sun, Nov 26, 2023 at 1:14=E2=80=AFAM Kent Gibson <warthog618@gmail.com> =
wrote:
>
> On Sun, Nov 26, 2023 at 12:05:08AM +0100, Linus Walleij wrote:
> > On Sat, Nov 25, 2023 at 3:40=E2=80=AFAM Kent Gibson <warthog618@gmail.c=
om> wrote:
> > > On Sat, Nov 25, 2023 at 12:25:47AM +0100, Linus Walleij wrote:
> >
> > > > -/* gpio_lock prevents conflicts during gpio_desc[] table updates.
> > > > - * While any GPIO is requested, its gpio_chip is not removable;
> > > > - * each GPIO's "requested" flag serves as a lock and refcount.
> > > > - */
> > >
> > > Perhaps provide a comment as to what the gpio_lock DOES cover?
> >
> > Normally yes, but Bartosz just said he is going to replace this spinloc=
k
> > with a mutex so it's better if he adds it then.
> >
>
> If that is happening soon then leave it to Bart to change both the
> comment and lock.
>
> If not, then we now have an undocumented lock.  If the coverage of the
> spinlock and proposed mutex are the same why not describe what the lock
> covers now?  Then Bart wont have to update the comment.
>
> Cheers,
> Kent.
>

Yeah, I think we should maybe leave some temporary FIXME comment once
the mutex patch is in saying this must go as well but it'll take more
time because the problem is quite tricky.

Bart
