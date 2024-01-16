Return-Path: <linux-kernel+bounces-28368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8FA82FDA7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 00:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5FD51F2629F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF2D1D55E;
	Tue, 16 Jan 2024 23:11:26 +0000 (UTC)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13231CFBF;
	Tue, 16 Jan 2024 23:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705446685; cv=none; b=Ncu/BSXxBq2D4wGnPLedFI+omQRjvgJ8gITh2ggCTrmSZKc55h4aiwi+R1ZeJ3K3+rJmP+ywECxPLp2vHXWN8QT4M9YdOnB/4iL3kJQW3mb6RUOSXXOAYwdlFIL98VpNMiAcriCe7FM1n3kzK2t8KGQyxoCDPG/f8JZumo8HjTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705446685; c=relaxed/simple;
	bh=7MiaAc6W5AQRrrlOnAKaPlcWyVIYgzIpHuf2rLOhyAM=;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-Provags-ID:
	 X-Spam-Flag:UI-OutboundReport; b=sUbpgn8NEVcu4dQn5sPrRddv20GrDMluQabpuMsRo/pOCtGt7euZz+i8baXCIvxvyGvXxkdsFmkwkgnxCQYyOHZXvGkKzFyPXneJVPSOTheTrcm4wCvK2Boqxmhes6RsC/DTq0ZDz2WR2AZChqYiqwxkYYmtfvPGV730Iuwh1Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de; spf=pass smtp.mailfrom=valentinobst.de; arc=none smtp.client-ip=212.227.126.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valentinobst.de
