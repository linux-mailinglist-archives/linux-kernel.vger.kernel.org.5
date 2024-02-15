Return-Path: <linux-kernel+bounces-67697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E63856F56
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 22:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB6D91C23026
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 21:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88740145B14;
	Thu, 15 Feb 2024 21:29:14 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C293F1419B1
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 21:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708032554; cv=none; b=dgdpSxBalK+VJ19PNZb7HHPu8Q5Rr1JaJlWMkvA9/8Fp6xH/R564dDRveLw5H+fp+S/4Xm4FJ23JmdeYibtIJstFG0mVaDQb9GxXqnlqqadXBtpSxEBd+O1LJvWwYo9jvRQ4xYJ39ktmS7ouA67E65R87Ml1z0Nv/rH46pY0I9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708032554; c=relaxed/simple;
	bh=sCfsnKhY2IDm3v288y5GnenUdGuz2YCuAJ4RqWsCZlo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rJ1Hz844yPratctP4qHuXuOLqPcDyNZ3K5r6wTjkl49+QKJC8HlcgB9Jw93M7wMMM197cVGUzEOAARYdpFRMF9vRelEQiQzE3+SVVYAMgGCIiBZxjLgadRcMlstkQL0vBhToqSj6923R/jZNW2HezIgZk4gtQpDLkL/Qva23t10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1rajHr-0001xh-Gx; Thu, 15 Feb 2024 22:28:55 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: gregkh@linuxfoundation.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	linux@roeck-us.net,
	heikki.krogerus@linux.intel.com,
	jun.li@nxp.com
Cc: linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v2 2/4] usb: typec: tcpci: add generic tcpci fallback compatible
Date: Thu, 15 Feb 2024 22:28:50 +0100
Message-Id: <20240215212852.1202339-3-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240215212852.1202339-1-m.felsch@pengutronix.de>
References: <20240215212852.1202339-1-m.felsch@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::28
X-SA-Exim-Mail-From: m.felsch@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The driver already support the tcpci binding for the i2c_device_id so
add the support for the of_device_id too.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
v2:
- no changes

 drivers/usb/typec/tcpm/tcpci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
index 0ee3e6e29bb1..7118551827f6 100644
--- a/drivers/usb/typec/tcpm/tcpci.c
+++ b/drivers/usb/typec/tcpm/tcpci.c
@@ -889,6 +889,7 @@ MODULE_DEVICE_TABLE(i2c, tcpci_id);
 #ifdef CONFIG_OF
 static const struct of_device_id tcpci_of_match[] = {
 	{ .compatible = "nxp,ptn5110", },
+	{ .compatible = "tcpci", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, tcpci_of_match);
-- 
2.39.2


