Return-Path: <linux-kernel+bounces-28369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F87782FDAB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 00:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47C341C266B1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4928B1DA53;
	Tue, 16 Jan 2024 23:11:38 +0000 (UTC)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965A61DA2C;
	Tue, 16 Jan 2024 23:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705446697; cv=none; b=gOpulVKLC9e+wl0plkDFr2CnoZMCulnvR8v+Fa9ULL/NmCv1gd5mA1zyvspYRyVY8WmjWjIA3ERiVWwgwF5VisgKbSvlIqzMVk9xnwT+5UJu8fmt1Jh6IN1ucP9BcF+ENIQUQyBC/T5BC1hKi8uzA1VFpp27DM9XQJhdzqHFjPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705446697; c=relaxed/simple;
	bh=MGssKXKFpJmMR/MBNNgGqevsBNhT1o85Az3TxIhlZAM=;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-Provags-ID:
	 X-Spam-Flag:UI-OutboundReport; b=Nw9WMs2vAMRh//pqLFcRY4rGUe5S/rrgNPZ8W4JY2BSlIIQwVUiOM6jV3oKp0/TKEKK2uesUn2bQdVU5/qOky50cK7N27P3SecB3FbdA6hMUjWVpvUFdh+N8SFtIbgpRVHqW/SeZmHK0LMnVjTaRUsh6tgyEqhOsRP5K3XvAvec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de; spf=pass smtp.mailfrom=valentinobst.de; arc=none smtp.client-ip=212.227.126.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valentinobst.de
