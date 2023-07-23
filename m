Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A1275E2A3
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 16:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjGWO14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 10:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjGWO1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 10:27:55 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C34E72;
        Sun, 23 Jul 2023 07:27:53 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-c01e1c0402cso2762184276.0;
        Sun, 23 Jul 2023 07:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690122473; x=1690727273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HFiEDMhSpzLopPoOlxDs4RsXxTglhVRYk9wnNiaoU+k=;
        b=MgzRVzh3ZoIlTtu5Rl8dFU+0y9ZM5ybnecxFcj1xrbAagKWs2YTjOedKvokIU9O7Oh
         crpfbGyfIsl2XhsK4jzXExTAZlCnT+wopexNXvLs4MdR4UehZr3wQ21yBVIchbZNlleV
         jVIPiXuX0rkExO+zzR5jybEwV2/EaXmQmztjEWZy3bhQ8FzlpYpzYHmM8uIVDUE2ksxY
         n5mJy/OSuNCqKm0F5zWNS/6idr1cOnfz8U1/QS9gOZQDWE27+Yxa9hrO7fa6PN6InsBQ
         m0g3ylDXHUi4MEGEJD1dzKQWkkGEjXApzfRtJ/vVWaDahvjRgiwsxhxdaJv5Y7yqxb7f
         zf0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690122473; x=1690727273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HFiEDMhSpzLopPoOlxDs4RsXxTglhVRYk9wnNiaoU+k=;
        b=QDKsjAzOZUbjBWpsA0rkPFDLxLGhllXukiJfJD1vjKRg9RLscVeE/0MqF77m487y7m
         9WtxOWwRauPdNBJy4rEUZyvCrwHo7PmnPzJ7QPOvWp3T3Uk+ZyfCkOX/Sitq7eC5JGSY
         dTEq53q9OLFy+DT/mj8c4c/RLiwftLmwtDphkRW6ZCqC2Ekc9zx6ly0Qg/V4NUSh9Lkt
         yfXAvHyvzm+KOhjSqO/g+ymIIu0BZgpyLrTBFrGASFZosU7MeBfot08A5Vi5vE1n2c7C
         k6hkpphQL2xhVMVeLq4qpJ0EvwjWjtsut/yYVhF+PfAjCW7wdnPS0fQYAiRy8YKJB+B8
         6x5w==
X-Gm-Message-State: ABy/qLYG3JDPwZ6zIfi72OrSlOq6c616y1+MgWhYmaCFxCtSXRoOF3dX
        J5+JkvBsriOBYH2/jkh7z8wXX6pn6tjBDVpDNuMGOhh+9g0=
X-Google-Smtp-Source: APBJJlHKjY4S91COs3SvmMr8xgjcPvakjvQDa3/QiQBlB6ZxUeFGQ6i9syJCna6ZBeQXdxliBsCVBQFatVghbOFa5Po=
X-Received: by 2002:a5b:c6:0:b0:c5d:1407:f2bc with SMTP id d6-20020a5b00c6000000b00c5d1407f2bcmr4649024ybp.17.1690122473065;
 Sun, 23 Jul 2023 07:27:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230718055235.1050223-1-ojeda@kernel.org> <CAK7LNAQ-hjW_19fjA+E-bQCrXcVPdN4-GvzAnEnYzna5KRVXew@mail.gmail.com>
 <CANiq72kZjOGvRKoRxtgG=2DhJnMJK9TCQtTmeef_B=nLcLQD6g@mail.gmail.com>
 <CAK7LNASqumGb0xvSa8n4Heasz9BKxgk4mvzNXsfFhZE1G+Bxbg@mail.gmail.com>
 <CANiq72kD2wxXy2ri8sBhVJ4y-JJiq+kYt_MRZwuwB9uGkX-_jQ@mail.gmail.com> <CAK7LNARm1LevTQVw1j5pQjp_gP=6-4CiwXLRDXbVH3bnC0OCxg@mail.gmail.com>
In-Reply-To: <CAK7LNARm1LevTQVw1j5pQjp_gP=6-4CiwXLRDXbVH3bnC0OCxg@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 23 Jul 2023 16:27:41 +0200
Message-ID: <CANiq72m0ZnVNj5p8LApsBJO2NWZ2-wnr4hdP6qhgkvBnLdXWsQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: rust: avoid creating temporary files
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        linux-kbuild@vger.kernel.org, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Raphael Nestler <raphael.nestler@gmail.com>,
        Andrea Righi <andrea.righi@canonical.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 23, 2023 at 7:06=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> Can you send v2 with the following squashed?
>
> I think it makes sense to fix both if we add
> Fixes: 295d8398c67e ("kbuild: specify output names separately for each
> emission type from rustc")

Both done [1] -- I marked the `Tested-by`s with "# non-hostprogs" to avoid
losing the tags.

Thanks!

[1] https://lore.kernel.org/rust-for-linux/20230723142128.194339-1-ojeda@ke=
rnel.org/

Cheers,
Miguel
