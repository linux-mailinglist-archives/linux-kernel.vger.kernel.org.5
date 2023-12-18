Return-Path: <linux-kernel+bounces-4399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 910B4817C7E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 22:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0910C1F23F83
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 21:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957E37408D;
	Mon, 18 Dec 2023 21:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITbsrZSL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938AD73465;
	Mon, 18 Dec 2023 21:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-77f8e4702a6so315703485a.1;
        Mon, 18 Dec 2023 13:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702934125; x=1703538925; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZAFj55iGA/fI8jzbFo5VrB8O4OpZy+ghswsZ8iOlJEs=;
        b=ITbsrZSLt4d0YNokKzmYP1YIjwTiKjKHxHjB4V4pd4/p/7XaY5JjgF41h/3qrgW0O6
         bcl4xIVG8fhXuUzt1WZHsTKGTshxi7pTbz5y2/7KB1aUrTrCGyFmGZXoR1o8PDRPzv2H
         NrIzexStJMSxL6BvtAFazmzLZ6kDWUZZejSFwcf2nn4sBXgc7Kw0ZlDPxnHAmh8rCwBJ
         Va98TnSKdllwM2A/Y9u9asmxLXDcFRf4fz+SvY1jpjPdsDT3rsf1dqis3dV5TIsFX2IO
         bGwnETH266ev3/LNxMCSDvI8qDhJS0UT6ak3Z3oYVwcsGgdJVtBOo8uxPcm+6UTZrOpM
         8OIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702934125; x=1703538925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZAFj55iGA/fI8jzbFo5VrB8O4OpZy+ghswsZ8iOlJEs=;
        b=Fosna+a+T3wW9ARC0RTY+UUOcZLH+4TpsCoWyomUF9+HTlGPCt3LL56+KSxUbYFKhL
         pDbEFW2ZNGMDmW8ETtn2FxVY435sjNyYvJAmCqsw/asEHZCyFK8l+kw0oHeaqPwSjNoA
         riVuny1yyMHQFBApaczxXCy8GDzZ72Aoutagc7ORT76j05zBlq+DnJCwXn8KDWP6uXaq
         fqFW5WuvC3y6CKKTBa6J/O6rqfTy0lUY5akYf0L0t6Vzb/pfg7owpFt9xWRgo73415k4
         /8FKiWmsYHZdkycHTNp7wgJBJlksUW6AsOtRWhtWL2h+8T2vK1HgVPnmn+g2RPe5o9Km
         WsyQ==
X-Gm-Message-State: AOJu0YwYBOhYznaksGJnmS3RmIVu73LNMpCPMvMGopv4Is8jin1hg6i7
	ZqQX6tL83cDFE9/+cUcPrjg=
X-Google-Smtp-Source: AGHT+IG5Dxu0kKKSLDzL8EB5ZqwauaD4ABzu47DHdDTIkeq7xKrJGpOR8xXkW6ZSfd8PhnNUQVpDwg==
X-Received: by 2002:a05:620a:640c:b0:77f:2cae:c6aa with SMTP id pz12-20020a05620a640c00b0077f2caec6aamr21304147qkn.119.1702934125533;
        Mon, 18 Dec 2023 13:15:25 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id wa2-20020a05620a4d0200b007788dac6b24sm8599541qkn.41.2023.12.18.13.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 13:15:25 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailauth.nyi.internal (Postfix) with ESMTP id C682A27C005A;
	Mon, 18 Dec 2023 16:15:24 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 18 Dec 2023 16:15:24 -0500
X-ME-Sender: <xms:bLaAZbLyZgsxHnAE-LQS72adUfi_i9yEd5gW_Esh9bbQ5crPNbx-gw>
    <xme:bLaAZfJd77gTebquISg3UayRtClCgMTxXVeEnGHkaIP9ZJvc3z7gQ5p1SE_PWjNsw
    sjgPu0-7gXzFiREcQ>
