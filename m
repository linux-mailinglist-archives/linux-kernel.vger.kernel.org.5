Return-Path: <linux-kernel+bounces-149186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0B28A8CF6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 22:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98B4E1C21B06
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B3A52F6F;
	Wed, 17 Apr 2024 20:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="MyLlPdJd"
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0FA44C94;
	Wed, 17 Apr 2024 20:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713385924; cv=none; b=O7fhlXnIvFUoVJsugOzMOxAw2j+6QyPm/enWpyOzPO6Yg633ur/1zSFtq6ZD2D6XFj+i1weeQy/fFZJLTvgpu0Dx5W5+wKjrytHRoAm5B+gQGjP/kPCuxgpZQt6XUmoIKiJtoP7DvbAKZBdrFhfTvEaHoaW0F2f7ttgJEK1mXlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713385924; c=relaxed/simple;
	bh=yJdXC/Q3Xr0EL7UYdwsyh7gdRvydjr3J5vNqgkjgxnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jk2p2EnJ6zWCThlNmN0J+0ojhFRHJIsNEpmBhftvol5rmUU5r/B/FRxfkhVNtgqJQqFTArBL8cAn+785PXCZWLYwkpfrD+VM8oj0UKL810dW2W8cOBYK1od8cOuqILJN+GNHaquEROxHq8lpoUJS/cl6heV2NMY0ZaB6qMspCMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=MyLlPdJd; arc=none smtp.client-ip=74.208.4.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1713385914; x=1713990714; i=parker@finest.io;
	bh=8DVZiB5rBLaO78Y9u12D3SplbPcKBaSsMHCST2QVFuw=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MyLlPdJdmZPEQzTkWQ4NCIXVXhZAtHIxN9X5ntx6h3aZgfQGf5o2ln17J5oxubqc
	 DLH9TrscN4o7nN0t8vGq0zqHA/5tT92h2f7iyliHXlNh2hKN0/o577fcBVTumPwZU
	 E7Jx5F4Ls915MQBmcg+a1aEADe/akbuGf+4bobAXj59P2qYLjuyNvzWjquGueGoMI
	 BkhcGBApx4GjdPc18tVJ4TRuaDisTc12fmetdNrKOIMlGpbDXUiqsE0CzTiOPPQCY
	 TCX6pI0U+v9iwlGJWjJW30Jie4jgtXnVIdGrN/T6GZb8l+IeV2DaJxZWhGrR9sj/a
	 qNz929ZcOPOkDsUJEg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from finest.io ([98.159.241.229]) by mrelay.perfora.net (mreueus004
 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MBVVT-1rsUq5124t-00CwVn; Wed, 17 Apr
 2024 22:31:54 +0200
From: Parker Newman <parker@finest.io>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Parker Newman <pnewman@connecttech.com>
Subject: [PATCH v4 1/7] serial: exar: remove old Connect Tech setup
Date: Wed, 17 Apr 2024 16:31:23 -0400
Message-ID: <06a04b6c683ca20c50646cc0836be869c2dacd87.1713382717.git.pnewman@connecttech.com>
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
X-Provags-ID: V03:K1:2kIeL5o789fbeAlzaygoEOoFLPT2MfcgRCrP8EJ+m6PJmvEBqKY
 zVpcpiFUeN30e15WClQbIkHzFwm+UpFZxKNkXGjaACl54e40JzGslnscRSNR/uRKwFHQRBs
 qkDo+sKprMZws6lr3Kq6rNWff7TRbxnAPi6/9tjCjSU9MuGjjjm/fFDIgMdpqvac0zGp2+X
 8Rtdy0Mui41IGFhJ/7z9A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Yu7mW78t6mA=;1+wiX4ZdaFrem6Q5HZc/8J/EXXo
 tIklVqD0xoMJXSxx1eWM4R5vojnxwEoEDFiQSZak/tJePgUAv4u3howzxHkqEmARt/1xkTACC
 bNG2pSE6aY/LqMmGeVZlNqG/CsaULsDi8Mx/ncz1cvydMG5lZt8ADvIo6yKz/BGTkUjgL6k0a
 3HUA99P8G7nwueXBKGnrUboGcuFW6iD+Lm291PWdiUi8dY4dY01Ii8m7U4LJcFZ3YEKMFKXue
 O8/edle2oHnnNLkcbIlpYy9lo/+eZ8UUFqcCFoDB4hx+2hXHnejsoOsjka3oTwIfMA/n/WFJw
 TFE0GYONBO02CRb75a0ulTnD/FWIsuCnGMbvEfqCKwqT6Ru6Paklz6ndbD48OWYSMZQJseI5l
 lBpFkAeYUor+/qXC3QPZjJoBZO6vS3VFOmVaOoLMHXPIGcN5jbIJ9/Qet0q08EweFnJbIe+Tw
 lIOWSgpHdxSo3MyA2+SLEsX00DmBqsd0jHPcSFhWstnvwM7SB8Vtq+jtd7iRG1Acl9iv7tFnG
 aymPo4t/SYVvM1/6QQuPCvj9RjhuNTTfOmnruya5DJSHrQlR0IIIpBe8l3E5NfroaymEvastJ
 MtyYH46g3vlMGj25EKP7qlnSeDTKj35JWN8ipoqscn2UhW5AQ2axu7iWVVsuAHVzt4R3TSxa2
 mE5pTY7rfMr67gJG4ynpvgmh7JMgTtfs++5KoYHCN3vJfiVxgwfDfEwN2pQYC2PXUhU22MOLJ
 8L4OWp/9oRGneeBLEiOrCTrdLaqjWOkiQrE/DIoMms3oXcKXh36R0g=

From: Parker Newman <pnewman@connecttech.com>

Preparatory patch removing existing Connect Tech setup code and
CONNECT_DEVICE macro.

Subsequent patches in this series will add in new UART family specific
setup code and new device definition macros to allow for supporting CTI
serial cards with Exar PCI IDs and CTI PCI IDs.

Signed-off-by: Parker Newman <pnewman@connecttech.com>
=2D--
Changes in v3:
- Split code removals to own patch

 drivers/tty/serial/8250/8250_exar.c | 37 -----------------------------
 1 file changed, 37 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250=
/8250_exar.c
index 604e5a292d4e..04ce5e8ddb24 100644
=2D-- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -358,17 +358,6 @@ pci_fastcom335_setup(struct exar8250 *priv, struct pc=
i_dev *pcidev,
 	return 0;
 }

-static int
-pci_connect_tech_setup(struct exar8250 *priv, struct pci_dev *pcidev,
-		       struct uart_8250_port *port, int idx)
-{
-	unsigned int offset =3D idx * 0x200;
-	unsigned int baud =3D 1843200;
-
-	port->port.uartclk =3D baud * 16;
-	return default_setup(priv, pcidev, idx, offset, port);
-}
-
 static int
 pci_xr17c154_setup(struct exar8250 *priv, struct pci_dev *pcidev,
 		   struct uart_8250_port *port, int idx)
@@ -849,10 +838,6 @@ static const struct exar8250_board pbn_fastcom335_8 =
=3D {
 	.setup		=3D pci_fastcom335_setup,
 };

-static const struct exar8250_board pbn_connect =3D {
-	.setup		=3D pci_connect_tech_setup,
-};
-
 static const struct exar8250_board pbn_exar_ibm_saturn =3D {
 	.num_ports	=3D 1,
 	.setup		=3D pci_xr17c154_setup,
@@ -897,15 +882,6 @@ static const struct exar8250_board pbn_exar_XR17V8358=
 =3D {
 	.exit		=3D pci_xr17v35x_exit,
 };

-#define CONNECT_DEVICE(devid, sdevid, bd) {				\
-	PCI_DEVICE_SUB(							\
-		PCI_VENDOR_ID_EXAR,					\
-		PCI_DEVICE_ID_EXAR_##devid,				\
-		PCI_SUBVENDOR_ID_CONNECT_TECH,				\
-		PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_##sdevid), 0, 0,	\
-		(kernel_ulong_t)&bd					\
-	}
-
 #define EXAR_DEVICE(vend, devid, bd) { PCI_DEVICE_DATA(vend, devid, &bd) =
}

 #define IBM_DEVICE(devid, sdevid, bd) {			\
@@ -935,19 +911,6 @@ static const struct pci_device_id exar_pci_tbl[] =3D =
{
 	EXAR_DEVICE(ACCESSIO, COM_4SM, pbn_exar_XR17C15x),
 	EXAR_DEVICE(ACCESSIO, COM_8SM, pbn_exar_XR17C15x),

-	CONNECT_DEVICE(XR17C152, UART_2_232, pbn_connect),
-	CONNECT_DEVICE(XR17C154, UART_4_232, pbn_connect),
-	CONNECT_DEVICE(XR17C158, UART_8_232, pbn_connect),
-	CONNECT_DEVICE(XR17C152, UART_1_1, pbn_connect),
-	CONNECT_DEVICE(XR17C154, UART_2_2, pbn_connect),
-	CONNECT_DEVICE(XR17C158, UART_4_4, pbn_connect),
-	CONNECT_DEVICE(XR17C152, UART_2, pbn_connect),
-	CONNECT_DEVICE(XR17C154, UART_4, pbn_connect),
-	CONNECT_DEVICE(XR17C158, UART_8, pbn_connect),
-	CONNECT_DEVICE(XR17C152, UART_2_485, pbn_connect),
-	CONNECT_DEVICE(XR17C154, UART_4_485, pbn_connect),
-	CONNECT_DEVICE(XR17C158, UART_8_485, pbn_connect),
-
 	IBM_DEVICE(XR17C152, SATURN_SERIAL_ONE_PORT, pbn_exar_ibm_saturn),

 	/* USRobotics USR298x-OEM PCI Modems */
=2D-
2.43.2


