Return-Path: <linux-kernel+bounces-8796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB00E81BC69
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62A2C285983
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B96C59935;
	Thu, 21 Dec 2023 16:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+OARogT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727D158224;
	Thu, 21 Dec 2023 16:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3ba2e4ff6e1so665371b6e.3;
        Thu, 21 Dec 2023 08:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703177685; x=1703782485; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oOnyS6RoUGj7q+YQFnfztHo1ETrd0QQj20PKPiFIAeQ=;
        b=i+OARogTvG7Mp5xagjgzYMNMMzwCO6UyECNegkBgvrsFUFv+yBojejZe8Iwgbjx8yn
         gAF3WVWTqc7Vwn0gBK2x7V0VGl4Q0IhRpKpF4lVBSUNJhhgwKX80RaKdJLGnuunxrG6q
         /1UnMGcJY2zhcDOKkcEX9+S79v/jf5BUBeUjzDmaOEjkt7Rvce3OznnO9gtpaWqcI4Tm
         YCqEzEWZEQ7V+7rgpftUOrg+gcBZM6iTmKbBffKzODCwsMfg5XzCMYqi221eGs5zxMcP
         9j1VOW1b8xkrX/l21SyzTDi84rLcJT4WECCCT04se6r6qA5yXQLDcLSWno39pR+r3ehM
         Rnvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703177685; x=1703782485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oOnyS6RoUGj7q+YQFnfztHo1ETrd0QQj20PKPiFIAeQ=;
        b=oJzxJ2/6KxrX004N49VGwGqc94io7D9CVLSovWlqK68f3chZrIXsV4qnnzBf84KXOe
         +egIk3mlp9h0KqgUhuhqH74zRVCLkvwLPfqf+ASHgy+EKECaMpix/1HORu4YCbLgjzlk
         OeXIgCRC0qIcIA3Uwb/2W84tSyGT2sNs4g1wXYMaEQxJneMSe1DfC4+YCWsa3W7Wz67J
         qY1YaFx9RwP6klmcNCek0tcwl3wKR7oD7CpBHyIITIDxSCybQyLnxpM8wTGF2BzcWxoT
         Xeg8y+jQG6PjvF7jGWJ+MrHjlOJR0MnX5Mvmmw6GTuyVIbvej+JCqwQCUiFBC3mUciAL
         3RFw==
X-Gm-Message-State: AOJu0YzG9sVL5jnge5upCTgjIBxz6LLbuOULWJpEfiDw9A4N0wb1tLg2
	xX+1o7185hcDCUz2TM75lX4=
X-Google-Smtp-Source: AGHT+IGp9HlLb3GzSyhQ5t66Urd72n7BMXw7L1Vg/sLOayffEUFcIwUSJ7Xz1dQXLjJ5Uq0y03A4pQ==
X-Received: by 2002:a05:6808:1409:b0:3bb:7448:676f with SMTP id w9-20020a056808140900b003bb7448676fmr3058794oiv.30.1703177685467;
        Thu, 21 Dec 2023 08:54:45 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id cu7-20020a05621417c700b0067f81a1494esm580687qvb.55.2023.12.21.08.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 08:54:44 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailauth.nyi.internal (Postfix) with ESMTP id 2FEC827C005A;
	Thu, 21 Dec 2023 11:54:44 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 21 Dec 2023 11:54:44 -0500
X-ME-Sender: <xms:022EZb1FJJ9xKlh8gOonVzgYYEORXf5Zc94tdiDAElp_6XvY7OiHeg>
    <xme:022EZaGbS9Hv6NZS4qaEYosn_Zz6c4Xt5UYrFY1jIiwYVPEqzg3WT0Ztmu9t3Tpb9
    Kg2JNawW4bFc2WT9A>
