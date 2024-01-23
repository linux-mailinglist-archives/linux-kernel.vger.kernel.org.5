Return-Path: <linux-kernel+bounces-35628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EB2839458
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E609C1C28208
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8C563512;
	Tue, 23 Jan 2024 16:10:03 +0000 (UTC)
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17ED6166F;
	Tue, 23 Jan 2024 16:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706026203; cv=none; b=tpSmxYpClrrXaJVA23jckNb1p1gY8Lv8AnTdqXhtGO1IAlDl+SLz0aRqfIHBzIt1PBzJEEK0r6LkYjGRxzpiccHUFXagafMQAkKF836VUgEi83G5pgBYZPse76FHybkK22pRR1LQjz2tsbgBnb6lLWCWDP68QRgcy7GuczNYjlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706026203; c=relaxed/simple;
	bh=7evZ5vnJssnQ3L5gw0A+dVQbOD4aGjWM4CuIu8PX8rM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XwqjR0d3t+1UTHvCxMDZtfYI+qALrMzVbfWjaUWAGL4BsSsh/apf7XAy8A4mikJaGyYFGwWI2HnujxGi1KWiFdou+snrRnN95+BA5cJl5y6QAMoUgfrqtklW7rIeUtaT12leJVpskCv7305MI7AYSJBhtol2GqLazg9W1kT1KSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de; spf=pass smtp.mailfrom=valentinobst.de; arc=none smtp.client-ip=217.72.192.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valentinobst.de
Received: from localhost.localdomain ([95.223.130.98]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MhlCg-1qxONS0TGy-00dpaC; Tue, 23 Jan 2024 17:09:42 +0100
From: Valentin Obst <kernel@valentinobst.de>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/12] rust: kernel: mark code fragments in docs with backticks
Date: Tue, 23 Jan 2024 17:09:41 +0100
Message-ID: <20240123160941.125348-1-kernel@valentinobst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123150112.124084-1-kernel@valentinobst.de>
References: <20240123150112.124084-1-kernel@valentinobst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:BVPE1uGnnEwYCq5nQavqew5CMEPSzqQb4jldVEYOWski2Y3V2Py
 xdjj3KWBOncdzQPS38py2WQFo9L+4S8jUa5f2lOVvoi1ajzgCMg/h6eWUcp3xrazQ6YcoMW
 x5sZwzUGWXp8UXJNk+2vfXXTN63l/gHYVCo+rGdI7X0MObeJyWfF+VAhD7YBMma/8fyohhb
 +mP2awwuD4gzeGH7o+7YA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0Nbwhu/xRzk=;n1YrVuSglSXQZyULkMu0U74euon
 OoU1lAftulE7OJI79yH2pLK9UjdHfMFJES3S+GgFo1hUvpSwQ+K3KPheSkT+Bw+kzVxeAI/7t
 rqbgJ2fJiUEFalwdTv4HDUa8DxNuC6P+eA5r679Z+SgodB0Topd3JYbhY1spk/fk9RvuVmkz4
 RePyF1D5ZIIykp3p2QL/9h4SSbRje/S37CF7kGa9Q2cqWmZXPSXY2Tyl+/HWdzw/+jp3O9ZN3
 YBb+agAbMfAUWadY2BhntAT7u7fvc1devSG0zlRMcGfkj3DTrWZ62lDvmO/gxMUvxXqcWK74x
 6mFxuBBxBY3lGx7gq52B9KLSBbwmIopo2+TGu4NHGRYAUSjRG6Dozrx8e54/CQhYQBoekuW/k
 SleZAeyxLS2mQ1oaohRNozbm2JCdPP4fyHdCNufR5kQtIWt+n/h/Qw61HcFvstw7ElukyYI7+
 1upMzgyGPc/FzBBbiwvCz3Uo466RuDBJ99/wOBfbRSg5Ndjfn5Q/2Z3oq5+VZUUzAE2si+mj3
 TXi6vII+z+SsZnkcX2qfbmO/Zl7wyJDyKQ3p+JzSKyuo3xZ68xRRLP33WpS60McG+sdpUdeXU
 +3zj806FtVb/yqRo4ujzyaY3eYo9BsYibSCCJMPbWhVdVZAsVa+KYKrVAZljyx9UvNRemqpYo
 hkal1TUG+sCm67QYEw1xrKSzWCBK+O5EInOvJOMgRq3oTtjZCwMC2s59qEkZ5ecXgluNJ8yVz
 qokrUPmISi76RT7N6aZ2sjGlEnEUj6nmSgWlhm+7qUc7ob3s/0EPonVTN4NvJtsvazsTIHVQT
 B+0p3ctFguXGuPN4s+rTZFSZl79j2ePm/66v46R8bMNH/ts1JjaEiPLkwD+eZ+QGb7Jx8V8VV
 sHuKJRYPc1xuKeA==

