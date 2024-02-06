Return-Path: <linux-kernel+bounces-55388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A34384BC08
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CE471C2409C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D4217579;
	Tue,  6 Feb 2024 17:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5AgS47d"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19761426E;
	Tue,  6 Feb 2024 17:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707240787; cv=none; b=TEShTPO67NXizj/s9QnpycaiH0XNn88VoLxiMEm2ltoITrOYELz1ZdmqHItTnSn53BLRBVylX4ONTsAVhQ0mo/yTKc05VDJj65PZuCsXX8KzKLwvBtp//tYcF08fLRpgYwzSeRdb3nsVRBbI3V4+xsg2ENh5xUOtzKuB9oR8b8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707240787; c=relaxed/simple;
	bh=GfIE22OybaPa3DRd0WpoTsg7iaxG7t9NSj5FJLsMdVE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kOStpf7uQO0WVLdQ4tcDRXvW8hluX0jxFhrkeHf/vJb6r8WSUyDJLJrnxveVR+BJH/NaXl8pIdaLWklkqSWOWgd78ZjLyyPngVJ00ydWzBoiuKogJAnQ1TRF0QJ77LQOyFZ/fPxSiUHoUOiGURLonzzkvEsaHLAI+YT9sjyto0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V5AgS47d; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40fc52c2ae4so41420745e9.3;
        Tue, 06 Feb 2024 09:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707240784; x=1707845584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f9ktY0liDe4oFr0FI8er2FX43RIFT8krH3jH7tSCLC8=;
        b=V5AgS47dE0YQ9VIPCO84Zv+BuymMykVRfWmdmtWMBron0blIuK1QLIo/wXIOUpMmNi
         J0bHUMJSo+DCgoVKj3fG983WohpGyJ8sm2hqGutp2+7MaUbS6Crk49Yy/ZIvtZ7W68VE
         oPMQNaT0d84qNG7zc6Z0G7iDwPlRrNxzAeo0y4oicHynb5DdqZzfDAaSTRppmLn4vgak
         Kv2OYqRNbEiGM+goPXM7MVVOpkGAvY2SdF9Yle/GL3uRYkyG5T9pM2KgaKD2fINiWSGB
         HplADSrKDSlaHID499mPocNGYNkKSwE2ajfg3qWScDroHMfbgFzVapF9fiMVQquTyOiN
         XJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707240784; x=1707845584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f9ktY0liDe4oFr0FI8er2FX43RIFT8krH3jH7tSCLC8=;
        b=T/x15cw/S+O0Hs7hdmMZRuu17xekag2VUaO/U33OkZbEr0Z5OFv2Ir+I5qq+Bpg+zg
         LEYRPr+IRRzWAQ9VU2DYhza5BTKD0G4q7gw8n/omq68hoyFKLN8Uc0uBT2zkNiHoydvQ
         LPsvWICEuCRnNXd9dg7UigYMGDIS0tOtclomEuNxJMXVCOrj5t1MMJRTH04iytimKYW2
         zLtwqoHBpjJVrgf1GEh+NJoFH66bH80cdgiQruaWt77ZYGCzPuWHx0Uj49p47vkFFs3C
         TFzPdX5kzDUzpO1wqmpn3ym6+GoPKH87+uRokJzL0V+/yZMHpLPUqpAv+fh9Kw9pihOV
         dQDg==
X-Gm-Message-State: AOJu0YwxscUaB9MpCIuV84WM5JcFOM2+cQ80NvzFkO0xGm1Qqa3+/G6v
	We11HvEZPPRYXRB4ftnu2YUD1vgdGAFJ4VkYHH4kubVUo/VNyh5Z
X-Google-Smtp-Source: AGHT+IHZpmejesn7q4hyZCM4EBbl9SG/EdYcekdTtT0D5kFgV21YhwgRZ5wLMSds9vubz+BRczYx+A==
X-Received: by 2002:a05:600c:354d:b0:40f:d3da:85cf with SMTP id i13-20020a05600c354d00b0040fd3da85cfmr2754650wmq.8.1707240783927;
        Tue, 06 Feb 2024 09:33:03 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX+MB19xzCAzIriGYNzEELPb3JpNFynCloU7S3gPgqQ8tnwvzzVkYC5N1tCNw6sT/z4XoeekTXsXXcC+AIkRsvx3ubvP5OvPvkYGMn/2KRYrF5bp2NpIH2GjKfQHPIEPdKRu9Nd0dtEIpJVobSRI6kqRepGGw/9hzRxNfhWhFJ4oBxv8N3hw+zSKPWoP4RvDNNZOSKDYL4jR0ccQDC5Z++dscCcMirEA8gL7iKVon73anKMIRKe+ZzNZ8uJvoEA5aLaNvtSiwfPxreC6tqmwyASfSXsO48zNUo4U1l+xsMHCBzVx2ZImphHbb58dWIkR06I0ARWpty91iNWY2j/EMjfVI+IoTnDOY3o3XQeQDuk/MFuabp0YyqEGVLFH1H9EeSNqCKeqJBS0KKsrR92S+/bZuL2dxa3ir9JGyyzPAtsg0GpwCApXLjFwi6gSad8BE7Kup3k/Yi1EOF26UrXItq67fd8Xti4uh4DNw1f3a2Oq5gcAVCDfChcZw0sClaVTFYgR/8VEa9VBEwc7DHdxTQAnCfgPJ8+n79WKZbXVrp4KP7VLJvmWGRi/FBldorwj4YwJssFWoiaNpCHrA/9NIkt7MAJeXOf7/JD4Q4Hr8ambqv2gEy2QW96DOeeExM6aUDJkugQG/z+CMAixpMVqIY4i0Y8OQRFcSWQseN4NKUm3l2fkddRFw==
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id l14-20020a05600c4f0e00b0040fc56712e8sm2621215wmq.17.2024.02.06.09.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 09:33:02 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Robert Marko <robert.marko@sartura.hr>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: [net-next PATCH v7 06/10] net: phy: provide whether link has changed in c37_read_status
Date: Tue,  6 Feb 2024 18:31:09 +0100
Message-ID: <20240206173115.7654-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206173115.7654-1-ansuelsmth@gmail.com>
References: <20240206173115.7654-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some PHY driver might require additional regs call after
genphy_c37_read_status() is called.

