Return-Path: <linux-kernel+bounces-103976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C53AC87C757
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 02:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 156F41F21D97
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 01:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4E563AC;
	Fri, 15 Mar 2024 01:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=risingedge.co.za header.i=@risingedge.co.za header.b="H+CvL/e4"
Received: from outgoing6.flk.host-h.net (outgoing6.flk.host-h.net [188.40.0.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745A253A0;
	Fri, 15 Mar 2024 01:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.0.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710467828; cv=none; b=B6f/WOgOM2ObvGhMV+BIZ2QKLJ4wikGzGX4VfDB6FZkDGwlv7/tFDHbEihPL9clPV8LDiOmYAb6HOGPSJxyLLWJk6BoZkRnXN4zZ+LcmcS9fvpkjUn4jRgKmbfDdEKzY11MkQMe/OXNwhoFGhVPNbiZgtXSPjXrKBDhUaha3lrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710467828; c=relaxed/simple;
	bh=k/4MAwR3FTpi3ezP4O+KfGOb9q/xcoTFPk2EDj74BQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rDDWqaiVaw3fuiT1J82xGK1Co1cGCNhM0HoprOMqb5IrsDndB/ponFMJ2SAEjhgYWOGClo/xg3PP6j813lEaZdDDZWoPmRgHLgHDRcsAl5xpk2N859aEVQC3oN+dM01056mofD6so5rLZ7ZLf5PKbCzRcIGVqvDESeiENHgHwMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=risingedge.co.za; spf=pass smtp.mailfrom=risingedge.co.za; dkim=pass (2048-bit key) header.d=risingedge.co.za header.i=@risingedge.co.za header.b=H+CvL/e4; arc=none smtp.client-ip=188.40.0.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=risingedge.co.za
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=risingedge.co.za
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=risingedge.co.za; s=xneelo; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:in-reply-to:references
	:content-type; bh=m5rd9ifZ34O1uNXee2Fsneyjh2M4bDVdEEJvhc4tvDA=; b=H+CvL/e440l
	JJPRJHdtp7h9KiOCO3m9QWpkWay3OUnhQkgt5KKBtcpAItqT5BYZdOgBH5WTGRKUoFL4A9VUYGhIm
	B8w23oS4YnTNz0ym/zk19pOV8fd75Wu93aUHzKwUV3RlL7v02/7wFqjFXEjyGQ4qLCG+Ca8IBVNRK
	Qc6ylwtXlH+DN0PXa02N1oCrpAXR/cH5yQK6zxNmxBlAZA6rfP68RYd6tZr0dTZcGtY/+v5DYi4jk
	rPCWQiIXyV9jiOO7sSjftVQKOvL27+GH9ATdAtE1s04CA+cAkCYBkh8vcfKfiNfQKnhMVfFsd5hf5
	4e0MPOE9bGDaSfTGiijFqkw==;
Received: from www31.flk1.host-h.net ([188.40.1.173])
	by antispam2-flk1.host-h.net with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <justin.swartz@risingedge.co.za>)
	id 1rkwoR-001fqj-Aa; Fri, 15 Mar 2024 03:56:50 +0200
Received: from [41.144.1.223] (helo=localhost.localdomain)
	by www31.flk1.host-h.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <justin.swartz@risingedge.co.za>)
	id 1rkwoM-0004ib-Kg; Fri, 15 Mar 2024 03:56:43 +0200
