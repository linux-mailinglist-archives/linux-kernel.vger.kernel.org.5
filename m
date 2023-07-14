Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3B1754045
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235841AbjGNRQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235576AbjGNRQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:16:11 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD63213F;
        Fri, 14 Jul 2023 10:16:09 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-991fe70f21bso292900566b.3;
        Fri, 14 Jul 2023 10:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689354968; x=1691946968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2RXNekYfM5171RgGB71xpzycQCjffPM2bUadpzvdYM=;
        b=kY/0v+8unNJQcfq5G4tka0qTrueA3NR7SZbTQflBgHhr9g09QpGjiK78+3Uhb6BqHU
         ckweVFmcxBY8DVkL0GNCuQ9XyFWGKAo4c+2bHPGyLAT1m5xe5uQyAJH0nTYYyQ2I/a1O
         EvNaBkvoHnY5VyoNjDswB3Ba+yjnrQDQLVi+foHbDEmUevCPnJMMZ6mupxdhxpDqu+jP
         bA4+DE7TbJAxLRtbo7qfS7J1mRsaXE5vJ1fZ4GQxPCCqnwUxUx372QY9BpffHLNYZZwP
         3u75uiHJ7cxfjxHBg3n7bgyyC4WTNr0PgSlaynoEZPLhMfAFOUBmJ/KhKtxzsO8BJiK5
         a41g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689354968; x=1691946968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r2RXNekYfM5171RgGB71xpzycQCjffPM2bUadpzvdYM=;
        b=FvW4JZvb2kXmsPjRKCq+6x7S5i10w3yHPBrgyVhnoCmn0AQhoFILDnvdiIrVc6ZOAI
         F1WkXIABI7z2BNyuDcxsaJELvb1RNy/x918cwk5nAqaUXQ7c8CkiYwYuFMW076VO7+Gs
         Ndb9szdCRgMagP7av2gtNLw+14fGo1kiQxUrvXlUh5oU1Yi/4UnM7+MSKdwmiuwZl1jC
         EhCeVWO1dD3fjrcPtF7p43LTl12Bc6QmCAEIypVoqdkshwAOgzCfvCg9EnERktW8WW3w
         DojzYswImsRICVZU1e1QkSqGJLSufjw1JLc6RnozP/1K+8D4nMvfdbRRV3eM9UpwZux/
         cx9A==
X-Gm-Message-State: ABy/qLawWs3REmeeu5AYDyE1PlYYkzpXaSBeUgFDBbr+ZZ4aRTPSDLR7
        e0XKXLycwbzFUPRY48TtKaw=
X-Google-Smtp-Source: APBJJlFLC6kFNEtpH6puqR796JdKyi+W0W5hMTNHayoZCKJ9vd9Ezy1JD4td+bxuWPimRwVkekS7HA==
X-Received: by 2002:a17:906:841:b0:991:cfce:7a09 with SMTP id f1-20020a170906084100b00991cfce7a09mr3864728ejd.67.1689354967936;
        Fri, 14 Jul 2023 10:16:07 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id cw13-20020a170906c78d00b0098748422178sm5630042ejb.56.2023.07.14.10.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:16:07 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailauth.nyi.internal (Postfix) with ESMTP id 1746A27C005C;
        Fri, 14 Jul 2023 13:16:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 14 Jul 2023 13:16:05 -0400
X-ME-Sender: <xms:04KxZCID6QkDcWQn3gkVwhjFPTnoHp-GxQ-gHjQwlQRcx4zoWwZRZA>
    <xme:04KxZKL9VDjmrijoIe3HccSHl6Uw7hApzH3bCkRx2CHQYN_3M75Of5YcC6lCg8XWn
    qoashTWVDmDHehhwA>
X-ME-Received: <xmr:04KxZCvix5wArhaXEF8Si9GdacDSr0pgIB5bAqJwnoJG-5_uMYCJibUoIHc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrfeeigdduudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeffleejleehveelteeltedugffhhedvkefgvdehfeeiffeihfeigfdvtdeu
    hfdtteenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhn
    odhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejje
    ekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhn
    rghmvg
X-ME-Proxy: <xmx:04KxZHZa1WQpui9cc9r6sV0JMYXPjXV5dWe5_oOYe7pjHcutNhe4fQ>
    <xmx:04KxZJZMKZO27ZRC_VLeBpVMPPyM5o5A_vvRzA97TPYYDPMro_ydKQ>
    <xmx:04KxZDD8kvJAhSMI91zO2atGV8Enx4_ZRqyvy-hg7H-9qQDNLxeJZQ>
    <xmx:1IKxZPz1DkENhY7hLVEGBMW5WHAbFRZx5PLQOE7LQFfZzdiPe8EJ7g>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Jul 2023 13:16:03 -0400 (EDT)
Date:   Fri, 14 Jul 2023 10:15:59 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Asahi Lina <lina@asahilina.net>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Josh Stone <jistone@redhat.com>,
        Gaelan Steele <gbs@canishe.com>,
        Heghedus Razvan <heghedus.razvan@protonmail.com>,
        linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        asahi@lists.linux.dev
