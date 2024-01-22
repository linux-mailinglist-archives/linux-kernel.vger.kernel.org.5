Return-Path: <linux-kernel+bounces-34189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D724383755B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 22:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85A922887D1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BF64BABB;
	Mon, 22 Jan 2024 21:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xoufn49u"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA24D4BA90;
	Mon, 22 Jan 2024 21:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705958997; cv=none; b=j06ooZf9mYaFHiJ800Rtx1J/bmYjGND2DjlelLesodblRw61yoXZ679fFyN586XBd6QceZJVbejpz0AKs+OCSZAp+TrcAL+9jxJDI7qbqzfZFrTLVdFExgdzjrZHsZa6aUCQBckZfpPbRkrm6VifCR2/79TITuexv510K0CtPpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705958997; c=relaxed/simple;
	bh=6NyN89TqUdLjq5FhaHiyBm8u6XvAMftJ4c2iTUQwAQM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eT54n7tUhfb4sToxeVjnaOKfxVvxsVxjxPo38a/ekbSAoG0u3B1VIThTFmSOk7flLszkXONfPjn+i3hXun5NYhwXo4ci7P31tpJGZVOUMRp4BSwNVuEPif7sk0v5wu89/8nGucmzoUwdaba4Vj77fA41d3NcbZpWzT2rIn8tjwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xoufn49u; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55c2c90c67dso1779195a12.1;
        Mon, 22 Jan 2024 13:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705958994; x=1706563794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AVNEcu8/KtmvdhD8Hp68PNiLA1u+xEERK9Ta2mi0Mzs=;
        b=Xoufn49u/Jfomc4jToGHnmEUalf3uLYcS2N351LZop5sl3eqRzkMJL43OerOcNNRSp
         gWEe0X1sX5+zDzUDr45T8vS1ViTuQH9+onG04clAgkmifKyjJi+m0D07ps/S4H9Rn/TG
         VLyDNNBUtTfYeK+LfSBntiiHs8p2O0Qe+udm23xP5xQq7krsM/xBksKv9XT6f64CURiX
         IdVhFJuXOQr4fcqH4FGP8UZyC/hmC+wOjRmKlGHoYhCGrqtEZOXuoJleGsKXAmFVipSY
         JUW+wPT9jS5FP8iVCy1apjzV9bkQXaa1+SxkRT89Z2pfQwk4KZfhkQiLeFZibKAcyXRh
         RLiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705958994; x=1706563794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AVNEcu8/KtmvdhD8Hp68PNiLA1u+xEERK9Ta2mi0Mzs=;
        b=r+6QdObZYwuOYBFsm5UP60Y8pcKcBpCofq0XFbWuT8JS/lPP2A7hOmEVsOZZ3B9eWm
         lRAOq4y2T5XhYh7UvFN9qWoku3x72KJxJMZqmb9oi8KtX4dYbSM6kghW/zYrnZkJPsiV
         EAUKliyP5qixcvgGfxrRz6fJ45yoOACRxaw7xxjO+Eok5HjOQJRzT0v0MU+u3zIb7rh7
         UO6p/rc1+/QQrvT/Y38WMKWRn20CpS5RdvVqyMZLexxc0xHEt/fJfKj9/6ixLUMhIWst
         iO//49xqrR7nMWE5HPCaka8lPb6hWyfgosQ53QYoolmM/ugUXxR3NJtH55vDx4iTcrEG
         HkFw==
X-Gm-Message-State: AOJu0Yy3jC/WE91Nnyh/xHS3aVICSxu3KwkQoJxAeq8MO3Ssuybrv2Z1
	immCo4EuvzDIX03MyUmmK1aPpQOZrQIoLgCsT9NfKWKDfsS1PaSV
X-Google-Smtp-Source: AGHT+IGqt/98OCeHGlibmCviwO91HkwiR+6lZjHNTFpWrYZwvjxg2aDs6ZE3nK4O+6k/6GLclNLaFQ==
X-Received: by 2002:a17:906:d04a:b0:a2a:dba3:faac with SMTP id bo10-20020a170906d04a00b00a2adba3faacmr2165680ejb.154.1705958993919;
        Mon, 22 Jan 2024 13:29:53 -0800 (PST)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id j25-20020a1709066dd900b00a26af4d96c6sm13823336ejt.4.2024.01.22.13.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 13:29:53 -0800 (PST)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: 