From: Justin Swartz <justin.swartz@risingedge.co.za>
To: Mark Brown <broonie@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Justin Swartz <justin.swartz@risingedge.co.za>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] spi: mt7621: allow GPIO chip select lines
Date: Fri, 15 Mar 2024 03:57:07 +0200
Message-Id: <20240315015708.13948-1-justin.swartz@risingedge.co.za>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: justin.swartz@risingedge.co.za
X-Virus-Scanned: Clear
X-SpamExperts-Domain: risingedge.co.za
X-SpamExperts-Username: 
Authentication-Results: host-h.net; auth=pass (login) smtp.auth=@risingedge.co.za
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00107698202516)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT9tEvqO5Dzlp8Hw8s4Xw7pgPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5wCPRB8bAzJcv2cv+UqiTTc2+CpNcmBnO4XM3Sck4bwNogU
 WCl1nkLBzZX0KuJ9bXiS85Z42w/+2OBolTNFbPomXFWCX8oNdggW7HE9XDTdSejrkEpbuUvwMvHx
 3T+KSG//gbuP7hnUK8NQdLwsVWKIss2oH4Yjh6Q4paNNh70vrmKlRYN8+ZW0XX0AH/7tz8lOUWMR
 3Oz/N19DDfqg//ykQCB4rUl3suKct8rEwEjtlBjGf82vsPPH4Z6bBeyJ2ioKLll7c1zqbZ0Shnfk
 f76m6WzjgyOQ30CX3jGye0AgO43dPg2t4siixN3H6ipUQpsUOAoG0LIxLqqnLG/G17r2WmuNA8WT
 ybi1JN85FSnfKaZl5e9CnNR0t//S8nh6vX9JR7tTkgtGxbJXMnaWeORi/IOL8hFK8UwSRsjj826v
 xIvoo9siXVea4yN8+JzC4p2qtoJeAaAIM5zNlwLSz7WsotxMDYRAzuCR0I/uZN17IfdXFZsEUcDk
 8TfE1VxuxGc2M4JzCc//R6Wyn0xEa4/gbKRUuwP9TxU53J++//mag2wVXO50BuTihrUiUr+Ne0YD
 3ddZG295JphtZpms9X0aBNANCxNWMmHXUTEMGGbKThOghFKJuzFdJ78lk25pCKnYrhUnk1aI/tYo
 PYfrgLItviC2z3vIzjh1mXBwO7cA3KxDuzsITj9XSEsqBTpMNClkAdhK23InA2zzja5I1riDVsRE
 /qfh3BpRIL035Lwa3AR5iWi4B3c2TvD1mYFCey4YQsgkfE0ewNgNUY5lZOQ5d86hkdfWpdNtlHKD
 /N5YI0ii+HGJbtyrZfX5fEH4LjZJ4azDVvtI4xLpBrhpV1Z2g0cC96lvLg9F6alXVA5GCKQ8jPBS
 b1sSQu/sXnVb6BTD1y1EN4lWLphXo/QFY19Ko4ys4J2lj1UPbPmBHp1pEv3Fs7AeUg8cSzkuHTCW
 7WeivJsOGdLHT5AmY9PDPjGy0z6bhalFEM/pjPCQA+BAlnIZxFSV0ux1niV+gnzf0coKruD/dlzX
 C6+t6EZu9kdJLKf1SPrgqyxNzu9tGWZKtpHq1b8bdjWfKogUQsVZaT9m4zuNRcgRKiGg7nXFaZTx
 I/6scxhAq/6af00PEtBNjYtqmoKr5eemJzKNdiP7m3gSrWCqyhAo0JR3rThOyxKFbWMT2xK3KT9R
 mx5HiKCYjt40eTXlWiUAYdLmsJdAoPIA+QBBCmRnfEQkXp5mAyXTIBVUuAX2KYddQlACXnsZ2u9C
 nazM3+ZE40UYhpZLE/UxL7hrJSk60SF3F6RYOYr2
X-Report-Abuse-To: spam@antispamquarantine.host-h.net

Extract a magic number, from mt7621_spi_probe(), used to
declare the number of chip select lines (which co-incides
with the native chip select count of 2) to a macro.

Use the newly defined MT7621_NATIVE_CS_COUNT macro to
instead populate both the spi_controller's max_native_cs
and num_chipselect members.

Declare that the spi_controller should use_gpio_descriptors
if present in the device properties (such as those declared
in the cs-gpio property of a "ralink,mt7621-spi" compatible
device-tree node) so that the SPI core will recalulcate
num_chipselect to account for the GPIO descriptors that
it should have populated in the cs_gpiod array member.

Add the mt7621_spi_set_cs_gpio() function to control the
logical state of a GPIO chip select line, agnostic of the
electrical line state and activation polarity.

Add the mt7621_spi_cleanup() function to ensure that every
GPIO chip select will be deactivated when no longer in use.

Extend mt7621_spi_setup() so that if an SPI device is
associated with a GPIO chip select, its chip select line
will be deactivated before use.

Rename mt7621_spi_set_cs() to mt7621_spi_set_native_cs(),
and redefine mt7621_spi_set_cs() to determine whether:

  to call mt7621_spi_set_cs_gpio(), in the case of the
  passed SPI device being associated with a GPIO chip
  select line,

  or to call mt7621_spi_set_set_native_cs() instead.

Modify mt7621_transfer_one_message() to take into account
that mt7621_spi_set_cs() now returns an int and should use
the returned value for spi_message status indication if a
failure related to GPIO access has occured.

Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>
---

See Documentation/devicetree/bindings/spi/spi-controller.yaml
for information about cs-gpios semantics.

Example:

&spi0 {
	cs-gpios = <0>, <0>,
	           <&gpio 18 GPIO_ACTIVE_LOW>,   /* WDT_RST_N */
	           <&gpio 19 GPIO_ACTIVE_HIGH>;  /* PERST_N   */
	status = "ok";

	...

	spidev@2 {
		compatible = "defective,by-design";
		reg = <2>;
		spi-max-frequency = <16000000>;
	};

	spidev@3 {
		compatible = "defective,by-design";
		reg = <3>;
		spi-cs-high;
		spi-max-frequency = <16000000>;
	};
}; 	 

 drivers/spi/spi-mt7621.c | 46 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 42 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-mt7621.c b/drivers/spi/spi-mt7621.c
