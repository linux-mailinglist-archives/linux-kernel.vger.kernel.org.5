Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0C375B5A2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 19:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjGTRaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 13:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjGTRaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 13:30:07 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E811BF7;
        Thu, 20 Jul 2023 10:30:06 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-bd61dd9a346so957017276.2;
        Thu, 20 Jul 2023 10:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689874206; x=1690479006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SCJQ65+7aQZac8L3veadNqaoOqxg9236xCtIGRaxWKA=;
        b=Vy0VLb8pBIRmkm/OCgFwCyVIHkdJkylVc+Hzceus7ZHA7wAZiPd1yx84YA+isdig02
         n9d9fo6a3ztiX81rtlbE20h6PR9YIXVXeKpFms6fadk9pnq9odSijinC8O/JL+qCQSfR
         GbXl9Jh2DBWBEY55CWGUmif9q5enGEF9UAZTNBxb43g2mc6d5RHI96pDNXMsBClswwcF
         gOxagc+I8oyWGwbWwVm7aPra4KhexdMQ+m4We2YQOKcTOuQD3JPKt9EsLzSa5hmW6mZh
         jetcV+WhXoikm5YfxU5IUZOjB0KTBO4K9rCS0l+KV/TWbY4eENQVyaYl7r7yjZpuOK+X
         TbwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689874206; x=1690479006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SCJQ65+7aQZac8L3veadNqaoOqxg9236xCtIGRaxWKA=;
        b=cPA5ihzVn2vHp3YOR/HYxQiuycmtFAEVMgRip4YYR4HNqQGb5URVJDQXkkwBwgFqgu
         rj4mR3wKoOVFssfgWMqsNLERx7+UMM/6JU6IeSQ8Ueh43j8jno3eeXYHL1iaD6vBK8oz
         HucoploVfgo6RQNMDThH4QTotijJgMnl3F3mHsMsYgf63YVHwuSMafeNKBfSGd4icZkg
         DMxSNXS1/MnGKA70cfrxpIM0P2eX4K7RQocQvoTJiUuxmbfEZ+IotWdlyPjM8t/5lJRk
         z6nxbgnWh8rAl/hGvwQt8MW+uNd7/gAON9jVT2SiRwfc3hBcn+jQwxLHhN15sonz6EGE
         7/Kw==
X-Gm-Message-State: ABy/qLbqP8542K+xSq6kFKh04apLd6WI6I1ShsW3oU59OX1H58PHW0h/
        1M22Ad/JxR5c9W6BfCnvra2ROdrah+Fh/dfkJCE=
X-Google-Smtp-Source: APBJJlHbTOValRmB/GshYtHb4Ajg/BgY2O7fJVdJ6AqgyDWmi+wB4sVPiYYN+prjLl1boydok0lSDcaStxx1GIZ4igs=
X-Received: by 2002:a25:910:0:b0:ce7:ee46:debd with SMTP id
 16-20020a250910000000b00ce7ee46debdmr2953145ybj.16.1689874206039; Thu, 20 Jul
 2023 10:30:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230718055235.1050223-1-ojeda@kernel.org> <CAK7LNAQ-hjW_19fjA+E-bQCrXcVPdN4-GvzAnEnYzna5KRVXew@mail.gmail.com>
In-Reply-To: <CAK7LNAQ-hjW_19fjA+E-bQCrXcVPdN4-GvzAnEnYzna5KRVXew@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 20 Jul 2023 19:29:55 +0200
Message-ID: <CANiq72kZjOGvRKoRxtgG=2DhJnMJK9TCQtTmeef_B=nLcLQD6g@mail.gmail.com>
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 7:18=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> Applied to linux-kbuild/fixes. Thanks.
>
> I believe this is a fix, so I will include it
> in my next pull request.

Thanks Masahiro! Yeah, it can be considered a fix. By the way, in case you =
want:

    Fixes: 2f7ab1267dc9 ("Kbuild: add Rust support")

I guess it can be also considered a feature (e.g. "supporting more
setups"), but having the temporaries created where they were was
unintentional.

Cheers,
Miguel
