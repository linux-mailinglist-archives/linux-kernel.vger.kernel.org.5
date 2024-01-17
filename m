Return-Path: <linux-kernel+bounces-28393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A7982FDF4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 01:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A231B249D1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 00:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B848BF9;
	Wed, 17 Jan 2024 00:16:47 +0000 (UTC)
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B653B8468;
	Wed, 17 Jan 2024 00:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705450606; cv=none; b=c24HrX3yuz4SofgVTMt9E8GhRSSuayoJuicx2GnYfa3kuusn8u0jJNKyydHGxsvJf05cYtXGCS2UdDWpMQGvwA0abf4ldKBqt32uQJ+AoiWeAv3fVPWVY5ZjNn7ao/4h/ysIf85I2cjMky9SdAqtFFKRGYqKp6SNIk5j5AQUl6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705450606; c=relaxed/simple;
	bh=hvWv/gsA+1XA5/ae14NG4bJ38X5ybqAzDv+NJAAUJFs=;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-Provags-ID:
	 X-Spam-Flag:UI-OutboundReport; b=cwvrSLSkY4nSdNvt7ugnaTLNycZ8DOd6k79Dr/oUEs8cJYzUeCmT0xEAYOfIPFiLn9j3KAPdhAo0GZ1+vHh+HlTWLWf2Qis+VAE9rX/K4qoz9yGz3o4JxPwAB2e+R9y7g73DDT/dtzkmBNaEA4c5hK61LRNWceBfmgPLhpCldRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de; spf=pass smtp.mailfrom=valentinobst.de; arc=none smtp.client-ip=217.72.192.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valentinobst.de
Received: from localhost.localdomain ([217.245.156.100]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MQdI8-1rkIGR0kJ4-00NlUi; Wed, 17 Jan 2024 01:16:21 +0100
From: Valentin Obst <kernel@valentinobst.de>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Valentin Obst <kernel@valentinobst.de>
Subject: [PATCH 13/13] rust: locked_by: shorten doclink preview
Date: Wed, 17 Jan 2024 01:16:13 +0100
Message-ID: <20240117001613.169177-1-kernel@valentinobst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116160141.165951-1-kernel@valentinobst.de>
References: <20240116160141.165951-1-kernel@valentinobst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:P+Wtzs9yqXIZYrvFo9hsAvAB2lek5+pAfAMb7c47Q2gbxEq9JQw
 tZqu5SlmeG69/pBfzK+Ywt2boBTUKjUq/8PDGTdyMbiXg7r7cNU6ZlQYUgSA14R7lUTSVu7
 hvLtW6AuECZTB4xDT0D01Iln4xKsWVEeEQdehN6p2+XAupqh0LTaHEGs5tUYWCLq95yMFBh
 Coc/vrsct7Ow/R0/4SM/A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dsSEASkNAtk=;LD2yuxK41OjMV0sSEd4SU39P4y/
 OxIG8uPb5vZNU/rpA/U6b+YJw2QI4njvG3acQ47b3Kl3hidgYYuftWvO8hJoBkLSvzQlSMq9k
 27EBcoOAShXtSGuMFynffFK8rNZRX5KYOlmraaO/1J8/YOteBQeHimF7mz9quakj9pD7nGkYN
 KpQLL/gY5mOXnugxEVfRif3JGdPyZl/TcIfl2ogvURVcRGGBNDRFY9eqCARwoAIlKHtdMxHkb
 dY/rBbo3o4U+wuMADJT2VS5VWXzXqDL70WMl37D1BBMAjEKuA22vB0rUUsnM85lqrISmQuOaq
 ML9houAAZMW0il42Zw54SmVRMVtqP2o5qXLv+DbR6mx/GLdDnobhXtCaNzLKrIcUwtS7vZVRp
 QoG41zntmEaKBgkgt19gukKYKQcM/vphyLpPCi9F9dmbK4ivUGIK5mIGYyTYc7D9QotRtUjEj
 49EGuYOVFj107ooTaGyiqmvaUYvUmja82EnryQua2nuIbqWC3gHdoIYeQ3IwCMGUm/y2biEMS
 gl8jzHy+KSPyPPzb6pjS+BUGNncGzELzItuP7F1yJKcTJXpXIQLcJUzn1YhULqbdeRPn7ZvmF
 oHtDu6hw5aSK2bB+Sjwm9dlHuCjguH2gEniBoyWC9uhOK6X2fyA1qV3NkjhkKO/vEecOrM/XQ
 gZ3IReFIBCcnGNzorz8EfgQAcpkj1JUrh3z3sqNEI7mjBXr/i99ErjQoSOs9LA78YlH4tvd22
 Lk1SAoFl7BrZZFOrCLgZxZckzNcD64Syma1EAmgRK5KyQKMuVM9xo6oX+4wSkfP1JO9IwJkcl
 pwP5rt3eo4i1326GkspBxuCDsVFPNzyQ1fW6S4+kl6DIe6eW9FD2aFo6zkWagwlqqZIybHiog
 0HYV/lU0w7ra7jA==

Increases readability by removing `super::` from the link preview
text.

Signed-off-by: Valentin Obst <kernel@valentinobst.de>
---
 rust/kernel/sync/locked_by.rs | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/sync/locked_by.rs b/rust/kernel/sync/locked_by.rs
index b17ee5cd98f3..22c38993bf63 100644
--- a/rust/kernel/sync/locked_by.rs
+++ b/rust/kernel/sync/locked_by.rs
@@ -9,7 +9,7 @@
 /// Allows access to some data to be serialised by a lock that does not wrap it.
 ///
 /// In most cases, data protected by a lock is wrapped by the appropriate lock type, e.g.,
-/// [`super::Mutex`] or [`super::SpinLock`]. [`LockedBy`] is meant for cases when this is not
+/// [`Mutex`] or [`SpinLock`]. [`LockedBy`] is meant for cases when this is not
 /// possible. For example, if a container has a lock and some data in the contained elements needs
 /// to be protected by the same lock.
 ///
@@ -17,6 +17,9 @@
 /// when the caller shows evidence that the 'external' lock is locked. It panics if the evidence
 /// refers to the wrong instance of the lock.
 ///
+/// [`Mutex`]: super::Mutex
+/// [`SpinLock`]: super::SpinLock
+///
 /// # Examples
 ///
 /// The following is an example for illustrative purposes: `InnerDirectory::bytes_used` is an
-- 
2.43.0


