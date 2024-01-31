Return-Path: <linux-kernel+bounces-47068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB1D8448C7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEA411C241BD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A51D1350CD;
	Wed, 31 Jan 2024 20:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k0UzYpgw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7995C40BF0;
	Wed, 31 Jan 2024 20:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706732649; cv=none; b=gHUaD7p6NgxwK73h9Ea0UinLaAds8izFEMQHVaDaKRY48PnhPbvKgQXZHcCWpGPlb7df9ZgATOswERP3jmQbMQkgDwTwH1qNgEHPEdYBP/Fha4IpUH+9v0mBdz6EE/c7J4exa22bduAzSIp+R6pMhzrbs0Nf/fA2Vw7fQIOJyV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706732649; c=relaxed/simple;
	bh=l5qTabcr/FSc8zBd9Snc6NefrNZmSs4e6M9FZdZKYQk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IAr4vN8XdVTGGtOJbY6OiHb/90P95/QhToOm4pT4DY/6Y/2mJ/WvlovkhznfguIGdNuD8jrxE8l5rueFe748SmjaGDU4Cm/47mIPyK1VdXqC3yiEfRpYqyNq3wXGs82ExsVwYCsP2AX+Fuqi1Ztq8qDVAmg010pb758XK3F17bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k0UzYpgw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 166E4C4166B;
	Wed, 31 Jan 2024 20:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706732649;
	bh=l5qTabcr/FSc8zBd9Snc6NefrNZmSs4e6M9FZdZKYQk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=k0UzYpgwyLiQrRKo8FEWyGL/vwl8eeYoF1n+sNcdZk8qajyxBqK1VP3bCjz7rjzsW
	 iy9ThfMXpOqyTMeZ6y7Y8Gj7kxHydvDldnyv1OoCp3lnsJsKdLLaPaS1GviHilXQ36
	 ekyoDesHIxu80HF39GWlNV0VUjSnFSHv7RlNIgPiSPow6E4wOVBB/pwik/6uh6xPiI
	 Q+f+4cU5aFHdOt4THg+PKo6bXqoXe47qkz/Ax6MBPFtP/4GVNn5UO2G0HsIoMSxBwI
	 9z95+Dewl84Gs2LIeiEH3M2AP9f1wYPvBIaNAhxoAcuh+PiyTsJsyr1S3mAkgKjb2S
	 u0iWutdAnsoUQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043D4C4828E;
	Wed, 31 Jan 2024 20:24:09 +0000 (UTC)
From: Valentin Obst via B4 Relay <devnull+kernel.valentinobst.de@kernel.org>
Date: Wed, 31 Jan 2024 21:23:30 +0100
Subject: [PATCH v3 08/12] rust: kernel: mark code fragments in docs with
 backticks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-doc-fixes-v3-v3-8-0c8af94ed7de@valentinobst.de>
References: <20240131-doc-fixes-v3-v3-0-0c8af94ed7de@valentinobst.de>
In-Reply-To: <20240131-doc-fixes-v3-v3-0-0c8af94ed7de@valentinobst.de>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Wedson Almeida Filho <wedsonaf@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@samsung.com>, 
 Alice Ryhl <aliceryhl@google.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Valentin Obst <kernel@valentinobst.de>, Trevor Gross <tmgross@umich.edu>, 
 Martin Rodriguez Reboredo <yakoyoku@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706732646; l=3807;
 i=kernel@valentinobst.de; s=20240131; h=from:subject:message-id;
 bh=J5dTHNR//Nnyw4X8Q/8C/mtX7OP1rzCZ6Zxen8pohMw=;
 b=HpgEriZmFxlMj6UQF50GllImTwzlcqVkT988KRK6iiTbNvDURVqFTmz0Sq4w5/UCq5EkM0OCQ
 kCT334V3M6HC7d3a+bS/t9UEn7IxBQftdV1bPp3QnO60rdWZAnLX9kN
X-Developer-Key: i=kernel@valentinobst.de; a=ed25519;
 pk=3s7U8y0mqkaiurgHSQQTYWOo2tw5HgzCg5vnJVfw37Y=
X-Endpoint-Received:
 by B4 Relay for kernel@valentinobst.de/20240131 with auth_id=124
X-Original-From: Valentin Obst <kernel@valentinobst.de>
Reply-To: <kernel@valentinobst.de>

From: Valentin Obst <kernel@valentinobst.de>

Fix places where comments include code fragments that are not enclosed
in backticks.

Signed-off-by: Valentin Obst <kernel@valentinobst.de>
Reviewed-by: Trevor Gross <tmgross@umich.edu>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
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
index 072b8ef2a0fa..10ccc0e39147 100644
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
index 6726f1056066..ca6e7e31d71c 100644
--- a/rust/kernel/task.rs
+++ b/rust/kernel/task.rs
@@ -132,7 +132,7 @@ fn deref(&self) -> &Self::Target {
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


