Return-Path: <linux-kernel+bounces-150408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 349208A9EA1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E63F42850EE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F57E171E62;
	Thu, 18 Apr 2024 15:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="r5fbv7oE"
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D7216D4C7;
	Thu, 18 Apr 2024 15:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713454654; cv=none; b=PnnptcrI9KZl6/wpdkPEWffs21wgHwHzhotHw8AfPr5qBJXMf4yi1aXG37ilD40Jv4BN9/RZnDLgci1fbMLSV62rnE0n4fj9ZUIQwLClv8I6bExJHXHN9Zsqhldq8kwlL47e7ZNVzIVpkU01xtZehJaOEDTjCK9yY4QQSkro31I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713454654; c=relaxed/simple;
	bh=xrOseHxGhJJjbzBk9CbfMrD6MMhOfu9NvA7fUAzlpU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nJ8YjsNlk9/kLPdwUDq02azhPTKPe4V3e/4YLhnKgfYRtCEdUoqJjuRqP0ydMInVPRxfVk1iVktFTg61zrC+N6z3VsRT6G//xbbVqJLzPaKHKxfOW1X39AfgE1oJMFatEgEWQSsUc/fNZyG3wL+T2chmCuNo5KgOyH6y5KA2bME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=r5fbv7oE; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1713454633; x=1714059433; i=parker@finest.io;
	bh=Ph05WVH8sofutm+g3QQ5ry41ZKtih+7xDUpbKSmjN4I=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=r5fbv7oEwfLqrnoh+j/ksY4L5IwuHNOKOQeg0k/XemuRryPSYclJ2FLiJ4ctSoUX
	 7hnv6uks6oawn5/EjnLQHd1lS1rcv9dYz2wNzdaJVGB1KD4OHIZdMSD3oa0SxEM6o
	 7O1NkCAhUWjoY01I+LJiBNpYWBNw0tTfrbQqopTr59lGbN3d3p/GRSxaadDhd4Z1v
	 TZOcXu/PyVty3JmJUH5qjfBC4HaZDtS3V1eI5VphuNN01mxzH8jgzs3yBuSJlj5Hw
	 viUxMSWZWgf5aEdqYVeaLG5hkYY3miIQdTGWyFUEJMcd44n/KJ90DwsvHD90O61Ng
	 OkUKA3CuNBwF3Oy+Hw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from finest.io ([98.159.241.229]) by mrelay.perfora.net (mreueus002
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LbL7E-1sQil122iA-00bgXD; Thu, 18 Apr
 2024 17:37:13 +0200
From: Parker Newman <parker@finest.io>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Parker Newman <pnewman@connecttech.com>
Subject: [PATCH v1 4/4] serial: exar: change port_type ternary line wrapping
Date: Thu, 18 Apr 2024 11:36:31 -0400
Message-ID: <0081b6a7bbe1ad6ce114132f9ee86677a761de6d.1713452766.git.pnewman@connecttech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1713452766.git.pnewman@connecttech.com>
References: <cover.1713452766.git.pnewman@connecttech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fEdVUzoim6yTgaflYo7WrYliLGG0Wd9ACHr3RzLIhaHdwvKaju9
 HWlFhCpk0hiZYrfoc0FF7pIRylyoh1sT4OKHwi7t6+nVgn2YVeeaUEm9zo2SPsNe4y2KRX/
 wFdQJCqCT6oKVg5sgieP74HMhPeIHtFDMd6aYgYNc/GGM0/VZ+Kz9JI15Ahjr7K/iycRQfo
 iNhp/q8p9PiQdWqdESFLg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Pq4BudVsxuU=;/kKc52QHcdEgk6SZ40r+13oNiO9
 y0Hdf6jbiYkC817XjeW3l99+fHoN98GGqpHGbLX7/kRj1AU8S9SNkzuaeGzHb0tnDhQSCldco
 oSXEqc0q59StSVzfkkLGB2EztL41q5RoCtNBnqzDJWLbhAQgtN+7HFxT98Ugcj0s/QGgHnlsQ
 MvPJwBpvlFsxjfrJnFR8gUSofhX5FrrcjLym9Ros+zljucxYs3BBPw92aOEkaraZmKHwoHG7v
 cVjW3+3u8XZI0Gc+9jpTY1aXNKcDP8wwAKCOAcQvcui0exB8jn//hbLXpcxlUY+z0qZF+j9f7
 WbGq1yHPaZriXjnbnam0bIif2XYyJGsltl1XYvreb/jNnou7Aak/qVaYGcL9LSM/gvXmMzUHW
 xcmscw7G9kHPYhDWgX1lUi/R+LNOJe7L6fggQ9I3Ks3flJux3mZlg2qbu73ittHpVsF7I6COU
 yePrv1WUpljSCBYgeyaz9nERZU5xQOcUdUA4QpklNcwDYgaaGasaiG/w7Z63n3uW9KFTjgt9/
 PARSvKDF8YFcQUO/eFU4kRxf88CkF6PFp+UgjHveZs2h4a1tI2+ze/MQf50goBItoGoR1Ya0z
 CoaqZtsJuBgz2mrBosFUb7CZ3DExmxVQ4oCEI/SoQ5ZCRiCCDE2eRHe/tb2f0syBGGf6c5gYe
 JNl5ZvgpaKEQxz0QatBkO6k4ulHawUNIgA8SWwnPAPVZFpJl9z189I9P6HwWhUasDAHuyEHrP
 1wQ34J7Pf2v6An3zwxMwbJb7SKcSXodYTHZ7KA/iQjmqbnWZBFiGd0=

From: Parker Newman <pnewman@connecttech.com>

Change line wrapping of ternary operators in
cti_get_port_type_xr17c15x_xr17v25x() for better readability.

Old example:

	port_type =3D port_num =3D=3D 0 ?
			CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;

New:
	port_type =3D port_num =3D=3D 0 ? CTI_PORT_TYPE_RS232 :
				CTI_PORT_TYPE_RS422_485;

Based on feedback from:
Link: https://lore.kernel.org/linux-serial/f2353b8c-2079-b895-2707-f6be831=
61288@linux.intel.com

Signed-off-by: Parker Newman <pnewman@connecttech.com>
=2D--
 drivers/tty/serial/8250/8250_exar.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250=
/8250_exar.c
index 10725ad0f3ef..a76b4e5bab4e 100644
=2D-- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -741,19 +741,19 @@ static enum cti_port_type cti_get_port_type_xr17c15x=
_xr17v25x(struct exar8250 *p
 		break;
 	// 1x RS232, 1x RS422/RS485
 	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_1_1:
-		port_type =3D port_num =3D=3D 0 ?
-			CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
+		port_type =3D port_num =3D=3D 0 ? CTI_PORT_TYPE_RS232 :
+					CTI_PORT_TYPE_RS422_485;
 		break;
 	// 2x RS232, 2x RS422/RS485
 	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_2:
-		port_type =3D port_num < 2 ?
-			CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
+		port_type =3D port_num < 2 ? CTI_PORT_TYPE_RS232 :
+					CTI_PORT_TYPE_RS422_485;
 		break;
 	// 4x RS232, 4x RS422/RS485
 	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_4:
 	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_4_SP:
-		port_type =3D port_num < 4 ?
-			CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
+		port_type =3D port_num < 4 ? CTI_PORT_TYPE_RS232 :
+					CTI_PORT_TYPE_RS422_485;
 		break;
 	// RS232/RS422/RS485 HW (jumper) selectable
 	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2:
@@ -789,13 +789,13 @@ static enum cti_port_type cti_get_port_type_xr17c15x=
_xr17v25x(struct exar8250 *p
 		break;
 	// 6x RS232, 2x RS422/RS485
 	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_6_2_SP:
-		port_type =3D port_num < 6 ?
-			CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
+		port_type =3D port_num < 6 ? CTI_PORT_TYPE_RS232 :
+					CTI_PORT_TYPE_RS422_485;
 		break;
 	// 2x RS232, 6x RS422/RS485
 	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_6_SP:
-		port_type =3D port_num < 2 ?
-			CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
+		port_type =3D port_num < 2 ? CTI_PORT_TYPE_RS232 :
+					CTI_PORT_TYPE_RS422_485;
 		break;
 	default:
 		dev_err(&pcidev->dev, "unknown/unsupported device\n");
=2D-
2.43.2


