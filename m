Return-Path: <linux-kernel+bounces-53132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4A884A116
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A55B2B2134A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB94245035;
	Mon,  5 Feb 2024 17:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aYjxjMwu"
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267CD446BC;
	Mon,  5 Feb 2024 17:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707154837; cv=none; b=COJlWafuqE1S6QQx9BYtBS39n9lpZ3FtRMcrd29o3Xct4O3e2IhOJ3xoRGv3+pROKzHy3gmt2bHydoBuoyZC3WlEuZ4b7z7x9FWciUtCNrlMQudvWLxRqKJAprSwuLDlEC6+7zguearUP5yxpA/GwpjEmfB8bWa0NwmY0ZBYmdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707154837; c=relaxed/simple;
	bh=M6pOvIo1Wd931byVMykKh7XsOivQ+mbW1mTLMmCGhME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E31Wahs9ddaK5fapY/QVp2U8ImkGjecoMa/4XlJ727hpuKXqWUrDZp4tvc1rWdLjtz7PDjtaTgRXkVvaCXtZJKVviJB2a7KaU209zBowvJMyNXt//NgqlKh9eUCcd8WnCu0qT3Dj+m8vMMSK0M5u1vosVjR/bpvUOVuxrEqFUeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aYjxjMwu; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4c021a73febso488142e0c.2;
        Mon, 05 Feb 2024 09:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707154835; x=1707759635; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6sd3MqpkPfETb8+jxwao7rv6fptVZILhkVXNFoUWJdM=;
        b=aYjxjMwuUtqrR9IgPK1Oh08Te42XOhywmqFRDt0vDpfsxaymqj+5fyyxPdCAtJc3yO
         KaE4AW30N9QysSPPK4H0gec2aYM3Fm59lJRCAjPmXv9PGyWEnNCpYaxELDw2pK0Zjjif
         A5w8Xg0XPFL2x5y1al+cFqm08ltiuuwTIcaYVpEK2T7J6rnUCJ/fpckdVIEJKdP8dDSJ
         +XyMQ4+B/e6mROJz6UIOMsY9VwevyA/cyaZNrSWXVVkNe3Y26Koa8Kjas7iDuIlK738p
         jmCtD7OuX4G+ltWVpOjK2yIRiLbzz+qvZ3eZ7IdUrb5SBBDut4h3E28Y8itHwTqAld3S
         W67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707154835; x=1707759635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6sd3MqpkPfETb8+jxwao7rv6fptVZILhkVXNFoUWJdM=;
        b=OKfN3Z0fJhXmD4nM/GShLqGZ+6BZnXW0wCrmYf5cNm8RZs8oa1+AlLd+rvBDlrq4YK
         UrMvSnGYj7z93rocpfwpaBhYOEcZqT3wRlXADFW+/Ojj4U/znSXLu9++GA6LXtxDjF1Y
         uZUi8f1WVQpHEix9WD+DBXUOEMcCl20PJ2SRsU+X8RD5bP3EC8gS3zmVWVmaMzYFdc3N
         h+DOiECGID1XR183SFh39k+iTvn4WgfVFc7Ce+0ZkCNyXTlvMdASPRv67rQD+wVrqAC1
         AsCSRvLV/XR/GJp4sIHt3aa3lGlhgqCtqAybX0tfuAYRooedy4zQtyxt/YP5a55ubV1Y
         Hh+A==
X-Gm-Message-State: AOJu0Yw7XezeKwC1UUpHSX39Kjzh89hrKip/XyknlDyYso8ktdSVgrfl
	bIyJPBOZXAbuJOk5u5/kwDvwM8khi4p1HZzQEUwDmLpYmP2GC5xjECkDoYZ7
