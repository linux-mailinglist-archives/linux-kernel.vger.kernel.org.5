Return-Path: <linux-kernel+bounces-28333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9815A82FD00
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98B261C2713A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064AC52F65;
	Tue, 16 Jan 2024 22:07:01 +0000 (UTC)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A277C50257;
	Tue, 16 Jan 2024 22:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705442820; cv=none; b=Pa2pDR8DIZwPkdeQRtUqNpoCYQEkbN0WZH43+rWD2r7K11ktUNCIvDcABHxokwNjJZSN8uI2qVrc8HSp2GIDbBFK2cSY69FJciwS4yaGgZRqVe5GzLn+ia2Q9TsZTnIsparGPWaXCkwWXs9+WJlEBylVBuIiQC4O3rsjyj5vJmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705442820; c=relaxed/simple;
	bh=j6+7rgEBCA/c/X5mKHo3VbMlssDcyBdbuCJWJNRxt8Y=;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-Provags-ID:
	 X-Spam-Flag:UI-OutboundReport; b=XBc9f+D7lub7wMlqyrAllmU6s/1UEOYCQRR7ozyQu0EG3KYHSoHFS7NFzgrOmBLEtOtSVQHa2bscmiOTC5KFZJDqO72hg91Rku1TZo1pgOjxME8Qpkx0vdLYXVvz5X7vL/T5HO3YL4VjtdzAEbfAAiZ61p10sjB7qhZBeMPLFM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de; spf=pass smtp.mailfrom=valentinobst.de; arc=none smtp.client-ip=212.227.126.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valentinobst.de
Received: from localhost.localdomain ([217.245.156.100]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MaIvV-1rc6xa1LD3-00WIzb; Tue, 16 Jan 2024 23:06:43 +0100
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
Subject: [PATCH 07/13] rust: kernel: unify spelling of refcount in docs
Date: Tue, 16 Jan 2024 23:06:34 +0100
Message-ID: <20240116220634.168103-1-kernel@valentinobst.de>
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
X-Provags-ID: V03:K1:LZw9oJjc57o5/lxghWGfTXEHpI9wO52N1Q7vBXUMuSrIikpUuFA
 /wRPeTCC2FC5I/fWxcg7HujN9BJ+9cfiyDvjerjofCYWK++qkNsZyn95dq7U3woXNxmTGEO
 I9HM7AYgD+VwsB3weGkdVoiOaZj99wNY/JsAqO3Wb5AmsQIsuznp679kqB5sOzqosRwkfmb
 X12P/4799wzyUNlPKdcGA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:B7paRzsauwk=;7Zg8OGMbyonRRdQLeSvE8EbvRuH
 DeuAgOrBxtUqEl++ypVX6kVQ42yPvKWxVh3lkhsKTLG4+5vxbEnD0htObVnBgt36h8eVG3byo
 n2TadqXG+CErGNXT0FtGoJ9RBDmoWvmcUvLxx5k8vcbhkQA8IsM3pTqDkNoor/LoTQqLVI/lu
 EJWbunYfwA6XLGkvfgR2KD7V9vz+KCD96d7XzvL6Xg3nOHlcpO0uX9M8oXMzz8xOitzFu3Aro
 Qw8yMkMjVpkQ9QrGeOoa2FhbJEl+db7cqc7DvoXmg0n/rpo3Y6ktWsKpOwnLh+zCZ2AagYH62
 LqMEjwilo5mugSIspBAKutImXdlEJDrD3zYn4xdlpaf0JPsxNghUh5I/NdFRQMOb9b/6ImMXj
 FuZELfBjJrBxB6OakEpfZa7jO83kWJiVKUyWutSybzCPJKxtErGUvhzIsrVug/0A3tkKtkyJy
 qwMMLd15SBoskdXmlKgs2KySrFANzkr5IUsb8wgW6jZRBzrgpiszzN2MzhVGMJ6HlKeTV4/YH
 kklnuK+2JB3Uz4b+FQL+1RwWL0y+4NuFSMlmeRaFRiPqc90CeBXh6ZYWl3fXQNCckdv9VsVfA
 vTZRaQeJUxoqEffd3LJUG/vZTGlSMXOHy9EtQPpqLu5YKSJTp31hMqoc0AsVWUPfuM+YzrIp9
 hNq4uIQliNqQ8SoOaHht2ZhgMbps9P9PTIDsU2dRUtDPw79H9qUxyNcP+EG0P37+7mDUxAkVv
 unIzN7nSuTm+LXfMClaBN/tY6CCUAFrRxD7QwClEPJ3c8p386XurE6YxeRqWuY8uLwTzxNsYr
 OX2jpxIiz9Wbw2cqQjlLNmHBqLVvskIoxZ9bh4zLCa4c3Lx2mP9+r+r8Es7vsUMSM5ZfqoOB0
 Qrywc77cH789l9Q==

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
index 9451932d5d86..818ac51b06b6 100644
--- a/rust/kernel/task.rs
+++ b/rust/kernel/task.rs
@@ -23,7 +23,7 @@ macro_rules! current {
 ///
 /// All instances are valid tasks created by the C portion of the kernel.
 ///
-/// Instances of this type are always ref-counted, that is, a call to `get_task_struct` ensures
+/// Instances of this type are always refcounted, that is, a call to `get_task_struct` ensures
 /// that the allocation remains valid at least until the matching call to `put_task_struct`.
 ///
 /// # Examples
@@ -147,7 +147,7 @@ pub fn wake_up(&self) {
     }
 }
 
-// SAFETY: The type invariants guarantee that `Task` is always ref-counted.
+// SAFETY: The type invariants guarantee that `Task` is always refcounted.
 unsafe impl crate::types::AlwaysRefCounted for Task {
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference means that the refcount is nonzero.
-- 
2.43.0


