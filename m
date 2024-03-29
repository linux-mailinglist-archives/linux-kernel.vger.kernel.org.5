Return-Path: <linux-kernel+bounces-125525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 291568927C8
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 00:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38D67282918
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 23:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E54813E051;
	Fri, 29 Mar 2024 23:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="anfaUUvk"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CC964B;
	Fri, 29 Mar 2024 23:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711754670; cv=none; b=IO+5Rt3m9b16ItoeMHHKMLKLNLdssKvw9wFDscopqOpCRGlo0jp93dVk69H945BbmmsI4HseLyPlg7ASLxA1UP2ILfuk0Xzzw7Zp/szhcKEAjqRwl8ZRVIxWjAJC4aD+rQIh4nZBZC2oXbS4j2dM04w2Uh28QBS6dN3V8ETl7RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711754670; c=relaxed/simple;
	bh=QSssbFjXz+eZ/ZgUMwkgKn6RmNuNwQ2PoDMrtj4r644=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fm7hBwypm2j1uall27qfA/aPd7m0VFJcqqLnIyJGEHXzG9ze71MEu/c783B9Ur8BPWIvfwFjyIqoHcHy3C+lKnF+Zr0INEZJlA0hzbgw8waIQAhHT0Z9gJKa9RiVLPjk7Vb/TSk1dYZLwNVTyNUkvqR9L9N0mnzoao7BFe7Vvxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=anfaUUvk; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3c36f882372so1436434b6e.2;
        Fri, 29 Mar 2024 16:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711754668; x=1712359468; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nAqT/PkO4I/dSKZYMDvK1XHcQqT1AvW4NQ1vVEVf7/Y=;
        b=anfaUUvkhzysZ+thkc0mCGm1rxPJBEoSHIEf1Em2gOmsKNu0vGJkiWxwZMi06m76Hb
         6lHapMX7KhWVob9TUclyO4pYFLejJi6wiRLIyeT5h7buerdyiYS9Oxgj2/mY0X70vn5Y
         hu1n1ssRm6C+pDQaYeueeOaRrGgDbG8T4X5wYBLtueR8vJz1q6RRqUHTro+L4YumTaRX
         IElEZZw6Rynv95ePX0dSjTAh0s7c1/vfTP1QC6Npj16vRsOu+d1baQyUf2oBq/SrFm3i
         ZPM/mzUkPy3nvX76yKCstgbIwr0FqKf3PK/4IiJ65G1DUQC81p4Ed3RnstrRUuTbBLnP
         Y5FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711754668; x=1712359468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nAqT/PkO4I/dSKZYMDvK1XHcQqT1AvW4NQ1vVEVf7/Y=;
        b=pjHl5ZVnKNxwTX8g3+M5GDz0BcQXbEnk0crzjVtdgKpMY2Xe0MQchP4AkTikZ3yX9h
         SD3COMclnRK3pmhymRDMq/3/S9CA3leGuj4QGfN7c0kJ9ZO3Xw9y7WaYsCSQQ0bx1UTe
         jbl9awxf5oIwManmf7TYnUcVbEDmJJqYDIZ2lzFdTp6SMQSJu66gLEAENulbaEEiTfm/
         BXCB2BVBWxb/5K/kN/pj2Z9sA0tXqgc1zLXFeuKBXrEYdf/P3bw3+A0AY4THPRFj/VJq
         T08xnPRYX5LYjGQaE3ykbzy4wfHzm1decSQNtCXjtY2D7AWH9GSjr1iMa/HF8OHSWw6v
         CpkQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+jEncGaVRz8WAx63aeYwOgLhNdQ0RZXfrcRth8OJYNP1RjLHHY/m0ku+4c80mVlEhAY7XKp9LRuPtXR/rTZZxQZtymIGTpJCJDCBM
X-Gm-Message-State: AOJu0YzOweFi3Ghz9AJPU/sXFPH7GsPcSLFFt0ZzV35/T/+8VPjurein
	hWAgEM1ov1lbL1Kc2XGLgNdfjDHnwk+Ox4lNUcX2Njprng8n6jX5
X-Google-Smtp-Source: AGHT+IFdNmK0xPtWYygNA8XuQeAr5sygQ6mRUco/hHSJpmhhK4b8eowehgfXoBh3zEyqRvQPLz0CyA==
X-Received: by 2002:a05:6808:13c9:b0:3c3:d65e:f6d with SMTP id d9-20020a05680813c900b003c3d65e0f6dmr3760249oiw.57.1711754668015;
        Fri, 29 Mar 2024 16:24:28 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6-20020ad45ba6000000b0069694dab3f8sm2093422qvq.39.2024.03.29.16.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 16:24:27 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 650DC1200032;
	Fri, 29 Mar 2024 19:24:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 29 Mar 2024 19:24:26 -0400