X-Google-Smtp-Source: AGHT+IHL+6m1BR2MdkAfxDKMQdpABxHeCJXIS4poMvbR7s/FO3xbjTolgf7g7STS+94zPPdNilAufQ==
X-Received: by 2002:a05:6122:169c:b0:4b6:d4c2:61d3 with SMTP id 28-20020a056122169c00b004b6d4c261d3mr287104vkl.0.1707154834711;
        Mon, 05 Feb 2024 09:40:34 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW8Vyg3JXRAAcT2/lJubpQ7KopWNlaRJc84HvMaUTAi3wz56qAGxbXnsGtJGgkZiu4hY+rCJbAgIO5MFIM5g2gwlf6XueVTgA8Sjh4xkigx92pSoSzB/TufD0NcMfsyD7Os1NZyl0lcv7cJrkOT6Kgz0gbXNUKniOqQvwZcKo9MDO2FsU176cfmwvCfSXZWW+dB4Mfjp55mvzcrtbQbCE2qntoNw1eKgK64UjS6w/rlnavxFfe8pMLpAxdTZ0tDWsuTtFu03C+Gr3Wh4Jw0PGh41+Q9OPEBtznLfPCBZjVehF1s5w875Msb2cz90oE=
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id c9-20020a05620a134900b007858ac144d7sm77652qkl.70.2024.02.05.09.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 09:40:34 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailauth.nyi.internal (Postfix) with ESMTP id 93A1627C005B;
	Mon,  5 Feb 2024 12:40:33 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 05 Feb 2024 12:40:33 -0500
X-ME-Sender: <xms:kR3BZSvYZjKXpNFhEqzi6mcRXJ5yaifxRrpEAv0U8AN2dsVULkWd7Q>
    <xme:kR3BZXfImrVyop3emBWXvHGAxo8_Vvoya9zY9Cj5ZaWHOewbs1S2nIRwLOUtHUUIO
    CIcrtTE5-xkhWahig>
X-ME-Received: <xmr:kR3BZdycFlpjG1T-piYGrzsxGYBWR9Dgt27AQt6cPgpuB22Cz3ZL_LI-PbPMTA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedvuddgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:kR3BZdPdQVRAsz-D0xQfDGL5pUY5QWyt3YFE24QuK1p6l6ltd9adjQ>
    <xmx:kR3BZS_JHsKgr0C1EjdYlzMLAr7r3tjb47dS6u0jLj1jy_i3aYEekA>
    <xmx:kR3BZVV_Fgq3oDnBJ1iPGbj6DiTQG3GfvkpuTn1qUzeqhjdvStBOJQ>
    <xmx:kR3BZVYZJqlRsrP4ZsjbZkhgicALpmHcPIOlEAa2uKeyL8VZ_8AcHQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Feb 2024 12:40:33 -0500 (EST)
Date: Mon, 5 Feb 2024 09:39:15 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] rust: add reexports for macros
Message-ID: <ZcEdQyaz0uLDOhrk@boqun-archlinux>
References: <20240129145837.1419880-1-aliceryhl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129145837.1419880-1-aliceryhl@google.com>

On Mon, Jan 29, 2024 at 02:58:37PM +0000, Alice Ryhl wrote:
> Currently, all macros are reexported with #[macro_export] only, which
> means that to access `new_work!` from the workqueue, you need to import
> it from the path `kernel::new_work` instead of importing it from the
> workqueue module like all other items in the workqueue. By adding
> reexports of the macros, it becomes possible to import the macros from
> the correct modules.
> 
> It's still possible to import the macros from the root, but I don't
> think we can do anything about that.
> 
> There is no functional change. This is merely a code cleanliness
> improvement.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> I hope that the KUnit examples still compile. I tried checking myself
> and it seemed to work, but I'm not completely sure whether I used the
> tool correctly. I would appreciate if someone is able to double-check
> and give a Tested-by for that.

