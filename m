Return-Path: <linux-kernel+bounces-109098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34668881498
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 382361F236A8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E01B40BEB;
	Wed, 20 Mar 2024 15:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3uPKYt+"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2F24F1E5;
	Wed, 20 Mar 2024 15:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710948615; cv=none; b=f27uDgB8pGkcVr6oI5OYWko8ijNtGn60i2wpbH6DsOlot1Q5DOhdjN98pKnVZDSZ0LbrMEmfvbw1d2pjLOTyULwO1nJBcId4AY5FUO/810F8a1i1h7dU45cd/HtQQor6JYvctOMZFnGkQfyawYOxUGoeL8dY+xQCXUlTebkSnmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710948615; c=relaxed/simple;
	bh=S8w2ciKv2tyfJUiGdL4xUBgp55ZLFwMcjTMOQqpG+2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K5B+INi3sfOyZZL581kWDkugDMzjzRUVyfH41BhXclRTaWve6wyP/Ez+1SYBkqU3j1K1uh8rsIkEV+Eee/9TOPJaU6NPVSadIUfgfKktEtT7r84v7xFUifMNRar59rB6LJuDYePMBxu5WHyj5dZMJrWlAXsSsKQFkOGsdN+UfKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F3uPKYt+; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-78a01a3012aso237968185a.2;
        Wed, 20 Mar 2024 08:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710948613; x=1711553413; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eTmvbf0b85vrB0cN1hNx/mI9MKVYHRjR7FRM8zIFvHo=;
        b=F3uPKYt+HcdaVAVRI0qMrW+Htm9pR6kZ7Gos1wginME2y1wxVpgnFdq4L2XVOBri70
         PaDfjhzjEUZH4RquSiZD7B8DuuVr4iG7/avmyOtcLGX+je27h877IEXo5yTdN5omGhmL
         oU0WEG5VuVYVMXBYvqfd9PBV8zE11cUW5ipCvkiHt07n3TgKFuqEJalrUzXIF0pjazCp
         imU1/+/Fed8IkRP8V7LWFFDKtoWxWWogNdZD3huQtFrrdMNOuSKFh8YKew29oTy67H5q
         OAWfPkSEr39qiMQWv5UoSQjIhBFdOzhstbK4VbD/jMuha5+oQHOOg4uRWl89i6sXXAO1
         Frhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710948613; x=1711553413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eTmvbf0b85vrB0cN1hNx/mI9MKVYHRjR7FRM8zIFvHo=;
        b=WaG3ab6jurL33EkOywYFIVHkzCMd8mOORRlXHEU2L5s2l4Ny9o1GiugArzrmmj2pvf
         Ia5vYo8cCiGRgmDQdcdRG33yK7PwYUVE/1wmy8d38168fg8GIE8cCpPJOPFrL7jnpsfs
         ZnXTKDy5b5EXgtZmmDZ9eFM9tSECGv/G4e1xlUHb+FL9z8UL2A/HhBxkUa0ah8utQ5gA
         j0KewqiZo7orpppCSC8yWJ6W4NfRETmR4QX4m5NuPl9sgDKQnlhIzJLIJoMoBsdUcdPh
         LfFcRxPtkbV4exfu+u4W+LsRmjobv7xGqOGbRJmAiIp0jfVasMe8hHoSnKmm9z6Egb22
         VkUg==
X-Forwarded-Encrypted: i=1; AJvYcCVwJo+813bzPGqCTVqHZavFdtvH/XlCqh0Yko4ANbpn8OHS87KU44Gtb1p8ooLW0PSKTNhb0c+gbKDYny0C0aACrl7iDReLX+WyOhz6x83snoEtR7Cjbnm2lNKZ7yqrJ2IImMFYvEPGcX6Ahzg=
X-Gm-Message-State: AOJu0Yzr3i9gwPbjw4AnyfMQza/A9kgiaMYVzs+IpEAB8VxrMkBuCIwD
	SwYioVjCiNcHBsr1pTp4Eb+lfCs33E84UrIN7ZEKAsvmlKommdLk
X-Google-Smtp-Source: AGHT+IEpnJCa+7oK7DksHBoch/mrFyk6jpUP5iVx/LSjvSo8DwPPiOy0xni5gEp5mEgr6z+mDpnwRA==
X-Received: by 2002:a05:620a:a17:b0:788:7835:2512 with SMTP id i23-20020a05620a0a1700b0078878352512mr20530499qka.5.1710948613008;
        Wed, 20 Mar 2024 08:30:13 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id i7-20020a05620a144700b00789e49808ffsm5383666qkl.105.2024.03.20.08.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 08:30:11 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 416371200032;
	Wed, 20 Mar 2024 11:30:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 20 Mar 2024 11:30:11 -0400
X-ME-Sender: <xms:AgH7Zcq5lkId9ZWdYwzRDBK44BF3hgfb9rweVXPkrgRKs8tcEPbSiw>
    <xme:AgH7ZSqzRn-HHDC5Pwsbd1n6izPvhHhOXGFrFSZ4OzQXmQ0ucwvJ2Fe1ITYpa_1pi
    SW1r7qbvQo1cx0dOA>
X-ME-Received: <xmr:AgH7ZRNdKkRuH8z8kk4eAHjyGQKJC_8MATH7OrzM8qWnlmPaPBqk0bKUYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrleeggdejiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepjefhhfeuffeugeduteehtdfhgfduffffteeghfeiteeggeehvdehvddulefg
    jeefnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdprghnughrohhiugdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhn
    odhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejje
    ekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhn
    rghmvg
