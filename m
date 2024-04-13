Return-Path: <linux-kernel+bounces-143491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE9E8A3A23
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 03:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AFC01C213A4
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 01:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFBCBE40;
	Sat, 13 Apr 2024 01:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSJzKSm6"
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A008663C8;
	Sat, 13 Apr 2024 01:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712971841; cv=none; b=O9KnBJWriym+gWDZoZIc6MWvr4MkznOWvB4DfP3uUXNEUS+PwbnE2kb+SrsuT88pCuNy86kDhaBqo8WHMupez+blh/G0oEj4D/vHJQatqaJKU31Pw1SBNVwTQLGVJUS/wEHVsaNyiWJecPFKy/6EJgM36zR8NZyBy8+N5bmpX/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712971841; c=relaxed/simple;
	bh=RlBJ6FJhdBQgcIf20qlpXCjBXGhLET1XFZuTUNZ6Yaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PlTXTVGljOLmpmtOs1LxxE9DkPI24dm0SHmGG3WmkWSk78HE1xTZIbDTJAhPt9wmcNpn0JZMF/V+VPYhEiSi0UHuUvAHjQTeki+oqdIeOYQOp+gMWihpjvgS641Fy1no8XHqIU+fdZlWQCD4ctqO9FIlFXbnzKbER+grLuLFuaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QSJzKSm6; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-479c0e8b1c5so413327137.1;
        Fri, 12 Apr 2024 18:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712971838; x=1713576638; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WGZV+9Baru/G/BJ7iBWX/ai40r2yV5HMJ8W7pjdUee8=;
        b=QSJzKSm6XfIKekPqtsNuLo5Wb3MR1lTlXXZg3T4hZBCnJo1dkAGZcAOP2GzeP/faeH
         oP771Pe0z0nVSXOBLrZe58SSQPGDtag4hwgnPKNynlmoIKN3vzj76V/1gRalpt7UdloT
         pkHeu632xx7lfI2j+EYHJWkWqI26689mcCtZ41cACl6gcLLU1dmpjXvSJfKUUNdyZack
         ksdg7dCzX1ze7CRCR68Tp7dfSP+4maxRVxHYv+TX37Urz+s2//DSB7PybXTHmx8965di
         a1drbW1ciPVcSayNHC2rIMhq7i0NeRs7g/5+BLUw38XUkidsn2DQG6FUIKXfMXQux5pP
         0jhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712971838; x=1713576638;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WGZV+9Baru/G/BJ7iBWX/ai40r2yV5HMJ8W7pjdUee8=;
        b=HHUmq/aX9yJkEXz1OjPEY4kdx+KwmI7MFmo26ZOf2BzMXHGdyTQAdwGA7tqoTKAy1I
         03xB+DSHh6DztB76Kzpz4VKmgWPG+IoqMK2wOv2QB8/MKqp3TH7fCn9cUwKJeJG5dSoT
         /4nkoaaVKEvZdPx+AGmIq6fwr2zNHrJZupZhcflRTpr/Spdn3mLqd41bCDx83G+YBjvh
         O1Z/5X7GBQBUwWreZKAjCV9c9U4eK0BkmDUVFwJ7harmevBRavBz8CrChjWzKBrhXA1N
         0a7kLuWrDKSPcmEH1S5bQCp4/JbuaqnET4CKkpkSsE2REX5bAc99fCy/VdHmL+XwDz7l
         DsSw==
X-Forwarded-Encrypted: i=1; AJvYcCWifcDAJQMri2BMoMupIZw6JYkIUrA79GbLYY1ooPsE/XxQ5dZ3l1QocKTBYb5Cc0qvMgZG9jwona/OCaoFfQ2COI+YC2FJ1VNg3pVNg2XFCQV5JBZgo8X3i2YSob5vlqUgMWcji0O6NX4UDI8=
X-Gm-Message-State: AOJu0Yy05vAnAja5AshHQmZazDL2x55YD0MjMFnOjj64Kkkd/SLYZcNj
	UFDz64liMY4N2cKBsL8QSjd9P59D6bgXfinQpHbrslys4U3LwUm1
