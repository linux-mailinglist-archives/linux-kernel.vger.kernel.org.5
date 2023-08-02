Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4859076D598
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbjHBRig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234177AbjHBRiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:38:14 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3738B1727;
        Wed,  2 Aug 2023 10:37:34 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d35a9d7a5bdso66575276.0;
        Wed, 02 Aug 2023 10:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690997852; x=1691602652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cWhqiuP44YcPPmHT2vtf0tx+jxKs6e8QElNN/SdMb8g=;
        b=d8YUDFp4xGGHKlKo4qxm10TFjBfG5za+jCOGSSZfc4uigmwcE7fawwWjhKPlAddKjl
         kxyqnjhCXDS5WrHv9b8Vwk8g0k82CLk/p3rIYxAktSX5QpV2YVLCqQFw3SZIezG03R3h
         gufN0IDwJlaDaSYToXk5wZHGVgkDOJ/BMss+kP069FWUiyQkSO9BT9oMFLkEVTsJuTGz
         6KIrCAiSMtSG6Xs+5b247hYTuFsjUwfoMXe7GLosBZXp/9b7UrB7scEPca4B/xqfNhRn
         186/kPTqAVq+JeJwJ0ERGkOVYBazGmg143nD8//bPjg6Pe1wQVUCt10OuBxu2eW6cLDL
         dayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690997852; x=1691602652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cWhqiuP44YcPPmHT2vtf0tx+jxKs6e8QElNN/SdMb8g=;
        b=OIzxhbZdrU46dsRnse70Ge+6By6IRJ96iJ7cct6tuPgI3ZgfqtaOCjEtd/Y/ATa4h/
         +2zLNHNL4wKLUd3uK6fNKPEQQdRUXd3cgchZDK3jSnjwc4d4v4xkOlxa9ojdNqbHoIy7
         XezWtI4VN27KcmYIgSlWv/5z9T00kSjOiWi7jBSIFQBdfAWJpu7+uNx0+MvFRJk0/wJU
         aDrUqpv/s367FJTYAORSDT4kS8putfHVoCfU24ReEsAfqe+rpIb+JR2AREmdQ3TsWVWC
         IdAlSuXFIwgup1O3BjqyDApqZ9ohXJK+UgcgFojCbOd0Qw0ily3r2Tjo8f/piAccbZkH
         nGTg==
X-Gm-Message-State: ABy/qLZ2qusm4ia683JCO2oG3OgAiSXXEgrDs0DRvlrlm62Za2ChuTDh
        /86QNEbzNi1hXba0Onfdp0jWfT0AnGWRPIju3sSrE2k5
X-Google-Smtp-Source: APBJJlFG7pGYvNOa2exsr6kzC1NMZtwy3KV9/KAnI0deA9i0OtvGsSvpUpgk4SkO4gsMReHE0IEf7vnukdCNIwdMqoA=
X-Received: by 2002:a25:ac2:0:b0:d0a:353b:b939 with SMTP id
 185-20020a250ac2000000b00d0a353bb939mr12886281ybk.52.1690997852583; Wed, 02
 Aug 2023 10:37:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230706094615.3080784-1-aliceryhl@google.com>
In-Reply-To: <20230706094615.3080784-1-aliceryhl@google.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 2 Aug 2023 19:37:21 +0200
Message-ID: <CANiq72=cT_f90GJkaRq_rBKYMnruSf87UVKSX0TBbNWETYya_g@mail.gmail.com>
Subject: Re: [PATCH] rust: delete `ForeignOwnable::borrow_mut`
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
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

On Thu, Jul 6, 2023 at 11:46=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> We discovered that the current design of `borrow_mut` is problematic.
> This patch removes it until a better solution can be found.
>
> Specifically, the current design gives you access to a `&mut T`, which
> lets you change where the `ForeignOwnable` points (e.g., with
> `core::mem::swap`). No upcoming user of this API intended to make that
> possible, making all of them unsound.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Applied to `rust-fixes`, thanks! I added a `Fixes` tag.

Cheers,
Miguel
