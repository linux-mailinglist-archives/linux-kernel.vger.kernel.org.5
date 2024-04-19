Return-Path: <linux-kernel+bounces-151570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A15EE8AB08F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 583BB1F24322
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC5612E1DA;
	Fri, 19 Apr 2024 14:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="C4kmhbju"
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E53912C817;
	Fri, 19 Apr 2024 14:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713536252; cv=none; b=ZCGo9PJ5kYseY3J5fhUZt0sCf6gS2b7dEuvrxw1QP/8HiGD8XIYsn00gwUhcYIoDajaXlJqxIPb+hm1x8IgMG4SE5FHFSv0XhaH6opkPT5impyEE9BUU02RSryxKsOWTw7YqdaoetvxJwtyInpLG80zaL0rOFcvX5D4+To8hhdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713536252; c=relaxed/simple;
	bh=euXPQiBqqIG2+cRuTUbXpVJ3280d78ADpFb0BaPYG54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cqb8kk6kIykoulvCGoR1Pk78thQZ+Hz8IIz1PSv5d9bRzTGcqe/xMHEV6QcSpIWzeG14QU7eEU8+f9eWcR0cw50wfHqS/H88Tx+a/bniiVHD4eZClxAiy5dZYHzhnzibUgrUlrQXvhKkEehMLVSdjxnZYLKg/E9Ge5hM+DWVEAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=C4kmhbju; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1713536244; x=1714141044; i=parker@finest.io;
	bh=nWFQ37RsfGMWOYIzH+ps6Dt2wTvbrcgBevzsVRsv/OM=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=C4kmhbjuw5LZ4uH/ZvMGpZMC8feopacN9/1dZM+U2FhwgHfhiMWbLD4mW2osHRbA
	 4fuFeC9c+RTsKh8ZOJTkm6tfo0imZzKCQicXHDVUodnNDX1P9YVwy9PQsysVICifD
	 uCaoS0JvMe5pvRAGvooUBLG+6qUD9eniZM+4RAuznate8zUcuroWiO9Y6WsyKHzDY
	 Yp3kmZgz8aIDCjmkkPPY+iRuQRYLoMsgDiwc5sk66chxynEGC6o0qSEeWelIsZEFC
	 IRrFHJfoAqSzjImeo+m9mHWBZHgmjYoF0c/LmDHD8/8uCjg0EXHUPBOpYpi7V+1Hw
	 NCocvfFzJoOuxfc7VQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from finest.io ([98.159.241.229]) by mrelay.perfora.net (mreueus003
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MO8aA-1s3Ih62rx6-005cbY; Fri, 19 Apr
 2024 16:17:24 +0200
From: Parker Newman <parker@finest.io>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Parker Newman <pnewman@connecttech.com>
Subject: [PATCH v2 4/4] serial: exar: remove ternaries from cti_get_port_type_xr17c15x_xr17v25x()
Date: Fri, 19 Apr 2024 10:17:04 -0400
Message-ID: <d672326427b1026c7700303eedef8594f2688def.1713533298.git.pnewman@connecttech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1713533298.git.pnewman@connecttech.com>
References: <cover.1713533298.git.pnewman@connecttech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:e14IZuYugv8xagY2QPH0Fz/gGkBpK3QfnisJhgzbn3Dkbz+BL0I
 20gTiAWsLO6wCszC1oSJiGjHckV+U3ENhRVrU3cCcVBy8hVPmU43YfgMKkkJV3Miij/2a9L
 qGcmxoX38afdWBqvWwRqo+26G+89lN3jxTXtOZBFEB9kLl8Vgg1dZd6LU4Byo6ownImBol+
 uo/Ek/bJ2Ed823bg39t+Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BwRiKUOze6Y=;EvYC6pMJhilTeMZfsCFEDNjmvwa
 1xcpwMRk0KxyE0nLMPkEU8VCHdzOHujxlZjB3OMCkjSZAdAbLhTBLVv9K1GBWVfkN3YO+YZKf
 OjVPqHTWKP98b3oDn/jBv+k3IkDc78i7MT90/Ovn+ETgPrTWRlyHWQn49Aq6U4CDjYRyZzWBI
 UEJoe3inA9OSt7nHabADMY1+qH1iTq0rXrLtj1+QgSAZbgMi4HJZBow3nmDq/XfX4jXNkPAu2
 4deOsTC3xvfZoQ/7R5nN+iKiZ4rxkMIhJWXbxglAT536IQxCrIy7IQzypjT4qhxCeJ6+6qDak
 HfPYmUumPNdTXtc3mkRPcRyYpgYvPB1tGrrA1B8VMY2tV+N0DF7BTAOGvku/LuJNYbOTPhpAg
 AM4N7MQlZz6i5EgaFrDiwwT50bHyJ1jQ9XsjFbawuNfJ+rRfL85Nc0OnbNkjSPWkd+HqjndDS
 aXkuyg6PPh2AnFJrdaVctAU3BJAKlqUDCozs23kFB9Vo5xNiI5ZYO3KVXSjUj0KQvARiQ59uh
 xH7HrJKBHCbbMgpPzXTROqHa2+2szeyrGP7llb+z/2cZyY5QeBoLOUvbiQ14LmiSuP9H8uVHG
 qTFx0BQMGMjO9vWuhm+ropH6dwk0xhagfV9vzy6qLwNQzX5pKaxawhEAp9LRG02MNGI3gEnUU
 0rNYGKJqMaQMHF7S/ij2gAWzTyYLNxUIV5iZ/gN+mbtpjiGFnvDqkiUQYmWExB60KTbWC1T1P
 q738Vv259C7KUbOZbJzG1ousVHtm09KHepYVs1aF1H59SooDzM2xB0=

From: Parker Newman <pnewman@connecttech.com>

Remove ternary operators from cti_get_port_type_xr17c15x_xr17v25x() for
better readability.

Signed-off-by: Parker Newman <pnewman@connecttech.com>
=2D--
Changes in v2:
- Removed ternary operators completely

 drivers/tty/serial/8250/8250_exar.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250=
/8250_exar.c
index 8665d3b7b673..521d2acf4004 100644
=2D-- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -726,7 +726,7 @@ static enum cti_port_type cti_get_port_type_xr17c15x_x=
r17v25x(struct exar8250 *p
 							struct pci_dev *pcidev,
 							unsigned int port_num)
 {
-	enum cti_port_type port_type;
+	enum cti_port_type port_type =3D CTI_PORT_TYPE_RS232;

 	switch (pcidev->subsystem_device) {
 	// RS232 only cards
@@ -737,23 +737,22 @@ static enum cti_port_type cti_get_port_type_xr17c15x=
_xr17v25x(struct exar8250 *p
 	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_SP_232_NS:
 	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP_232:
 	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP_232_NS:
-		port_type =3D CTI_PORT_TYPE_RS232;
 		break;
 	// 1x RS232, 1x RS422/RS485
 	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_1_1:
-		port_type =3D (port_num =3D=3D 0) ?
-			CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
+		if (port_num)
+			port_type =3D CTI_PORT_TYPE_RS422_485;
 		break;
 	// 2x RS232, 2x RS422/RS485
 	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_2:
-		port_type =3D (port_num < 2) ?
-			CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
+		if (port_num > 1)
+			port_type =3D CTI_PORT_TYPE_RS422_485;
 		break;
 	// 4x RS232, 4x RS422/RS485
 	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_4:
 	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_4_SP:
-		port_type =3D (port_num < 4) ?
-			CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
+		if (port_num > 3)
+			port_type =3D CTI_PORT_TYPE_RS422_485;
 		break;
 	// RS232/RS422/RS485 HW (jumper) selectable
 	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2:
@@ -789,13 +788,13 @@ static enum cti_port_type cti_get_port_type_xr17c15x=
_xr17v25x(struct exar8250 *p
 		break;
 	// 6x RS232, 2x RS422/RS485
 	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_6_2_SP:
-		port_type =3D (port_num < 6) ?
-			CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
+		if (port_num > 5)
+			port_type =3D CTI_PORT_TYPE_RS422_485;
 		break;
 	// 2x RS232, 6x RS422/RS485
 	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_6_SP:
-		port_type =3D (port_num < 2) ?
-			CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
+		if (port_num > 1)
+			port_type =3D CTI_PORT_TYPE_RS422_485;
 		break;
 	default:
 		dev_err(&pcidev->dev, "unknown/unsupported device\n");
=2D-
2.43.2


