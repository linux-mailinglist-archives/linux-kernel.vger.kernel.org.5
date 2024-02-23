Return-Path: <linux-kernel+bounces-79172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E7E861E72
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13F751C233C1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1978D150983;
	Fri, 23 Feb 2024 21:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0l1tv5b"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3F714F99E;
	Fri, 23 Feb 2024 21:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708722177; cv=none; b=WQmKl6QAitV1aUolPnRsMSUoAAbIcdH5+PsevGKSGVGd3XTmbglK0ktjuNbQOlJGf3kRSiX4UwHWNMQlRdkqVXbBsWLkAhCV+2hJOBkqiacBJbXUhaK0WO2h0qpiiOkal076TwioMeiqtQhP0050NiiwwUNYuFdgcMkyLwwdpa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708722177; c=relaxed/simple;
	bh=wqknE9u4+0m61qZz7WSBRU/y1adl1GpWbvzVjWqRpQs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R+uFE5njIAdNINaKhDHZglK+bvDyfG/+bXIauPVJ8ER8eifXDdzA0BQaNVo0Pbbte5sPj6xGv6XUP4bLj0vIE/cbiNI/flgodlrAUHiDFVuWsJNzsMEi2Fpx754IB7/9vqnDLW3YEI9glcLWhTFy/RgxzEnIHtelmurs0yh3mE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c0l1tv5b; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-564e4df00f3so1563852a12.3;
        Fri, 23 Feb 2024 13:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708722173; x=1709326973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nFS2hcwK9/ZRU15faSWV/LrndwlGzgKuFOE0N4Cou2w=;
        b=c0l1tv5bp6t0Mlqw6p2pCwUVvnCvmZAhdpDM3SAc0/EHlGac/1GOOEpVgZevB1JCke
         oadC0TY1zhV19uq2/bXLeNdmHuO3W+32RygkzaZtIyzLbhSKHhPujz8K+9PbeVLaKSFE
         jpquO3ijaysec/dJb0SKR4TsQ6rzCEPSE0Uing/gtNMlo6RRj5lEDjE4hlnDMFw1/gmy
         JEoXRSvZaj1azb9i/hhqzqh90B/eVYgguVuKDPNkJd1c4gh7sE0aRpnO8tIa7HlN/+Ft
         wdXFTltT+Li9c6S7uNMlGyGaZ6OA7egDcCRLJ4NSjJ7x40kpWNkplcy9ngw+EVWObku7
         DxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708722173; x=1709326973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nFS2hcwK9/ZRU15faSWV/LrndwlGzgKuFOE0N4Cou2w=;
        b=onfer8bLbFpIlZzajkZYbPiZ6WalFeMBrWNJDz7n76WfVtvgU/+8zqLYKCVcn+MoZF
         JQse+BnaL+ftTwPDWmIJKYQq9jcqepFDbF56EDerg+i3VIXr2uzBaJpwJ3HSzRulYKZT
         CRPDCLol/HhPMniv6mXPyZz48u/iZjbOnoVMoqyxX4wqhzXSTOdgMzclqXeO/V4uUA9b
         /QIdNlZYOqIhfNlglrG5hwUBU7+lF2X6LOoTfbU//t8efuYIxvJLQF88A1SKjTtopfqy
         oLhv0GjsZ9D+5z9bKhrUqjNgeGyIWdqlTlZgLMRWbaTnqNXsyp0D/bdmUE3bimwjQdXQ
         zttA==
X-Forwarded-Encrypted: i=1; AJvYcCXxNxiFs8B13lfbboBrv7jGF4HKRuyFG767uq404ssSIyiQAd5WZ1ZMGgLwhr3UTF2TG4v6V2wHhXNrcDIutE3z+hW0aFquTUAmGyBW
X-Gm-Message-State: AOJu0YyChmwwwMbUnUXsBBymisveoRQ8gkXA7fFgruTpguhqUkr0WXYs
	eHgQOZqEP+bIqflYBnmIr+ykOfUaBAOpPEv1MHb+uWhwJKRFacVnXL5762FMQ58=
X-Google-Smtp-Source: AGHT+IHMhYGIk6DrqgXSN3qd7Sh734TzrVvLXgke5AtfBUeAKqPwKkpdJeiFOE+sVDDKyd3xIX4tcg==
X-Received: by 2002:a17:906:6855:b0:a42:1347:17c0 with SMTP id a21-20020a170906685500b00a42134717c0mr376499ejs.50.1708722173289;
        Fri, 23 Feb 2024 13:02:53 -0800 (PST)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id st11-20020a170907c08b00b00a3e559aaff9sm6185424ejc.29.2024.02.23.13.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 13:02:53 -0800 (PST)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: linus.walleij@linaro.org,
	Pawel Dembicki <paweldembicki@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 13/16] net: dsa: vsc73xx: Implement the tag_8021q VLAN operations