Subject: Re: [PATCH v2] rust: time: New module for timekeeping functions
Message-ID: <ZLGCz00r9T0LfEbC@boqun-archlinux>
References: <20230714-rust-time-v2-1-f5aed84218c4@asahilina.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714-rust-time-v2-1-f5aed84218c4@asahilina.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 04:55:01PM +0900, Asahi Lina wrote:
> This module is intended to contain functions related to kernel
> timekeeping and time.
> 
> Initially, this implements an abstraction for a time Instant (analogous
> to the Rust std::time::Instant) that represents an opaque instant in
> time. Unlike the std Instant, this is a generic type that is bound to a
> specific clock source, so that only Instants from the same clock source
> can be subtracted/compared.
> 
> Then we implement the relevant clocks available to the kernel:
> KernelTime (CLOCK_MONOTONIC), BootTime (CLOCK_BOOTTIME),
> RealTime (CLOCK_REALTIME), and TaiTime.
> 
> Co-developed-by: Heghedus Razvan <heghedus.razvan@protonmail.com>
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> ---
> 
> Based on the feedback to v1, now we have proper type checking for kernel
> time. I decided to implement marker traits for monotonic vs. wallclock
> time sources, since it's useful to be able to safely implement different
> semantics conditional on that, but that left me with a name conflict of
> the Monotonic trait with the CLOCK_MONOTONIC / "default ktime" clock
> source. I ended up calling it KernelTime since it's the most fundamental
> kernel timesource, but suggestions welcome!
> 
> Heghedus: I think I need a signoff on this since this is based on the
> playground demo you wrote in the feedback to v1. Can you provide that? I
> can fold it into v3 (if there is one, otherwise Miguel can probably just
> add it when he applies it). Thanks!
> ---
>  rust/bindings/bindings_helper.h |   2 +
>  rust/helpers.c                  |  16 +++++
>  rust/kernel/lib.rs              |   1 +
>  rust/kernel/time.rs             | 150 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 169 insertions(+)
> 
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index 3e601ce2548d..eddfdf887364 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -8,9 +8,11 @@
>  
>  #include <linux/errname.h>
>  #include <linux/slab.h>
> +#include <linux/ktime.h>
>  #include <linux/refcount.h>
>  #include <linux/wait.h>
>  #include <linux/sched.h>
> +#include <linux/timekeeping.h>
>  
>  /* `bindgen` gets confused at certain things. */
>  const gfp_t BINDINGS_GFP_KERNEL = GFP_KERNEL;
> diff --git a/rust/helpers.c b/rust/helpers.c
> index bb594da56137..eff092302e23 100644
> --- a/rust/helpers.c
> +++ b/rust/helpers.c
> @@ -26,6 +26,7 @@
>  #include <linux/mutex.h>
>  #include <linux/spinlock.h>
>  #include <linux/sched/signal.h>
> +#include <linux/timekeeping.h>
>  #include <linux/wait.h>
>  
>  __noreturn void rust_helper_BUG(void)
> @@ -135,6 +136,21 @@ void rust_helper_put_task_struct(struct task_struct *t)
>  }
>  EXPORT_SYMBOL_GPL(rust_helper_put_task_struct);
>  
> +ktime_t rust_helper_ktime_get_real(void) {
> +	return ktime_get_real();
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_ktime_get_real);
> +
> +ktime_t rust_helper_ktime_get_boottime(void) {
> +	return ktime_get_boottime();
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_ktime_get_boottime);
> +
> +ktime_t rust_helper_ktime_get_clocktai(void) {
> +	return ktime_get_clocktai();
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_ktime_get_clocktai);
> +
>  /*
>   * We use `bindgen`'s `--size_t-is-usize` option to bind the C `size_t` type
>   * as the Rust `usize` type, so we can use it in contexts where Rust
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 85b261209977..52c91484c5d8 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -42,6 +42,7 @@
>  pub mod str;
>  pub mod sync;
>  pub mod task;
> +pub mod time;
>  pub mod types;
>  
>  #[doc(hidden)]
> diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
> new file mode 100644
> index 000000000000..f3bfeed20145
> --- /dev/null
> +++ b/rust/kernel/time.rs
> @@ -0,0 +1,150 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Timekeeping functions.
> +//!
> +//! C header: [`include/linux/ktime.h`](../../../../include/linux/ktime.h)
> +//! C header: [`include/linux/timekeeping.h`](../../../../include/linux/timekeeping.h)
> +
> +use crate::{bindings, pr_err};
> +use core::marker::PhantomData;
> +use core::time::Duration;
> +
> +/// Represents a clock, that is, a unique time source.
> +pub trait Clock: Sized {}
> +
> +/// A time source that can be queried for the current time.
> +pub trait Now: Clock {

Is there a `Clock` that we cannot get the current time? ;-)

> +    /// Returns the current time for this clock.
> +    fn now() -> Instant<Self>;
> +}
> +
> +/// Marker trait for clock sources that are guaranteed to be monotonic.
> +pub trait Monotonic {}
> +
> +/// Marker trait for clock sources that represent a calendar (wall clock)
> +/// relative to the UNIX epoch.
> +pub trait WallTime {}
> +
> +/// An instant in time associated with a given clock source.
> +#[derive(Debug)]
> +pub struct Instant<T: Clock> {
> +    nanoseconds: i64,
> +    _type: PhantomData<T>,
> +}
> +
> +impl<T: Clock> Clone for Instant<T> {
> +    fn clone(&self) -> Self {
> +        *self
> +    }
> +}
> +
> +impl<T: Clock> Copy for Instant<T> {}
> +
> +impl<T: Clock> Instant<T> {
> +    fn new(nanoseconds: i64) -> Self {
> +        Instant {
> +            nanoseconds,
> +            _type: PhantomData,
> +        }
> +    }
> +
> +    /// Returns the time elapsed since an earlier Instant<t>, or
> +    /// None if the argument is a later Instant.
> +    pub fn since(&self, earlier: Instant<T>) -> Option<Duration> {
> +        if earlier.nanoseconds > self.nanoseconds {
> +            None
> +        } else {
> +            // Casting to u64 and subtracting is guaranteed to give the right
> +            // result for all inputs, as long as the condition we checked above
> +            // holds.
> +            Some(Duration::from_nanos(
> +                self.nanoseconds as u64 - earlier.nanoseconds as u64,
> +            ))
> +        }
> +    }
> +}
> +
> +impl<T: Clock + Now + Monotonic> Instant<T> {
> +    /// Returns the time elapsed since this Instant<T>.
> +    ///
> +    /// This is guaranteed to return a positive result, since
> +    /// it is only implemented for monotonic clocks.
> +    pub fn elapsed(&self) -> Duration {
> +        T::now().since(*self).unwrap_or_else(|| {
> +            pr_err!(
> +                "Monotonic clock {} went backwards!",
> +                core::any::type_name::<T>()
> +            );
> +            Duration::ZERO
> +        })
> +    }
> +}
> +
> +/// Contains the various clock source types available to the kernel.
> +pub mod clock {
> +    use super::*;
> +
> +    /// A clock representing the default kernel time source.
> +    ///
> +    /// This is `CLOCK_MONOTONIC` (though it is not the only
> +    /// monotonic clock) and also the default clock used by
> +    /// `ktime_get()` in the C API.
> +    ///
> +    /// This is like `BootTime`, but does not include time
> +    /// spent sleeping.
> +

Could you add one example for each `*Time` type? Not only they can show
people how to use the API, but also we can use them to generate unit
tests:

	https://lore.kernel.org/rust-for-linux/20230614180837.630180-1-ojeda@kernel.orge 

If you want to test your examples, you can either apply that patchset or
use the rust-dev branch:

	https://github.com/Rust-for-Linux/linux.git rust-dev

I use the following command to run tests:

	./tools/testing/kunit/kunit.py run --make_options LLVM=1 --arch x86_64 --kconfig_add CONFIG_RUST=y

Thanks!

Regards,
Boqun

> +    pub struct KernelTime;
> +
> +    impl Clock for KernelTime {}
> +    impl Monotonic for KernelTime {}
> +    impl Now for KernelTime {
> +        fn now() -> Instant<Self> {
> +            Instant::<Self>::new(unsafe { bindings::ktime_get() })
> +        }
> +    }
> +
> +    /// A clock representing the time elapsed since boot.
> +    ///
> +    /// This is `CLOCK_MONOTONIC` (though it is not the only
> +    /// monotonic clock) and also the default clock used by
> +    /// `ktime_get()` in the C API.
> +    ///
> +    /// This is like `KernelTime`, but does include time
> +    /// spent sleeping.
> +    pub struct BootTime;
> +
> +    impl Clock for BootTime {}
> +    impl Monotonic for BootTime {}
> +    impl Now for BootTime {
> +        fn now() -> Instant<Self> {
> +            Instant::<Self>::new(unsafe { bindings::ktime_get_boottime() })
> +        }
> +    }
> +
> +    /// A clock representing TAI time.
> +    ///
> +    /// This clock is not monotonic and can be changed from userspace.
> +    /// However, it is not affected by leap seconds.
> +    pub struct TaiTime;
> +
> +    impl Clock for TaiTime {}
> +    impl WallTime for TaiTime {}
> +    impl Now for TaiTime {
> +        fn now() -> Instant<Self> {
> +            Instant::<Self>::new(unsafe { bindings::ktime_get_clocktai() })
> +        }
> +    }
> +
> +    /// A clock representing wall clock time.
> +    ///
> +    /// This clock is not monotonic and can be changed from userspace.
> +    pub struct RealTime;
> +
> +    impl Clock for RealTime {}
> +    impl WallTime for RealTime {}
> +    impl Now for RealTime {
> +        fn now() -> Instant<Self> {
> +            Instant::<Self>::new(unsafe { bindings::ktime_get_real() })
> +        }
> +    }
> +}
> 
> ---
> base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
> change-id: 20230714-rust-time-10dd9ed25333
> 
> Thank you,
> ~~ Lina
> 
