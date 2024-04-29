Return-Path: <linux-kernel+bounces-162389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D48B98B5A74
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0487E1C2145C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CE6745C0;
	Mon, 29 Apr 2024 13:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="M/akvdJ0"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2732745C3
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 13:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714398477; cv=none; b=HI+YKKKqDMgKg8EaOLkLyFm3YRj0kkQwzengSgSHJsyPNnb5vuKaDymjPnsjuC4VZSdrD4BspgXG+ERl9vUbGY+ASDVCDMGt/fRH5qZdWBbkE9TIP9Z7jCN+2JrSAXEN9VRCz1CwvgfPMCgJAYMvdjWZ+IsO5X7406TEzoDSpvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714398477; c=relaxed/simple;
	bh=ARPhoW58t0JAb+XhD4We4yq8qzr4Xlj7h6uPLXBL7yc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=toyhi6XGmcQPfeNDDF4pX2H1pt98Le7nHK8wv0E0mcWrhzZU/wp1Y5yXmmh8zQz8S8tsbERVa3whXEee67RoI0qRFvBMHE9IXjBa6R+u0hv5RfGu0wuxGw0tQkJla65ht3Ns0+jQPex9tucMA//q44ArzojuLdT/wNSqvBYuX3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=M/akvdJ0; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5196fe87775so4918041e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 06:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1714398473; x=1715003273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fTbaPy+dJ2EwkSJYrQFFWcOz4izqUvcjbKkMYVCjdhM=;
        b=M/akvdJ0tkfCpEjx2+tpWHbfuTw8nzp9xoOuDYZ5fd8D+Pwmg1w4AQ00TSJR1+xmwA
         tj10fZGgjdRyuAAIGqQIDYqO+wIZ2IY/yocUQEfJMFQ8QsD/+CzeoB3m6M8yyhbsm3y1
         TgzxmjpZCs1jbDMCs+jt29X4Jebixjswx1W+RHdBCaEOgTasx+Wu5TsDD0j3lFGBuAVO
         /MQaT901Qsu3fL3sg6okdUH/0ByAh34niRLIg4tTCOJbogPYYKWJdB1SdKjY+s65xff3
         hRcU0rurZS5GGMm1UqAYh1gAAmXhBFACSYum39X4zpl156hFCDL4zQDNoWYKel/hWWkQ
         g8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714398473; x=1715003273;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fTbaPy+dJ2EwkSJYrQFFWcOz4izqUvcjbKkMYVCjdhM=;
        b=bpws03yoLgpFxRzwxabXBd/ZBI/My5d59gJlpNknckaToXR028duTaTrsYmkqMciHM
         j1/Sukhg3hIOBT8LovymYi5dJtsZJjgCfvhAm7q2xG0L1MPwpJPEOV8TZazauOE8hR/Y
         Dm5VFbbIDzcXGaUJRseoKzvAuTvJM/foIJy1rsgbKVTIPwQNwoxKig7L3htRllXkVYbe
         rSVyJvLMO1PNi69zr3T8RLlbPNUK0lK0kKuqOQxRfyYQOaZyCPc5ZKutysLYgVDvrRqP
         JDs0Wcyx/aEUc5BRSRT9Cmrete9dzHh2cILShocUKhwDDaWS+UyXdB8RnhYcH76QUy8p
         q7ww==
X-Forwarded-Encrypted: i=1; AJvYcCX2U8Nw3zFvcrg73iuj/L2h5D9ohgWXz+OZxuQRDnQeXtpWTBPwUyVOtpzDmMsi8Yeyf/betO8pUQl9dBNFyOpwJK2b9d7oqRX1yDiO
X-Gm-Message-State: AOJu0Yx5yhp898xxH2rgqFj4DHX9aVtluJwDVOxyVDwbnMhlBOq3LBsT
	SSO93rc2KCdzeaRjfqBCZpTkzjgLJ5GWec9ZIkHnRsWiI/pd3AOEbJkdsYtl9c4=
X-Google-Smtp-Source: AGHT+IHvCP7iybwfg9JD3qH/GlFZDWAIgSbPT+EdmIP24wggfU7b0RC4JDQlZm6tM0m9ZlDxV2Mw5Q==
X-Received: by 2002:a05:6512:1156:b0:51b:ebe0:a91a with SMTP id m22-20020a056512115600b0051bebe0a91amr5496821lfg.36.1714398473401;
        Mon, 29 Apr 2024 06:47:53 -0700 (PDT)
Received: from localhost ([194.62.217.2])
        by smtp.gmail.com with ESMTPSA id a4-20020a170906368400b00a4e48e52ecbsm13834825ejc.198.2024.04.29.06.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 06:47:52 -0700 (PDT)
From: Andreas Hindborg <nmi@metaspace.dk>
To: Alice Ryhl <aliceryhl@google.com>
Cc: a.hindborg@samsung.com,  alex.gaynor@gmail.com,
  anna-maria@linutronix.de,  benno.lossin@proton.me,
  bjorn3_gh@protonmail.com,  boqun.feng@gmail.com,  frederic@kernel.org,
  gary@garyguo.net,  linux-kernel@vger.kernel.org,  ojeda@kernel.org,
  rust-for-linux@vger.kernel.org,  tglx@linutronix.de,  wedsonaf@gmail.com