Date: Fri, 23 Feb 2024 22:00:43 +0100
Message-Id: <20240223210049.3197486-14-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240223210049.3197486-1-paweldembicki@gmail.com>
References: <20240223210049.3197486-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch is a simple implementation of 802.1q tagging in the vsc73xx
driver. Currently, devices with DSA_TAG_PROTO_NONE are not functional.
The VSC73XX family doesn't provide any tag support for external Ethernet
ports.

The only option available is VLAN-based tagging, which requires constant
hardware VLAN filtering. While the VSC73XX family supports provider
bridging, it only supports QinQ without full implementation of 802.1AD.
This means it only allows the doubled 0x8100 TPID.

In the simple port mode, QinQ is enabled to preserve forwarding of
VLAN-tagged frames.

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
v5:
  - improve commit message
v4:
  - adjust tag8021q implementation for changed untagged vlan storage
  - minor fixes
v3:
  - Split tagger and tag implementation into separate commits

 drivers/net/dsa/Kconfig                |  2 +-
 drivers/net/dsa/vitesse-vsc73xx-core.c | 39 ++++++++++++++++++++++++--
 2 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
index 3092b391031a..22a04636d09e 100644
--- a/drivers/net/dsa/Kconfig
+++ b/drivers/net/dsa/Kconfig
@@ -126,7 +126,7 @@ config NET_DSA_SMSC_LAN9303_MDIO
 
 config NET_DSA_VITESSE_VSC73XX
 	tristate
-	select NET_DSA_TAG_NONE
+	select NET_DSA_TAG_VSC73XX_8021Q
 	select FIXED_PHY
 	select VITESSE_PHY
 	select GPIOLIB
diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index 87ad8b78f141..1132a86538a3 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -592,7 +592,7 @@ static enum dsa_tag_protocol vsc73xx_get_tag_protocol(struct dsa_switch *ds,
 	 * cannot access the tag. (See "Internal frame header" section
 	 * 3.9.1 in the manual.)
 	 */
-	return DSA_TAG_PROTO_NONE;
+	return DSA_TAG_PROTO_VSC73XX_8021Q;
 }
 
 static int vsc73xx_wait_for_vlan_table_cmd(struct vsc73xx *vsc)
@@ -683,7 +683,7 @@ vsc73xx_update_vlan_table(struct vsc73xx *vsc, int port, u16 vid, bool set)
 static int vsc73xx_setup(struct dsa_switch *ds)
 {
 	struct vsc73xx *vsc = ds->priv;
-	int i;
+	int i, ret;
 
 	dev_info(vsc->dev, "set up the switch\n");
 
@@ -752,6 +752,12 @@ static int vsc73xx_setup(struct dsa_switch *ds)
 
 	mdelay(50);
 
+	rtnl_lock();
+	ret = dsa_tag_8021q_register(ds, htons(ETH_P_8021Q));
+	rtnl_unlock();
+	if (ret)
+		return ret;
+
 	/* Release reset from the internal PHYs */
 	vsc73xx_write(vsc, VSC73XX_BLOCK_SYSTEM, 0, VSC73XX_GLORESET,
 		      VSC73XX_GLORESET_PHY_RESET);
@@ -1554,6 +1560,33 @@ static int vsc73xx_port_vlan_del(struct dsa_switch *ds, int port,
 	return 0;
 }
 
+static int vsc73xx_tag_8021q_vlan_add(struct dsa_switch *ds, int port, u16 vid,
+				      u16 flags)
+{
+	bool untagged = flags & BRIDGE_VLAN_INFO_UNTAGGED;
+	bool pvid = flags & BRIDGE_VLAN_INFO_PVID;
+	struct vsc73xx *vsc = ds->priv;
+	bool operate_on_storage;
+
+	operate_on_storage = !vsc73xx_tag_8021q_active(dsa_to_port(ds, port));
+
+	if (untagged)
+		vsc73xx_vlan_change_untagged(vsc, port, vid, true,
+					     operate_on_storage);
+	if (pvid)
+		vsc73xx_vlan_change_pvid(vsc, port, vid, true,
+					 operate_on_storage);
+
+	return vsc73xx_update_vlan_table(vsc, port, vid, true);
+}
+
+static int vsc73xx_tag_8021q_vlan_del(struct dsa_switch *ds, int port, u16 vid)
+{
+	struct vsc73xx *vsc = ds->priv;
+
+	return vsc73xx_update_vlan_table(vsc, port, vid, false);
+}
+
 static int vsc73xx_port_setup(struct dsa_switch *ds, int port)
 {
 	struct vsc73xx *vsc = ds->priv;
@@ -1695,6 +1728,8 @@ static const struct dsa_switch_ops vsc73xx_ds_ops = {
 	.port_vlan_add = vsc73xx_port_vlan_add,
 	.port_vlan_del = vsc73xx_port_vlan_del,
 	.phylink_get_caps = vsc73xx_phylink_get_caps,
+	.tag_8021q_vlan_add = vsc73xx_tag_8021q_vlan_add,
+	.tag_8021q_vlan_del = vsc73xx_tag_8021q_vlan_del,
 };
 
 static int vsc73xx_gpio_get(struct gpio_chip *chip, unsigned int offset)
-- 
2.34.1


