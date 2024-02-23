Return-Path: <linux-kernel+bounces-80999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 026FF866ED3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A096C283D56
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2364020B38;
	Mon, 26 Feb 2024 09:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="ks0FbFhi"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438A418AF8
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 09:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708938168; cv=none; b=TLcWT6nGkmzrMXTJXY3OEC18mRQy1sbG00tYdsZ1QTMNNAdfDd1P9drZXXozNILian8SdGckZtQWdBbI/31WEkrDtIFyvIsVg1X/hibKQOITW8Jf9GKNTXV2JsqDOp8QqQ4ej+oYL22yVJ+O1zYephkoNi6u8ndY9dxuvMHBocY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708938168; c=relaxed/simple;
	bh=XbXVfHeOwDhV+PDLw6Hx0gES/Ce6Uc4JONajMf23QXo=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=FDgTCXD4LcFht9+NPKWW53z5Gc3MNY8kcaK4xMyDwHOn6QFNvA/d/R+40/VeImWO1QC3rM+FfiV+UQo1xvtm6a0dzJT9EObn6OZZ8i7gG23/7XUbwH45jQFRTFTDdiVNQHu1+pqI/B1m4f2Rx2urp/VygpsXlvhHPAnamjB2j1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=ks0FbFhi; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a3e891b5e4eso314138766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 01:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1708938163; x=1709542963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DXJKtDALC3AllytrckFvRAF/ZRCMob4eWSKm4Ha7cls=;
        b=ks0FbFhiJIhNZP+mFC4+YnxvuB1LLZ5tmUnlPi2j6nJGNwYBfwgbP+JRA33kMINLYn
         0OXEkPIEv6k19TVZbhMKxTq9ng5lCX9CD8mjDkEWykdPMwxi/X5yTLeGzR6/dRpFhCHs
         GFD8+9q2uBb4f2nK9HtWajwonLfY6kwDhvJCeIpkmC0yDdD4gDFj3MfOtvZdy+FAl5Cc
         s315j8pSdXCbfxLKWJCrgXjNL+DNsHsk3dTaYyO+NtKO/RIsfW56iOg6YgSYJNetjaGc
         x7FuwQZPIjsz2FCPL/q+V2lp56sFOLUJdhYNtp3NRPtX23C5DB7KCkTmGRwUIwgZt6G7
         bbyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708938163; x=1709542963;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DXJKtDALC3AllytrckFvRAF/ZRCMob4eWSKm4Ha7cls=;
        b=cvGVk1v8CRlw+UEN1g8kJIcxVB/VrP8mvpLIMwanGaWOjvVzI6laltMVtJWuAx5/c0
         BO1/HtDVfgTZktMvmh9D27FATgIcTRW0cVIKjRA5kcsIY2ywnqQlOFq8kEYt4V6j5WdD
         kiNudxB83wD/3nKnK3s1TF7u14F6WXkRGnanYj2sLFy+WzDx5S1i5202H+bOpU9ZKnHq
         zanDUk1pjinp7OZNlqs+rn2ICLpsEwmHFB7aV7ljnMgo3GcCJQSZNrt16OF7SDZ3I6+i
         m5c+0AiC5eNZnUBAbBQznlq62KdRRcGnORPT4VnHb1/BaPqY4163jEuaQgfYpTdRQ/wE
         NxQQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2GIiMSKoJFQFvV9teX7gFcc+8BKToj+U6RYiJuoUmuiIoobZ7i/KbVhiEjdXNCxh9TlFusYs1ehr1RGT4pY3dThYzvti4TMi2EvWL
X-Gm-Message-State: AOJu0Yxqsz2K9qZrMtweGX5+pPFrhEnrUcxxywAJ6bEGKy2cGn3gDFO1
	ugGbkPCdJq5ERuqfMhqCSxv5IF3o5KzVtZrweclxOUKoW3PupSblGOcMJJpnAIY=
X-Google-Smtp-Source: AGHT+IEABUyZM4Qr+FrrCNgluJIL+UvNGxn0b+EdUy4hbr938x99f18HccbJrZ69FJrZcZZVDCIEmg==
X-Received: by 2002:a17:906:b7ca:b0:a3e:6038:42b8 with SMTP id fy10-20020a170906b7ca00b00a3e603842b8mr3801391ejb.39.1708938163246;
        Mon, 26 Feb 2024 01:02:43 -0800 (PST)
Received: from localhost ([194.62.217.1])
        by smtp.gmail.com with ESMTPSA id un6-20020a170907cb8600b00a4386852da5sm1198ejc.83.2024.02.26.01.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 01:02:42 -0800 (PST)
References: <20230503090708.2524310-7-nmi@metaspace.dk>
 <20230503120354.534136-1-aliceryhl@google.com>
User-agent: mu4e 1.10.8; emacs 29.2
From: "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Damien.LeMoal@wdc.com, alex.gaynor@gmail.com, axboe@kernel.dk,
 benno.lossin@proton.me, bjorn3_gh@protonmail.com, boqun.feng@gmail.com,
 gary@garyguo.net, gost.dev@samsung.com, hare@suse.de, hch@lst.de,
 kbusch@kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, lsf-pc@lists.linux-foundation.org,
 ojeda@kernel.org, rust-for-linux@vger.kernel.org, wedsonaf@gmail.com,
 willy@infradead.org