Tested-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> 
>  rust/kernel/init.rs               |  8 +++++---
>  rust/kernel/sync.rs               |  5 +++--
>  rust/kernel/sync/condvar.rs       |  4 ++--
>  rust/kernel/sync/lock/mutex.rs    |  4 +++-
>  rust/kernel/sync/lock/spinlock.rs |  4 +++-
>  rust/kernel/workqueue.rs          | 14 ++++++--------
>  6 files changed, 22 insertions(+), 17 deletions(-)
> 
> diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
> index 65be9ae57b80..d7107db1d587 100644
> --- a/rust/kernel/init.rs
> +++ b/rust/kernel/init.rs
> @@ -36,7 +36,8 @@
>  //!
>  //! ```rust
>  //! # #![allow(clippy::disallowed_names)]
> -//! use kernel::{prelude::*, sync::Mutex, new_mutex};
> +//! use kernel::prelude::*;
> +//! use kernel::sync::{new_mutex, Mutex};
>  //! # use core::pin::Pin;
>  //! #[pin_data]
>  //! struct Foo {
> @@ -56,7 +57,8 @@
>  //!
>  //! ```rust
>  //! # #![allow(clippy::disallowed_names)]
> -//! # use kernel::{prelude::*, sync::Mutex, new_mutex};
> +//! # use kernel::prelude::*;
> +//! # use kernel::sync::{new_mutex, Mutex};
>  //! # use core::pin::Pin;
>  //! # #[pin_data]
>  //! # struct Foo {
> @@ -79,7 +81,7 @@
>  //! above method only works for types where you can access the fields.
>  //!
>  //! ```rust
> -//! # use kernel::{new_mutex, sync::{Arc, Mutex}};
> +//! # use kernel::sync::{new_mutex, Arc, Mutex};
>  //! let mtx: Result<Arc<Mutex<usize>>> = Arc::pin_init(new_mutex!(42, "example::mtx"));
>  //! ```
>  //!
> diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> index c1fb10fc64f4..c983f63fd56e 100644
> --- a/rust/kernel/sync.rs
> +++ b/rust/kernel/sync.rs
> @@ -13,8 +13,9 @@
>  mod locked_by;
>  
>  pub use arc::{Arc, ArcBorrow, UniqueArc};
> -pub use condvar::{CondVar, CondVarTimeoutResult};
> -pub use lock::{mutex::Mutex, spinlock::SpinLock};
> +pub use condvar::{new_condvar, CondVar, CondVarTimeoutResult};
> +pub use lock::mutex::{new_mutex, Mutex};
> +pub use lock::spinlock::{new_spinlock, SpinLock};
>  pub use locked_by::LockedBy;
>  
>  /// Represents a lockdep class. It's a wrapper around C's `lock_class_key`.
> diff --git a/rust/kernel/sync/condvar.rs b/rust/kernel/sync/condvar.rs
> index 9f1d83589beb..72680ff57e67 100644
> --- a/rust/kernel/sync/condvar.rs
> +++ b/rust/kernel/sync/condvar.rs
> @@ -27,6 +27,7 @@ macro_rules! new_condvar {
>          $crate::sync::CondVar::new($crate::optional_name!($($name)?), $crate::static_lock_class!())
>      };
>  }
> +pub use new_condvar;
>  
>  /// A conditional variable.
>  ///
> @@ -44,8 +45,7 @@ macro_rules! new_condvar {
>  /// The following is an example of using a condvar with a mutex:
>  ///
>  /// ```
> -/// use kernel::sync::{CondVar, Mutex};
> -/// use kernel::{new_condvar, new_mutex};
> +/// use kernel::sync::{new_condvar, new_mutex, CondVar, Mutex};
>  ///
>  /// #[pin_data]
>  /// pub struct Example {
> diff --git a/rust/kernel/sync/lock/mutex.rs b/rust/kernel/sync/lock/mutex.rs
> index 8c524a3ec45a..38207f9ce78a 100644
> --- a/rust/kernel/sync/lock/mutex.rs
> +++ b/rust/kernel/sync/lock/mutex.rs
> @@ -17,6 +17,7 @@ macro_rules! new_mutex {
>              $inner, $crate::optional_name!($($name)?), $crate::static_lock_class!())
>      };
>  }
> +pub use new_mutex;
>  
>  /// A mutual exclusion primitive.
>  ///
> @@ -35,7 +36,8 @@ macro_rules! new_mutex {
>  /// contains an inner struct (`Inner`) that is protected by a mutex.
>  ///
>  /// ```
> -/// use kernel::{init::InPlaceInit, init::PinInit, new_mutex, pin_init, sync::Mutex};
> +/// use kernel::prelude::*;
> +/// use kernel::sync::{new_mutex, Mutex};
>  ///
>  /// struct Inner {
>  ///     a: u32,
> diff --git a/rust/kernel/sync/lock/spinlock.rs b/rust/kernel/sync/lock/spinlock.rs
> index 068535ce1b29..cb2c6f71e80e 100644
> --- a/rust/kernel/sync/lock/spinlock.rs
> +++ b/rust/kernel/sync/lock/spinlock.rs
> @@ -17,6 +17,7 @@ macro_rules! new_spinlock {
>              $inner, $crate::optional_name!($($name)?), $crate::static_lock_class!())
>      };
>  }
> +pub use new_spinlock;
>  
>  /// A spinlock.
>  ///
> @@ -33,7 +34,8 @@ macro_rules! new_spinlock {
>  /// contains an inner struct (`Inner`) that is protected by a spinlock.
>  ///
>  /// ```
> -/// use kernel::{init::InPlaceInit, init::PinInit, new_spinlock, pin_init, sync::SpinLock};
> +/// use kernel::prelude::*;
> +/// use kernel::sync::{new_spinlock, SpinLock};
>  ///
>  /// struct Inner {
>  ///     a: u32,
> diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
> index 498397877376..0ed17451b06e 100644
> --- a/rust/kernel/workqueue.rs
> +++ b/rust/kernel/workqueue.rs
> @@ -35,8 +35,7 @@
>  //! ```
>  //! use kernel::prelude::*;
>  //! use kernel::sync::Arc;
> -//! use kernel::workqueue::{self, Work, WorkItem};
> -//! use kernel::{impl_has_work, new_work};
> +//! use kernel::workqueue::{self, impl_has_work, new_work, Work, WorkItem};
>  //!
>  //! #[pin_data]
>  //! struct MyStruct {
> @@ -78,8 +77,7 @@
>  //! ```
>  //! use kernel::prelude::*;
>  //! use kernel::sync::Arc;
> -//! use kernel::workqueue::{self, Work, WorkItem};
> -//! use kernel::{impl_has_work, new_work};
> +//! use kernel::workqueue::{self, impl_has_work, new_work, Work, WorkItem};
>  //!
>  //! #[pin_data]
>  //! struct MyStruct {
> @@ -147,6 +145,7 @@ macro_rules! new_work {
>          $crate::workqueue::Work::new($crate::optional_name!($($name)?), $crate::static_lock_class!())
>      };
>  }
> +pub use new_work;
>  
>  /// A kernel work queue.
>  ///
> @@ -396,9 +395,8 @@ pub unsafe fn raw_get(ptr: *const Self) -> *mut bindings::work_struct {
>  /// like this:
>  ///
>  /// ```no_run
> -/// use kernel::impl_has_work;
>  /// use kernel::prelude::*;
> -/// use kernel::workqueue::Work;
> +/// use kernel::workqueue::{impl_has_work, Work};
>  ///
>  /// struct MyWorkItem {
>  ///     work_field: Work<MyWorkItem, 1>,
> @@ -473,9 +471,8 @@ unsafe fn work_container_of(ptr: *mut Work<T, ID>) -> *mut Self
>  /// # Examples
>  ///
>  /// ```
> -/// use kernel::impl_has_work;
>  /// use kernel::sync::Arc;
> -/// use kernel::workqueue::{self, Work};
> +/// use kernel::workqueue::{self, impl_has_work, Work};
>  ///
>  /// struct MyStruct {
>  ///     work_field: Work<MyStruct, 17>,
> @@ -509,6 +506,7 @@ unsafe fn raw_get_work(ptr: *mut Self) -> *mut $crate::workqueue::Work<$work_typ
>          }
>      )*};
>  }
> +pub use impl_has_work;
>  
>  impl_has_work! {
>      impl<T> HasWork<Self> for ClosureWork<T> { self.work }
> 
> base-commit: f090f0d0eea9666a96702b29bc9a64cbabee85c5
> -- 
> 2.43.0.429.g432eaa2c6b-goog
> 
> 

