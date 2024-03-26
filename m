Return-Path: <linux-kernel+bounces-119104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABE388C437
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E74CB22E5F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB6576022;
	Tue, 26 Mar 2024 13:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ghr8XxPr"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCCA7440B
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 13:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711461522; cv=none; b=nwMTv42Hu+D6Mb5nW6QWDOUAu5BP0/sDSKfPeY/uuTW8lVEXChXbvdkUh36op9HilvbXLLlia9G9FeOIxjtyYBuYY2nTdNthx5P3lNg6EoDOxrOcm0wSErhxyAuSArrk3Y53SJzRlS1hQ7CPvv42qPtXNnwPo1d084+f316tjdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711461522; c=relaxed/simple;
	bh=zKa4/45e9odHjxrpuei7T8kQZfCmORh48encO6ZwDXA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o4wxmpB0OvVxk20LqK4xyuWcwd+rNG3NH32wyp9lCY2SJmNixrXM820CbOxhTSdFUXwobJ3ObCl3OEbabpoM9cuLk5H0217M8UeYZEivRY3V3XOx9o0avABCqbBK5p3eYtWU6e39Awib8HRCxJQ9jCk/D7be7vl6RIqKrVGDt10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=ghr8XxPr; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1711461518; x=1711720718;
	bh=qtEBAIBIYK65CQa7Za5xsfAYMGv1McPLumPTs6claeg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ghr8XxPrelWouWgUrziU85wQJAplgbqyXXWDYwZytG4/i4HzAQxjYzYr9ghQ0E6Wr
	 ovoUPMACwUzwkEpYtcV2bNHWqOuYJ53npXv4O0CjbA3hOk4jnPfcrI2eb+ej2kOqpB
	 amsvKjQaEnFlRKXfatWy1db8T21Ba2Y5mXe5l60zeF1jU2MARIKjFbZ5PwIqCCu4ay
	 MKhSoJHLPxwQZVHZ8NoiDoRHGbHnPy1rTz+naUDn0JExRIkIco9dGDjyMXXqWLWIOG
	 wJeeeptdHy6SBfbha2hLSSaf/n/YVsoXpbJ7fjEaGlnHw4q72TN46cokaIkx5e5eat
	 +aMATUl4Yrs4g==
Date: Tue, 26 Mar 2024 13:58:33 +0000
To: Wedson Almeida Filho <wedsonaf@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Boqun Feng <boqun.feng@gmail.com>, rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, linux-kernel@vger.kernel.org, Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [PATCH 07/10] rust: alloc: update `VecExt` to take allocation flags
Message-ID: <L8Btmo6IhqMHoSXiTDQ-avI42EPw1WUkSiIshVgNZ4gvBZJEYkNL2Ag3hQ0dLEwF_c1FnLTG1rY9G4UTHAbRvxuAxiN-Dk5vGryaNvKD450=@proton.me>
In-Reply-To: <CANeycqpRfgTof1QeX4NnTV5NidEHxYCan7rvEw+T5nRyMDD9oQ@mail.gmail.com>
References: <20240325195418.166013-1-wedsonaf@gmail.com> <20240325195418.166013-8-wedsonaf@gmail.com> <ZgHiJ23TdOmnSGe9@boqun-archlinux> <CANeycqpRfgTof1QeX4NnTV5NidEHxYCan7rvEw+T5nRyMDD9oQ@mail.gmail.com>
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
> We also rename the methods by removing the `try_` prefix since the names
> are available due to our usage of the `no_global_oom_handling` config
> when building the `alloc` crate.
>=20
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
>   rust/kernel/alloc/vecext.rs  | 106 ++++++++++++++++++++++++++++-------
>   rust/kernel/lib.rs           |   1 -
>   rust/kernel/str.rs           |   6 +-
>   rust/kernel/types.rs         |   4 +-
>   samples/rust/rust_minimal.rs |   6 +-
>   5 files changed, 95 insertions(+), 28 deletions(-)

With Boqun's change:

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

One thing that we might consider in the future would be to create
our own `Extend` trait to allow extending a Vec with any iterator.

--=20
Cheers,
Benno