index 4e9053d03..87e164c86 100644
--- a/drivers/spi/spi-mt7621.c
+++ b/drivers/spi/spi-mt7621.c
@@ -52,6 +52,8 @@
 #define MT7621_CPOL		BIT(4)
 #define MT7621_LSB_FIRST	BIT(3)
 
+#define MT7621_NATIVE_CS_COUNT	2
+
 struct mt7621_spi {
 	struct spi_controller	*host;
 	void __iomem		*base;
@@ -75,7 +77,19 @@ static inline void mt7621_spi_write(struct mt7621_spi *rs, u32 reg, u32 val)
 	iowrite32(val, rs->base + reg);
 }
 
-static void mt7621_spi_set_cs(struct spi_device *spi, int enable)
+static int mt7621_spi_set_cs_gpio(struct spi_device *spi, int enable)
+{
+	struct gpio_desc *gpiod = spi_get_csgpiod(spi, 0);
+	int cs = spi_get_chipselect(spi, 0);
+	int status = gpiod_direction_output(gpiod, enable);
+
+	if (status)
+		dev_err(&spi->dev, "set_gpio: failed to set CS%d", cs);
+
+	return status;
+}
+
+static void mt7621_spi_set_native_cs(struct spi_device *spi, int enable)
 {
 	struct mt7621_spi *rs = spidev_to_mt7621_spi(spi);
 	int cs = spi_get_chipselect(spi, 0);
@@ -99,6 +113,15 @@ static void mt7621_spi_set_cs(struct spi_device *spi, int enable)
 	mt7621_spi_write(rs, MT7621_SPI_POLAR, polar);
 }
 
+static int mt7621_spi_set_cs(struct spi_device *spi, int enable)
+{
+	if (spi_is_csgpiod(spi))
+		return mt7621_spi_set_cs_gpio(spi, enable);
+
+	mt7621_spi_set_native_cs(spi,enable);
+	return 0;
+}
+
 static int mt7621_spi_prepare(struct spi_device *spi, unsigned int speed)
 {
 	struct mt7621_spi *rs = spidev_to_mt7621_spi(spi);
@@ -266,7 +289,9 @@ static int mt7621_spi_transfer_one_message(struct spi_controller *host,
 	}
 
 	/* Assert CS */
-	mt7621_spi_set_cs(spi, 1);
+	status = mt7621_spi_set_cs(spi, 1);
+	if (status)
+		goto msg_done;
 
 	m->actual_length = 0;
 	list_for_each_entry(t, &m->transfers, transfer_list) {
@@ -290,7 +315,7 @@ static int mt7621_spi_transfer_one_message(struct spi_controller *host,
 
 	/* Flush data and deassert CS */
 	mt7621_spi_flush(rs);
-	mt7621_spi_set_cs(spi, 0);
+	status = mt7621_spi_set_cs(spi, 0);
 
 msg_done:
 	m->status = status;
@@ -313,9 +338,18 @@ static int mt7621_spi_setup(struct spi_device *spi)
 		return -EINVAL;
 	}
 
+	if (spi_is_csgpiod(spi))
+		return mt7621_spi_set_cs_gpio(spi, 0);
+
 	return 0;
 }
 
+static void mt7621_spi_cleanup(struct spi_device *spi)
+{
+	if (spi_is_csgpiod(spi))
+		mt7621_spi_set_cs_gpio(spi, 0);
+}
+
 static const struct of_device_id mt7621_spi_match[] = {
 	{ .compatible = "ralink,mt7621-spi" },
 	{},
@@ -353,10 +387,14 @@ static int mt7621_spi_probe(struct platform_device *pdev)
 	host->mode_bits = SPI_LSB_FIRST;
 	host->flags = SPI_CONTROLLER_HALF_DUPLEX;
 	host->setup = mt7621_spi_setup;
+	host->cleanup = mt7621_spi_cleanup;
 	host->transfer_one_message = mt7621_spi_transfer_one_message;
 	host->bits_per_word_mask = SPI_BPW_MASK(8);
 	host->dev.of_node = pdev->dev.of_node;
-	host->num_chipselect = 2;
+
+	host->max_native_cs = MT7621_NATIVE_CS_COUNT;
+	host->num_chipselect = host->max_native_cs;
+	host->use_gpio_descriptors = true;
 
 	dev_set_drvdata(&pdev->dev, host);
 
-- 


