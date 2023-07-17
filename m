Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63A975692C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 18:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjGQQb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 12:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232122AbjGQQbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 12:31:08 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF5AE4F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 09:30:49 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-78372b896d0so212755639f.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 09:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689611428; x=1692203428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9i3VK3pQTjmUtT5OIdEmXOiU0z+iCuLJNI+axMd3d80=;
        b=zQfMnpxIRttCfvjgQrSKDYwDxfWm0p44+S0sR4izGZ3ZbuNF//3EyLQjfiB1W/mOi7
         quHsMMlEOnRSRRturG789RcLoPi2Msk04IbG007aIA4nMDUR/4bnle16MbFhLMdETZ+4
         OZpB+a86kbM71Lv/LtBjmUfZ4bnh/FseD91F8lD6qSb5FVsWob/EB42nxriBGLXXhvSc
         XzUtTfx0emnlo7dzIf1hBtojF+tWFvdKH0Qemx0LcxNivEM2/eK/3W7oCTP+WpHZT1Lr
         5bNv7MK788odki5qtoaIR2/UOJD77oVJ79ZMTpqfyWTOZtZhdbiRKfqAsakhrDF2NFxR
         PyjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689611428; x=1692203428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9i3VK3pQTjmUtT5OIdEmXOiU0z+iCuLJNI+axMd3d80=;
        b=TQHJTxE4M6TfM+B0EpYuih7TPyDCcpJtgGKMXntVfSbrD0sIzV0+9SYjnsIHahJ+ms
         nSwAOD9FKY1vyJIS2FFQBFJTUOioXJ1Epjm0Zy2P0N4wnUI0pkqcEi+fgD9YIXK5hkqj
         w2Pwrz8Q9RVoYZcS+ne3/TPYyuCOdvb4XtMH4uokj8xqciuw3SjxIksY5vo8Gypvu3ju
         YXa0pk4SER0yqzd5oNaWc+AOfEsOrljgd6ebZo2kn2yt8invTzn39/wDpTu45zH5gWkh
         Wfwv4PbOGVqync+h3+Br/B+JQyOdHNb1N21AfUpvMsEaP9afxUoGhdO13Vvc3O9O1v++
         HfQw==
X-Gm-Message-State: ABy/qLb9PYURxYOGG38DzsFZfiBMyW39EtN+Z2ILYuaueavLZyI0C86H
        0iWYoQeM9EDs6ZYTioM5djW3//ovPC9aZX93szG7Ww==
X-Google-Smtp-Source: APBJJlEB18fMmLkRLn8GKxFnGKSNp97lazA148cuQr29/maTgq8okpMvpGjdFcgv6XdZaS7NbcERponGocHsXsHfd6k=
X-Received: by 2002:a6b:cf18:0:b0:783:58f4:2e2e with SMTP id
 o24-20020a6bcf18000000b0078358f42e2emr336550ioa.0.1689611428551; Mon, 17 Jul
 2023 09:30:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230717113709.328671-1-glider@google.com> <20230717113709.328671-2-glider@google.com>
 <ZLU7mkhUiDQodaw1@smile.fi.intel.com> <CAG_fn=XNYQC8gKKQr3Mz7CVw8H=Ubmr+QaUu-jraoT4sN550rA@mail.gmail.com>
 <CAG_fn=Ufo8sWbdtPyaXhvUddRG3k9E+btFVVLTn5Tk91cwAwLw@mail.gmail.com> <ZLVYRHUwgnYdnZih@smile.fi.intel.com>
In-Reply-To: <ZLVYRHUwgnYdnZih@smile.fi.intel.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 17 Jul 2023 18:29:52 +0200
Message-ID: <CAG_fn=X+NshSQXD9H7ajuMsDM7oA60-HF-bPrt3bQuPL63W=6A@mail.gmail.com>
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 5:03=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Jul 17, 2023 at 04:53:51PM +0200, Alexander Potapenko wrote:
>
> ...
>
> > > > I remember that this construction may bring horrible code on some a=
rchitectures
> > > > with some version(s) of the compiler (*).
> > >
> > > Wow, even the trunk Clang and GCC seem to generate better code for
> > > your version of this line: https://godbolt.org/z/36Kqxhe6j
> >
> > Oh wait.
> > First, my Godbolt reproducer is incorrect, it is using sizeof(unsigned
> > long) instead of 8 * sizeof(unsigned long) for BITS_PER_LONG.
>
> Still slightly better. And note, that the same GENMASK() is used at the
> beginning of the function. Compiler actually might cache it.

I think that the compiler might consider this transformation invalid
because "GENMASK(nbits - 1, 0) << offset" and "GENMASK(nbits + offset
- 1, offset)" have different values in the case "nbits + offset"
exceed 64.
Restricting the domain of bitmap_set_value() might result in better
code, but it is easier to stick to your version, which prevents the
overflow.

> > > > To fix that I found an easy refactoring:
> > > >
> > > >                 map[index] &=3D ~(GENMASK(nbits, 0) << offset));
> > > >
> >
> > Second, the line above should probably be:
> >   map[index] &=3D ~(GENMASK(nbits - 1, 0) << offset));
> >
> > , right?
>
> Yes.

This "nbits vs. nbits - 1" was not detected by test_set_get_value(),
so I'll add an extra test case for it.
