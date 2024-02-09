Return-Path: <linux-kernel+bounces-59013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 239BB84EFD0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 06:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CE49B281EC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 05:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D0959B4E;
	Fri,  9 Feb 2024 05:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRerSew7"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A835E59B4F;
	Fri,  9 Feb 2024 05:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707455103; cv=none; b=fBpI+4sbYYRuvvrMMp3jKX5OXcbfdilydFurjHv7tXq5c2HmxXRHhZz7hXTGiNR217E9thgVw3z6vkLPTZghYpKXkELeqOfWi+TuSmAg0jyXI966BFZfic1EZdi/2X3S3ESbdrsUk/aXuaQWQaWGza3jZTEVGY42J+du5R3m1h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707455103; c=relaxed/simple;
	bh=M7tyFdeNP+I/FIJPD2qDtWuHiq0EsHeuC0IL9G2yMh0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y3yPFssEyosngVS5k34/vIYnhYkTIc1UXJforaiw3JZUd1p3ZmYwxfu/5sUPBIN0/QEu/Uf53w8yESh/fK9mxejqX3xOIOx7dQBzFjL3ba1hJg9fYXFD70xrJ16MddHVO4JLlmyZ0aS4PRhIuydm7QOsaVCksUQUKnSNX7h1HIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZRerSew7; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3be61772d9aso241473b6e.3;
        Thu, 08 Feb 2024 21:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707455101; x=1708059901; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SDHXEFZTikwmhTjEOcrYXugCCX9uf2Y9+WgX2fGJ5fM=;
        b=ZRerSew7++2x9QlAgcNRq8in/JPCg5LJOMi0w/jcIxuhq7z6FMg7n5mZcIJBu0bULU
         lpsADMUCRfh2ixxNTHelIPAtrYpueDR69XvitL10IGKKnEc0MiKs43rt+SXfDWx2oTIE
         lgxmt/FvptpqfgN1GGZneUpOPINQp1Sm9RRpE48/696tW0DaQubJPELa1bZh5789rzz3
         9T0WOkZHR+VG4kryayUcMRU10RRhBQ9N2T6PbNpa1jwZk7d+6f/HkCACR8LcDuoJJJ4M
         t6xoAGMP1V+D3kmwIp842GYv7QUJG4i0fEg/ydM1zmeSZnu8CHuEDvBac9HxmwvuV+HV
         u5CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707455101; x=1708059901;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SDHXEFZTikwmhTjEOcrYXugCCX9uf2Y9+WgX2fGJ5fM=;
        b=M2Nk/JjQK6hWa8obdODD2fgF/XFAPqFQ7dBv5jpBQSsZ4wSTSI6mmZwsezfw3FOOr4
         lUqR0OMJP7aXb6T6D3WrgbA1/rkqoh/pNkI7LlKe7TUEUpgjzgtiMTfBhKAQT5M8TMK+
         9Esqy6zzlAXXVKzmZID04ybwOzypoAQsQPAEHdEhBuEcb1+gzRU3Ul/05NxxOtgu5oeU
         pcbVxAjekuoB0rKDqha+p44vwyob1cIGztbNG5FjmHx8TkwLonD7tssLJxkTs3P5wt48
         4uimZAw6BtIXkMj773WBtl5nG24jV/uN/K5ty5LUTEG/vFcyaupncq9M795VS9FCRv7b
         1QZA==
X-Gm-Message-State: AOJu0Ywnyi2USWoi756GS3dfCLtJ3aBdpK60ynOXf4huATFhz6vfRHX5
	tLtDwMSPVMvtuUdlKxyP//HfkKNg7rN4O2NyylkAZDMfpJcQbSfU
