Return-Path: <linux-kernel+bounces-63600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5CE85320E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E93501F22C0B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451A95645E;
	Tue, 13 Feb 2024 13:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lm8ofKR8"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D930655E72;
	Tue, 13 Feb 2024 13:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707831378; cv=none; b=W/afvOOPro2NkPLZx+WyQ/vb+AB+JZMtTBlJCUl9nUO5BV8BF7pfuEenkTwjiayAuTec8jpEmZAgTZ0jBPwuVYeEteUNbNU8VI303qFc9YMJIjl8y4ETe1Dk7nsvFJ+JVmFaVPANJH7cEnDgSOTEmwXai+Sux+eVgsEYVFWQ41A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707831378; c=relaxed/simple;
	bh=N7AhYS5taaTtOuBRIyerdZXvQWosZFwf8q7uYgacElI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=RHrKgT9mQX4roGXYG3VHW7aYyRvvg7K4RAAjS29m93eSDblupvGvlR3V7k3tbSkJtyarZxOJM1U8EMAgL3iztX5sltY24mL9D7MIYAWNxYvj97Sk+mnsm2p6GQB2USUgOonzRPnMCesR2n24zslRrNuf1FZ6ZXHYiOJJtrJCCm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lm8ofKR8; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33cda3dfa06so348933f8f.3;
        Tue, 13 Feb 2024 05:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707831375; x=1708436175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=bZoOHtmLd6o0i6RGJTyIj/F81E7ZeV30E7USouHRFOA=;
        b=Lm8ofKR8DCghOjYzKxn32thFCum9tURmnkRa/CrS54a49BUmaM+s3JpsccknXwYThU
         qj3XQt4cPqLJlAJ7oZ4Ribhyf7FoWCAR1ox4PrqHUEuiIhxvzL9RcwNG7g57VmcgDX8N
         P9hPn4ACa1q0aI9Z6MKGl59DjUZmktriK7RjlDURG27BFFHQj9RWncMmAJcYnF40w5tQ
         uDrJ+tWFQ7tui596G3/YnDkKK1CF7s4Vb8ZH0vljJRFkUdWvcIQnJmh1BZFrKEvthiTb
         00Tvt9D2mUoDDVe77fUqJJCqGxz0nEeGJafS7xCuqEw0SIw1yelUfRWY+gGKb6b+ruVI
         TUQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707831375; x=1708436175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bZoOHtmLd6o0i6RGJTyIj/F81E7ZeV30E7USouHRFOA=;
        b=rk1fic2PJ7t1cSpYNNPp9VmcE/OqqUHLzw2anMocIIm3wHAlu2dXdCRt/v9ONF5St2
         bhLI/8+uVXmtV83DyNZ+QDOUlM1kBNJeMXRM1ghFH/iZVMramuiCBpLEWQxATwtrFXyd
         XXvfyNDC3MqEOl86Gl8s5fUFzC5F67t92A0n7pAdq14iBTh/OzeyWLWgF9QZuLeHTaJU
         xW1r9SFpg1etnGk1/xHdmyRUTfWJOyCren5ILVsHAhwANFl1n2UDlfMxs+R6Jf9iCuQS
         MqvyDvgUU9vGxD01vuQS7e8gwr8W4VDRwmHsL3xQpHd4O13C+fGThJf49yqo8/EBw3O8
         EGhw==
X-Forwarded-Encrypted: i=1; AJvYcCXK/NtmtuQdVGec6vKy4oftMqEJG1RKMd60UqgdAmEwPQHN3lfyLxDCMlkl4H3DM+yOIaillW9wiJDQl0e0dtzchbbZEibvLzfy2jhr+mBWEbsJua9Ju51/3cx/wC+CRAfi9R5j
X-Gm-Message-State: AOJu0YxKe9V0jMId1WCuWmEuQuuBhUTBRrHcnWtYEsZvLOtu+xoYYqe8
	Cq1NBYlCu2hPD3roaToXnib21ppc4pi/hoHc9v4gmSyZZa2Lsw8k
