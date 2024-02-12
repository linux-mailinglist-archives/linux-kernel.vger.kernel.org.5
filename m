Return-Path: <linux-kernel+bounces-62308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E63B851E5A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F30EB247C0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 20:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0583F47F5C;
	Mon, 12 Feb 2024 20:04:45 +0000 (UTC)
Received: from mx.skole.hr (mx2.hosting.skole.hr [161.53.165.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA4B4CB55;
	Mon, 12 Feb 2024 20:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.165.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707768284; cv=none; b=tjyzDQJ6HfQHpqQUQz2l9G6ZAIZUKcbfgY0fG4JOL42BhcNMFif2DQ03vWe3HH4fvikx9+nUbN9iwUmyIc7PwtInypsAdlSBWEB5eRX6sPoJ4hSiG0iBybwp8uCpdFBIP73rOUL3HyeEhMBoAzYgQtm28bYH535cFzsajxpALIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707768284; c=relaxed/simple;
	bh=PSXGPCrqbnaDBfgcrLl0RTka3gT8h50OxpcbtqLKeVY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kf7Jn0kUSdo/U+t0k0KBWN0LxCWSSpnn79jn33ZF+X84C3egsg8zzTD09roC4cNdc6t+X3HYcMevlETushA2IkXVusaKeenL6fW5DBsTBrzPcBqhZhM861oRA4utlvmoWU1TdcgyW4iMNDcVYrm3mg1ns6bHwv4UHXlj2iY60Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr; spf=pass smtp.mailfrom=skole.hr; arc=none smtp.client-ip=161.53.165.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skole.hr
Received: from mx2.hosting.skole.hr (localhost.localdomain [127.0.0.1])
	by mx.skole.hr (mx.skole.hr) with ESMTP id DE5BB8507B;
	Mon, 12 Feb 2024 21:04:37 +0100 (CET)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date: Mon, 12 Feb 2024 21:03:25 +0100
Subject: [PATCH 1/2] Revert "leds: Only descend into leds directory when
 CONFIG_NEW_LEDS is set"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240212-expresswire-deps-v1-1-685ad10cd693@skole.hr>
References: <20240212-expresswire-deps-v1-0-685ad10cd693@skole.hr>
In-Reply-To: <20240212-expresswire-deps-v1-0-685ad10cd693@skole.hr>
To: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
 Daniel Thompson <daniel.thompson@linaro.org>, 
 Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Flavio Suligoi <f.suligoi@asem.it>, Hans de Goede <hdegoede@redhat.com>, 
 Jianhua Lu <lujianhua000@gmail.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Helge Deller <deller@gmx.de>, Jingoo Han <jingoohan1@gmail.com>, 
 Karel Balej <balejk@matfyz.cz>, dri-devel@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-leds@vger.kernel.org, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1040;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=PSXGPCrqbnaDBfgcrLl0RTka3gT8h50OxpcbtqLKeVY=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlynmg1AO2BNWzA/ObjvKoEbirvyIXAvvYxitfx
 MmcK/0fNv2JAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZcp5oAAKCRCaEZ6wQi2W
 4ctmD/4tcF0fuxA0coVon4C8C7312+ldyuaC8IMNaeizEWBKHkJm0mENe1UP33oiF5dAyGssI44
 95H+dwlBtvzANNwvK6g/oKe/1Qt/OJrcPpxaFinTRGdGF2a7/YVIPbWdRGdxUI0D+kOGpHkjKJ8
 Nl7wrt9TWpqs2ABy5Aiwr0y1a3tNTx57hHkCTIWrdB/MZW3c6yxOcYeyBo+lT6zEcUuGsuEaiql
 0k/BMoMtI9IPG3K84mn8KlbY1tqAjaEiL+HiusXzi88t+IgfiIi2NxP6sxpeSQrCqvlkFRo8mLY
 f99AfHzmk54jks9GuUMTmArCD0TdROur7XqcHoM/kt8M/B3xh0Kevs4qGQXi9COv5+bTc2LWdXU
 xB7NOqva9vj785yNN98a60IEct2wT0Au/zuSA94KqQmrRRLD9MqlKZqHzfYjcmg2yW1kJbWG2V4
 tKsHMGRNxl1/mNti1iZy5SfKnPoQY7TyoBLBz7eHLfDTrPCVWudNcyzomdhqVG1r7hNVpNQdeDN
 FJImywxVWRgLegz1/5kVkdUhyNrP6nJz1Nbw0EanENzJH+3FjGJci3RybAAm6S6C3rYNee8QJtF
 eFM3JQS1+C0AOhRpnyHQaKKI/SkvEphXmU5iVyON3BO8crU8TJPJqGETm4X2Z+upytZmQTZbMNh
 vdemFIgFU3AMFtQ==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1

This reverts commit b1ae40a5db6191c42e2e45d726407096f030ee08.

The ExpressWire library introduced in 25ae5f5f4168 ("leds: Introduce
ExpressWire library") does not depend on NEW_LEDS, but without this
revert it would never get compiled if NEW_LEDS is not enabled. Revert
this commit to allow the library to be compiled.

Link: https://lore.kernel.org/2cacd8dc-6150-4aa2-af9e-830a202fb0a8@app.fastmail.com
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
 drivers/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/Makefile b/drivers/Makefile
index 37fd6ce3bd7f..3bf5cab4b451 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -135,7 +135,7 @@ obj-$(CONFIG_CPU_IDLE)		+= cpuidle/
 obj-y				+= mmc/
 obj-y				+= ufs/
 obj-$(CONFIG_MEMSTICK)		+= memstick/
-obj-$(CONFIG_NEW_LEDS)		+= leds/
+obj-y				+= leds/
 obj-$(CONFIG_INFINIBAND)	+= infiniband/
 obj-y				+= firmware/
 obj-$(CONFIG_CRYPTO)		+= crypto/

-- 
2.43.1



