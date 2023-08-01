Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7814576B948
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 18:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbjHAQC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 12:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjHAQCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 12:02:21 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C0A10B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 09:02:18 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-63cffc0f95eso29124936d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 09:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690905737; x=1691510537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=03aieGdgBxbYMor+zrbkfIBxz/KLfdHy7Dl2oJFgL9Q=;
        b=dtmuBO6Fb+DNoOV0Y2U8m6eJh8nWPZxx7E7wRQNiJO2s+Ifq81nKUpE/0J1ZXHJmga
         hHaOSLF8rAv1gi+00Uxf+4KnC4PrW4Srbfpenxb52befJwBmxZNOtTXgIW1KsZr26vRc
         vJeBIt4U+e1DhruiCFR14Pn9fHrZBtEdRI0Zz7F4GnHr4TBvfGPErUjAOaRsUSu/97NF
         JAq8Mzj2cfRM+RnHPdbvYmWEQr14VJMdc44oQaBYbktAYwuTDL7slK2uCZl3d6Le+fYw
         upGxuwChc1apybgOHGWzBGcjXH3N8o9ilLYDxX/Q6ZJCao1Vqen84QXVzF8wDuMRIjzi
         nlRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690905737; x=1691510537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=03aieGdgBxbYMor+zrbkfIBxz/KLfdHy7Dl2oJFgL9Q=;
        b=be9tfhUnMgqyw85bUo0EV8u0cqeLu1a6UrI8gfHGqaWAar1Ci1JWoP7cdbzY36fVp9
         2p2lnbZJgwgluqAsQzuISDmI+bJeMsOnjq0fxm1zkbhKUzgZc37sLL197HMGAzIF60Qb
         aaW6RGVeS/Mf+J0FhVi2MoYrF1WXPxTgIymLDG79uBd4++qPZ1R8Kbmec48e7VFD8U6y
         lkLip3D+8u/kC/IDz8sSKgH2t0TaL8ZPYfGqjgttONjN0+h7pnEYalQ4cZSIZaVW10B9
         PSnSt2zYcvz0LUS8ipTan2ZWr2XEA2ClATWrXyy7xo8BuZOiCD2ZHDdZ98v6fBpoA86J
         BkNQ==
X-Gm-Message-State: ABy/qLYpKfj16Fk145tbx3dPoVnYsO1+Wpj6GAJabh37vQXs+j1NeQtg
        w+7yeyFDVWw6RFIWQfO9Fq4TTzVFVuURgYsmM4gC+w==
X-Google-Smtp-Source: APBJJlFhlDXyfDh1bir6NtiRwgyu53SQkMwG14hApKnu7Xh4DgS+oyRQEYihjYIk6TpeJYBq4Ki/kTENkUO2wINlBms=
X-Received: by 2002:a05:6214:459c:b0:63d:1e4e:d745 with SMTP id
 op28-20020a056214459c00b0063d1e4ed745mr11462027qvb.61.1690905737445; Tue, 01
 Aug 2023 09:02:17 -0700 (PDT)
MIME-Version: 1.0
References: <bde3d2dc933848bbaceeb9b7102f6f4c@AcuMS.aculab.com>
 <b4ce9dad748e489f9314a2dc95615033@AcuMS.aculab.com> <9c14002108ff49e1a54819133fe9e2a3@AcuMS.aculab.com>
In-Reply-To: <9c14002108ff49e1a54819133fe9e2a3@AcuMS.aculab.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 1 Aug 2023 09:02:06 -0700
Message-ID: <CAKwvOdm6ZVSMpzSJ0tFMR_rVb1+=REk8ETLS2SBe3s8QrbYUQw@mail.gmail.com>
Subject: Re: [PATCH next v2 5/5] minmax: Relax check to allow comparison
 between int and small unsigned constants.
