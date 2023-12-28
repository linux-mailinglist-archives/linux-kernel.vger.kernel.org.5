Return-Path: <linux-kernel+bounces-12775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D28E81F9F1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 17:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DEB21F2428F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 16:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B55F50E;
	Thu, 28 Dec 2023 16:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mmDW+lEO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136A0F9C1;
	Thu, 28 Dec 2023 16:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4B9EAFF803;
	Thu, 28 Dec 2023 16:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1703780855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3caCpG8ZH7oZ0hpaYqweYRqw0uIE1xXMGccjPUq7ZSA=;
	b=mmDW+lEObBDog5+me+9C3G2cufszFJbvy0pA/1Y+aaHKqxgabulg+UKMTRKQ7IrGplee16
	dgwMCpgitB5XBKneeC6mKPxZtijzHlBcYau+4faXejwNZ050PUnh5dKWziwyciS4DtenHO
	DcTB5QZBq/tTPXNyKfKb0i71XMdp2BD9cHrmz7/HMh2paSeeyANAMT/e8A76Nuq0ojPmyB
	qsss/aaehG2T7ZaPblAfDxy1xzEd8e6G1SAEUeYp98O7H6UtlbpJYctL5KyHYbDKtnOnYy
	63QCuGZAxkUns21Y55Nazrzkq614JAafghXdcykbG+AInXQpNY+JoLn5RxsMbQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Thu, 28 Dec 2023 17:27:16 +0100
Subject: [PATCH] hwmon: (lm75) remove now-unused include
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231228-hwmon-cleanup-include-v1-1-e36f65aee1f0@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAOOhjWUC/x3MSwqAMAwA0auUrA1oKiJeRVzUGjWgUVr8gHh3i
 8u3mHkgchCO0JgHAp8SZdOEIjPgZ6cTowzJQDnZgqjG+Vo3Rb+w02NHUb8cA2NdMVFfWlvaClK
 7Bx7l/r9t974fiYoQ5WcAAAA=
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: luca.ceresoli@bootlin.com

Including hwmon-sysfs.h is not needed since sysfs code got removed from
this file in commit 08b024338166 ("hwmon: (lm75) Convert to use new hwmon
registration API").

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/hwmon/lm75.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index 5b2ea05c951e..dbabef2c2402 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -11,7 +11,6 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/hwmon.h>
-#include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
 #include <linux/of.h>
 #include <linux/regmap.h>

---
base-commit: 0882168ccf0a8d7a7e61fceb610dcfb196e4724b
change-id: 20231228-hwmon-cleanup-include-86e22b433436

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


