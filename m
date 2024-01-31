Return-Path: <linux-kernel+bounces-47069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A2F8448C9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8821F1F248C6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B5C13D507;
	Wed, 31 Jan 2024 20:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mf8FNPTV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874163FB1E;
	Wed, 31 Jan 2024 20:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706732649; cv=none; b=bGq16jAkYXFMXXX2FCwGkrL7mkeXaGoCcUoicEU8m5ekzsmHbquMvxV1VWSKV4Kgd6gdmz3Hqo+2iYhQ35NNpdS2pQNc1DSdi3dFVtj6XAkG/loytiiIVywXqTPGSzY4hoRYbCKeLPa49diN2yS93P1ojlBfrJwzzVK0i7gpEyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706732649; c=relaxed/simple;
	bh=kdmvq8FHVvrhi/nhman0CJ4rcR5nU6JHLMJSECky02U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X0obyrUKO1zH/hsKu8UlJjR9/tOWj74XQHHbzVfakCeL9o9K5280UgfDo9IOtcWUrm51zGz9gzSbVjWzjACrNb13+1Xu1r8deh18MYO+RaUqi3Vk/EokpmauoEL2LR+MjNWr0njfRwbOxSoU8QTj2uLZxG6kCJKWt0l0cPGQYdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mf8FNPTV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E4FF6C433B1;
	Wed, 31 Jan 2024 20:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706732649;
	bh=kdmvq8FHVvrhi/nhman0CJ4rcR5nU6JHLMJSECky02U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=mf8FNPTVEHtCFME3wbDfqX8jnVZPnLquQ0k0gghT4YZgFFDRo4r8sJ5jR7RDhQKLM
	 sKRr1cvgO8gW5G7tY9VEB9rUHHlQVQjjXNttVeTefEMNoTzJNr9XZgeCa6pZg9VGqz
	 NVnka9Y7Jib63yQlyvCdgfKrb+0CCxvS0YzyfG0zRKjk2QyjVVc3m5vcSjm92xHpot
	 9JWRqyW9p8fJtwpAxHwbaSR6QbBU9/X7OsWhpNxhgHk4S/ggOIPfxrsUWzXhw/7pH7
	 dM3ZBL4Q/k3KSQGz3WRnVxw3asICcsw32ztX8pOy+ayUeXXEBQ5OqpoCNW02ugz6RW
	 P4sjJ/CDb/6eA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD724C4828D;
	Wed, 31 Jan 2024 20:24:08 +0000 (UTC)
From: Valentin Obst via B4 Relay <devnull+kernel.valentinobst.de@kernel.org>
Date: Wed, 31 Jan 2024 21:23:26 +0100
Subject: [PATCH v3 04/12] rust: kernel: add srctree-relative doclinks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-doc-fixes-v3-v3-4-0c8af94ed7de@valentinobst.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706732646; l=1495;
 i=kernel@valentinobst.de; s=20240131; h=from:subject:message-id;
 bh=kLgaqmllmKNEoPT8KkSdoCC7kj+DdGrDcoL6QfU76KA=;
 b=7S3b+DjY5YBQva6+YSgVQsa22uB6Rj3uPyuLUNr8VssbgZuwJb/abEN7dWypql8P+MEF2keoc
 weVwL3OLTgqDx5AquVTxmPWwyq1xxyVqvm6sbHhS8rgqT9XMEwXLPWG
X-Developer-Key: i=kernel@valentinobst.de; a=ed25519;
 pk=3s7U8y0mqkaiurgHSQQTYWOo2tw5HgzCg5vnJVfw37Y=
X-Endpoint-Received:
 by B4 Relay for kernel@valentinobst.de/20240131 with auth_id=124
X-Original-From: Valentin Obst <kernel@valentinobst.de>
Reply-To: <kernel@valentinobst.de>

From: Valentin Obst <kernel@valentinobst.de>

Convert existing references to C header files to make use of
Commit bc2e7d5c298a ("rust: support `srctree`-relative links").

Signed-off-by: Valentin Obst <kernel@valentinobst.de>
Reviewed-by: Trevor Gross <tmgross@umich.edu>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/lib.rs          | 2 +-
 rust/kernel/sync/condvar.rs | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index b89ecf4e97a0..74581c958a6c 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -78,7 +78,7 @@ pub trait Module: Sized + Sync {
 
 /// Equivalent to `THIS_MODULE` in the C API.
 ///
-/// C header: `include/linux/export.h`
+/// C header: [`include/linux/export.h`](srctree/include/linux/export.h)
 pub struct ThisModule(*mut bindings::module);
 
 // SAFETY: `THIS_MODULE` may be used from all threads within a module.
diff --git a/rust/kernel/sync/condvar.rs b/rust/kernel/sync/condvar.rs
index 9f1d83589beb..fa1794972aa0 100644
--- a/rust/kernel/sync/condvar.rs
+++ b/rust/kernel/sync/condvar.rs
@@ -87,6 +87,8 @@ pub struct CondVar {
 
     /// A condvar needs to be pinned because it contains a [`struct list_head`] that is
     /// self-referential, so it cannot be safely moved once it is initialised.
+    ///
+    /// [`struct list_head`]: srctree/include/linux/types.h
     #[pin]
     _pin: PhantomPinned,
 }

-- 
2.43.0


