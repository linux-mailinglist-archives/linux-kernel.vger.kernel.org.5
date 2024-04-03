Return-Path: <linux-kernel+bounces-129303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2107D896897
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA3C9B2BF55
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF106F08A;
	Wed,  3 Apr 2024 08:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KA2BvgOZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B00F13FD7E;
	Wed,  3 Apr 2024 08:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131881; cv=none; b=tzMb6HW6q+vRMHyyypMM7q7AtxV0/igkzveFSR+oX+ZgtNdzQ2bzOR+UGSfKbUH9qhxQgz27N8JSwKhpzD2c/OAcOzQqZ/UuqjG66RU359x1C+u9oEasLGq3hIiP3t4KKldZxbCSA+rFHS0rjtldY4qONBuxOu3TF5MMG67Fip0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131881; c=relaxed/simple;
	bh=0liwis3knuJplIlsLI48oLG63cRfb9QsB+onh6JK9F0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qd+fXwYgisTj935RvDXOzJQifb+k24in4rC1nl6zvRQo10Dlt4UvCI92zL1C0jg0nWw5ztUflz7XbOgVLTlN6Q0YNn1ejlvau4RNGUsW4RQQGjTMhoYg2fPemLv8J41FChR4m4ANBIAEP8weOD3q6Aayysp74SoEkFL+UFsOqiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KA2BvgOZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CCDDC433C7;
	Wed,  3 Apr 2024 08:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712131880;
	bh=0liwis3knuJplIlsLI48oLG63cRfb9QsB+onh6JK9F0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KA2BvgOZ0aKADiJYSLZEt38u+ZxvwcPS5kbp9hKULRkrMO30PMZkChHNsikGdAPSZ
	 a4fT2buKxH39mNkm+K3hGG6YhApMU1tf+Pk3MYGngKqYCXkbjwETYFG3pPDdEI7Bym
	 lqTXztk2Y495V4EqJQ7TXXN37sIsRumgW3wyA/ao2JjdJrIBQZGY6qQSiZIKewOWyN
	 pvaPlJVASLhLMBJ3MyWl8GmjN7Yip72P137ky2jfTjB7xkl1KNNIT/HACG9tRlkrSy
	 gMlm/mD5ZJZ3bR7bhh/pL+K9zNAbDXUHqGwzAiZMqu8MuPRlw5AB/jnm3O50fdvmPZ
	 DvRo3K+1oIfdw==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	linux-usb@vger.kernel.org
Subject: [PATCH 25/34] usb: gadget: omap_udc: remove unused variable
Date: Wed,  3 Apr 2024 10:06:43 +0200
Message-Id: <20240403080702.3509288-26-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240403080702.3509288-1-arnd@kernel.org>
References: <20240403080702.3509288-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The driver_desc variable is only used in some configurations:

drivers/usb/gadget/udc/omap_udc.c:113:19: error: unused variable 'driver_desc' [-Werror,-Wunused-const-variable]

Since there is only ever one user of it, just open-code the string in place
and remove the global variable and the macro behind it. This also helps
grep for the MODULE_DESCRIPTION string.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/gadget/udc/omap_udc.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/gadget/udc/omap_udc.c b/drivers/usb/gadget/udc/omap_udc.c
index f90eeecf27de..e13b8ec8ef8a 100644
--- a/drivers/usb/gadget/udc/omap_udc.c
+++ b/drivers/usb/gadget/udc/omap_udc.c
@@ -56,7 +56,6 @@
 /* ISO too */
 #define	USE_ISO
 
-#define	DRIVER_DESC	"OMAP UDC driver"
 #define	DRIVER_VERSION	"4 October 2004"
 
 #define OMAP_DMA_USB_W2FC_TX0		29
@@ -110,7 +109,6 @@ MODULE_PARM_DESC(use_dma, "enable/disable DMA");
 
 
 static const char driver_name[] = "omap_udc";
-static const char driver_desc[] = DRIVER_DESC;
 
 /*-------------------------------------------------------------------------*/
 
@@ -2299,13 +2297,11 @@ static int proc_udc_show(struct seq_file *s, void *_)
 
 	spin_lock_irqsave(&udc->lock, flags);
 
-	seq_printf(s, "%s, version: " DRIVER_VERSION
+	seq_printf(s, "OMAP UDC driver, version: " DRIVER_VERSION
 #ifdef	USE_ISO
 		" (iso)"
 #endif
-		"%s\n",
-		driver_desc,
-		use_dma ?  " (dma)" : "");
+		"%s\n", use_dma ?  " (dma)" : "");
 
 	tmp = omap_readw(UDC_REV) & 0xff;
 	seq_printf(s,
@@ -2994,6 +2990,6 @@ static struct platform_driver udc_driver = {
 
 module_platform_driver(udc_driver);
 
-MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_DESCRIPTION("OMAP UDC driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:omap_udc");
-- 
2.39.2


