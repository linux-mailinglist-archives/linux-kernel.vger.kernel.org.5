Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD95807061
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 13:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378346AbjLFM6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 07:58:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378188AbjLFM6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 07:58:01 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30336D42
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 04:58:05 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-7c461a8cb0dso1431227241.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 04:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701867484; x=1702472284; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZGoYDW3YQsCzUXqvsbiGGRLqfJtz8CuECDoHvJMwowA=;
        b=zzSejHzlYCtxzkwSxFmJ9cLnJ870it9JXKAFDEm2WFo5VgI0wNWxiv/Axq67CA8XL3
         VifHzekUcvZSuvIlNUuyttJ23igW+uxMcYfiW0rgOg9zPiJ0r1RQ/SceXDG5fTgogY0x
         /gcfgPTzrxpGDr/D2gpszfk0Ms2ObBqG7mWCFCDXfQgESGrtt28ITRZTppJuXbeh0Eyq
         +eUu+bTb9tMFCc6BjGU3mjAyseLGOoq2MCZOvx3Tpg7sgO++0AB/D3T+Jpi5sJtdKRkj
         KyM3gXzGSVdpvpRpgcICjn8XxPqfk2r4ZYj6YsoFrxI5SMw0wpg8NMSATsJhrVrfc4IT
         ZwbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701867484; x=1702472284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZGoYDW3YQsCzUXqvsbiGGRLqfJtz8CuECDoHvJMwowA=;
        b=sa2TldkHa65zEs12ksQK2009yafFMnbpHZ6gH6tNGR9Xp4gVl6zZQWYyNAghzUVOpC
         jVSaBMVuQlgwH7KVTh79goPLWpH2gUUjoATM/93wU1A7gHIQeWOucpNP8uZYqH7Cphip
         6RsOMNLXoMVOdIi8pXTCNmgGQZ6V8rnuGTXuLwhMq/ChSaodFFXYUNjsoDmG9LvtTYKG
         yd+eN3hxT9vnyHDmUN/OXnCJXFKuJdUF3+2/1t7HE3XWHiiWkt0qca75k0IVlUBjE8Vm
         p8o24cvtGbvUmiDOVUdsuNaBqthsodAQsG+QFIotM6/9x0gnQbfETgMzgx1KdjdcIXhV
         UHGw==
X-Gm-Message-State: AOJu0YyWM01foS0TwS1GYgl00Hi350YkRBcqU8yto7QocQiKas01aVsu
        QoZgj6K1F6LABUwCzwtuFNBODeps+26LfHV06NRSIw==
X-Google-Smtp-Source: AGHT+IG1/Vjpae3H5W+ZbnTi936i2LjYA50NrGUUAe1mup4QsNLrUvjnIaS+tKWBM8ZO1uqYk3un/FSr1qp/knN9p3M=
X-Received: by 2002:a05:6102:53b:b0:464:5913:60e with SMTP id
 m27-20020a056102053b00b004645913060emr265114vsa.29.1701867484173; Wed, 06 Dec
 2023 04:58:04 -0800 (PST)
MIME-Version: 1.0
References: <20231206-alice-file-v2-0-af617c0d9d94@google.com>
 <20231206-alice-file-v2-5-af617c0d9d94@google.com> <20231206123402.GE30174@noisy.programming.kicks-ass.net>
In-Reply-To: <20231206123402.GE30174@noisy.programming.kicks-ass.net>
From:   Alice Ryhl <aliceryhl@google.com>
Date:   Wed, 6 Dec 2023 13:57:52 +0100
Message-ID: <CAH5fLgh+0G85Acf4-zqr_9COB5DUtt6ifVpZP-9V06hjJgd_jQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] rust: file: add `Kuid` wrapper
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
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
        rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 6, 2023 at 1:34=E2=80=AFPM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Wed, Dec 06, 2023 at 11:59:50AM +0000, Alice Ryhl wrote:
>
> > diff --git a/rust/helpers.c b/rust/helpers.c
> > index fd633d9db79a..58e3a9dff349 100644
> > --- a/rust/helpers.c
> > +++ b/rust/helpers.c
> > @@ -142,6 +142,51 @@ void rust_helper_put_task_struct(struct task_struc=
t *t)
> >  }
> >  EXPORT_SYMBOL_GPL(rust_helper_put_task_struct);
> >
> > +kuid_t rust_helper_task_uid(struct task_struct *task)
> > +{
> > +     return task_uid(task);
> > +}
> > +EXPORT_SYMBOL_GPL(rust_helper_task_uid);
> > +
> > +kuid_t rust_helper_task_euid(struct task_struct *task)
> > +{
> > +     return task_euid(task);
> > +}
> > +EXPORT_SYMBOL_GPL(rust_helper_task_euid);
>
> So I still object to these on the ground that they're obvious and
> trivial speculation gadgets.
>
> We should not have (exported) functions that are basically a single
> dereference of a pointer argument.
>
> And I do not appreciate my feedback on the previous round being ignored.

I'm sorry about that. I barely know what speculation gadgets are, so I
didn't really know what to respond. But I should have responded by
saying that.

I can reimplement these specific functions as inline Rust functions,
but I don't think I can give you a general solution to the
rust_helper_* problem in this patch series.

Alice
