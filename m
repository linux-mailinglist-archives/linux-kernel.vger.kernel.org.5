Return-Path: <linux-kernel+bounces-121685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE2888EC69
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24BDFB267D8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36B914E2D0;
	Wed, 27 Mar 2024 17:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="M7DiNKHh"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754EF142E9E;
	Wed, 27 Mar 2024 17:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711559977; cv=none; b=i5TDR3f9NtP6YgSFIabLtJfDR3c336zRRmGSdQKztI5HsDwBacgc5rWDXzxCRPHcJ9BUbbfRuXLz3sLyV/KKpxzcLqXeFh3hwUFwRj3lRkbxOexBV4mpyrGOIMPOoVl+eqSzb0PcHx8T7XHZCCXYuYgqD6rMQ5bAy5NAHM9JtaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711559977; c=relaxed/simple;
	bh=vW/fn6mQ+wneRUrK9ujviuMwS68Wl2uzvxICsdaE1/Y=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GsxOgvGwwwXm9u9jdtR0Z719utmjQ8tjTXHMtTJtjtldX+UJKwTnYdsQJrc4MzfqGVwCgmi2kC5H7P0v5A/EhCeSZFng4VB9CZ1bzq5F5PHfQOULBBcVvG7PZYrIuwchc1azVERSrRblQGRkwv7ydiicTf28dmk4Ot8xf0JOo7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=M7DiNKHh; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1711559967; x=1711819167;
	bh=9yeamnTtlGMFiwRm9eAhzSWJ4rgq+GQc4yS+VkqJV54=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=M7DiNKHhRDwvW2mw5s/WA5ijTQbGWlC5wqJB6pWy0kXkZos+F4zQ/RHAhpaHN2byo
	 V8/C3iKXwS2Jf3S0a6Q9va9Jus15nLvs/OUNkHr034LOQpLfjMD/7GyfbBn3h1B0qE
	 pPJEXGMg1dbBiI/mwGO6dwjcnhjehnh5X4Y7PMkaV8qpzLxfCYnr87KUUMorhJzCBB
	 1vWG5U3xLGun5KcRaVYOzlRIhweImbtoJhwr7QSw7YyXpyCkVtuYaajubeQwvZY4kf
	 0/djXcZFYcwwg70mcwi1nwIV+dpYFL5rIW4k6oj5LLYWkGQTyGvC1+Hxk7xLfpOtih
	 81Gq3rsVlB+Og==
Date: Wed, 27 Mar 2024 17:19:18 +0000
To: Wedson Almeida Filho <wedsonaf@gmail.com>, rust-for-linux@vger.kernel.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, linux-kernel@vger.kernel.org, Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [PATCH v2 10/10] rust: kernel: remove usage of `allocator_api` unstable feature
Message-ID: <2b148cfb-0557-46de-b39f-f2506eb17afd@proton.me>
In-Reply-To: <20240327023531.187880-11-wedsonaf@gmail.com>
References: <20240327023531.187880-1-wedsonaf@gmail.com> <20240327023531.187880-11-wedsonaf@gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 27.03.24 03:35, Wedson Almeida Filho wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
>=20
> With the adoption of `BoxExt` and `VecExt`, we don't need the functions
> provided by this feature (namely the methods prefixed with `try_` and
> different allocator per collection instance).
>=20
> We do need `AllocError`, but we define our own as it is a trivial empty
> struct.
>=20
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
>  rust/kernel/alloc.rs         | 4 ++++
>  rust/kernel/alloc/box_ext.rs | 3 +--
>  rust/kernel/alloc/vec_ext.rs | 4 ++--
>  rust/kernel/error.rs         | 4 ++--
>  rust/kernel/init.rs          | 3 +--
>  rust/kernel/lib.rs           | 1 -
>  rust/kernel/str.rs           | 3 +--
>  rust/kernel/sync/arc.rs      | 4 ++--
>  rust/kernel/workqueue.rs     | 3 +--
>  9 files changed, 14 insertions(+), 15 deletions(-)

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

--=20
Cheers,
Benno


