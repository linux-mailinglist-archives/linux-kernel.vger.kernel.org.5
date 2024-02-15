Return-Path: <linux-kernel+bounces-66976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDD8856446
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84A75B21595
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E64130AC1;
	Thu, 15 Feb 2024 13:25:14 +0000 (UTC)
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [195.130.132.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB0E128837
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 13:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708003513; cv=none; b=OpLhr8xkdPgsJ49ItJy3VKWD07b0H4x7ekVGlAxl1d471mbXhoM1hn0p36321azcdlj6Edi+mrw7516NV6vBRGFTdc3UZKr/eiHuuwyTZgj1gjFiv/G8kOuA/cLx4nqeah2X6P9cds2UZ2Jit8kNDkkGj06eOHBveRYIrznxxyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708003513; c=relaxed/simple;
	bh=L5Fmt/vxvrj+Hm2BqAp6LP7B/rme3isGyU56p0X9Jo4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YOWb+idvBJkbjhxC5+CP4XQp4JOnrb3BDy3Oz/SwLyamZ1vol5xY5qgxvr6+BrJMnb6k5m+UrHp3YeffaZbNJBJzd0dF7KQMpvOxjZ3kV5PNQrMgXYrjrp+7mIpLQfsGzSmr1vaGMFzGqaP0xey5n3RlOj2pcNfCwWBAFX+5jls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:ac52:3a54:2a84:d65a])
	by xavier.telenet-ops.be with bizsmtp
	id nRRB2B0040LVNSS01RRBhu; Thu, 15 Feb 2024 14:25:11 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rabjb-000gz5-Nj;
	Thu, 15 Feb 2024 14:25:11 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rabjj-00HZiA-2z;
	Thu, 15 Feb 2024 14:25:11 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH resend] riscv: misaligned: Grammar s/disable/disabled/
Date: Thu, 15 Feb 2024 14:25:10 +0100
Message-Id: <e541754cd564253b2da9efa952479c75bb7fd2d6.1708003477.git.geert+renesas@glider.be>
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
index b49016bb5077b860..84b8200f7a625b07 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -706,7 +706,7 @@ config RISCV_MISALIGNED
 	default y
 	help
 	  Say Y here if you want the kernel to embed support for misaligned
-	  load/store for both kernel and userspace. When disable, misaligned
+	  load/store for both kernel and userspace. When disabled, misaligned
 	  accesses will generate SIGBUS in userspace and panic in kernel.
 
 config RISCV_EFFICIENT_UNALIGNED_ACCESS
-- 
2.34.1


