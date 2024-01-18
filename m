Return-Path: <linux-kernel+bounces-30262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F43831C58
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 908861F289DB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30802D05E;
	Thu, 18 Jan 2024 15:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="BQJkyEsg"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C552CCD8;
	Thu, 18 Jan 2024 15:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705591356; cv=none; b=tbM8PFz6T0KRq4uQ9jr/TE7kduxQTLewNLSCsEkkL1d1q1omA5hDmWywwlOluozPu8EajKBaqBshJ0Auu6cE/xmacTqxhdrb40xuVE5sga6ZN8ypN+NFwfjrRgRkppg8CB6/AXJDn7NeIbYk4qAmxw0iKUHC5TWiOyAIyc0XxsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705591356; c=relaxed/simple;
	bh=za7xwtkxGDaYTpODxkLHH/g2BNhvN6NVZPEdJhLrtmI=;
	h=DKIM-Signature:Received:From:To:Cc:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-SA-Exim-Connect-IP:X-SA-Exim-Mail-From:X-Spam-Checker-Version:
	 X-Spam-Level:X-Spam-Report:X-Spam-Status:Subject:X-SA-Exim-Version:
	 X-SA-Exim-Scanned; b=cEPM6K45UJ6ktrfrfftr5r8JGVUgqim3AVi5ZgPLr8RkUJe5pm/OkAinBJjBcSSobu1KURKOJS4YfshshVE9XaK1RHEEGib3T2ud/qbRK2D+Iu2GaknyBJsEtD705b5CMg5m1eamnToEf8thAlfXs6j8pxfeO/lbMHD4k/fYSvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=BQJkyEsg; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=kHLWFA54ihZYBiJv9OQ4T9K7ujrN8iXEvXbK+k32CJw=; b=BQJkyEsgRU50f1Fsm1ysFPiqAC
	3PHKK7eU+94KWPTTXvg87gTA6zR/cPQbwwmJ5F+L/8OdvgaP8/iBQI33XN5+4Fhle6Y208Ep6Q7Ek
	1YXL8a+AfyuOlITRjc5EtxVMIPDGYtXbUQPZC5oZuxMjNm89yhFfEx+6yT6nP1c6XxqQ=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:57058 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rQUDu-0002lf-RX; Thu, 18 Jan 2024 10:22:31 -0500
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
Date: Thu, 18 Jan 2024 10:22:06 -0500
Message-Id: <20240118152213.2644269-11-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240118152213.2644269-1-hugo@hugovil.com>
References: <20240118152213.2644269-1-hugo@hugovil.com>
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
Subject: [PATCH v2 10/17] serial: max310x: add explicit return for some switch default cases
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Allows to simplify code by removing the break statement in the default
switch/case in some functions.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
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


