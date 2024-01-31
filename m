Return-Path: <linux-kernel+bounces-47076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 911278448D0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D33F2897B4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CE213DBA2;
	Wed, 31 Jan 2024 20:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JBfhkEnS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92B778B6C;
	Wed, 31 Jan 2024 20:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706732649; cv=none; b=Dqwsu62fUCz2AL5L3fWE0H8JRtH4zyk+L2Ym7i+s0/HPPQ8iQVwK6Tf/JSk+ArUk7Nijfp61WITp6nDt/ffpqK7PBnA9euyaBW2NLxAI4U9qFtYnBDeHaOXzEfeH9VOUyU/VRoZnjASycyNUS1A1JngBeIMkpeigmZ0PnOZ9LJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706732649; c=relaxed/simple;
	bh=Z6DzNv6aKwU5F0iVgt7H+eG2SqQrz3L9funW8c2FQog=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZtgOtZOJhI3/cDqy0t+OUWuudTha+rghWkg/HSoD97Wf4zuyElWlzk95fY1bRqjRYn6Rjcm7OTn32aGh1BKPtMgjwSBzDhGz4LQw7pysWavOiILw1ZIc/RaSQY5HAXGph+f21jH8ag2gwS1Hm3WySnDCOCUXONYmvAZARmURmkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JBfhkEnS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3ED32C433A6;
	Wed, 31 Jan 2024 20:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706732649;
	bh=Z6DzNv6aKwU5F0iVgt7H+eG2SqQrz3L9funW8c2FQog=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=JBfhkEnSHeD17O6buGBZ8K+MTzx7xslYy0BFyd0LmELLO60pOr1ISHbdm5AXXlj1d
	 +Y63vuak+bLpi3T4ykduf4l1sBSLlKXaQ0Myzfvsxb3wUvRwbioSQU6MTvKuU1EtpQ
	 jRE5jm0Cns/wtGT4eButGtSQmiojaH4B6U17FsCDjmi4rQ/I6V4rmJvUIz5iBGYLTs
	 UPwQGuHcqwdo3wbIpP20UhlymyVIhEzD0uO3Z5RYVLvANCBjDaB2IjaVsNGhC8668H
	 Z1ZAIScccmEwArsteApeN3mJvnWHGwmeyTVIFS9X+PgHMLZAnmS8aeVYvElXRxZ8Fv
	 ygAWcV3NrtgSQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC0CC4828D;
	Wed, 31 Jan 2024 20:24:09 +0000 (UTC)
From: Valentin Obst via B4 Relay <devnull+kernel.valentinobst.de@kernel.org>
Date: Wed, 31 Jan 2024 21:23:34 +0100
Subject: [PATCH v3 12/12] rust: locked_by: shorten doclink preview
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-doc-fixes-v3-v3-12-0c8af94ed7de@valentinobst.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706732646; l=1666;
 i=kernel@valentinobst.de; s=20240131; h=from:subject:message-id;
 bh=sqg0B5Wr1bFP5Krb6u5ZgMS6Wtgf+9jYvaOmeO5jfXs=;
 b=lQBqbaRJYx0+ptyykohvXQroXhFbdrLF8+38IIQ+Mrgzdcc4iQGLoNEXfOVgcOP4WxwiMVtZ7
 lHRemgJ/QGwD5JvssVna2L6r4kIbhLvEGdxnqRbd19Zmt64CVD0tjKM
X-Developer-Key: i=kernel@valentinobst.de; a=ed25519;
 pk=3s7U8y0mqkaiurgHSQQTYWOo2tw5HgzCg5vnJVfw37Y=
X-Endpoint-Received:
 by B4 Relay for kernel@valentinobst.de/20240131 with auth_id=124
X-Original-From: Valentin Obst <kernel@valentinobst.de>
Reply-To: <kernel@valentinobst.de>

From: Valentin Obst <kernel@valentinobst.de>

Increases readability by removing `super::` from the link preview
text.

Signed-off-by: Valentin Obst <kernel@valentinobst.de>
Reviewed-by: Trevor Gross <tmgross@umich.edu>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/sync/locked_by.rs | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/sync/locked_by.rs b/rust/kernel/sync/locked_by.rs
index b17ee5cd98f3..babc731bd5f6 100644
--- a/rust/kernel/sync/locked_by.rs
+++ b/rust/kernel/sync/locked_by.rs
@@ -9,14 +9,17 @@
 /// Allows access to some data to be serialised by a lock that does not wrap it.
 ///
 /// In most cases, data protected by a lock is wrapped by the appropriate lock type, e.g.,
-/// [`super::Mutex`] or [`super::SpinLock`]. [`LockedBy`] is meant for cases when this is not
-/// possible. For example, if a container has a lock and some data in the contained elements needs
+/// [`Mutex`] or [`SpinLock`]. [`LockedBy`] is meant for cases when this is not possible.
+/// For example, if a container has a lock and some data in the contained elements needs
 /// to be protected by the same lock.
 ///
 /// [`LockedBy`] wraps the data in lieu of another locking primitive, and only allows access to it
 /// when the caller shows evidence that the 'external' lock is locked. It panics if the evidence
 /// refers to the wrong instance of the lock.
 ///
+/// [`Mutex`]: super::Mutex
+/// [`SpinLock`]: super::SpinLock
+///
 /// # Examples
 ///
 /// The following is an example for illustrative purposes: `InnerDirectory::bytes_used` is an

-- 
2.43.0