Received: from localhost.localdomain ([217.245.156.100]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mtf39-1r8kba2vOh-00v5AO; Wed, 17 Jan 2024 00:11:09 +0100
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
Subject: [PATCH 10/13] rust: kernel: add doclinks
Date: Wed, 17 Jan 2024 00:11:06 +0100
Message-ID: <20240116231106.168864-1-kernel@valentinobst.de>
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
X-Provags-ID: V03:K1:Z1CAg3hR5eUEZFAbmCMyk8n31l1hu3iGDoGIyb2TOJ9BQ6oZ66N
 xgh7g1pKxzlAf0WUIFDUKP6K/0/NaQU5EdLwvuiu82vHVUx/nWQVi7tTrEjqXbfEavV1qSq
 HrR7fNDf5NZEFnuJhaCpZnyoeNIhDAKWSzglIR75OwVbgo339n6EqHSswFeEYMbblYfusVm
 74H2GunGWWkBY49egjj0A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JXSp30eQ2Vw=;J/G1TkfLaA88yilc2Ul0f19oerM
 eaVn2VYzWEyaVDNjswDND3Sg+cPLdiaIvpcHAGh0B0O/0TG3NrFW6pYG7WVLF9pTLsOTEtYul
 4Hw+Di5Fx/4HRpJe0f71AnukTzancGUDaRdCOb7cTvJKI1j0GZuA1voIp6mKXunWnoBEOFR1C
 9TPfdxc1ye9TTZb1xvbx9ppe4V4X0zan3jFJ2xIl2PxwgDCTL9f6sN81Bi182naEKhQ+qWs5e
 jj3WiPAsKOfxPInmfGLuihc4tQzGCpxuVrcqzkQoa/dktCSCnM45L0clZQyZKCDCQZISiVYoi
 h8mGL+tRfuV0z2cNzlq179xNC6C1G/p2MN2ywDR3se14Jiq5R+lGB7biUVlFsy5nCqrsdnsi0
 6jCOzPoOF8i9Eu6Epul8OUrwkhTg1KN7NbsXw0pkzTMRl7EVpgXgDL6SxDHV2tMaU90VMYpMd
 RWdnpeTOGmv137kNwdJF6GK6jWduZEBl8BTmd65z+CA4FCQGVryHPJLK99trx1U3UV4fRNwuu
 DlvCUq9BeN9CpNjK1S0zlK+iG4LpnWefkshVw/rNSf8hHNGMcgQ3exSbFqwLwWCOadZuBIqcY
 RPskhAnNRaBr9DHLgWJDg70DoEZfE1JoCV/lqh0akdfvzCZrKuSBLHSakldF8XiyPXejt0skj
 /ta1coK7kGwz9wAXiVEBtZo+vOgKunEFMZXGBgxwgKHTYdcSQjPfT7EQaGT1330USsvtECsvt
 P8bJHL/b0EU2c2L6Q4j2KeVm7L9xCq2NuYdtI4UrGVV2PGkuHqp8NZ2J2bEqm/iDGi5xXeHIN
 hqe6I7kFUUoNMFRKgrRrcNbMDc4iUvsyLfEZUaWgZ1QF7XikFcOlDhLD+kmP4L5TWgsCofrM2
 vqZIJquE0icTWfg==

Add doclinks to existing documentation.

Signed-off-by: Valentin Obst <kernel@valentinobst.de>
---
 rust/kernel/sync/arc.rs  |  6 +++---
 rust/kernel/sync/lock.rs | 13 +++++++++---
 rust/kernel/workqueue.rs | 45 ++++++++++++++++++++++++----------------
 3 files changed, 40 insertions(+), 24 deletions(-)

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 6c46b1affca5..936bc549a082 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -365,12 +365,12 @@ fn from(item: Pin<UniqueArc<T>>) -> Self {
 /// A borrowed reference to an [`Arc`] instance.
 ///
 /// For cases when one doesn't ever need to increment the refcount on the allocation, it is simpler
-/// to use just `&T`, which we can trivially get from an `Arc<T>` instance.
+/// to use just `&T`, which we can trivially get from an [`Arc<T>`] instance.
 ///
 /// However, when one may need to increment the refcount, it is preferable to use an `ArcBorrow<T>`
 /// over `&Arc<T>` because the latter results in a double-indirection: a pointer (shared reference)
-/// to a pointer (`Arc<T>`) to the object (`T`). An [`ArcBorrow`] eliminates this double
-/// indirection while still allowing one to increment the refcount and getting an `Arc<T>` when/if
+/// to a pointer ([`Arc<T>`]) to the object (`T`). An [`ArcBorrow`] eliminates this double
+/// indirection while still allowing one to increment the refcount and getting an [`Arc<T>`] when/if
 /// needed.
 ///
 /// # Invariants
diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index 467249b39f71..f14179d19d4e 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -21,14 +21,21 @@
 /// # Safety
 ///
 /// - Implementers must ensure that only one thread/CPU may access the protected data once the lock
-/// is owned, that is, between calls to `lock` and `unlock`.
-/// - Implementers must also ensure that `relock` uses the same locking method as the original
+/// is owned, that is, between calls to [`lock`] and [`unlock`].
+/// - Implementers must also ensure that [`relock`] uses the same locking method as the original
 /// lock operation.
+///
+/// [`lock`]: Backend::lock
+/// [`unlock`]: Backend::unlock
+/// [`relock`]: Backend::relock
 pub unsafe trait Backend {
     /// The state required by the lock.
     type State;
 
-    /// The state required to be kept between `lock` and `unlock`.
+    /// The state required to be kept between [`lock`] and [`unlock`].
+    ///
+    /// [`lock`]: Backend::lock
+    /// [`unlock`]: Backend::unlock
     type GuardState;
 
     /// Initialises the lock.
diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index d900dc911149..ed3af3491b47 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -12,19 +12,19 @@
 //!
 //! # The raw API
 //!
-//! The raw API consists of the `RawWorkItem` trait, where the work item needs to provide an
+//! The raw API consists of the [`RawWorkItem`] trait, where the work item needs to provide an
 //! arbitrary function that knows how to enqueue the work item. It should usually not be used
 //! directly, but if you want to, you can use it without using the pieces from the safe API.
 //!
 //! # The safe API
 //!
-//! The safe API is used via the `Work` struct and `WorkItem` traits. Furthermore, it also includes
-//! a trait called `WorkItemPointer`, which is usually not used directly by the user.
+//! The safe API is used via the [`Work`] struct and [`WorkItem`] traits. Furthermore, it also
+//! includes a trait called [`WorkItemPointer`], which is usually not used directly by the user.
 //!
-//!  * The `Work` struct is the Rust wrapper for the C `work_struct` type.
-//!  * The `WorkItem` trait is implemented for structs that can be enqueued to a workqueue.
-//!  * The `WorkItemPointer` trait is implemented for the pointer type that points at a something
-//!    that implements `WorkItem`.
+//!  * The [`Work`] struct is the Rust wrapper for the C `work_struct` type.
+//!  * The [`WorkItem`] trait is implemented for structs that can be enqueued to a workqueue.
+//!  * The [`WorkItemPointer`] trait is implemented for the pointer type that points at a something
+//!    that implements [`WorkItem`].
 //!
 //! ## Example
 //!
@@ -218,7 +218,9 @@ pub fn try_spawn<T: 'static + Send + FnOnce()>(&self, func: T) -> Result<(), All
     }
 }
 
-/// A helper type used in `try_spawn`.
+/// A helper type used in [`try_spawn`].
+///
+/// [`try_spawn`]: Queue::try_spawn
 #[pin_data]
 struct ClosureWork<T> {
     #[pin]
@@ -258,9 +260,11 @@ fn run(mut this: Pin<Box<Self>>) {
 ///
 /// # Safety
 ///
-/// Implementers must ensure that any pointers passed to a `queue_work_on` closure by `__enqueue`
+/// Implementers must ensure that any pointers passed to a `queue_work_on` closure by [`__enqueue`]
 /// remain valid for the duration specified in the guarantees section of the documentation for
-/// `__enqueue`.
+/// [`__enqueue`].
+///
+/// [`__enqueue`]: RawWorkItem::__enqueue
 pub unsafe trait RawWorkItem<const ID: u64> {
     /// The return type of [`Queue::enqueue`].
     type EnqueueOutput;
@@ -290,10 +294,11 @@ unsafe fn __enqueue<F>(self, queue_work_on: F) -> Self::EnqueueOutput
 
 /// Defines the method that should be called directly when a work item is executed.
 ///
-/// This trait is implemented by `Pin<Box<T>>` and `Arc<T>`, and is mainly intended to be
+/// This trait is implemented by `Pin<Box<T>>` and [`Arc<T>`], and is mainly intended to be
 /// implemented for smart pointer types. For your own structs, you would implement [`WorkItem`]
-/// instead. The `run` method on this trait will usually just perform the appropriate
-/// `container_of` translation and then call into the `run` method from the [`WorkItem`] trait.
+/// instead. The [`run`] method on this trait will usually just perform the appropriate
+/// `container_of` translation and then call into the [`run`][WorkItem::run] method from the
+/// [`WorkItem`] trait.
 ///
 /// This trait is used when the `work_struct` field is defined using the [`Work`] helper.
 ///
@@ -309,8 +314,10 @@ pub unsafe trait WorkItemPointer<const ID: u64>: RawWorkItem<ID> {
     ///
     /// # Safety
     ///
-    /// The provided `work_struct` pointer must originate from a previous call to `__enqueue` where
-    /// the `queue_work_on` closure returned true, and the pointer must still be valid.
+    /// The provided `work_struct` pointer must originate from a previous call to [`__enqueue`]
+    /// where the `queue_work_on` closure returned true, and the pointer must still be valid.
+    ///
+    /// [`__enqueue`]: RawWorkItem::__enqueue
     unsafe extern "C" fn run(ptr: *mut bindings::work_struct);
 }
 
@@ -328,12 +335,14 @@ pub trait WorkItem<const ID: u64 = 0> {
 
 /// Links for a work item.
 ///
-/// This struct contains a function pointer to the `run` function from the [`WorkItemPointer`]
+/// This struct contains a function pointer to the [`run`] function from the [`WorkItemPointer`]
 /// trait, and defines the linked list pointers necessary to enqueue a work item in a workqueue.
 ///
 /// Wraps the kernel's C `struct work_struct`.
 ///
 /// This is a helper type used to associate a `work_struct` with the [`WorkItem`] that uses it.
+///
+/// [`run`]: WorkItemPointer::run
 #[repr(transparent)]
 pub struct Work<T: ?Sized, const ID: u64 = 0> {
     work: Opaque<bindings::work_struct>,
@@ -409,7 +418,7 @@ pub unsafe fn raw_get(ptr: *const Self) -> *mut bindings::work_struct {
 /// }
 /// ```
 ///
-/// Note that since the `Work` type is annotated with an id, you can have several `work_struct`
+/// Note that since the [`Work`] type is annotated with an id, you can have several `work_struct`
 /// fields by using a different id for each one.
 ///
 /// # Safety
@@ -429,7 +438,7 @@ pub unsafe trait HasWork<T, const ID: u64 = 0> {
     /// Returns the offset of the [`Work<T, ID>`] field.
     ///
     /// This method exists because the [`OFFSET`] constant cannot be accessed if the type is not
-    /// `Sized`.
+    /// [`Sized`].
     ///
     /// [`Work<T, ID>`]: Work
     /// [`OFFSET`]: HasWork::OFFSET
-- 
2.43.0


