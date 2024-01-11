Return-Path: <linux-kernel+bounces-23449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E78D82ACDD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F9C2282B0B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85B914F8C;
	Thu, 11 Jan 2024 11:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="pgGmg4MF"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F7B15482;
	Thu, 11 Jan 2024 11:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=4FvuXbjORVZUNuiHro
	y0xyda+f52Z6Gdyv4aILQqr9g=; b=pgGmg4MFb+MlPnHfxoVZxC9xsKbE61o2pW
	YHi0nRTIqV9OXZ3wFTUFXaPaPqRuL9MgmG2q8xDRXlLs2SDRlJDL74W7f8fkil8Y
	X2rZv+sPCw9t0D6chCaHM1brzRSNfHAa+yFO1HXhglURQl2+6SFsjc6PYulLGpdf
	mO0VP6muY=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g1-3 (Coremail) with SMTP id _____wD3P8LYy59lYNk4AA--.38428S2;
	Thu, 11 Jan 2024 19:07:04 +0800 (CST)
From: XueBing Chen <chenxb_99091@126.com>
To: mchehab@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	XueBing Chen <chenxb_99091@126.com>
Subject: [PATCH] [media] media: Clean up errors in bcm3510_priv.h
Date: Thu, 11 Jan 2024 11:07:03 +0000
Message-Id: <20240111110703.15010-1-chenxb_99091@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wD3P8LYy59lYNk4AA--.38428S2
X-Coremail-Antispam: 1Uf129KBjvJXoWrKw18KrWUXr15uF1rZw4xWFg_yoW8Jr1kpr
	s0yry0ya13Aw47K3Z3Ja4xKFy3Gws8Xa40g3Waga17uF1rGa9rJr1YgwsFvrn8Gr4fAa9r
	tFnIqw1xua45KaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR5DGOUUUUU=
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiOhxixWVEuYGXCgAAsF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: space prohibited before that ',' (ctx:WxW)

Signed-off-by: XueBing Chen <chenxb_99091@126.com>
---
 drivers/media/dvb-frontends/bcm3510_priv.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/dvb-frontends/bcm3510_priv.h b/drivers/media/dvb-frontends/bcm3510_priv.h
index 2c9f3c430a82..89c71bc42a0f 100644
--- a/drivers/media/dvb-frontends/bcm3510_priv.h
+++ b/drivers/media/dvb-frontends/bcm3510_priv.h
@@ -12,11 +12,11 @@
 #define PACKED __attribute__((packed))
 
 #undef err
-#define err(format, arg...)  printk(KERN_ERR     "bcm3510: " format "\n" , ## arg)
+#define err(format, arg...)  printk(KERN_ERR     "bcm3510: " format "\n", ## arg)
 #undef info
-#define info(format, arg...) printk(KERN_INFO    "bcm3510: " format "\n" , ## arg)
+#define info(format, arg...) printk(KERN_INFO    "bcm3510: " format "\n", ## arg)
 #undef warn
-#define warn(format, arg...) printk(KERN_WARNING "bcm3510: " format "\n" , ## arg)
+#define warn(format, arg...) printk(KERN_WARNING "bcm3510: " format "\n", ## arg)
 
 
 #define PANASONIC_FIRST_IF_BASE_IN_KHz  1407500
-- 
2.17.1