Subject: Re: [PATCH] rust: hrtimer: introduce hrtimer support
In-Reply-To: <20240429124937.414056-1-aliceryhl@google.com> (Alice Ryhl's
	message of "Mon, 29 Apr 2024 12:49:37 +0000")
References: <20240425094634.262674-1-nmi@metaspace.dk>
	<20240429124937.414056-1-aliceryhl@google.com>
User-Agent: mu4e 1.12.4; emacs 29.3
Date: Mon, 29 Apr 2024 15:47:47 +0200
Message-ID: <87ttjkjn5o.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alice Ryhl <aliceryhl@google.com> writes:

> Andreas Hindborg <nmi@metaspace.dk> writes:
>> From: Andreas Hindborg <a.hindborg@samsung.com>
>>=20
>> This patch adds support for intrusive use of the hrtimer system. For now=
, only
>> one timer can be embedded in a Rust struct.
>>=20
>> The hrtimer Rust API is based on the intrusive style pattern introduced =
by the
>> Rust workqueue API.
>>=20
>> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
>
> This patch is very similar to the workqueue I implemented. It seems like
> we have the following correspondence between them:
>
> * Your HasTimer is my HasWork.
> * Your RawTimerCallback is my WorkItemPointer.
> * Your TimerCallback is my WorkItem.
> * Your RawTimer is my RawWorkItem. (but the match isn't great here)
>
> I think it would make sense to have the names be more consistent. I
> propose renaming RawTimerCallback to TimerCallbackPointer.
>
> Or we can name them TimerEntry and RawTimerEntry?

I took some advice from Benno and merged `RawTimerCallback` with
`RawTimer` and renamed the resulting trait `TimerPointer`. There is not
really any reason they should be split for the `hrtimer` as far as I can
tell.

> I also note that the method on your RawTimer trait seems to be the
> public API of how you're supposed to schedule a timer, whereas the
> workqueue RawWorkItem only provides a raw low-level method, and instead
> has the "public API" be a function on the Workqueue struct.
>
> I'm not such a big fan of having the primary method everying is supposed
> to use be a method on a trait whose name starts with "Raw".

I would remove the `Raw`.

> It's worth
> considering whether it makes more sense to have a free-standing function
> called `schedule_timer` and have that be how you're supposed to schedule
> timers, instead of the RawTimer trait.

I think being able to call `my_timer_containing_struct.schedule()` is
nice.

>
>> +#[pinned_drop]
>> +impl<T> PinnedDrop for Timer<T> {
>> +    fn drop(self: Pin<&mut Self>) {
>> +        // SAFETY: By struct invariant `self.timer` was initialized by
>> +        // `hrtimer_init` so by C API contract it is safe to call
>> +        // `hrtimer_cancel`.
>> +        unsafe {
>> +            bindings::hrtimer_cancel(self.timer.get());
>> +        }
>> +    }
>> +}
>
> Assuming that this is mirroring the workqueue, then this is not
> necessary. The timer owns a refcount to the element, so the destructor
> cannot run while the timer is scheduled.

Yes, it is very much a mirror. Yes, it is a leftover from trying to
support stack allocated timers. I will remove it.


> Also, as a generaly note, putting semicolons outside of unsafe blocks
> formats better.

=F0=9F=91=8D

>
>> +/// Implemented by pointer types that can be the target of a C timer ca=
llback.
>> +pub trait RawTimerCallback: RawTimer {
>> +    /// Callback to be called from C.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// Only to be called by C code in `hrtimer`subsystem.
>> +    unsafe extern "C" fn run(ptr: *mut bindings::hrtimer) -> bindings::=
hrtimer_restart;
>> +}
>
> Safety comment is missing a space.

Thanks.

>
>> +/// Implemented by pointers to structs that can the target of a timer c=
allback
>> +pub trait TimerCallback {
>> +    /// Type of `this` argument for `run()`.
>> +    type Receiver: RawTimerCallback;
>> +
>> +    /// Called by the timer logic when the timer fires
>> +    fn run(this: Self::Receiver);
>> +}
>
> The documentation says that this is implemented by pointers to structs,
> but that is not the case.

I will update the doc comment, it should say "implemented by structs that
can be the target...". Thanks.

>
>> +impl<T> RawTimer for Arc<T>
>> +where
>> +    T: Send + Sync,
>> +    T: HasTimer<T>,
>> +{
>> +    fn schedule(self, expires: u64) {
>> +        let self_ptr =3D Arc::into_raw(self);
>> +
>> +        // SAFETY: `self_ptr` is a valid pointer to a `T`
>> +        let timer_ptr =3D unsafe { T::raw_get_timer(self_ptr) };
>> +
>> +        // `Timer` is `repr(transparent)`
>> +        let c_timer_ptr =3D timer_ptr.cast::<bindings::hrtimer>();
>
> I would add an `raw_get` method to `Timer` instead of this cast,
> analogous to `Work::raw_get`.
>

Why is that? It is a lot of extra code, extra safety comments, etc.

In any case, would you prefer to implement said method with a cast
(which we can because `Timer` is transparent), or by `Opaque::raw_get`:

`Opaque::raw_get(core::ptr::addr_of!((*ptr).timer))`


Best regards,
Andreas

