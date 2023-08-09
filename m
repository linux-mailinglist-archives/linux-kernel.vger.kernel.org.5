Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8E7776CB8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 01:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbjHIXVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 19:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjHIXVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 19:21:09 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAE1E75;
        Wed,  9 Aug 2023 16:21:08 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id a1e0cc1a2514c-791b8525b59so99940241.1;
        Wed, 09 Aug 2023 16:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691623267; x=1692228067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k5o9z8rIozKDSWMTZU5ytSG47Bk0bLqtkW/aG47vTbQ=;
        b=Jf4T6AMa/ohS1+2qM35/DkAfQJj76hPqJFrRE7fEADiiE0jnz0b1mNgeWfZqcmEFeU
         R/a/pkbuPS+lsQWTYUBVn7HAf7zBSFZfHu951lrOKFzWoTPzBv8DVnptc85rTQUE4nPH
         KWW9MjGtj0dz3r0o3OeuJiCiUU5oMBXZggbcKUyYoqiyjZdheznqno0hedR7VIJNSbh1
         4U288qLcHkohljB6pgTL9ryznkKsi/6tQlTuk+XUqeg6R2geZHQx8aACKOjynf4vMTQo
         mC8W7a70i6XdSQDwuNjKK++R9yhzccVNLlfPUIJDtk1dsppJALDACS1tCkYNyRaZ/UdI
         xdWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691623267; x=1692228067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k5o9z8rIozKDSWMTZU5ytSG47Bk0bLqtkW/aG47vTbQ=;
        b=X4cWfagQIHzyC+9nCLv0jwktzZ/rhcAZ4AqUE4pZMzmP0bph1kO3RJJm4577+SocTY
         sbn+b6f6VAc20dKsGYX1/V/i+8OYASvqEObYgohgz7ZLBWZunN3xxM63t7rB38GNU2he
         F4q9gbdDXX0UaPc5ghbVlQxUwTcdV+ETzDcoOa1Ei4sFXUd/TKaOCDDJjkYtpIda4L8n
         27lyAzxmvnn6l1H/TTMSRHCrnt/KS470j84tw3aBQJLrza8tvvLKw5PNNFsvAVSjgBsp
         L+L4thw1VzI7rTjymJsDh4MxGM3rryE1dqy5kfouUv1HqrHNWBJBpFx1QJfyAIEaWUdV
         cOCQ==
X-Gm-Message-State: AOJu0YxuNOdEaxkdTO00PJpNgiLutq49F+dUhQzZ5x85xfs1U+Kd9cTe
        SxAS/VBMKm0rnInHiHaWB9JJn/9FEa0e854CYVQ=
X-Google-Smtp-Source: AGHT+IGqPUs/d80Szj9z56iymuDqM5vj3EeTgPS4VDiZqmrFqxhEWSd6fHGyQVSFkNuuJWPw7w4fy99kM+1/sJu3VMs=
X-Received: by 2002:a05:6102:156:b0:447:4432:7400 with SMTP id
 a22-20020a056102015600b0044744327400mr581937vsr.16.1691623267476; Wed, 09 Aug
 2023 16:21:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230616001631.463536-1-ojeda@kernel.org>
In-Reply-To: <20230616001631.463536-1-ojeda@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 10 Aug 2023 01:20:56 +0200
Message-ID: <CANiq72=EpRVK14-ShY7zdKmNLTfXMz=JdU5YPcivVN8TDpF0YA@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] `scripts/rust_is_available.sh` improvements
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        linux-kbuild@vger.kernel.org, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
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

On Fri, Jun 16, 2023 at 2:16=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> This is the patch series to improve `scripts/rust_is_available.sh`.
>
> The major addition in v2 is the test suite in the last commit. I added
> it because I wanted to have a proper way to test any further changes to
> it (such as the suggested `set --` idea to avoid forking by Masahiro),
> and so that adding new checks was easier to justify too (i.e. vs. the
> added complexity).
>
> In addition, there are also a few new checks in the script, to cover for
> even some more cases, which hopefully make problematic setups easier to
> identify and solve by users building the kernel. For instance, running
> the script externally gives:
>
>     $ scripts/rust_is_available.sh
>     ***
>     *** Environment variable 'RUSTC' is not set.
>     ***
>     *** This script is intended to be called from Kbuild.
>     *** Please use the 'rustavailable' target to call it instead.
>     *** Otherwise, the results may not be meaningful.
>     ***
>     *** Please see Documentation/rust/quick-start.rst for details
>     *** on how to set up the Rust support.
>     ***
>
> I also changed it to avoid setting `-e` as Masahiro suggested.
> Similarly, I now check for `$RUSTC`, `$BINDGEN` and `$CC`, instead of
> `$MAKEFLAGS`, as he also suggested (but I gave it their own error
> message rather than use the `${CC?: is not set}` approach. This goes in
> line with the reasons outlined above, i.e. trying to give users a clear
> error of what step exactly failed).
>
> In the test suite I included previously problematic compiler version
> strings we got reports for. The test suite covers all current branches
> in the script, and we should keep it that way in the future.
>
> The patch series also include Masahiro's patch to remove the `-v`
> option, as well as Russell's patch for supporting multiple arguments
> in `$CC`.
>
> All in all, this should solve all the issues we got so far (unless I
> have missed something) and improve things further with the new checks
> plus the test suite to hopefully have an easier time in the future.
>
> Testers for this one are appreciated, especially if you have uncommon or
> custom setups for building the kernel.
>
> This could go through either the Kbuild or the Rust tree.

Applied to `rust-next` -- thanks everyone!

Cheers,
Miguel
