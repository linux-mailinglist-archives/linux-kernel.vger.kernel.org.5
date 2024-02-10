Return-Path: <linux-kernel+bounces-60451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B14485051C
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 17:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF7931C21B83
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 16:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05805C5EC;
	Sat, 10 Feb 2024 16:23:27 +0000 (UTC)
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1190C2B9C2;
	Sat, 10 Feb 2024 16:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.165.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707582207; cv=none; b=uOG4JE6kB6veB780fyA3xzI0Wa0A09whi8YTHpzzk40KQbAW3X+t51G2y/nOJ4f/nuNXidinun9UWVzc+qgA0ZXkwGHNu0HO8/oL/OZG5D0+KsLcfLgyeYzlcZez1LqtpDbCl33plcb4iN7qPGUwxGguIcR4LyQYbxyP/U8XzRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707582207; c=relaxed/simple;
	bh=TFGgvTM2PG0fbMk9Rl9Qb2vgbRJiET6Rp+y64OYoGI4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mdZwAqRP/9nSQQ7zKjwk/7n3daOCs9WZm10nmHEArysHhuy0D7IuIwutYjas7vw89tHspLeWpFKSWsMdA559vnJORTgBuUSIXqsS8+z6p7k9xik8IcW6Hl3lWGuZx26P2zqQfbGRIX+A7l7wcHqgAS+5Tp8UjN7AovIWXhsCVAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr; spf=pass smtp.mailfrom=skole.hr; arc=none smtp.client-ip=161.53.165.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skole.hr
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
	by mx.skole.hr (mx.skole.hr) with ESMTP id 59EDD8431B;
	Sat, 10 Feb 2024 17:17:59 +0100 (CET)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date: Sat, 10 Feb 2024 17:16:17 +0100
Subject: [PATCH] backlight: ktd2801: make timing struct static
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240210-ktd2801-static-v1-1-90ad2e2e8483@skole.hr>
X-B4-Tracking: v=1; b=H4sIAFChx2UC/x3MMQqAMAxA0atIZgtJFFGvIg7SRg1ClbaIIL27x
 fEN/78QJahEGKsXgtwa9fQFVFdg98VvYtQVAyO3yITmSI57JBPTktQaIcuNo6FDtFCiK8iqzz+
 c5pw/xW2pM2AAAAA=
To: Lee Jones <lee@kernel.org>, 
 Daniel Thompson <daniel.thompson@linaro.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Cc: Karel Balej <balejk@matfyz.cz>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1184;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=TFGgvTM2PG0fbMk9Rl9Qb2vgbRJiET6Rp+y64OYoGI4=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlx6GE2aYXO7i6H7ygEfSoqrSV4LJWg+nPqiTWX
 De1P3tytdqJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZcehhAAKCRCaEZ6wQi2W
 4Qc2EACLTotP/+lxPbA4aYMKka8lirI9jsEY2lS37VZxUyOV4vV5MRUFJmJ5DPU11k/c+0NbwX0
 xZ2gMntp/sR/9A6jYFVOfU50N6SaymZRo+vnDQr+CmFj2bnX9NXH7huoyhPWmKXHKB2pxiDCSSy
 9ZvgazMDi1O078oYI07txn6Mv5yv3+Vru1/UDjZvMTGleuwTsSbPmwYPZ459X7jUZjRE1tbNM0A
 kOkG3pN4qhh1BJ5fA5joSqFkeFHoo/eSZVUX2ZOKUC5UDiSwOXWpmzAWikvVhaCf1HYSCqudBWA
 LYK2von+UkIct5WSYjsC/rcQPaCltcc9M44ZhuQDrTHe0qNwIvz1IX+ErId8ALX8p5/DOsc7Ajx
 Iem5xm1FDD5/OS3lFqZGKnzRV5sniXWzxwwbNxUHTj5exuiu+cfGbHwvi/x6N5K/VOaMrff6oss
 4m4TtJy71Xz0BfGLE0Gw/uvXVSRSBHm9HJwxAY4NSh//+uSM2TCNH2XPqcELV8wEjT2DDNTO+Im
 CG7zehjHRrhDrwwCp3rp/4AjnQ+lJnDV/ffNTZ8uL9nvs54WEnR4UXw7zH9bRRLLNHBq7WAmXJ4
 gRmj4lX1oCohNrKeIbQ7VHRUkWB1fRldwcfx+3wr+9+jC0gkE6AIbW22R6UJkxa0vV8/+7LuuSO
 EQWdKESlbf/OSrg==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1

The struct containing the KTD2801 timing can be made static as it's not
referenced outside the KTD2801 driver. Do this to prevent sparse
complaints.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202402100625.M0RkJhMh-lkp@intel.com/
Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
 drivers/video/backlight/ktd2801-backlight.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/ktd2801-backlight.c b/drivers/video/backlight/ktd2801-backlight.c
index c020acff40f1..d295c2766025 100644
--- a/drivers/video/backlight/ktd2801-backlight.c
+++ b/drivers/video/backlight/ktd2801-backlight.c
@@ -13,7 +13,7 @@
 #define KTD2801_MAX_BRIGHTNESS		255
 
 /* These values have been extracted from Samsung's driver. */
-const struct expresswire_timing ktd2801_timing = {
+static const struct expresswire_timing ktd2801_timing = {
 	.poweroff_us = 2600,
 	.detect_delay_us = 150,
 	.detect_us = 270,

---
base-commit: 66c76c1cd984c14660453dfa2118014817924375
change-id: 20240210-ktd2801-static-e1c23d19600c

Best regards,
-- 
Duje Mihanović <duje.mihanovic@skole.hr>



