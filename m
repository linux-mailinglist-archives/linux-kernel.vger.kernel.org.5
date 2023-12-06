Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2DF48075EF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 18:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442666AbjLFRAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 12:00:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjLFRAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 12:00:46 -0500
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0BED40
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 09:00:52 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id ada2fe7eead31-4647a565b1aso1097293137.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 09:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701882052; x=1702486852; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NF9nufPWnM01j1SPHynVIUvkO1Ix/4ylpVaBOu+mZxc=;
        b=N6Rj66GsjPuQhvDb63IpWMcaD1Wn5L9jUZKW7ZVbZOS4Y8upcucN89hlbA+FVR8U1A
         wr/7C+lppaFD8RkUwtKIf9fga14Uzvn+jm9LKhWANVKg2ujNnj/WbVS1ONvuA4WJp+t9
         1JMC6ku5aU/APTE93RAX/gMyy2/iApTiGT+vYd3lLiknoPP6bLSLA8HWKXURLXU2m7jV
         yk/gLfSqH6Xti2gFstdhAtm34vHTeI3Qm2VIZ8H7IWEKR/5JqZP9zF/O9DOhLBfS9Kqj
         rgNLDOJs5K3DuCjCBqkzXgGThyG0cq2qDkrcGtzl3EfbkSVwBOdye4WFWZhic0Y56HLU
         TMzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701882052; x=1702486852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NF9nufPWnM01j1SPHynVIUvkO1Ix/4ylpVaBOu+mZxc=;
        b=v6i75DWCmdp7XbtvKhI7ymQjFteAGE8toURz29Kr5jaE4PgjnTiUHAUtRvW7xc4MjS
         VI2w7HjTylQv6ZwOOOdWR+Pghsa00wo+AIwOW2doksMaR8NdnjFDWeHKw7A4KyPNjrc3
         dmy8XPFlQrcC14+tG5g+g3rsDb7pdjgWozEtSwyxSjli+4e5G883rPL/4ynil+NP3F7L
         HAehzGT6yyddZTNqaMmELYY5MmMKbeBpWyHYNiSaNlF5UfAMff9Oz20NoKg4mDNFKw2x
         XZANHzZjwiMh8VgdqQ+pQRJvoGnrGSAallNrBnUICAixYbPbZG0JZow3Aq2PwvSXpkUE
         qfQw==
X-Gm-Message-State: AOJu0Yyq/WED2Nzig2cgsU4SIBr1hi6pgvyCQ6UJ4L+3Ef1OnLWjxiXE
        01yfzZlyXhF9GGQLBkXALBI1f0hnLfqMaJRkov+F8Q==
X-Google-Smtp-Source: AGHT+IFaQ0MvL2WLpAX7SvEzm7LltpqPnfhRGTfoLWdg+HMEuMFw4REkG0GMFaFmWlA6w4k/s8hGVGFp0TMo/JUcp5c=
X-Received: by 2002:a67:cd8c:0:b0:464:8391:98d2 with SMTP id
 r12-20020a67cd8c000000b00464839198d2mr1175682vsl.27.1701882051829; Wed, 06
 Dec 2023 09:00:51 -0800 (PST)
MIME-Version: 1.0
References: <20231206-rb-new-condvar-methods-v1-0-33a4cab7fdaa@google.com>
 <20231206-rb-new-condvar-methods-v1-2-33a4cab7fdaa@google.com>
 <ZXChjmoKPj3XnJgG@Boquns-Mac-mini.home> <20231206163945.GC36423@noisy.programming.kicks-ass.net>
 <CAH5fLgi56i70MaFaoLcWVw+nf-ZvOLpmA8bHNVX=VXTBkcSa4Q@mail.gmail.com> <20231206165314.GD36423@noisy.programming.kicks-ass.net>
In-Reply-To: <20231206165314.GD36423@noisy.programming.kicks-ass.net>
From:   Alice Ryhl <aliceryhl@google.com>
Date:   Wed, 6 Dec 2023 18:00:38 +0100
Message-ID: <CAH5fLgjeQFKvqqXUHi6xXKFRYD-jKHAEWPyKJPDnr9pmw0QKxg@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: sync: add `CondVar::wait_timeout`
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
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

On Wed, Dec 6, 2023 at 5:53=E2=80=AFPM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Wed, Dec 06, 2023 at 05:42:29PM +0100, Alice Ryhl wrote:
> > On Wed, Dec 6, 2023 at 5:39=E2=80=AFPM Peter Zijlstra <peterz@infradead=
.org> wrote:
> > >
> > > On Wed, Dec 06, 2023 at 08:30:06AM -0800, Boqun Feng wrote:
> > > > On Wed, Dec 06, 2023 at 10:09:24AM +0000, Alice Ryhl wrote:
> > > > [...]
> > > > > +
> > > > > +/// The return type of `wait_timeout`.
> > > > > +pub enum CondVarTimeoutResult {
> > > > > +    /// The timeout was reached.
> > > > > +    Timeout,
> > > > > +    /// Somebody woke us up.
> > > > > +    Woken {
> > > > > +        /// Remaining sleep duration.
> > > > > +        jiffies: u64,
> > > >
> > > > I have a Jiffies definition in the my upcoming timer patchset:
> > > >
> > > > /// The time unit of Linux kernel. One jiffy equals (1/HZ) second.
> > > > pub type Jiffies =3D core::ffi::c_ulong;
> > > >
> > > > Maybe you can add that (in a separate patch) in kernel::time?
> > >
> > > Urgh, why are we using jiffies in 2023?
> >
> > I assumed that the correct thing here would be to accept the same unit
> > as what schedule_timeout takes. Should I be doing something else?
>
> Bah, so we have schedule_hrtimeout() that takes ktime/u64 nsec. But the
> 'problem' is that hrtimers are written with the expectation to fire,
> while the old timers are written with the expectation to not fire.
>
> Timeouts are typically best done with the latter, so in that regard
> using schedule_timeout() is right. But it is sad to inflict the
> brain-damage that is jiffies onto new code.
>
> Perhaps add schedule_timeout_*msec() wrappers around schedule_timeout*()
> and use a consistent sane time unit?
>
> Thomas?

Hmm, looking over my usage in Rust Binder again ... the unit I need
*is* msec, but when we are woken up, we sometimes just go to sleep
again, which means that we need to be able to pass the remaining
duration back to `wait_timeout` to continue sleeping. I'm guessing
that I would lose precision if I converted back/forth to msecs here?

Alice
