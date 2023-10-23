Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD8F7D38A8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 15:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbjJWN7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 09:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbjJWN7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 09:59:08 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE2310C0;
        Mon, 23 Oct 2023 06:59:05 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d9ace5370a0so2537072276.0;
        Mon, 23 Oct 2023 06:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698069545; x=1698674345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PsfVtKRf9ybpzEArPxCGBZ2gJkO2N8IB8u3WGmqpZq8=;
        b=aaNdziOy0qX/koYnSuY0RVglIw4v2nZbB0J6d6qrkFRfAh4tYe0H9/7P9Ps/2VcCPj
         NqbwtaWrEznoBz2erXHpIagW16RsKD2qho8ltlrM5DUUEO709Q5ED7X3aipVMM9bhMT5
         mShqgamHqYTuMzeq7o0H99+KD2Z9oQSZi3DgxGVSLlr3a44XMncXH7zIxxTx9R1vErD+
         xq5zqdfw3r1Lrivt6nbPKWvbQMK7gZbxccB4w1xKWma+AdfW0zOLQouMHp/1GmodIpwf
         23nYzPwHvVZsX8sEI0YAHw1DHKLAQjB73SqWc26u4F/jRNHpSjUo2uz5lsfhC54Rdzt9
         O3JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698069545; x=1698674345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PsfVtKRf9ybpzEArPxCGBZ2gJkO2N8IB8u3WGmqpZq8=;
        b=RHu/E5rCBWQyk7FMmG69cHMmcpb9+NyBCTSu+JTmhls9KjQM/L02ca2BGQXI3jxH2I
         jqtCSPJId8LG+Af9Q23ioQshTlvEjzt7cMo+pWYlFM5c7P1X+1E/h2l8nJmK+wNT+m3h
         B94p0H5VanDi1APHCODBTRCutCAIBlvD9+6JkyYVOvV6ip3pLoD8oj96n4PthveuHEPG
         q2c73ZAqRzh8qbhJeVQmglLTmn2Wh0mve66swECP6wOQeEdarlzGTxjGHz8K6Fb2KFoy
         /5ebv5DsmEtUQl7GF622nHqbv0Y+hClV8UjTlmeoASgVA4vr+rUyMLLCGXCeooclHCBR
         6bVw==
X-Gm-Message-State: AOJu0Yxsd9uFPJdwV77eQz7gyykoyCfcRRzfG130pi5AlWDk/jFM29Ji
        GsFjwlHnYcE/rXhEvBebsBcYZ7BI59fNq70f2D8=
X-Google-Smtp-Source: AGHT+IEhm5iIz9QRAioPkjkoON0WJZN8cZe7j7MCUTL7a/EtExgikOEKZmfc/44+Sn+9FlSE5Y32tBE2XxHutXYqG6c=
X-Received: by 2002:a25:c70b:0:b0:d9a:4da4:b793 with SMTP id
 w11-20020a25c70b000000b00d9a4da4b793mr8312256ybe.62.1698069544706; Mon, 23
 Oct 2023 06:59:04 -0700 (PDT)
MIME-Version: 1.0
References: <20231009224347.2076221-1-mmaurer@google.com> <20231010081220.GD377@noisy.programming.kicks-ass.net>
 <CAGSQo01=NRosJCzRCWcqZfvdHzH+d6dThN02SpvkF2EHsFXD-g@mail.gmail.com>
 <20231010142448.GN377@noisy.programming.kicks-ass.net> <CAGSQo03wwtjzba-W9Vs4gOW3Jin=dnC937hNijxgHEd-jDev6w@mail.gmail.com>
 <20231010145601.GP377@noisy.programming.kicks-ass.net>
In-Reply-To: <20231010145601.GP377@noisy.programming.kicks-ass.net>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 23 Oct 2023 15:58:53 +0200
Message-ID: <CANiq72n_iA14X5J82-MGsfYr7Vm00wH0-5PmcP6jFL-fpXjNBQ@mail.gmail.com>
Subject: Re: [PATCH] x86: Enable IBT in Rust if enabled in C
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Matthew Maurer <mmaurer@google.com>,
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
        linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
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

On Tue, Oct 10, 2023 at 4:56=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> I'm not sure -- if they happen, objtool should warn about them. So I
> suppose we'll take it from there.
>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Applied to `rust-next` -- thanks!

For subsequent patches, do you want that they go through the tip tree?
If so, please let me know, I think it would be ideal.

Thanks!

Cheers,
Miguel
