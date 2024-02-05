Return-Path: <linux-kernel+bounces-52593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F94D849A0F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CE5FB21E8A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4A71BC3B;
	Mon,  5 Feb 2024 12:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Lp0NO2ad"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA821BC2C;
	Mon,  5 Feb 2024 12:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707135982; cv=none; b=hMiCMd525cWq4x6ThRZ96a1t8GHCDx3ruraanpQ20/9nB639nkwqfK/+sF4qMDhhb5UChWQ+FgW5igxpUAZtYwHmdxjs7P9SLXqx1YmakTG1n0sWtpAHfnzRQRipqrxwP9lSvedKYiw4GIVSqnSzVi+06AX7eMvOOVR737DdiCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707135982; c=relaxed/simple;
	bh=/xDr2MMgZ1sU+0+C1G8hOoShIrpAzIc2K1W6rt3nwiQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gQIx30xJei0xs4mejv4zvzxIMjRmkUKn2J2xSzdlBWC7BLWBU6cex2zMT/JmAw1JBgdN9TzcBdDraAgnL42mdEL9GOxhq99py4D/Q0p9FDhEC7a53mV3oBTrMRi3UpENY2fZUiHgn3yKYJQDZR/FhEjA9bW2X6sXWEIsQhz+avw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Lp0NO2ad; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1707135978; x=1707395178;
	bh=zMhlP+q1kZ1xhMQog/NNGaxk6WwJDjlG0eyf33U/c/E=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Lp0NO2ad2V/bWFKm3w+78eiB50SUqsZZzmvW3DGIJBCy0Ra5ThkKxPW3FTQo0D3Ev
	 9kW9s6GPvyReAOjQtBuPFv0+0TbdyVXEwYhAfpPpWy4H4H6Vb4y+hpCSXZsBGCNYkG
	 80j7GfsFXjTOzu4lmbODDLEvFPGpIQBIj5jaS1sqh7PdzR3QKHDxfjM6MaYvZfvJD8
	 KQzJkc1pvC+iu7F6GQASp4hzgxAyC4XrH0jgffzsTdEM7HhaXt3qsgWtSAua9oLm/+
	 UzZ4mXaj+R6lOi/Z6TfD+Gfuhzpsczg2hOH1RtOTE1FGS+KOU9ugY64aBDPF7AkpRU
	 SPRnxxoW0PE4A==
Date: Mon, 05 Feb 2024 12:25:58 +0000
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Wedson Almeida Filho <wedsonaf@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: stop using ptr_metadata feature
Message-ID: <b871d79e-0f55-4dd4-9f8f-7d84791440fb@proton.me>
In-Reply-To: <20240205091842.2858516-1-aliceryhl@google.com>
References: <20240205091842.2858516-1-aliceryhl@google.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/5/24 10:18, Alice Ryhl wrote:
> The `byte_sub` method was stabilized in Rust 1.75.0. By using that
> method, we no longer need the unstable `ptr_metadata` feature for
> implementing `Arc::from_raw`.
>=20
> This brings us one step closer towards not using unstable compiler
> features.
>=20
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> This patch is based on rust-next because it depends on the patch [1]
> that upgrades to Rust 1.75.0.
>=20
> [1]: https://lore.kernel.org/all/20231224172128.271447-1-ojeda@kernel.org=
/
>=20
>  rust/kernel/lib.rs      |  1 -
>  rust/kernel/sync/arc.rs | 10 ++++------
>  2 files changed, 4 insertions(+), 7 deletions(-)

Good to see this!

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

--
Cheers,
Benno


