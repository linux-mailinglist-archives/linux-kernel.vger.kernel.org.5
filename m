Return-Path: <linux-kernel+bounces-47064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0746E8448C8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AB391F276E7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F66133998;
	Wed, 31 Jan 2024 20:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9cafvoJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A05F405FB;
	Wed, 31 Jan 2024 20:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706732649; cv=none; b=ew3iRqkGfJ/yQciF6lCbBmKhcVpTflfXFBrk/HBOs1gREH1DyR76QFu+nv9iAsK6c4XQZ59Fe+jqWAr3JIop9fvlA+njTMHB2qTqhK+2R1pz4dVkyvRjFQOsu9fdQuzkfIw+R0xNcFH7Ob/uypaQLNWEtSxk8r+dr6eb5EOwI00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706732649; c=relaxed/simple;
	bh=PvtMQBD1nzrPCWrpIxzcWBmhKwGTdsFy2wiCmXx5kmc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lPwc6WusXyv2p/I5jOlNKUqh0HSAhOZdhpYvLGfwU166XUKRPfl+KAjZTx2CWJfVwwaMTzRv2zY+nYC01LzCMxvFPwh3DLhKiTV6aY421MFKkycR7qeTHvBykvWIwpc2s/xdOvi/lsNsg1u26lsfPJvNGxmcF/iPZttjOf0wEaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9cafvoJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9CA3C433F1;
	Wed, 31 Jan 2024 20:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706732648;
	bh=PvtMQBD1nzrPCWrpIxzcWBmhKwGTdsFy2wiCmXx5kmc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=E9cafvoJF0JXHvi2eNyiaSY200M0Sp2uhQ6moobZxgZIjUMiRkrIpMn3EklDCBkVz
	 /oIxVpNmHtkN6tJN+Fyi/EHsog/L84nodmF0iSPKHv/e2ckJjdwqRkLBw00wufN0GD
	 Q64tgfMLD0PWebgApJ+Tcc1dLRQryrSrcgKG3i+IRQJdffhZUclT6Bcp3VKNCKX77A
	 w2XJAIwOZDbToOWpoy6rlJecx9n+wdrwqFals+z+L/Uv6iQs54QBE9gh1woRoaKBVp
	 rSWVrVqy0JsCtNG29HZplN+l38g9Wg3awXle6MhT3GRtECKbZ8IeHpV9q9lE60/wBf
	 OyYgS9ihbswQw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD84DC48285;
	Wed, 31 Jan 2024 20:24:08 +0000 (UTC)
From: Valentin Obst via B4 Relay <devnull+kernel.valentinobst.de@kernel.org>
Date: Wed, 31 Jan 2024 21:23:23 +0100
Subject: [PATCH v3 01/12] rust: kernel: fix multiple typos in documentation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-doc-fixes-v3-v3-1-0c8af94ed7de@valentinobst.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706732646; l=9277;
 i=kernel@valentinobst.de; s=20240131; h=from:subject:message-id;
 bh=jWhzEv3VcHW57738U5ZKKHmNbKt/A7SeH+hRAr2L2Bk=;
 b=QY87KrykNPYCphGyXkSBtlMng+/CCeRX5yyJaO90ypoGHxmiwefLYtHxVSaqdkgiFiTZD+q++
 /2luZABdQmlD6bDQWk6mh/755foHs+alRCJwsiaKZLzatLel2fdGOeH
X-Developer-Key: i=kernel@valentinobst.de; a=ed25519;
 pk=3s7U8y0mqkaiurgHSQQTYWOo2tw5HgzCg5vnJVfw37Y=
X-Endpoint-Received:
 by B4 Relay for kernel@valentinobst.de/20240131 with auth_id=124
X-Original-From: Valentin Obst <kernel@valentinobst.de>
Reply-To: <kernel@valentinobst.de>

From: Valentin Obst <kernel@valentinobst.de>

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
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
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
index 149a5259d431..072b8ef2a0fa 100644
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


