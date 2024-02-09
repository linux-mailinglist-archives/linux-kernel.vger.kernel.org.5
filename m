Return-Path: <linux-kernel+bounces-59011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F4B84EFCC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 06:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB4EF2890A5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 05:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4498259158;
	Fri,  9 Feb 2024 05:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aRB762+K"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17365914D;
	Fri,  9 Feb 2024 05:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707455094; cv=none; b=tqYVrOlz0HlyKPGLQ0/miyRBQF2sV9hxeogF+2o/82XcYhsV9MvCC/58IFL8kG6FeR3hmsvEbhmbTggt2J0RszokD5JWHGrU7KpHECcFHmv2/awcp1imvfq8LBSvIWsxAUV+yKt/qJiAa97hhTx8j1pTE0eKeAWvTAh3a54lJdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707455094; c=relaxed/simple;
	bh=th2mXBWQmGcWOhbgTrZmTuITUpx8jFNlm3jTc1Fr7PQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l3IPRX/Pi0cDeU/gKW30zB8hVEi8Ad4DHv7nzmKYbpgIpVBIzY5IG7UWi7MTeJ+IIDDojrW0Dj52aA/SaZ88emrMm0gRFplAe0Uwxbov9C3r656t3Kh7EwbE5pDji3mUEXbhF0WDUnBR/8ZcfwK4aanEhqZ03jwUst8A6q1vVAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aRB762+K; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6dc36e501e1so377914a34.1;
        Thu, 08 Feb 2024 21:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707455092; x=1708059892; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OCZ0u0JMUjeWwMEidR1j+87euhJ3fNtoLBFeSNRekRY=;
        b=aRB762+KeHvX6wTYchK6PRzH885qv6Ysz7w9w/04eY2KWt+YTagkhGE3T9sFaT6Pf3
         IO9aKl3VLmyTa0PZ9NXR8PEmQUGjusQC1JW7E1f8f/sCLRprIvD1Z8J/tjmuboyqRC6t
         0hRKCc0Jo3MHH6P5W4lkj1qdU1VGa+XWwk5pv0quKAwfOsaqBe3TyGlYmtjSoz4C1qj7
         HOBABiREjLU0wuffmLkOaNpsi+nEc4F/8T9QDKvkJWbhqvoCMoVD9OjEOl27Xw8+mnTb
         Uvudn/XzkBMxk3Hf+lSnMpD2FohhID3Xfj5mwg7RTt3uTjlfv7JUQm/zSnwtb39qLXMM
         y66A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707455092; x=1708059892;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OCZ0u0JMUjeWwMEidR1j+87euhJ3fNtoLBFeSNRekRY=;
        b=AS3HAKPrs+V2QyFsbkgw/Sol6QIYSB1WGszW+qeUGHEVqtYl8BV91DVFzb5b91gSPB
         MTIZb4ilsc8h0VavHIWvzzbrrPdxDA7RfK/vWvhnbxXYEP0EY5Cfab7ZfL1qg87l2RzB
         yMWKLOO3CWRkU721ZvJuuoijTwwVFPLAFE2czEEJeD/Ld/gfNZg9epi+vzTXsrcoC0WJ
         MA5YW3IUtyz4lu1awpAcnCcVxuqdzHpkmR1J8tprlD826Ju/8na2uN6kNxpnDhyCTBci
         D1L4iFoLBOvLo9wRLEZR53hGaxzp46NxVeIdT65k0JTz/49lLTElY4Y3R0dOiAE0i9e1
         tpGQ==
X-Gm-Message-State: AOJu0Yy2pHVQIQZTYOcIsiPpCAD9wOFW/ITEchLcXTW02SjvszOxLGsj
	cuySlHW1ph3LbkIaTvvXe7rH6fLp12l0w6PUTFXdb7iWukRNhKPg
X-Google-Smtp-Source: AGHT+IGSgc4fqCZ6lwXb6LKfJjaw3u73EG4M38QkZH/VFWDL8Iz4vwawtEsll3+pKu76kianaKzNCA==
X-Received: by 2002:a9d:6282:0:b0:6e1:2e98:e5d9 with SMTP id x2-20020a9d6282000000b006e12e98e5d9mr525721otk.18.1707455092062;
        Thu, 08 Feb 2024 21:04:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU7P+7zTv3YazljIpn4scNpZrXwKb+52Y+N/I8V8Lgam1KmEm1gHxVQI0PAzbD7Y5iyyoXRfiUXxVv1E3EEMQOVkxysnmLK113xLQqeLJI5e0TjYdbggCW9sI1RFfMvXAFKBmIunlkqUnfvG7UrjH5UnnfjVDAVr8f3MeB0PJt7sVVpUXZOwqa9EQoJmloZHY3btlW0AWE97lO/HfA/wJ7uXCt0du7rzmg7DqP222ZKws+a11jxVRhItQ1qSQpj5b2lvm3uOb8EdHTHbOFhltOfAAGi3jJOuRLW3wJKcmMufli/BUKnrDfhptb54PQvBCbEe3I7nDAS+AaNACvO/pA36zT4mm+MTvQazFZfsCbBVNSM2WM=
Received: from tresc054937.tre-sc.gov.br ([2804:3b0:4104:200:2be:43ff:febc:c2fb])
        by smtp.gmail.com with ESMTPSA id d1-20020a634f01000000b005cda7a1d72dsm793616pgb.74.2024.02.08.21.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 21:04:51 -0800 (PST)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Fri, 09 Feb 2024 02:03:44 -0300
