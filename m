Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC6C7CEB82
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 00:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjJRW5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 18:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJRW5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 18:57:30 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86A4114;
        Wed, 18 Oct 2023 15:57:28 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5a877e0f0d8so1704937b3.1;
        Wed, 18 Oct 2023 15:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697669848; x=1698274648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AE1SaR/BHQxenJ33mN0ItySiN6Ep+fGPSaWs9qSQa2Q=;
        b=hxPLh7NSkHY+wXqwwUwySB0xQaqg+1BVE/hdb6rnPdkrhXrK9ukLalozC6PJBhJmMt
         A+SJruIWxqrGffLbOsZAF2yEzjslYYuiGrq5dfGod+x4Yn/+boPOjFwdgjeYaJj47Z0e
         uI124EgCE9WokhGYmbifKSfonyD4AswTycobzUrKNgXdbpQN6j6nOsUFkGEEzFqQK8gS
         6teK4xDeffiJuOKaoEPh5a7ktUN0ZsZ6swsrpoe/EI1VRp8jPIKI1GlT6hLE27TATiQL
         FaxT1eEKo3OTRgLGqryK0q8N2/3AjQNLnqKfhVnSKjCv9qM1sHpWYVdi2+LJTScxj1Es
         6ILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697669848; x=1698274648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AE1SaR/BHQxenJ33mN0ItySiN6Ep+fGPSaWs9qSQa2Q=;
        b=RoZSfamasYgNmD684fPCXlxzs3m0Akb3ffLbffS4879eNizlLTkv8DV1lezGodr5ht
         57l7sg6VE+F3ZKyxmrbIJ0Ndb8bKJ0DFXi5CtLmy5Frulczyv8H1Tku13KYI8RduuH5i
         /hxdwwlIRkNgZOO3NkHsd9uqyfUEHM+A3pwtwLhj+IZNODGHIJcKcCxfQTU9su/UFVkf
         ApI4HOmYbcE/EXsCojVEF3mlnEQ7BHnzEGuntXd6t1b7pGz8gI8HR4/0tMBkPQenuw9D
         TkNiAmfTPBKJWX3hJ9Xe/Lbh8MQ9hfya3mg112IZKNTzjc183LFPAecW6BkVQFU5cm6+
         +b0g==
X-Gm-Message-State: AOJu0Yzz/qbkwaCSCSDw+d3eERX4td1H6+WgfYil+OKCwbmts+zBExjS
        SGssc0vL/rX5yf1Z7d2jlMUOcowrGseh0UtYKzjKEpskXp9yLCei
X-Google-Smtp-Source: AGHT+IEhExAjJ/kqU13bH/iu+1hTB73pJsYiyEBFRfajbn0eLIbp0DQbJge+BtAiBbYc9eQEJDm8R0y65x2ghEM15FE=
X-Received: by 2002:a0d:eb4b:0:b0:5a7:c887:43bd with SMTP id
 u72-20020a0deb4b000000b005a7c88743bdmr182981ywe.15.1697669847838; Wed, 18 Oct
 2023 15:57:27 -0700 (PDT)
MIME-Version: 1.0
References: <20231018160145.1017340-1-ojeda@kernel.org>
In-Reply-To: <20231018160145.1017340-1-ojeda@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 19 Oct 2023 00:57:16 +0200
Message-ID: <CANiq72=_jGC1YR+9jHxYn9w68iZoC9sHoXdXqGu6qGxzriEkwA@mail.gmail.com>
Subject: Re: [PATCH 1/2] docs: rust: update Rust docs output path
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Carlos Bilbao <carlos.bilbao@amd.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Akira Yokosawa <akiyks@gmail.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>
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

On Wed, Oct 18, 2023 at 6:02=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> The Rust code documentation output path moved from `rust/doc` to
> `Documentation/output/rust/rustdoc`, thus update the old reference.
>
> Fixes: 48fadf440075 ("docs: Move rustdoc output, cross-reference it")
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied to `rust-fixes` early to start getting some time in
`linux-next` -- please feel free to send more reviews, thanks!

Cheers,
Miguel
