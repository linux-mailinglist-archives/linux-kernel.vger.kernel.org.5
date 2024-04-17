Return-Path: <linux-kernel+bounces-149184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4678A8CF3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 22:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE06B2863AD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F06482E1;
	Wed, 17 Apr 2024 20:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="spwjUayj"
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680E844C9E;
	Wed, 17 Apr 2024 20:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713385922; cv=none; b=Twq9c2jfmG8OaC7Mhwg6Scor6p59vrDZzOWMRV6DbFyFq2Pqa02hzhl7Y1jH0vH1aAaovP8/HJhPpsT5OT+ORPdRHg3yztO3QwlXj7PLN9ue5c2WktxC9P73Gnw9eWwhTzT22oqNH6QckRRWIl5YY38wrd824qqn4aI7ZZsAOmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713385922; c=relaxed/simple;
	bh=cQOIUn28R7ZCsWq0fLJEMttNYm5HrXEpOQPtfYumEqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N2XcUwAQMywMXvTTW03w3TWvRRmkHtURq4EssyNJy1vrzwG3znSpA0+Vla+z5IYL7NoBOvdMidfinpEoUXjAoMQ2dnjY7SndPTn6dNnQG0mnE94lsQkNXvicJ03nuV8Dp0v7MgWKEgD2ZCtQ9BWyBcY38T0TmbLaqdl2fipHSK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=spwjUayj; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1713385916; x=1713990716; i=parker@finest.io;
	bh=3mlaqrL+/WwAOWO2/+h06ofeEnSKj96AzK/VqPbMGLo=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=spwjUayjd2TABBZIxW+c819UGgqmEfjETKw/uSEEkEYV7zDpioAr6cacZ7x1wNgC
	 C9XzN9Z2jiG4dDdpwVKDNpeyJHhouf1Ha/TIN9scW0gXte2eYl5zvn7y3CqTIlyjG
	 dXScDqMaYlBxrUsMUAf6QoRB5jQ6qS5Y7XtYPBXkPlZpXyjnDGI9jlgJUPPbEnRgH
	 NoQuXCUSpE3ETcIyz1sPGMdXFLSzZMgQiHthY4THbLTKCwUBLAYUEC0UGK7t6LyBP
	 I1VyYYmT76lRJD8Ih2WB7EUrcHXbFxL6RXyS0uifcsrbQlnukT7TOj8sS973i9bb2
	 YeXe5tofDWwQrGAhKA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from finest.io ([98.159.241.229]) by mrelay.perfora.net (mreueus004
 [74.208.5.2]) with ESMTPSA (Nemesis) id 1M5fxm-1s4KoQ0XN4-007Bs6; Wed, 17 Apr
 2024 22:31:56 +0200
