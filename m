Return-Path: <linux-kernel+bounces-45672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 033368433D7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 03:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 283CF1C2490B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 02:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A0E16439;
	Wed, 31 Jan 2024 02:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KCTTNSX5"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A98163B3;
	Wed, 31 Jan 2024 02:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706668000; cv=none; b=F4fVx8mqbmqKyjvdK+s/bUuHf8wYwgzr5xqp50gdw4+ypL/1wanSZC1CmulOOhrMsdMiuJTJy7kpSL2deUERWuJyiSO1rfrpTdwhELDcNCcZtTmFTQVFB0T1r5xvvhfuMiixzuciB+TI3yOVVFph8CE/lX0+kCDOrV0KQBnkY+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706668000; c=relaxed/simple;
	bh=OeobFr780bBe5eA+J54EIVdkiUd9gmXuzcsAf0kfdhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GhR8mVdgilVhVewP9GTiG/MikqKM71iKq4MNsBnrLREhrvcZWCZMh9ouC0/TLLBU0S9ux2IKYDC5mBL12OzRrRJOMpDe5eCwqM2rEEOAp75nhohIrYRHZ7K8LGjZNNcdCgOuM90efN5EIz87nWDgjfsqO9ZrmEK2Hvdl55LeVoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KCTTNSX5; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3394b892691so198110f8f.1;
        Tue, 30 Jan 2024 18:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706667996; x=1707272796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=coKSywo/h86OGWMRoq0sS8061xQ1pSjnMogvgE5DzXo=;
        b=KCTTNSX5lnJ2OIptN7diNcmcowj+uBQ22CpAjnnIAC79YN6gxLGg9PFb0v+Z4JFXgP
         q1ecfMUGDB4xaWiFMBybqVl/iKonu0+DKqL0SE2AsefhU7XZoeqgp8ZvYOgc4VU2hiRV
         AYKPIZJmi11VnX36TeKwLbG+hMKzEJ+rXQQ++8rkM1nbDLOX60v79jOJhcrF+qI67CW5
         oXHwTvT3H7YxmejTuaDB6vTc/GHIiA3XO/+z6OgHTJirMMNQcrK13I/J4fkof+DCSfET
         SOaZknVuZEYiuvWQzXpmrgliYKjS/rMNl3j6FP76CcHv6Ux9TsSzko+NHWcmXnmbsINb
         1oaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706667996; x=1707272796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=coKSywo/h86OGWMRoq0sS8061xQ1pSjnMogvgE5DzXo=;
        b=YxRExzDZy8aItGapt0CDq4CQ8jsBrtu2RJdeSpX+o6a8TqaX2oHu4y+kJbds9MsWUz
         qOwAJCFadLavR4n3akpE9809PGYS9soKDsqOPLClndoGrOXR6uYssHqizkBBXfF4yphO
         PrsYkQSE30dkNUURwo30BRQ2YqNkVP2mJ9l6XnRa3u24Kr6kZ9kcB55HGNDzKvgMz7Nw
         Ayw43I9mciPdNPOofMqi/4/i29HRuYMH598VThxmuBG7Oqo3m2TqY1IzXm+m74xyQJSa
         CGsqDT6KXJ1HoXNEPxBnLDUY8YvPfgiSA9ZhqMjB+DeHnCzGWFk5e/610zt4KdKHydR0
         40vg==
X-Gm-Message-State: AOJu0YyF0LWWfZbFusnNubFlmARbH/WjTL2AQAV0m8gjBXk891fjOUFn
	OPzVnyWmvTGVL0Xp/wpln40gEhV7KbYjmqSuALQZ7p/S01rzPo+n
X-Google-Smtp-Source: AGHT+IGdOPShEK1YaSwCU+UtgRE/nMJ1dy1F0FjkwcATAO87tMzzOk6LKLLQ/4qRDab1nJ8KA6XsEQ==
X-Received: by 2002:a5d:4c49:0:b0:33a:e7d4:7fb9 with SMTP id n9-20020a5d4c49000000b0033ae7d47fb9mr2895091wrt.23.1706667996404;
        Tue, 30 Jan 2024 18:26:36 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id f22-20020a7bc8d6000000b0040eea5dc778sm757722wml.1.2024.01.30.18.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 18:26:35 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Robert Marko <robert.marko@sartura.hr>,
	linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH v3 2/2] net: mdio: ipq4019: add support for clock-frequency property
