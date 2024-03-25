Return-Path: <linux-kernel+bounces-118098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEA288B400
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A7651C3D202
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956CD80C00;
	Mon, 25 Mar 2024 22:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="VYNiNH3R"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1013180030
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 22:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711405626; cv=none; b=O9EFjcc0TFSoq5nM35vs18cuPN4/9U7BEwbrtcWV592rlFxhiui+NP2L3WI8UxLb3yB8aQgkMqMAxDq400DNS4qMarzUnejLFEatoVHi9CHYATu+gXKIjwUhQ9RlPuHdI6mnvAfcJdMSFepAQF02AqZWQVnR//U6l5AhO437ZdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711405626; c=relaxed/simple;
	bh=GZwKSyme3Qv/tXzsXFUJNx/0YQ7r8OnUgRcmfYjAwCg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cCvqF8FiIOy+lbbZjPfIIfKfqygJfQ4oyymy/Xt9UcaCVageJKmuXFUlfciGTZERUdDNEroMmWgxToQpXAOFZMm4wNTmrWW5wiLpxYaO0q+fm6IGMrIyMbpNeNFGiNqnlcNbMn5kYD2ylnqGwQ+ZSDZtsGUyEvgZPlGfE8nEq7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=VYNiNH3R; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1711405622; x=1711664822;
	bh=GZwKSyme3Qv/tXzsXFUJNx/0YQ7r8OnUgRcmfYjAwCg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=VYNiNH3Rx4qIPWgeuWfYLOy+W27Flh4CrflS+/NNBRirmXH7U0ZCjb0lMuBt2uTRl
	 Cdof4Uq8jvDe2Tlw/UFmc+ToI7fAfyu4B6QQsuw2VxFpdhBsYQtZPfizz8Vn1nrH4k
	 5RVmnCr/1xf57J7HFqKEgglaP/LWrkzgvadmvU1DHkOSlotOWELvE6j8yYesjVZk98
	 354z42ZnM3ml0Ygv2PsUy+wG3yrCD4QQAffcN4xsDAl8hEIUtj/gw09rlgq8wrVeXY
	 311Um/6FhbbSlJitDfFJh78e0N9uYnWqQ8MJ1p6Upb8RqxaF/yA+pVAbY3rmOZr5TW
	 v/BW1oNz0b3cg==
Date: Mon, 25 Mar 2024 22:26:56 +0000
To: Wedson Almeida Filho <wedsonaf@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, linux-kernel@vger.kernel.org, Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [PATCH 05/10] rust: alloc: introduce allocation flags
Message-ID: <lD6nFi45lZHea8jd_AG2CbXQg3xE9XMBaCTLdqJQxj8JcezXEOmFET0HDFrprPSUoBFkwfZl5kuIsKZncg8E5zTM8os99A551s2avkJuvxw=@proton.me>
In-Reply-To: <20240325195418.166013-6-wedsonaf@gmail.com>
References: <20240325195418.166013-1-wedsonaf@gmail.com> <20240325195418.166013-6-wedsonaf@gmail.com>
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
> We'll use them when allocating `Box`, `Arc`, and `UniqueArc` instances,
> as well as when allocating memory for `Vec` elements. These changes will
> come in subsequent patches.
>=20
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>

--=20
Cheers,
Benno