From: Parker Newman <parker@finest.io>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Parker Newman <pnewman@connecttech.com>
Subject: [PATCH v4 7/7] serial: exar: fix checkpach warnings
Date: Wed, 17 Apr 2024 16:31:29 -0400
Message-ID: <f7fa6c16cb5f2c8c1c7cb7d29f80bc7be53f91ab.1713382717.git.pnewman@connecttech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1713382717.git.pnewman@connecttech.com>
References: <cover.1713382717.git.pnewman@connecttech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rmQ6lvyO9pcnLqF+oMyPzW9wbsk5Q3xtHL1O3lWF5U+UZndGBr3
 7w9Xot12CLhbAYxoy0wJ+Ne6eXqebMrO+jM+iUWIoRXgT5uZpLyv+8gz40NbbvnPxTA4o4R
 iAqJsu1PjiH5yUqRYdZ9oM2TwN8cTOWaFAImOlDFmSCTQgBxqNDzKEeW/kEf+iG4PEeUPnE
 xQadyyuJUeFPXt8jd+Sjw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tecjjXD4p7U=;yGo4BdNr+vZQPdaOqVSoWRi35md
 X1J2LPXuMabQkd2cG6i0FxPUdqdkCx+bWHs5QkCszvuMIIsNzNRw0DHvrF8HqoLFAR7iTtD3g
 h5BqWJzac+KPcQFmU9yPpKpQqaN4XUlIVFrv3Qi5RnQ7H2D/Q6iprDoAFS8wr8xowj+V0mOjV
 fSy01PPWZILRWfvhJug/6Au+Cy7+2sBK7VjOxokGzTi+PNUF/iVaEkj2rpCrQ95d3u16fW0nb
 Kg8ah1un8PTwPmngIuQbjl6S72OjqlDmyMEf2TdQ0DqNB5cI08oTQXI9XJAuCVSDK82r7mB0d
 2WPUJ+efgMZekBupb4mUoMn4hZ/KAhFvXmTsjH2ebWZsslV4cEc5JjYKncItpAzZDd2AEfISa
 esuRreZv4eOQ+yeu8yuMh9YGJx2tm3U8t+jwMhz6L3pDZW5mPdoeo6S5UpMxWJxQ4YQV85nYM
 ZsmWSm5zSRa/oaJUFOepNmnSRbWVNe9Dy+57DrFPl7hRumyRguf1Psw78M6Gcw6iQeb/Pj8dK
 fcl2o6iJr3/Qm7h6bUYojCJtyMsLZC1B0MTM5mYB/u8wZKGxOwvx3JBFU7vrkcOf9V60E/2sw
 SWeGbchB8FM5cSJg0eRlguqkJLkb74m0fD+rwm7qQPJrCHFPW/c0gJLoVDV7XxbekoPIzGTLd
 uzNtH6QNlv98lTxvBNUGtYAB33RV3Qhybx2kViTeyyxe7iNNGVTo6FK6M7FFwzc/XMNylcTI3
 7U46a8Fxpeu9L76BidXoBMwsjWkq3EUQDQCyjmrwOTa5psM/VRuiJc=

From: Parker Newman <pnewman@connecttech.com>

-Fix several "missing identifier name" warnings from checkpatch in
struct exar8250_platform and struct exar8250_board.
Example:

WARNING: function definition argument <arg> should also have an
identifier name

- Fix space before tab warning from checkpatch:
WARNING: please, no space before tabs
+ * 0^I^I2 ^IMode bit 0$

Signed-off-by: Parker Newman <pnewman@connecttech.com>
=2D--
Changes in v4:
- Moved to separate patch

 drivers/tty/serial/8250/8250_exar.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250=
/8250_exar.c
index 6985aabe13cc..5e42558cbb01 100644
=2D-- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -147,7 +147,7 @@
  *
  * MPIO		Port	Function
  * ----		----	--------
- * 0		2 	Mode bit 0
+ * 0		2	Mode bit 0
  * 1		2	Mode bit 1
  * 2		2	Terminate bus
  * 3		-	<reserved>
@@ -229,8 +229,8 @@ struct exar8250_platform {
 	int (*rs485_config)(struct uart_port *port, struct ktermios *termios,
 			    struct serial_rs485 *rs485);
 	const struct serial_rs485 *rs485_supported;
-	int (*register_gpio)(struct pci_dev *, struct uart_8250_port *);
-	void (*unregister_gpio)(struct uart_8250_port *);
+	int (*register_gpio)(struct pci_dev *pcidev, struct uart_8250_port *port=
);
+	void (*unregister_gpio)(struct uart_8250_port *port);
 };

 /**
@@ -245,8 +245,8 @@ struct exar8250_board {
 	unsigned int num_ports;
 	unsigned int reg_shift;
 	int     (*board_init)(struct exar8250 *priv, struct pci_dev *pcidev);
-	int	(*setup)(struct exar8250 *, struct pci_dev *,
-			 struct uart_8250_port *, int);
+	int	(*setup)(struct exar8250 *priv, struct pci_dev *pcidev,
+			 struct uart_8250_port *port, int idx);
 	void	(*exit)(struct pci_dev *pcidev);
 };

=2D-
2.43.2