To:     David Laight <David.Laight@aculab.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Nathan Chancellor <nathan@kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 6:27=E2=80=AFAM David Laight <David.Laight@aculab.c=
om> wrote:
>
> By the time I've done:
>
> #define __is_noneg_int(x)                                       \
>         __builtin_choose_expr(!__is_constexpr(x), false,        \
>                 ((x) >=3D (typeof(x))0 && (x) <=3D (typeof((x) + 0))(long=
)__INT_MAX__))
>
> #define __is_signed(x)                                                   =
      \
>        __builtin_choose_expr(__is_constexpr(is_signed_type(typeof(x))),  =
      \
>                is_signed_type(typeof(x)), 0)
>
> #define __types_ok(x, y)                                        \
>         (__is_signed(x) =3D=3D __is_signed(y) ||                    \
>                 __is_signed((x) + 0) =3D=3D __is_signed((y) + 0) || \
>                 __is_noneg_int(x) || __is_noneg_int(y))
>
> the error message for
>
> >       static_assert(__types_ok(x, y),                 \
> >               #op "(" #x ", " #y ") signedness error, fix types or cons=
ider " #op "_unsigned() before " #op "_t()"); \
>
> generated by clang 8.0.0 and later is similar to (see https://godbolt.org=
/z/jq613Gnsa):
>
> <source>:49:12: error: static assertion failed due to requirement '__buil=
tin_choose_expr((sizeof(int) =3D=3D sizeof (*(8 ? ((void *)((long)((((int)(=
-1)) < (int)1)) * 0L)) : (int *)8))), (((int)(-1)) < (int)1), 0) =3D=3D __b=
uiltin_choose_expr((sizeof(int) =3D=3D sizeof (*(8 ? ((void *)((long)((((un=
signed int)(-1)) < (unsigned int)1)) * 0L)) : (int *)8))), (((unsigned int)=
(-1)) < (unsigned int)1), 0) || __builtin_choose_expr((sizeof(int) =3D=3D s=
izeof (*(8 ? ((void *)((long)((((int)(-1)) < (int)1)) * 0L)) : (int *)8))),=
 (((int)(-1)) < (int)1), 0) =3D=3D __builtin_choose_expr((sizeof(int) =3D=
=3D sizeof (*(8 ? ((void *)((long)((((unsigned int)(-1)) < (unsigned int)1)=
) * 0L)) : (int *)8))), (((unsigned int)(-1)) < (unsigned int)1), 0) || (__=
builtin_choose_expr(!(sizeof(int) =3D=3D sizeof (*(8 ? ((void *)((long)(a) =
* 0L)) : (int *)8))), 0, __builtin_choose_expr(__builtin_choose_expr((sizeo=
f(int) =3D=3D sizeof (*(8 ? ((void *)((long)((((int)(-1)) < (int)1)) * 0L))=
 : (int *)8))), (((int)(-1)) < (int)1), 0), a, 0) >=3D 0 && (a) <=3D (int)(=
long)2147483647)) || (__builtin_choose_expr(!(sizeof(int) =3D=3D sizeof (*(=
8 ? ((void *)((long)(2147483648U - 0) * 0L)) : (int *)8))), 0, __builtin_ch=
oose_expr(__builtin_choose_expr((sizeof(int) =3D=3D sizeof (*(8 ? ((void *)=
((long)((((unsigned int)(-1)) < (unsigned int)1)) * 0L)) : (int *)8))), (((=
unsigned int)(-1)) < (unsigned int)1), 0), 2147483648U - 0, 0) >=3D 0 && (2=
147483648U - 0) <=3D (unsigned int)(long)2147483647))': min(a, 0x80000000u =
- 0) signedness error, fix types or consider min_unsigned() before min_t()
>
> Repeating the expression seems somewhat sub-optimal!
> Surely it shouldn't be outputting the expansion of the
> input when an error message is supplied?
>
> Is there any (sane) way to stop it being that verbose?

No, but we can probably change that in clang. Filed:
https://github.com/llvm/llvm-project/issues/64310

>
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1=
 1PT, UK
> Registration No: 1397386 (Wales)



--=20
Thanks,
~Nick Desaulniers
