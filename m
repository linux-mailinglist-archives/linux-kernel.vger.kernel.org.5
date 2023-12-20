Return-Path: <linux-kernel+bounces-6798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF71E819DB8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D9AC1C22A87
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819362110F;
	Wed, 20 Dec 2023 11:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="c0ufHgqL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4B3210EF
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 11:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1703070724; x=1703329924;
	bh=UKGOEKAEiJbfDf+g0US9elwS32PxzMQuvGZA26uCeZA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=c0ufHgqLIygEzjmZuUxn8rhv8aX6otFq4Yr2fsqEOqvw4TimXi+2vo+ptC7D+T1Uk
	 tJthwI4+H0X4rKy2qjJtUn4az5+TX4370sVdcfyG3LHr40ZjEPh1lKhyhimFt8JsFM
	 Tqmy/HOceiXeyb/wnXVM0HrsJzoWHy/MC/M2nXf/uaBczBLP8TWcXv8LZWHx6H6KB9
	 Xf3/x6FEJcwSE72MI4A6xS/jmSqaIQ0DfextKd4+Y5JTFi9L0XGA9Akg7VThSDYmuR
	 a97kqI4U+8E/t6ekb5C5WKxSXb6lgDcXvO3GCsxvTnis/El6xNQWdnHy9C/qrEVQKI
	 40KCqGu/Wf9Fw==
Date: Wed, 20 Dec 2023 11:11:41 +0000
To: Boqun Feng <boqun.feng@gmail.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: Tiago Lam <tiagolam@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: Re: [PATCH] rust: sync: Makes `CondVar::wait()` an uninterruptible wait
Message-ID: <97de563e-3936-4a61-9d7f-2f504ef409c8@proton.me>
In-Reply-To: <20231214200421.690629-1-boqun.feng@gmail.com>
References: <ZXtebif2S1CyJRik@boqun-archlinux> <20231214200421.690629-1-boqun.feng@gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/14/23 21:04, Boqun Feng wrote:
> Currently, `CondVar::wait()` is an interruptible wait, and this is
> different than `wait_event()` in include/linux/wait.h (which is an
> uninterruptible wait). To avoid confusion between different APIs on the
> interruptible/uninterruptible, make `CondVar::wait()` an uninterruptible
> wait same as `wait_event()`, also rename the old `wait()` to
> `CondVar::wait_interruptible()`.
>=20
> Spotted-by: Tiago Lam <tiagolam@gmail.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

--=20
Cheers,
Benno


