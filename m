Return-Path: <linux-kernel+bounces-78393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A33ED8612E2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E22D1F2503D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B1281AD3;
	Fri, 23 Feb 2024 13:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAYoe9Wa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DB97FBA7;
	Fri, 23 Feb 2024 13:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708695521; cv=none; b=CiTAHvJXwgRBh+P9/JR4URTN6n1SVq8YAmd7ysEZeCiLZVmMvLqy1TUYmVWzo+3IryFV1t2hB+HIlyX0dOhZ2YWdlgj3QWzVnal+EGDlnWd3WPqPlS9mcibXPC3w6qDBuU0U0TYDGxOm1R5UJ9pmSfaKPivhK/NbqnKnutPS2Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708695521; c=relaxed/simple;
	bh=GBY3CxtFjRdlkWk0xQcPhghSUX/TMHc7PXVii3OW0UI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PggK4/WE18tkMe3xk0ZkF5I3vMO5DydSZxRioKKI5bcIGRpB4RbBmScVSFOKw0Ml17TgmBV8W1WqWBoCF96laPo/Xe3c5NC7LzRUt3fT2OO2V9qCksMlCXVoqD3pW+opZOdsFY4dq97G8JdrG1WGRqt5aZGBTX2MVQ8Ola0YGZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NAYoe9Wa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84281C433C7;
	Fri, 23 Feb 2024 13:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708695521;
	bh=GBY3CxtFjRdlkWk0xQcPhghSUX/TMHc7PXVii3OW0UI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NAYoe9WaOvWjK1nqOgnvCRLfNM1vZZ77ud9LwZ25q4toItC75bJj1HTjri6c2gXdA
	 qx6gYl6UK3FaZPRWQtXRkeKeMNxLZH7BloLltp+gB9ahCt1OG+0ZTwxb3EoKpi6GYN
	 Mbq4hQSa43Hf4YoY1B0DUu9QUvy3j4JJyAdd74AV3Avzt5xg6Ox4FylJRDHG1oSfts
	 zB8IHxJFvZpDcgNweVSDpkC0wMuv3OWRL6SRzq91BNBWy7zk/+idBiurodqRLm6qSt
	 lGDm6eVu3pt63byZpq3ks1rLII5B+W750e8gG1wICoaebGb7eaw3n4SUrkPrpfsh/r
	 UHJujfNg9x3dg==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	rust-for-linux@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v2 2/3] scripts: generate_rust_target: enable building on RISC-V
Date: Fri, 23 Feb 2024 13:38:04 +0000
Message-ID: <20240223-employee-pessimism-03ba0b58db6b@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240223-leverage-walmart-5424542cd8bd@spud>
References: <20240223-leverage-walmart-5424542cd8bd@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1601; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=p3JdpTjlU4Gcdumuom76iCrubxUFIi9NJkWxSpqwhJ0=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDKk35u/5lrFAdfnzD1GuIt8lz140CmXaqXr44cXs8KWGK R2WOsGHOkpZGMQ4GGTFFFkSb/e1SK3/47LDuectzBxWJpAhDFycAjCRPSsYGSan/60+PG/FqTAG kUlzFlW8U7p6xSjmJYeo5ZTlD5iZ9rkxMnwt/bL+85NpTZyR6SErzVtmXlqpyCW6YMKvR3qGn5M 3MbMDAA==
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Miguel Ojeda <ojeda@kernel.org>

Add the required bits from rust-for-linux to enable generating a RISC-V
target for rust. The script, written by Miguel, was originally a
config file contributed by Gary.

Co-developed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 scripts/generate_rust_target.rs | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/scripts/generate_rust_target.rs b/scripts/generate_rust_target.rs
index 416c6b89e806..942ddca57ee4 100644
--- a/scripts/generate_rust_target.rs
+++ b/scripts/generate_rust_target.rs
@@ -171,6 +171,22 @@ fn main() {
         ts.push("llvm-target", "loongarch64-linux-gnusf");
         ts.push("llvm-abiname", "lp64s");
         ts.push("target-pointer-width", "64");
+    } else if cfg.has("RISCV") {
+        if cfg.has("64BIT") {
+            ts.push("arch", "riscv64");
+            ts.push("data-layout", "e-m:e-p:64:64-i64:64-i128:128-n64-S128");
+            ts.push("llvm-target", "riscv64-linux-gnu");
+            ts.push("target-pointer-width", "64");
+        } else {
+            panic!("32-bit RISC-V is an unsupported architecture");
+        }
+        ts.push("code-model", "medium");
+        ts.push("disable-redzone", true);
+        let mut features = "+m,+a".to_string();
+        if cfg.has("RISCV_ISA_C") {
+            features += ",+c";
+        }
+        ts.push("features", features);
     } else {
         panic!("Unsupported architecture");
     }
-- 
2.43.0


