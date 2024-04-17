Return-Path: <linux-kernel+bounces-149185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 981468A8CF4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 22:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54EEB2866BB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069BF4AEED;
	Wed, 17 Apr 2024 20:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="IpYU9e4b"
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E183D967;
	Wed, 17 Apr 2024 20:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713385923; cv=none; b=V/MFRKjuAn0omkD/EFwEOQy0FGwFEnTu7M59JmkMaD8lX8wyNELqyZ+cgso2G0bk0WdqfwpFnzl1cooStZyDLOXWRVoZwRbgxM/4LSJkLKq1etU2OlZm0lVgfSu7REAMaJY+0IfSGqvlS6/Rtroqpy+800+k5qggGhBuPP+lsjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713385923; c=relaxed/simple;
	bh=bx7VWFAj9zkp6xgsrVbQBN8r0hAL1+YWgodpGDfPiwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VRjUXoskUpKzUqrL9tiTphd7rHpR/dIq9GIdHW4X0HZeLs0Mgb4SctlyTJ1wUHJv4nfh+iEGTQ+4+H/JlDY8pFBznrr7+Izj82e1E9/qWWO0rJLjykucA2Vwq4narMiYdURIGlFChyItPIaJCQa8o2bHi/EH9XLvYHt78Xw3LhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=IpYU9e4b; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1713385914; x=1713990714; i=parker@finest.io;
	bh=D0cLuCAUv1D0ayVna0ISlfjCEXY7iRquaoAsOH9TeO4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=IpYU9e4bz++EAGzAO+iM2PGmgL+utMk/64Z07YsylnRF3tL4MO8RfB4OSN/oLsc5
	 qNH2hhGQPzuI3JfHldy2B/JUi4ooU0d1W/DopMgCmWMTXHH3fTFQWBT913vuSjJUd
	 AzB6a75yIzAUTZsWzNUkJcw4REfuiRGeceYOpDFX0P5rV9P4yqUqE08rcC9r8+oyw
	 z/tucpCQwzuG7Subp3lRIlX3e57lrGi1Kcc0DDGIkAq1ywOEPipysyQuss4Sx+azF
	 gfD120Yf+n30m2N93WWYXq2VZohXmkg4qZd4nARB51GGzR2SLuUausKnPLJlvVmxm
	 fG1kILzra/mltLT+2w==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from finest.io ([98.159.241.229]) by mrelay.perfora.net (mreueus004
 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MzyVm-1suEVo2JJ0-00x6AM; Wed, 17 Apr
 2024 22:31:54 +0200
From: Parker Newman <parker@finest.io>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Parker Newman <pnewman@connecttech.com>
Subject: [PATCH v4 2/7] serial: exar: added a exar_get_nr_ports function
Date: Wed, 17 Apr 2024 16:31:24 -0400
Message-ID: <33f2bf66bc334573c10cf670a299ecef0b7264bc.1713382717.git.pnewman@connecttech.com>
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
X-Provags-ID: V03:K1:lmxjJVTt5Rxry9+yxUIQhHvHMuCXBS86zV+ew9oOXQmeZeK6tof
 Dt1whiHtZZ6rMhpcuLVF7YL5rn0i+mbVkefwzyV+A/gtdj8gxTY4o5ABsg720axXQG/ZzES
 PL8cvcXFuz/7S6jg4aY6OobTFnARSKXiUNYplOIMmoeAywqdAMgLDiTEAlRxutO5P3/gKoE
 VANiRnIkckaen/Ija5TTw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:g4f2b9UA+MY=;7N1TVxiFRc05BDan4sTTMmiIbCt
 kElQvHp5BQ+bKwrp8hMyq1L29KrbLAmKq1lyp0VlDesaTYsGAzBSqUIFIJPrRg7tXL7qh9pIY
 0kXWBLen69BwKuo8Vw+lP5DSfGKa9//+vNePUHVMyixaUKB24gfPrzFrcdOXIyxxooxL+IgmI
 JbEztJPY4EL5KnV6secdH+2vByFbwXK2kCzqm2fq6f/kwOqWZHPX9uD1NKj0L94VxSO4B/eLO
 k8fyOLCCuiPcfAuH2rkl46GvGIYBvKMIsr1eX7VmzpusvzeKA6JsugKIQNUTXtQw0BTy9HmHn
 EHVJejVnXnq0QFFJAQtPDw2MHiiFMBTwta6s6XaIuqoBc+UauOQkHUII1324LUvOGdatQDKxZ
 fKZBRhL9s+x56tljmtEBSEEecoa5QRqdMszjfSxo6W/hUGJufsvhDy7aTq5dxrJCeTGL6CPgB
 skCYsWs1m4NWL5YT1N8tfWorViRRlMbbN2nh6WneWBblQ3ZYATue45fjgpvpwmYVHx6WRbMsF
 GHBFC+rgwN/JH9XMjhhMQZMOuwrfHA/5TiWMhTqIBQ2dhhqV1ZnUVAEGsbK5WiAfuZwjaXQZ2
 2wvWaiSyowQxhFf0HZaxqrnx4mHG5PzrO7mx1Pa5p2o9TXJrguRtKxs2U2TYJgdH/pkQ5dsEC
 U7ZJMJgcTK7bN3EZzmyI/mMaAEFotGM6GB7aAjR9J5muAsquJdFE/U206uhUZjevK4XElD8eT
 ecda+uaZR7rh0tgAUz+qmonwYjKblhloi5pqFDWrJ1GMfnUccounF0=

From: Parker Newman <pnewman@connecttech.com>

Moved code for getting number of ports from exar_pci_probe() to a
separate exar_get_nr_ports() function. CTI specific code will be added
in another patch in this series.

Signed-off-by: Parker Newman <pnewman@connecttech.com>
=2D--
Changes in v3:
- Only moved existing code in this patch, will add CTI code in subsequent
  patch

 drivers/tty/serial/8250/8250_exar.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250=
/8250_exar.c
index 04ce5e8ddb24..72385c7d2eda 100644
=2D-- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -704,6 +704,21 @@ static irqreturn_t exar_misc_handler(int irq, void *d=
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
@@ -723,12 +738,12 @@ exar_pci_probe(struct pci_dev *pcidev, const struct =
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


