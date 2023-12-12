Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357FE80E839
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 10:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346058AbjLLJwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 04:52:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346096AbjLLJki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 04:40:38 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FC2120
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 01:40:44 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3b9df0a6560so3616401b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 01:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702374044; x=1702978844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBPastpn1RC87z2hLEiZW6KtB1XJZ0fz+MiJEWfk6hU=;
        b=aHzAsDdNxgosCtPLlh4A7a7Pd9lK10j1bcD+5midrPZFIulAaKCBBM021VmiWWJf1i
         DsXaPooqliJv2rn2gA4pNTYl0sJNEnr55neuH4Eeocp/bsL4EBhtSBHxXz0Dd4KUF0Zb
         fCKDXSyN19/TSQv49O60rsk+wvvtWOJ8WO6ZM7QhxThLt4v8ArGuiNFD0U1fffaIhYXW
         PmZNAtebFqfh54fio1652/DkUAHp8JF7iFRzxlP//DN2g6E7r8R/4PwB20dgjFRcAGSf
         j1AS0Ha70elH1dxAxO+KwYRJ1P0nSQoZ3N92BPl0a9yDoIkHwNuk5RhCfs+8E3E1cWbj
         /ZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702374044; x=1702978844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yBPastpn1RC87z2hLEiZW6KtB1XJZ0fz+MiJEWfk6hU=;
        b=XEH5kYx46vh/AHh7tRg0sMngLIImu32yg2jUSUo/DOFlossLVAQyieIYHkkP0QUsoQ
         PRA39944EQ2Je499HSzTtsndVmzejX0pDYTeb0mf0++ibJ6miFdX76YZG8w7WwhMUrO0
         NDNX/7UYsqImli5AtePoKoC5KLHcv2AolLAu6f7p7i9jQwKLJOtxA4iS3l+zmdC+qhBZ
         e8VL/KuCisLxokMymuM71ovFq96fenLjyUrT1YT/m37ivGXfJyOGz6vM5tLkgwS1STvr
         i42/i7sihKE22+ziryVPLehFkvUw+kOiMj0vi8LYSDikDahS6kab/RIqz0AfxM4Cxa7Y
         uLTA==
X-Gm-Message-State: AOJu0YxBUtouMrMwasFUJcxFKZ34Hc691RFBJRZX0+ZU7vTSmZ1P01mY
        fYNCO1uLcOXaV1ZpQjepOCcSSqzT7pynDLobkbSARQ==
X-Google-Smtp-Source: AGHT+IHTSiZ6LzgVymhn5KubTf+HT5hUzMz3vldIiaU9GfA+4GJncv76WqjD73+5ZSklO9GCgIaWXZcxpODcXU0Y6u8=
X-Received: by 2002:a05:6808:130a:b0:3b8:7a9d:af5b with SMTP id
 y10-20020a056808130a00b003b87a9daf5bmr6387114oiv.35.1702374043714; Tue, 12
 Dec 2023 01:40:43 -0800 (PST)
MIME-Version: 1.0
References: <ZXZjoOrO5q7no4or@boqun-archlinux> <20231211153429.4161511-1-aliceryhl@google.com>
 <ZXdIbEqSCTO62BHE@boqun-archlinux>
In-Reply-To: <ZXdIbEqSCTO62BHE@boqun-archlinux>
From:   Alice Ryhl <aliceryhl@google.com>
Date:   Tue, 12 Dec 2023 10:40:32 +0100
Message-ID: <CAH5fLghbOA6s1d8GFz3JwcqDtzq+VbM3dc3M=enF0UHQN_Nt5g@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] rust: cred: add Rust abstraction for `struct cred`
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     a.hindborg@samsung.com, alex.gaynor@gmail.com, arve@android.com,
        benno.lossin@proton.me, bjorn3_gh@protonmail.com,
        brauner@kernel.org, cmllamas@google.com, dan.j.williams@intel.com,
        dxu@dxuuu.xyz, gary@garyguo.net, gregkh@linuxfoundation.org,
        joel@joelfernandes.org, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        maco@android.com, ojeda@kernel.org, peterz@infradead.org,
        rust-for-linux@vger.kernel.org, surenb@google.com,
        tglx@linutronix.de, tkjos@android.com, viro@zeniv.linux.org.uk,
        wedsonaf@gmail.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 6:35=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
> On Mon, Dec 11, 2023 at 03:34:29PM +0000, Alice Ryhl wrote:
> > The safety comment explains what the signature means. I think that
> > should be enough.
> >
>
> For someone who has a good understanding of Rust lifetime (and the
> elision), yes. But I'm wondering whether all the people feel the same
> way.

The safety comment doesn't require understanding of lifetime elision
to be understood: "The signature of this function ensures that the
caller will only access the returned credential while the file is
still valid."

Yes, if you don't know the syntax for lifetimes, you'll have to trust
me that this is what the signature means. But I think that's the case
either way. I don't think it needs to be changed.

Alice
