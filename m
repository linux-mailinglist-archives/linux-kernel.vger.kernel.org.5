Return-Path: <linux-kernel+bounces-47073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E11C48448CC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10E041C2349B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA14713D511;
	Wed, 31 Jan 2024 20:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rGExPr9+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3F35D90E;
	Wed, 31 Jan 2024 20:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706732649; cv=none; b=Mca4QRsTfZfce+HNQjaj98RZ2c7P3ES/4pV+z65bR4KUM3SQHbkzRQGvs3Aq/PRh9K0Rcd/th+3SkfRu4d4soGYsFKr0oK3bvUhHIadYsv6v6Hrrn2rUz/QIbR4B4gTy+aH7Kg2Ae1TR7wiEdXMmWy3RkAIVuRCFOZ+Ve8gHTWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706732649; c=relaxed/simple;
	bh=oEOEYI5XD7Gl9YRicVq5JZCnoGI82gQIloe6mONRHjU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XgIZDLYFqIS9OhVCQ3jyJ4ioNa+JAjBWUVXhDV1P7tO3rwmD8rnLsyp9jP7872FgfD77y672BHFC2QfxOTjGtGQlJTqxw3FyqhtC2GxkFbGwaZ8I+hZyzXMY7ZkzLh6jwSGJKcjBkxSrvM/7NZgDvYXb3DZn7XosqxdzcqXsoR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rGExPr9+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1F205C4166C;
	Wed, 31 Jan 2024 20:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706732649;
	bh=oEOEYI5XD7Gl9YRicVq5JZCnoGI82gQIloe6mONRHjU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rGExPr9+3ePh7IQJE1IiBqRGNyopfOoMG0OTUQ0ZNelBntg7+PMd6SILPolM6XYg+
	 q8InwkqMCMp8fzu5jzSomz190Id6CC7IV+hN4VOlbuWyz+5jjHJdCQz4RApuOQK2GT
	 XXBl6x957ki7uhKVEbxo60AchBYFGaDxbeMWHKsGQ+VCoZ7rMPQVzqJT8pw6kfSt/R
	 BJacbHKDBijbyldbvGPVkwIwBcdAEgHMrquzhA6V3Vrs4keXq47aNc/yPGXxDokjRU
	 TGOEnqmRIjsd0KG/UwIWwZsqO/JIJR2EcfCqmrJqSHZ+mcPc+j48+n9U1idTkfmxqS
	 gcLFGzEuwog1w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB54C48291;
	Wed, 31 Jan 2024 20:24:09 +0000 (UTC)
From: Valentin Obst via B4 Relay <devnull+kernel.valentinobst.de@kernel.org>
Date: Wed, 31 Jan 2024 21:23:31 +0100
Subject: [PATCH v3 09/12] rust: kernel: add blank lines in front of code
 blocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-doc-fixes-v3-v3-9-0c8af94ed7de@valentinobst.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706732646; l=1527;
 i=kernel@valentinobst.de; s=20240131; h=from:subject:message-id;
 bh=uY1sZnb/LMfFXaWeBAwEM8DMFKBsaytN4jZN05O/ykE=;
 b=99dau8uj89rQF+Ui2JVfPI4xnHVD6+T01C8FkwBqgFe94TWEWf3h/+vqiyLPqj9bgVxIXeeWy
 Sz7HbN+z06sBam3gLTECfS+tY1SSHGwiOu6AV7FDJFKsZ4pC8ygnQKz
X-Developer-Key: i=kernel@valentinobst.de; a=ed25519;
 pk=3s7U8y0mqkaiurgHSQQTYWOo2tw5HgzCg5vnJVfw37Y=
X-Endpoint-Received:
 by B4 Relay for kernel@valentinobst.de/20240131 with auth_id=124
X-Original-From: Valentin Obst <kernel@valentinobst.de>
Reply-To: <kernel@valentinobst.de>

From: Valentin Obst <kernel@valentinobst.de>

Throughout the code base, blank lines are used before starting a code
block. Adapt outliers to improve consistency within the kernel crate.

Signed-off-by: Valentin Obst <kernel@valentinobst.de>
Reviewed-by: Trevor Gross <tmgross@umich.edu>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/types.rs | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index fdb778e65d79..8aabe348b194 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -90,6 +90,7 @@ unsafe fn from_foreign(_: *const core::ffi::c_void) -> Self {}
 ///
 /// In the example below, we have multiple exit paths and we want to log regardless of which one is
 /// taken:
+///
 /// ```
 /// # use kernel::types::ScopeGuard;
 /// fn example1(arg: bool) {
@@ -108,6 +109,7 @@ unsafe fn from_foreign(_: *const core::ffi::c_void) -> Self {}
 ///
 /// In the example below, we want to log the same message on all early exits but a different one on
 /// the main exit path:
+///
 /// ```
 /// # use kernel::types::ScopeGuard;
 /// fn example2(arg: bool) {
@@ -129,6 +131,7 @@ unsafe fn from_foreign(_: *const core::ffi::c_void) -> Self {}
 ///
 /// In the example below, we need a mutable object (the vector) to be accessible within the log
 /// function, so we wrap it in the [`ScopeGuard`]:
+///
 /// ```
 /// # use kernel::types::ScopeGuard;
 /// fn example3(arg: bool) -> Result {

-- 
2.43.0


