Return-Path: <linux-kernel+bounces-6804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7392819DC9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72329B24030
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B6221363;
	Wed, 20 Dec 2023 11:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="fr3wvUuR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E18C21346
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 11:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1703071001; x=1703330201;
	bh=AHEwZCmY/Zfr7myDOFIbTRHugY04FkfLKVuXC4pRExo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=fr3wvUuRDUzm+7gUByQScgV9ATDIz8BUobKA0OBXmEE3dHb3In6D0CveSzvaRaq3y
	 EwZzyxxqynkhwRIJNgNAtGyufPLgKqFWyKU7dsZiOknNh9CoEGPiSNyQGb1rCrXSGr
	 c3HDDhkywV+QLSdB5Os20FnQdjBQIZTuASsM0WCe4h/ezRuIycAT+cJ4UZEJcIi2Dz
	 9rx/D79vhVGaNPoMk+FumrCOwA5PQC4qkmZamfmFZzM9B/2yvORoSPKW+mEkUEqrtl
	 aVGtZVrKYc4/YBw4R7hf4AN9WlvXiYNKOx/UqdxiVr/VBxsxy8ChTL6DHFwvGgLOy3
	 DxykXhB4DhU0w==
Date: Wed, 20 Dec 2023 11:16:22 +0000
To: Miguel Ojeda <ojeda@kernel.org>, Wedson Almeida Filho <wedsonaf@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH] rust: upgrade to Rust 1.74.1
Message-ID: <98aedb6a-bdf5-482a-b063-8cb8bab49874@proton.me>
In-Reply-To: <20231214092958.377061-1-ojeda@kernel.org>
References: <20231214092958.377061-1-ojeda@kernel.org>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/14/23 10:29, Miguel Ojeda wrote:
> This is the next upgrade to the Rust toolchain, from 1.73.0 to 1.74.1
> (i.e. the latest) [1].
>=20
> See the upgrade policy [2] and the comments on the first upgrade in
> commit 3ed03f4da06e ("rust: upgrade to Rust 1.68.2").
[...]

> Link: https://github.com/rust-lang/rust/blob/stable/RELEASES.md#version-1=
741-2023-12-07 [1]
> Link: https://rust-for-linux.com/rust-version-policy [2]
> Link: https://github.com/Rust-for-Linux/linux/issues/2 [3]
> Link: https://github.com/rust-lang/rust/pull/114201 [4]
> Link: https://github.com/rust-lang/rust-clippy/issues/11219 [5]
> Link: https://github.com/rust-lang/rust-clippy/issues/11431 [6]
> Link: https://github.com/rust-lang/rust/issues/117976#issuecomment-182222=
5691 [7]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

--=20
Cheers,
Benno