X-Google-Smtp-Source: AGHT+IF42MKFt7Yf+r4wiMdU0A49tcIRWR3vmpwx7CJFgNUIGi54cLjxaFrK9X6y1MrwY0Rd6uRZNw==
X-Received: by 2002:a05:6358:63a3:b0:176:40fb:cf3a with SMTP id k35-20020a05635863a300b0017640fbcf3amr416821rwh.14.1707455100607;
        Thu, 08 Feb 2024 21:05:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWihVBS7XcTeXmlU9rvmESkZkdvtCSiV0nw5marxBf4aT8zTFoVMPTeE08n4n+m001X5cQQvvJvF8vHyyyyhZb5lQOpUdetw1ADe22AI8FZ8jRgnLyYjO0jzu/pFOjXmZNGv48/ZN/vRs6w+MSr1mpvjiFDMpioHB60c2h3xZKV+PfufVang8c+4/r/Ppe/RQHt0WHbLaeahkzX91xQvd9LPp/VhRtDlHEdc30anySrzSOWkzmCMt5JTiErWhU/sGDQhoh4kWDN8fsQL/F/WZmgXzRtUXpBrMyeY57Ho0uH3pKnd1k7Hpzy7n6NoPGyykWwTFNh3t4z2TxmyWRWAym3oYlR8Mp2+9ncv9Jj7xv9ib6ecak=
Received: from tresc054937.tre-sc.gov.br ([2804:3b0:4104:200:2be:43ff:febc:c2fb])
        by smtp.gmail.com with ESMTPSA id d1-20020a634f01000000b005cda7a1d72dsm793616pgb.74.2024.02.08.21.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 21:04:59 -0800 (PST)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Fri, 09 Feb 2024 02:03:46 -0300
Subject: [PATCH net-next v6 10/11] net: dsa: realtek: use the same mii bus
 driver for both interfaces
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240209-realtek_reverse-v6-10-0662f8cbc7b5@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9959; i=luizluca@gmail.com;
 h=from:subject:message-id; bh=M7tyFdeNP+I/FIJPD2qDtWuHiq0EsHeuC0IL9G2yMh0=;
 b=owEBbQGS/pANAwAIAbsR27rRBztWAcsmYgBlxbJMjzq0uQmWyt8tZZPhBrnuIICvjI32pWo4z
 vS/JgGFePiJATMEAAEIAB0WIQQRByhHhc1bOhL6L/i7Edu60Qc7VgUCZcWyTAAKCRC7Edu60Qc7
 Vj9hB/4uFxPhmqzchHSPq7jIWj48SrRURhjbstYj2iAVwsIfbtFT+e7Fz63wjKYuHZZKNEMqgSs
 EaKpAfrFfblY+xLihebrVBFhR2JUmaGROpHk0WvT0vbl9JlSfbvTsR8QBmFeaYGDX3hYk4ogJ0u
 b4ClP2sAiDJqZgpVtWvLU8YKcnsnFaeVAO8K1l5vW6JGao31puCO06XIahc4vfBq8Ck/+3HYX4g
 dt5qZu9o6JKZRm9m3MUTcBriY5ML15cQLzMCfAXPfaYU0Q5gUzRunNsN8zi8rK/xkuK+tTryuWo
 fLn8Hidx0ygy1u5uD2DJqfPYIiX7zNbjgvgxd5mNlqhhGePP
X-Developer-Key: i=luizluca@gmail.com; a=openpgp;
 fpr=1107284785CD5B3A12FA2FF8BB11DBBAD1073B56

The realtek-mdio will now use this driver instead of the generic DSA
driver ("dsa user smi"), which should not be used with OF[1].

With a single ds_ops for both interfaces, the ds_ops in realtek_priv is
no longer necessary. Now, the realtek_variant.ds_ops can be used
directly.

The realtek_priv.setup_interface() has been removed as we can directly
call the new common function.

[1] https://lkml.kernel.org/netdev/20220630200423.tieprdu5fpabflj7@bang-olufsen.dk/T/

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
---
 drivers/net/dsa/realtek/realtek-mdio.c |  1 -
 drivers/net/dsa/realtek/realtek-smi.c  |  2 --
 drivers/net/dsa/realtek/realtek.h      |  5 +---
 drivers/net/dsa/realtek/rtl8365mb.c    | 49 ++++----------------------------
 drivers/net/dsa/realtek/rtl8366rb.c    | 52 ++++------------------------------
 drivers/net/dsa/realtek/rtl83xx.c      |  2 +-
 6 files changed, 14 insertions(+), 97 deletions(-)

