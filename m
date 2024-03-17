Return-Path: <linux-kernel+bounces-105333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFDF87DC61
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 07:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFEFD1F212CA
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 06:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63655C142;
	Sun, 17 Mar 2024 06:01:51 +0000 (UTC)
Received: from rockwork.org (rockwork.org [45.32.92.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9D479C4
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 06:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.32.92.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710655311; cv=none; b=E4nn+No0IUfy/wT3EAtvnVwQtq8LTj9VBfOkrl4WCY1uvJWBtKe8t2G4qgRdk/ofanxAsGcL/M7io4Z7b+wL6INEy7L2SBrVUk1VGPr2ydAbHNEvoUQC2oGvutdBbjgbgrWXHx+tsLLI9GiZ4YuJJEVg3yW7jXnFd4tdoKTHEH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710655311; c=relaxed/simple;
	bh=3q+L8XNm/LiG5uw6hvwiHpIt1jjNID42bN9950zbjq8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rcDPts1wJUQae3WORwqc0MZetlqr4/blwIy0XhTPDJUQM8XXOZ571garU1QEgWERS+yzYos0SwFvoxfYasKkbGi4U2f7WnCT4Hgz3UQ/9VoF++J3zLRZdTdBGXORYc3LU6YQMmLOd7oRuiUV+UiFYl/kzcgUnZAl6xBr3zc6/VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rockwork.org; spf=pass smtp.mailfrom=rockwork.org; arc=none smtp.client-ip=45.32.92.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rockwork.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rockwork.org
Received: from rockdesk (unknown [IPv6:2408:8340:c40:490:6106:2b11:2955:ac3a])
	by rockwork.org (Postfix) with ESMTPSA id CB25B3E862;
	Sun, 17 Mar 2024 05:56:17 +0000 (UTC)
From: Xingyou Chen <rockrush@rockwork.org>
To: linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	ajones@ventanamicro.com,
	cleger@rivosinc.com,
	aou@eecs.berkeley.edu,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	Xingyou Chen <rockrush@rockwork.org>
Subject: [PATCH] riscv: typo in comment for get_f64_reg
Date: Sun, 17 Mar 2024 13:55:56 +0800
Message-ID: <20240317055556.9449-1-rockrush@rockwork.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Xingyou Chen <rockrush@rockwork.org>
---
 arch/riscv/kernel/fpu.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/fpu.S b/arch/riscv/kernel/fpu.S
index 2c543f130f93..327cf527dd7e 100644
--- a/arch/riscv/kernel/fpu.S
+++ b/arch/riscv/kernel/fpu.S
@@ -211,7 +211,7 @@ SYM_FUNC_START(put_f64_reg)
 SYM_FUNC_END(put_f64_reg)
 
 /*
- * put_f64_reg - Get a 64 bits FP register value and returned it or store it to
+ * get_f64_reg - Get a 64 bits FP register value and returned it or store it to
  *	 	 a pointer.
  * a0 = FP register index to be retrieved
  * a1 = If xlen == 32, pointer which should be loaded with the FP register value
-- 
2.43.0


