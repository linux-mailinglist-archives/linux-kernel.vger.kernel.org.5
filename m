Return-Path: <linux-kernel+bounces-162372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0588B5A13
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60BC91F2213F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E666F099;
	Mon, 29 Apr 2024 13:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="GXiT4dQZ";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="b9F6O//n"
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF202C69C;
	Mon, 29 Apr 2024 13:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.97.38.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714397586; cv=none; b=Uag8XfIIB2D3+dskv2TLaXWn6ebMrwdtPArl+WT8PWxaEE5reUnBMgwAWbssiDH2T4P1SWYdvTvazFLSijAtYk4HRYUpSuN8GMS1ikKmp7cqwCIfPe6awBTU+ovYNTwnOfWUAF/IaIS8MlqQeECXzlQ4xDXV90TFPPAQcBdsm8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714397586; c=relaxed/simple;
	bh=4j6weDF25jQZQUdqxLsaoiFHuIeMxEvPiuo5E2VrF30=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PX9FVebisIf7BxZYXmWN9DlV3sPk0NhgWtzjsxE8ODacz7H6OsSuPIIGpnQEFOYmHJoXqs9pJr+e4/VrKJE15kXSI9qI26lcO6yRk67bLpg4foLKJu+7jJL7ocOIgrpb5R3qCQQas1MTKwYy+4xv3Vq63/u0PRrZuwhZ3WMxaf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=GXiT4dQZ; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=b9F6O//n; arc=none smtp.client-ip=88.97.38.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1714397575; bh=4j6weDF25jQZQUdqxLsaoiFHuIeMxEvPiuo5E2VrF30=;
	h=From:To:Cc:Subject:Date:From;
	b=GXiT4dQZDDvyvBeoxoXswxBOaDftcqjQ8OfAE5IzwJpeCEn+1YYpYAGET/P6p93pO
	 5Fp2lKdIT70SfMjXSjWMtVmwb+/YizN6odwkXPkGSMdBEbgcF2UNSFYBYRpCZjCFO0
	 sMzsL64N9ZnIN+lGYXnzp2kwxQtVjpFENlknqFEcDMZRuc550ONPAqKAZk997QBnMR
	 A5REmOuqN5BZ8SV0AjkKdgu9T8xgoXfq52x8SmiXYEmoRjGRhYlzWq7vVnFmL8AVwu
	 JMKAJiqrSj8swqzOTzZc3EEDQcsrWxQYweFivFTzJhoQv33qQ8FZ2VngLhUiM5RpCr
	 VKzcTi9e2gs9g==
Received: by gofer.mess.org (Postfix, from userid 501)
	id F1C9310006F; Mon, 29 Apr 2024 14:32:55 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1714397574; bh=4j6weDF25jQZQUdqxLsaoiFHuIeMxEvPiuo5E2VrF30=;
	h=From:To:Cc:Subject:Date:From;
	b=b9F6O//nf7xWEL9Fyei9FUJJvryHOCwfcnCqGSaq2qv/WebSwe3tmrBw2w5GdhinB
	 hww2IcJup65qyfz2SwAaTwvcg/+XOFr56IRSyZ88vsyFp/5ZIw/S2WXhjelGUvYkXu
	 GD7X6mQSawRuWpNoM3jrdgkprA0XpSuNvLf5AhNLS396Uk+C6yCmIQQrKmqNobSCFz
	 EToBXthsbu9j7uufrZysm1q+swK60iNjOCMKV3F3teWaPHIDwFNTmAQOv07Dh8V6UM
	 0j2fMAWU6lyU2X6/EOMvdQoBs1/v515T4iQSv5SKP1Pqel7G7l9f1ktr2e4q6dZk5w
	 2dkVz5bvYMW1Q==
Received: from localhost.localdomain (bigcore.local [IPv6:2a02:8011:d000:212:bc3c:1b4a:a6fa:362f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gofer.mess.org (Postfix) with ESMTPSA id BA86D10005B;
	Mon, 29 Apr 2024 14:32:54 +0100 (BST)
From: Sean Young <sean@mess.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] media: mceusb: No need for vendor/product ID in name
Date: Mon, 29 Apr 2024 14:32:31 +0100
Message-ID: <20240429133232.820988-1-sean@mess.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is available in other places and doesn't belong in the name
of the rc device.

Signed-off-by: Sean Young <sean@mess.org>
---
 drivers/media/rc/mceusb.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/media/rc/mceusb.c b/drivers/media/rc/mceusb.c
index c76ba24c1f55..8e804f41e083 100644
--- a/drivers/media/rc/mceusb.c
+++ b/drivers/media/rc/mceusb.c
@@ -494,7 +494,7 @@ struct mceusb_dev {
 	u32 carrier;
 	unsigned char tx_mask;
 
-	char name[128];
+	const char *name;
 	char phys[64];
 	enum mceusb_model_type model;
 
@@ -1591,12 +1591,8 @@ static struct rc_dev *mceusb_init_rc_dev(struct mceusb_dev *ir)
 		goto out;
 	}
 
-	snprintf(ir->name, sizeof(ir->name), "%s (%04x:%04x)",
-		 mceusb_model[ir->model].name ?
-			mceusb_model[ir->model].name :
-			"Media Center Ed. eHome Infrared Remote Transceiver",
-		 le16_to_cpu(ir->usbdev->descriptor.idVendor),
-		 le16_to_cpu(ir->usbdev->descriptor.idProduct));
+	ir->name = mceusb_model[ir->model].name ? :
+		"Media Center Ed. eHome Infrared Remote Transceiver";
 
 	usb_make_path(ir->usbdev, ir->phys, sizeof(ir->phys));
 
-- 
2.44.0


