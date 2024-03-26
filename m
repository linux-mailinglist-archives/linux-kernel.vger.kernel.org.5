Return-Path: <linux-kernel+bounces-119492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E94CF88C9A3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A54023274BB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6161310A2A;
	Tue, 26 Mar 2024 16:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="gHBDUKqh"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164764A0A
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 16:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711471498; cv=none; b=dqjZxaxQbZD98W3k+csZ85fFkhaHw+dKmbBU2S7xV7ivN+qn1PLVt2Es7ndy9YonCwoRbRa7Ovpwob5flMKCC3fssURj2j336u1t4DfLOktsjJ6oEkEP/Sqf5CdZ+nPLW7dWCVyTXQyjS9BzHpal+zX1QSwwuKdUPPlkS4TDAZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711471498; c=relaxed/simple;
	bh=1gQH+2tZI8zwQ2qZlk46RPoabx1vjeQhTZKr99UHtyQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VAvXkfdzMQFQOMZqOSbKh2KF1hUnNd3B6vWDh4G/ZddTZOm5bD5+im/P2sXbEbu0wCCyaJJtg+OZjmKagfFjSVaJqwtbCFEdlhdQjg3orqIZtW8HJTh0yH5ff1McHeO9CvqaaQlwlYOQ8t5LMYR610K4Mmgq/8aD12HlcGiQfzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=gHBDUKqh; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1711471489; x=1711730689;
	bh=eb4Uog2nSYqmvOmyV3gi+b3HfJY/4XsgBHX4glybeyU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=gHBDUKqhfXSah1+a6Em72Wqhfn+3I0hV3j37Y5byKFz60Ojn/V3xTLQZBgTRgom8y
	 LEg3YAmzpiut9WAgJpOrlET9jouisBVDSiWdaxNM1YJx7LOJFaFYT0vs7+sRDiK0c0
	 WSiEl/ToA57R6eSCeATVvwsWe0DkTo+3Sj11uo+0rdWM+ogcaMZdj+RCVo8DdUVBE2
	 TS/GTrble6IjCqAVp+9rvZKayGV35LfbEPX6MihxBtkPNZB9HXLg5moqxEdqKt7SIo
	 QLdmgEgbHvKWJyDk/xK+st6XcJeQ6SjmcPtUmd1sM1T6TOsGQJr4yUSt0HH+j2B9Bm
	 C7DJnD0nkyIWg==
Date: Tue, 26 Mar 2024 16:44:39 +0000
To: Boqun Feng <boqun.feng@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, Valentin Obst <kernel@valentinobst.de>
Subject: Re: [PATCH 1/5] rust: time: doc: Add missing C header link to jiffies
Message-ID: <u80hyBY_r8f0yDIURNlC7D0gy9PPC7AsAaHKJICX4JK-rZGaU3g0hSmn1ok9wh9KZxeYbcnbuB9A9cSRcy_ubr5tkeesMYuTw_UuXoIZgF0=@proton.me>
In-Reply-To: <20240324223339.971934-2-boqun.feng@gmail.com>
References: <20240324223339.971934-1-boqun.feng@gmail.com> <20240324223339.971934-2-boqun.feng@gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 24.03.24 23:33, Boqun Feng wrote:> The definitions related to jiffies ar=
e at linux/jiffies.h, and since
> `kernel::time` provides the functionality dealing with jiffies, it makes
> sense to add a link to it from Rust's time module.
>=20
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>   rust/kernel/time.rs | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

--=20
Cheers,
Benno

