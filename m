Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0307771FB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 09:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233909AbjHJH4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 03:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbjHJH4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 03:56:32 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361DF1702;
        Thu, 10 Aug 2023 00:56:30 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d44c2ca78ceso2553070276.0;
        Thu, 10 Aug 2023 00:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691654189; x=1692258989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FxgcLGl1+zaKb7gMeVcoWhNfpw99e6OYlBFpuHyvHvw=;
        b=kH81k+GCakwbjhGtyMkWLMXDOz+YGETmOwVEDCxE382QgnxcGj0TA9VtGzsg2R26Nq
         2y4xLqTIBnfB1e943kKmpEYv72MkVhDB4aCCdSyuuA214u8CZBZZSCqGqpUtT3EaXQGe
         f3bgb8Arrb9GG1hNx+5QLyakpGjMJ+mkRk/T39lZ4/LWrxBFu3k6BHE/aagAo8mDNrCy
         6l8iHPBvXVKJ6RV7ntrRKBb6xtEFglALy5WnsbNboii7bFaPwU5sOXOlyCYqtg7pGmiT
         C4Nsh+6zutQhDDs6V6IPDSoXsuGfKbPkxewLOVhakn9XZPIISWc+XVPXigXAfDbyP5hg
         lw2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691654189; x=1692258989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FxgcLGl1+zaKb7gMeVcoWhNfpw99e6OYlBFpuHyvHvw=;
        b=g5E6dB43A9Nb3Eh+MCZa/rWs1nTzVEtx9m4juMzS+ePcgXa7HF94vZSPKHW2pxP9kq
         x7cyPxqZAn7dpAauol+tX5n1Yyejh64taMlTY4RZ5WplYCzU5dQ1ikylgl2ZNZINF4HZ
         jAyn6owyhJYOZfhadrPUl7QIoUBanrUoqv/V6fZh4VoU/r3ynEbhf89qOEGFOktCAw0X
         FyrmaU6dSjOwMtwPmvi8n/xVPQO+7duy2+e+xpR9sd4gf06/pu/KoxcAL41ICN8TyGNL
         EC2V6AHqD8cuiInmQQsBhhTEdh61NS7armcPoGwB8YBXsS56I80KkRVUEkuggjCUFLlQ
         KqWQ==
X-Gm-Message-State: AOJu0YzuxcUAd1Iocog4k7gAzJEXq2SN9R3K2cmL0BP+VBbaAMkf1GdH
        ptND3A94WW3FZHfWp//zFSj5r63TWMXRXfxR6Go=
X-Google-Smtp-Source: AGHT+IH/8k8q7IzfHsj73FObfHzZIvZfpdU6unzS/7brkbfWMGYYzhZQkRLzrdd7Kxmnv/6VBAesQg9Ip9V7kZKp8qo=
X-Received: by 2002:a25:257:0:b0:d48:7988:15e0 with SMTP id
 84-20020a250257000000b00d48798815e0mr1496362ybc.6.1691654189388; Thu, 10 Aug
 2023 00:56:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230628171108.1150742-1-gary@garyguo.net> <CANiq72miVic=P+qSobuUqXoCuKW30_tT_buD8MyEsyVb_uoj6w@mail.gmail.com>
 <20230809230249.01ffc009.gary@garyguo.net> <CANiq72nWArGsvWVVknPdAVYUbWqJKfwOAVCRUmLnuAHAHP+rSQ@mail.gmail.com>
 <2023081043-cake-catwalk-1ba8@gregkh>
In-Reply-To: <2023081043-cake-catwalk-1ba8@gregkh>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 10 Aug 2023 09:56:18 +0200
Message-ID: <CANiq72=-NffQz9jMxoznoRGkeQz+1oTb6__r3c1z+BzOsWxfRw@mail.gmail.com>
Subject: Re: [PATCH] rust: macros: add `paste!` proc macro
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
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

On Thu, Aug 10, 2023 at 7:08=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> The kernel will migrate when we have converted all files in the tree to
> SPDX and can worry about things like the SPDX version level.  We have a
> ways to go still...

I see, thanks!

> Be VERY careful with dual licenses please, and especially non-GPL ones
> in the kernel tree.  It gets tricky very very quickly and you need to
> know what you are doing.  So much so that I really want to see a lawyer
> sign off on such a thing so that everyone involved understands the
> issues that this requires.

It is the common one used in Rust projects, which we are using for
other bits too, e.g. vendoring the `alloc` standard library.

Since these couple functions are essentially a compiler plugin (a proc
macro) that is useful in userspace and other contexts too, Gary wanted
to use that license (he contributes the other kernel code under
GPL-2.0). For instance, he may possibly want to put those functions in
crates.io or similar, I imagine (like the linked crate this replaces
as a simplification).

He is also OK with GPL-2.0, so we can just do that here, of course.
But I am mentioning the above because, if this one is problematic,
then perhaps we should revisit again `rust/alloc`, our `std_vendor.rs`
files and the `pinned-init` library (which all use the same dual
license).

> Otherwise please, just default to GPL-2.0 for kernel code, unless you
> have real reasons why it can't be that way, as remember, the overall
> license of the codebase is that.

That is our default, definitely. I OK'd these two functions for the
reasons above only.

Thanks for keeping an eye on our list, by the way.

Cheers,
Miguel
