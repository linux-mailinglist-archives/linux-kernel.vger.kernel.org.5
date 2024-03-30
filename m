Return-Path: <linux-kernel+bounces-125712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F01F892AEF
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 12:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 505DD1C20B94
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 11:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A38A36B01;
	Sat, 30 Mar 2024 11:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Abr3GeCx"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA722F50;
	Sat, 30 Mar 2024 11:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711799370; cv=none; b=dyAUwa5W0Nxhm1OrszIpTwNhrLo6HI3AUlpZeNy4g8rXh9FoCllxu6sJK+53AqmoafCApPCxFCpq0lRIJrOdZJ7k9oXXm8ue2MKsaV8aVO5av43LkzlazKI+puniwWDgWyPk8WQQK+vsGFKU27WqenkEMAUZq5taj2SWsvfJSME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711799370; c=relaxed/simple;
	bh=OAtYO0TA7oz+MdmFTmj+NaS5brG0Cyc3v8vfLdL3BiA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AA0/2GCSu/l5pE9wlTspDAsZDqHDa7WNqdw6NGCDt2c19Ktgo0Dep/55ZSAo+fXMFuF/659ySygpw0hlzrHtKdG7yNwu95/tzDD73YwI1+BOd7LVkaLLllKdwPp/L5D1nDbULmX/q0M9n9YqN3bL9xc1pz74TPzniTwIkGlKrNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Abr3GeCx; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1711799366; x=1712058566;
	bh=kiZnypS/KuzikRmWxKufVnqNXSXiYj1BmoyGeMKj258=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Abr3GeCxTIIrQTTnESvCeOUYCxOlk2+oBonr7Hx/LKyJIgYDquo98dO2xIFjRo6xv
	 s3ehq7kPYIIzlUsZwU8kjY75JrXflRopy/eW/HlvP2y8Di0y/su4YJX9lJCYUAPW8u
	 0eA3LPc/IXBZCReEFGfFOBd4qM4MUp2Xy7esdWZgKCQNDTq4lhS4tn4m8fzANMZs2k
	 jXWI/l+dcbhRTCkENhyBVH/FlCXGaHRH7Jwz29Idzs0VCWLQnht0UX08lwLg/OmnRy
	 PwZPzL2cFnxTtgao6biM0gIqXhuCb1KxIsI6MJoWQSSC4QXRzwnx3D1cXfXjPwgotu
	 HR//YI5djoEog==
Date: Sat, 30 Mar 2024 11:49:16 +0000
To: Wedson Almeida Filho <wedsonaf@gmail.com>, rust-for-linux@vger.kernel.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, linux-kernel@vger.kernel.org, Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [PATCH v2 5/5] samples: rust: add in-place initialisation sample
Message-ID: <0b5e6adb-b4d2-48db-90f5-cc1e66012400@proton.me>
In-Reply-To: <20240328195457.225001-6-wedsonaf@gmail.com>
References: <20240328195457.225001-1-wedsonaf@gmail.com> <20240328195457.225001-6-wedsonaf@gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 28.03.24 20:54, Wedson Almeida Filho wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
>=20
> This is a modified version of rust_minimal that is initialised in-place
> and has a mutex.
>=20
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
>   samples/rust/Kconfig         | 11 +++++++++
>   samples/rust/Makefile        |  1 +
>   samples/rust/rust_inplace.rs | 44 ++++++++++++++++++++++++++++++++++++
>   3 files changed, 56 insertions(+)
>   create mode 100644 samples/rust/rust_inplace.rs

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

--=20
Cheers,
Benno


