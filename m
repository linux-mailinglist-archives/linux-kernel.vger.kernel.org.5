Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4867D6D1E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 15:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344550AbjJYNaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 09:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343840AbjJYNaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 09:30:11 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1CE132
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 06:30:08 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id 71dfb90a1353d-49dd647a477so2094542e0c.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 06:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698240607; x=1698845407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9FCfEKDsSxj0UbnaNrhG13AiQF2xaylJwEFbU7V7KMs=;
        b=hIktdwxpd9E3a7a/b45fH2I/23koFstKRUL0OUVCY/6eEPeerRP8Sk0f+GP044xPj2
         fM+6cmb8yqX7AXWr90cqddHS7krSZZerL5gWsAy2xNonzoCTWwN6RvZ+gAYK3gT6hjil
         R0o+6KxKkSet9cDuNKgZJLOVEorn1vjyoWDg2nVQhiyD2MYZRqwPkk5LMladSs8MHiYr
         QtCiaSd72ERGxRwIgLNazjmOr/JPeyl986oAbHU4u+c0c4sZM9oXq8C81uMgLQ7fmB/c
         Y2p75VP372Ybhmd73h/xysJ9zHCbhfz37FQsGQGjng2wReEZah9glRoMYvgP5oirYbSR
         caNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698240607; x=1698845407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9FCfEKDsSxj0UbnaNrhG13AiQF2xaylJwEFbU7V7KMs=;
        b=cARuosKP7JGOUmyH5MLiHg+Rp6SrU9P6jtjYF2jd9z4VhVgWxfURBPgz5+PeZM88Fn
         WC/53tBW4ouPxO7K1eGuQ+H8iedf29BOzfsvETfjZy1w4HRemKISce3xTeTohbU9P3QN
         ZBiMCdSwEJZfEzXMHg7DFCLhsX6tz8Yj7pr/dQQfAhhtKhZw54ZyUiYZlUR03vxl0vo/
         QvBJiL1g8kOwgqFMgSSJ9lfWKe8z1pr0hYnvB56QZXPPGuwZxvx/WbiNaSoBqHLWlc/a
         XweKWm9fAIt7ryI4Z3Q4sdy6o7OZxBAsqGbSKZgM1zCK93K6M1fst0o4TlHZCK7ARDM0
         iV+A==
X-Gm-Message-State: AOJu0Yw4ChvDBop8I6ATD409sxdntCkMon3cyB/x2wU5zidgO93Xtcc5
        ax29btL/9brk8d5Jank7UeEMRCGET9Egma+0tIbFsg==
X-Google-Smtp-Source: AGHT+IEZIO89GvjY7p6Onv9qJsiFS8XSTMJNgINxOt+FqqhdyaLpY0c4XnNgQgLeJNXkNJv6us7+wxUzs2ulyGkppzw=
X-Received: by 2002:a05:6122:d0e:b0:49a:6742:b176 with SMTP id
 az14-20020a0561220d0e00b0049a6742b176mr14979846vkb.16.1698240607437; Wed, 25
 Oct 2023 06:30:07 -0700 (PDT)
MIME-Version: 1.0
References: <20231019171540.259173-1-benno.lossin@proton.me>
 <1cc11492-248e-4b37-9608-b475acde3da2@ryhl.io> <06d27457-6b6c-4392-9be1-d1fecfbfd9f3@proton.me>
In-Reply-To: <06d27457-6b6c-4392-9be1-d1fecfbfd9f3@proton.me>
From:   Alice Ryhl <aliceryhl@google.com>
Date:   Wed, 25 Oct 2023 15:29:56 +0200
Message-ID: <CAH5fLgiT4A1jMcsUhPdnXZC0cd=GMWuwDmLjnAGxe55+9HBiJA@mail.gmail.com>
Subject: Re: [PATCH v2] rust: macros: improve `#[vtable]` documentation
To:     Benno Lossin <benno.lossin@proton.me>
Cc:     Alice Ryhl <alice@ryhl.io>, Boqun Feng <boqun.feng@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 9:01=E2=80=AFAM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> On 21.10.23 14:45, Alice Ryhl wrote:
> > On 10/19/23 19:15, Benno Lossin wrote:
> >> Traits marked with `#[vtable]` need to provide default implementations
> >> for optional functions. The C side represents these with `NULL` in the
> >> vtable, so the default functions are never actually called. We do not
> >> want to replicate the default behavior from C in Rust, because that is
> >> not maintainable. Therefore we should use `build_error` in those defau=
lt
> >> implementations. The error message for that is provided at
> >> `kernel::error::VTABLE_DEFAULT_ERROR`.
> >>
> >> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> >
> > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> >
> > There is a minor nit below, and in reviews sent by others, but overall
> > this looks fine to me.
> >
> >>    /// # Examples
> >>    ///
> >>    /// ```ignore
> >> +/// # use kernel::error::VTABLE_DEFAULT_ERROR;
> >>    /// use kernel::prelude::*;
> > I probably wouldn't hide the import of VTABLE_DEFAULT_ERROR from this
> > example.
>
> What do you guys think of putting the const it in the prelude?

I think it's fine to just import it.

Alice
