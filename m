Return-Path: <linux-kernel+bounces-47067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1CC8448C5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA84E1F222D8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2293612C534;
	Wed, 31 Jan 2024 20:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNprb6YD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B41405FF;
	Wed, 31 Jan 2024 20:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706732649; cv=none; b=lluPtye6TZARLTqrrDmbqOiLX/v6e1Kvzxij24/pZxGI7FJKWKT8ROdZUc2QRu7Pxo4vmHlsh1fedA5Own4t0sybH4KziPk2DXCmV62kTuj6kN2c/yfZW5brPnx/tiVKsApYKoJkRcu3DVIt7XqLC5mxhdrYlDQT8EaVUrhH0xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706732649; c=relaxed/simple;
	bh=wGJkNZWM5trjq8rhQ/Cfkn8OWEaE+kuNu9wG/5opVek=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L8h6rf0WyNVXO+Dc3PQstNAOAzxFQdfeHrQ0+hkzsOiUlwC2HfzTqsU3b0LSa07kfP4ra6i4/69OtZl9juei725Mo433T9dHi86Ol5uWRAr3Iv11cj4+I+KR8GO0C03T7Qd/Ae1ybl3AbkBHqvWgRdSn/GC0zQvo0df0VvOhD54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PNprb6YD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D6E63C43390;
	Wed, 31 Jan 2024 20:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706732648;
	bh=wGJkNZWM5trjq8rhQ/Cfkn8OWEaE+kuNu9wG/5opVek=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=PNprb6YDsVQC9K+TZzrTZxVZajBZtbt0v8EZOLlsgo9ic6ZIKGgwYkpOu18ml/JPB
	 28BjIcm5oWk4O6LQLH+iiXEXcEXVa6seXpRmH6OrgZ2v/xJ93r3nXlP+LVdK8O27yU
	 ibHmdCD0pFYnH0g1f1h3OrWJ4aBvRlp0M/IdmuhNXp7zjBVYBgAYtHzTz5xTs/KSBN
	 2KwOIuwx6xk6ziB6tee+6QrWwTQjkb7u5glUx6cA+3bAOZM5Wg29M4+irOTXT5crHh
	 DYxVPQBdVQoh8fx4X4mnK8BX4gaXRgsseQ1PL7kRO21Bx0oNpq+7jwsMQZuh/a1vp2
	 Tmjs5CmJiEDNw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C38C4828E;
	Wed, 31 Jan 2024 20:24:08 +0000 (UTC)
From: Valentin Obst via B4 Relay <devnull+kernel.valentinobst.de@kernel.org>
Date: Wed, 31 Jan 2024 21:23:25 +0100
Subject: [PATCH v3 03/12] rust: ioctl: end top-level module docs with full
 stop
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-doc-fixes-v3-v3-3-0c8af94ed7de@valentinobst.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706732646; l=787;
 i=kernel@valentinobst.de; s=20240131; h=from:subject:message-id;
 bh=RnmjgqCkBgtaoPxCHzDBkuKFgg4rjvv/297TJiMhnEQ=;
 b=DFYaExxkBLacWrAXEjYrfqcfudJkoubWg1dEDgUS4NWXXUrugAr3GKNQOtG7EKqVDRcOEdWOY
 oGHG7IZ5INYD7JdP0I4w3Hacu97rtIsCPjclv3/mroltWwWdXZWc1sN
X-Developer-Key: i=kernel@valentinobst.de; a=ed25519;
 pk=3s7U8y0mqkaiurgHSQQTYWOo2tw5HgzCg5vnJVfw37Y=
X-Endpoint-Received:
 by B4 Relay for kernel@valentinobst.de/20240131 with auth_id=124
X-Original-From: Valentin Obst <kernel@valentinobst.de>
Reply-To: <kernel@valentinobst.de>

From: Valentin Obst <kernel@valentinobst.de>

Every other module ends its first line of documentation with a full
stop. Adapt the only outlier.

Signed-off-by: Valentin Obst <kernel@valentinobst.de>
Reviewed-by: Trevor Gross <tmgross@umich.edu>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/ioctl.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/ioctl.rs b/rust/kernel/ioctl.rs
index 59050e5f5a5a..5987ad6d38a7 100644
--- a/rust/kernel/ioctl.rs
+++ b/rust/kernel/ioctl.rs
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
-//! ioctl() number definitions
+//! ioctl() number definitions.
 //!
 //! C header: [`include/asm-generic/ioctl.h`](srctree/include/asm-generic/ioctl.h)
 

-- 
2.43.0


