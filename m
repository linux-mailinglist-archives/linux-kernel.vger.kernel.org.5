Return-Path: <linux-kernel+bounces-164232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB94C8B7AFD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A738F283E2C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FBD77118;
	Tue, 30 Apr 2024 15:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="bvNQyhix";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="TVaBAxDq"
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E507152799;
	Tue, 30 Apr 2024 15:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.97.38.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714489644; cv=none; b=Xl/Qv1ofJV2IzCN/JrjRvSyu58tgfiHrjsaXg4lGYfYD1XuPUtax/q9RERRegXSaTNWxVzpOSsJa/BnrgM5K/DnwIWmkUivYZyJZi+J2laS8xT4Xm6Rqn0bw4MOl57NnBg+hKgpQdb7BKx5Y6ItJ84vzkMGic4DZEn+JsZUbqIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714489644; c=relaxed/simple;
	bh=P1Yb9UHx7qGFrtffHgDWXFAhgYxkjfHOuo9CX+hCpI4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IRkG2yisznq3Gz2NGaEfuAs8HoYfiB9wLdh5b4DuG9slMg4jN4BwCd6o7tF5tKgen0jXt5w8Kw7JqJV8LEcso7Sj/hBTahIy4duniwIOrM7UEkwtsOkKzcxADjwP68KckN8Ok36t4Fw1kKQbm3Nz5eUN8AgwqfPPWohXcWfJey8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=bvNQyhix; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=TVaBAxDq; arc=none smtp.client-ip=88.97.38.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1714489595; bh=P1Yb9UHx7qGFrtffHgDWXFAhgYxkjfHOuo9CX+hCpI4=;
	h=From:To:Cc:Subject:Date:From;
	b=bvNQyhixOJxDveSCSESDcnJXpADudXP+EY3U3UiW+drSxGzfBtS4WR8+qzvQalPbN
	 kRcoFsm/hGV0p4geuzGMHgmIM+Dhf/rTLHPqKzcS1TDbsdt1h+H8hjmjSlzBWAggAY
	 9sj/A+F7p/jnix7XILY9Lu9wJnCPAOYUYJ9AJMAjLOlxrpPBjY06enfBReQ8DmFAjH
	 lUvSrEfqtdE27cv70BtHWbaXZ04eAif1evWmRyhQpv792NcyTnq51a02BTxSNlVfT+
	 NaWTy2zqSgWK2ZcYOnh2wkSVw6GBiiv6eFaFl2MnZBgKVWT4KCw4l5eMQAnozJbUE2
	 A/cN7Meii3GFw==
Received: by gofer.mess.org (Postfix, from userid 501)
	id CB49C1000C2; Tue, 30 Apr 2024 16:06:35 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1714489594; bh=P1Yb9UHx7qGFrtffHgDWXFAhgYxkjfHOuo9CX+hCpI4=;
	h=From:To:Cc:Subject:Date:From;
	b=TVaBAxDqrqd1HfdhBISAYP1yj0KARVCrzP8aUHr/A1f5nFwVMpDnlzY7d3G/d7Atw
	 i0Gy0pCi18M5VkxttJbCh7Dj8BMSLv2ulBFLzjZmDhreTRjAQDqkVQt0UWitc2pB+A
	 S3z9leuhqjZ3DysXu7DqEyjj8epZJHsDbKrUfvYjEZSdyjbWZORljECXWZ6D6X/Yu+
	 qMhDlhBw7AiVF/cLd0MHARO5PD/mQstzfYBS4Bcb/zUOR8+rXtpipJ05J8GX2fy6Fb
	 N8ZC13RBU/o087Y7S/L4Brk+gOXFBNhf/tmV7oTFN6f4uSgRhzz/XZ0o5VYvGs51Jy
	 PKVs4COS55+wQ==
Received: from localhost.localdomain (bigcore.local [IPv6:2a02:8011:d000:212:bc3c:1b4a:a6fa:362f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gofer.mess.org (Postfix) with ESMTPSA id A3A1D10005B;
	Tue, 30 Apr 2024 16:06:34 +0100 (BST)
From: Sean Young <sean@mess.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] media: mceusb: No need for vendor/product ID in name
Date: Tue, 30 Apr 2024 16:06:22 +0100
Message-ID: <20240430150623.2910-1-sean@mess.org>
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
 drivers/media/rc/mceusb.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/media/rc/mceusb.c b/drivers/media/rc/mceusb.c
index c76ba24c1f55..615f48898300 100644
--- a/drivers/media/rc/mceusb.c
+++ b/drivers/media/rc/mceusb.c
@@ -494,7 +494,6 @@ struct mceusb_dev {
 	u32 carrier;
 	unsigned char tx_mask;
 
-	char name[128];
 	char phys[64];
 	enum mceusb_model_type model;
 
@@ -1591,16 +1590,10 @@ static struct rc_dev *mceusb_init_rc_dev(struct mceusb_dev *ir)
 		goto out;
 	}
 
-	snprintf(ir->name, sizeof(ir->name), "%s (%04x:%04x)",
-		 mceusb_model[ir->model].name ?
-			mceusb_model[ir->model].name :
-			"Media Center Ed. eHome Infrared Remote Transceiver",
-		 le16_to_cpu(ir->usbdev->descriptor.idVendor),
-		 le16_to_cpu(ir->usbdev->descriptor.idProduct));
-
 	usb_make_path(ir->usbdev, ir->phys, sizeof(ir->phys));
 
-	rc->device_name = ir->name;
+	rc->device_name = mceusb_model[ir->model].name ? :
+		"Media Center Ed. eHome Infrared Remote Transceiver";
 	rc->input_phys = ir->phys;
 	usb_to_input_id(ir->usbdev, &rc->input_id);
 	rc->dev.parent = dev;
-- 
2.44.0