X-Google-Smtp-Source: AGHT+IHS/N8QDRdQcxdF97ORpJiSqEdWxBgscXHLMzsACh9++T2iQtEGnwLq3nWivu3FBHa+C9qWDQ==
X-Received: by 2002:a05:6102:f94:b0:47a:42c4:4cde with SMTP id e20-20020a0561020f9400b0047a42c44cdemr5751224vsv.18.1712971838479;
        Fri, 12 Apr 2024 18:30:38 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d24-20020ac85358000000b004364d940d3dsm2878244qto.96.2024.04.12.18.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 18:30:37 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 11B261200066;
	Fri, 12 Apr 2024 21:30:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 12 Apr 2024 21:30:37 -0400
X-ME-Sender: <xms:POAZZihf7kZ8o-pThSc6ydkfq_pk4FB6usxnDrWN9MhcHdkC59VS1g>
    <xme:POAZZjCQ0g31iflkM9t3F4k5P6M-NcwV0nCf8o5_rtmRR_7a24N2ngizzHzIaZVYj
    ar1VyrT55bLrJu8Jg>
X-ME-Received: <xmr:POAZZqHc0pN7NsOxptgyVot2cNbAbWu20bsHYvOK_LxPB9HlZVBqUFFcUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeihedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepvefghfeuveekudetgfevudeuudejfeeltdfhgfehgeekkeeigfdukefh
    gfegleefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:POAZZrQCUKoXT_bnydx2daT60K3T-1r2MO79noUpm_c9eEBTO9w30A>
    <xmx:POAZZvyisjjaISvpviSNW6f8yp3qDYnX6g2tAjs2nYieq_OT-karwQ>
    <xmx:POAZZp5ptOs5M9SsEEDxRz7DpmNDE6LleF3CEIkVXC5sLbY5GGzLxw>
    <xmx:POAZZsx9-kZ_gSdKTGj34w7jx59jk8CadewHA84ku4AZC6CmWLBKUw>
    <xmx:PeAZZrikbS4JyF6GkM5KxnDoLCGW7vkkFZrtkFuOhR2cYjs2DaO_g2PS>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Apr 2024 21:30:36 -0400 (EDT)
Date: Fri, 12 Apr 2024 18:30:34 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Miguel Ojeda <ojeda@kernel.org>,
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>, bjorn3_gh@protonmail.com,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vegard Nossum <vegard.nossum@oracle.com>
Subject: Re: [PATCH 2/2] rust: time: Use wrapping_sub() for Ktime::sub()
Message-ID: <ZhngOs7Xze65i9Qy@Boquns-Mac-mini.home>
References: <20240411230801.1504496-1-boqun.feng@gmail.com>
 <20240411230801.1504496-3-boqun.feng@gmail.com>
 <CANiq72nSSAVkynVaAq7bQKoL6N8K2JUXp8AOVvu7vN+siAhk-Q@mail.gmail.com>
 <Zhk4Uqc4LImR2n_r@Boquns-Mac-mini.home>
 <CANiq72ka4UvJzb4dN12fpA1WirgDHXcvPurvc7B9t+iPUfWnew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72ka4UvJzb4dN12fpA1WirgDHXcvPurvc7B9t+iPUfWnew@mail.gmail.com>

On Fri, Apr 12, 2024 at 04:41:26PM +0200, Miguel Ojeda wrote:
> On Fri, Apr 12, 2024 at 3:34 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > That works for me, although I would prefer `Ktime::sub()` is wrapping
> > sub and we have another function doing a safe version of sub.
> 
> Why? It goes against the "normal" case in integers. It is also not
> what `ktime_sub()` does, which is the "normal" case here, vs.

Seems we have a different reading of `ktime_sub()` ;-)

