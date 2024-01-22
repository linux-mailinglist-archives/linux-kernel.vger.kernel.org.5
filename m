Return-Path: <linux-kernel+bounces-33314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DBC83684C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E3291C21F10
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E9647788;
	Mon, 22 Jan 2024 15:03:21 +0000 (UTC)
Received: from albert.telenet-ops.be (albert.telenet-ops.be [195.130.137.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AD33D976
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 15:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935801; cv=none; b=N61Bvcsj5/AiLM0b4va7ZBNROv5/OeYD/k6/GRW9/pISJNZrRcSptAFoge2EXvroQcgA/jaV0Bal20513AyKc1u0m1A7fsZlcknv/oYxI43vTfcmN0/2cBLO0Py3w63GvYj3JE2qz29+vI7zKNy82WsHoVnaovvb5FNlKlcZvpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935801; c=relaxed/simple;
	bh=WOMTvRjBaywwDoiQZYdAyQ3gMBMD/Ts44r2FLWVxMYk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I+tOEP9gcBunw03nzLcdH3lbxZk0sA8VSgN+GeJUZ5zjR/+HykUlkxuLzgCoIU5lfGNHb36Nbkzz3r+t31UdBPwLcmp+RCEO/u2+z8USswzQVEf83Saqz/rzRcU3rfIoSSuLKHpRTp4776cQppZN8yArNwnPEv3CgXuAMdU/Jzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:955e:bba5:7ff4:cfb6])
	by albert.telenet-ops.be with bizsmtp
	id dr3B2B0040ZxL6o06r3BKN; Mon, 22 Jan 2024 16:03:11 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rRvob-00GH0P-SX;
	Mon, 22 Jan 2024 16:03:10 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rRvpO-00CFzl-S0;
	Mon, 22 Jan 2024 16:03:10 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] riscv: misaligned: Grammar s/disable/disabled/
Date: Mon, 22 Jan 2024 16:03:09 +0100
Message-Id: <c10ca3e18a783f6fc7ada13782e5f789e9fc2e7b.1705935488.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a wrong conjugation of "disabled".

Fixes: 7c83232161f609bb ("riscv: add support for misaligned trap handling in S-mode")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/riscv/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 69d24f51392206bd..f1b22d11e0b63b32 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -693,7 +693,7 @@ config RISCV_MISALIGNED
 	default y
 	help
 	  Say Y here if you want the kernel to embed support for misaligned
-	  load/store for both kernel and userspace. When disable, misaligned
+	  load/store for both kernel and userspace. When disabled, misaligned
 	  accesses will generate SIGBUS in userspace and panic in kernel.
 
 config RISCV_EFFICIENT_UNALIGNED_ACCESS
-- 
2.34.1


