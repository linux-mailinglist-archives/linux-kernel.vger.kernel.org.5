Return-Path: <linux-kernel+bounces-20376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB7F827DDE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 05:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C14951F24572
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 04:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63005819;
	Tue,  9 Jan 2024 04:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="f/lME9AY"
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.214])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6ED631;
	Tue,  9 Jan 2024 04:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=1ad9S
	/a41A/LWp7yf1wRRo/sXfgTHOJJT+GW2z8tQnc=; b=f/lME9AY8QI34XICOeuMK
	iwXotmKIBoMS0H/UBTsms8PlfBXrJTjcRz3J975yCiWUp7a75G4xtTFz9fn0LUTH
	N/D2HrIBmKChsbfoHHKro9hO0b1K8kl/0k9GgeCzUk3sxz+kzYkI71cxLPrUhCOz
	5jQb4cv5v9Lo8+05d+yrcA=
Received: from localhost.localdomain (unknown [114.105.142.232])
	by zwqz-smtp-mta-g4-2 (Coremail) with SMTP id _____wDnt4zUzJxl+6msAg--.14805S4;
	Tue, 09 Jan 2024 12:35:14 +0800 (CST)
From: Lizhe <sensor1010@163.com>
To: ilpo.jarvinen@linux.intel.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	u.kleine-koenig@pengutronix.de,
	robh@kernel.org,
	john.ogness@linutronix.de,
	tglx@linutronix.de,
	frank.li@vivo.com,
	zhang_shurong@foxmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Lizhe <sensor1010@163.com>
Subject: [PATCH v7] serial: linflexuart: Remove redundant uart type assignment
Date: Mon,  8 Jan 2024 20:34:26 -0800
Message-Id: <20240109043426.3756-1-sensor1010@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnt4zUzJxl+6msAg--.14805S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrtw4rAw13Wr13Jw43Cr1kAFb_yoWxKwb_uF
	1DC347ur10kFWakFnrXFWYkrySganYvF48ZF10q3saq3yDZw4rXryIqrZru39rG3yUZrZr
	WwsrWr12yrsrXjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNvtCUUUUUU==
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/1tbiWANfq2VOA4+1OwACsE

in linflex_config_port() the member variable type will be
assigned again. see linflex_connfig_port()

Signed-off-by: Lizhe <sensor1010@163.com>
---
 drivers/tty/serial/fsl_linflexuart.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/fsl_linflexuart.c b/drivers/tty/serial/fsl_linflexuart.c
index 3bdaf1ddc309..c5a04a168c15 100644
--- a/drivers/tty/serial/fsl_linflexuart.c
+++ b/drivers/tty/serial/fsl_linflexuart.c
@@ -837,7 +837,6 @@ static int linflex_probe(struct platform_device *pdev)
 		return ret;
 
 	sport->dev = &pdev->dev;
-	sport->type = PORT_LINFLEXUART;
 	sport->iotype = UPIO_MEM;
 	sport->irq = ret;
 	sport->ops = &linflex_pops;
-- 
2.25.1