Subject: [PATCH net-next v6 08/11] net: dsa: realtek: clean user_mii_bus
 setup
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240209-realtek_reverse-v6-8-0662f8cbc7b5@gmail.com>
References: <20240209-realtek_reverse-v6-0-0662f8cbc7b5@gmail.com>
In-Reply-To: <20240209-realtek_reverse-v6-0-0662f8cbc7b5@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2768; i=luizluca@gmail.com;
 h=from:subject:message-id; bh=th2mXBWQmGcWOhbgTrZmTuITUpx8jFNlm3jTc1Fr7PQ=;
 b=owEBbQGS/pANAwAIAbsR27rRBztWAcsmYgBlxbJL2fi6aiAkCzNNWEVnjtQgEtdkBDdq9NeTe
 qCNlbDd9CuJATMEAAEIAB0WIQQRByhHhc1bOhL6L/i7Edu60Qc7VgUCZcWySwAKCRC7Edu60Qc7
 VsFrB/sHRU4RJC5Q04Uh7cKRAbSKC+DA5EFwMEwL3izidfRxZ5GaAv3E88g0iBTCk7LzIy+VAYQ
 BFnrwh3pZWSrZTjGOyw7c5bTm7bPzn9OVzUKHC4EI3s4bjC5kRNZlPlF0v0MA4HdKNE3CX787h8
 fVrPwNRrcq/q7WLbyuj5hgu5S3/OLFixUy1tQWB//Gw7NJgD9UBnCy6ayCF0U8MBva0KQOMz0af
 Q4YGKpZe0e4nY+OetoIr41xtE/LkiwMF6/pOyiPB2hnBu75E/i/njQr8uzVA6jClNn8YR0SjL3o
 RnYkT3uNLAJqZjT7o7G0eO+ExuLVtezDCvHzb/n9K3BR5/59
X-Developer-Key: i=luizluca@gmail.com; a=openpgp;
 fpr=1107284785CD5B3A12FA2FF8BB11DBBAD1073B56

Remove the line assigning dev.of_node in mdio_bus as subsequent
of_mdiobus_register will always overwrite it.

As discussed in [1], allow the DSA core to be simplified, by not
assigning ds->user_mii_bus when the MDIO bus is described in OF, as it
is unnecessary.

Since commit 3b73a7b8ec38 ("net: mdio_bus: add refcounting for fwnodes
to mdiobus"), we can put the "mdio" node just after the MDIO bus
registration.

[1] https://lkml.kernel.org/netdev/20231213120656.x46fyad6ls7sqyzv@skbuf/T/#u

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
---
 drivers/net/dsa/realtek/realtek-smi.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/net/dsa/realtek/realtek-smi.c b/drivers/net/dsa/realtek/realtek-smi.c
index 1fa8e9cb1a10..0c36b43cd7b3 100644
--- a/drivers/net/dsa/realtek/realtek-smi.c
+++ b/drivers/net/dsa/realtek/realtek-smi.c
@@ -331,7 +331,7 @@ static int realtek_smi_setup_mdio(struct dsa_switch *ds)
 {
 	struct realtek_priv *priv =  ds->priv;
 	struct device_node *mdio_np;
-	int ret;
+	int ret = 0;
 
 	mdio_np = of_get_child_by_name(priv->dev->of_node, "mdio");
 	if (!mdio_np) {
@@ -344,15 +344,14 @@ static int realtek_smi_setup_mdio(struct dsa_switch *ds)
 		ret = -ENOMEM;
 		goto err_put_node;
 	}
+
 	priv->user_mii_bus->priv = priv;
 	priv->user_mii_bus->name = "SMI user MII";
 	priv->user_mii_bus->read = realtek_smi_mdio_read;
 	priv->user_mii_bus->write = realtek_smi_mdio_write;
 	snprintf(priv->user_mii_bus->id, MII_BUS_ID_SIZE, "SMI-%d",
 		 ds->index);
-	priv->user_mii_bus->dev.of_node = mdio_np;
 	priv->user_mii_bus->parent = priv->dev;
-	ds->user_mii_bus = priv->user_mii_bus;
 
 	ret = devm_of_mdiobus_register(priv->dev, priv->user_mii_bus, mdio_np);
 	if (ret) {
@@ -361,8 +360,6 @@ static int realtek_smi_setup_mdio(struct dsa_switch *ds)
 		goto err_put_node;
 	}
 
-	return 0;
-
 err_put_node:
 	of_node_put(mdio_np);
 
@@ -428,8 +425,7 @@ EXPORT_SYMBOL_NS_GPL(realtek_smi_probe, REALTEK_DSA);
  * @pdev: platform_device to be removed.
  *
  * This function should be used as the .remove_new in a platform_driver. First
- * it unregisters the DSA switch and cleans internal data. Finally, it calls
- * the common remove function.
+ * it unregisters the DSA switch and then it calls the common remove function.
  *
  * Context: Can sleep.
  * Return: Nothing.
@@ -443,9 +439,6 @@ void realtek_smi_remove(struct platform_device *pdev)
 
 	rtl83xx_unregister_switch(priv);
 
-	if (priv->user_mii_bus)
-		of_node_put(priv->user_mii_bus->dev.of_node);
-
 	rtl83xx_remove(priv);
 }
 EXPORT_SYMBOL_NS_GPL(realtek_smi_remove, REALTEK_DSA);

-- 
2.43.0