X-ME-Sender: <xms:qU0HZq_m6l5ETvaRE3DctkpbRfLAsG-wTZc_gxjKTdof6JwqVz3qog>
    <xme:qU0HZquOjyhNQ_D0AGQ6T8aL7ZulcJzwfe0DhOreHCYYW4zYEDeWjRhW3SCWcj9GY
    KZhIEYzHnC-wD4Ocg>
X-ME-Received: <xmr:qU0HZgC5UQY3JphX0Z3yZEZ32b9khPRMB0P6iYnlyuhyRJrMmnswpoZBX4I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddvfedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpefgieegkeelgfekheetudeiiedvlefghfeffefffefgudejvefgtdfhhfet
    hfegjeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:qU0HZicx5e3dMWD-YdgwVwHgM-U3adzoEceJw5X7snvZbpx7GggeMA>
    <xmx:qU0HZvO79pKZp5UVTah8IROqEFukIipr8ZMcnCBLzA-pjxbeRkxUSw>
    <xmx:qU0HZsn01L4HydhzTSwVZ2Ywsl2S11VxVT1wwGKoLbTjyIb-20Phwg>
    <xmx:qU0HZhthgv4R27lSphyc6jLBqSuHc5u36Rz-_A6SgHpNc4gIzE2o9A>
    <xmx:qk0HZjnexGrV8j9NniSTNboCO4IuGbRjJOA6-KtJs3T6u21neDG9bIUVgbE>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Mar 2024 19:24:25 -0400 (EDT)
Date: Fri, 29 Mar 2024 16:23:42 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, linux-kernel@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [PATCH v3 00/10] Allocation APIs
Message-ID: <ZgdNfvLWXhHIpWUf@boqun-archlinux>
References: <20240328013603.206764-1-wedsonaf@gmail.com>
 <ZgcHfG5Hdhv39SLU@boqun-archlinux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgcHfG5Hdhv39SLU@boqun-archlinux>

On Fri, Mar 29, 2024 at 11:25:00AM -0700, Boqun Feng wrote:
> On Wed, Mar 27, 2024 at 10:35:53PM -0300, Wedson Almeida Filho wrote:
> > From: Wedson Almeida Filho <walmeida@microsoft.com>
> > 
> > Revamp how we use the `alloc` crate.
> > 
> > We currently have a fork of the crate with changes to `Vec`; other
> > changes have been upstreamed (to the Rust project). This series removes
> > the fork and exposes all the functionality as extension traits.
> > 
> > Additionally, it also introduces allocation flag parameters to all
> > functions that may result in allocations (e.g., `Box::new`, `Arc::new`,
> > `Vec::push`, etc.) without the `try_` prefix -- the names are available
> > because we build `alloc` with `no_global_oom_handling`.
> > 
> > Lastly, the series also removes our reliance on the `allocator_api`
> > unstable feature.
> > 
> > Long term, we still want to make such functionality available in
> > upstream Rust, but this allows us to make progress now and reduces our
> > maintainance burden.
> > 
> > In summary:
> > 1. Removes `alloc` fork
> > 2. Removes use of `allocator_api` unstable feature
> > 3. Introduces flags (e.g., GFP_KERNEL, GFP_ATOMIC) when allocating
> > 
> > ---
> > 
> 
> FWIW, I've put this into rust-dev:
> 
> 	https://github.com/Rust-for-Linux/linux rust-dev
> 
> a few adjustments are needed to work with other commits that have been
> queued in rust-dev, so I add an commit on the top for everyone's
> reference. (Besides this commit, I also removed all updates to our own
> alloc in Miguel's 1.77.0 compiler version bump patch)
> 
> Regards,
> Boqun

As Miguel pointed out offline, the following is also needed:

diff --git a/rust/kernel/file.rs b/rust/kernel/file.rs
index a5930f0f2bc5..bf68a0ce9f14 100644
--- a/rust/kernel/file.rs
+++ b/rust/kernel/file.rs
@@ -350,7 +350,7 @@ impl DeferredFdCloser {
     pub fn new() -> Result<Self, AllocError> {
         Ok(Self {
             // INVARIANT: The `file` pointer is null, so the type invariant does not apply.
-            inner: Box::new(
+            inner: <Box<_> as BoxExt<_>>::new(
                 DeferredFdCloserInner {
                     twork: mem::MaybeUninit::uninit(),
                     file: core::ptr::null_mut(),

