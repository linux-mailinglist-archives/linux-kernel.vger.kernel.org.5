Return-Path: <linux-kernel+bounces-33316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2557836850
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42A521F20FF6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C9F47F47;
	Mon, 22 Jan 2024 15:04:20 +0000 (UTC)
Received: from michel.telenet-ops.be (michel.telenet-ops.be [195.130.137.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4433247F41
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 15:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935860; cv=none; b=Pg9LwktvBkZyCBuqOUOsqG6pCAwgfO+P5Y5n1465JsNbcJdKZmxpvHJHqlG+fxZxWVezptkwAwRLxaufEWpfTuZfzQrsaB32fKgYg6NMFvplG6HPh0PaM/SzKOLSxP7FY/sgQ5UJEOmsBuei5Rk+1s6brn0IWP74jRlBbEgJxFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935860; c=relaxed/simple;
	bh=xsdzq8Jbr/araPOKURvJcUktUloOPaI4gTd8nU8y6XA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KqxT0NHRo5Dc3bnBKxRFmkYQFS6ZEWwOHIAO3uDPYgFPl+r/QJh2B/TzGM3tlJ9rmz7As4LLVu0pfyJ+SSP7xfR7jBo2PxMscH9FgoTDxUQVLAU6DwnoulWFjKYa0fEPwdkQrH6nm5qjaBYVEtGA0xiyR3M5gxgX7HJdn56NZrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:955e:bba5:7ff4:cfb6])
	by michel.telenet-ops.be with bizsmtp
	id dr4F2B00V0ZxL6o06r4Gxl; Mon, 22 Jan 2024 16:04:16 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rRvpe-00GH0U-Qq;
	Mon, 22 Jan 2024 16:04:15 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rRvqR-00CG1D-QJ;
	Mon, 22 Jan 2024 16:04:15 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Conor Dooley <conor@kernel.org>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] soc: microchip: Fix POLARFIRE_SOC_SYS_CTRL input prompt
Date: Mon, 22 Jan 2024 16:04:14 +0100
Message-Id: <607c5ba8b95b1a11b6dc532223e9d7abcc2c20e4.1705935812.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The symbol's prompt should be a one-line description, instead of just
duplicating the symbol name.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/soc/microchip/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/microchip/Kconfig b/drivers/soc/microchip/Kconfig
index 9b0fdd95276e4e01..19f4b576f822b2e5 100644
--- a/drivers/soc/microchip/Kconfig
+++ b/drivers/soc/microchip/Kconfig
@@ -1,5 +1,5 @@
 config POLARFIRE_SOC_SYS_CTRL
-	tristate "POLARFIRE_SOC_SYS_CTRL"
+	tristate "Microchip PolarFire SoC (MPFS) system controller support"
 	depends on POLARFIRE_SOC_MAILBOX
 	depends on MTD
 	help
-- 
2.34.1


