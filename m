Return-Path: <linux-kernel+bounces-35486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BFB8391ED
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA4A8B24245
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD0C5FF07;
	Tue, 23 Jan 2024 15:01:36 +0000 (UTC)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAB112E5F;
	Tue, 23 Jan 2024 15:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706022096; cv=none; b=hA2mXDbFSliBWuYO1NDaF/KQRmmSas+OMZTa5Gb9aOIVw2KX1IUWpJ9YU6oB5ft2wxSrafPP9QIaaGligTDAHI4td74DmXxTPclxF92tZVZsJb2JyOq1xLiKpJ7y482t3a4VeYgxL1E6Nz9IQEQMQred4tq1Dy6Tzg0KnstXDNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706022096; c=relaxed/simple;
	bh=aS66R/O5x9YNSVV4RmvE68N8cZ4eNwOcTYx8xWcTcYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Js3wZw53/kdJkJ2u6h352wQICA+MNw7CW3FnNGIXREBZcL2gwAoF/0mlRvfm/VXzX/hCF06zWn6YDBoTkKMNJhruZcnL6z/n2bQV0uLddrHieL+aTlpL4nPN8z5QWv1G5MAudva04p5E5B6v/zk2Kh1k1StMX/fSYYuOzKvwTYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de; spf=pass smtp.mailfrom=valentinobst.de; arc=none smtp.client-ip=212.227.17.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valentinobst.de
