Return-Path: <linux-kernel+bounces-141246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8E08A1B44
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C8521C220FF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44601757FB;
	Thu, 11 Apr 2024 15:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZscvUQgx"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD82A2BD06;
	Thu, 11 Apr 2024 15:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712851026; cv=none; b=WEv9qM0UzhlifW/lypuLAuGS24RiHrKppBL0JnwGVCR+u8aP5ZeXRuCsgsvyONuDVk2m7QHlOOOISIYVHE9rcCeniP7U4Wk9kGT7ASzUBolwox50mD36vdpn4K4LpS+3jQvNGNUi3oCD3oEgRXQS4nCoXm/lnH8KV8/N+d8++JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712851026; c=relaxed/simple;
	bh=j0C88cQjcRARX8NAqzbWswdUlX/bmV95PPqBm9svuP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmG+b7CUq7KhvFV6G6oGz3Q42AzfObbAHty4YcCkROF0QmezpVFy8c3Pl4zNS7vEd1bC4MHOblhOC8BvbSIgjuVuK8S4AJOydh/VehMuaP5bgvr5SJQ0VuY60/AixpAwpCQsoqCwMVQG2yV/rAU2B+akAPLeV+oukvJkqji/KyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZscvUQgx; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-78d7558bf10so184882885a.1;
        Thu, 11 Apr 2024 08:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712851024; x=1713455824; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xIcOsLyrVQHki9Dz95LMR/vycR1ddNkayx5GTY0yswM=;
        b=ZscvUQgxIU91VYb68QmTzdyLUFFzC3NUc1r0j/2HbgTfzSA7kt1SPles5xbVctjf0Y
         kNghhPNO4rIAM5oeYMjPRKzKtXoM+6szzGRd1aTl7NhhZK9EJC3xnfTFP828RcW+y66a
         yZqjZkcqEhI5/2j7xa3eVe37oQbuu8Xj1prcTV7KKMx+w0xJNkk05J0YBOd2SNNtQJos
         X4OpmnrcYrNA6lspYM6//Z6b7K0ImGc8ectzi3DxMVzr8S2kzY73o+rkjy/5JSRHkUwE
         sqX/cyOpoTKEoF9yCp4XUsaQVxKjjn/5b+mMtVt6L+2Ev3GlijI/J9VyLgy/OulCQJ7w
         VlmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712851024; x=1713455824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xIcOsLyrVQHki9Dz95LMR/vycR1ddNkayx5GTY0yswM=;
        b=aPnefqZGDSHU1Hd/gsPK3ZfEZCy7Mqx/VylBYPAKUS38faniD9tuOQhazQDNZMIqks
         EMFCqWaditG28892WGAzRHy/DWYhL+4Z2S1U/ZnmU0yL/lNm10+sWJuf+9BawcY8PJaC
         WnyRpyZwV3u1pR7K4kMFBiY4lp3uXBKyyODcsjXSTJIlxttFMQZ+npJk/Q2DkKM+nVFn
         2nkvcKj3AuO01v/QPaj0vL3+J7kAZxcBHLHXkziE23jJI1D6IMbqug0CBU4AvevKiehr
         knj3K1b1dBlfJqcNivCdaJVm2ImRprGCYUMqE+UaINnpqay028TAiM26AH2ci0D8xpE+
         eE4w==
X-Forwarded-Encrypted: i=1; AJvYcCU/EtOcPg5yPgvqLEs3jA3eUUSHrIDcINQXnOcOOOBhSwbefMPGyhHexqwZTMieinScg5s6Nf8NmFueOoSHDDMWaF9qjadungtpLmA455K96AaJBnNzRcsCbbokFws+RXjCs1PZqv7s8nq0Zq4=
X-Gm-Message-State: AOJu0YypZG/JVPp2SWpbpzis4yib8mYHtjaCDYfUSbbinBcGJffOcRP6
	QjNNROyzUIX2/g41vngeqGTEfJUKMLeV4uN7+qU23keO3zoYf1lP
