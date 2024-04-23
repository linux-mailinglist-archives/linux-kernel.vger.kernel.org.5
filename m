Return-Path: <linux-kernel+bounces-155001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B22A98AE42F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 685C31F23C02
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6869D84A55;
	Tue, 23 Apr 2024 11:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pqrs.dk header.i=@pqrs.dk header.b="ZJNJt5Eb"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A887FBA2
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 11:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872152; cv=none; b=Av19mw/ByLkLtmH982KXYmmXuqK+LEF4vTtmySImSqhln55lll6+qoQhRAMJcUWswpWYXH3tw6EN8A70GKQfvNNfG09s866YH0MRJYe6qr+5kx+7PQyWPJo4AKT4hdaiGl78fR+SJw2vV4jyqutMkXcaV4hUvAmme3xstRXj1no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872152; c=relaxed/simple;
	bh=ovcMslS2omGsY1EULRFd77UxhiulmHebYLq+iKzHxI0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A3AacmDJC8bBR1Od2zKH55015sUPrUl55RJdwJg1B0R/Kf/hPSHNaUfP6+HJBCMIzccu3nld/AhqgNGMJbfoSCI5xutU52jufFko2rrrgx73/d3dxPklTCPOkEyCKKR5G5b9IX5VaocS603L1uOAwuII+JIa9nz2Ni8thyVgrNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pqrs.dk; spf=pass smtp.mailfrom=pqrs.dk; dkim=pass (2048-bit key) header.d=pqrs.dk header.i=@pqrs.dk header.b=ZJNJt5Eb; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pqrs.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pqrs.dk
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqrs.dk; s=key1;
	t=1713872148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0PyQJiiXfGl3oN3CM544FYnY5XXcnoGO8H5B1VBN/i8=;
	b=ZJNJt5EbaEVMM/q98cMyLcBHCIDIF4y65dav7PnKGqCoaZqF10zEdRu20JW8lc4PF71CW0
	Ms+HhvssjeIyzO289SHY+vuieiPvLsmSF3+1XkpXC6l/h17pL278e2EFcASL9NZIH32E9C
	r3lhxkB14RQvY8lViMUV0ccEnCZMXKlkH4ah5G4LJmENZUwq8adu9W2nybjIDarPiUn5m6
	gpGilZzzLLVybiAGs++6YRsk8dDjv8Mx6F1BUkJK0IJxdg2Cg7OanB8Ga9xNbDiMNXx9X1
	h7xIbIEdw2PEBW3ZewbmEaJ0UmPBkV0nNcD8hSmo5r7RIWhY1hJYKVLGLr5Svg==
From: =?utf-8?q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>
Date: Tue, 23 Apr 2024 13:35:32 +0200
Subject: [PATCH 3/3] spi: sc18is602: add support for SC18IS606
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240423-sc18is606-v1-3-094ef37d5a59@bang-olufsen.dk>
References: <20240423-sc18is606-v1-0-094ef37d5a59@bang-olufsen.dk>
In-Reply-To: <20240423-sc18is606-v1-0-094ef37d5a59@bang-olufsen.dk>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>
X-Migadu-Flow: FLOW_OUT

From: Alvin Šipraga <alsi@bang-olufsen.dk>

Per its datasheet, the SC18IS606 is a functional replacement of the
currently supported SC18IS602B, with the only relevant exceptions to
this driver being an increased data buffer size (1024 vs 200 bytes) and
three (rather than four) chip selects. It also lacks support for
quasi-directional GPIO, but the driver does not use this feature anyway,
so this is not reflected in the changes.

To that end, update the driver to support variable data buffer sizes and
add populate the relevant driver private data fields for this new chip.

Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
---
 drivers/spi/spi-sc18is602.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-sc18is602.c b/drivers/spi/spi-sc18is602.c
index eecf9ea95ae3..c4adfd4af804 100644
--- a/drivers/spi/spi-sc18is602.c
+++ b/drivers/spi/spi-sc18is602.c
@@ -16,9 +16,9 @@
 #include <linux/platform_data/sc18is602.h>
 #include <linux/gpio/consumer.h>
 
