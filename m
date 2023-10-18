Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 648687CE311
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 18:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjJRQlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 12:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjJRQlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 12:41:24 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53A1111;
        Wed, 18 Oct 2023 09:41:22 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5a7fb84f6ceso86447857b3.1;
        Wed, 18 Oct 2023 09:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697647282; x=1698252082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E3VlPSQFKxSvHpa9DFEsMWBHHBdkSCrb3dmsVnDHyyA=;
        b=arX6Y0IhMW/ZCvW60tvyCbV6TUELxWfTx5hv/ER2NYbaYdIkl79OghfvzPwVPrpQ1k
         fD2filkQqLqGYWXS+Hk5la+AGXuRZKSjovyBeoPsqYh5/Ra6HgJ0VDLAUR3G5zRLQp6k
         zKToUIUDCK7zZ5SLs8Yl5zoItF5jStGauePiOVzRxh/qPhaowkElQEgjmocf1x0A2lYI
         XXWpzKMGqfIA4YUQTEH5RixObUEVLfQ5tZw/Khs4/uKA6AC8RwV534uOYmYF3JRjirLk
         9KOcJ2BXfdieUv2YzRgDyli+hXGORSvZLblg62WX96QctMPAW1wdWyC99InBDeOnSjuw
         +yiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697647282; x=1698252082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E3VlPSQFKxSvHpa9DFEsMWBHHBdkSCrb3dmsVnDHyyA=;
        b=LYfIOjeoKfCGYqiLXgQJltLrcNVRM5LUO8YT3f5MN2wknkXFWP/OXzVRk7BaMzzwS9
         hIqVXOxFi0NZ02quvWocs9O2mCZNJw09Hi6znciScgFF4V2y+DJQjLONujVzaocgXxWz
         2r8jhP/X5OEfvDsuHzbiDJXgTpjyU/h9u192dd04QI4xJu8dz9OTP4leog642/ePjGDS
         OKb9hIiLk6SrF/MyeBo+3rBtB93gyU6pZUhTdajdfSBR4DrdBsCpKXT8AAPhwA54Yfqs
         1ZOZ/BMQMTcmY4Q6AKMWju6mjRXBUO+Mt0jWDuDanAGvQxL+Kwt2aWAi2xL/DOUVG9gU
         rcuQ==
X-Gm-Message-State: AOJu0Yz3JwIfYZzYIWkM/15wTq6V9o0b2GfxtzSjGnMJWa673zXqh1Sv
        Vc6HjkuOK+jy8/75orlf/l13OlgJBLPYBdTd3wo=
X-Google-Smtp-Source: AGHT+IGeMWtpzMDExoSuABmjNGqR3PFNyAVZrVg+01vy33KHXMOMHhwIQ38DWCms00XgIn2FEgV/uD7AmSicFFB5XUc=
X-Received: by 2002:a05:690c:d89:b0:5a7:aa7f:17d5 with SMTP id
 da9-20020a05690c0d8900b005a7aa7f17d5mr7105458ywb.11.1697647281835; Wed, 18
 Oct 2023 09:41:21 -0700 (PDT)
MIME-Version: 1.0
References: <20231018160922.1018962-1-ojeda@kernel.org> <d47553f1-1832-4c69-8a8c-71c58048ff30@lunn.ch>
In-Reply-To: <d47553f1-1832-4c69-8a8c-71c58048ff30@lunn.ch>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 18 Oct 2023 18:41:10 +0200
Message-ID: <CANiq72=E7TPLcq-yiQF9E8a33ghbogPcbv-yMqFKBxMQ0oOxNQ@mail.gmail.com>
Subject: Re: [PATCH] docs: rust: add "The Rust experiment" section
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Miguel Ojeda <ojeda@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>, linux-doc@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
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

On Wed, Oct 18, 2023 at 6:27=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> It very unlikely end users read this document.

We can add a note to the Kconfig symbol too -- would that be OK with you?

> And that statement is
> not limited to end users, it is true for everybody.

Agreed, but that bit is meant to emphasize that end users do not have
a reason to use it at all (unlike kernel developers etc. from the
previous paragraph)

> What we should be saying is that Rust for the Linux kernel in general
> is not ready for production use. Developing drivers in Rust is
> currently for experimentation only. Given the experimental nature of
> the work, there is some risk Rust will never be ready for production
> use.

The risk is that Rust gets dropped from the kernel because it is not
used enough, not so much that there is a fundamental problem to solve
in order to reach production.

Cheers,
Miguel
