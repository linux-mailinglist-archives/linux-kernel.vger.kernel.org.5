Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7E380A89E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 17:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233561AbjLHQTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 11:19:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbjLHQTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 11:19:16 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35135173F;
        Fri,  8 Dec 2023 08:19:23 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5cdc0b3526eso17038997b3.1;
        Fri, 08 Dec 2023 08:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702052362; x=1702657162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z+lYtPFLdYgqfi+bVCE0w/Goq5cyv5fzrYGDfQjvUqs=;
        b=AuxOW/96MA3WP6Bu3NBSqnlAPEcnkMvz4FjQyAu7uaKUWgahIwjk8Ea20c2za8PVon
         5IaxL8Cq1uMIkZKZq+Y0Caax1OHV9rw7/KCWq70KK0yN1ZqPORa6IQ6r13aQ48FM7r5o
         /G02aG/P531k5ef9HkJiEa+Y7sq3XmCl0IxS7eki9PUU8wiTaXFMTX+Ol2Lnk4zxUXnb
         KPQ0UA5T6QeVPsnooSYFsl0gud0LiFw3TmrnnKIU/gB5fyFOGmPqevptG5c5GF3mOyAk
         iUricYT5sUJ6/KCOsSvP5evwT9W4dtLDxpwDZEBOs8UaNJPSFAcxzrSoYlSZCQbsGFUf
         Hhlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702052362; x=1702657162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z+lYtPFLdYgqfi+bVCE0w/Goq5cyv5fzrYGDfQjvUqs=;
        b=m3TsnYYMVKyM4cFjCOTY9ETIhSMlRQYWoZSqM5rzHHF7Hhvu7paQUbkzsv+ji6aKs5
         zCuUy7ZSC3vJTLjTLibyh+XwYkJrRbfLWVgVKVhMsPdTbvSCQFaUZGt7UNqWiGUfkGyh
         /rg+nk+vEeaG8aju0pJ+Y20Ug3TntXeuS2rRr+UqnFd7uWAgEi7yM9fmRJIqx44ifs/S
         HZdsocJoMjJ4ntsSRbZVLEHcGWXdJKGgvSmPOfuMyOvp2U20cUV3Oqvg5PPO6ZC4m4XI
         AZkgyj1djSVCDyqkigvYBOaVBayfljri7Oost7cHWkzC9CKZj3ZkQVwxbc3w5S5emL/P
         99TQ==
X-Gm-Message-State: AOJu0YwGZ9Lgg/+SABWfKITAkPvX1bKeDJxco4k9rlBilIFc0epdvOro
        ahRPbIAKsDVeKoGUYZxOyqkWQ4GjYVerwUCJRRc=
X-Google-Smtp-Source: AGHT+IF5PgsbeMFc+2if2n98aWvttOjDNo4fhgiHLvX2JZTzIWMyX6fFcExSa9MAqsBrNCHabnhZR74hTRTdyv63D18=
X-Received: by 2002:a81:9284:0:b0:5d9:3d8e:59e7 with SMTP id
 j126-20020a819284000000b005d93d8e59e7mr677539ywg.45.1702052362294; Fri, 08
 Dec 2023 08:19:22 -0800 (PST)
MIME-Version: 1.0
References: <20231129-alice-file-v1-0-f81afe8c7261@google.com>
 <20231129-alice-file-v1-5-f81afe8c7261@google.com> <20231129-etappen-knapp-08e2e3af539f@brauner>
 <20231129164815.GI23596@noisy.programming.kicks-ass.net> <20231130-wohle-einfuhr-1708e9c3e596@brauner>
 <A0BFF59C-311C-4C44-9474-65DB069387BD@gmail.com>
In-Reply-To: <A0BFF59C-311C-4C44-9474-65DB069387BD@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 8 Dec 2023 17:19:10 +0100
Message-ID: <CANiq72k4H2_NZuQcpeKANqyi_9W01fLC0WxXon5cx4z=WsgeXQ@mail.gmail.com>
Subject: Re: [PATCH 5/7] rust: file: add `Kuid` wrapper
To:     comex <comexk@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alice Ryhl <aliceryhl@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
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

On Fri, Dec 8, 2023 at 6:28=E2=80=AFAM comex <comexk@gmail.com> wrote:
>
> Regarding the issue of wrappers not being inlined, it's possible to get L=
LVM to optimize C and Rust code together into an object file, with the help=
 of a compatible Clang and LLD:
>
> @ rustc -O --emit llvm-bc a.rs
> @ clang --target=3Dx86_64-unknown-linux-gnu -O2 -c -emit-llvm -o b.bc b.c
> @ ld.lld -r -o c.o a.bc b.bc
>
> Basically LTO but within the scope of a single object file.  This would b=
e redundant in cases where kernel-wide LTO is enabled.
>
> Using this approach might slow down compilation a bit due to needing to p=
ass the LLVM bitcode between multiple commands, but probably not very much.
>
> Just chiming in as someone not involved in Rust for Linux but familiar wi=
th these tools.  Perhaps this has been considered before and rejected for s=
ome reason; I wouldn=E2=80=99t know.

Thanks comex for chiming in, much appreciated.

Yeah, this is what we have been calling the "local-LTO hack" and it
was one of the possibilities we were considering for non-LTO kernel
builds for performance reasons originally. I don't recall who
originally suggested it in one of our meetings (Gary or Bj=C3=B6rn
perhaps).

If LLVM folks think LLVM-wise nothing will break, then we are happy to
go ahead with that (since it also solves the performance side), but it
would be nice to know if it will always be OK to build like that, i.e.
I think Andreas actually tried it and it seemed to work and boot, but
the worry is whether there is something subtle that could have bad
codegen in the future.

(We will also need to worry about GCC.)

Cheers,
Miguel
