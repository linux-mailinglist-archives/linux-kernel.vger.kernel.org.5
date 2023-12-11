Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BADA80DCB4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 22:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344409AbjLKVIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 16:08:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjLKVIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 16:08:25 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0390CB6;
        Mon, 11 Dec 2023 13:08:31 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5df49931b4eso25516387b3.0;
        Mon, 11 Dec 2023 13:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702328910; x=1702933710; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5oBAVSIeSewVnml1Ggl9UiTKUJO5pXb4FDxuctj8KAs=;
        b=jkGmJX9/ZItDI0KJe4z1kBVl9APxFu6tTY2PHGusQ+5wpDB3/TB6nmDj+FR9eFDaHe
         /1W3DFpJQM9Xhq5VHdOSHxrxYcyhCMXOOj54d/EVqxUMPc/zyUUTwiSVEZCrbY6ko5Gr
         eeqG/Ada9M4XPtHTFZPsmhKKA44DfZ5nZFvuGZq/DGoZzIkWb46cx0eDnusbVRCeR6k/
         y4EvFru3EmoDl1fN+ST5t9Jr8zEbptOrseRAAFc2OQufj8ZuulzHBvEdnafPstgl58Xs
         5vmFd75F9TPnsxw7stVHIqPxPKeL39x52DkVTuJTuQnc+ZGv+F9SUxcmZT8kCFS7ZIxS
         Lgzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702328910; x=1702933710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5oBAVSIeSewVnml1Ggl9UiTKUJO5pXb4FDxuctj8KAs=;
        b=cmE4w+at3xgQQhzEYD+boqvKT21D4PFaIlYxE/sjEEefK+ihTVwsk7vFjhVlL+IaUP
         Ra9FOmvbPD7ECOIm7NJKbB6e/jmjuD5jUEZhdwO7pAUSZZhmRGNITRxxMXXgdI5XzI20
         uUwo4zeh9kz4VDprjh49Eh/qnaG/BoBhfQFr569/YkzQA4doMQwTYarj1Q4i6P9UUWsd
         NssruvmkQQ3tfjdZ+Gc8UIdppBBoq4EAUKa2Ja09QcHf5uUFXWQWhuDc9sSHvJOoccpX
         gks41W/wCWNoKEETh0PdV0seoeS+gIAsi7hsYbARRI6NJ6UmCPi8IoYY8xk6SsfGtBK9
         Grqg==
X-Gm-Message-State: AOJu0YyTyMgIEFnkSgTmgguyT3bIEeercmEKdmgF/v4B6qGpzYxNznTt
        d2WmXB4ECIJS4TfRCoR7ytWgmkwzojqX7pNmwTU=
X-Google-Smtp-Source: AGHT+IGIVzj0yPiY7yZzg859Ku8euIwz+1MHKfBlo6Ny1C7iN7YwqA+cO5Yz+Mnhp3wa7YrKjE5xfoLnD3LJpbtEFk8=
X-Received: by 2002:a0d:e3c1:0:b0:5d7:1940:b378 with SMTP id
 m184-20020a0de3c1000000b005d71940b378mr4215267ywe.68.1702328910222; Mon, 11
 Dec 2023 13:08:30 -0800 (PST)
MIME-Version: 1.0
References: <20231211150753.293883-1-mmaurer@google.com> <CANiq72nrCThY3mtHRMncRFDsu8XUmdb=W4WBs5Ua6oNugkDZhA@mail.gmail.com>
 <CAGSQo03EPpPFy9ppE7wjv_NG8P_pRqLN21TvoMnYzA=+Z_gCnw@mail.gmail.com>
In-Reply-To: <CAGSQo03EPpPFy9ppE7wjv_NG8P_pRqLN21TvoMnYzA=+Z_gCnw@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 11 Dec 2023 22:08:18 +0100
Message-ID: <CANiq72koDW8yLKDQ+iV7cdROxwD9HtPn88i_3HCBKeCe38M5mA@mail.gmail.com>
Subject: Re: [PATCH] x86/Kconfig: rust: Patchable function Rust compat
To:     Matthew Maurer <mmaurer@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 5:11=E2=80=AFPM Matthew Maurer <mmaurer@google.com>=
 wrote:
>
> Sorry, I just realized this was only in a local patch. I hadn't sent
> it previously because,
> as you pointed out, we currently only support one compiler revision.

No worries at all, and thanks!

> Re: Martin's comments (unfortunately they aren't on the same email so
> I can't reply inline)
> would you like me to file an issue against the R4L repository about
> this before sending a v2?
> I thought that repository was just for staging/discussion, and this
> didn't seem likely to need it.

What we normally do is putting them in the "wanted features" sub-lists
(to track implementation/merging into upstream Rust). Then, when we
start using them, we put them into the main list at
https://github.com/Rust-for-Linux/linux/issues/2 (to track
stabilization).

Then we also add version numbers when they get implemented/stabilized,
and then on the version upgrades I like to go through the lists and
mention things in the commit message that got solved (that we needed).

Therefore, since the feature is still getting implemented, I have
added it now to https://github.com/Rust-for-Linux/linux/issues/355 --
when the PR / Tracking Issue are created, we can add the links.

Cheers,
Miguel