X-ME-Received: <xmr:022EZb5B0BgGLtkBGU0YH-54A0AC5LSqsRri92C3XUG4eqstKg7WT_-k_fXYsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduhedgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:022EZQ0eyE-D2KxVwNG0ZFHQ6ryjJ14mdjkHE5xijKfsr6SDvvKOEg>
    <xmx:022EZeE9dPm120a8WcCz5bPNFXplXyURpJLK_lVFxBilTv4D7D1OJw>
    <xmx:022EZR8baVBMlDrWhY8Jah7LWtJeKXerGj0XXjnsdmXeHFRruOXslw>
    <xmx:1G2EZcFiglWm-z2NTm1d8mjC9x72Enxfe6iZiTGikgNxg2yd1z-u9g>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Dec 2023 11:54:42 -0500 (EST)
Date: Thu, 21 Dec 2023 08:54:17 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Tiago Lam <tiagolam@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] rust: sync: add `CondVar::wait_timeout`
Message-ID: <ZYRtuRXPgQcN_3cr@boqun-archlinux>
References: <20231216-rb-new-condvar-methods-v2-0-b05ab61e6d5b@google.com>
 <20231216-rb-new-condvar-methods-v2-3-b05ab61e6d5b@google.com>
 <3fba196a-8cb6-4ce9-9e67-bfb716a2d171@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fba196a-8cb6-4ce9-9e67-bfb716a2d171@proton.me>

On Wed, Dec 20, 2023 at 11:31:05AM +0000, Benno Lossin wrote:
> On 12/16/23 16:31, Alice Ryhl wrote:
> > @@ -102,7 +105,12 @@ pub fn new(name: &'static CStr, key: &'static LockClassKey) -> impl PinInit<Self
> >          })
> >      }
> > 
> > -    fn wait_internal<T: ?Sized, B: Backend>(&self, wait_state: u32, guard: &mut Guard<'_, T, B>) {
> > +    fn wait_internal<T: ?Sized, B: Backend>(
> > +        &self,
> > +        wait_state: u32,
> > +        guard: &mut Guard<'_, T, B>,
> > +        timeout: c_long,
> > +    ) -> c_long {
> >          let wait = Opaque::<bindings::wait_queue_entry>::uninit();
> > 
> >          // SAFETY: `wait` points to valid memory.
> > @@ -113,11 +121,13 @@ fn wait_internal<T: ?Sized, B: Backend>(&self, wait_state: u32, guard: &mut Guar
> >              bindings::prepare_to_wait_exclusive(self.wait_list.get(), wait.get(), wait_state as _)
> >          };
> > 
> > -        // SAFETY: No arguments, switches to another thread.
> > -        guard.do_unlocked(|| unsafe { bindings::schedule() });
> > +        // SAFETY: Switches to another thread. The timeout can be any number.
> > +        let ret = guard.do_unlocked(|| unsafe { bindings::schedule_timeout(timeout) });
> 
> I am not sure what exactly the safety requirements of `schedule_timeout`
> are. I looked at the function and saw that the timout should not be
> negative. But aside from that only the the context switching should be
> relevant. What things are not allowed to do when calling `schedule`
> (aside from the stuff that klint catches)?

One thing is that you probably don't want to call `schedule` with task
state being TASK_DEAD, if so the `schedule` would be counted as
`ARef<Task>::drop()`, see __schedule() -> context_switch() ->
finish_context_switch(), and the task may be freed after that, which
free the stack of the task, and anything that references a object on the
stack would be a UAF. On the other hand, if the task state is not
TASK_DEAD, `schedule*()` should be a no-op regarding memory safety.

> Because if there are none, then I would put the "switches to another
> thread" part into a normal comment.
> 

I think it's possible to make schedule_timeout() a safe function: we can
define setting task state TASK_DEAD as an unsafe operation, whose safety
requirement is something like: "Must ensure that if some code can
reference a memory object that belongs to the task (e.g. a stack
variable) after the task calls a followed `schedule()`, the code must
also hold an additional reference count to the task."

Yes, it might be out of the scope of this patchset though.

Regards,
Boqun

> -- 
> Cheers,
> Benno
> 
> > 
> >          // SAFETY: Both `wait` and `wait_list` point to valid memory.
> >          unsafe { bindings::finish_wait(self.wait_list.get(), wait.get()) };
> > +
> > +        ret
> >      }
> 

