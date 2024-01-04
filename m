Return-Path: <linux-kernel+bounces-17307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8FE824B2B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 23:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CFCA1F24BB9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 22:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2832D035;
	Thu,  4 Jan 2024 22:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fa+5SOze"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E432CCAD;
	Thu,  4 Jan 2024 22:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-594bea92494so513719eaf.2;
        Thu, 04 Jan 2024 14:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704408491; x=1705013291; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ig4wvFvhtr+8Tfek404VfnLve6ynwSGmNBANXDk4iHk=;
        b=fa+5SOzeXcqCBhjv8dgmTw/HIsrzZkDuBXZ+zgsfYPBe15CnBgIaA2AvZZyxEstqcK
         P6Kqgbq+WoYzRMRMeTOfp8OKFg/txyIm+Au4bnEalnq33u6G9P0tq8U2r+IUAtcSh7dF
         QchDgOeFGbMz8b1oOP2t578JZusrc5GKmp+1U3Q5ZcDP3+06cQ+8GIY7n+8xujmOfnjz
         yRE0TeXO0UIPVL+rE1+E8qhLe23xhCmCdzo7Ged2X6GEwVNVjJaB3FRD6dgPyoxcx1io
         UZEOZonCuxTsW1avqqw3FegaeLRITzpE7Pfx654nkkox7L46ubuNmxnC09s4RCMXv27r
         L+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704408491; x=1705013291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ig4wvFvhtr+8Tfek404VfnLve6ynwSGmNBANXDk4iHk=;
        b=E7lUwtYFxKFUTsSSrnkXKPHtLPBsvQLGwkk1zyK5d9193EKu6jz9ARc36//PE7ywG1
         Zc0+Iduktq4XRlsoGQmuzSmJc+MFa2BrfvOQdxfJZ+Sa7N7GrMi07hUfvIDSLwsNlpgL
         M1QORlEPsGC+TNveWYnpFUluW1eZ4wVJQ/CNiJv9xckynbgmpE1gmOBe9IFphBgSdYut
         gun6sojPdsNAnOrLGNbQ1KAxyxqjHPan3ZjKSsb34lHFa8UvtZFeUoeeAV6+7ymQLCzM
         qwABEBz1VmpOFeMRJchimA2lh325iG2JbVOfcOAlywxqlNrfzX917BoD605gd7dpP+rw
         7Org==
X-Gm-Message-State: AOJu0YxGSVFC/CNw6djSF3TcN6hfWLMIodsf/8aHq1SHkc/RULNYJLUB
	skgP6pw9eJ4vzjk8tsdxK8w=
X-Google-Smtp-Source: AGHT+IGfvR8XJZSQ113ZitUd9zmFRfxDm7xJXcURskPH74zVS3CNlFiUK0SJbdtVxWMZKsXhvNmPGg==
X-Received: by 2002:a05:6820:2284:b0:594:35b8:5fc8 with SMTP id ck4-20020a056820228400b0059435b85fc8mr1380293oob.8.1704408491424;
        Thu, 04 Jan 2024 14:48:11 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id fz27-20020a05622a5a9b00b0042545c7beccsm189536qtb.59.2024.01.04.14.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 14:48:11 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailauth.nyi.internal (Postfix) with ESMTP id 9256C27C005A;
	Thu,  4 Jan 2024 17:48:10 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 04 Jan 2024 17:48:10 -0500
X-ME-Sender: <xms:qTWXZaaLeprJbFdosXfbnBS-a9jPW6PW_g3juXTTRn4R6DPmkg8-5A>
    <xme:qTWXZda1othseXpQ2eCV4I0eLZ_QL2XyP4ueBkbUBtVD_Npg6FTrTpF7OOjXjPSdM
    hYRDRNg2OHL96dx2A>
X-ME-Received: <xmr:qTWXZU8ITpl5zXQ28ueQo_nffOCyJ6Wb51zWgmGMixWnHIMGST3BD_yVHC8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdegkedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:qTWXZcrvZ9FAFmVfhceXvYE6FTMAs0Tlhh1E1uR6X1kxjUYhfgyxmw>
    <xmx:qTWXZVpZLAHnlFff6jPlesCGC0GTofTMy1YiisUxa4bXKQCIG5dpYQ>
    <xmx:qTWXZaSDB0QpYmhEe59A1te0s9c0vnKksAd2XsfZjx-tD59wMIiZtA>
    <xmx:qjWXZbYoRUTD6xR8w5ng7C92aLRS_JdeO2N3idwgSb8AYO3ej_8PqA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jan 2024 17:48:09 -0500 (EST)
Date: Thu, 4 Jan 2024 14:47:01 -0800
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
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] rust: sync: update integer types in CondVar
Message-ID: <ZZc1ZcgzdRHtipr0@boqun-archlinux>
References: <20240104-rb-new-condvar-methods-v3-0-70b514fcbe52@google.com>
 <20240104-rb-new-condvar-methods-v3-4-70b514fcbe52@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104-rb-new-condvar-methods-v3-4-70b514fcbe52@google.com>

On Thu, Jan 04, 2024 at 02:02:44PM +0000, Alice Ryhl wrote:
[...]
> -use core::ffi::c_long;
> +use core::ffi::{c_int, c_long, c_uint};

core::ffi::c_uint is not needed here. And 

	use core::ptr;

is missing (for the `ptr::mut_null()` below)

>  use core::marker::PhantomPinned;
>  use macros::pin_data;
>  
[...]
> @@ -174,23 +179,16 @@ pub fn wait_interruptible_timeout<T: ?Sized, B: Backend>(
>          }
>      }
>  
> -    /// Calls the kernel function to notify the appropriate number of threads with the given flags.
> -    fn notify(&self, count: i32, flags: u32) {
> +    /// Calls the kernel function to notify the appropriate number of threads.
> +    fn notify(&self, count: c_int) {
>          // SAFETY: `wait_list` points to valid memory.
> -        unsafe {
> -            bindings::__wake_up(
> -                self.wait_list.get(),
> -                bindings::TASK_NORMAL,
> -                count,
> -                flags as _,
> -            )
> -        };
> +        unsafe { bindings::__wake_up(self.wait_list.get(), TASK_NORMAL, count, ptr::null_mut()) };
>      }
>  
[...]
> diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
> index ffb4a51eb898..37468613ac0d 100644
> --- a/rust/kernel/task.rs
> +++ b/rust/kernel/task.rs
> @@ -10,6 +10,14 @@

Missing:

	use core::ffi::{c_long, c_int, c_uint};

here.

Regards,
Boqun

>  /// A sentinal value used for infinite timeouts.
>  pub const MAX_SCHEDULE_TIMEOUT: c_long = c_long::MAX;
>  
> +/// Bitmask for tasks that are sleeping in an interruptible state.
> +pub const TASK_INTERRUPTIBLE: c_int = bindings::TASK_INTERRUPTIBLE as c_int;
> +/// Bitmask for tasks that are sleeping in an uninterruptible state.
> +pub const TASK_UNINTERRUPTIBLE: c_int = bindings::TASK_UNINTERRUPTIBLE as c_int;
> +/// Convenience constant for waking up tasks regardless of whether they are in interruptible or
> +/// uninterruptible sleep.
> +pub const TASK_NORMAL: c_uint = bindings::TASK_NORMAL as c_uint;
> +
>  /// Returns the currently running task.
>  #[macro_export]
>  macro_rules! current {
> 
> -- 
> 2.43.0.472.g3155946c3a-goog
> 

