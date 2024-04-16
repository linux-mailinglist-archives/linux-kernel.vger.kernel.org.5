Return-Path: <linux-kernel+bounces-146756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B686E8A6A62
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69389280E5D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F7612BF21;
	Tue, 16 Apr 2024 12:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNUj3Y9T"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D0B12AACC;
	Tue, 16 Apr 2024 12:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713269439; cv=none; b=Jmjgt/VyZwlQ4MDapGlY/rBWGNKbW0u5gR6C8yKZ5nMjWG7HbuNUc5GctJrqyOaKS27LbgwpYdjb1fC15xWKBcT7pN/lvfkvwRFpQ32ETMj3g0luEaz0K/Ph1Xj7OdD1MSHaMyXj60u3THAoTn+1zB2uN10yxyOX7x61UD9KH2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713269439; c=relaxed/simple;
	bh=Np0xodRkfHCyc2ASkxWCyonOqAUzHF+7BznmT2uScWQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N3qluMBkNIQkoNPpKkof//8Sz/FtjnBMjR81aP2DjZzqNMunxx3tB9zxPQomELtTCtX+n23BBNI0gzygslFMliO5s4zTNYV8VteCzUag+s/3wOUUykE6eRCVGRjNvZfmvDufNQZV+HTL8z/xnNF+eQkw7f2Zori6N8/F5wgAiuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JNUj3Y9T; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a51a7d4466bso491686966b.2;
        Tue, 16 Apr 2024 05:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713269435; x=1713874235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EywP0ORbcwYupTHjZxnseaKIdgopmLjXc6Kh63nwRpk=;
        b=JNUj3Y9TXOQQv8ZMjEKJhMTK4/Rqv1zS0d//069auA1SJKhTlqtcp5FDN34qPJvdV1
         e3NiVVBsET+LHx8VvUjeR1+FAjc6EpkziQ5SVrLA1JMH/CeBY6JsKECGYrXqPglCeu7b
         hVfkgYY8CbWU6PacwSUbtNneX2zJmco+u1ZYTE1F43QueW+zNlRQyCJluy4WT5g/KcdK
         pW9HIPpgchqCPyhKxR2xiYBH0lkFRj6s7jhT9vHAe5gaNqrJfyMDxZTLUQH73frEOeWe
         P/jZ1RKrdqFDDe2uIHiS55ijpga5435GBjoCbVsRldPcfOshe0Mq9fKb39Go6SIMSuDh
         gCrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713269436; x=1713874236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EywP0ORbcwYupTHjZxnseaKIdgopmLjXc6Kh63nwRpk=;
        b=AOue4lpoFvoDSWpKTdbdHoq3pS1fdbbTson0cSHmdTxuxB/YlH4qrffaT6V5/k2x/l
         gYRh6XStOaj1vsKb23o4sVmAGbGCLaD+9XVXRO2cePTz/sTh93DElQnrSKREXGvlAmzN
         EyME5erjQnqLuJ7/hz2cTxnoxIoFFFQfPVxTB2RCYyb/kwJhzoQMNOVdA6taAuvkA9g0
         GmoUbyllZWzWeBrLJuOfCiWC0IsVCH+rW8RCMUmDeMrp8TkqmmPR3VK7yggi7pUgvTiC
         cq7PO8SBLpKgdmcsQlUxnSu4sNEi0W6cFHEQk1sYDF7l7bCU/1yiEyl6icRqk8qkE2CQ
         r0Ig==
X-Forwarded-Encrypted: i=1; AJvYcCVl6ldDqIvf53R2y5W+l4uHkdRT+xAXjIL714IHH9La98hBRp+T4ipWC1Xw7CkTgY5tfeCoElzhncPTZktyPoc21p/nQWsrvRxqa7Qr4JL1/wYY6lo3KPmH+bmwsRdegireh4YcedyPqw==
X-Gm-Message-State: AOJu0YzPid4OXGQbKGtq/S+91QIJ4/1A4s+ZQdxDiz+JT6w5JT/tHfvZ
	09gKpicR6SuXk1q6iLIq403TpoviaXgADkUvgROUfhh8n7VmV7iG
X-Google-Smtp-Source: AGHT+IHSL8lBWdoxil/kiJaFxgpUjKdUY4oR9IJ/STOc6VcsQt43Bj6omc0sg9tnSjrfSQCkXj4Hag==
X-Received: by 2002:a17:907:8690:b0:a55:357d:1ed4 with SMTP id qa16-20020a170907869000b00a55357d1ed4mr2809328ejc.6.1713269435516;
        Tue, 16 Apr 2024 05:10:35 -0700 (PDT)