Expand genphy_c37_read_status to provide a bool wheather the link has
changed or not to permit PHY driver to skip additional regs call if
nothing has changed.

Every user of genphy_c37_read_status() is updated with the new
additional bool.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/broadcom.c    |  3 ++-
 drivers/net/phy/phy_device.c  | 11 +++++++++--
 drivers/net/phy/qcom/at803x.c |  3 ++-
 include/linux/phy.h           |  2 +-
 4 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
index 312a8bb35d78..370e4ed45098 100644
--- a/drivers/net/phy/broadcom.c
+++ b/drivers/net/phy/broadcom.c
@@ -665,10 +665,11 @@ static int bcm54616s_config_aneg(struct phy_device *phydev)
 static int bcm54616s_read_status(struct phy_device *phydev)
 {
 	struct bcm54616s_phy_priv *priv = phydev->priv;
+	bool changed;
 	int err;
 
 	if (priv->mode_1000bx_en)
-		err = genphy_c37_read_status(phydev);
+		err = genphy_c37_read_status(phydev, &changed);
 	else
 		err = genphy_read_status(phydev);
 
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 9014ac3c0fc8..861b09cff3f7 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2617,12 +2617,15 @@ EXPORT_SYMBOL(genphy_read_status);
 /**
  * genphy_c37_read_status - check the link status and update current link state
  * @phydev: target phy_device struct
+ * @changed: pointer where to store if link changed
  *
  * Description: Check the link, then figure out the current state
  *   by comparing what we advertise with what the link partner
  *   advertises. This function is for Clause 37 1000Base-X mode.
+ *
+ *   If link has changed, @changed is set to true, false otherwise.
  */
-int genphy_c37_read_status(struct phy_device *phydev)
+int genphy_c37_read_status(struct phy_device *phydev, bool *changed)
 {
 	int lpa, err, old_link = phydev->link;
 
@@ -2632,9 +2635,13 @@ int genphy_c37_read_status(struct phy_device *phydev)
 		return err;
 
 	/* why bother the PHY if nothing can have changed */
-	if (phydev->autoneg == AUTONEG_ENABLE && old_link && phydev->link)
+	if (phydev->autoneg == AUTONEG_ENABLE && old_link && phydev->link) {
+		*changed = false;
 		return 0;
+	}
 
+	/* Signal link has changed */
+	*changed = true;
 	phydev->duplex = DUPLEX_UNKNOWN;
 	phydev->pause = 0;
 	phydev->asym_pause = 0;
diff --git a/drivers/net/phy/qcom/at803x.c b/drivers/net/phy/qcom/at803x.c
index 3e3ee4c1d4bc..4717c59d51d0 100644
--- a/drivers/net/phy/qcom/at803x.c
+++ b/drivers/net/phy/qcom/at803x.c
@@ -912,9 +912,10 @@ static int at8031_config_intr(struct phy_device *phydev)
 static int at8031_read_status(struct phy_device *phydev)
 {
 	struct at803x_priv *priv = phydev->priv;
+	bool changed;
 
 	if (priv->is_1000basex)
-		return genphy_c37_read_status(phydev);
+		return genphy_c37_read_status(phydev, &changed);
 
 	return at803x_read_status(phydev);
 }
diff --git a/include/linux/phy.h b/include/linux/phy.h
index f8ce8a757ed0..e9aaa0dfe675 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1876,7 +1876,7 @@ int genphy_write_mmd_unsupported(struct phy_device *phdev, int devnum,
 
 /* Clause 37 */
 int genphy_c37_config_aneg(struct phy_device *phydev);
-int genphy_c37_read_status(struct phy_device *phydev);
+int genphy_c37_read_status(struct phy_device *phydev, bool *changed);
 
 /* Clause 45 PHY */
 int genphy_c45_restart_aneg(struct phy_device *phydev);
-- 
2.43.0