Date: Wed, 31 Jan 2024 03:26:04 +0100
Message-ID: <20240131022606.1532-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131022606.1532-1-ansuelsmth@gmail.com>
References: <20240131022606.1532-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IPQ4019 MDIO internally divide the clock feed by AHB based on the
MDIO_MODE reg. On reset or power up, the default value for the
divider is 0xff that reflect the divider set to /256.

This makes the MDC run at a very low rate, that is, considering AHB is
always fixed to 100Mhz, a value of 390KHz.

This hasn't have been a problem as MDIO wasn't used for time sensitive
operation, it is now that on IPQ807x is usually mounted with PHY that
requires MDIO to load their firmware (example Aquantia PHY).

To handle this problem and permit to set the correct designed MDC
frequency for the SoC add support for the standard "clock-frequency"
property for the MDIO node.

The divider supports value from /1 to /256 and the common value are to
set it to /16 to reflect 6.25Mhz or to /8 on newer platform to reflect
12.5Mhz.

To scan if the requested rate is supported by the divider, loop with
each supported divider and stop when the requested rate match the final
rate with the current divider. An error is returned if the rate doesn't
match any value.

On MDIO reset, the divider is restored to the requested value to prevent
any kind of downclocking caused by the divider reverting to a default
value.

To follow 802.3 spec of 2.5MHz of default value, if divider is set at
/256 and "clock-frequency" is not set in DT, assume nobody set the
divider and try to find the closest MDC rate to 2.5MHz. (in the case of
AHB set to 100MHz, it's 1.5625MHz)

While at is also document other bits of the MDIO_MODE reg to have a
clear idea of what is actually applied there.

Documentation of some BITs is skipped as they are marked as reserved and
their usage is not clear (RES 11:9 GENPHY 16:13 RES1 19:17)

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/mdio/mdio-ipq4019.c | 109 ++++++++++++++++++++++++++++++--
 1 file changed, 103 insertions(+), 6 deletions(-)

diff --git a/drivers/net/mdio/mdio-ipq4019.c b/drivers/net/mdio/mdio-ipq4019.c
index abd8b508ec16..9d8f43b28aac 100644
--- a/drivers/net/mdio/mdio-ipq4019.c
+++ b/drivers/net/mdio/mdio-ipq4019.c
@@ -14,6 +14,20 @@
 #include <linux/clk.h>
 
 #define MDIO_MODE_REG				0x40
+#define   MDIO_MODE_MDC_MODE			BIT(12)
+/* 0 = Clause 22, 1 = Clause 45 */
+#define   MDIO_MODE_C45				BIT(8)
+#define   MDIO_MODE_DIV_MASK			GENMASK(7, 0)
+#define     MDIO_MODE_DIV(x)			FIELD_PREP(MDIO_MODE_DIV_MASK, (x) - 1)
+#define     MDIO_MODE_DIV_1			0x0
+#define     MDIO_MODE_DIV_2			0x1
+#define     MDIO_MODE_DIV_4			0x3
+#define     MDIO_MODE_DIV_8			0x7
+#define     MDIO_MODE_DIV_16			0xf
+#define     MDIO_MODE_DIV_32			0x1f
+#define     MDIO_MODE_DIV_64			0x3f
+#define     MDIO_MODE_DIV_128			0x7f
+#define     MDIO_MODE_DIV_256			0xff
 #define MDIO_ADDR_REG				0x44
 #define MDIO_DATA_WRITE_REG			0x48
 #define MDIO_DATA_READ_REG			0x4c
@@ -26,9 +40,6 @@
 #define MDIO_CMD_ACCESS_CODE_C45_WRITE	1
 #define MDIO_CMD_ACCESS_CODE_C45_READ	2
 
-/* 0 = Clause 22, 1 = Clause 45 */
-#define MDIO_MODE_C45				BIT(8)
-
 #define IPQ4019_MDIO_TIMEOUT	10000
 #define IPQ4019_MDIO_SLEEP		10
 
@@ -41,6 +52,7 @@ struct ipq4019_mdio_data {
 	void __iomem	*membase;
 	void __iomem *eth_ldo_rdy;
 	struct clk *mdio_clk;
+	unsigned int mdc_rate;
 };
 
 static int ipq4019_mdio_wait_busy(struct mii_bus *bus)
@@ -203,6 +215,38 @@ static int ipq4019_mdio_write_c22(struct mii_bus *bus, int mii_id, int regnum,
 	return 0;
 }
 
+static int ipq4019_mdio_set_div(struct ipq4019_mdio_data *priv)
+{
+	unsigned long ahb_rate;
+	int div;
+	u32 val;
+
+	/* If we don't have a clock for AHB use the fixed value */
+	ahb_rate = IPQ_MDIO_CLK_RATE;
+	if (priv->mdio_clk)
+		ahb_rate = clk_get_rate(priv->mdio_clk);
+
+	/* MDC rate is ahb_rate/(MDIO_MODE_DIV + 1)
+	 * While supported, internal documentation doesn't
+	 * assure correct functionality of the MDIO bus
+	 * with divider of 1, 2 or 4.
+	 */
+	for (div = 8; div <= 256; div *= 2) {
+		/* The requested rate is supported by the div */
+		if (priv->mdc_rate == DIV_ROUND_UP(ahb_rate, div)) {
+			val = readl(priv->membase + MDIO_MODE_REG);
+			val &= ~MDIO_MODE_DIV_MASK;
+			val |= MDIO_MODE_DIV(div);
+			writel(val, priv->membase + MDIO_MODE_REG);
+
+			return 0;
+		}
+	}
+
+	/* The requested rate is not supported */
+	return -EINVAL;
+}
+
 static int ipq_mdio_reset(struct mii_bus *bus)
 {
 	struct ipq4019_mdio_data *priv = bus->priv;
@@ -225,10 +269,58 @@ static int ipq_mdio_reset(struct mii_bus *bus)
 		return ret;
 
 	ret = clk_prepare_enable(priv->mdio_clk);
-	if (ret == 0)
-		mdelay(10);
+	if (ret)
+		return ret;
 
-	return ret;
+	mdelay(10);
+
+	/* Restore MDC rate */
+	return ipq4019_mdio_set_div(priv);
+}
+
+static void ipq4019_mdio_select_mdc_rate(struct platform_device *pdev,
+					 struct ipq4019_mdio_data *priv)
+{
+	unsigned long ahb_rate;
+	int div;
+	u32 val;
+
+	/* MDC rate defined in DT, we don't have to decide a default value */
+	if (!of_property_read_u32(pdev->dev.of_node, "clock-frequency",
+				  &priv->mdc_rate))
+		return;
+
+	/* If we don't have a clock for AHB use the fixed value */
+	ahb_rate = IPQ_MDIO_CLK_RATE;
+	if (priv->mdio_clk)
+		ahb_rate = clk_get_rate(priv->mdio_clk);
+
+	/* Check what is the current div set */
+	val = readl(priv->membase + MDIO_MODE_REG);
+	div = FIELD_GET(MDIO_MODE_DIV_MASK, val);
+
+	/* div is not set to the default value of /256
+	 * Probably someone changed that (bootloader, other drivers)
+	 * Keep this and don't overwrite it.
+	 */
+	if (div != MDIO_MODE_DIV_256) {
+		priv->mdc_rate = DIV_ROUND_UP(ahb_rate, div + 1);
+		return;
+	}
+
+	/* If div is /256 assume nobody have set this value and
+	 * try to find one MDC rate that is close the 802.3 spec of
+	 * 2.5MHz
+	 */
+	for (div = 256; div >= 8; div /= 2) {
+		/* Stop as soon as we found a divider that
+		 * reached the closest value to 2.5MHz
+		 */
+		if (DIV_ROUND_UP(ahb_rate, div) > 2500000)
+			break;
+
+		priv->mdc_rate = DIV_ROUND_UP(ahb_rate, div);
+	}
 }
 
 static int ipq4019_mdio_probe(struct platform_device *pdev)
@@ -252,6 +344,11 @@ static int ipq4019_mdio_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->mdio_clk))
 		return PTR_ERR(priv->mdio_clk);
 
+	ipq4019_mdio_select_mdc_rate(pdev, priv);
+	ret = ipq4019_mdio_set_div(priv);
+	if (ret)
+		return ret;
+
 	/* The platform resource is provided on the chipset IPQ5018 */
 	/* This resource is optional */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-- 
2.43.0