Received: from localhost.localdomain ([95.223.130.98]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MRnXY-1rYJtL3piE-00TDhk; Tue, 23 Jan 2024 16:01:14 +0100
From: Valentin Obst <kernel@valentinobst.de>
To: Valentin Obst <fraunhofer@valentinobst.de>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Trevor Gross <tmgross@umich.edu>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: [PATCH v2 01/12] rust: kernel: fix multiple typos in documentation
Date: Tue, 23 Jan 2024 16:00:55 +0100
Message-ID: <20240123150112.124084-2-kernel@valentinobst.de>
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
X-Provags-ID: V03:K1:qYzLBBnAeNINpVPZ5qptSa+mZHr3wYD6F/tVTzjxUqW+HAXk1le
 7kbSUqopDsgxmqF59ZfobvP+1riUqZBqpAVRcf321Ac16WDctrV7HHlUkuRNEqkGcBl5nVI
 5CmilrZ5wP1TPt7ClX/RsioomXMOVXXNtwimSZ5Md1EhiqiWLRRAKfRnuDEtSdNOtww4jxL
 TQX57rD+b2496XcqMFUvg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dPExryj3cg4=;73XglDwUupDIG0mgSkIH67B/gTy
 O/WyR/0CL60PxoPhevjK0MyftV8SV3ayWUt/sP5K9PBwHs5U45ad/Z0+buZcJKRL0x4na+DFZ
 fVcEpf0n8kdl4DyI00mTsaki0sEkXZPpazb1O0iQtffgCEv/x9J3I1d6+1SA1V/4MNZTMfs9d
 eXxhvZEPOeBJi8hfgoaLiPeZSs/thQlSZTfxIokjKWsEMChf2QuQlcewit0sNqgc6gP4Jq62S
 3a9Gh75ePu/zqnFf77sVsRB88RsXkW54+dgQ8ph/3zGnnBD/JQ1xcHWbcl1LnlqOHG50CU/my
 TgZWx+K02lZcJn134PiRWxk54hWy+D+DFxPVeODMffHAphLdSue3NrbqLci5iZTL8mIy9vNdO
 lvre/YqFf4OUV4QFRSUvZjIpcwBhs0XGdQyf5XzRsq7K/RbG8bZ8LNaRo6Px3TV6FkD/2arFh
 c5qlwHe6RGG/Sr2yUOemoX9KVEn4V7cih0GQJJQ6deHX8jslDKYouqifn1Ss8z1AB9expeJ+X
 Mwj1GPhZ0RS78PoTRIrcXWr5Z3fy4BU8p5cxrKydOR3ExqyUvygYkrgvu6NvkS3l/dIjE8MS8
 w6rWKUnj2dJtpxZb5xiH2Suwmp/u0FArgnvraFgfjSnlomil88OCLwfo5HMCC/6xCscqbm6D+
 Yd9qSLY6RqySrR7L6GrnQN+jCDZa5/dyY2zTrRhWmR3H+5u8SfhgJDpryQODqYHLe/KV4XTu0
 RLAQWVxkK/x9T6PmPI9lDKNnP3N5EKqFFuf8UWPxP+cJySgYDH1Un9VobA5hD/Ts+4cV5xhvJ
 N3rJundIYq4N+AbAM3l7EbH6CIFYFcN3C4Y8pC1afW7d4UqNeL87APocnZvF6AvvZYyLevtUD
 PVsl34NVKETKduA==

Fixes multiple trivial typos in documentation and comments of the
kernel crate.

allocator:
- Fix a trivial list item alignment issue in the last SAFETY comment of
  `krealloc_aligned`.

init:
- Replace 'type' with 'trait' in the doc comments of the `PinInit` and
  `Init` traits.
- Add colons before starting lists.
- Add spaces between the type and equal sign to respect the code
  formatting rules in example code.
- End a sentence with a full stop instead of a colon.

ioctl:
- Replace 'an' with 'a' where appropriate.

str:
- Replace 'Return' with 'Returns' in the doc comment of `bytes_written`
  as the text describes what the function does.

sync/lock:
- Fix a trivial list item alignment issue in the Safety section of the
  `Backend` trait's description.

sync/lock/spinlock:
- The code in this module operates on spinlocks, not mutexes. Thus,
  replace 'mutex' with 'spinlock' in the SAFETY comment of `unlock`.

workqueue:
- Replace "wont" with "won't" in the doc comment of `__enqueue`.

Signed-off-by: Valentin Obst <kernel@valentinobst.de>
Reviewed-by: Trevor Gross <tmgross@umich.edu>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
---
 rust/kernel/allocator.rs          |  2 +-
 rust/kernel/init.rs               | 16 ++++++++--------
 rust/kernel/ioctl.rs              |  4 ++--
 rust/kernel/str.rs                |  2 +-
 rust/kernel/sync/lock.rs          |  4 ++--
 rust/kernel/sync/lock/spinlock.rs |  2 +-
 rust/kernel/workqueue.rs          |  2 +-
 7 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/rust/kernel/allocator.rs b/rust/kernel/allocator.rs
index 4b057e837358..01ad139e19bc 100644
--- a/rust/kernel/allocator.rs
+++ b/rust/kernel/allocator.rs
@@ -35,7 +35,7 @@ unsafe fn krealloc_aligned(ptr: *mut u8, new_layout: Layout, flags: bindings::gf
     // - `ptr` is either null or a pointer returned from a previous `k{re}alloc()` by the
     //   function safety requirement.
     // - `size` is greater than 0 since it's either a `layout.size()` (which cannot be zero
-    //    according to the function safety requirement) or a result from `next_power_of_two()`.
+    //   according to the function safety requirement) or a result from `next_power_of_two()`.
     unsafe { bindings::krealloc(ptr as *const core::ffi::c_void, size, flags) as *mut u8 }
 }
 
diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index 65be9ae57b80..16a99984622c 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -751,10 +751,10 @@ macro_rules! try_init {
 ///
 /// # Safety
 ///
-/// When implementing this type you will need to take great care. Also there are probably very few
+/// When implementing this trait you will need to take great care. Also there are probably very few
 /// cases where a manual implementation is necessary. Use [`pin_init_from_closure`] where possible.
 ///
-/// The [`PinInit::__pinned_init`] function
+/// The [`PinInit::__pinned_init`] function:
 /// - returns `Ok(())` if it initialized every field of `slot`,
 /// - returns `Err(err)` if it encountered an error and then cleaned `slot`, this means:
 ///     - `slot` can be deallocated without UB occurring,
@@ -861,10 +861,10 @@ unsafe fn __pinned_init(self, slot: *mut T) -> Result<(), E> {
 ///
 /// # Safety
 ///
-/// When implementing this type you will need to take great care. Also there are probably very few
+/// When implementing this trait you will need to take great care. Also there are probably very few
 /// cases where a manual implementation is necessary. Use [`init_from_closure`] where possible.
 ///
-/// The [`Init::__init`] function
+/// The [`Init::__init`] function:
 /// - returns `Ok(())` if it initialized every field of `slot`,
 /// - returns `Err(err)` if it encountered an error and then cleaned `slot`, this means:
 ///     - `slot` can be deallocated without UB occurring,
@@ -1013,7 +1013,7 @@ pub fn uninit<T, E>() -> impl Init<MaybeUninit<T>, E> {
 ///
 /// ```rust
 /// use kernel::{error::Error, init::init_array_from_fn};
-/// let array: Box<[usize; 1_000]>= Box::init::<Error>(init_array_from_fn(|i| i)).unwrap();
+/// let array: Box<[usize; 1_000]> = Box::init::<Error>(init_array_from_fn(|i| i)).unwrap();
 /// assert_eq!(array.len(), 1_000);
 /// ```
 pub fn init_array_from_fn<I, const N: usize, T, E>(
@@ -1027,7 +1027,7 @@ pub fn init_array_from_fn<I, const N: usize, T, E>(
         // Counts the number of initialized elements and when dropped drops that many elements from
         // `slot`.
         let mut init_count = ScopeGuard::new_with_data(0, |i| {
-            // We now free every element that has been initialized before:
+            // We now free every element that has been initialized before.
             // SAFETY: The loop initialized exactly the values from 0..i and since we
             // return `Err` below, the caller will consider the memory at `slot` as
             // uninitialized.
@@ -1056,7 +1056,7 @@ pub fn init_array_from_fn<I, const N: usize, T, E>(
 ///
 /// ```rust
 /// use kernel::{sync::{Arc, Mutex}, init::pin_init_array_from_fn, new_mutex};
-/// let array: Arc<[Mutex<usize>; 1_000]>=
+/// let array: Arc<[Mutex<usize>; 1_000]> =
 ///     Arc::pin_init(pin_init_array_from_fn(|i| new_mutex!(i))).unwrap();
 /// assert_eq!(array.len(), 1_000);
 /// ```
@@ -1071,7 +1071,7 @@ pub fn pin_init_array_from_fn<I, const N: usize, T, E>(
         // Counts the number of initialized elements and when dropped drops that many elements from
         // `slot`.
         let mut init_count = ScopeGuard::new_with_data(0, |i| {
-            // We now free every element that has been initialized before:
+            // We now free every element that has been initialized before.
             // SAFETY: The loop initialized exactly the values from 0..i and since we
             // return `Err` below, the caller will consider the memory at `slot` as
             // uninitialized.
diff --git a/rust/kernel/ioctl.rs b/rust/kernel/ioctl.rs
index f1d42ab69972..59050e5f5a5a 100644
--- a/rust/kernel/ioctl.rs
+++ b/rust/kernel/ioctl.rs
@@ -28,13 +28,13 @@ pub const fn _IO(ty: u32, nr: u32) -> u32 {
     _IOC(uapi::_IOC_NONE, ty, nr, 0)
 }
 
-/// Build an ioctl number for an read-only ioctl.
+/// Build an ioctl number for a read-only ioctl.
 #[inline(always)]
 pub const fn _IOR<T>(ty: u32, nr: u32) -> u32 {
     _IOC(uapi::_IOC_READ, ty, nr, core::mem::size_of::<T>())
 }
 
-/// Build an ioctl number for an write-only ioctl.
+/// Build an ioctl number for a write-only ioctl.
 #[inline(always)]
 pub const fn _IOW<T>(ty: u32, nr: u32) -> u32 {
     _IOC(uapi::_IOC_WRITE, ty, nr, core::mem::size_of::<T>())
diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 7d848b83add4..0a8569594fc3 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -449,7 +449,7 @@ pub(crate) fn pos(&self) -> *mut u8 {
         self.pos as _
     }
 
-    /// Return the number of bytes written to the formatter.
+    /// Returns the number of bytes written to the formatter.
     pub(crate) fn bytes_written(&self) -> usize {
         self.pos - self.beg
     }
diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index f12a684bc957..87e111c0da17 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -21,9 +21,9 @@
 /// # Safety
 ///
 /// - Implementers must ensure that only one thread/CPU may access the protected data once the lock
-/// is owned, that is, between calls to `lock` and `unlock`.
+///   is owned, that is, between calls to `lock` and `unlock`.
 /// - Implementers must also ensure that `relock` uses the same locking method as the original
-/// lock operation.
+///   lock operation.
 pub unsafe trait Backend {
     /// The state required by the lock.
     type State;
diff --git a/rust/kernel/sync/lock/spinlock.rs b/rust/kernel/sync/lock/spinlock.rs
index 068535ce1b29..e5e0bf621988 100644
--- a/rust/kernel/sync/lock/spinlock.rs
+++ b/rust/kernel/sync/lock/spinlock.rs
@@ -112,7 +112,7 @@ unsafe fn lock(ptr: *mut Self::State) -> Self::GuardState {
 
     unsafe fn unlock(ptr: *mut Self::State, _guard_state: &Self::GuardState) {
         // SAFETY: The safety requirements of this function ensure that `ptr` is valid and that the
-        // caller is the owner of the mutex.
+        // caller is the owner of the spinlock.
         unsafe { bindings::spin_unlock(ptr) }
     }
 }
diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index 498397877376..8775c34d12a5 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -253,7 +253,7 @@ fn run(mut this: Pin<Box<Self>>) {
 /// actual value of the id is not important as long as you use different ids for different fields
 /// of the same struct. (Fields of different structs need not use different ids.)
 ///
-/// Note that the id is used only to select the right method to call during compilation. It wont be
+/// Note that the id is used only to select the right method to call during compilation. It won't be
 /// part of the final executable.
 ///
 /// # Safety
-- 
2.43.0


