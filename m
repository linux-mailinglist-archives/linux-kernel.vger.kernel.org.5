Return-Path: <linux-kernel+bounces-26155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 632CF82DC12
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C5381F22A17
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AFD17BAF;
	Mon, 15 Jan 2024 15:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OF5Itzhq"
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FAD179B5;
	Mon, 15 Jan 2024 15:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay9-d.mail.gandi.net (unknown [217.70.183.199])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id D9714C646B;
	Mon, 15 Jan 2024 14:59:20 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 905CAFF80E;
	Mon, 15 Jan 2024 14:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1705330753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f53Zp5Ie7SvA/urVLBu9knCFVK7DSFZQ8gZToRBEIg4=;
	b=OF5ItzhqFaamgBezgWVg9/B2KXGRP9tnRoLiz7gqbObeTDOch0oAdJ1BN+ou03qFQWa03k
	YGosK7D0zkB51PkdUbRgQ6tRuJFjFxurKykh5by0HzrwIVrePxv4xeGMBq0ONpz3m4sXBN
	AeY7aYS8FnHqm0HrgA2HhyZJpzO/blLF3vGgaYPef1/zXxvA9dmcJ28LeAr37QRDHNrc93
	9pF48Da9UoZ4T6Lb0hdvtzZyoBTzrlkKUIfk3QnQ0eu9or2866oFKneEsTfLboFmKCaker
	ttH58df2vTQ7QK1565WiKtrLJOZoxad1TBYuhxHSjrBfcJ495VBfq7GQCfJTUQ==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Date: Mon, 15 Jan 2024 15:56:30 +0100
Subject: [PATCH 1/5] wifi: wilc1000: set preamble size to auto as default
 in wilc_init_fw_config()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240115-wilc_1000_fixes-v1-1-54d29463a738@bootlin.com>
References: <20240115-wilc_1000_fixes-v1-0-54d29463a738@bootlin.com>
In-Reply-To: <20240115-wilc_1000_fixes-v1-0-54d29463a738@bootlin.com>
To: linux-wireless@vger.kernel.org
Cc: Ajay Singh <ajay.kathat@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Kalle Valo <kvalo@kernel.org>, 
 David Mosberger-Tang <davidm@egauge.net>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: alexis.lothore@bootlin.com

From: Ajay Singh <ajay.kathat@microchip.com>

Changed the default value preamble to WILC_FW_PREAMBLE_AUTO in
wilc_init_fw_config().

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
 drivers/net/wireless/microchip/wilc1000/netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.c b/drivers/net/wireless/microchip/wilc1000/netdev.c
index 91d71e0f7ef2..8923eb64c964 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.c
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.c
@@ -284,7 +284,7 @@ static int wilc_init_fw_config(struct net_device *dev, struct wilc_vif *vif)
 	if (!wilc_wlan_cfg_set(vif, 0, WID_11G_OPERATING_MODE, &b, 1, 0, 0))
 		goto fail;
 
-	b = WILC_FW_PREAMBLE_SHORT;
+	b = WILC_FW_PREAMBLE_AUTO;
 	if (!wilc_wlan_cfg_set(vif, 0, WID_PREAMBLE, &b, 1, 0, 0))
 		goto fail;
 

-- 
2.42.1


