Return-Path: <linux-kernel+bounces-102631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D709587B51C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 00:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88D9A285300
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 23:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD175D488;
	Wed, 13 Mar 2024 23:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="fTo9IO2q"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719115CDE1
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 23:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710371409; cv=none; b=HPMGMTWiABzJN+OrkPZBNZW8uTO5aBmuQX6d6KOyJPho1QCDEtT3BzQGn/LfoPDos3KMxYgYNobBV55V6oSVuXirmR6gCVa4Fx1QKqjez0uaOCNMJA8lR9TgD/c3gCF53Sk2fAw/QlAARi+QcPMB1n6A5Pe5jpr2d4AUgCWfRRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710371409; c=relaxed/simple;
	bh=kdHGNf15Fkji+Yncd0qKZLXXXshvhJrNdSwpkSrHW2E=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=i8gCEcbKro5Jt0PiPUVRbX7aqhw36G6aPB+HOg5duUmdLRI0YZacUDu/D9i355B7LrLST78wV0ylaJmLxzjgOxJTSsNpfxB6vNk1FiVtV9NqSWUbZcUzeIyYPyWR0zUh2+FcJMmNm7sWznUdvelZCuybokUlfRxuTH8jolYAllk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=fTo9IO2q; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=3qu2niw75nb2xbjezbisjc3dce.protonmail; t=1710371398; x=1710630598;
	bh=rYZPrBzSjkyRIMR5GIwY/KAK6jPdoSu7grZu7ns8X4Q=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=fTo9IO2qtRKJE1X29fMuTUGTtSPKC1Y/lyivka8OWJABM8Bpd764HMOCR/vxeW14V
	 zRJkNTTeUe7eHXqgM5qKGYS8Uhm/UbJbRFPOa6CbeBdO0ATMw2WB+UtCiDBTp8e8YH
	 0m05TS0wYo+qGfDNZXJM1Ic0RKKgmJszbR4TXGMqiSZ3uYrAXU/y839sKjLmDMZrbG
	 64VvCO3nt9XSKT3ZRLQvua04GOU8o+G59eGJ46X3azCa5xo3rPTKnNjww8WzpUqFXe
	 54UOdOd/L2el/nKQuZ96+hDYefQj+UIJEDJgICx2rEvmccewi0z3ks832LpCQmb/Cl
	 ZryR0wOx3uSqQ==
Date: Wed, 13 Mar 2024 23:09:37 +0000
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Laine Taffin Altman <alexanderaltman@me.com>, stable@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rust: init: remove impl Zeroable for Infallible
Message-ID: <20240313230713.987124-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From: Laine Taffin Altman <alexanderaltman@me.com>

It is not enough for a type to be a ZST to guarantee that zeroed memory
is a valid value for it; it must also be inhabited. Creating a value of
an uninhabited type, ZST or no, is immediate UB.
Thus remove the implementation of `Zeroable` for `Infallible`, since
that type is not inhabited.

Cc: stable@vger.kernel.org
Fixes: 38cde0bd7b67 ("rust: init: add `Zeroable` trait and `init::zeroed` f=
unction")
Closes: https://github.com/Rust-for-Linux/pinned-init/pull/13
Signed-off-by: Laine Taffin Altman <alexanderaltman@me.com>
Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
 rust/kernel/init.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index 424257284d16..538e03cfc84a 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -1292,8 +1292,8 @@ macro_rules! impl_zeroable {
     i8, i16, i32, i64, i128, isize,
     f32, f64,
=20
-    // SAFETY: These are ZSTs, there is nothing to zero.
-    {<T: ?Sized>} PhantomData<T>, core::marker::PhantomPinned, Infallible,=
 (),
+    // SAFETY: These are inhabited ZSTs, there is nothing to zero and a va=
lid value exists.
+    {<T: ?Sized>} PhantomData<T>, core::marker::PhantomPinned, (),
=20
     // SAFETY: Type is allowed to take any value, including all zeros.
     {<T>} MaybeUninit<T>,

base-commit: 768409cff6cc89fe1194da880537a09857b6e4db
--=20
2.42.0