X-ME-Received: <xmr:bLaAZTvEyjr_4kOz8oCSF-IwRIFl20EJWelJDOuSqrnLt0hneDyvbCH8WN8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtkedgudeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:bLaAZUb76YkJsSzyj7v6KPPRUiccBBmbX0Aefvtr_i0pbK7ky-2scg>
    <xmx:bLaAZSalLIWDZOllWbo953vCiGZoXTcJbqM0FyyL3l1yBcJvp50Auw>
    <xmx:bLaAZYARUYQasC-N7uhFlvdsgajbHb1tBX_TSyymDgIwvFvKwbH2Gw>
    <xmx:bLaAZXJ8Rb6TkmOrunQwiWDh4xtX5adRVKDQm5Elt1kbOQNFMCh0tg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Dec 2023 16:15:23 -0500 (EST)
Date: Mon, 18 Dec 2023 13:15:07 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Tiago Lam <tiagolam@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] rust: sync: add `CondVar::wait_timeout`
Message-ID: <ZYC2W5Rzdrsr2KKv@boqun-archlinux>
References: <20231216-rb-new-condvar-methods-v2-0-b05ab61e6d5b@google.com>
 <20231216-rb-new-condvar-methods-v2-3-b05ab61e6d5b@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231216-rb-new-condvar-methods-v2-3-b05ab61e6d5b@google.com>

On Sat, Dec 16, 2023 at 03:31:41PM +0000, Alice Ryhl wrote:
> Sleep on a condition variable with a timeout.
> 
> This is used by Rust Binder for process freezing. There, we want to
> sleep until the freeze operation completes, but we want to be able to
> abort the process freezing if it doesn't complete within some timeout.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/sync/condvar.rs | 59 ++++++++++++++++++++++++++++++++++++++++-----
>  rust/kernel/sync/lock.rs    |  4 +--
>  2 files changed, 55 insertions(+), 8 deletions(-)
> 
> diff --git a/rust/kernel/sync/condvar.rs b/rust/kernel/sync/condvar.rs
> index 9331eb606738..0176cdfced6c 100644
> --- a/rust/kernel/sync/condvar.rs
> +++ b/rust/kernel/sync/condvar.rs
> @@ -6,7 +6,8 @@
>  //! variable.
>  
>  use super::{lock::Backend, lock::Guard, LockClassKey};
> -use crate::{bindings, init::PinInit, pin_init, str::CStr, types::Opaque};
> +use crate::{bindings, init::PinInit, pin_init, str::CStr, time::Jiffies, types::Opaque};
> +use core::ffi::c_long;
>  use core::marker::PhantomPinned;
>  use macros::pin_data;
>  
> @@ -18,6 +19,8 @@ macro_rules! new_condvar {
>      };
>  }
>  
> +const MAX_SCHEDULE_TIMEOUT: c_long = c_long::MAX;
> +

I'd like to put this in rust/kernel/time.rs or rust/kernel/task.rs, but
it's not a blocker.

>  /// A conditional variable.
>  ///
>  /// Exposes the kernel's [`struct wait_queue_head`] as a condition variable. It allows the caller to
> @@ -102,7 +105,12 @@ pub fn new(name: &'static CStr, key: &'static LockClassKey) -> impl PinInit<Self
>          })
>      }
>  
> -    fn wait_internal<T: ?Sized, B: Backend>(&self, wait_state: u32, guard: &mut Guard<'_, T, B>) {
> +    fn wait_internal<T: ?Sized, B: Backend>(
> +        &self,
> +        wait_state: u32,
> +        guard: &mut Guard<'_, T, B>,
> +        timeout: c_long,

Nit: maybe `timeout_in_jiffies` instead of `timeout`? Or we have another
data type:

	pub type DeltaJiffies = c_long;

or 

	pub type JiffyDelta = c_long;

because a "c_long timeout" really hurts the readability.

Regards,
Boqun

> +    ) -> c_long {
>          let wait = Opaque::<bindings::wait_queue_entry>::uninit();
>  
>          // SAFETY: `wait` points to valid memory.
> @@ -113,11 +121,13 @@ fn wait_internal<T: ?Sized, B: Backend>(&self, wait_state: u32, guard: &mut Guar
>              bindings::prepare_to_wait_exclusive(self.wait_list.get(), wait.get(), wait_state as _)
>          };
>  
[...]

