Return-Path: <linux-kernel+bounces-91156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FC1870A2E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D66722815EA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA9779922;
	Mon,  4 Mar 2024 19:11:01 +0000 (UTC)
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [195.130.132.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D79B7AE56
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 19:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709579461; cv=none; b=tVkzcZrbSxyQqyV/6mKt8HfrxYMf4bsZ3/Zy44lITFbphozTcQFLAHiF9uiXvbtzrsp2YZrZG00jynfVgxru4ZcLzucSoT1XW7pKvI8nYz+NbGl7Jtbfl2DYbUi1sWMKO/wUT9TLW/dkBbvpjaT1vSKOFTqD3tO/1fEfBpStTWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709579461; c=relaxed/simple;
	bh=H/gQxfV3suXjIp6hEocMHk10NKKhL2CfpxOu/Ql0GOw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OeMunFtida4RJMmoCYDGhSVBqr0rtscO4jpmCTyUm+Yy3OzoFJcSSOzIne+WHU+EiuqFa7DvjBP9Kv0xLBi7wkp1Z4d5TRnjooRLqa3S9nsAHYKn/cXMAb8HBL7uW7Ous0lyMZWgoBufmMmrfz6xQ6ZqJFFfgutybotcDJtVd/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:2716:1247:52e8:4f90])
	by baptiste.telenet-ops.be with bizsmtp
	id ujAr2B00F2qflky01jAr7d; Mon, 04 Mar 2024 20:10:52 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rhDhv-002KJx-Lw;
	Mon, 04 Mar 2024 20:10:51 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rhDi7-00BCcj-Bz;
	Mon, 04 Mar 2024 20:10:51 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 3/7] sh: mach-highlander: Add missing #include <mach/highlander.h>
Date: Mon,  4 Mar 2024 20:10:45 +0100
Message-Id: <bbbc833d2c5b565122baaf9277ddf4a2f2cadead.1709579038.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1709579038.git.geert+renesas@glider.be>
References: <cover.1709579038.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

arch/sh/boards/mach-highlander/pinmux-r7785rp.c:9:13: warning: no previous prototype for ‘highlander_plat_pinmux_setup’ [-Wmissing-prototypes]

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/sh/boards/mach-highlander/pinmux-r7785rp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sh/boards/mach-highlander/pinmux-r7785rp.c b/arch/sh/boards/mach-highlander/pinmux-r7785rp.c
index 703179faf652b242..689bd8732d9eedbc 100644
--- a/arch/sh/boards/mach-highlander/pinmux-r7785rp.c
+++ b/arch/sh/boards/mach-highlander/pinmux-r7785rp.c
@@ -5,6 +5,7 @@
 #include <linux/init.h>
 #include <linux/gpio.h>
 #include <cpu/sh7785.h>
+#include <mach/highlander.h>
 
 void __init highlander_plat_pinmux_setup(void)
 {
-- 
2.34.1