Based on your reply to Philipp, I take it that
CONFIG_RUST_CHECK_OVERFLOWS can be enabled in a production kernel,
right? IOW, it's not a debug-only feature like UBSAN (or maybe I'm way
wrong, that UBSAN is also a feature that production kernel can or
already use?). If so, then the current `Ktime::sub()` has a different
behavior compared to `ktime_sub()`: it will perform overflow checks and
panic (which is BUG()) in production kernels.

Now I wasn't trying to say substraction overflows shouldn't be checked
(by default), the thing is that `Ktime` is just a `ktime_t` wrapper, so
it's natural that it provides as least difference as possible. If it was
a standalone abstraction, then by all means let's add different APIs for
different purpose.

If you look at ktime API, ktime_sub() is the only one doing
substraction between two ktime_t, there is no raw or unsafe or safe API,
So as a minimal abstraction, it's natural for a user to expect
`Ktime::sub()` behaves like `ktime_sub()`.

That's my reasoning, but it depends one a few "if"s and what time
subsystem wants to do.

> `_unsafe()` and `_safe()` ones.
> 
> > Exactly, ktime_add_safe() doesn't panic if overflow happens, right?
> > I think that's pretty clear on how time subsystem wants to handle
> > overflow (saturating it, or zeroing it instead of panicing).
> 
> There are three variants in C (for addition) that I can see:
> 
>   - No suffix: not supposed to wrap.
>   - `_unsafe()`: wraps.
>   - `_safe()`: saturates.
> 
> The first one, in normal C, would be UB. In kernel C, it wraps but may
> be detected by UBSAN (this is what Kees is re-introducing very
> recently with 557f8c582a9b ("ubsan: Reintroduce signed overflow
> sanitizer")).
> 
> So, in Rust terms, the three options above would map to:
> 
>   - Raw operators.
>   - `wrapping_`.
>   - `saturating_`.
> 
> Because the raw operators are what we use for arithmetic that is "not
> supposed to wrap" too. That is, they wrap, but may be checked by the
> Kconfig option. Of course, it may be worth having an intermediate
> option that does not actually go for a full-blown Rust-panic for that,
> but the point is that the current "not supposed to wrap" methods are
> the raw operators.
> 
> All three, in fact, are "safe" in Rust terms, since none can actually
> trigger UB (in kernel C at least -- it would be different in normal C:
> the first one would map to an unsafe Rust method, i.e. `unchecked_`).
> 
> Instead, in the C side, `_unsafe()` seems to be used to mean instead
> "you should be checking for overflow if needed, because it will never
> be reported by UBSAN unlike the raw one". Again, this is based on my
> reading of that commit and the docs on `_unsafe()`. It may be wrong,
> or maybe the subtraction is supposed to be different. It should
> probably be clarified in the C side anyway.
> 
> And, relatedly, I see that when the `union` was removed in commit
> 2456e8553544 ("ktime: Get rid of the union"), `ktime_add_unsafe()`
> stopped returning a `ktime_t` even when both inputs are `ktime_t`s
> themselves:
> 
>     static_assert(_Generic(ktime_add(a, b), ktime_t: true, default:
> false)); // OK
>     static_assert(_Generic(ktime_add_unsafe(a, b), ktime_t: true,
> default: false)); // Bad
> 
> It returns an `u64` now, which could surprise users, and probably
> should be fixed. The only user just puts the result into a `ktime_t`,
> so there is no actual issue today.
> 
> > I must defer this to Thomas.
> 
> Yeah, the question on the C API was meant for Thomas et al.
> 

Maybe it's wise to just wait for them to reply, I don't think you and I
have much disagree other than ktime_t API semantics ;-)

Regards,
Boqun

> > Maybe, however neither of this function probably shouldn't have the
> > panic-on-overflow behavior. So I agree that overflow checking is not a
> > bad thing, but when to check and how to handle overflow should be
> > controlled by the users, and making the default behavior
> > panic-on-overflow doesn't look reasonable to me.
> 
> Yes, it should be controlled by callers, but the point above is that,
> from the looks of it, these interfaces are not meant to overflow to
> begin with.
> 
> Cheers,
> Miguel

