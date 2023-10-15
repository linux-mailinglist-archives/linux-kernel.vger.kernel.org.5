Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF9FB7C9B3A
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 22:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjJOUFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 16:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJOUFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 16:05:49 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4549EB7;
        Sun, 15 Oct 2023 13:05:48 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5a7d9d357faso48745957b3.0;
        Sun, 15 Oct 2023 13:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697400347; x=1698005147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EKORFiiytuzrNFOWWDbWqjqT0AccoDtRThiM4JZ06tU=;
        b=H8HmgrgithIDO47ajKObn546rPCYLBkktXHex4OZixHCHE0hrv7VCZqsu9E8ux2Ct4
         rSGiQbrflkj0gHfCvXiTFBuFWCRZFaIrAwtquIsJVkxI6qFAmXDu7nyqgrPmMZrrdzed
         TQg3dvrVYgh9wMLj4yzi2nC2T6UW+mvgAAJH0pseXYKU3QQrQko2MOvpZ454NGVxByS6
         iXLYa3NTYNhOUGh8tCqCd3Nx0r0MXSVeT3D7Lj3US2yjewy3a6cxqIjmdsEKuqA7mdIk
         J6QXWe1h02+1k8Zw1phHlSSCruh6BNc5coEr5mY49jWjSj0IPsaLjrTpN2pNmugveOQq
         ZAuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697400347; x=1698005147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EKORFiiytuzrNFOWWDbWqjqT0AccoDtRThiM4JZ06tU=;
        b=pYIJAGvPkYA6005af7dJbUAIAIv8NPr+ova+Mkmmrf3jdGsTtKIqfTYrjtwQNKhkst
         sAbssH/ulfZxAZglZBidoijXk7V4c+9SzX+W6DjAaL7so45le+7NtDQnsJRoF1pS1n/1
         Gbl00kb9ThTt78gkFime+MSW8uhbknCLaGW4eyT6Ept4jrF9v27TA4Icu82xD2R+ObzR
         DBRIMvuNPTxsE0CWvkAkTWYWlfmfFbdMpRddg4cmYpK1mlGEmU4Nm/3bCIquQj4Lx8n1
         IAAgGr8EFlQ/X33OxVmsY0nC7GlMS3dfJ91y8j0MCa/aeQQSNtnM4zzttWJx6ugW26UV
         kaGw==
X-Gm-Message-State: AOJu0Yw2grCmQOjUy33V3VKQaq8dPJatpdPai8M3Ok+eJ1TaPmiaEFdx
        e52Bfqhn6wB3bCH3k3QWYOaLM3ihz7IfNTxvQBM=
X-Google-Smtp-Source: AGHT+IFBhbF3r4q5CUVMMEKRcg6Xu+A03hqoM66meeRz3vANXvQ6N3phyxOqvwyTVOwpNbKGG9XG0hWx+DEvS1OFr38=
X-Received: by 2002:a81:6c92:0:b0:5a7:b918:26be with SMTP id
 h140-20020a816c92000000b005a7b91826bemr17134197ywc.15.1697400347435; Sun, 15
 Oct 2023 13:05:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230928201421.2296518-1-mmaurer@google.com>
In-Reply-To: <20230928201421.2296518-1-mmaurer@google.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 15 Oct 2023 22:05:36 +0200
Message-ID: <CANiq72=52j1kL2bYyU8S_wYpFK7pxjGMbyt0HK+gDjDT4Qf0Og@mail.gmail.com>
Subject: Re: [PATCH] rust: Use grep -Ev rather than relying on GNU grep
To:     Matthew Maurer <mmaurer@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 10:14=E2=80=AFPM Matthew Maurer <mmaurer@google.com=
> wrote:
>
> While GNU grep supports '\|' when in basic regular expression mode, not
> all grep implementations do (notably toybox grep, used to build the
> Android kernel, does not). Switching to grep -Ev enables extended
> regular expresions which includes support for the '|' operator.
>
> Signed-off-by: Matthew Maurer <mmaurer@google.com>

Applied to `rust-next` (with typo fixed) -- thanks everyone!

Cheers,
Miguel
