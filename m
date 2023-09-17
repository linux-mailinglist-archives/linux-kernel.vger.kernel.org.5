Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93CE07A3735
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 21:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237492AbjIQS7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 14:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234667AbjIQS7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 14:59:19 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BF5107
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 11:59:13 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id 71dfb90a1353d-495c744d690so1401517e0c.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 11:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694977152; x=1695581952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VlcPeLWUpqyZXNRe+2hhkQ4dMbixtPe4TC1okl7ks7c=;
        b=WXzK2Tvpv4iOQYCS9bQ2Jeb4kL8qpzIB2QfghBNL2N05L5RurTAOau3dxGwX11mcuS
         v8UIsPLILCy1Lj8LkX+CceoAQlb/vwOuKIYnb+DmUMzHMtiLs/XMlcYDinomWT3nFnPV
         DhzsIZv/lpiaoqd4W9cTEqwdF9qDq8ARZ+E/4CzXiuZXNNWg82ZLb91zJeQsuwXC7+mq
         F0bQ+KpcH7u683eO60bRjw7WWew4Yf8xVAkvHcSwLCIdxp7FiyXV4qphr5S6LUIdTsDM
         IvpcwxxwKKDyOC21cv+TKSn0IZZbwrZ+daXvUY+irKs5LbjLEfo2OLIb8rsTwY236TaQ
         BAQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694977152; x=1695581952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VlcPeLWUpqyZXNRe+2hhkQ4dMbixtPe4TC1okl7ks7c=;
        b=DO414XS+2dw4GkY+/ldB5sdA32AkPhK6HvcFQ2mPhJvytHTzOEKf68bsgskf/7IchE
         AMZGyLTIexvyYiY+6KFZ8bn3itwKGeFTrPbyV+ky78rbCMk12vfVcFa9WMhkM9ZsSgU6
         +Cm8aiCCN3vcqCi8kfrRkO339llXl7RTtt3CKzNNunXE4M6bC8ZYDizkKJkhpKy/4h+B
         y5ely5Qlo/cOB+A4SuJk6OeHF+5M8eGHAR4EAzuNHxfM8TQRP79rEumGtppuJAxejZsA
         /txmSczuRXINjY4DZgwwFm4m7d0Ns4kffKRZofd9YAV7aPxHkLrpLEdRuaM5nViQr+bh
         TPlw==
X-Gm-Message-State: AOJu0Yxt+rgDJJLr7mPpnvDXndHSjkEFQji2FOlHN7ySZXdjZKSAv30k
        q3OO3q1lNZENJ9vMnqur66PgZ9Bebp73H8gVtHf/Dg==
X-Google-Smtp-Source: AGHT+IFgwfDbhCkqrAtCmQc4CO3yC+LAWPDUVeQW8p19oc1Rg7qipxwd/aimhF9e9xmhJGDCjn1boSrmoj1bm2M0Xnw=
X-Received: by 2002:a05:6122:1893:b0:496:a303:a321 with SMTP id
 bi19-20020a056122189300b00496a303a321mr828206vkb.8.1694977152568; Sun, 17 Sep
 2023 11:59:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230917091225.6350-1-brgl@bgdev.pl> <20230917091225.6350-2-brgl@bgdev.pl>
 <CAHk-=wjr5N-2ZKgn_gPaMapprn1vbBxzsdp4fJY+2iC=1H2T5g@mail.gmail.com>
In-Reply-To: <CAHk-=wjr5N-2ZKgn_gPaMapprn1vbBxzsdp4fJY+2iC=1H2T5g@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Sun, 17 Sep 2023 20:59:01 +0200
Message-ID: <CAMRc=MdMBo0R2XDMYDU+gySyb_eQnvdE64QxE4JSGRDqH7Xcmw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] gpio: sim: fix an invalid __free() usage
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 17, 2023 at 6:46=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, 17 Sept 2023 at 02:12, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >
> > +               has_line_names =3D true;
> > +               max_offset =3D max(line->offset, max_offset);
>
> I really don't understand why you kept this old broken logic.
>
> I sent a much better version of this function that didn't need that
> pointless has_line_names thing or the 'max()' thing, by just making
> the code a lot simpler.
>

Right, it does what it's supposed to after all but IMO it's less
clear, I had to take a second look now to get it. I was wondering if
I'm simply too sleep deprived but no - it's because in your version
the max_offset variable actually holds the value of (max_offset + 1)
which makes the name untrue.

I don't want to bikeshed about it, let me know if my version is
GoodEnough(R) or do you prefer another respin.

Bart

> Whatever.
>
> > +       line_names_size =3D gpio_sim_get_line_names_size(bank);
> > +       if (line_names_size) {
> > +               line_names =3D kcalloc(line_names_size, sizeof(*line_na=
mes),
> > +                                    GFP_KERNEL);
> > +               if (!line_names)
> > +                       return ERR_PTR(-ENOMEM);
> > +
> > +               gpio_sim_set_line_names(bank, line_names);
> >
> > -       if (line_names)
> >                 properties[prop_idx++] =3D PROPERTY_ENTRY_STRING_ARRAY_=
LEN(
> >                                                 "gpio-line-names",
> >                                                 line_names, line_names_=
size);
> > +       }
>
> But I do like this reorganization.
>
>             Linus
