Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A5C7C43BB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 00:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbjJJWYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 18:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbjJJWYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 18:24:16 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB23999
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 15:24:14 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d9a7a3e17d1so829705276.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 15:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1696976654; x=1697581454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jKM6X9DW5ZaZr1/Qmc2UJFJHXlJjhVjqRx8RRr4UsNI=;
        b=ho8Rv1I6XZ6wAkQVGSk6AJd8hJyFKwm4QsF05RhJolvUSHTz1Slj09NZ+3ZckpQJyG
         4yi0quC6sMrch8WRYjXw7a6vxaZaP8GDFFrWSuk4jzck805p2qDKr5mwpnk1cj9kWAcV
         CG4ucOo5y+NGsEkfOimrsA7DYGVDDHG5DnPfdFzx3ke1Wi84Nvd3cRbz4m7yEH0DhAdB
         mFTISZOxW0kzClrv1d3fiR/M8lm+aDKSPP3sBTbE+GS7xGSVjXXEAxa4LJ7vK1iktZK/
         YTMLsNtaOnNZV5VK/nLW2hZzHzJCxFFhVkeWH3M8rmE6reKttKdsxiRJf0pgjcU7Adub
         CORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696976654; x=1697581454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jKM6X9DW5ZaZr1/Qmc2UJFJHXlJjhVjqRx8RRr4UsNI=;
        b=RYhkE68Ew34krW5IIkswOTSaaZEt2WgHzo1PoFlcYbMg7a3BjGC5IXfTppQn0U7g4C
         4COm4RsxCSNo86KSyKbRyfoMbqjhm0K58wKCOCAmw+mZPMX5rAQKFglNwUwyB+GS6lij
         FJ+qFZYG7NlKxVCWvHj/DleWnihDoI5d9T/QNeIEeiKXL3MnseRrx8DIAb34uVC6DLms
         FjYihnUDxSZjztTCzHGGIj5XtIZNXSZYp4/+kmPUW0+4rfn5dwCwxQftF0SDAwN4IxOs
         GnURWfKf07LInvVqD9bOvD7ZqEPA/sURGrfTEWuW1q/2dHqzmemZoycUPZB2qW3rGHt6
         2LRA==
X-Gm-Message-State: AOJu0YzPo0QIDt/TsmjekR5WcZW+eQLuMQWA76yJspK2ozSAQ/mtFZRT
        /UjpxTJsyi8RBOwayjV9YIYygEhWLHGjZnT5bFClIQ==
X-Google-Smtp-Source: AGHT+IHsvu8tCXO3m1s7kvev6QqQvN/Qsnj8U5Zy1hlfaQgvrWPVMtCzaGFQlvmeEd1Pf4lv+NlHZhCBDy4jLDlFxSA=
X-Received: by 2002:a25:f910:0:b0:d9a:6316:42c8 with SMTP id
 q16-20020a25f910000000b00d9a631642c8mr2777970ybe.54.1696976654175; Tue, 10
 Oct 2023 15:24:14 -0700 (PDT)
MIME-Version: 1.0
References: <20231009224347.2076221-1-mmaurer@google.com> <20231010081220.GD377@noisy.programming.kicks-ass.net>
 <CAKwvOdk1c3N05R9fya6HsZwPZzrkDhC3LrK=nRVOoUwyXsiXQg@mail.gmail.com>
In-Reply-To: <CAKwvOdk1c3N05R9fya6HsZwPZzrkDhC3LrK=nRVOoUwyXsiXQg@mail.gmail.com>
From:   Trevor Gross <tmgross@umich.edu>
Date:   Tue, 10 Oct 2023 18:24:03 -0400
Message-ID: <CALNs47vSswVKFnH90q42gZMfNH113_XUP3oLcjeTdBAZHueg5g@mail.gmail.com>
Subject: Re: [PATCH] x86: Enable IBT in Rust if enabled in C
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Matthew Maurer <mmaurer@google.com>,
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 11:39=E2=80=AFAM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> > > https://godbolt.org/z/bc4n6sq5q
>
> Intel asm syntax...my eyes!!!

:) If it helps, you can click on the "output" (gear) dropdown in any
of the asm panels and toggle between Intel and AT&T
