Return-Path: <linux-kernel+bounces-28366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1463E82FDA4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 00:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 263B81C2659F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBB11BF5E;
	Tue, 16 Jan 2024 23:10:20 +0000 (UTC)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615AC747C;
	Tue, 16 Jan 2024 23:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705446619; cv=none; b=S2IABM3eNLOPTMOjrOni9aPj/lKBu28mgV/6BiXAyL/LMaM4A1SdVp+guwSfMZcUWLRJVz7A7UNMA9YxBJuPBD/X646yuHxVKw9lJavzcGj/OJ1S/g+G6Oa24+2EapvJ+UzOJIOqstzk+MYJNrKpeLoludvhLG2OxXHnWmowGpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705446619; c=relaxed/simple;
	bh=CZ7nKrqhhNF2pFJNM9siYB8MbfbW8gtSc1B3+Vk9ZE0=;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-Provags-ID:
	 X-Spam-Flag:UI-OutboundReport; b=eAZC1Y1XuNzhHR14sbeQpKimzKgJdZd6SE/adrLpN/BuonSM02SGX5TzhMJ89RVNekRzMtKM9OWGEyD26KKbXC4QTTADCIHvc64REk5eHtvWUlj2agt30cbA7hLuI+2U5IjvOniXriZrv3ayuofD3vP3VZxiBLNPhnpYrrWD/Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de; spf=pass smtp.mailfrom=valentinobst.de; arc=none smtp.client-ip=212.227.126.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valentinobst.de
Received: from localhost.localdomain ([217.245.156.100]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mw9Dg-1r7Ni60Y9E-00s3Gk; Wed, 17 Jan 2024 00:09:58 +0100
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
Subject: [PATCH 08/13] rust: kernel: mark code fragments in docs with backticks
Date: Wed, 17 Jan 2024 00:09:51 +0100
Message-ID: <20240116230951.168808-1-kernel@valentinobst.de>
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
X-Provags-ID: V03:K1:wsYRVP+9i0BrZ6my14LK0meIR1rCYBN7Lm9fbdVaOsY7zBcTIGO
 EEFNqthbwPz3ogMXHrVS8MRzcfsxnVkRhe468aOJoxMUd1PtiS5IAZiCMa8UMwdlcXBMz5H
 sK7qy8DuRGD8kSpw3ZPXgIwEtpD/gS0XzUalEeM4GRcD29oDz0DHd3RJPsvoNpCV9XlJNs1
 OcVgL9xGHIi/iCz2q6TNg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:W30ecyRewBo=;wvY9r0144BnswLQcU8dj4le0K03
 R5Ny7mbnEZ+eixrRf90+qoXDEoBwnMQ3W7DRtaPl1h4zuyixGJAENMhGplPQXg4aLoLagylmh
 1BZmH79O+ILgG2pSQwnVBu8jgDFrClRKThjO/NmbcFwST34CAA2hgOM5//+DZZhp37LXIsm50
 MLDtaPYCNfUiUKBUaoq8KycM9vgbSykaW6O/U8n73YDcG9HnhF2Xo+vZWso4rDSguvssUUY7M
 iXO14mX52V+9QhDBKQzzXhfr0LInsiZTrxFZLaHwihsHR4y8wJkE5xQDgSNE/8a+rKJHpMCLw
 PhAnSbuXzuWOVv8jOhX5UjE3Yo5BnRPDWW2biQBnA4Cbz/+sCABxDGvZPTyaahOMVdUOqWcLw
 u0lctsoy/+Bf+y0lbYpieZOh76LaQ1og8v4TaKV+WU8zc4zUjvOCWT/YLV4Nic0kgrke/FBWg
 relULteLJ++pCQN7vdKA0jXILwCYXxHG+ClV8mVL8HX6V4XwjWsASVJRjrMOd4ZuutPv7m7vW
 CYyaT3Bd2KfeMk+W+u7RU0x3ORpdoSsKo2I4kyqOIH8jTO1e9ledk6QKJuXnaZhFqtFX0Jh+c
 hi8EeQDjjoSqADJ4y+UTWJnSa2YpaQK8E5Fe+GvmkkIgHjgq7HbzJAtFDow8S5XTnQFa2Ej8o
 OnWXvNejIUXpGfkwjVuDpPdI1UJLvzdDqBuu9zCzTtew2GFl5OylxIKEhwszXN1frL/pFpoI0
 7unrsr46/CvPqUUw76YJZkJA/Dye3xj4adJzhZDzdNi7tpUt/kF2fwXJNTUAAu2ZHbi7tlMpb
 ldtJcXj+6mlw9MMdMMvQ/AAIlpsaZmA99FZv6jduo/CJ5Uyk1oO6rL50dCfwmn6WR7YAyIUd7
 WtKSDg+2rWStQoA==

Fix places where comments include code fragments that are not enclosed
in backticks.

Signed-off-by: Valentin Obst <kernel@valentinobst.de>
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
index f12a684bc957..467249b39f71 100644
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


