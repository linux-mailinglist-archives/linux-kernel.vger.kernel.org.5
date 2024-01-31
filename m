Return-Path: <linux-kernel+bounces-47072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A058448CF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89513282D16
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E745313D51C;
	Wed, 31 Jan 2024 20:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxAIl+/U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F383FE24;
	Wed, 31 Jan 2024 20:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706732649; cv=none; b=Ya8YX7y6ALWZx+Z7Crv1AodviFhXb6HEVyU0pYYqZBFpd+bIUxipNjxMVNVAictAvFVsk8GA97PJ83EtNTk97KRjSSHO1kf2t/VS0UpQ/i42raiXnPbPXvl8i7bdaSKkzZbOEDYT25zrw2DA8oc3p0ip6ZQy4fdJJNXjdc9dLyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706732649; c=relaxed/simple;
	bh=GarbNP+2iuIwr6VxBD7bVTYXmjv1I2yVW0qul64RfeA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ifAvwbIittZgjmNb2h1EGYj2gr7DXgac+5/4HKNyb//UIFhCOoxkmHbjXwixnGWcfc7SePJZbkB80LX2dcA/ojUPv/bMLqkiMrxMptxFqZ//Z2FpIpqmL3uZjWOlXXDdw6dk+/kWb4BtIbbU3yatQsvtUauF0i3+wkkarLmidYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxAIl+/U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2AD03C41674;
	Wed, 31 Jan 2024 20:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706732649;
	bh=GarbNP+2iuIwr6VxBD7bVTYXmjv1I2yVW0qul64RfeA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=mxAIl+/UeHg4Y+01Q2LDQ93mLlXEwonoxVcEvnu9lOv2UspOYOR/y/3LFL0tPqrW3
	 471t7BwNr8mJjTr5CnlID2RyJ5XAF96K5IzrKdmUjNsodPXA0sK395b7Kice2z4mk6
	 sWxJrBxrKdw2INKj0FvwtzgU7ibOp4+QNf1ywH/YJToe2Q6R9jWPgraDgwLCsIdoc8
	 O6yPFHaKrLl1NsTm2f8scj5PSA2vD8NOroDPwrwQRizKr3L6vGKEg2jumicnqU9OW4
	 xLIlkNi1fpKAyGaiMJT8ydmNh81/lJo37OjOLK+5C3nAgIOoPCwMCwO/gOD1Ou2+qZ
	 KsdltbFS/ML9A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194AEC47DB3;
	Wed, 31 Jan 2024 20:24:09 +0000 (UTC)
From: Valentin Obst via B4 Relay <devnull+kernel.valentinobst.de@kernel.org>
Date: Wed, 31 Jan 2024 21:23:32 +0100
Subject: [PATCH v3 10/12] rust: kernel: add doclinks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-doc-fixes-v3-v3-10-0c8af94ed7de@valentinobst.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706732646; l=8480;
 i=kernel@valentinobst.de; s=20240131; h=from:subject:message-id;
 bh=+UXljfH8wlx7xaY4WJ467vxrBsuNMbjA2jEIytFPfIs=;
 b=rj2UxYJPHYdYlXqRXd4c6xgALp7XYJwoNoByMd3YVtyR7KVpB6mNm0amP9b+45CxN6jo5OOEf
 t0qmiR4CqhGCG/XkubDOwhShE9UQV1SqSjwNrDSxEV1N/xcgGZV/Rl3
X-Developer-Key: i=kernel@valentinobst.de; a=ed25519;
 pk=3s7U8y0mqkaiurgHSQQTYWOo2tw5HgzCg5vnJVfw37Y=
X-Endpoint-Received:
 by B4 Relay for kernel@valentinobst.de/20240131 with auth_id=124
X-Original-From: Valentin Obst <kernel@valentinobst.de>
Reply-To: <kernel@valentinobst.de>

From: Valentin Obst <kernel@valentinobst.de>

Add doclinks to existing documentation.

Signed-off-by: Valentin Obst <kernel@valentinobst.de>
Reviewed-by: Trevor Gross <tmgross@umich.edu>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/sync/arc.rs  |  6 +++---
 rust/kernel/sync/lock.rs | 13 ++++++++++---
 rust/kernel/workqueue.rs | 45 +++++++++++++++++++++++++++------------------
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
index 10ccc0e39147..5b5c8efe427a 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -21,14 +21,21 @@
 /// # Safety
 ///
 /// - Implementers must ensure that only one thread/CPU may access the protected data once the lock
-///   is owned, that is, between calls to `lock` and `unlock`.
-/// - Implementers must also ensure that `relock` uses the same locking method as the original
+///   is owned, that is, between calls to [`lock`] and [`unlock`].
+/// - Implementers must also ensure that [`relock`] uses the same locking method as the original
 ///   lock operation.
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