Fix places where comments include code fragments that are not enclosed
in backticks.

Signed-off-by: Valentin Obst <kernel@valentinobst.de>
Reviewed-by: Trevor Gross <tmgross@umich.edu>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
---
 rust/kernel/ioctl.rs     | 2 +-
 rust/kernel/sync/lock.rs | 2 +-
 rust/kernel/task.rs      | 2 +-
 rust/kernel/workqueue.rs | 9 +++++----
 4 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/rust/kernel/ioctl.rs b/rust/kernel/ioctl.rs
index 5987ad6d38a7..cfa7d080b531 100644
--- a/rust/kernel/ioctl.rs
+++ b/rust/kernel/ioctl.rs
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
-//! ioctl() number definitions.
+//! `ioctl()` number definitions.
 //!
 //! C header: [`include/asm-generic/ioctl.h`](srctree/include/asm-generic/ioctl.h)
 
diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index 87e111c0da17..67588654c22f 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -28,7 +28,7 @@ pub unsafe trait Backend {
     /// The state required by the lock.
     type State;
 
-    /// The state required to be kept between lock and unlock.
+    /// The state required to be kept between `lock` and `unlock`.
     type GuardState;
 
     /// Initialises the lock.
diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
index 818ac51b06b6..d4b0d232480d 100644
--- a/rust/kernel/task.rs
+++ b/rust/kernel/task.rs
@@ -116,7 +116,7 @@ fn deref(&self) -> &Self::Target {
     /// Returns the group leader of the given task.
     pub fn group_leader(&self) -> &Task {
         // SAFETY: By the type invariant, we know that `self.0` is a valid task. Valid tasks always
-        // have a valid group_leader.
+        // have a valid `group_leader`.
         let ptr = unsafe { *ptr::addr_of!((*self.0.get()).group_leader) };
 
         // SAFETY: The lifetime of the returned task reference is tied to the lifetime of `self`,
diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index 8775c34d12a5..d900dc911149 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -168,7 +168,7 @@ impl Queue {
     /// # Safety
     ///
     /// The caller must ensure that the provided raw pointer is not dangling, that it points at a
-    /// valid workqueue, and that it remains valid until the end of 'a.
+    /// valid workqueue, and that it remains valid until the end of `'a`.
     pub unsafe fn from_raw<'a>(ptr: *const bindings::workqueue_struct) -> &'a Queue {
         // SAFETY: The `Queue` type is `#[repr(transparent)]`, so the pointer cast is valid. The
         // caller promises that the pointer is not dangling.
@@ -414,8 +414,8 @@ pub unsafe fn raw_get(ptr: *const Self) -> *mut bindings::work_struct {
 ///
 /// # Safety
 ///
-/// The [`OFFSET`] constant must be the offset of a field in Self of type [`Work<T, ID>`]. The methods on
-/// this trait must have exactly the behavior that the definitions given below have.
+/// The [`OFFSET`] constant must be the offset of a field in `Self` of type [`Work<T, ID>`]. The
+/// methods on this trait must have exactly the behavior that the definitions given below have.
 ///
 /// [`Work<T, ID>`]: Work
 /// [`impl_has_work!`]: crate::impl_has_work
@@ -428,7 +428,8 @@ pub unsafe trait HasWork<T, const ID: u64 = 0> {
 
     /// Returns the offset of the [`Work<T, ID>`] field.
     ///
-    /// This method exists because the [`OFFSET`] constant cannot be accessed if the type is not Sized.
+    /// This method exists because the [`OFFSET`] constant cannot be accessed if the type is not
+    /// `Sized`.
     ///
     /// [`Work<T, ID>`]: Work
     /// [`OFFSET`]: HasWork::OFFSET
-- 
2.43.0


