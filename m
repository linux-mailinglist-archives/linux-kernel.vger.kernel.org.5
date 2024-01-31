Return-Path: <linux-kernel+bounces-47070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8941B8448CB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEAB4B27352
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E10013D4FD;
	Wed, 31 Jan 2024 20:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OuwgKaRI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873DB3FB10;
	Wed, 31 Jan 2024 20:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706732649; cv=none; b=IQmyLNfK9s9rhVpHtAGXds34McCkaZZPm+KENdXXKQLQMToDeLdupaeq+unKBuskKmPNDeZUx9w5LxIeG4p89htXxFRePWWix41l0vOsgRl7LRRPdpkMBhxTVDMpGcG+v1K44px5wKs7BBuyAwUP6zTQane3/kTpYYXs1tczJB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706732649; c=relaxed/simple;
	bh=qvu+Ox0zu6pevZi9vcwFq2laTuQ829Sreeg9+Gf9HMA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ha4CUTaAZ9GRhvTUOGYHn50lLJ0SL1CzkQxkyEr4GUYhdObWtpIGS8AKYKzQei2HM5oFHWcZbh+feRwT6ddaekj7EFJjtBmAO4R1x0Fome5NXwfdomW9tUxNu5xkB17a6vr/5IkG4VvkWpQYCAH6ae2gTaVUqXwepAk/W6gQBIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OuwgKaRI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0167CC43609;
	Wed, 31 Jan 2024 20:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706732649;
	bh=qvu+Ox0zu6pevZi9vcwFq2laTuQ829Sreeg9+Gf9HMA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=OuwgKaRINXpUT2P3BU1WdF1vAyAXW3peXAdlYywNwt14Min7HHn7HD+6DU52/R/Z+
	 S/46KIJhqMw0JQsMvCD/rAVXWkthWfTH7thRZDYiG1tZwwITgxXRjmGUWYJKpN87og
	 R6linx8xN+ucJpMVLwgW1eWRb5AAZ4JIM5y8KnK0KNS+o0nt7JEewgL0tzAVUnXqLb
	 wU823bsaRnkJ3utxA0se8DmZ2RrdEcUJxcBisNyDL3fRPs3Y8gEFCoIpYnB4109SeV
	 JqItdzw8Rq4kdq8m2RczMbzW3Zjlj4boiKzmnFhf68w7YS7+nK2mq2SXQfUtDViM3h
	 4q5o4Cke4OxOw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D52C47258;
	Wed, 31 Jan 2024 20:24:08 +0000 (UTC)
From: Valentin Obst via B4 Relay <devnull+kernel.valentinobst.de@kernel.org>
Date: Wed, 31 Jan 2024 21:23:28 +0100
Subject: [PATCH v3 06/12] rust: str: move SAFETY comment in front of unsafe
 block
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240131-doc-fixes-v3-v3-6-0c8af94ed7de@valentinobst.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706732646; l=1018;
 i=kernel@valentinobst.de; s=20240131; h=from:subject:message-id;
 bh=DDoG48Qq56LKmbADR58N8ly1qfgI3wpt9bk2atcwP2I=;
 b=MZe2Hxv9roGYl7lqeSTsKZTqoSJKgkFsgca/PD3aFOr4ulKBTBblhv38PbvagOpZGWXWbWtyj
 YNvZipM8WUGDw3pFzMQXX3OxChgETuOQVPLM3td+l4AGy5t/ZaHB/O5
X-Developer-Key: i=kernel@valentinobst.de; a=ed25519;
 pk=3s7U8y0mqkaiurgHSQQTYWOo2tw5HgzCg5vnJVfw37Y=
X-Endpoint-Received:
 by B4 Relay for kernel@valentinobst.de/20240131 with auth_id=124
X-Original-From: Valentin Obst <kernel@valentinobst.de>
Reply-To: <kernel@valentinobst.de>

From: Valentin Obst <kernel@valentinobst.de>

SAFETY comments should immediately precede the unsafe block they
justify. Move assignment to `bar` past comment as it is safe.

Signed-off-by: Valentin Obst <kernel@valentinobst.de>
Reviewed-by: Trevor Gross <tmgross@umich.edu>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/str.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 843ffeec9b3e..fec5c4314758 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -191,9 +191,9 @@ pub fn to_str(&self) -> Result<&str, core::str::Utf8Error> {
     /// ```
     /// # use kernel::c_str;
     /// # use kernel::str::CStr;
+    /// let bar = c_str!("ツ");
     /// // SAFETY: String literals are guaranteed to be valid UTF-8
     /// // by the Rust compiler.
-    /// let bar = c_str!("ツ");
     /// assert_eq!(unsafe { bar.as_str_unchecked() }, "ツ");
     /// ```
     #[inline]

-- 
2.43.0


