Return-Path: <linux-kernel+bounces-137257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9F189E014
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62E76B29AAC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA7F13D608;
	Tue,  9 Apr 2024 15:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="du2t19T0"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C21213BC0B;
	Tue,  9 Apr 2024 15:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712677588; cv=none; b=dK0v1b/0ZEEaNYtXzxD7oBpkXCMEOkkib7Rz/JUUj9qG5yc71amXInYnx93Wx9qu6ZS06SMXxkYo7H3oQd+pxGbHHTfDnFP8VdqjbnRvr64Vbay5ohiW6Wj7CnKVHgORV1+0jYin139ByrKuGOyJ+3EtCuY6VIbuh0HHZNfFWZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712677588; c=relaxed/simple;
	bh=iSTLVLIy2o0xdhE41Jdp4Cxj2vLa0PYff8icfkK+GMo=;
	h=From:To:Cc:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 Subject; b=BC0+PF4Vd9YiPVI1Higo6/gESB/wCjTWz+cxm4hDCbgaRZ8SXHO6wKfwZmvqrOvI6SWv1ZZKmJSRv3Ri6eK0WY1e4zhgOY50Mnh0WR4a28qanZbZn7ZCky2119HUPwd+t7iGi6KP8PKeWpudroYP42XWIwSqruBqy73KGHgoqwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=du2t19T0; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=lCxCeWbt8uSDKc1Xqjof8d8QsSDhI7OnGAQovecVbF4=; b=du2t19T0lNnQkelI1w+FNUvpv9
	qQqnid7+vPCGU97qVpmC+mJUIcC1F9UKwyquU1+NJLppqj8nRWak95AWyR3fBZ0zWKq10L2SyjoDY
	NHp8StDTTsvpHUWKK8nyYzkS8tePX3A2oXH+qy4WKwQQ8TZ2FmuQBzeSGrssNao01Nlg=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:44750 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1ruDfq-0002NM-0g; Tue, 09 Apr 2024 11:46:14 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	peterz@infradead.org,
	mingo@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com,
	andy.shevchenko@gmail.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Tue,  9 Apr 2024 11:42:49 -0400
Message-Id: <20240409154253.3043822-2-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240409154253.3043822-1-hugo@hugovil.com>
References: <20240409154253.3043822-1-hugo@hugovil.com>
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
Subject: [PATCH v4 1/5] serial: sc16is7xx: add proper sched.h include for sched_set_fifo()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Replace incorrect include with the proper one for sched_set_fifo()
declaration.

Fixes: 28d2f209cd16 ("sched,serial: Convert to sched_set_fifo()")
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/sc16is7xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 929206a9a6e11..34edc80859d5c 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
+#include <linux/sched.h>
 #include <linux/serial_core.h>
 #include <linux/serial.h>
 #include <linux/tty.h>
@@ -25,7 +26,6 @@
 #include <linux/spi/spi.h>
 #include <linux/uaccess.h>
 #include <linux/units.h>
-#include <uapi/linux/sched/types.h>
 
 #define SC16IS7XX_NAME			"sc16is7xx"
 #define SC16IS7XX_MAX_DEVS		8
-- 
2.39.2


