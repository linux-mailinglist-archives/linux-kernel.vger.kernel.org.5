Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16B980CFB0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344171AbjLKPgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:36:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344107AbjLKPf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:35:57 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF1DE5;
        Mon, 11 Dec 2023 07:36:03 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-67a9cba087aso33904366d6.3;
        Mon, 11 Dec 2023 07:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702308963; x=1702913763; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DJCqvG9lOVsqS1lp0xIiOZx+dmEbaY5Fmm26UgBCqwc=;
        b=dEVhVPmDuJzXGS4ZapA66gDNN6Gfopi1YOTwf0uSUGxpicbJTcI308pyI71sdQ3hQm
         Sh2p/Mam/y8Vnt8Iuw70/RE+LxC5IJMsHQ8xHYR2psHxYEsJ0Y63BJ7Jjx2xNyUnuIk8
         RPKLt5MRQnGgxh90fRJjRWdFgpcE35ca7Z/XS9gyF/dtB8gfsXXHG78BIE8mYh24FJvh
         +t7Yf5u3nO/fF8cG+dAmZQaTsTiosK3Id2zno+ymdX2vpXQFRccD7NkkdSN1hajv5JmR
         VHs/hB5UVHG/sbGrj3HCpy05Oxman9tzkR7lXJ/iykYR6SPCTGoATFm4DynPw4S/OBmZ
         svrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702308963; x=1702913763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DJCqvG9lOVsqS1lp0xIiOZx+dmEbaY5Fmm26UgBCqwc=;
        b=XdTZn9TUp7I7i/9uR6m1FdYygBDMfQsmnel6cUsycxH3oX+7vSVk+h3yfOzS9xxUy9
         gn4E5NGsvuOQo8nDAVTbNLazdkyyyzX7yO4kI8ncTkiiPbsVNyrPuhZhpJg7YO8J4JqV
         9B8yKehnWPOvpBYy9m4K0PqSmxsMP3VFdEDOQCDGVJPFE+VnXU/uyNagB22ZU4SpfyxK
         9SyNWN/URrC0RfqxdkucySFvVPqp39X9TUdgLpYoqC84aXBuprPaA87GnEqKfAx3XQdx
         8HofFmMvwhqlLTLsvvQR8tIh1kAZKtjVSqEa0ND4AaDV727vPrOJOBQ8BURJU87MzuVi
         2+/Q==
X-Gm-Message-State: AOJu0YxAityp3oGg/On0uwE7t/tN6v26vJcliUcnJltAXMGRMVv0AMl1
        N8C7jG5BhhAcoEuIv5IaqdY0tSaqVTIQlaeWaB8=
X-Google-Smtp-Source: AGHT+IGOMnVpmdA6ux2hULlzLc8a3XGG57n9MJuP45RPU4tJbeKsbWx21ckPove8nQVjAFWYjK/omaW75VqCIG4YJCE=
X-Received: by 2002:ad4:42ae:0:b0:67a:956d:98d5 with SMTP id
 e14-20020ad442ae000000b0067a956d98d5mr5342217qvr.29.1702308963026; Mon, 11
 Dec 2023 07:36:03 -0800 (PST)
MIME-Version: 1.0
References: <20231211150753.293883-1-mmaurer@google.com>
In-Reply-To: <20231211150753.293883-1-mmaurer@google.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 11 Dec 2023 16:35:51 +0100
Message-ID: <CANiq72nrCThY3mtHRMncRFDsu8XUmdb=W4WBs5Ua6oNugkDZhA@mail.gmail.com>
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
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_XBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 4:08=E2=80=AFPM Matthew Maurer <mmaurer@google.com>=
 wrote:
>
> +       def_bool $(rs-option,-Zpatchable-function-entry=3D16,16)

We don't have `rs-option` in mainline yet -- missing dependency? We
will likely eventually need it, but currently we only support a single
Rust version anyway, so we could add it (and the flag check itself)
when we upgrade (especially if it is going to be supported soon).

Speaking of which, I can't find the flag in upstream Rust (i.e.
outside the LLVM submodule), and I couldn't find a PR adding it. Could
you please add a `Link:` tag to the tracking issue / PR / ... if it is
submitted / when it is submitted? Or am I very confused?

Cheers,
Miguel