Cc: Dimitri Fedrau <dima.fedrau@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Stefan Eichenberger <eichest@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: [PATCH v5 net-next 08/13] net: phy: marvell-88q2xxx: add support for temperature sensor
Date: Mon, 22 Jan 2024 22:28:41 +0100
Message-Id: <20240122212848.3645785-9-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240122212848.3645785-1-dima.fedrau@gmail.com>
References: <20240122212848.3645785-1-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Marvell 88q2xxx devices have an inbuilt temperature sensor. Add hwmon
support for this sensor.

Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 drivers/net/phy/marvell-88q2xxx.c | 152 ++++++++++++++++++++++++++++++
 1 file changed, 152 insertions(+)

diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
index 4cb8fe524795..6900bad275d0 100644
--- a/drivers/net/phy/marvell-88q2xxx.c
+++ b/drivers/net/phy/marvell-88q2xxx.c
@@ -5,6 +5,7 @@
 #include <linux/ethtool_netlink.h>
 #include <linux/marvell_phy.h>
 #include <linux/phy.h>
+#include <linux/hwmon.h>
 
 #define PHY_ID_88Q2220_REVB0	(MARVELL_PHY_ID_88Q2220 | 0x1)
 
@@ -33,6 +34,19 @@
 #define MDIO_MMD_PCS_MV_GPIO_INT_CTRL			32787
 #define MDIO_MMD_PCS_MV_GPIO_INT_CTRL_TRI_DIS		0x0800
 
+#define MDIO_MMD_PCS_MV_TEMP_SENSOR1			32833
+#define MDIO_MMD_PCS_MV_TEMP_SENSOR1_RAW_INT		0x0001
+#define MDIO_MMD_PCS_MV_TEMP_SENSOR1_INT		0x0040
+#define MDIO_MMD_PCS_MV_TEMP_SENSOR1_INT_EN		0x0080
+
+#define MDIO_MMD_PCS_MV_TEMP_SENSOR2			32834
+#define MDIO_MMD_PCS_MV_TEMP_SENSOR2_DIS_MASK		0xc000
+
+#define MDIO_MMD_PCS_MV_TEMP_SENSOR3			32835
+#define MDIO_MMD_PCS_MV_TEMP_SENSOR3_INT_THRESH_MASK	0xff00
+#define MDIO_MMD_PCS_MV_TEMP_SENSOR3_INT_THRESH_SHIFT	8
+#define MDIO_MMD_PCS_MV_TEMP_SENSOR3_MASK		0x00ff
+
 #define MDIO_MMD_PCS_MV_100BT1_STAT1			33032
 #define MDIO_MMD_PCS_MV_100BT1_STAT1_IDLE_ERROR		0x00ff
 #define MDIO_MMD_PCS_MV_100BT1_STAT1_JABBER		0x0100
@@ -488,6 +502,143 @@ static int mv88q2xxx_resume(struct phy_device *phydev)
 	return phy_clear_bits_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_CTRL1,
 				  MDIO_CTRL1_LPOWER);
 }
