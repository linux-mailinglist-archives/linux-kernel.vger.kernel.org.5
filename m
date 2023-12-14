Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FBD8133B3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 15:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573585AbjLNO4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 09:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjLNO4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 09:56:44 -0500
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9477121
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 06:56:49 -0800 (PST)
Received: by mail-ua1-x929.google.com with SMTP id a1e0cc1a2514c-7c5060a9e5bso2529825241.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 06:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1702565809; x=1703170609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QXGU7uxzdx9Ei/zDB1+ErYmoyAxKtQT/JcBiEtryWB8=;
        b=DA0GCRETHjh2t2x//pla5xlpAu9Lv9r0HluBKMCO+7yymArkZpzaB4j7DSOyPDcTdS
         9npQei5l2AS2LaKEYA5PtD0mO13gp97/yeafxQesOFFPOyNldhXbcL0ykINYEx6mF7u/
         kdiUNaOhpvtgOwqRyZHXDGD3z3PXnGGJAtsy/E+HCrxso5LCrDMaGNcxnaJTH0zQdZDp
         j1oMxlr7YG6pnKeM6TZUDdShV6XeWoEukfIqYVUSba26G7QRWEqMYXmJ6gaDHYTQE/jP
         JQPW5m16FEKBPEuJX40+bqq6rdZnBy8LYFmGqiOVuwo3BHTlQPc0quZMuv7TJNc5xeHC
         P43g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702565809; x=1703170609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QXGU7uxzdx9Ei/zDB1+ErYmoyAxKtQT/JcBiEtryWB8=;
        b=rcde1wycnuBmLwyB/KBK5Re17pPTEgQtezpAsJO9qswUgxlYRe0WW16rWqZUvNLWv3
         CaCaAWvl7LYbErPJZMWBAorTzY3TZJHtiBVM2o6MrbkeXZQ8MclaSZ80YJIMA2kJF64R
         Bw6dOiojtEizGqflcn9MB8xRqTGCf2a2X1WPeFktHKGNMdAB+jl8QzLssp97/q7b1q0I
         pbAg77xNFCgWxz22q/Q1zPCdKKziPci8QKwQZXkLSGg4VvMioaUD2Di6GAeHxcjw+PIy
         djogGdGfCldGzyQdwaFg31toYvl0d2mey1Oa0z2Tbw8bkuBhTyOZopbZFAeJPeKgLvtQ
         gLcg==
X-Gm-Message-State: AOJu0YyULMCXslcw9NYG3Bk4FwNkdq77yO8R36OhO4QpR58i23xG1wba
        Fg7g5idKeGormNKDlq8b0LgS+ZKhIHZl118BCdxOxQ==
X-Google-Smtp-Source: AGHT+IH1GjCeuBbUcjcikeV55wKgIXAGMADfNzBmmP8sp3xw7kytWZVne7yKdaKjhD1PQ0BGrq4ns+SIyq3frhSJ8xA=
X-Received: by 2002:a05:6102:dcd:b0:464:93fd:f4a4 with SMTP id
 e13-20020a0561020dcd00b0046493fdf4a4mr7694324vst.25.1702565808851; Thu, 14
 Dec 2023 06:56:48 -0800 (PST)
MIME-Version: 1.0
References: <20231214095814.132400-1-warthog618@gmail.com> <20231214095814.132400-3-warthog618@gmail.com>
 <CAMRc=MeoeOgZaz6xT+ScVjOemVovrEHvQDBvqsN1pD9U3haE_A@mail.gmail.com> <ZXsU_UN6g0Fdj4qx@rigel>
In-Reply-To: <ZXsU_UN6g0Fdj4qx@rigel>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 14 Dec 2023 15:56:37 +0100
Message-ID: <CAMRc=Mf4FpzLqQZ5phRZLbTsGCfdYaELZHnLM13vnWnkAkLXkQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] gpiolib: cdev: relocate debounce_period_us from
 struct gpio_desc
To:     Kent Gibson <warthog618@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, andy@kernel.org
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

On Thu, Dec 14, 2023 at 3:45=E2=80=AFPM Kent Gibson <warthog618@gmail.com> =
wrote:
>
> On Thu, Dec 14, 2023 at 03:29:28PM +0100, Bartosz Golaszewski wrote:
> > On Thu, Dec 14, 2023 at 10:58=E2=80=AFAM Kent Gibson <warthog618@gmail.=
com> wrote:
> > >
> > >
> > > +/*
> > > + * Used to populate gpio_v2_line_info with cdev specific fields not =
contained
> > > + * in the struct gpio_desc.
> > > + * A line is determined to contain supplemental information by
> > > + * line_is_supplemental().
> > > + */
> > > +static struct {
> > > +       /* a rbtree of the struct lines containing the supplemental i=
nfo */
> > > +       struct rb_root tree;
> > > +       /* covers tree */
> > > +       spinlock_t lock;
> >
> > Looks like this is never taken from atomic context? Can this be a mutex=
 instead?
> >
>
> Correct, only from thread context.
>
> Can be a mutex, but it only covers tree lookups which should be quick
> as the tree is kept minimal, and I wouldn't expect it to ever get to the
> mutex slowpath, so a spinlock seemed more appropriate.
>

Fair enough.

Bart

> Cheers,
> Kent.