-enum chips { sc18is602, sc18is602b, sc18is603 };
+enum chips { sc18is602, sc18is602b, sc18is603, sc18is606 };
 
-#define SC18IS602_BUFSIZ		200
+#define SC18IS602_MAX_BUFSIZ		1024
 #define SC18IS602_CLOCK			7372000
 
 #define SC18IS602_MODE_CPHA		BIT(2)
@@ -35,11 +35,12 @@ struct sc18is602 {
 	u8			ctrl;
 	u32			freq;
 	u32			speed;
+	size_t			bufsiz; /* Data buffer size */
 
 	/* I2C data */
 	struct i2c_client	*client;
 	enum chips		id;
-	u8			buffer[SC18IS602_BUFSIZ + 1];
+	u8			buffer[SC18IS602_MAX_BUFSIZ + 1];
 	int			tlen;	/* Data queued for tx in buffer */
 	int			rindex;	/* Receive data index in buffer */
 
@@ -99,7 +100,7 @@ static int sc18is602_txrx(struct sc18is602 *hw, struct spi_message *msg,
 	}
 
 	if (do_transfer && hw->tlen > 1) {
-		ret = sc18is602_wait_ready(hw, SC18IS602_BUFSIZ);
+		ret = sc18is602_wait_ready(hw, hw->bufsiz);
 		if (ret < 0)
 			return ret;
 		ret = i2c_master_send(hw->client, hw->buffer, hw->tlen);
@@ -173,7 +174,9 @@ static int sc18is602_setup_transfer(struct sc18is602 *hw, u32 hz, u8 mode)
 static int sc18is602_check_transfer(struct spi_device *spi,
 				    struct spi_transfer *t, int tlen)
 {
-	if (t && t->len + tlen > SC18IS602_BUFSIZ + 1)
+	struct sc18is602 *hw = spi_controller_get_devdata(spi->controller);
+
+	if (t && t->len + tlen > hw->bufsiz + 1)
 		return -EINVAL;
 
 	return 0;
@@ -220,7 +223,9 @@ static int sc18is602_transfer_one(struct spi_controller *host,
 
 static size_t sc18is602_max_transfer_size(struct spi_device *spi)
 {
-	return SC18IS602_BUFSIZ;
+	struct sc18is602 *hw = spi_controller_get_devdata(spi->controller);
+
+	return hw->bufsiz;
 }
 
 static int sc18is602_setup(struct spi_device *spi)
@@ -274,10 +279,12 @@ static int sc18is602_probe(struct i2c_client *client)
 	case sc18is602:
 	case sc18is602b:
 		host->num_chipselect = 4;
+		hw->bufsiz = 200;
 		hw->freq = SC18IS602_CLOCK;
 		break;
 	case sc18is603:
 		host->num_chipselect = 2;
+		hw->bufsiz = 200;
 		if (pdata) {
 			hw->freq = pdata->clock_frequency;
 		} else {
@@ -291,6 +298,11 @@ static int sc18is602_probe(struct i2c_client *client)
 		if (!hw->freq)
 			hw->freq = SC18IS602_CLOCK;
 		break;
+	case sc18is606:
+		host->num_chipselect = 3;
+		hw->bufsiz = 1024;
+		hw->freq = SC18IS602_CLOCK;
+		break;
 	}
 	host->bus_num = np ? -1 : client->adapter->nr;
 	host->mode_bits = SPI_CPHA | SPI_CPOL | SPI_LSB_FIRST;
@@ -310,6 +322,7 @@ static const struct i2c_device_id sc18is602_id[] = {
 	{ "sc18is602", sc18is602 },
 	{ "sc18is602b", sc18is602b },
 	{ "sc18is603", sc18is603 },
+	{ "sc18is606", sc18is606 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, sc18is602_id);
@@ -327,6 +340,10 @@ static const struct of_device_id sc18is602_of_match[] __maybe_unused = {
 		.compatible = "nxp,sc18is603",
 		.data = (void *)sc18is603
 	},
+	{
+		.compatible = "nxp,sc18is606",
+		.data = (void *)sc18is606
+	},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, sc18is602_of_match);

-- 
2.44.0


