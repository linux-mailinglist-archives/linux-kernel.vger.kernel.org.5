Return-Path: <linux-kernel+bounces-97894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B7487713C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 14:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85C6C1C20AC8
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 13:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7A33BBDF;
	Sat,  9 Mar 2024 13:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="HG3nX1K+"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679ED2C853
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 13:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709989452; cv=none; b=ii+JcoqCFJYRpFHgMseAaNjoFSfWyhxJQhRAJmJ0ATb7Y5UIQQUxajFTwHimq/NrQuY9hC15v8BLgSJV9bjws8/LROjfUkQ+Comk4Ccun4efpNzukgrNtdCl36yQY3bR3mXCFRVqb1d5xUUCJi1YJm+n4gjS2+m/BIwvegmORzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709989452; c=relaxed/simple;
	bh=EUv3cSpiLpsQFBKG1Yjm3U0IIFrHPhV6nt4DTmzqRPI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aT+gm4tkmWVRZeSkduQAuNEvFhiGovo66qGPaaZ5qL2/ZE4Cj0Txflv/kplY3UVwHYE4UOkT/ATU91ZK5XIASafXC665qryVXVOD/H2P7R6uI4quPTXbM9/FoU3lxRVQndChdPkVp+jnTJ3KNW1sEI5p/iY41EHW42hHl1mWMHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=HG3nX1K+; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1709989449; x=1710248649;
	bh=EUv3cSpiLpsQFBKG1Yjm3U0IIFrHPhV6nt4DTmzqRPI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=HG3nX1K+05JUq9ePBatCJW6WRfu+0Hj0C7yqd3UFtOoWZGYRQbL4HDeTPuvKHnSeU
	 fa7YPt1mSSpSsMNYKexkU1+k30VfR+gz0dC0lITe7QJ52W1ygIqnYjnWsTDm6TbdvA
	 obRoGuytIVIzJCFdp08RK9Bldqlbe1l2B8aPycIG+M/eHb4EE8rQBWtrav8ATL7AM4
	 WXz7KIF3Gk/8keigIxHHm3pwtmbuncPDA6weX8p2aKnErH3M8Kfl7gW/sRZLJNPKJS
	 zL+JfXkj8stjdVqXE7DWhh6R/eJHsnf2l6bcI9me3xSrr4wr5a22HRRaC2+wmRqQeb
	 V3ix5xqrrGnRw==
Date: Sat, 09 Mar 2024 13:03:59 +0000
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: add `Module::as_ptr`
Message-ID: <d1890bfd-7d0a-44c5-af14-5228071ec45a@proton.me>
In-Reply-To: <20240226-module-as-ptr-v1-1-83bc89213113@google.com>
References: <20240226-module-as-ptr-v1-1-83bc89213113@google.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/26/24 10:44, Alice Ryhl wrote:
> This allows you to get a raw pointer to THIS_MODULE for use in unsafe
> code. The Rust Binder RFC uses it when defining fops for the binderfs
> component [1].
>=20
> This doesn't really need to go in now - it could go in together with
> Rust Binder like how it is sent in the Rust Binder RFC. However, the
> upcoming 1.77.0 release of the Rust compiler introduces a new warning,
> and applying this patch now will silence that warning. That allows us to
> avoid adding the #[allow(dead_code)] annotation seen in [2].
>=20
> Link: https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-2-08=
ba9197f637@google.com/ [1]
> Link: https://lore.kernel.org/all/20240217002717.57507-1-ojeda@kernel.org=
/ [2]
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

--=20
Cheers,
Benno