X-Google-Smtp-Source: AGHT+IE5ZMKMQmcnrGkC7XJ2HjnlikftDfG+rCClJjhzYMgv8hkpYLa/F+TCkuwKYkiWJmF5ucgPsA==
X-Received: by 2002:a05:620a:890:b0:78d:5a03:2595 with SMTP id b16-20020a05620a089000b0078d5a032595mr53988qka.24.1712851023748;
        Thu, 11 Apr 2024 08:57:03 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id b18-20020a05620a119200b0078eba18c234sm1182666qkk.47.2024.04.11.08.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:57:02 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 38072120006A;
	Thu, 11 Apr 2024 11:57:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 11 Apr 2024 11:57:02 -0400
X-ME-Sender: <xms:TggYZk-Oax9NHxI8BTEqvHSDwdXrVrsFs5PQDibkDrUWPVqFc3328w>
    <xme:TggYZsutcP19n_lLdmoHQsFBa5oCnN5FamFHCDBqQ9yO5RdQxuTdpQNo2C1zBrJVp
    Nm4gcNOpnd_PEY4tA>
X-ME-Received: <xmr:TggYZqC5ol30kUxHPeHYQx3lMJn6PJ5UuHo1Sd_IeyduDWPCUt9ZHgL2yyfz1A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehkedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeffhfekuedvjedtudekgfetffeiffeludejuedufeeftddvjeefkedvveeh
    ueegvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdgrnhgurhhoihgurdgtohhmpd
    hruhhsthdqfhhorhdqlhhinhhugidrtghomhenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrsh
    honhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghn
    gheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:TggYZkc1cjXIaj8jBlz-Gm0__JdbRZ2ENXZuou0JPpXamzCPXn6c7A>
    <xmx:TggYZpM9NknugcHpwoTMH22PPtxqT94gAqdGkC1lGpXSAUpEhf9Wbw>
    <xmx:TggYZunl1KXLF_nUvRA6ldWAQZJ5coTxBn22o-QxMG1d7WQ6RwNd0g>
    <xmx:TggYZrvLnlVxhMcyRMsoYOgsdv_oY4gWwnOZxZNtX0BY-7mfZbNIHA>
    <xmx:TggYZnuNuyLH-lBmc1-XGMejpMEpjty1BqJ0vje4C45RPuIczeHXHhP0>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Apr 2024 11:57:01 -0400 (EDT)
Date: Thu, 11 Apr 2024 08:56:58 -0700
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
Subject: Re: [PATCH v2] rust: time: add Ktime
Message-ID: <ZhgISqMcEl21QZmW@boqun-archlinux>
References: <20240322-rust-ktime_ms_delta-v2-1-d98de1f7c282@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322-rust-ktime_ms_delta-v2-1-d98de1f7c282@google.com>

On Fri, Mar 22, 2024 at 08:59:38AM +0000, Alice Ryhl wrote:
> Introduce a wrapper around `ktime_t` with a few different useful
> methods.
> 
> Rust Binder will use these bindings to compute how many milliseconds a
> transaction has been active for when dumping the current state of the
> Binder driver. This replicates the logic in C Binder [1].
> 
> For a usage example in Rust Binder, see [2].
> 
> The `ktime_get` method cannot be safely called in NMI context. This
> requirement is not checked by these abstractions, but it is intended
> that klint [3] or a similar tool will be used to check it in the future.
> 
> Link: https://lore.kernel.org/lkml/5ac8c0d09392290be789423f0dd78a520b830fab.1682333709.git.zhangchuang3@xiaomi.com/ [1]
> Link: https://r.android.com/3004103 [2]
> Link: https://rust-for-linux.com/klint [3]
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> Changes in v2:
> - Mention that ktime_get cannot be safely called in NMI context.
> - Link to v1: https://lore.kernel.org/r/20240320-rust-ktime_ms_delta-v1-1-ccb8672a0941@google.com
> ---
>  rust/kernel/time.rs | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
> 
> diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
> index 25a896eed468..6811d5cadbd4 100644
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
> +        // SAFETY: It is always safe to call `ktime_get` outside of NMI context.
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

Nit: although we use "Release mode" to compile Rust code in kernel, so
i64 substraction behaves as 2's complement wrap, I think it's better we
use wrapping_sub here:
		
        self.inner.wrapping_sub(other.inner)

however it's not a correctness issue for now, so with or without it,

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

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

