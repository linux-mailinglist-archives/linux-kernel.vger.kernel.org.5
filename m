Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3179E7BD59B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 10:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345529AbjJIIsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 04:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345490AbjJIIsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 04:48:50 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6883BA3;
        Mon,  9 Oct 2023 01:48:49 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50435ad51bbso5084269e87.2;
        Mon, 09 Oct 2023 01:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696841327; x=1697446127; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wgoMovMkZSAvfqa8PGZ/v+zEqtovHRzU+CUakuAURFw=;
        b=VTgTiD5Jc7FLqi/zHR+VOWqdGfZg4/JtXFd8lAZQhRymskaFcA5s9req4DTYhlhWuX
         gyajzAhRmP31s0x3LJ6FT88iYCaFL3sRA1iwJUuaKTAV8Ac64Gc6QbNl1UvPUgTCzGEo
         4/u/rYA9ehHMk9zA4mHBMcdgWhprBVJgA61QomvtTuxesdWAFSAylQaAd1xFqrjfRIco
         xQ9xJUBiU9tg+/2yoBG2cUe3Db2rUi95FtwoWnf9KVJDTkB2yAk+wL5pmIJTh5gkFqnb
         pEg5AoqxJQzxLq3r5t++kcaJkhPWH/yaox7WxkBYQRLz/VFLIKWfT1OERatVzJrJ/KWp
         CaxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696841327; x=1697446127;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wgoMovMkZSAvfqa8PGZ/v+zEqtovHRzU+CUakuAURFw=;
        b=ikEjgLWH+YTC5Y3AMtmyJn9jwE6iy0I6mVUP21rDV6AqbjSD9JpM5p13wE/SkL87ZJ
         46GrY7bjvK1NdG83LOszjznxTtqJx4t9V7kzyPm4KEAW3wU029wzMJ0aYi1AKjd4jBD4
         QqbMtG4TKROy/+zODXhvI2tw6yVcI89MSVtLf+MisLZo631PDZxjZudn8heIsV9GZ2IA
         6xpsngRroh8eVu5vECpizATnyhhmD6Vt5z2CDamNix8m583IuEQfT7nD7J2jeS6L96jp
         ZLy9i7ejS0IM4CZ4dy7i32QiYYxWsnMpn/pUvacig9InaYpNkxrePi10rrVElnT5In7J
         tu1A==
X-Gm-Message-State: AOJu0YyDv9LoO50ylL7b8OTWYI3Flkju42Ps9tCzvfUE1gfPAhlBFv54
        urYdIxvjqsY3CRDm0VuM3Rg=
X-Google-Smtp-Source: AGHT+IHhcU61xBBMKUOeAY+GkinxHfngiCQlhzFkKDaovUc9VGDTf0uGVwn3pv1PsqFdx4nfWpAV0Q==
X-Received: by 2002:a19:8c48:0:b0:504:3a7c:66ce with SMTP id i8-20020a198c48000000b005043a7c66cemr10896001lfj.68.1696841327347;
        Mon, 09 Oct 2023 01:48:47 -0700 (PDT)
Received: from localhost ([146.70.182.19])
        by smtp.gmail.com with ESMTPSA id y2-20020a197502000000b0050467be30ccsm1361737lfe.89.2023.10.09.01.48.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 01:48:47 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 09 Oct 2023 10:48:45 +0200
Message-Id: <CW3S1RNMMQKE.3DP29TLAE53AD@gmail.com>
To:     "Miguel Ojeda" <ojeda@kernel.org>,
        "Wedson Almeida Filho" <wedsonaf@gmail.com>,
        "Alex Gaynor" <alex.gaynor@gmail.com>
Cc:     "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        "Benno Lossin" <benno.lossin@proton.me>,
        "Andreas Hindborg" <a.hindborg@samsung.com>,
        "Alice Ryhl" <aliceryhl@google.com>,
        <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@lists.linux.dev>
Subject: Re: [PATCH 2/3] rust: print: use explicit link in documentation
From:   "Vincenzo Palazzo" <vincenzopalazzodev@gmail.com>
X-Mailer: aerc 0.15.2-211-g37d5fc691aff
References: <20231005210556.466856-1-ojeda@kernel.org>
 <20231005210556.466856-3-ojeda@kernel.org>
In-Reply-To: <20231005210556.466856-3-ojeda@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The future `rustdoc` in the Rust 1.73.0 upgrade requires an explicit
> link for `pr_info!`:
>
>     error: unresolved link to `pr_info`
>        --> rust/kernel/print.rs:395:63
>         |
>     395 | /// Use only when continuing a previous `pr_*!` macro (e.g. [`p=
r_info!`]).
>         |                                                               ^=
^^^^^^^ no item named `pr_info` in scope
>         |
>         =3D note: `macro_rules` named `pr_info` exists in this crate, but=
 it is not in scope at this link's location
>         =3D note: `-D rustdoc::broken-intra-doc-links` implied by `-D war=
nings`
>
> Thus do so to avoid a broken link while upgrading.
>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
Reviewed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