+#ifdef CONFIG_HWMON
+static const struct hwmon_channel_info * const mv88q2xxx_hwmon_info[] = {
+	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_ALARM),
+	NULL
+};
+
+static umode_t mv88q2xxx_hwmon_is_visible(const void *data,
+					  enum hwmon_sensor_types type,
+					  u32 attr, int channel)
+{
+	switch (attr) {
+	case hwmon_temp_input:
+		return 0444;
+	case hwmon_temp_max:
+		return 0644;
+	case hwmon_temp_alarm:
+		return 0444;
+	default:
+		return 0;
+	}
+}
+
+static int mv88q2xxx_hwmon_read(struct device *dev,
+				enum hwmon_sensor_types type,
+				u32 attr, int channel, long *val)
+{
+	struct phy_device *phydev = dev_get_drvdata(dev);
+	int ret;
+
+	switch (attr) {
+	case hwmon_temp_input:
+		ret = phy_read_mmd(phydev, MDIO_MMD_PCS,
+				   MDIO_MMD_PCS_MV_TEMP_SENSOR3);
+		if (ret < 0)
+			return ret;
+
+		*val = ((ret & MDIO_MMD_PCS_MV_TEMP_SENSOR3_MASK) - 75) * 1000;
+		return 0;
+	case hwmon_temp_max:
+		ret = phy_read_mmd(phydev, MDIO_MMD_PCS,
+				   MDIO_MMD_PCS_MV_TEMP_SENSOR3);
+		if (ret < 0)
+			return ret;
+
+		*val = (((ret & MDIO_MMD_PCS_MV_TEMP_SENSOR3_INT_THRESH_MASK) >>
+			MDIO_MMD_PCS_MV_TEMP_SENSOR3_INT_THRESH_SHIFT) - 75) *
+			1000;
+		return 0;
+	case hwmon_temp_alarm:
+		ret = phy_read_mmd(phydev, MDIO_MMD_PCS,
+				   MDIO_MMD_PCS_MV_TEMP_SENSOR1);
+		if (ret < 0)
+			return ret;
+
+		*val = !!(ret & MDIO_MMD_PCS_MV_TEMP_SENSOR1_RAW_INT);
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int mv88q2xxx_hwmon_write(struct device *dev,
+				 enum hwmon_sensor_types type, u32 attr,
+				 int channel, long val)
+{
+	struct phy_device *phydev = dev_get_drvdata(dev);
+
+	switch (attr) {
+	case hwmon_temp_max:
+		if (val < -75000 || val > 180000)
+			return -EINVAL;
+
+		val = ((val / 1000) + 75) <<
+		       MDIO_MMD_PCS_MV_TEMP_SENSOR3_INT_THRESH_SHIFT;
+		return phy_modify_mmd(phydev, MDIO_MMD_PCS,
+				      MDIO_MMD_PCS_MV_TEMP_SENSOR3,
+				      MDIO_MMD_PCS_MV_TEMP_SENSOR3_INT_THRESH_MASK,
+				      val);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static const struct hwmon_ops mv88q2xxx_hwmon_hwmon_ops = {
+	.is_visible = mv88q2xxx_hwmon_is_visible,
+	.read = mv88q2xxx_hwmon_read,
+	.write = mv88q2xxx_hwmon_write,
+};
+
+static const struct hwmon_chip_info mv88q2xxx_hwmon_chip_info = {
+	.ops = &mv88q2xxx_hwmon_hwmon_ops,
+	.info = mv88q2xxx_hwmon_info,
+};
+
+static int mv88q2xxx_hwmon_probe(struct phy_device *phydev)
+{
+	struct device *dev = &phydev->mdio.dev;
+	struct device *hwmon;
+	char *hwmon_name;
+	int ret;
+
+	/* Enable temperature sensor interrupt */
+	ret = phy_set_bits_mmd(phydev, MDIO_MMD_PCS,
+			       MDIO_MMD_PCS_MV_TEMP_SENSOR1,
+			       MDIO_MMD_PCS_MV_TEMP_SENSOR1_INT_EN);
+	if (ret < 0)
+		return ret;
+
+	/* Enable temperature sense */
+	ret = phy_modify_mmd(phydev, MDIO_MMD_PCS, MDIO_MMD_PCS_MV_TEMP_SENSOR2,
+			     MDIO_MMD_PCS_MV_TEMP_SENSOR2_DIS_MASK, 0);
+	if (ret < 0)
+		return ret;
+
+	hwmon_name = devm_hwmon_sanitize_name(dev, dev_name(dev));
+	if (IS_ERR(hwmon_name))
+		return PTR_ERR(hwmon_name);
+
+	hwmon = devm_hwmon_device_register_with_info(dev,
+						     hwmon_name,
+						     phydev,
+						     &mv88q2xxx_hwmon_chip_info,
+						     NULL);
+
+	return PTR_ERR_OR_ZERO(hwmon);
+}
+
+#else
+static int mv88q2xxx_hwmon_probe(struct phy_device *phydev)
+{
+	return 0;
+}
+#endif
+static int mv88q2xxx_probe(struct phy_device *phydev)
+{
+	return mv88q2xxx_hwmon_probe(phydev);
+}
 
 static int mv88q222x_soft_reset(struct phy_device *phydev)
 {
@@ -583,6 +734,7 @@ static struct phy_driver mv88q2xxx_driver[] = {
 	{
 		PHY_ID_MATCH_EXACT(PHY_ID_88Q2220_REVB0),
 		.name			= "mv88q2220",
+		.probe			= mv88q2xxx_probe,
 		.get_features		= mv88q2xxx_get_features,
 		.config_aneg		= mv88q222x_config_aneg,
 		.aneg_done		= genphy_c45_aneg_done,
-- 
2.39.2


