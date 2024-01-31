Return-Path: <linux-kernel+bounces-47075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E39BB8448CE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFD5028204A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74AE13D51D;
	Wed, 31 Jan 2024 20:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZwJccGhP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5837866F;
	Wed, 31 Jan 2024 20:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706732649; cv=none; b=YyPtGRxSSzq6mqO5Q8hWAwNfKB26+xhpmG1ud7SC+rupq14aGcp5A8glAGIYc9xcFLPThSnMZxZgloSjqCiUgvsnfrSD0s+JuFuhhuSkMOZS6AC9ncFSf+XUAmxDa6G6i4Igkp8LqzRYTQFC/HIP+pwd4ceFwjBaso6UF+AChQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706732649; c=relaxed/simple;
	bh=qtayRPJ/adeWhbKoR+73scBOhW61yyOyCVFDV1rrQQk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XaZ5MGfA6CHeMrTyjvioDQK+h4D5jghyc0RBsfOEyto9iKQsnSgiSEz/25JC9tw4+3Hw+tufuGqA+E6luZjsQuNB83vQwll94ZC9rWsEL6P2g+al45srQ1/BnAv+6e7/tj41YZlbAcib3kKzMlbwyhX30Z8G+8IcbSnMAULMN7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZwJccGhP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0950FC43141;
	Wed, 31 Jan 2024 20:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706732649;
	bh=qtayRPJ/adeWhbKoR+73scBOhW61yyOyCVFDV1rrQQk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ZwJccGhP4NSavvRUDPStbCopCAnVg+T68orFpmFbENGnAAyKO9FNEYjSx7u7J4Npd
	 Saxl2THmCBTsFqOciattHbr+d0q8AkQb8ZXOHzj6rntt+Xf94a7pEI60WSCqaYxqQs
	 4p2GrkOi5MuCe5d/KMD0fRB7Ir278RgPq0sm3LnFpN7LZPd8hI0PiolupPwXM42bNb
	 v5mBo97913g/+NmGa5uG5Tq/cgOoGkvKOMe9Vtg72rrZ1IaYjfTg5evWWyiWg0vVqR
	 Go7zXPQM7s2sIYB35mvPp1KGGXAU7kUrTcHTdwR+Bb1sv0jEj1Cj031SoU3/ChDA2Z
	 uXm+SIt635AGg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF53C4828F;
	Wed, 31 Jan 2024 20:24:08 +0000 (UTC)
From: Valentin Obst via B4 Relay <devnull+kernel.valentinobst.de@kernel.org>
Date: Wed, 31 Jan 2024 21:23:29 +0100
Subject: [PATCH v3 07/12] rust: kernel: unify spelling of refcount in docs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-doc-fixes-v3-v3-7-0c8af94ed7de@valentinobst.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706732646; l=3612;
 i=kernel@valentinobst.de; s=20240131; h=from:subject:message-id;
 bh=QKfC4Yx2YuMhbVoUU+HsBYOAmy4hrhjLwyi1rK9J+vA=;
 b=cJ0rU/cLrFYxQveHJSf8kBibCQ+wP0mbRY7IOhdp9xuHNGZCB9eWtfFYX5GKRhGxstervDr2Z
 09J+P5+4MjYAYHLcf/aEy8xWjKU5IFP6K1Dt5JmFEeqja6W78i2fmGO
X-Developer-Key: i=kernel@valentinobst.de; a=ed25519;
 pk=3s7U8y0mqkaiurgHSQQTYWOo2tw5HgzCg5vnJVfw37Y=
X-Endpoint-Received:
 by B4 Relay for kernel@valentinobst.de/20240131 with auth_id=124
X-Original-From: Valentin Obst <kernel@valentinobst.de>
Reply-To: <kernel@valentinobst.de>

From: Valentin Obst <kernel@valentinobst.de>

Replace instances of 'ref-count[ed]' with 'refcount[ed]' to increase
consistency within the Rust documentation. The latter form is used more
widely in the rest of the kernel:

```console
$ rg '(\*|//).*?\srefcount(|ed)[\s,.]' | wc -l
1605
$ rg '(\*|//).*?\sref-count(|ed)[\s,.]' | wc -l
43
```

(numbers are for Commit 052d534373b7)

Signed-off-by: Valentin Obst <kernel@valentinobst.de>
Reviewed-by: Trevor Gross <tmgross@umich.edu>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/sync/arc.rs | 8 ++++----
 rust/kernel/task.rs     | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 77cdbcf7bd2e..6c46b1affca5 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -56,7 +56,7 @@
 ///     b: u32,
 /// }
 ///
-/// // Create a ref-counted instance of `Example`.
+/// // Create a refcounted instance of `Example`.
 /// let obj = Arc::try_new(Example { a: 10, b: 20 })?;
 ///
 /// // Get a new pointer to `obj` and increment the refcount.
@@ -510,7 +510,7 @@ fn deref(&self) -> &Self::Target {
 /// # test().unwrap();
 /// ```
 ///
-/// In the following example we first allocate memory for a ref-counted `Example` but we don't
+/// In the following example we first allocate memory for a refcounted `Example` but we don't
 /// initialise it on allocation. We do initialise it later with a call to [`UniqueArc::write`],
 /// followed by a conversion to `Arc<Example>`. This is particularly useful when allocation happens
 /// in one context (e.g., sleepable) and initialisation in another (e.g., atomic):
@@ -560,7 +560,7 @@ impl<T> UniqueArc<T> {
     /// Tries to allocate a new [`UniqueArc`] instance.
     pub fn try_new(value: T) -> Result<Self, AllocError> {
         Ok(Self {
-            // INVARIANT: The newly-created object has a ref-count of 1.
+            // INVARIANT: The newly-created object has a refcount of 1.
             inner: Arc::try_new(value)?,
         })
     }
@@ -574,7 +574,7 @@ pub fn try_new_uninit() -> Result<UniqueArc<MaybeUninit<T>>, AllocError> {
             data <- init::uninit::<T, AllocError>(),
         }? AllocError))?;
         Ok(UniqueArc {
-            // INVARIANT: The newly-created object has a ref-count of 1.
+            // INVARIANT: The newly-created object has a refcount of 1.
             // SAFETY: The pointer from the `Box` is valid.
             inner: unsafe { Arc::from_inner(Box::leak(inner).into()) },
         })
diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
index a3a4007db682..6726f1056066 100644
--- a/rust/kernel/task.rs
+++ b/rust/kernel/task.rs
@@ -39,7 +39,7 @@ macro_rules! current {
 ///
 /// All instances are valid tasks created by the C portion of the kernel.
 ///
-/// Instances of this type are always ref-counted, that is, a call to `get_task_struct` ensures
+/// Instances of this type are always refcounted, that is, a call to `get_task_struct` ensures
 /// that the allocation remains valid at least until the matching call to `put_task_struct`.
 ///
 /// # Examples
@@ -163,7 +163,7 @@ pub fn wake_up(&self) {
     }
 }
 
-// SAFETY: The type invariants guarantee that `Task` is always ref-counted.
+// SAFETY: The type invariants guarantee that `Task` is always refcounted.
 unsafe impl crate::types::AlwaysRefCounted for Task {
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference means that the refcount is nonzero.

-- 
2.43.0