X-Google-Smtp-Source: AGHT+IEbI8thEeTyTjfM7ZsCH6ZdR/CnHnkQtyVVo5VSV/x5I987v57cuFq1da8kssS5xKs0QIuCMQ==
X-Received: by 2002:adf:f1cf:0:b0:33b:4f82:8440 with SMTP id z15-20020adff1cf000000b0033b4f828440mr7581339wro.49.1707831374843;
        Tue, 13 Feb 2024 05:36:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUIIccKV27JVuqfSL+/yDbDH9vX1qyMoUvaeAgR5AJLB3QuTQ/lMwhiVNqlYFLUTosmgyLebjSU5rFDpWkFl1fLljBJ5jCVRCKZ7plTVTphffpIGXQ/A1Csj08JXKzc0R7Mm7cFkcAM6fQprApZYDTCMWI/hjswyRoOFEjtHQXPuPZC33uTRPt5is9MQWyNRzUXKUbscp7WkbwKLEo5DWqFGDhshgABn3ZEo5IfZb75UxWDrzEsQ+jp1bwprTaZmXoHTsCj1IdPRPc5HMyTrv6YE+7QYSsYcI2zvYUEZFTWzqtbNQoiAQoVxmDEv25J72NJfuAOUnYTG0Ne0Io311fnJHxwLloRuPN6BNdiPbdnEn5vzFrtA0DgeguVmhW/s3TbiliNlXE=
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id cl3-20020a5d5f03000000b0033b7ce8b496sm7076813wrb.108.2024.02.13.05.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 05:36:14 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Robert Marko <robimarko@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next PATCH] net: phy: aquantia: add AQR111 and AQR111B0 PHY ID
Date: Tue, 13 Feb 2024 14:35:51 +0100
Message-ID: <20240213133558.1836-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Aquantia AQR111 and AQR111B0 PHY ID. These PHY advertise 10G speed
but actually supports up to 5G speed, hence some manual fixup is needed.

The Aquantia AQR111B0 PHY is just a variant of the AQR111 with smaller
chip size.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/aquantia/aquantia_main.c | 52 ++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index 97a2fafa15ca..656ea77265a2 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -22,6 +22,8 @@
 #define PHY_ID_AQR107	0x03a1b4e0
 #define PHY_ID_AQCS109	0x03a1b5c2
 #define PHY_ID_AQR405	0x03a1b4b0
+#define PHY_ID_AQR111	0x03a1b610
+#define PHY_ID_AQR111B0	0x03a1b612
 #define PHY_ID_AQR112	0x03a1b662
 #define PHY_ID_AQR412	0x03a1b712
 #define PHY_ID_AQR113C	0x31c31c12
@@ -746,6 +748,16 @@ static int aqr107_probe(struct phy_device *phydev)
 	return aqr_hwmon_probe(phydev);
 }
 
+static int aqr111_config_init(struct phy_device *phydev)
+{
+	/* AQR111 reports supporting speed up to 10G,
+	 * however only speeds up to 5G are supported.
+	 */
+	phy_set_max_speed(phydev, SPEED_5000);
+
+	return aqr107_config_init(phydev);
+}
+
 static struct phy_driver aqr_driver[] = {
 {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQ1202),
@@ -819,6 +831,44 @@ static struct phy_driver aqr_driver[] = {
 	.get_stats	= aqr107_get_stats,
 	.link_change_notify = aqr107_link_change_notify,
 },
+{
+	PHY_ID_MATCH_MODEL(PHY_ID_AQR111),
+	.name		= "Aquantia AQR111",
+	.probe		= aqr107_probe,
+	.get_rate_matching = aqr107_get_rate_matching,
+	.config_init	= aqr111_config_init,
+	.config_aneg    = aqr_config_aneg,
+	.config_intr	= aqr_config_intr,
+	.handle_interrupt = aqr_handle_interrupt,
+	.read_status	= aqr107_read_status,
+	.get_tunable    = aqr107_get_tunable,
+	.set_tunable    = aqr107_set_tunable,
+	.suspend	= aqr107_suspend,
+	.resume		= aqr107_resume,
+	.get_sset_count	= aqr107_get_sset_count,
+	.get_strings	= aqr107_get_strings,
+	.get_stats	= aqr107_get_stats,
+	.link_change_notify = aqr107_link_change_notify,
+},
+{
+	PHY_ID_MATCH_MODEL(PHY_ID_AQR111B0),
+	.name		= "Aquantia AQR111B0",
+	.probe		= aqr107_probe,
+	.get_rate_matching = aqr107_get_rate_matching,
+	.config_init	= aqr111_config_init,
+	.config_aneg    = aqr_config_aneg,
+	.config_intr	= aqr_config_intr,
+	.handle_interrupt = aqr_handle_interrupt,
+	.read_status	= aqr107_read_status,
+	.get_tunable    = aqr107_get_tunable,
+	.set_tunable    = aqr107_set_tunable,
+	.suspend	= aqr107_suspend,
+	.resume		= aqr107_resume,
+	.get_sset_count	= aqr107_get_sset_count,
+	.get_strings	= aqr107_get_strings,
+	.get_stats	= aqr107_get_stats,
+	.link_change_notify = aqr107_link_change_notify,
+},
 {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQR405),
 	.name		= "Aquantia AQR405",
@@ -894,6 +944,8 @@ static struct mdio_device_id __maybe_unused aqr_tbl[] = {
 	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR107) },
 	{ PHY_ID_MATCH_MODEL(PHY_ID_AQCS109) },
 	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR405) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR111) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR111B0) },
 	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR112) },
 	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR412) },
 	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR113C) },
-- 
2.43.0


