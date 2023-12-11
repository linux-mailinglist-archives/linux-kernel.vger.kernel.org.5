Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E1D80CD24
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 15:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343921AbjLKOHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 09:07:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344140AbjLKOHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 09:07:30 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67401FE6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 06:04:21 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5cfc3a48ab2so37707507b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 06:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702303460; x=1702908260; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9CFck6j5mISD+nr8l97lbay7YxJi1mf85R6XUu8mP+0=;
        b=hrBFkik9oFxUX5wMVj4LYekT0SWiYmqBBGl6FTPR6MPSllkOg/0ZVVQ9tGR1/FGMln
         ehidZO6X6MKpQUs6JCDXX/26IVvykFkqW6drujkokWf+fFbfInaywyX9vttSsf5+Bvvz
         wtY8c29HxMWGuFpjqTukIz0SrcTj9U0U288BmOevNDKzwtwCEwYISCryh+EVJzuno3jR
         lmeJpIurpKpd1YUpu53gEjnjGc4Mq2sG+LnRXIlDCmcgkyi+ZnaahQKpAwEkRYe2thP5
         IKWypKlyyOWerplf6iTcnIZr52rL0nc2gDYDbQl7v/HLcjvU2Ev6OMGTrBE2N8iILrtt
         TZPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702303461; x=1702908261;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9CFck6j5mISD+nr8l97lbay7YxJi1mf85R6XUu8mP+0=;
        b=Pf5Dn8Z6qejgPNb62Cl2kr5hbZ3Fru1KH6buBgMb4yrlJNt1xLWXeSbT9lbI7D1aC/
         GLF+pFARr/g37fe4J9SeNH4VC3cOquFvJm59YHVhNze6Re10O3NaYgESXad1oilZ4tCG
         3uHKh4+zpNMG4NdoYujvaAyeeiMz4NUua7f6WfMz/6CyXl9t9lbVr1+whbI7KkDjwyg3
         Ix1Wa4luLtESxDHEV/mGW7oHZSQ4LPJBK0oJEEmM2oCnVBNsXcC2JJtcHxYyZX1l9Lem
         XQH/2Leafywbf3xfNQqzwap3e1stEqR8ituzeqWr9w/K2T8/d8acDpReLOqIQNxqW7xA
         jgew==
X-Gm-Message-State: AOJu0YyhVpX6iJkUb57BZc3i0pnLzsE15HJ9zlmGr0UX5gIoxVRTRdJ9
        2oYmdDoTQvEMDQefJiGOBqyeekTujUsnur42GQYYE6JaKrjgI4qwLQs=
X-Google-Smtp-Source: AGHT+IFJfV/y2PnGfaQT/1mvy7rqc46THwn/8r5BmZmLNDkolpvzIx6WNKWKCigIVsmNcnTu01u0CSEZ7fib68jKE6k=
X-Received: by 2002:a05:6902:4e:b0:db7:dacf:ed9c with SMTP id
 m14-20020a056902004e00b00db7dacfed9cmr2473744ybh.125.1702303460564; Mon, 11
 Dec 2023 06:04:20 -0800 (PST)
MIME-Version: 1.0
References: <20231211145056.23fbfd7d@canb.auug.org.au> <CACMJSetGz1fCnqS_HPTLyV8dOWOUtO07-bZKKXu3=3Lk2PGdyw@mail.gmail.com>
 <ZXcRMTFitYohcFfS@smile.fi.intel.com>
In-Reply-To: <ZXcRMTFitYohcFfS@smile.fi.intel.com>
From:   Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date:   Mon, 11 Dec 2023 15:04:09 +0100
Message-ID: <CACMJSeun5bCUwkVZPXpc5mKqyj_XztUHTXafuz5Psc_8LCKkuA@mail.gmail.com>
Subject: Re: linux-next: manual merge of the pinctrl-intel tree with the
 gpio-brgl tree
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_XBL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2023 at 14:40, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> +Cc: Linus W.
>
> On Mon, Dec 11, 2023 at 09:15:30AM +0100, Bartosz Golaszewski wrote:
> > On Mon, 11 Dec 2023 at 04:51, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> > > Today's linux-next merge of the pinctrl-intel tree got a conflict in:
> > >
> > >   drivers/pinctrl/intel/pinctrl-baytrail.c
> > >
> > > between commit:
> > >
> > >   c73505c8a001 ("pinctrl: baytrail: use gpiochip_dup_line_label()")
> > >
> > > from the gpio-brgl tree and commit:
> > >
> > >   6191e49de389 ("pinctrl: baytrail: Simplify code with cleanup helpers")
> > >
> > > from the pinctrl-intel tree.
>
> ...
>
> > Andy, please pull the following into your baytrail tree:
> > https://lore.kernel.org/lkml/20231208083650.25015-1-brgl@bgdev.pl/
>
> I can do it, but why?
>

You were the one who asked me to put these commits into an immutable
branch in the first place to avoid conflicts with the baytrail branch.
:)

Bartosz

> Conflicts is a normal practice during kernel development. And I believe this
> particular one will be solved by Linus W.
>
> Stephen, resolution looks correct to me, thank you.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
