Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D996180DCAF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 22:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344760AbjLKVJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 16:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjLKVJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 16:09:38 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA5BBE;
        Mon, 11 Dec 2023 13:09:44 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3b88f2a37deso3828822b6e.0;
        Mon, 11 Dec 2023 13:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702328984; x=1702933784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+ey/gQgXGxGry1lQD8K5omLablilAoeCXkj6pliNPA=;
        b=GXkr5bvpldND4I6tp63lswIXsq4DUwjEw/K9h+eioVirPOBfsYGHV903MiG0PspXu+
         Fg0qFOcJpRVlZJFNukQ7S0CpxKPw3OMRg5AM5DITuooSWZJJI6mHfEHcOedNmeUvqwzn
         6Yd49jngxXzikT35iAIyh6nqa6BVHUS6Ta5VJSRhl5h7YJB9jQQIaEFfWAZc1pDE608D
         qnw4mZW5gfsVYPke6wL+REpawXfV/MVNjxQ5ANYPhONwK9RCKVy8kcKM6pIi+Q4Bg989
         6RfFkzPSgA6tK1O53IcFHjE+ZRCsTP3oAVqV83ZosaLDuGSidYOMnujM/p/cInv1yLbV
         XY+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702328984; x=1702933784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k+ey/gQgXGxGry1lQD8K5omLablilAoeCXkj6pliNPA=;
        b=nbINGO475kgSaClG4TgRP3jh3LDpQx5gBtdPMQN/XUpyj34Vrbc0yyPdvpyb0unKss
         xRH8YW9kacLJeTH/65++ztpkNrD86Fnw1JYLfQNl2UcagedM5BqEdUaT6fwow+opui8M
         JC2Qf/giaPdnHowuCRnY8ysEg0AbF6nyq9StaFByx7jHpN/qZG81KeEZMrS5MZDEuD9s
         e1mrN/eXtD8NEEf9WwJJBusDFwKsqUcwkGPdGpNS7EYYkqae9G2z56TY2VP1PRz/UfM+
         g4qEH8h+DQJ28DPIEC8VnfwxhFwJnUKQlbYbbbhecIEFnJWGOE53FbJCNgnsM00e0rqh
         jTyA==
X-Gm-Message-State: AOJu0YwY1hHh/1Skdt7qZUPpOq3yM/BOUnuqa80C14AQkVStTMShb9Vm
        EEHBhZBFklOnl08j600YgGy+Fh/FWRFmKLemzWM=
X-Google-Smtp-Source: AGHT+IGsdwJssPRzImhE1I7xHS06dBU4ugRt6h3GUi5zrQgtImqxrC8jGY3uyhZCK/yzgSUT/ysNt8HWLxJ+R/8nUV0=
X-Received: by 2002:a05:6808:17a7:b0:3b8:b365:1e34 with SMTP id
 bg39-20020a05680817a700b003b8b3651e34mr6119019oib.33.1702328983890; Mon, 11
 Dec 2023 13:09:43 -0800 (PST)
MIME-Version: 1.0
References: <20231211150753.293883-1-mmaurer@google.com> <CANiq72nrCThY3mtHRMncRFDsu8XUmdb=W4WBs5Ua6oNugkDZhA@mail.gmail.com>
 <CAGSQo03EPpPFy9ppE7wjv_NG8P_pRqLN21TvoMnYzA=+Z_gCnw@mail.gmail.com> <991d92dc-9b08-497e-bef1-dde7de2642a0@gmail.com>
In-Reply-To: <991d92dc-9b08-497e-bef1-dde7de2642a0@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 11 Dec 2023 22:09:32 +0100
Message-ID: <CANiq72=393A++eb8W2eQz+Su83xhZDVcr-T3WKZ63Toxvy_i1w@mail.gmail.com>
Subject: Re: [PATCH] x86/Kconfig: rust: Patchable function Rust compat
To:     Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Cc:     Matthew Maurer <mmaurer@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
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

On Mon, Dec 11, 2023 at 5:23=E2=80=AFPM Martin Rodriguez Reboredo
<yakoyoku@gmail.com> wrote:
>
> About issues, commits or PRs I was referring to issues in
> `rust-lang/rust`. When we use unstable compiler features in R4L they
> get tracked in [1].
>
> Link: https://github.com/Rust-for-Linux/linux/issues/355 [1]

Almost right :) In that one we put compiler things that we "want",
i.e. they may not even implemented in upstream Rust. When we start
using them (or we intend to use it and they have a
flag/feature/cfg...) it is when we (also) put them in the "main" list
of unstable features in issue #2.

Cheers,
Miguel
