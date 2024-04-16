Return-Path: <linux-kernel+bounces-146838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECCF8A6B9B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F5601C219A3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A26E12D201;
	Tue, 16 Apr 2024 12:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="3CdkqIp/"
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7C312BF34;
	Tue, 16 Apr 2024 12:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713272217; cv=none; b=lS5RxwPaMX9ufnpvptd5j/peIvTCcGDIJIyMXa3tIpetOWRPZsB/jCOuPM0TUBoL1hBOByajlVtcSUjCX2f+VElEHBvATOFCNmr69HaOamBNvBTgrZJTguh2VcNP+BI7A72F5XeshZ5Yli6fJVbW34sJEIP0dL61xM7WOznvJoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713272217; c=relaxed/simple;
	bh=GfaI+aTHir3/wRw2tSbsMcT/xQWxfCW1Zpvm4IBN30I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SNp4VbbC6A+nBL5clsHNDaVFGycxaNmB7dZ2KqwdrqUHgL3hoMsUggD2gZlcOvCvlxXl0iDesvKccJbl8R+M/DGygpL53LW18xms5nlJCikeps/ZC7yGGlq8M15jTIV3t7OPfEklWTLwoEF0QPXB0scBry/wLMOeWOBohS3EU/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=3CdkqIp/; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1713272196; x=1713876996; i=parker@finest.io;
	bh=+5Vvf/SAWIVW3yfOilRLx3KOgf0DZrr2EGtuyz53rGE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=3CdkqIp/S945EkDX+Ohc/Z0oq/M+BhSk95gKlBLXMo3DQQbgO45n9BIZ92V/mfsK
	 0VG8PMS7YNvasw9Mjdtzz5n9tLeFVYt1HfrKx4gafCYuEzrn2J8NlMDjM5RcuyVKr
	 PuBMlfNnCMYnjrsB8kcwtkrOCv6K9YDrkpD29q0JTZ+N6CqsWhopiuMt46ELeKwQc
	 QIEAR2V6xXWxUUTfVHVZ9G+ekLbkdzHEJRnXshzAsZaWvTFO4faVIvLJ+tE/tUGfW
	 lTDwl8E8Lm1JBOuDrtD8T6bkeB/CS07/zmp7zpcPbTBmXgJulcpx0PlWTzfu+B5QL
	 CHZb5GWQqdP2WILuGw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from finest.io ([98.159.241.229]) by mrelay.perfora.net (mreueus002
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LmaZx-1sVm8F2keh-00joZK; Tue, 16 Apr
 2024 14:56:36 +0200
From: Parker Newman <parker@finest.io>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Parker Newman <pnewman@connecttech.com>
Subject: [PATCH v3 3/8] serial: exar: added a exar_get_nr_ports function
Date: Tue, 16 Apr 2024 08:55:30 -0400
Message-ID: <56bda5690e76a297bdec6768ea1f5d11c32e5eed.1713270624.git.pnewman@connecttech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1713270624.git.pnewman@connecttech.com>
References: <cover.1713270624.git.pnewman@connecttech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uCv4vkQ33eN02KL/ElIF9H4MqZXklXDLUNpgf/pe4WOXXYWzAy+
 4SoeRHdj6agPH08sp5szYCC8/qiYLVO3hWHSdxQIgkyBYYfP4rcKnFzGuMNTXmNvWXGrvQz
 XpYrn7Pxl3OQTcY5slnizBMcDFBht2oWZH9EHiRqgtnov2ta4tnVCCaokE/xE73pbHnrob3
 FSsg3rDz97sRvlLy9VGgg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Xf9sIUOeSHE=;/edaBReefVY65VfKAskOva2NsFn
 EyAg+JEWGlSJzmtHT9gBvne1ukFw6a8mQ+LJPVvcJ3N2rb2HfK7eaoO0zyJ68q0LkugBxSv4P
 OQn8ue60inu9O9mnoENNeq8GEx+DI0UNrsMmJ8cIMit7Yq7weoAXahzD4eg9h7NA6NJ6kwOtI
 RY7Dhe3Tbmzr5O6CBvwcEb/4QrvNhh1GP+G0gYlmC+U7uNDr18k1BTYVj9eCW07vRhhhmunba
 f8DQnSTuoocz1iVj6r8HEeEITXDgVC7qmfeOJpnpIMgjhqx5wVOzzewVc9XdMdgt3aPI4P+nh
 yQUshury6VtJYOm4eaee/s5Ee/a3Lvw3WWf7BBKT1vx4/X2hVcOnBJhzicT4vEbcPxZKCsoY7
 Y58hNrUiuydgblq1gHsfFZzt+ODH9MQ7AJYlt+KRcOoRfrE7jRqH6GI70rUSO/pv3ZoQOyYaU
 T5rEHfm61nRC0fZNYVcDDD8UsGdx8dEUaypdsrhNfskt5MBL91FN2HWJ2LAPNd4slGMGUxZbP
 7TIsQ5ch1+2n0oRxligJhbvFWzVJW0ghkcD2Ej9EHhdA2nmPHhX+LKQQMPJ3BjPZ8ctBdDyEJ
 XRdmpyZi7WcuAHc3itTzMqtDw/VHX+0ge2SRh2eSxYRzZpRP2W9mk2mQCR76weqSK8QAd4mkj
 0DiOBqFC0x+hfcNdurHOEMpMLn3lR02LJxPZz7ALVUSzA/lk/ol36sv/dOu5vqRc16HmrHfRT
 cHy6g8LLG0Ubg9cEK6Ppm9+kikVPvc307r57yeZ2fKFvdBJzkn+Wtc=

From: Parker Newman <pnewman@connecttech.com>

Moved code for getting number of ports from exar_pci_probe() to a
separate exar_get_nr_ports() function.

Chnages in v3:
- Only moved existing code in this patch, will add CTI code in subsequent
  patch

Signed-off-by: Parker Newman <pnewman@connecttech.com>
=2D--
 drivers/tty/serial/8250/8250_exar.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250=
/8250_exar.c
index 3565b880f512..388dd60ad23a 100644
=2D-- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -703,6 +703,21 @@ static irqreturn_t exar_misc_handler(int irq, void *d=
ata)
 	return IRQ_HANDLED;
 }

