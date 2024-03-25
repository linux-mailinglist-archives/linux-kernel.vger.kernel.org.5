Return-Path: <linux-kernel+bounces-118094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6B688B3F6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D52A61F657B0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6C37F7DD;
	Mon, 25 Mar 2024 22:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="FmR5WWpA"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB74F1CAA5
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 22:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711405481; cv=none; b=Jmo7SJ+uPCFfAZNT2ENBHpYmTPoFJhm9pE6GWxT0nz5F0gPt7LglCt6zXdiwDVzMNLaAnbfVDnsHYV1HLfacUGJkgSERAmckYRzRA/gIKGbapNsuSOAx9J4KIuvz9IQJ+1q/xFBwuFojuYZpN4IDZEuyzp2pEcPyzunt70qThHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711405481; c=relaxed/simple;
	bh=qUf/lMSFpgM0OC3FLLVNDJ1XXx/LnvanuJ2KlOt+NpY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JiGnl/9MrrK/5FMkzz0VFiSxKPCoz55Q2Rek2SLiKzUmXWFSulr5QirycSl8dFRgC1HGktWmFKbvpLkUUGBTXlJwNsk9AC62mbwTgKb9iZm7DBklQmS1lPCVdYUtLWSLzjjWHMvR/CEWrH9xQu+5tLKOIwOjmHnN5L2gPPuoucg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=FmR5WWpA; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1711405476; x=1711664676;
	bh=aWrPyMoWRF/FgF4vWS28ZEGuUYCg1AOjVlZZ0z+Ar/c=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=FmR5WWpA+o96aczwdkg7XsKnr+OTQHtJg7NUcSFnY5nnl8emjH6NvP0exW0ZnleOk
	 ZFmd08um2plFm/fLPmV9ojikLkHo+Gm5MybYvhibbcESKYAsIX8Lg31E0QNpYXxiAq
	 0sKYrxWU637AMzJmUa7ovPbh+qccQQWfioSVzujtSLDX8MDk6fTaYHxjXL3BLlgSAS
	 uXZFw6T6geRStSTKQfpLwD8v/u4FyQ/I+FW6mllmOKUpgU38aLECU1Q3K571gegmqK
	 KHZdFVD0m5IttqO+qARPFGJt7YOdUr7OcBVinnF7WtKgRtF9rcqWIBJVfJQns2w13Z
	 Lzboy2KWUQRag==
Date: Mon, 25 Mar 2024 22:24:20 +0000
To: Wedson Almeida Filho <wedsonaf@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, linux-kernel@vger.kernel.org, Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [PATCH 04/10] rust: alloc: remove our fork of the `alloc` crate
Message-ID: <B_2mY6rCanHqb2TTjBPjW3caOJDXHH47O96PklhDUac3opxQSIf7U5O-neiOPYIX1gYGt5hPvrkj8oGAyDkeotYKYiNYmSxnQ7A3rmlZS7c=@proton.me>
In-Reply-To: <20240325195418.166013-5-wedsonaf@gmail.com>
References: <20240325195418.166013-1-wedsonaf@gmail.com> <20240325195418.166013-5-wedsonaf@gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 25.03.24 20:54, Wedson Almeida Filho wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
>=20
> It is not used anymore as `VecExt` now provides the functionality we
> depend on.
>=20
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
>   rust/alloc/README.md              |   36 -
>   rust/alloc/alloc.rs               |  452 ----
>   rust/alloc/boxed.rs               | 2463 -------------------
>   rust/alloc/collections/mod.rs     |  160 --
>   rust/alloc/lib.rs                 |  288 ---
>   rust/alloc/raw_vec.rs             |  611 -----
>   rust/alloc/slice.rs               |  890 -------
>   rust/alloc/vec/drain.rs           |  255 --
>   rust/alloc/vec/extract_if.rs      |  115 -
>   rust/alloc/vec/into_iter.rs       |  454 ----
>   rust/alloc/vec/is_zero.rs         |  204 --
>   rust/alloc/vec/mod.rs             | 3683 -----------------------------
>   rust/alloc/vec/partial_eq.rs      |   49 -
>   rust/alloc/vec/set_len_on_drop.rs |   35 -
>   rust/alloc/vec/spec_extend.rs     |  119 -
>   15 files changed, 9814 deletions(-)

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

--=20
Cheers,
Benno

