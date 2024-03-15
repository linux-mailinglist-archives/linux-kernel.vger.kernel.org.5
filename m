Return-Path: <linux-kernel+bounces-104368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F6287CCEC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B56FC282D05
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F031C680;
	Fri, 15 Mar 2024 11:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="af59ePWn"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FE21C696;
	Fri, 15 Mar 2024 11:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710503278; cv=none; b=V0gHG4s+mu5VP4s+HtFWZxLbM1BnaIxjgGhnTjJh1Lf5fAnfYvKcWCaYFWMvET/NDUIIhl3uYNTPSd1OWFDzVImmdyFt4x8vMqg1guYSaN/tKx02hIuHOHgLbofKSXGP8oW5wN6hPz1lHuZKk3XEhfEXlg+5yGMa/QrPnHjw2L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710503278; c=relaxed/simple;
	bh=DIdRQO9TomTqaIppjsY3vBeLiORYCIQp/cqE8Gy6rSU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J1sNOlCFeOq5Y8rrC4rNr+VLhtyfZyrHU+Wc84NGF/y7lqd03gmtcgMj48wpuDtg+donULnXd3SaLqR9bUP/RrRDnCRilLTyWf0iveCorN1Q1MWUlO3voZ/tp2+J3AIHLP6frQQhNySlfpKuJfZcXQYVNLtQ7xvp8HWU22a0y18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=af59ePWn; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1710503270; x=1710762470;
	bh=DIdRQO9TomTqaIppjsY3vBeLiORYCIQp/cqE8Gy6rSU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=af59ePWnDHD5CkENDFXlGwJHEGBodI2k8rc+F7MzCWlhRTga6dWCAJCHEsfxdPP3l
	 6jUZcVBAz6tHDHAVhd+QKD2xaJFRF+gQq8dWGkHEBgKs4V+Gvra+cKtuegoYKjtDUp
	 XUGqr+H7oBZZXpbO/afI6jTIcOVdnJCEW/aC0Z2h1I2BQEscTEXq1iFldzKKtyaWpY
	 X+vmL1MUhimIIwDrDk3HQspw2IvmYLQmvQNLJ0XULPXF9goIvkSHWPXoU/k4bICq8k
	 O7UHvf70Ar4ON6oZX2DLZmQ/AIeMZqi9/YCKJX1D3HQfmJ+jgcMr2VM62fLRmGJEzU
	 +sGy2W1WpPBnA==
Date: Fri, 15 Mar 2024 11:47:41 +0000
To: Danilo Krummrich <dakr@redhat.com>, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] rust: str: add {make,to}_{upper,lower}case() to CString
Message-ID: <bbc7cbfd-9b56-471e-8fdd-c027363cea2b@proton.me>
In-Reply-To: <20240223163726.12397-1-dakr@redhat.com>
References: <20240223163726.12397-1-dakr@redhat.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/23/24 17:37, Danilo Krummrich wrote:
> Add functions to convert a CString to upper- / lowercase, either
> in-place or by creating a copy of the original CString.
>=20
> Naming followes the one from the Rust stdlib, where functions starting
> with 'to' create a copy and functions starting with 'make' perform an
> in-place conversion.
>=20
> This is required by the Nova project (GSP only Rust successor of
> Nouveau) to convert stringified enum values (representing different GPU
> chipsets) to strings in order to generate the corresponding firmware
> paths. See also [1].
>=20
> [1] https://rust-for-linux.zulipchat.com/#narrow/stream/288089-General/to=
pic/String.20manipulation.20in.20kernel.20Rust
>=20
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Danilo Krummrich <dakr@redhat.com>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

--=20
Cheers,
Benno