+static unsigned int exar_get_nr_ports(struct exar8250_board *board,
+					struct pci_dev *pcidev)
+{
+	unsigned int nr_ports =3D 0;
+
+	if (pcidev->vendor =3D=3D PCI_VENDOR_ID_ACCESSIO)
+		nr_ports =3D BIT(((pcidev->device & 0x38) >> 3) - 1);
+	else if (board->num_ports)
+		nr_ports =3D board->num_ports;
+	else
+		nr_ports =3D pcidev->device & 0x0f;
+
+	return nr_ports;
+}
+
 static int
 exar_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *ent)
 {
@@ -722,12 +737,12 @@ exar_pci_probe(struct pci_dev *pcidev, const struct =
pci_device_id *ent)

 	maxnr =3D pci_resource_len(pcidev, bar) >> (board->reg_shift + 3);

-	if (pcidev->vendor =3D=3D PCI_VENDOR_ID_ACCESSIO)
-		nr_ports =3D BIT(((pcidev->device & 0x38) >> 3) - 1);
-	else if (board->num_ports)
-		nr_ports =3D board->num_ports;
-	else
-		nr_ports =3D pcidev->device & 0x0f;
+	nr_ports =3D exar_get_nr_ports(board, pcidev);
+	if (nr_ports =3D=3D 0) {
+		dev_err_probe(&pcidev->dev, -ENODEV,
+				"failed to get number of ports\n");
+		return -ENODEV;
+	}

 	priv =3D devm_kzalloc(&pcidev->dev, struct_size(priv, line, nr_ports), G=
FP_KERNEL);
 	if (!priv)
=2D-
2.43.2


