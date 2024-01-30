Return-Path: <linux-kernel+bounces-43676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFDD84178B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9170B1F21B62
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 00:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48635364AB;
	Tue, 30 Jan 2024 00:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/m/AFka"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C371E4B0;
	Tue, 30 Jan 2024 00:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706574967; cv=none; b=qvglEcdLfg5kpc4lp1WcgDSZetgRuy+60/nrFujZ9V+zDwPkxeAtjs3i6ZjhXZfbhHPztRU7DyyF8gBMF0+rxDnTKeRFfPMeEFbxLVo9kwSq67llMKBfx75sha3FAnA/rXtRJqadL+kdYck3VbqdQd3z23HTJf9pKWeovP46X/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706574967; c=relaxed/simple;
	bh=XNIJOEPWnTmJj95Bx/8HPnK1xXiD0h7JfWIOVnb2RKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UpytobkBwfttb/HYZbfVAAPvGxgsqBRkjLrxOhKYZe7DgFXz5cxIBVhATJIFBMOs+ENIrJsQd2yXNZhJ/6Zx+yndEi9g91E0WVcQ+Os0qjBVqHfOoaYg34sIm7A8iXzI4ueY9r68qCV30WWrSpBFHPFCvcKDl3d+Yc2UUJjiByU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/m/AFka; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40eb033c1b0so39522405e9.2;
        Mon, 29 Jan 2024 16:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706574963; x=1707179763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oEsPKjtltYrRbUWdMt7dkeHTeW1XxA60FHbtu1eKACU=;
        b=H/m/AFkact0OQdY6YVbE9mmVBfh90BAs0w/65Fo6bOVDjUx+IoD7L9wMzVJe2XkhQA
         V4yNbQE4XTUyXjWIjUuTeRiPGJE/oEt7E0f9NSqA4UprQPSUqRMa5AmNjRGSV3mMNmCn
         JyK1RlDSErCq25M+Z/W0sBOabjif70D0AE1TXqeb9EvOEmOF29aTQGIgvJhJgUL8YMzr
         zqipIIcCJLdYk0DvWnTRoiiqyblvMhtx0Ie7WuymL3JozYcAdd+IWjpZJY+XCFCJrEUY
         95fhl2CBxw2ALGVVIpYKjyQWoL9EI+vPC5D25jtejXk1YtVYBj3bPndZSQ41ozcPKTGU
         tvaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706574963; x=1707179763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oEsPKjtltYrRbUWdMt7dkeHTeW1XxA60FHbtu1eKACU=;
        b=ZchRM9P0MOSmRzXnZT6gRjoDe/AuyemXvZvVOaLSKV0xg+JNZTkg8DNjqWN/HnusOP
         hgwH1AEDzhZuPRI5i0xF68fP9JOVhBduRRfiF/tfYBIS41R1Bvturzhb/JKT2vivIYj0
         y1CdWzLo6twDE3vd4HGA0m87SSN1A2yD7uHDoCyZJ+Zu116Ijc7MIWZafWzLQcjytfAa
         ak+/B6H0xlWh5o2PIRjc3WVZYN0WJZ+9UNociAwadtZ0XWxTP/oP2XazT1HKnSou22Wt
         wZqQXuja1fy9fwdiyopOGpmhWuOLoutEY27fWbkaNVMTKqx8AekEXyUEvenmuHdSe0Az
         aKTg==
X-Gm-Message-State: AOJu0Yz6j21zwzKtK44mrFF5jiv8bHGB6nYhwcQXq3bKJSMvN8OVYZ17
	vDHx2UgAZGi4eCccsWLxxVJFqg16jXtVrAvcBJh+4F9wFYh+cQma
X-Google-Smtp-Source: AGHT+IGGx7gZdVSfjnuzLzFyWRd3Hif+UNY23Ac8jx3YrFaupWgI6TLI4mA3MEesWvaz/tM4C/kA3Q==
X-Received: by 2002:a05:600c:19cf:b0:40d:91fd:74e with SMTP id u15-20020a05600c19cf00b0040d91fd074emr5586072wmq.15.1706574963493;
        Mon, 29 Jan 2024 16:36:03 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id l10-20020a056000022a00b0033af350fb88sm2542167wrz.25.2024.01.29.16.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 16:36:03 -0800 (PST)
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
	linux-kernel@vger.kernel.org,
	Jie Luo <quic_luoj@quicinc.com>
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH v2 2/3] net: mdio: ipq4019: add support for clock-frequency property
Date: Tue, 30 Jan 2024 01:35:21 +0100
Message-ID: <20240130003546.1546-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130003546.1546-1-ansuelsmth@gmail.com>
References: <20240130003546.1546-1-ansuelsmth@gmail.com>
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
---
 drivers/net/mdio/mdio-ipq4019.c | 109 ++++++++++++++++++++++++++++++--
 1 file changed, 103 insertions(+), 6 deletions(-)

diff --git a/drivers/net/mdio/mdio-ipq4019.c b/drivers/net/mdio/mdio-ipq4019.c
index abd8b508ec16..61638f25c184 100644
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
+	 * Keep this and doesn't overwrite it.
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


