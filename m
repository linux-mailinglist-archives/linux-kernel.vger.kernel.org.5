Return-Path: <linux-kernel+bounces-151573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC7B8AB093
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33AA11F21BA4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C4A12F38B;
	Fri, 19 Apr 2024 14:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="OAiag4wM"
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3ABE12CDBF;
	Fri, 19 Apr 2024 14:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713536254; cv=none; b=mGn6IDRMxwMLd45INnUw3NPEsqfbnQK5FcCr2UjEzPXZ7NSZUWZsetNXqLHJM1hu5d1lX4m+Zcqs0e4ArnU+2031hnEBOL2pwH8HtT+aU2wifdmK+xbY2hBRxWgj39ggRm7jhPHHe1GxUaUott1yyDZ+KrdFW7BkD3J5BfYa3Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713536254; c=relaxed/simple;
	bh=6FcMwAVQ1oQ13VSGE3/gSNaKF921zwjZHklsSqpjmWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MHciLKfAnRw2CzYbOEX0Y69J3/xtoJrmyoPRKGukud72FEpzPNDDN0JginCa/8pGIuwghk8raZPDOfxu4yJaSav319cKdvSl6X1zlUEgDX1osnfmsg82J+pZmNCd+ZQt1yabJXlJyQw8LOIa8reK/cDR1awkYgC02p9oXeNUkVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=OAiag4wM; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1713536244; x=1714141044; i=parker@finest.io;
	bh=91znGsyHENCtexZoIjuZ12Bug2BwW+jFHp+nXCy9hyc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=OAiag4wMjp22WE+ZuM2jreH2XJ9+fjOxATJqxVt98tunp2sH9oS/d0uemwOSEZnY
	 fzdFYu4VNhe8gq5ev1Diu28bVBgGTafR2kSnwFyxTBKv6tkDADDzlvr3JXoZvXvXc
	 f8yobC/DKFdYrwtjM3om7cluLs80jXe9biK8VDdxRJ/VLVudZJ8/cty1LsfKKLpqV
	 JqaIdaKSr2fW3zScF47c5ar80jl6ypbhQQ0T1oRaEXHuYEyOAUYf9FXCsTo97Pecy
	 PDBcGHg6jy9TcfFdx7irgJFpo/HNVN/Z0NTDm8APzvPOw5hSGiC5SwYWhBDcdm62r
	 8WGaEBeT4IPpfEr70w==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from finest.io ([98.159.241.229]) by mrelay.perfora.net (mreueus003
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LjHGD-1saAkF05Z1-00dZVz; Fri, 19 Apr
 2024 16:17:24 +0200
From: Parker Newman <parker@finest.io>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Parker Newman <pnewman@connecttech.com>
Subject: [PATCH v2 2/4] serial: exar: use return dev_err_probe instead of returning error code
Date: Fri, 19 Apr 2024 10:17:02 -0400
Message-ID: <447100ccb30be8af635fe7f07c70a7d6ddd3427f.1713533298.git.pnewman@connecttech.com>
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
X-Provags-ID: V03:K1:gJ/feI4o66KI/+U//3vro5I/LLpQ9rlYQ/tXWgyYls84Gd0rbm4
 3Ny625v458WZpo8EV9jNl5eIJ+5t8hPuNGrIlKO2erGwDSFjdmkEyMwiaFq+TFvUOgy8Ac2
 ZwmIrWW9uhQVKblGlE2o1jcJyeEE3Jp+wtvhndP59t0OLZstv6czD8p8NhejUBs6fLt6nrg
 5r84oNtW6OC29t/bcivfg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MeJh/ngW2n0=;bulCA/JtoEuf94hMT98XK/gXUcJ
 grjoS1ec77wgEwoDX59KjTdvaYPg1FTSVsFnWWkCyYWCQZ0jiw0tmL0E61+HunUvp/bbAr2pO
 4tBm1t3X3HjCQjm/NsjLlgWS+NXAa1O56Yb8RpJjzzKbqrbdHbpM2b5LJiAZFwYkYAOp0SbsV
 mZo+x6huGZ0LLvWAa2y7AO02+2XRllQ+VAV4XUejvU2wrecPKWNv6kGQfXJ0HohlkXk+DpfpZ
 4Onxh3zM1+FHd6kmVERrI/Txy7PkfeoVxt28eh6pBhbuDyuqkYKWzir05ZJfziQDDrvzPcog+
 JKmQ+g42DlXerE7/vL46IvgwNjSRnz4egzyzvVKK6qwjlJJ5y6MKu1D+NHQrF6Xdz03CA5cSL
 g6kJHRupKcinc5JeknFcV1Y5IjjfZ/xI/NiusPc5mzhyLMTjRLApjjL9XpI4WK+wNepEvx0rn
 F7vaUBOk5b69P5wlY33fVtA5ENmh8OeC/PtqI6bbeEdNhvgyrYI5t+4zjCKDJpvYbPPLOyjFb
 ShAJon5wyTb8rDngRj7QutVr97O7DiE7eETSe7khR/64wFdUOac3X/G0yls4Ubp+JvbeYwzMY
 yGxisWaEqD4gg5VWs31iUzTiX175Fz2BNwE24Dpy8KAlGRSBg7nyzJLXfQpSRLJCM69S+mrgB
 jbJsE9p52Xurmx1+1eXyXLjURBXWPdHhZ8uMFnv4gp9otIP+f068X/56tmi78TXVMgLwhLT2q
 eu7mmtlYsDw5JwHcNHPhEcCuxsl4/2NDQTEinr2BhQUbxd5REyEXn0=

From: Parker Newman <pnewman@connecttech.com>

Change to returning dev_err_probe() instead of returning the error code
after calling dev_err_probe().

Signed-off-by: Parker Newman <pnewman@connecttech.com>
=2D--
 drivers/tty/serial/8250/8250_exar.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250=
/8250_exar.c
index a180741da634..01748ddbf729 100644
=2D-- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -1551,9 +1551,8 @@ exar_pci_probe(struct pci_dev *pcidev, const struct =
pci_device_id *ent)

 	nr_ports =3D exar_get_nr_ports(board, pcidev);
 	if (nr_ports =3D=3D 0) {
-		dev_err_probe(&pcidev->dev, -ENODEV,
+		return dev_err_probe(&pcidev->dev, -ENODEV,
 				"failed to get number of ports\n");
-		return -ENODEV;
 	}

 	priv =3D devm_kzalloc(&pcidev->dev, struct_size(priv, line, nr_ports), G=
FP_KERNEL);
@@ -1587,9 +1586,8 @@ exar_pci_probe(struct pci_dev *pcidev, const struct =
pci_device_id *ent)
 	if (board->board_init) {
 		rc =3D board->board_init(priv, pcidev);
 		if (rc) {
-			dev_err_probe(&pcidev->dev, rc,
+			return dev_err_probe(&pcidev->dev, rc,
 					"failed to init serial board\n");
-			return rc;
 		}
 	}

=2D-
2.43.2


