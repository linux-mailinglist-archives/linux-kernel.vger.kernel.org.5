Return-Path: <linux-kernel+bounces-1189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A47814B78
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A716E1F2135D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF40A3D98C;
	Fri, 15 Dec 2023 15:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="JzQggL4l"
X-Original-To: linux-kernel@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51E1374E9;
	Fri, 15 Dec 2023 15:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1702653207; x=1734189207;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7FkxHPKCkGpKFOZSD5EQ8Rk+gyt82kYlBUNX8Qhpy1U=;
  b=JzQggL4l+Luguc0u1irfLzkM+uMngdBvXeMlByxX5MHegZ5pjVH1zGIC
   MVTMEm1rsh3snUgGMJvyYptwSgd2S8IX0th/gLIWcDo6jEdqP2V4TzH6W
   5eC7JJchRlgyR4db9EyzjZGL7ZDrQBftnhOWxswvGJOfvlSPSIsweeg29
   m9agNXOA1yusvTlUA/rAMnoNI4+l2SYLxsM7jwSMlsBl2tcshrKmlYEp6
   wVOnls87GHcsnHVC88YSCJZzAvf8em5xGFli5M/T/t7IuvonXy/tvGNnN
   lHLv0GoEF4FV/Qagn6RIbSVgAHpmV42yjvIghgezdnkhcvTPvhbH985wc
   w==;
X-CSE-ConnectionGUID: /Moh9OXQQmOyPN9c02EGlg==
X-CSE-MsgGUID: EkXUut2XSam2/OWku67UOg==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="180577316"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Dec 2023 08:13:20 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Dec 2023 08:13:15 -0700
Received: from che-dk-ungapp03lx.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 15 Dec 2023 08:13:11 -0700
From: Rengarajan S <rengarajan.s@microchip.com>
To: <kumaravel.thiagarajan@microchip.com>,
	<tharunkumar.pasumarthi@microchip.com>, <gregkh@linuxfoundation.org>,
	<jirislaby@kernel.org>, <keescook@chromium.org>, <gustavoars@kernel.org>,
	<linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>
CC: <unglinuxdriver@microchip.com>
Subject: [PATCH v1 tty-next 1/4] 8250: microchip: pci1xxxx: Rearranging the structure declarations
Date: Fri, 15 Dec 2023 20:41:20 +0530
Message-ID: <20231215151123.41812-2-rengarajan.s@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231215151123.41812-1-rengarajan.s@microchip.com>
References: <20231215151123.41812-1-rengarajan.s@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Structure declarations in 8250_pci1xxxx.c have been moved above
the functions for code readability.

Signed-off-by: Rengarajan S <rengarajan.s@microchip.com>
---
 drivers/tty/serial/8250/8250_pci1xxxx.c | 26 ++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci1xxxx.c b/drivers/tty/serial/8250/8250_pci1xxxx.c
index 9f9e21981929..48bd2f3a287d 100644
--- a/drivers/tty/serial/8250/8250_pci1xxxx.c
+++ b/drivers/tty/serial/8250/8250_pci1xxxx.c
@@ -85,6 +85,19 @@
 #define MAX_PORTS				4
 #define PORT_OFFSET				0x100
 
+struct pci1xxxx_8250 {
+	unsigned int nr;
+	void __iomem *membase;
+	int line[] __counted_by(nr);
+};
+
+static const struct serial_rs485 pci1xxxx_rs485_supported = {
+	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND |
+		 SER_RS485_RTS_AFTER_SEND,
+	.delay_rts_after_send = 1,
+	/* Delay RTS before send is not supported */
+};
+
 static const int logical_to_physical_port_idx[][MAX_PORTS] = {
 	{0,  1,  2,  3}, /* PCI12000, PCI11010, PCI11101, PCI11400, PCI11414 */
 	{0,  1,  2,  3}, /* PCI4p */
@@ -104,12 +117,6 @@ static const int logical_to_physical_port_idx[][MAX_PORTS] = {
 	{3, -1, -1, -1}, /* PCI1p3 */
 };
 
-struct pci1xxxx_8250 {
-	unsigned int nr;
-	void __iomem *membase;
-	int line[] __counted_by(nr);
-};
-
 static int pci1xxxx_get_num_ports(struct pci_dev *dev)
 {
 	switch (dev->subsystem_device) {
@@ -205,13 +212,6 @@ static int pci1xxxx_rs485_config(struct uart_port *port,
 	return 0;
 }
 
-static const struct serial_rs485 pci1xxxx_rs485_supported = {
-	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND |
-		 SER_RS485_RTS_AFTER_SEND,
-	.delay_rts_after_send = 1,
-	/* Delay RTS before send is not supported */
-};
-
 static bool pci1xxxx_port_suspend(int line)
 {
 	struct uart_8250_port *up = serial8250_get_port(line);
-- 
2.25.1


