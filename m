Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09305756628
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 16:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjGQOQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 10:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjGQOQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 10:16:21 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4419310DF
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 07:15:55 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-7835971026fso185735139f.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 07:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689603334; x=1692195334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q/Etr5ln7V9qJYgR+jYHUosTrycy9bCbiREFEh6ojkU=;
        b=HyV4wuTniDMbcFSK2QBPfJAjUzNwJO36NBbC2zZzM4XH1s9wP1Ylq3TY10VKISDb2m
         hMtGz7nh93CC+6ZviadaYgWRo26EDCQxxGf8jjxjVsU6pexiNHp9aHTF4VYrmbQfki3l
         v1gl4/zR5SFXs/709m7To+Zh2O82oIT6ZYUeajeZ5j8OY+HptQ9Xkdc42QBw9hDYtdzu
         gqgsx53R/PndUEdA6R29Qs4BuBHbDnkb1K1dI5Lg/F3udhft0MzuV3yA+JAjoys0fywq
         fwK+RX+eH0oA8yM3j0c+c33/Nb/TrrsCeNz8+qTIqmARQ7qyVNwbS4Dfb9/4UqYi15PJ
         1uUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689603334; x=1692195334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q/Etr5ln7V9qJYgR+jYHUosTrycy9bCbiREFEh6ojkU=;
        b=G+zuR+9Oi/gx6CrtUXCg8o0RSwxAQ8PkrnbHTlB/L/UsAhEm/9p/x2CPKbmGdGKCMJ
         dYvK7iTHCsaDcxAmQfEqtHMBAmw1IV8jfWUXYoPxHk2ltrVnV1Gy5P62HsVgLbRf9glV
         Ih37c4G7HOOZluKBXF83LSfly4lORhMQ5V3D7TKHpo+wB2/oaek3tERa+4aF9uEK+dev
         njik3wZRMpO4Xqz1+790oRxv7N2JNd/6xSksNiz2IBNJYP5Lga5m23m9bnrwGXFAiIk8
         XO0YnRyuSxz8QzrZZIssxmlwKcQs5O1EsVA0AypwFMilMo7kJ2v00XfMiQeM82ZCM6yw
         AZ/A==
X-Gm-Message-State: ABy/qLbeHxWVLg7RCkZ16vdFv2lUnzV5kBdlH+Zc/p4ZubiFzzSPnCOt
        zMBHuj0iqzM0AGmQD4InLWXA66F7EwIcNO8jWxZIHg==
X-Google-Smtp-Source: APBJJlGyiVthTHnd3Lbdq9FfE+vz0TSwKhDJ3weCw6vrvclqK+qmW68GyaqAZjLKUa73gZpBusbA4r3SeLTGlwuNaD8=
X-Received: by 2002:a6b:d608:0:b0:787:a73:b411 with SMTP id
 w8-20020a6bd608000000b007870a73b411mr9656710ioa.17.1689603334563; Mon, 17 Jul
 2023 07:15:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230717113709.328671-1-glider@google.com> <20230717113709.328671-2-glider@google.com>
 <ZLU7mkhUiDQodaw1@smile.fi.intel.com>
In-Reply-To: <ZLU7mkhUiDQodaw1@smile.fi.intel.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 17 Jul 2023 16:14:57 +0200
Message-ID: <CAG_fn=XNYQC8gKKQr3Mz7CVw8H=Ubmr+QaUu-jraoT4sN550rA@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] lib/bitmap: add bitmap_{set,get}_value()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, linux@rasmusvillemoes.dk,
        yury.norov@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> > Cc: Arnd Bergmann <arnd@arndb.de>
>
> You can use --cc to `git send-email` instead of polluting the commit mess=
age.

Right. But as far as I can tell, certain kernel devs prefer to be CCed
on the whole series, whereas others do not want to see anything but
the actual patch they were interested in.
I am not sure about Arnd's preferences, so I just decided to keep the
tag from the original patch by Syed Nayyar Waris (which I also
consider to be an indication of the fact "that potentially interested
parties have been included in the discussion" per
https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html#when-=
to-use-acked-by-cc-and-co-developed-by)

> > Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
> > Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
> > Link: https://lore.kernel.org/lkml/fe12eedf3666f4af5138de0e70b67a07c7f4=
0338.1592224129.git.syednwaris@gmail.com/
> > Suggested-by: Yury Norov <yury.norov@gmail.com>
> > Signed-off-by: Alexander Potapenko <glider@google.com>
>
> With above, I think you can also add Co-developed-by (as the changes were
> made).

Ok, will do.

> ...
>
> > +static inline void bitmap_set_value(unsigned long *map,
> > +                                 unsigned long value,
> > +                                 unsigned long start, unsigned long nb=
its)
> > +{
> > +     const size_t index =3D BIT_WORD(start);
> > +     const unsigned long offset =3D start % BITS_PER_LONG;
> > +     const unsigned long space =3D BITS_PER_LONG - offset;
> > +
> > +     value &=3D GENMASK(nbits - 1, 0);
> > +
> > +     if (space >=3D nbits) {
>
> > +             map[index] &=3D ~(GENMASK(nbits + offset - 1, offset));
>
> I remember that this construction may bring horrible code on some archite=
ctures
> with some version(s) of the compiler (*).

Wow, even the trunk Clang and GCC seem to generate better code for
your version of this line: https://godbolt.org/z/36Kqxhe6j

> To fix that I found an easy refactoring:
>
>                 map[index] &=3D ~(GENMASK(nbits, 0) << offset));
>

I'll take this one.

> (*) don't remember the actual versions, though, but anyway...
>
> > +             map[index] |=3D value << offset;
> > +             return;
> > +     }
> > +     map[index] &=3D ~BITMAP_FIRST_WORD_MASK(start);
> > +     map[index] |=3D value << offset;
> > +     map[index + 1] &=3D ~BITMAP_LAST_WORD_MASK(start + nbits);
> > +     map[index + 1] |=3D (value >> space);
> > +}
>
> --
> With Best Regards,
> Andy Shevchenko
>
>


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