diff --git a/drivers/net/dsa/realtek/realtek-mdio.c b/drivers/net/dsa/realtek/realtek-mdio.c
index 04c65452da0d..04b758e5a680 100644
--- a/drivers/net/dsa/realtek/realtek-mdio.c
+++ b/drivers/net/dsa/realtek/realtek-mdio.c
@@ -131,7 +131,6 @@ int realtek_mdio_probe(struct mdio_device *mdiodev)
 	priv->bus = mdiodev->bus;
 	priv->mdio_addr = mdiodev->addr;
 	priv->write_reg_noack = realtek_mdio_write;
-	priv->ds_ops = priv->variant->ds_ops_mdio;
 
 	ret = rtl83xx_register_switch(priv);
 	if (ret) {
diff --git a/drivers/net/dsa/realtek/realtek-smi.c b/drivers/net/dsa/realtek/realtek-smi.c
index bf02276b74d0..88590ae95a75 100644
--- a/drivers/net/dsa/realtek/realtek-smi.c
+++ b/drivers/net/dsa/realtek/realtek-smi.c
@@ -352,8 +352,6 @@ int realtek_smi_probe(struct platform_device *pdev)
 	}
 
 	priv->write_reg_noack = realtek_smi_write_reg_noack;
-	priv->setup_interface = rtl83xx_setup_user_mdio;
-	priv->ds_ops = priv->variant->ds_ops_smi;
 
 	ret = rtl83xx_register_switch(priv);
 	if (ret) {
diff --git a/drivers/net/dsa/realtek/realtek.h b/drivers/net/dsa/realtek/realtek.h
index e9e28b189509..864bb9a88f14 100644
--- a/drivers/net/dsa/realtek/realtek.h
+++ b/drivers/net/dsa/realtek/realtek.h
@@ -62,7 +62,6 @@ struct realtek_priv {
 
 	spinlock_t		lock; /* Locks around command writes */
 	struct dsa_switch	*ds;
-	const struct dsa_switch_ops *ds_ops;
 	struct irq_domain	*irqdomain;
 	bool			leds_disabled;
 
@@ -73,7 +72,6 @@ struct realtek_priv {
 	struct rtl8366_mib_counter *mib_counters;
 
 	const struct realtek_ops *ops;
-	int			(*setup_interface)(struct dsa_switch *ds);
 	int			(*write_reg_noack)(void *ctx, u32 addr, u32 data);
 
 	int			vlan_enabled;
@@ -115,8 +113,7 @@ struct realtek_ops {
 };
 
 struct realtek_variant {
-	const struct dsa_switch_ops *ds_ops_smi;
-	const struct dsa_switch_ops *ds_ops_mdio;
+	const struct dsa_switch_ops *ds_ops;
 	const struct realtek_ops *ops;
 	unsigned int clk_delay;
 	u8 cmd_read;
diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
index 60f826a5a00a..778a962727ab 100644
--- a/drivers/net/dsa/realtek/rtl8365mb.c
+++ b/drivers/net/dsa/realtek/rtl8365mb.c
@@ -828,17 +828,6 @@ static int rtl8365mb_phy_write(struct realtek_priv *priv, int phy, int regnum,
 	return 0;
 }
 
-static int rtl8365mb_dsa_phy_read(struct dsa_switch *ds, int phy, int regnum)
-{
-	return rtl8365mb_phy_read(ds->priv, phy, regnum);
-}
-
-static int rtl8365mb_dsa_phy_write(struct dsa_switch *ds, int phy, int regnum,
-				   u16 val)
-{
-	return rtl8365mb_phy_write(ds->priv, phy, regnum, val);
-}
-
 static const struct rtl8365mb_extint *
 rtl8365mb_get_port_extint(struct realtek_priv *priv, int port)
 {
@@ -2017,12 +2006,10 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
 	if (ret)
 		goto out_teardown_irq;
 
-	if (priv->setup_interface) {
-		ret = priv->setup_interface(ds);
-		if (ret) {
-			dev_err(priv->dev, "could not set up MDIO bus\n");
-			goto out_teardown_irq;
-		}
+	ret = rtl83xx_setup_user_mdio(ds);
+	if (ret) {
+		dev_err(priv->dev, "could not set up MDIO bus\n");
+		goto out_teardown_irq;
 	}
 
 	/* Start statistics counter polling */
@@ -2116,28 +2103,7 @@ static int rtl8365mb_detect(struct realtek_priv *priv)
 	return 0;
 }
 
-static const struct dsa_switch_ops rtl8365mb_switch_ops_smi = {
-	.get_tag_protocol = rtl8365mb_get_tag_protocol,
-	.change_tag_protocol = rtl8365mb_change_tag_protocol,
-	.setup = rtl8365mb_setup,
-	.teardown = rtl8365mb_teardown,
-	.phylink_get_caps = rtl8365mb_phylink_get_caps,
-	.phylink_mac_config = rtl8365mb_phylink_mac_config,
-	.phylink_mac_link_down = rtl8365mb_phylink_mac_link_down,
-	.phylink_mac_link_up = rtl8365mb_phylink_mac_link_up,
-	.port_stp_state_set = rtl8365mb_port_stp_state_set,
-	.get_strings = rtl8365mb_get_strings,
-	.get_ethtool_stats = rtl8365mb_get_ethtool_stats,
-	.get_sset_count = rtl8365mb_get_sset_count,
-	.get_eth_phy_stats = rtl8365mb_get_phy_stats,
-	.get_eth_mac_stats = rtl8365mb_get_mac_stats,
-	.get_eth_ctrl_stats = rtl8365mb_get_ctrl_stats,
-	.get_stats64 = rtl8365mb_get_stats64,
-	.port_change_mtu = rtl8365mb_port_change_mtu,
-	.port_max_mtu = rtl8365mb_port_max_mtu,
-};
-
-static const struct dsa_switch_ops rtl8365mb_switch_ops_mdio = {
+static const struct dsa_switch_ops rtl8365mb_switch_ops = {
 	.get_tag_protocol = rtl8365mb_get_tag_protocol,
 	.change_tag_protocol = rtl8365mb_change_tag_protocol,
 	.setup = rtl8365mb_setup,
@@ -2146,8 +2112,6 @@ static const struct dsa_switch_ops rtl8365mb_switch_ops_mdio = {
 	.phylink_mac_config = rtl8365mb_phylink_mac_config,
 	.phylink_mac_link_down = rtl8365mb_phylink_mac_link_down,
 	.phylink_mac_link_up = rtl8365mb_phylink_mac_link_up,
-	.phy_read = rtl8365mb_dsa_phy_read,
-	.phy_write = rtl8365mb_dsa_phy_write,
 	.port_stp_state_set = rtl8365mb_port_stp_state_set,
 	.get_strings = rtl8365mb_get_strings,
 	.get_ethtool_stats = rtl8365mb_get_ethtool_stats,
@@ -2167,8 +2131,7 @@ static const struct realtek_ops rtl8365mb_ops = {
 };
 
 const struct realtek_variant rtl8365mb_variant = {
-	.ds_ops_smi = &rtl8365mb_switch_ops_smi,
-	.ds_ops_mdio = &rtl8365mb_switch_ops_mdio,
+	.ds_ops = &rtl8365mb_switch_ops,
 	.ops = &rtl8365mb_ops,
 	.clk_delay = 10,
 	.cmd_read = 0xb9,
diff --git a/drivers/net/dsa/realtek/rtl8366rb.c b/drivers/net/dsa/realtek/rtl8366rb.c
index a0c365325b4a..54eff9cd0c03 100644
--- a/drivers/net/dsa/realtek/rtl8366rb.c
+++ b/drivers/net/dsa/realtek/rtl8366rb.c
@@ -1033,12 +1033,10 @@ static int rtl8366rb_setup(struct dsa_switch *ds)
 	if (ret)
 		dev_info(priv->dev, "no interrupt support\n");
 
-	if (priv->setup_interface) {
-		ret = priv->setup_interface(ds);
-		if (ret) {
-			dev_err(priv->dev, "could not set up MDIO bus\n");
-			return -ENODEV;
-		}
+	ret = rtl83xx_setup_user_mdio(ds);
+	if (ret) {
+		dev_err(priv->dev, "could not set up MDIO bus\n");
+		return -ENODEV;
 	}
 
 	return 0;
@@ -1785,17 +1783,6 @@ static int rtl8366rb_phy_write(struct realtek_priv *priv, int phy, int regnum,
 	return ret;
 }
 
-static int rtl8366rb_dsa_phy_read(struct dsa_switch *ds, int phy, int regnum)
-{
-	return rtl8366rb_phy_read(ds->priv, phy, regnum);
-}
-
-static int rtl8366rb_dsa_phy_write(struct dsa_switch *ds, int phy, int regnum,
-				   u16 val)
-{
-	return rtl8366rb_phy_write(ds->priv, phy, regnum, val);
-}
-
 static int rtl8366rb_reset_chip(struct realtek_priv *priv)
 {
 	int timeout = 10;
@@ -1861,35 +1848,9 @@ static int rtl8366rb_detect(struct realtek_priv *priv)
 	return 0;
 }
 
-static const struct dsa_switch_ops rtl8366rb_switch_ops_smi = {
-	.get_tag_protocol = rtl8366_get_tag_protocol,
-	.setup = rtl8366rb_setup,
-	.phylink_get_caps = rtl8366rb_phylink_get_caps,
-	.phylink_mac_link_up = rtl8366rb_mac_link_up,
-	.phylink_mac_link_down = rtl8366rb_mac_link_down,
-	.get_strings = rtl8366_get_strings,
-	.get_ethtool_stats = rtl8366_get_ethtool_stats,
-	.get_sset_count = rtl8366_get_sset_count,
-	.port_bridge_join = rtl8366rb_port_bridge_join,
-	.port_bridge_leave = rtl8366rb_port_bridge_leave,
-	.port_vlan_filtering = rtl8366rb_vlan_filtering,
-	.port_vlan_add = rtl8366_vlan_add,
-	.port_vlan_del = rtl8366_vlan_del,
-	.port_enable = rtl8366rb_port_enable,
-	.port_disable = rtl8366rb_port_disable,
-	.port_pre_bridge_flags = rtl8366rb_port_pre_bridge_flags,
-	.port_bridge_flags = rtl8366rb_port_bridge_flags,
-	.port_stp_state_set = rtl8366rb_port_stp_state_set,
-	.port_fast_age = rtl8366rb_port_fast_age,
-	.port_change_mtu = rtl8366rb_change_mtu,
-	.port_max_mtu = rtl8366rb_max_mtu,
-};
-
-static const struct dsa_switch_ops rtl8366rb_switch_ops_mdio = {
+static const struct dsa_switch_ops rtl8366rb_switch_ops = {
 	.get_tag_protocol = rtl8366_get_tag_protocol,
 	.setup = rtl8366rb_setup,
-	.phy_read = rtl8366rb_dsa_phy_read,
-	.phy_write = rtl8366rb_dsa_phy_write,
 	.phylink_get_caps = rtl8366rb_phylink_get_caps,
 	.phylink_mac_link_up = rtl8366rb_mac_link_up,
 	.phylink_mac_link_down = rtl8366rb_mac_link_down,
@@ -1928,8 +1889,7 @@ static const struct realtek_ops rtl8366rb_ops = {
 };
 
 const struct realtek_variant rtl8366rb_variant = {
-	.ds_ops_smi = &rtl8366rb_switch_ops_smi,
-	.ds_ops_mdio = &rtl8366rb_switch_ops_mdio,
+	.ds_ops = &rtl8366rb_switch_ops,
 	.ops = &rtl8366rb_ops,
 	.clk_delay = 10,
 	.cmd_read = 0xa9,
diff --git a/drivers/net/dsa/realtek/rtl83xx.c b/drivers/net/dsa/realtek/rtl83xx.c
index ceb8418dfab7..80f2c38ae55a 100644
--- a/drivers/net/dsa/realtek/rtl83xx.c
+++ b/drivers/net/dsa/realtek/rtl83xx.c
@@ -232,7 +232,7 @@ int rtl83xx_register_switch(struct realtek_priv *priv)
 
 	ds->priv = priv;
 	ds->dev = priv->dev;
-	ds->ops = priv->ds_ops;
+	ds->ops = priv->variant->ds_ops;
 	ds->num_ports = priv->num_ports;
 	priv->ds = ds;
 

-- 
2.43.0


