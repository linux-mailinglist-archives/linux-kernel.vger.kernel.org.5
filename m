Return-Path: <linux-kernel+bounces-48662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCB4845F7E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5049A1C296E5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2F012E1C0;
	Thu,  1 Feb 2024 18:07:19 +0000 (UTC)
Received: from mail.someserver.de (mail.someserver.de [116.202.193.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8050884FC5;
	Thu,  1 Feb 2024 18:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.193.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706810839; cv=none; b=lhmOxoCR6j9xG30P71NDE43OYBogv2Sahw1MOflrNVBGKJdHjP9u/7HaCQB40l1wMp4f/eEel5S2anzX3vgJJlwUwB8HnJh0nRBNUOsU7Soun0NS2sO2N5JALXZEdz8gayxJEcsFv9QZ+tQAjVF6aHOGJ/vYimuKbflChKlQsqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706810839; c=relaxed/simple;
	bh=I9yo8gFF9g6Nktp5khK01f/99bXfCpCeui/xCrTFEX0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jaeqw0/DX8LyMACjAD6mrdbcIz4pYRKBWCFCG3ZBMpXtzxZ9FtnUyN2ofn6v7Q3NXiKnBrpozmsSo97HYZF5ECKasOAPURAIUCzpbLqGmW400oBpq8qj55DrKRWncVNAg6px67UKO37LRd50tBJQ/Lw6C6KzLMagDv0SnbtIRkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=christina-quast.de; spf=pass smtp.mailfrom=christina-quast.de; arc=none smtp.client-ip=116.202.193.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=christina-quast.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=christina-quast.de
Received: from localhost (unknown [195.162.191.218])
	by mail.someserver.de (Postfix) with ESMTPSA id 2965DA21AE;
	Thu,  1 Feb 2024 19:07:13 +0100 (CET)
From: Christina Quast <contact@christina-quast.de>
Date: Thu, 01 Feb 2024 19:06:58 +0100
Subject: [PATCH v2 1/3] DONOTMERGE: rust: prelude: add bit function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240201-rockchip-rust-phy_depend-v2-1-c5fa4faab924@christina-quast.de>
References: <20240201-rockchip-rust-phy_depend-v2-0-c5fa4faab924@christina-quast.de>
In-Reply-To: <20240201-rockchip-rust-phy_depend-v2-0-c5fa4faab924@christina-quast.de>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Wedson Almeida Filho <wedsonaf@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@samsung.com>, 
 Alice Ryhl <aliceryhl@google.com>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Trevor Gross <tmgross@umich.edu>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, 
 Christina Quast <contact@christina-quast.de>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706810819; l=1166;
 i=contact@christina-quast.de; s=20240130; h=from:subject:message-id;
 bh=I9yo8gFF9g6Nktp5khK01f/99bXfCpCeui/xCrTFEX0=;
 b=PD/auZkWvS/a6RAELm9LZMt+cqhgGaqOca8QQUD5tdAWmf0dbh8OFZXYaJmqZgB58v2xzsXPY
 6aq5k52d6jBD1X+2SRUI45jUSSAeNaaKZovXt/2kXeZa7O2MuqHekKw
X-Developer-Key: i=contact@christina-quast.de; a=ed25519;
 pk=aoQfinjbnr265vCkIZdYteLDcmIqLBhY1m74WfFUU9E=

In order to create masks easily, the define BIT() is used in C code.
This commit adds the same functionality to the rust kernel.

Do not merge this commit, because rust/kernel/types.rs in Rust-for-Linux
already contains this functionality and will be merged into next-net
soon.
But this driver does not compile without this commit, so I am adding it
to the patchset to get more feedback on the actual driver.

Signed-off-by: Christina Quast <contact@christina-quast.de>
---
 rust/kernel/prelude.rs | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
index ae21600970b3..16e483de2f27 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -38,3 +38,19 @@
 pub use super::init::{InPlaceInit, Init, PinInit};
 
 pub use super::current;
+
+/// Returns a `u32` number that has only the `n`th bit set.
+///
+/// # Arguments
+///
+/// * `n` - A `u32` that specifies the bit position (zero-based index)
+///
+/// # Example
+///
+/// ```
+/// let b = bit(2);
+/// assert_eq!(b, 4);
+#[inline]
+pub const fn bit(n: u32) -> u32 {
+    1 << n
+}

-- 
2.43.0


