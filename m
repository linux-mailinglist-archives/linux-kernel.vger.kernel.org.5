Return-Path: <linux-kernel+bounces-132759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A25B8999D4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8FEE2843B4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4400716087B;
	Fri,  5 Apr 2024 09:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="JvxeNbEq"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32AD1A26E;
	Fri,  5 Apr 2024 09:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712310456; cv=none; b=XHGNmMzBjuLku9OWIs/fVbra6DCSvTxuOlpMBrQkqqV/kDBudj27l0xEcbsrBz2AXOe6astT9zjsUzuAlLgmEDPDz1Qhc6KMUFyiZpDZBKLS4IlK16Nsz8f8+bw9hzvgzKThwYbGc86TNxxAOnGU60KBIaQWEcUlmOAjJ28IiQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712310456; c=relaxed/simple;
	bh=F5izhsD4G3SI0Rk/8S99UY1gDQNUNsaPEQp+ZSnHcRk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PpI0RB1oNz3NiJYfgxFMh8/uc64dWwZNIUuzsF5rNw9jMM0dcf1zp3bHOpwgw7SfiNp/xdcym8EgKog9/6tc6R/t9lUmYbX6FDpmcLKqZJI+z6ddoKtNS0Dpa5rJhi8HWGh4/zNLbT8a1Xi2fz7DkL0Wltn8t7+UsfLrN2Uc1Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=JvxeNbEq; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1712310452; x=1712569652;
	bh=rLmpZrzNrBXqu+xt/ZCUi25drzPdpOCa8IMXdFNbdc8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=JvxeNbEq6egthg86ERFlZgIt8Ffa9WRNQao5xrKEbdogccX8tJ6XU221TPPj2oQf8
	 +WaBVkqK9vGY2GN8knfFKUUawkgrphu35+Df/7uUmYBzN9p7SbQn/fP5sHxFX00avv
	 1m040ef2uOOXUPOcy6wybgQ/w9MM5vV8qzI9XCpmcegAVLaYeKypQujds0S18Nas0A
	 CcQ+PM3vx84lfVewXxF6EPsog5kh1acT/eSAP0gtGUfwNwSuLwmre4ZtkDNAigXm3O
	 NLRxUO1VLMJmUAOULSMuDPiYUOJl9kTJawsZHuD5pQSrE5h68Px+ggGSEh+7RiHSK9
	 kmBLeBKKQoqow==
Date: Fri, 05 Apr 2024 09:47:28 +0000
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Marco Elver <elver@google.com>, Kees Cook <keescook@chromium.org>, Coly Li <colyli@suse.de>, Paolo Abeni <pabeni@redhat.com>, Pierre Gondois <pierre.gondois@arm.com>, Ingo Molnar <mingo@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 3/9] rust: list: add struct with prev/next pointers
Message-ID: <c715d559-0f03-4659-a515-1dd58e683f31@proton.me>
In-Reply-To: <20240402-linked-list-v1-3-b1c59ba7ae3b@google.com>
References: <20240402-linked-list-v1-0-b1c59ba7ae3b@google.com> <20240402-linked-list-v1-3-b1c59ba7ae3b@google.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02.04.24 14:17, Alice Ryhl wrote:
> +impl<const ID: u64> ListLinks<ID> {
> +    /// Creates a new initializer for this type.
> +    pub fn new() -> impl PinInit<Self> {
> +        // INVARIANT: Pin-init initializers can't be used on an existing=
 `Arc`, so this value will
> +        // not be constructed in an `Arc` that already has a `ListArc`.
> +        ListLinks {
> +            inner: Opaque::new(ListLinksFields {
> +                prev: ptr::null_mut(),
> +                next: ptr::null_mut(),
> +            }),

You might want to implement `Zeroable` (using the derive macro) for this
struct, since then you could just return `init::zeroed()`.
You can also use that for the `ListLinksSelfPtr` in the other patch.

--=20
Cheers,
Benno

> +        }
> +    }
> +}
>=20
> --
> 2.44.0.478.gd926399ef9-goog
>=20


