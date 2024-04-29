Return-Path: <linux-kernel+bounces-162279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C46578B5905
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76CBC28BBC8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C491C15D;
	Mon, 29 Apr 2024 12:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jR/6sySW"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E2410971
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 12:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714394983; cv=none; b=LBwZGHKL6+r/2Fbzq+dc/CQzulYqrDEHmhhHBl2yOtqI5/4b0B7+tepG9Sb5tR/BvMUB7A/g+d4qVQRGT0xOr0PPYvVI6UwfAbzPQJwDGIZZP78vd0/YEPSAxWBNu3gB1v0FmB1T67Vdd5amu1fHWxeIcb4k1BlmTumsTY3g0oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714394983; c=relaxed/simple;
	bh=foekwiK2irNO7kjblTK/aCRUob5Xq6wSPTpCLmoxwSg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B0flCt/EdKrIyw3EHram+MF7nJyR55m5AbVD3sfm0J3y/CqUcu87iqImhsJSjf4npR2hSUvetLah3cPp+0wBe82ExnZPWKFwzpgQfjgymyO6H7kRt3veBwIsvReq4LAz9nP91pdpjkonHU3VaCGhsFadcBd5EvEPkCIzjOuciWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jR/6sySW; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de59e612376so6443721276.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 05:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714394981; x=1714999781; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aO9R726kvlIe8U+i/RDdx0Xm5PqDkC0qKYa9+xGjJy0=;
        b=jR/6sySWT44/TsnBqJv+NfQ/A/XLp5P+rBKW3LFaZxps5WjY4ijQkyoSTF9uJ9XB+6
         K1QlC7KBWEId2FQZ66AGmuzkkihxIF1ETJPRTlO9/Hbk5SJm2b2f/tY2Tbl2wHUKlDVh
         z5oYoPPnkjz1wfyL6A2CWVCifn4f/d3RrzrORL+1obvYYU3qtTDzEnMysEOvtd1+P6mP
         s0ux8P15oElwbyddw8fOjvo4yGstzNC90OPrl+zEHpUkmx1YRKN6a6dAdn7VFlo/RxA2
         Yo5IsJKOb9DL0vnS/n4mlyX+LuQMOSamjZXFNYYj0csGPezwf4PuwRBs2SoYvb4FIU4s
         x4LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714394981; x=1714999781;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aO9R726kvlIe8U+i/RDdx0Xm5PqDkC0qKYa9+xGjJy0=;
        b=EeWsdMvpKugxLSzPCXz9sL6Qc4T15gv2uF0pPdqNKnKOU+esJ8x5+dzBZ8UTnUbdZX
         tcMlvRbQaZymK1kIbNNb2a+tqGd5lG2ml+r+6uqV9a8FEkNUhvxAjWfqONakHddUSWNm
         w1VmXTusk8sGbKjWZ0B1OkLU1zrq9LKyoI572G5nGDAAHAmxiBDb7mR7lXlUln4pOm2v
         0lh6vEsYtH2o5GKIQOvmr8uKTcMZ6Hs9BeMEUwv8mnMJMAcjODZKgmidlK4CBS+NCBUZ
         tpstip5SQNlvr5mJD9Exmsj72P5dMpstNk6j5WqE6Z9nyYDYFBwBB5m7RKIHvJhZ9AIT
         SUqw==
X-Forwarded-Encrypted: i=1; AJvYcCWY1w98QrAwsJ+OYYsUVGaws9MIwwiANzCI3u7ekHiwp10hlt+k6nIzglKKkgeW9bTyaS1fFKSSc1HXgMiNg7tgVhjxsyHCsaadGpFw
X-Gm-Message-State: AOJu0YzZRII3RucR3R1OaWROvbnfKDq6MdnWUMQZqgSfi8J8aq7noaCJ
	zrnj6yvT2yjv8PNwMS8JKN7ydxS736AnAhAvBRnTX51pKJt4LM9uACETQ/g7L3YYRBSkvzo0Pmg
	BEsWv5nXux9RlqQ==
X-Google-Smtp-Source: AGHT+IFzqYH58rGsw9DqivNI5mk+kReDB7fsYikuQg4Nm52f6W/qdIORJP8kMFLe8/UE0Y8SR+4oP5EzkmvrR7A=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:1006:b0:dcd:3a37:65 with SMTP
 id w6-20020a056902100600b00dcd3a370065mr1046073ybt.7.1714394980921; Mon, 29
 Apr 2024 05:49:40 -0700 (PDT)
