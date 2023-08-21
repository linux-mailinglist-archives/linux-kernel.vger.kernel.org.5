Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1672C782928
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 14:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234903AbjHUMdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 08:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234900AbjHUMdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 08:33:43 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8D6CC;
        Mon, 21 Aug 2023 05:33:21 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-58c5642701fso37362277b3.0;
        Mon, 21 Aug 2023 05:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692621200; x=1693226000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TcMV5lQGmI98bFrnU90JtTBiUMBBaOFYKC9uq0wQzqQ=;
        b=CtGnDzrFXF4ikbz3/LMJBL/g5EpeOh6nCO0uLoGIrP01UWZ8oLjEBKWRnZuoDngy7X
         NPH/LPsYScIubKeTnNNX6e2lnvRBBrAlHFK3zHb+cT20O9/dXDdhvt4aHxBQds1e1Mhw
         xslpg0qeE5Vj9CuaHY/HlWw7lW82wGQwet0K3pg5fTZirwu5Ob72HAJ3QgAZcwbVa5N2
         XOSgXb3qfzZHdCITK8+tCLytj/o1dr1AUhKdHuY8VVNmmcFyR21XbyB1lZ7dQMRJ6PcG
         S8uh7OaimxwxtnaSraOhkMa9pAsj9GjoPoHLpYMkoYlEBzM32G9LMuaaoSUaF0i6r2R9
         Mm8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692621200; x=1693226000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TcMV5lQGmI98bFrnU90JtTBiUMBBaOFYKC9uq0wQzqQ=;
        b=PlZ//c+0o6EoY+lJ/H09HX5oZErh/yy6IpIFpWnn5yaOKWHcB67avC+Inc8oUY4IM6
         REuo+ErelAJCjC52vHkItBubYL0UdzpBvyiqRvTpfYggW3cu3CNTbOVCUfYaGFpOf5Vr
         Wnu6E8+YnX5cp/QLBt9ykZORq9L/TBJ+VkYS150XFpeBIZ54RxGn3m+QWxbocYaw6Ky5
         wKq5XaYbt0tMxrPJhTuZ/vZkjE+j6Xr4dOeYZdUPFlwov+zwk3jnardI6D5XgXIcmiMl
         Tp68Icg95PrHIcoSq/eUkHf0/FWrYN4pH28G9b83KsHjLsTnkbtWs85JAHe8w+sl3fz5
         CEJA==
X-Gm-Message-State: AOJu0YwYXKR6SSMSdWNuNFtBO7VpTaeUu1f/hduhG5j06K8YG6ZBwIeN
        6x1ix4hKf+9M3mKF0EKms4ciAuS2VYnvD59nDH4=
X-Google-Smtp-Source: AGHT+IGp9QiWZj4Ddo/semyKuYTZr8VO1JUjgMfKoXzyeNtcXUtGkEtBIfPojap0bJJIiJLCyRujKuuTz/7iy27Mecc=
X-Received: by 2002:a25:d650:0:b0:d05:96e4:b379 with SMTP id
 n77-20020a25d650000000b00d0596e4b379mr7666381ybg.56.1692621200528; Mon, 21
 Aug 2023 05:33:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230814084602.25699-1-benno.lossin@proton.me>
In-Reply-To: <20230814084602.25699-1-benno.lossin@proton.me>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 21 Aug 2023 14:33:09 +0200
Message-ID: <CANiq72kjUGmWDrjQDsZ185Pm+yKGMKZUAtgT0ykx3saZdiGxTw@mail.gmail.com>
Subject: Re: [PATCH v4 00/13] Quality of life improvements for pin-init
To:     Benno Lossin <benno.lossin@proton.me>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
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

On Mon, Aug 14, 2023 at 10:46=E2=80=AFAM Benno Lossin <benno.lossin@proton.=
me> wrote:
>
> This patch series adds several improvements to the pin-init api:
> - a derive macro for the `Zeroable` trait,
> - makes hygiene of fields in initializers behave like normal struct
>   initializers would behave,
> - prevent stackoverflow without optimizations
> - add `..Zeroable::zeroed()` syntax to zero missing fields,
> - support arbitrary paths in initializer macros.

Applied to `rust-next` with a few changes -- thanks everyone!

  - Rebased on top of `rust-next` instead of `rust-dev`, which
requires a small `use` line change due to the KUnit patches being
there back then.

  - Added an `ignore` for the `macros/lib.rs` example to avoid
breaking `rusttest`.

  - Cleaned a few trivial nits I noticed in several commits.

Cheers,
Miguel