Received: from eichest-laptop.netmodule.intranet ([77.109.188.34])
        by smtp.gmail.com with ESMTPSA id hg17-20020a170906f35100b00a469d3df3c1sm6767509ejb.96.2024.04.16.05.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 05:10:35 -0700 (PDT)
From: Stefan Eichenberger <eichest@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	lxu@maxlinear.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	michael@walle.cc
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/2] net: phy: mxl-gpy: add new device tree property to disable SGMII autoneg
Date: Tue, 16 Apr 2024 14:10:32 +0200
Message-Id: <20240416121032.52108-3-eichest@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240416121032.52108-1-eichest@gmail.com>
References: <20240416121032.52108-1-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new device tree property to disable SGMII autonegotiation and
instead use the option to match the SGMII speed to what was negotiated
on the twisted pair interface (tpi). This allows us to disable SGMII
autonegotiation on Ethernet controllers that are not compatible with
this mode.

Signed-off-by: Stefan Eichenberger <eichest@gmail.com>
---
 drivers/net/phy/mxl-gpy.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/mxl-gpy.c b/drivers/net/phy/mxl-gpy.c
index b2d36a3a96f1..4147b4c29eaf 100644
--- a/drivers/net/phy/mxl-gpy.c
+++ b/drivers/net/phy/mxl-gpy.c
@@ -114,6 +114,7 @@ struct gpy_priv {
 	 * is enabled.
 	 */
 	u64 lb_dis_to;
+	bool sgmii_match_tpi_speed;
 };
 
 static const struct {
@@ -262,8 +263,17 @@ static int gpy_mbox_read(struct phy_device *phydev, u32 addr)
 
 static int gpy_config_init(struct phy_device *phydev)
 {
+	struct gpy_priv *priv = phydev->priv;
 	int ret;
 
+	/* Disalbe SGMII Autoneg if we want to match SGMII to TPI speed */
+	if (priv->sgmii_match_tpi_speed) {
+		ret = phy_modify_mmd(phydev, MDIO_MMD_VEND1, VSPEC1_SGMII_CTRL,
+				     VSPEC1_SGMII_CTRL_ANEN, 0);
+		if (ret < 0)
+			return ret;
+	}
+
 	/* Mask all interrupts */
 	ret = phy_write(phydev, PHY_IMASK, 0);
 	if (ret)
@@ -304,6 +314,9 @@ static int gpy_probe(struct phy_device *phydev)
 	if (!device_property_present(dev, "maxlinear,use-broken-interrupts"))
 		phydev->dev_flags |= PHY_F_NO_IRQ;
 
+	priv->sgmii_match_tpi_speed =
+		device_property_present(dev, "maxlinear,sgmii-match-tpi-speed");
+
 	fw_version = phy_read(phydev, PHY_FWV);
 	if (fw_version < 0)
 		return fw_version;
@@ -516,6 +529,7 @@ static int gpy_update_mdix(struct phy_device *phydev)
 
 static int gpy_update_interface(struct phy_device *phydev)
 {
+	struct gpy_priv *priv = phydev->priv;
 	int ret;
 
 	/* Interface mode is fixed for USXGMII and integrated PHY */
@@ -529,6 +543,8 @@ static int gpy_update_interface(struct phy_device *phydev)
 	switch (phydev->speed) {
 	case SPEED_2500:
 		phydev->interface = PHY_INTERFACE_MODE_2500BASEX;
+		if (!gpy_sgmii_aneg_en(phydev))
+			break;
 		ret = phy_modify_mmd(phydev, MDIO_MMD_VEND1, VSPEC1_SGMII_CTRL,
 				     VSPEC1_SGMII_CTRL_ANEN, 0);
 		if (ret < 0) {
@@ -542,7 +558,7 @@ static int gpy_update_interface(struct phy_device *phydev)
 	case SPEED_100:
 	case SPEED_10:
 		phydev->interface = PHY_INTERFACE_MODE_SGMII;
-		if (gpy_sgmii_aneg_en(phydev))
+		if (gpy_sgmii_aneg_en(phydev) || priv->sgmii_match_tpi_speed)
 			break;
 		/* Enable and restart SGMII ANEG for 10/100/1000Mbps link speed
 		 * if ANEG is disabled (in 2500-BaseX mode).
-- 
2.40.1