Date: Mon, 29 Apr 2024 12:49:37 +0000
In-Reply-To: <20240425094634.262674-1-nmi@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240425094634.262674-1-nmi@metaspace.dk>
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
Message-ID: <20240429124937.414056-1-aliceryhl@google.com>
Subject: [PATCH] rust: hrtimer: introduce hrtimer support
From: Alice Ryhl <aliceryhl@google.com>
To: nmi@metaspace.dk
Cc: a.hindborg@samsung.com, alex.gaynor@gmail.com, aliceryhl@google.com, 
	anna-maria@linutronix.de, benno.lossin@proton.me, bjorn3_gh@protonmail.com, 
	boqun.feng@gmail.com, frederic@kernel.org, gary@garyguo.net, 
	linux-kernel@vger.kernel.org, ojeda@kernel.org, 
	rust-for-linux@vger.kernel.org, tglx@linutronix.de, wedsonaf@gmail.com
Content-Type: text/plain; charset="utf-8"

Andreas Hindborg <nmi@metaspace.dk> writes:
> From: Andreas Hindborg <a.hindborg@samsung.com>
> 
> This patch adds support for intrusive use of the hrtimer system. For now, only
> one timer can be embedded in a Rust struct.
> 
> The hrtimer Rust API is based on the intrusive style pattern introduced by the
> Rust workqueue API.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>

This patch is very similar to the workqueue I implemented. It seems like
we have the following correspondence between them:

* Your HasTimer is my HasWork.
* Your RawTimerCallback is my WorkItemPointer.
* Your TimerCallback is my WorkItem.
* Your RawTimer is my RawWorkItem. (but the match isn't great here)

I think it would make sense to have the names be more consistent. I
propose renaming RawTimerCallback to TimerCallbackPointer.

Or we can name them TimerEntry and RawTimerEntry?


I also note that the method on your RawTimer trait seems to be the
public API of how you're supposed to schedule a timer, whereas the
workqueue RawWorkItem only provides a raw low-level method, and instead
has the "public API" be a function on the Workqueue struct.

I'm not such a big fan of having the primary method everying is supposed
to use be a method on a trait whose name starts with "Raw". It's worth
considering whether it makes more sense to have a free-standing function
called `schedule_timer` and have that be how you're supposed to schedule
timers, instead of the RawTimer trait.

> +#[pinned_drop]
> +impl<T> PinnedDrop for Timer<T> {
> +    fn drop(self: Pin<&mut Self>) {
> +        // SAFETY: By struct invariant `self.timer` was initialized by
> +        // `hrtimer_init` so by C API contract it is safe to call
> +        // `hrtimer_cancel`.
> +        unsafe {
> +            bindings::hrtimer_cancel(self.timer.get());
> +        }
> +    }
> +}

Assuming that this is mirroring the workqueue, then this is not
necessary. The timer owns a refcount to the element, so the destructor
cannot run while the timer is scheduled.

Also, as a generaly note, putting semicolons outside of unsafe blocks
formats better.

> +/// Implemented by pointer types that can be the target of a C timer callback.
> +pub trait RawTimerCallback: RawTimer {
> +    /// Callback to be called from C.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Only to be called by C code in `hrtimer`subsystem.
> +    unsafe extern "C" fn run(ptr: *mut bindings::hrtimer) -> bindings::hrtimer_restart;
> +}

Safety comment is missing a space.

> +/// Implemented by pointers to structs that can the target of a timer callback
> +pub trait TimerCallback {
> +    /// Type of `this` argument for `run()`.
> +    type Receiver: RawTimerCallback;
> +
> +    /// Called by the timer logic when the timer fires
> +    fn run(this: Self::Receiver);
> +}

The documentation says that this is implemented by pointers to structs,
but that is not the case.

> +impl<T> RawTimer for Arc<T>
> +where
> +    T: Send + Sync,
> +    T: HasTimer<T>,
> +{
> +    fn schedule(self, expires: u64) {
> +        let self_ptr = Arc::into_raw(self);
> +
> +        // SAFETY: `self_ptr` is a valid pointer to a `T`
> +        let timer_ptr = unsafe { T::raw_get_timer(self_ptr) };
> +
> +        // `Timer` is `repr(transparent)`
> +        let c_timer_ptr = timer_ptr.cast::<bindings::hrtimer>();

I would add an `raw_get` method to `Timer` instead of this cast,
analogous to `Work::raw_get`.

> +        // Schedule the timer - if it is already scheduled it is removed and
> +        // inserted
> +
> +        // SAFETY: c_timer_ptr points to a valid hrtimer instance that was
> +        // initialized by `hrtimer_init`
> +        unsafe {
> +            bindings::hrtimer_start_range_ns(
> +                c_timer_ptr.cast_mut(),
> +                expires as i64,
> +                0,
> +                bindings::hrtimer_mode_HRTIMER_MODE_REL,
> +            );
> +        }
> +    }
> +}

Alice