Received: from localhost.localdomain ([217.245.156.100]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MWAjC-1reqJ90vEo-00XaJ8; Wed, 17 Jan 2024 00:11:21 +0100
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
Subject: [PATCH 11/13] rust: kernel: add doclinks with html tags
Date: Wed, 17 Jan 2024 00:11:18 +0100
Message-ID: <20240116231118.168882-1-kernel@valentinobst.de>
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
X-Provags-ID: V03:K1:7HDVl5ICHcjvu8IpxbaBi4RT96IEY2WzS7HNpagrRLMKzjKGrrp
 HNDQsDnObQM5UfrcYAKFPKwKCa5nfWzXvBIhcQwMJ9ILV9sF0MGkg7zqBWx5GBG/DFKg4br
 w6eGrh4MfDydzwKak28EhlPwcRYRAEDzgEpaXfBiZvigBZhg7xTY6oby3zkYbHY8xe5FyRR
 EZsHCecWfOGzI74G8BReA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5/VYKVZVSV4=;5l1Im1o2v77FVLbOqnVkHhisSp0
 k7AS8oXGuUvRGhQthNOkF/ZLN3ir5LJulRiGMeaQCTZ8BdgQ6/YkrwDFPI4w+e1AWm9BOaata
 OwdzxKXhi6TEGb6SXsDir/NhL+ssLJIGSCMeDs0Cy1JrZKM+Qm66e1TeY9I5wggc4oHl2fYJa
 cFCv87mieIxot1SuDI3up88/WIJ8ZMGdHF5VTMTR2uydvg3Nh4zyKpdEyCMW5CSInX6gGUB+Q
 0owTLgdWQlMzEzG7XN1S+fSLi3fBSalsGUE68KI3+KAfs566BsmTMHbF0sq4vscw9to+P3oG/
 tHyydKRGmstfuTZqjYX9hPSTBb7BZUiXJsIQEnRtnLB4wDob8znUlmqwAaMYxT2d9osf+Dvdm
 rolqsi7ke/u/R6L5Ni8OC4HPwMoqAgqOgHs6rzxPIUS7drdvwqQRCPUPYoNodytJxSuBWPYzE
 Tvet71iNl/dLwjI6KmFwlyU6uAJeGy+49vGe9Zyf8tm9EXn2ixIGjpoTtx7vRiS9v32AZuY2d
 f/c2lCYKh5BqYnWCO+Hv2v3jQiuTaqGidN2N9kFlV4f3zwsttmUVgb+VNkttlMUnCfIwg+3ky
 gdRVX69LvhRifswlpnEQHDxbF+dKnlp3XefUiCXRDUkJgWkog8W/yAE1NPRrTVstsGDyo3zNH
 9eeik+58hxfoJSf7shMMg2+rtDNoum2MQvMYWKHq8b3oEGuP2XNOLgMDUyu1+e+USqehxJBeT
 dHigE4RXSqu63/wzgmF1N6GY7poSDkVloE0wyzT3W7EkcnP/glVszmjoG0nBAGtK52wfBnuu2
 omZd/jRq5030D5HlJxGpHiv3MHJIG5kurtqQZq2QuE2idwkoTJ7noDkiHxDtD/D4vYz11ub+h
 Gz4TCR8aGjt+yTw9Mq4WffazeSk724w8ufBM=

Add doclinks to existing documentation. Use html 'code' tags to add
links to items that cannot be linked with the normal syntax.

The use of html tags is a tradeoff between the readability of the
documentation's source code and the ergonomics of the generated content.

Signed-off-by: Valentin Obst <kernel@valentinobst.de>
---
 rust/kernel/str.rs       |  7 ++++---
 rust/kernel/sync/arc.rs  | 24 +++++++++++++-----------
 rust/kernel/workqueue.rs | 10 +++++-----
 3 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index fec5c4314758..f95fd2ba19fb 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -14,7 +14,8 @@
 
 /// Byte string without UTF-8 validity guarantee.
 ///
-/// `BStr` is simply an alias to `[u8]`, but has a more evident semantical meaning.
+/// `BStr` is simply an alias to <code>[[u8]]</code>, but has a more evident
+/// semantical meaning.
 pub type BStr = [u8];
 
 /// Creates a new [`BStr`] from a string literal.
@@ -106,7 +107,7 @@ pub unsafe fn from_char_ptr<'a>(ptr: *const core::ffi::c_char) -> &'a Self {
         unsafe { Self::from_bytes_with_nul_unchecked(bytes) }
     }
 
-    /// Creates a [`CStr`] from a `[u8]`.
+    /// Creates a [`CStr`] from a <code>[[u8]]</code>.
     ///
     /// The provided slice must be `NUL`-terminated, does not contain any
     /// interior `NUL` bytes.
@@ -130,7 +131,7 @@ pub const fn from_bytes_with_nul(bytes: &[u8]) -> Result<&Self, CStrConvertError
         Ok(unsafe { Self::from_bytes_with_nul_unchecked(bytes) })
     }
 
-    /// Creates a [`CStr`] from a `[u8]` without performing any additional
+    /// Creates a [`CStr`] from a <code>[[u8]]</code> without performing any additional
     /// checks.
     ///
     /// # Safety
diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 936bc549a082..5fcd4b0fd84b 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -368,10 +368,10 @@ fn from(item: Pin<UniqueArc<T>>) -> Self {
 /// to use just `&T`, which we can trivially get from an [`Arc<T>`] instance.
 ///
 /// However, when one may need to increment the refcount, it is preferable to use an `ArcBorrow<T>`
-/// over `&Arc<T>` because the latter results in a double-indirection: a pointer (shared reference)
-/// to a pointer ([`Arc<T>`]) to the object (`T`). An [`ArcBorrow`] eliminates this double
-/// indirection while still allowing one to increment the refcount and getting an [`Arc<T>`] when/if
-/// needed.
+/// over <code>&[`Arc<T>`]</code> because the latter results in a double-indirection: a pointer
+/// (shared reference) to a pointer ([`Arc<T>`]) to the object (`T`). An [`ArcBorrow`] eliminates
+/// this double indirection while still allowing one to increment the refcount and getting an
+/// [`Arc<T>`] when/if needed.
 ///
 /// # Invariants
 ///
@@ -489,8 +489,8 @@ fn deref(&self) -> &Self::Target {
 /// # Examples
 ///
 /// In the following example, we make changes to the inner object before turning it into an
-/// `Arc<Test>` object (after which point, it cannot be mutated directly). Note that `x.into()`
-/// cannot fail.
+/// <code>[Arc]\<Test\></code> object (after which point, it cannot be mutated directly).
+/// Note that `x.into()` cannot fail.
 ///
 /// ```
 /// use kernel::sync::{Arc, UniqueArc};
@@ -512,8 +512,9 @@ fn deref(&self) -> &Self::Target {
 ///
 /// In the following example we first allocate memory for a refcounted `Example` but we don't
 /// initialise it on allocation. We do initialise it later with a call to [`UniqueArc::write`],
-/// followed by a conversion to `Arc<Example>`. This is particularly useful when allocation happens
-/// in one context (e.g., sleepable) and initialisation in another (e.g., atomic):
+/// followed by a conversion to <code>[Arc]\<Example\></code>. This is particularly useful when
+/// allocation happens in one context (e.g., sleepable) and initialisation in another
+/// (e.g., atomic):
 ///
 /// ```
 /// use kernel::sync::{Arc, UniqueArc};
@@ -532,8 +533,8 @@ fn deref(&self) -> &Self::Target {
 /// ```
 ///
 /// In the last example below, the caller gets a pinned instance of `Example` while converting to
-/// `Arc<Example>`; this is useful in scenarios where one needs a pinned reference during
-/// initialisation, for example, when initialising fields that are wrapped in locks.
+/// <code>[Arc]\<Example\></code>; this is useful in scenarios where one needs a pinned reference
+/// during initialisation, for example, when initialising fields that are wrapped in locks.
 ///
 /// ```
 /// use kernel::sync::{Arc, UniqueArc};
@@ -582,7 +583,8 @@ pub fn try_new_uninit() -> Result<UniqueArc<MaybeUninit<T>>, AllocError> {
 }
 
 impl<T> UniqueArc<MaybeUninit<T>> {
-    /// Converts a `UniqueArc<MaybeUninit<T>>` into a `UniqueArc<T>` by writing a value into it.
+    /// Converts a <code>UniqueArc<[`MaybeUninit<T>`]></code> into a `UniqueArc<T>`
+    /// by writing a value into it.
     pub fn write(mut self, value: T) -> UniqueArc<T> {
         self.deref_mut().write(value);
         // SAFETY: We just wrote the value to be initialized.
diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index ed3af3491b47..aedf47f258bd 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -294,9 +294,9 @@ unsafe fn __enqueue<F>(self, queue_work_on: F) -> Self::EnqueueOutput
 
 /// Defines the method that should be called directly when a work item is executed.
 ///
-/// This trait is implemented by `Pin<Box<T>>` and [`Arc<T>`], and is mainly intended to be
-/// implemented for smart pointer types. For your own structs, you would implement [`WorkItem`]
-/// instead. The [`run`] method on this trait will usually just perform the appropriate
+/// This trait is implemented by <code>[Pin]<[`Box<T>`]></code> and [`Arc<T>`], and is mainly
+/// intended to be implemented for smart pointer types. For your own structs, you would implement
+/// [`WorkItem`] instead. The [`run`] method on this trait will usually just perform the appropriate
 /// `container_of` translation and then call into the [`run`][WorkItem::run] method from the
 /// [`WorkItem`] trait.
 ///
@@ -325,8 +325,8 @@ pub unsafe trait WorkItemPointer<const ID: u64>: RawWorkItem<ID> {
 ///
 /// This trait is used when the `work_struct` field is defined using the [`Work`] helper.
 pub trait WorkItem<const ID: u64 = 0> {
-    /// The pointer type that this struct is wrapped in. This will typically be `Arc<Self>` or
-    /// `Pin<Box<Self>>`.
+    /// The pointer type that this struct is wrapped in. This will typically be
+    /// <code>[Arc]\<Self\></code> or <code>[Pin]<[Box]\<Self\>></code>.
     type Pointer: WorkItemPointer<ID>;
 
     /// The method that should be called when this work item is executed.
-- 
2.43.0


