Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4DCD78B624
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 19:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbjH1RM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 13:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232823AbjH1RM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 13:12:27 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07FA1AC
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 10:12:07 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-79b191089a3so1239749241.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 10:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693242727; x=1693847527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9tcC3xYDUYwLzITsg84+hAPTK1MGosey0hEdDjWQsdI=;
        b=HK+2qa+pN0mhYLNzOBZsUVDYXtZ20TkKfbnq5M0z34ErpEVT9D4C8aQ5z2Ln+ltY5N
         r3/c9wfpJCZRLNHJSYBs3KenOhFgnv7EydN5ITvPdBgPqPpT8PJHyhO7TcGMD9DaBf4Q
         96gw4nUyp69wLLP7kHnCTrfy1KWlprR4lg0Qe8u/KLYp0R/QUifUZIZBd5e4uZ4k2b4B
         6dm66uj/nz6ZJPhpwbzjH9fRrR2e6hoPunQH8f/DYjSYLgIprxcsm5EZLJg9yG+mKlxN
         0u7ZUiRen8jMdJrbe/7i5d4dlLma/vNJ8G/zcc3HsMaPq7dVtPMpjOHz21XgZ0w1hxsj
         rzkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693242727; x=1693847527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9tcC3xYDUYwLzITsg84+hAPTK1MGosey0hEdDjWQsdI=;
        b=MdYH/DxtXeQvpteGjvkVu1FrJ4E3jcu7Mf1PoMcg8MOlDXBfFqnjyrHVsc+PCyRSaT
         p3hpa7wsiok0FkJsjUzsiE7LJNp/39icRhVjIGx6dStGBXZhmGoQVgS9ODLZuDxKXJK3
         57VZgRDXHmWgcjYlz/mkxX2Zz657gBEYHqsIxEgRxBkxHbW/RWkb5IkcoK54U4XGEoiT
         d20n/aTJx9MrgEjopgac3bCfcTAotxRJh2QD8fsVORJFd/ywXNFEbD5IPWW/Vg5S2gx0
         Utwt+wv7zKL0Y1s4jGW5TTuZoVQe4hWYwjh9kf8xK7wMcIqZ/xjABHNMSLOOFE9BvzSR
         0boA==
X-Gm-Message-State: AOJu0Yz1UFRd2EJic7VL1TNJJbGsWkDELUDwckBVrFZTQXpPxQGukFaS
        iHBa21J5IHxyz9C63noI8Rn8DXHZ0FEAqHUbzjs=
X-Google-Smtp-Source: AGHT+IFtmPZ3uMAYDxx/b7vneJ0vogIxpORfqTC9pZwVNdfjNDKwCqNf4r142rkaf/Rc7w+x4EtH98JESDE73AVFElg=
X-Received: by 2002:a05:6102:107:b0:44e:8773:8c72 with SMTP id
 z7-20020a056102010700b0044e87738c72mr13329551vsq.0.1693242726984; Mon, 28 Aug
 2023 10:12:06 -0700 (PDT)
MIME-Version: 1.0
References: <CA+jjjYQWeqDY3EFQWmVzV2pXyhfRaHm6s-XWYSXfe1CxvkeuEQ@mail.gmail.com>
 <c3b9a46e2cf44ff1a08efadde68248b2@AcuMS.aculab.com>
In-Reply-To: <c3b9a46e2cf44ff1a08efadde68248b2@AcuMS.aculab.com>
From:   Joshua Hudson <joshudson@gmail.com>
Date:   Mon, 28 Aug 2023 10:11:55 -0700
Message-ID: <CA+jjjYTcKyuy6HdwPsXr99FvHMK8vhmU8sqhZLE0m2n__GaRpA@mail.gmail.com>
Subject: Re: System Call trashing registers
To:     David Laight <David.Laight@aculab.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
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

On Mon, Aug 28, 2023 at 10:06=E2=80=AFAM David Laight <David.Laight@aculab.=
com> wrote:
>
> From: Joshua Hudson
> > Sent: 24 August 2023 17:15
> >
> > 1) A lot of my old 32-bit programs don't work on x64 linux anymore
> > because int 80h now trashes ecx and edx. This hasn't been a serious
> > problem for me.
>
> Aren't both ecx and edx caller saved?
> So if the code is using asm syscall wrappers provided the asm
> wrappers don't expect the registers be saved (which is unlikely)
> then it is safe for the kernel to trash them.
>
> OTOH I have seen code compiled with inlined syscall code
> (but not recently). In that case it will matter.
>
> It gets more interesting with all the xmm/ymm/zmm registers.
> They are also all caller saved, so if the compiler always
> sees a real function call wrapping a system call then the kernel
> need not save them and can return with them all set to zero.
>
> I don't believe that is done, but it is likely to be a measurable
> performance gain for most programs.
>
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1=
 1PT, UK
> Registration No: 1397386 (Wales)

The actual question is "why isn't trashing the registers with arbitrary val=
ues
from the kernel stack" a security vulnerability? It doesn't look like
they're being
set to zero.

It was in fact once documented that all registers are preserved except eax.
(Fun fact: this used to be true across a successful exec(); you could actua=
lly
pass extra values to a child exec process in esi and edi until this was
deliberately changed to zero all registers on program entry.)
