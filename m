Return-Path: <linux-kernel+bounces-47071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 579E98448CA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0B042882E6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1CA13D504;
	Wed, 31 Jan 2024 20:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3sn+vi6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874433FB2C;
	Wed, 31 Jan 2024 20:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706732649; cv=none; b=LSlXARwDDCIBkhm/fQUzCWin4SumC3T6zNEhTryyzeNXR/XmmaWgz6F8aoaMOeTrrCKWGf0D0LfvNBtKPKa+oeD7a+3y2XhIEqTdWS/PS1zx9kA6bxIaXgr2WuufWfkLyhJ78PeF+rkP9r+ydlq/nN9JUtV/LrOnRnZ/zUX7pKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706732649; c=relaxed/simple;
	bh=FA1F9SC1pBO6t7e2nw2RaFdLgUedeL9JkTxRX+R5a1k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IA8gcTj8m/20YHsW6z42z3di2PTlvjSDAFp63WRWZfGypkG0iATPdspnuJFriGE66o6gA02XT6UZ5qyoniEMAbscHkrfvzcALsAkmdeUA5+bDQt2tS5NHitj9tNWRiLR/kVrk7f3lRUZa3qGQuOfKjB+YpsLxoqGdZbVS9KeUN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M3sn+vi6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB7B1C433B2;
	Wed, 31 Jan 2024 20:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706732649;
	bh=FA1F9SC1pBO6t7e2nw2RaFdLgUedeL9JkTxRX+R5a1k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=M3sn+vi6Cu1BqqPG4lWEehKMEuMstzwT45trKG0phzxD+5JsFIKqi8OkMmlDTL2+F
	 AlzQJUSUyetwBHWF4VtgFllYGxJCp6EPCJZ2XyjUTcZxiC2etr842ulVk4l3Ei/vmp
	 nkg6L+eVT+xNK8uVB7F4vwzVRTPwPOga8Xrn6l1KsJb4P9a67xhCwt1lLjbdWz3/8t
	 ZgKR6tTGj7kWigoktA5X3lOqh8bdbJJVgB6FmCPtRiZjmgePKU8J3cBnf3fZR+DFlJ
	 UC0WycYvc5y4eY5W6VAvnmvGfDVJFUKfB2wgPaYuD/AmQpG/of6maTf6Q7SIW6ONSA
	 v00MsMB5HIvdw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B9DC48290;
	Wed, 31 Jan 2024 20:24:08 +0000 (UTC)
From: Valentin Obst via B4 Relay <devnull+kernel.valentinobst.de@kernel.org>
Date: Wed, 31 Jan 2024 21:23:27 +0100
Subject: [PATCH v3 05/12] rust: str: use `NUL` instead of 0 in doc comments
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-doc-fixes-v3-v3-5-0c8af94ed7de@valentinobst.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706732646; l=1199;
 i=kernel@valentinobst.de; s=20240131; h=from:subject:message-id;
 bh=t90awkZOfJrNEj9Nqg9r3N76iP/cmOjmkwvkrtyw/9I=;
 b=hqfaaXwqKw/qal+VSCs0YjOz+bA68/qcnK/d1pbkLbyCibjtbc31Gxbrt1UfSfIgjGoTLjxY6
 rJEeLkBTy2EDgEhqxS22yuDkLgnRAuGmCvQBc6KePEKQf5KT1v9gKbu
X-Developer-Key: i=kernel@valentinobst.de; a=ed25519;
 pk=3s7U8y0mqkaiurgHSQQTYWOo2tw5HgzCg5vnJVfw37Y=
X-Endpoint-Received:
 by B4 Relay for kernel@valentinobst.de/20240131 with auth_id=124
X-Original-From: Valentin Obst <kernel@valentinobst.de>
Reply-To: <kernel@valentinobst.de>

From: Valentin Obst <kernel@valentinobst.de>

Throughout the module, bytes with the value zero are referred to as
`NUL` bytes. Adapt the only two outliers.

Signed-off-by: Valentin Obst <kernel@valentinobst.de>
Reviewed-by: Trevor Gross <tmgross@umich.edu>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/str.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 0a8569594fc3..843ffeec9b3e 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -149,13 +149,13 @@ pub const fn as_char_ptr(&self) -> *const core::ffi::c_char {
         self.0.as_ptr() as _
     }
 
-    /// Convert the string to a byte slice without the trailing 0 byte.
+    /// Convert the string to a byte slice without the trailing `NUL` byte.
     #[inline]
     pub fn as_bytes(&self) -> &[u8] {
         &self.0[..self.len()]
     }
 
-    /// Convert the string to a byte slice containing the trailing 0 byte.
+    /// Convert the string to a byte slice containing the trailing `NUL` byte.
     #[inline]
     pub const fn as_bytes_with_nul(&self) -> &[u8] {
         &self.0

-- 
2.43.0


