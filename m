Return-Path: <linux-kernel+bounces-141631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3028A20E7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 23:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B14FB1F23FAF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 21:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030883D3A7;
	Thu, 11 Apr 2024 21:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OY4/pS9d";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T6ACBiKe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A21B3D38D;
	Thu, 11 Apr 2024 21:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712870945; cv=none; b=sx7H0idyNkwEH2Dmf2/JtDhYaILaNJOH9m22ymN/G0CaffNs8DTbsBPFCnpnQSLtgCT9CXKywRD0zV3A7f7M6pnmfpTAO8f27kmdbMIbw9sBBXvxeFnYSxMXcJAcTuOXn3tta2gqln9SoxGsfGNwOy6pF8GJbxZTe/iVhBLWbtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712870945; c=relaxed/simple;
	bh=fq2Sz8YzXxH3MmgbR6+ZQW0h2jwwe5aHgxjosvRzTng=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kwHyrlUyMR8sZb6P55j7/mpUmdF3zK/XuX+YD5U47Lppc9FOvbHNz619PCIEFBZq4F1JCEmJB3mrYGWbmBguz75KBTQk3J+uhFpTsBW3lN/B6GL7LVPWHoaUR1SyLxwoCqr444iOTIquSuvGfsoypJSZ+7zXgXPwn+ZZqvoMz70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OY4/pS9d; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T6ACBiKe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 11 Apr 2024 21:29:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712870941;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XAiQ9jb3mg7RJ1XbPGTKx56PaPdXw1wZjFk6j52pnp0=;
	b=OY4/pS9dKLMS6qMfwyfwzwtCgOunX94RiABzmQ9087UxQoHuwDad/XS14Y8VRAVEzCUnrZ
	1BjGfPO0itRBxjv/7O96NA3Wbej/UQrAsWRVZ1llku5t0TktkNw+wBYv4Es0yITIBAPcCZ
	NmUHBuWYK7qv5JbXB1Cd0rO9m+CUNrxt2rHg25tfMRM2+W083VFoiZlQUPIbZcyLa5ia+6
	gj3u2A6EpyYfDqp96pxfdjZOfHRydlQUYrajS/bNk/MT1URwK/xi1LyqN2iY0AYv0uAK/6
	11Lq/hKIWRirBFhGGwVQ0qAFeOYOgpMD1a6X6RGM2GvZ37Zg+AxM8Edz13bLJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712870941;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XAiQ9jb3mg7RJ1XbPGTKx56PaPdXw1wZjFk6j52pnp0=;
	b=T6ACBiKef6JI4qWsX33Nn8lIt4O8BoLk3TpyebUCLNnDeuDYr3z3YnREP1WmK8AtXLwOgg
	o0r31stkdo8lcmBQ==
From: "tip-bot2 for Alice Ryhl" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] rust: time: Add Ktime
Cc: Alice Ryhl <aliceryhl@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Benno Lossin <benno.lossin@proton.me>, Boqun Feng <boqun.feng@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240322-rust-ktime_ms_delta-v2-1-d98de1f7c282@google.com>
References: <20240322-rust-ktime_ms_delta-v2-1-d98de1f7c282@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171287094047.10875.5384110198296900359.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     48b7f4d29ac8fcdc35a97ce38e4aecdee83b0e3f
Gitweb:        https://git.kernel.org/tip/48b7f4d29ac8fcdc35a97ce38e4aecdee83b0e3f
Author:        Alice Ryhl <aliceryhl@google.com>
AuthorDate:    Fri, 22 Mar 2024 08:59:38 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 11 Apr 2024 23:20:43 +02:00

rust: time: Add Ktime

Introduce a wrapper around `ktime_t` with a few different useful methods.

Rust Binder will use these bindings to compute how many milliseconds a
transaction has been active for when dumping the current state of the
Binder driver. This replicates the logic in C Binder [1].

For a usage example in Rust Binder, see [2].

ktime_get() cannot be safely called in NMI context. This requirement is not
checked by these abstractions, but it is intended that klint [3] or a
similar tool will be used to check it in the future.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Miguel Ojeda <ojeda@kernel.org>
Link: https://lore.kernel.org/r/20240322-rust-ktime_ms_delta-v2-1-d98de1f7c282@google.com
Link: https://lore.kernel.org/lkml/5ac8c0d09392290be789423f0dd78a520b830fab.1682333709.git.zhangchuang3@xiaomi.com/ [1]
Link: https://r.android.com/3004103 [2]
Link: https://rust-for-linux.com/klint [3]
---
 rust/kernel/time.rs | 60 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 60 insertions(+)

diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
index 25a896e..6811d5c 100644
--- a/rust/kernel/time.rs
+++ b/rust/kernel/time.rs
@@ -5,6 +5,9 @@
 //! This module contains the kernel APIs related to time and timers that
 //! have been ported or wrapped for usage by Rust code in the kernel.
 
+/// The number of nanoseconds per millisecond.
+pub const NSEC_PER_MSEC: i64 = bindings::NSEC_PER_MSEC as i64;
+
 /// The time unit of Linux kernel. One jiffy equals (1/HZ) second.
 pub type Jiffies = core::ffi::c_ulong;
 
@@ -18,3 +21,60 @@ pub fn msecs_to_jiffies(msecs: Msecs) -> Jiffies {
     // matter what the argument is.
     unsafe { bindings::__msecs_to_jiffies(msecs) }
 }
+
+/// A Rust wrapper around a `ktime_t`.
+#[repr(transparent)]
+#[derive(Copy, Clone)]
+pub struct Ktime {
+    inner: bindings::ktime_t,
+}
+
+impl Ktime {
+    /// Create a `Ktime` from a raw `ktime_t`.
+    #[inline]
+    pub fn from_raw(inner: bindings::ktime_t) -> Self {
+        Self { inner }
+    }
+
+    /// Get the current time using `CLOCK_MONOTONIC`.
+    #[inline]
+    pub fn ktime_get() -> Self {
+        // SAFETY: It is always safe to call `ktime_get` outside of NMI context.
+        Self::from_raw(unsafe { bindings::ktime_get() })
+    }
+
+    /// Divide the number of nanoseconds by a compile-time constant.
+    #[inline]
+    fn divns_constant<const DIV: i64>(self) -> i64 {
+        self.to_ns() / DIV
+    }
+
+    /// Returns the number of nanoseconds.
+    #[inline]
+    pub fn to_ns(self) -> i64 {
+        self.inner
+    }
+
+    /// Returns the number of milliseconds.
+    #[inline]
+    pub fn to_ms(self) -> i64 {
+        self.divns_constant::<NSEC_PER_MSEC>()
+    }
+}
+
+/// Returns the number of milliseconds between two ktimes.
+#[inline]
+pub fn ktime_ms_delta(later: Ktime, earlier: Ktime) -> i64 {
+    (later - earlier).to_ms()
+}
+
+impl core::ops::Sub for Ktime {
+    type Output = Ktime;
+
+    #[inline]
+    fn sub(self, other: Ktime) -> Ktime {
+        Self {
+            inner: self.inner - other.inner,
+        }
+    }
+}

