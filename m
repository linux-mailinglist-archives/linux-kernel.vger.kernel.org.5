Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C327B4D36
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 10:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235814AbjJBISX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 04:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235809AbjJBISW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 04:18:22 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBBFD8
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 01:18:19 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-7ab4c86eeb0so5376512241.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 01:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696234698; x=1696839498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fzGsF0rzQfJ2PSb9vQta/54VjhELfW04Cn5cgB+veoY=;
        b=2VZoskpY8CB3Bl80MW8tT3w0+t3zNEZSuAo0/YMtpN+yb6ivR+iyjXwhmL1K1rf2MB
         iiZEAi1eLpgwjRSDe+1ALVti28AoIBEy6Z52Yv/QTcEm2qXy8156wTrXzzuK2majr3um
         jKtn8R6jC8DmJJY0iNjIsGiNI2NcsXx3coTGWMa7HkItfKrDh9o0wBWmeMHy4L6Y5BM8
         zBTXrGeDhecHbNT7uIJiV76hsPAqPymCgpNdlmhTen7LXSF3r3tGyiQVPa2KLnc/e2Wn
         loh7L2SlrLHBq/ICJZ91an0SNqJdzADr7IcBv5YxovxSqed8Y8ne7FjgHf+YxeUcOhoO
         Xogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696234698; x=1696839498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fzGsF0rzQfJ2PSb9vQta/54VjhELfW04Cn5cgB+veoY=;
        b=IkaYIR7Ch3NWKYdQxmdHlH1FwWAAv0rG6+zZdW0DVjvbneDpCYoOs+URqwk8i8vKb6
         cFyoxosp6koUsCCBXhcNJ1hxIYd0YkecR/n9QWsL5crjKUMWovwXG0TA1+M1GCjpCQie
         1q94RI0K4/DprUScuoszUi0QFuz+UzT3q99200PphrLTl2ok/z1bSro4k1Vud4n8XMXb
         NfUQ9IZJ+FtHihoQC1c5Imhn90T3S2+aFLjm8FhvOx0ujX/fLWGJ6GXVXVWaSo8rj7ID
         /X70F5eae3eS20L/79ZGCiaDOcP4YuXn71Vg4goiBidmPq4gjcuFGbYVuPYJ5hngLuXh
         PhJA==
X-Gm-Message-State: AOJu0Yz0MykYF17mSgXybR6V6sr25ULjqSgadia9p3VroNNNT1pykewG
        ZA0J7fkN2w2BHSEfX4+ficRrdPezkvb5KfEViMGbHw==
X-Google-Smtp-Source: AGHT+IHNKNGh7AYwLVhrXE3mmbjF4Lf/z1rjAVKz9QkAX1cFb5lJWqWaTN2K7r0ITPz7PTVM6uJ747xF8Gt7sVyM2sY=
X-Received: by 2002:a67:f818:0:b0:452:6ac0:ed19 with SMTP id
 l24-20020a67f818000000b004526ac0ed19mr7834838vso.31.1696234698016; Mon, 02
 Oct 2023 01:18:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230928201421.2296518-1-mmaurer@google.com> <CAH5fLgjmPkfokku190dab9JVqk3_uTABNWqOZ-xKOEqQJoX+9g@mail.gmail.com>
In-Reply-To: <CAH5fLgjmPkfokku190dab9JVqk3_uTABNWqOZ-xKOEqQJoX+9g@mail.gmail.com>
From:   Alice Ryhl <aliceryhl@google.com>
Date:   Mon, 2 Oct 2023 10:18:07 +0200
Message-ID: <CAH5fLggO4FP3JHdA6QtU8fK9yzFtnAk53=bbKF2++23bA+ML6Q@mail.gmail.com>
Subject: Re: [PATCH] rust: Use grep -Ev rather than relying on GNU grep
To:     Matthew Maurer <mmaurer@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 2, 2023 at 9:51=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
> On Thu, Sep 28, 2023 at 10:14=E2=80=AFPM Matthew Maurer <mmaurer@google.c=
om> wrote:
> >
> > While GNU grep supports '\|' when in basic regular expression mode, not
> > all grep implementations do (notably toybox grep, used to build the
> > Android kernel, does not). Switching to grep -Ev enables extended
> > regular expresions which includes support for the '|' operator.
> >
> > Signed-off-by: Matthew Maurer <mmaurer@google.com>
>
> LGTM. I tested this in my Android build.

Also tested in a non-Android build. Works both places.

> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Tested-by: Alice Ryhl <aliceryhl@google.com>