X-ME-Proxy: <xmx:AgH7ZT4fEKIWAO6oQpBp919fatmDvWsCedJ9XZpfICkZzLbDbEXXZA>
    <xmx:AgH7Zb7FWkqkYbS-Km1r0KL26JufJ4_uO_Bhn00by7rO1XxlF1kttg>
    <xmx:AgH7ZTiCXca5mTWMlNiC0qpMvD3PCxkzr42ksPodXE_Ou_18L0UwFQ>
    <xmx:AgH7ZV5TDIcrD5YKaixgTUgdorJ08JI1i2IMyhPNHQhoBbznIseK4Q>
    <xmx:AwH7ZaQTzt98WLMYBGvpt8E_2IaaPMec_K9SAfZJfVtvb6z0DHs-EbxCqkU>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Mar 2024 11:30:10 -0400 (EDT)
Date: Wed, 20 Mar 2024 08:30:08 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: time: add Ktime
Message-ID: <ZfsBADaYHz1FG8ie@Boquns-Mac-mini.home>
References: <20240320-rust-ktime_ms_delta-v1-1-ccb8672a0941@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320-rust-ktime_ms_delta-v1-1-ccb8672a0941@google.com>

Hi,

On Wed, Mar 20, 2024 at 10:08:45AM +0000, Alice Ryhl wrote:
> Introduce a wrapper around `ktime_t` with a few different useful
> methods.
> 
> Rust Binder will use these bindings to compute how many milliseconds a
> transaction has been active for when dumping the current state of the
> Binder driver. This replicates the logic in C Binder [1].
> 

I wonder whether Lina's previous patch also works for your case?

	https://lore.kernel.org/rust-for-linux/20230714-rust-time-v2-1-f5aed84218c4@asahilina.net/

You don't need to implement all the `Clock`s since you only need
MONOTONIC time. But maybe `Duration::as_nanos` and `Duration::as_millis`
return `u128` is problematic?

Regards,
Boqun

> For a usage example, see [2].
> 
> Link: https://lore.kernel.org/lkml/5ac8c0d09392290be789423f0dd78a520b830fab.1682333709.git.zhangchuang3@xiaomi.com/ [1]
> Link: https://r.android.com/3004103
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/time.rs | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
> 
> diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
> index 25a896eed468..ac8b35f662af 100644
> --- a/rust/kernel/time.rs
> +++ b/rust/kernel/time.rs
> @@ -5,6 +5,9 @@
>  //! This module contains the kernel APIs related to time and timers that
>  //! have been ported or wrapped for usage by Rust code in the kernel.
>  
> +/// The number of nanoseconds per millisecond.
> +pub const NSEC_PER_MSEC: i64 = bindings::NSEC_PER_MSEC as i64;
> +
>  /// The time unit of Linux kernel. One jiffy equals (1/HZ) second.
>  pub type Jiffies = core::ffi::c_ulong;
>  
> @@ -18,3 +21,60 @@ pub fn msecs_to_jiffies(msecs: Msecs) -> Jiffies {
>      // matter what the argument is.
>      unsafe { bindings::__msecs_to_jiffies(msecs) }
>  }
> +
> +/// A Rust wrapper around a `ktime_t`.
> +#[repr(transparent)]
> +#[derive(Copy, Clone)]
> +pub struct Ktime {
> +    inner: bindings::ktime_t,
> +}
> +
> +impl Ktime {
> +    /// Create a `Ktime` from a raw `ktime_t`.
> +    #[inline]
> +    pub fn from_raw(inner: bindings::ktime_t) -> Self {
> +        Self { inner }
> +    }
> +
> +    /// Get the current time using `CLOCK_MONOTONIC`.
> +    #[inline]
> +    pub fn ktime_get() -> Self {
> +        // SAFETY: It is always safe to call `ktime_get`.
> +        Self::from_raw(unsafe { bindings::ktime_get() })
> +    }
> +
> +    /// Divide the number of nanoseconds by a compile-time constant.
> +    #[inline]
> +    fn divns_constant<const DIV: i64>(self) -> i64 {
> +        self.to_ns() / DIV
> +    }
> +
> +    /// Returns the number of nanoseconds.
> +    #[inline]
> +    pub fn to_ns(self) -> i64 {
> +        self.inner
> +    }
> +
> +    /// Returns the number of milliseconds.
> +    #[inline]
> +    pub fn to_ms(self) -> i64 {
> +        self.divns_constant::<NSEC_PER_MSEC>()
> +    }
> +}
> +
> +/// Returns the number of milliseconds between two ktimes.
> +#[inline]
> +pub fn ktime_ms_delta(later: Ktime, earlier: Ktime) -> i64 {
> +    (later - earlier).to_ms()
> +}
> +
> +impl core::ops::Sub for Ktime {
> +    type Output = Ktime;
> +
> +    #[inline]
> +    fn sub(self, other: Ktime) -> Ktime {
> +        Self {
> +            inner: self.inner - other.inner,
> +        }
> +    }
> +}
> 
> ---
> base-commit: 768409cff6cc89fe1194da880537a09857b6e4db
> change-id: 20240320-rust-ktime_ms_delta-74b00c9ab872
> 
> Best regards,
> -- 
> Alice Ryhl <aliceryhl@google.com>
> 

