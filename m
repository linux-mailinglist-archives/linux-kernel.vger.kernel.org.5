Return-Path: <linux-kernel+bounces-141573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8C78A202E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 22:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64FEE1F23CA0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052C629422;
	Thu, 11 Apr 2024 20:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="kk1nSTVt"
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04AF17C9B;
	Thu, 11 Apr 2024 20:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712867166; cv=none; b=dU3vGsQ4D5I48RqFI5aPX5h47TUCtwjg1aJjFm4dPjGDEECnMuOHp7m2Mn6rsp/1mzttf4Z20mGJlYhwnTbKS9Cv5JDqyUJ9uys3VGbn3+Xv56FYEPm9HHEkSyxyGD8uaRmTI/i3PJ/+Pwes5FhHJmloNJ/U4K2M98JAXHJidD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712867166; c=relaxed/simple;
	bh=ZIhUJYvk/wOqSM1Ia5ds5H6P5YLEAb5YuO7xaYAFlVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sUbxzTca63pCMvbnZ4tbc3N43/CtjHYLsoF9zCV6JLVZoPWHvzLPmXWmcoL0OgF23Eg5FGLlK22iu+w/qNS+RR0UX45niFs3LuWaRFNEHJ0tsDbQzsJcj1ua27xS3XYfc6jpnPlv3I6KtfxCXwmdSYV4TUMneAhxn+Ame1h4Sq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=kk1nSTVt; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1712867157; x=1713471957; i=parker@finest.io;
	bh=/pMNEblpoORPGqBosh2QqloC4JBppA9VbN2iUpBE/p8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=kk1nSTVtVfu2ynp1qOzpLu0CuH3B53XzvIyrqnB4GbOoREOIeraU2mSbqF6n5Wam
	 nRgrT81pUR82Dc6iNqAtD5s41LoZ49Z34TUFMvQ1c9RLDn4cyDw0oj5as6URXYHVU
	 67xk8oYRO/uC4PuF6Jc6Hr207es1qXt90qmBjYbVHS8qlADm/lxAKyC+0MAG3RtV6
	 hNjrUZWl6HCp+pZVJDy6N/25yKJzERxzGuOZsMcO1uzuhof3u7wOsQsCQWwzoZCMO
	 jjY3c6rN1d0e1C0SLnjOYaL4LtYRXouYn3kw/UfvrUQ5kUbdbCZ0xtQp0vXTcsZnr
	 gNzhvsBf/4Cjat9Spg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from finest.io ([98.159.241.229]) by mrelay.perfora.net (mreueus002
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MbODK-1sDdlx0u9s-00QmTM; Thu, 11 Apr
 2024 22:25:57 +0200
From: parker@finest.io
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Parker Newman <pnewman@connecttech.com>
Subject: [PATCH v2 1/7] serial: exar: adding missing CTI and Exar PCI ids
Date: Thu, 11 Apr 2024 16:25:39 -0400
Message-ID: <0a62e3c831ab93a583e5f29affdea87bd27ae9d6.1712863999.git.pnewman@connecttech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1712863999.git.pnewman@connecttech.com>
References: <cover.1712863999.git.pnewman@connecttech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cXmJLp/tzSoLCUkKqfmuM1UaagLN2AmJ3EvkXEYcSB4NZCiUkS6
 z2BzbyJBI0yCNNW3lWT1iwTuGWvyRM5bXE1G0EYh8xJ0YE5+dAa+vtdZZc9zgaZq992n15C
 2Ss8g3nIqKe2Igse2VwIZ1aodDn971BT8KLu6R2T9uOyYTJIBCDiIT0J8nl0Gx2venDCuwK
 SK6DIaXqDJezgFlbqOE6A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BSekdH7t9NU=;d2x6hKxVTe4Zt81uKmdZWJUoHSw
 0f8n5RgM+gXguAGFedwRNFXg4IAgyCXxdiXLw6a/MZAy1KygShEf8FSwQlxwZ+LUtkZ4xfAI6
 p2f3bv+nzR8g4BpIP54GuIXSpDdKj0zlVsoBOK3uBO/mFmdR7TxCrw5ZLshmnBMD0ydX3iKJ2
 INC+ic/LslRPLez4ReHZfTPTUsrnMB+FDThw4iPWLWU9Y1AjE3rUeLnmtgshyhvTMrlfqn4z7
 UvuroCghhadEl3o6tPaOEvjUzGrIntQs71s/jWZ06mqNCtlr3jp6a26lqzOKhZIHeEiaMUAwO
 J4VneNVSnPjoQJ2u6edQycygCE0ToQ2mh/ixHe5gdjhxOMVn0RRl9oeAqqCrsShmZ7ER7+2So
 WsngorxHc22nIB67nYe9CigfftWdaNFB8C7UHR5uJBmtK1zCDeqXGV61Avp8af/FAap8vsGqP
 GZN2YOBd2bfEyytBE3lSD9vD2/mCTwP245WSc5pSpnmG/D3FwQEMD+4QT6qsQzSu8dkHZ0396
 gCLHgpDnkmkHBFbW0plQSElln//wYNv3tUd5n8cv/ZuYtq2wDY+U6imCC0CECfDhFi4QEfcG2
 cCNxS7W24OrgCXt5lF2PvHD2fKr1kVf3mLjJgkFmmdUpSW6/rzskj2ns1QmucIeQ1eNc+alDd
 C8UywUF7Q6VQxgxHkxI/fTnzYUZyUywJZDHacaWIUcCiIVH1tZuqOIIbXdxrjGQ1x8X2IFjZa
 5MsfJ92cmhTjIaUnWim083Rtls6avDRBYbCdxUmci4aPHLhU+79uHs=

From: Parker Newman <pnewman@connecttech.com>

- Added Connect Tech and Exar IDs not already in pci_ids.h

Signed-off-by: Parker Newman <pnewman@connecttech.com>
=2D--
 drivers/tty/serial/8250/8250_exar.c | 42 +++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250=
/8250_exar.c
index 0440df7de1ed..4d1e07343d0b 100644
=2D-- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -46,8 +46,50 @@
 #define PCI_DEVICE_ID_COMMTECH_4228PCIE		0x0021
 #define PCI_DEVICE_ID_COMMTECH_4222PCIE		0x0022

+#define PCI_VENDOR_ID_CONNECT_TECH				0x12c4
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_SP_OPTO        0x0340
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_SP_OPTO_A      0x0341
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_SP_OPTO_B      0x0342
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XPRS           0x0350
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_A         0x0351
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_B         0x0352
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS           0x0353
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_16_XPRS_A        0x0354
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_16_XPRS_B        0x0355
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XPRS_OPTO      0x0360
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_OPTO_A    0x0361
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_OPTO_B    0x0362
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_SP             0x0370
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_SP_232         0x0371
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_SP_485         0x0372
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_4_SP           0x0373
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_6_2_SP           0x0374
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_6_SP           0x0375
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_SP_232_NS      0x0376
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XP_OPTO_LEFT   0x0380
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XP_OPTO_RIGHT  0x0381
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XP_OPTO        0x0382
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_4_XPRS_OPTO    0x0392
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP        0x03A0
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP_232    0x03A1
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP_485    0x03A2
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP_232_NS 0x03A3
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCIE_XEG001               0x0602
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCIE_XR35X_BASE           0x1000
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCIE_XR35X_2              0x1002
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCIE_XR35X_4              0x1004
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCIE_XR35X_8              0x1008
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCIE_XR35X_12             0x100C
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCIE_XR35X_16             0x1010
+#define PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_12_XIG00X          0x110c
+#define PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_12_XIG01X          0x110d
+#define PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_16                 0x1110
+
 #define PCI_DEVICE_ID_EXAR_XR17V4358		0x4358
 #define PCI_DEVICE_ID_EXAR_XR17V8358		0x8358
+#define PCI_DEVICE_ID_EXAR_XR17V252		0x0252
+#define PCI_DEVICE_ID_EXAR_XR17V254		0x0254
+#define PCI_DEVICE_ID_EXAR_XR17V258		0x0258

 #define PCI_SUBDEVICE_ID_USR_2980		0x0128
 #define PCI_SUBDEVICE_ID_USR_2981		0x0129
=2D-
2.43.2


