Return-Path: <linux-kernel+bounces-35631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FE783945C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A94B1C2705E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE2D6BB44;
	Tue, 23 Jan 2024 16:10:29 +0000 (UTC)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64C3612ED;
	Tue, 23 Jan 2024 16:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706026228; cv=none; b=Naq+pPnLwStlMo4G5MqgTVA/Unp+D+euvKkJamtGzcIlWv2/XLGZJpMP6slWUrR16mULo+YCl9NZAtoRoVikZ+Vj25sz1hrGR6fCeaF97CHZcnl4SBIf4vC9ysn1CkcJHGsZtTrxD/Qf5CBrLhbYhGnH860BahaXip6uUErohPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706026228; c=relaxed/simple;
	bh=yNxLPKFKZ3J06UdonBVMW5YOPuqcKhVVrMz3VR5s+xM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hvC80aNq5FrKRMiGJAuki0X+BiD0Ck68pRqK3JC6BcjbeB3Zg8ytIrW0urOKLGVeVTmayyTPmKVJbSSh6DJi7zmk9laNSE7CDdwymgtUkfQijh5uwwatLrP4qM3fF0yc4wafLkT+r5t9VojihyQ3lzrMpYkUjB3Kb0RHSIekC2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de; spf=pass smtp.mailfrom=valentinobst.de; arc=none smtp.client-ip=212.227.126.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valentinobst.de
Received: from localhost.localdomain ([95.223.130.98]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MRmsE-1rYGfy13MI-00TFbA; Tue, 23 Jan 2024 17:10:08 +0100
From: Valentin Obst <kernel@valentinobst.de>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/12] rust: kernel: add doclinks
Date: Tue, 23 Jan 2024 17:10:07 +0100
Message-ID: <20240123161007.125380-1-kernel@valentinobst.de>
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
X-Provags-ID: V03:K1:AYk5K0DI/SeWiuqD1FwjDB4RASXP+DR8GlmX0yrZEINI+MyAPQ1
 flxlJl42P3tRBLLjJo001pw3HRffuZ5eqK/SCAxR4K7mzt1Dzya9bY2CTWrEkS2jQwSjZok
 5NTNrhjKg3ZuSt4mdT6hD4pGULN6HuhWmTW9L/bSV5yEDwHbjRjg8nKIwT2c1hAD6NrUuXC
 0LKknSklVTmUdDBi+faLw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JcwRn86CuEo=;E4gMNnRFw+wRTIjyK2DmlkoHTYq
 MNhN/4+rRSGmzclDMty8eLoFMSIOd20kALaVhdLkvqTkE1SFw5Bn1iiYuPpwjIY06aEe2S421
 e8iK1p5Ei1RyV1zTl/GaKlASHO6TwRqpTtbbiziwx4oBh4+ewATqfK7O5t54GONq6a5JOSFPR
 55Peov9PXa8tpQq0lcbTPQ1glNVC0I97DKJarOz9S6SsYQweyE+O4y8GupvYs/YL9UaJ5wgY1
 wYhBSURtFDHHV5jlrqet9QU10eWFra0qKc+oMr60IgnpLPPlgbEv4zE6Pnuh3RhUTKxdhiNNN
 jP76k3v4tJ7vp/caBEB+aMN1ZDVzv1Kb2hukC1l6qJbqHvQ0hfSeyzunOySpIyjdj3UNblE9p
 pQ2U2c+1rvBg7Rf1fYs5kLL8q3KWKt1WP5EBeJy8XNR88KN8z0R99E7xTwZR8dXgVMxMeJgtz
 2jSZup6mvXfXMOLhQxLrO9DRyLjvO//Z6G/AxFhkESbPe+UkLtO1kfKCYz1po8qMGF0JWYSOy
 OoULW7SrvdPnIEvs0CetPmHv+KgP6YMUgnqZQBwA671BQNIqQaNC0lSbMPuol35O/ImZ8NYWb
 07v4RHZ6NPX6y/C2qEKEuFoFuIqGwDbfAHBC9vgpzLbqLbbhAgioQM5HM4rIrRL0O93UAi4qc
 otQ++JnattkOpmaRYrfHDnJpTUhg/hoMJcqq3YSj5jc2sRpfUXjWITsmi5EOaArLySsDzUfLp
 EYkxSyX4nMWCjdTeEvnh9FcjkraVGO3lDoKe3cLy0jETW7deXRnctR+TPZIeBi95MzZ7J0Lru
 rSPTt5C1saWDjtfl5dxHiw1UENwgdJoCv7JBOS3pCYDcH5VT5Mq99SzjT69EcF7tFTbkDD289
 bnoKARD1gGHdcqQ==

Add doclinks to existing documentation.

Signed-off-by: Valentin Obst <kernel@valentinobst.de>
Reviewed-by: Trevor Gross <tmgross@umich.edu>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
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
index 67588654c22f..956a0618ecc6 100644
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


