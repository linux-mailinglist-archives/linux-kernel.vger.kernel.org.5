Return-Path: <linux-kernel+bounces-35623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C88C83944F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DD661F24F0F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2966B61673;
	Tue, 23 Jan 2024 16:08:08 +0000 (UTC)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC22612F0;
	Tue, 23 Jan 2024 16:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706026087; cv=none; b=YdmIXQQZWk/qN7Cku+oPyMSd1JCC9wl0eHrl/tnMZhs27Csk9RQjgbZ9ttWS98fyAlbytF1mrQxbFTnWCuMjPdKH9oy9siftOJPL5+h0p97gJ1ejdcccCJp7AHIN9ICuKzSXYwDkLYtj4/SfNvAU80wKO0uHPQOEsQaiebVv+Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706026087; c=relaxed/simple;
	bh=dcjqT6LwDiJet5DL11/RabzBcNLvOWMbGrooPlheAbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MruHhD4GgquAfw8qz0mTKwdVOcvGqhrR54JaeVQDJkWsQekYLl17Eurhzki5Do4WKgs44yWStUPvtuM+djhBl0V0szstZRYwCnt9izvlsiwi9cWs8VcXUcvVpau3j7zSErVIEm19TL1/fL1WQ649mAd2bFwnDPCnh2I6/EYwgFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de; spf=pass smtp.mailfrom=valentinobst.de; arc=none smtp.client-ip=212.227.126.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valentinobst.de
Received: from localhost.localdomain ([95.223.130.98]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MLRDv-1rj1DV3Ck7-00IRcC; Tue, 23 Jan 2024 17:07:46 +0100
From: Valentin Obst <kernel@valentinobst.de>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/12] rust: kernel: unify spelling of refcount in docs
Date: Tue, 23 Jan 2024 17:07:46 +0100
Message-ID: <20240123160746.125310-1-kernel@valentinobst.de>
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
X-Provags-ID: V03:K1:oz7nBXnl6WKtzIifeIQQp/y21tgQTbcqFqguCS0tl9mId5WT3FO
 x0bHGtitmGuCGA52GfmAok6Uv0oxPEhw4nwzkpYcQXosTUi/ce0AFZHxruVeUfwGoECgddW
 tpuZUIZsjfY5/0IgMODQXzjWHWY1S7gGoG7cQbpu7JcKm14+o1+xCuJdIvSnidY8p7WIWcY
 i74nOrBvOfe1nXKdxqByw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:cqVRWdgTbnM=;Cv2PKUFiZOF7VUI4CrEaqm5CXBG
 jrhytFZRysztOUiuiX7xEe3B08xilN/ZdVlJqdsOCvn2w9qxicfXhwcpOwu1e1w2kPci3DDYw
 Xlz8jSxQTFC0Hb2Ro96ojSKVanOKBIJcbsmNCxfO6fY/QccEOOmqWytO2vcPIXGGJkttB+gp5
 Y3FT/N9RfcXoUw/S0/KA3DGL3kPVXT3HRMe0ji3bI8f6YezI9r/LnxFs2GMEdGVD+b9mJYUI2
 1+l10wx374HQlFlOK7eU2uhVWQAISQ6E1VObAVbuiCr4gVKZhcNLgvD7Ml8M+NyCt3MtqcvaY
 i3a7+4gEBIiyaH7Oj5yUJ07v0zgpHMNmEigQEkCgK4WyRULVC9va+bsWG+zFDm9jFg975eQif
 7XmeutsgG2t6lPAy5TlYAeg+SdUokA66H7oFwzW54vmeDgujEI8jC+VUVFGBDyHJR6BmcqL/3
 cd5+zshZByTo0JIByCNb05G4sCxdoRDTnQWJ28DVuIY+7354HSm3GmFiHylsCbU3624At+2Ks
 oRG2Hu9zucXK651K6wb83laVvN3a3Cl5ozJ1W6mBF0yG+38noSKTmqM+DVCZSzPWF9tLFzinQ
 HRij5k3zZu5mr8yborq3Ka/A9rjJGCwfTgRERm8pBgInG4lpNnY86FNkQCjHDDCxo8A6ZIe7E
 q6i+f/utTyYd8sWaN7GBVU+bJWfRFya8vqGxrcwE1CtTqnX/O550WGYctOTHrMdDyBz4QLYiW
 ZlzaJEafG4DiiuCBa6j/67oHBoGcfz90pu+8WPWkiF+ydlPL7IEG67yWB/8tlyeVtFYH5qZuy
 BBsgr5GV2Xbi0/wkoF5ns69L5Cqx/tqVGoH9EkQ6Twdee8Gqs6VTF5cDFcuNlpRZXEB/I3v5i
 xPVkcuTc0db9LTQ==

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