Subject: Re: [RFC PATCH 06/11] rust: apply cache line padding for `SpinLock`
Date: Fri, 23 Feb 2024 12:29:40 +0100
In-reply-to: <20230503120354.534136-1-aliceryhl@google.com>
Message-ID: <87y1b7a994.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Hi Alice,

Alice Ryhl <aliceryhl@google.com> writes:

> On Wed, 3 May 2023 11:07:03 +0200, Andreas Hindborg <a.hindborg@samsung.c=
om> wrote:
>> The kernel `struct spinlock` is 4 bytes on x86 when lockdep is not enabl=
ed. The
>> structure is not padded to fit a cache line. The effect of this for `Spi=
nLock`
>> is that the lock variable and the value protected by the lock will share=
 a cache
>> line, depending on the alignment requirements of the protected value. Al=
igning
>> the lock variable and the protected value to a cache line yields a 20%
>> performance increase for the Rust null block driver for sequential reads=
 to
>> memory backed devices at 6 concurrent readers.
>>=20
>> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
>
> This applies the cacheline padding to all spinlocks unconditionally.
> It's not clear to me that we want to do that. Instead, I suggest using
> `SpinLock<CachePadded<T>>` in the null block driver to opt-in to the
> cache padding there, and let other drivers choose whether or not they
> want to cache pad their locks.

I was going to write that this is not going to work because the compiler
is going to reorder the fields of `Lock` and put the `data` field first,
followed by the `state` field. But I checked the layout, and it seems
that I actually get the `state` field first (with an alignment of 4), 60
bytes of padding, and then the `data` field (with alignment 64).

I am wondering why the compiler is not reordering these fields? Am I
guaranteed that the fields will not be reordered? Looking at the
definition of `Lock` there does not seem to be anything that prevents
rustc from swapping `state` and `data`.

>
> On Wed, 3 May 2023 11:07:03 +0200, Andreas Hindborg <a.hindborg@samsung.c=
om> wrote:
>> diff --git a/rust/kernel/cache_padded.rs b/rust/kernel/cache_padded.rs
>> new file mode 100644
>> index 000000000000..758678e71f50
>> --- /dev/null
>> +++ b/rust/kernel/cache_padded.rs
>>=20
>> +impl<T> CachePadded<T> {
>> +    /// Pads and aligns a value to 64 bytes.
>> +    #[inline(always)]
>> +    pub(crate) const fn new(t: T) -> CachePadded<T> {
>> +        CachePadded::<T> { value: t }
>> +    }
>> +}
>
> Please make this `pub` instead of just `pub(crate)`. Other drivers might
> want to use this directly.

Alright.

>
> On Wed, 3 May 2023 11:07:03 +0200, Andreas Hindborg <a.hindborg@samsung.c=
om> wrote:
>> diff --git a/rust/kernel/sync/lock/spinlock.rs b/rust/kernel/sync/lock/s=
pinlock.rs
>> index 979b56464a4e..e39142a8148c 100644
>> --- a/rust/kernel/sync/lock/spinlock.rs
>> +++ b/rust/kernel/sync/lock/spinlock.rs
>> @@ -100,18 +103,20 @@ unsafe impl super::Backend for SpinLockBackend {
>>      ) {
>>          // SAFETY: The safety requirements ensure that `ptr` is valid f=
or writes, and `name` and
>>          // `key` are valid for read indefinitely.
>> -        unsafe { bindings::__spin_lock_init(ptr, name, key) }
>> +        unsafe { bindings::__spin_lock_init((&mut *ptr).deref_mut(), na=
me, key) }
>>      }
>>=20=20
>> +    #[inline(always)]
>>      unsafe fn lock(ptr: *mut Self::State) -> Self::GuardState {
>>          // SAFETY: The safety requirements of this function ensure that=
 `ptr` points to valid
>>          // memory, and that it has been initialised before.
>> -        unsafe { bindings::spin_lock(ptr) }
>> +        unsafe { bindings::spin_lock((&mut *ptr).deref_mut()) }
>>      }
>>=20=20
>> +    #[inline(always)]
>>      unsafe fn unlock(ptr: *mut Self::State, _guard_state: &Self::GuardS=
tate) {
>>          // SAFETY: The safety requirements of this function ensure that=
 `ptr` is valid and that the
>>          // caller is the owner of the mutex.
>> -        unsafe { bindings::spin_unlock(ptr) }
>> +        unsafe { bindings::spin_unlock((&mut *ptr).deref_mut()) }
>>      }
>>  }
>
> I would prefer to remain in pointer-land for the above operations. I
> think that this leads to core that is more obviously correct.
>
> For example:
>
> ```
> impl<T> CachePadded<T> {
>     pub const fn raw_get(ptr: *mut Self) -> *mut T {
>         core::ptr::addr_of_mut!((*ptr).value)
>     }
> }
>
> #[inline(always)]
> unsafe fn unlock(ptr: *mut Self::State, _guard_state: &Self::GuardState) {
>     unsafe { bindings::spin_unlock(CachePadded::raw_get(ptr)) }
> }
> ```

Got it =F0=9F=91=8D


BR Andreas

