Return-Path: <linux-kernel+bounces-29500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C09D4830F60
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 23:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3AC31C21B36
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 22:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E34C2C878;
	Wed, 17 Jan 2024 22:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="QvT9a7T1"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81B928E12;
	Wed, 17 Jan 2024 22:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705531162; cv=none; b=tqbYx1GYAhN7cgOLQX0OWJG3xGAUMMweCm7oWkwu8EOz21OtrkSamCeMUSIbab9/WwH4NbrIyv1nStH6rl0aD/jFjwfb2MWd8mJWDlNa2DiTnNZIQXhhQIRWgb8kye4Px0qFzuCf6c6aM01zle48CPPWLNE8FKIMrs1ImYKF/xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705531162; c=relaxed/simple;
	bh=LZipp2J5ODSWKW0/wf/7Dva4c04b2Zu6L2eGbhwCn10=;
	h=DKIM-Signature:Received:From:To:Cc:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-SA-Exim-Connect-IP:X-SA-Exim-Mail-From:X-Spam-Checker-Version:
	 X-Spam-Level:X-Spam-Report:X-Spam-Status:Subject:X-SA-Exim-Version:
	 X-SA-Exim-Scanned; b=ILiEsChhTB4ehMRxz+iuxSYfiXZswklO4vze4z+XgWwOFIzMvEWRin9MBOVVnwkSXYO4HoJl4esU6fEPE6xdxE2HxNdjNirAuHsViPlXOnSBFljjbz5s6XG7oEn2NNI07ObAGeCI+J1NttGA5wHwdy/K2JFb3tqpOPzYzETZ2Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=QvT9a7T1; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=LhqHwlrUyDIZEEL1PofE3YIiu/u+1LniZhq8Y/nggDw=; b=QvT9a7T15RWtfD31JYbBdsLTpI
	AQCKcgrDWAYTg2qfcOo8Nhb6TXlNDDcMsTSGwe7i3YsEYzzAiD5XbCXZfk+irTB+ZybWBkFOSkog4
	d+z2A+4id9nq8Ckxhbg5N+GhadZlFSRUs0PIsbTOHCqQRVTDrAN966oBdKP2WZPfl5pg=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:52924 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rQEZ0-000155-P8; Wed, 17 Jan 2024 17:39:15 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	cosmin.tanislav@analog.com,
	andy.shevchenko@gmail.com,
	shc_work@mail.ru
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Wed, 17 Jan 2024 17:38:48 -0500
Message-Id: <20240117223856.2303475-11-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240117223856.2303475-1-hugo@hugovil.com>
References: <20240117223856.2303475-1-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
Subject: [PATCH 10/18] serial: max310x: add explicit return for some switch default cases
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Allows to simplify code by removing the break statement in the default
switch/case in some functions.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/max310x.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 9ef146f09d5b..048ae432ba48 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -483,10 +483,8 @@ static bool max310x_reg_writeable(struct device *dev, unsigned int reg)
 	case MAX310X_RXFIFOLVL_REG:
 		return false;
 	default:
-		break;
+		return true;
 	}
-
-	return true;
 }
 
 static bool max310x_reg_volatile(struct device *dev, unsigned int reg)
@@ -505,10 +503,8 @@ static bool max310x_reg_volatile(struct device *dev, unsigned int reg)
 	case MAX310X_REG_1F:
 		return true;
 	default:
-		break;
+		return false;
 	}
-
-	return false;
 }
 
 static bool max310x_reg_precious(struct device *dev, unsigned int reg)
@@ -520,10 +516,8 @@ static bool max310x_reg_precious(struct device *dev, unsigned int reg)
 	case MAX310X_STS_IRQSTS_REG:
 		return true;
 	default:
-		break;
+		return false;
 	}
-
-	return false;
 }
 
 static bool max310x_reg_noinc(struct device *dev, unsigned int reg)
-- 
2.39.2


