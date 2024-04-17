Return-Path: <linux-kernel+bounces-148426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCC98A8265
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DB441C21BDF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD85613D626;
	Wed, 17 Apr 2024 11:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ltts.com header.i=@ltts.com header.b="FKCW78ji";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="GXy/yh3/"
Received: from c180-17.smtp-out.ap-south-1.amazonses.com (c180-17.smtp-out.ap-south-1.amazonses.com [76.223.180.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9606B13D296;
	Wed, 17 Apr 2024 11:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.223.180.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713354597; cv=none; b=FBjSczY0retAjo4pomHdvMVWej0BF5ky7utwx3e80ei43qzM7h3qXi0duOypVz2DpXbVmmCDT0DQXJ/wrozUNbwU0muVfC2EHj62BwKgjDfkL8GDHWYLb5pu9lStDIk1kwxG45hAArU7BJRYAoQb6jm+OKjXve31wnwXsh890Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713354597; c=relaxed/simple;
	bh=pjple3N7K1u1+TmH4sBZ9GXxe47P7tkb4dir/HgayiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CJ8Z2dbWRMn6t6z4kxVGnhr0+4BSCLUCQeVW7mO/2YjERCgEcWEU7CYGQUN96CErtaMtJc8JrFxNBOBJQJCiSL5IJAAUCGzpo+zjkc1gyOXvNXschUKuKfL8o/UbIICSmHYFJ9SwEy8WhBnw7lr7FjdxVhlUjcjPjDOeyydT8g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com; spf=pass smtp.mailfrom=ap-south-1.amazonses.com; dkim=pass (2048-bit key) header.d=ltts.com header.i=@ltts.com header.b=FKCW78ji; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=GXy/yh3/; arc=none smtp.client-ip=76.223.180.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ap-south-1.amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=i3fe3efcd4pbz7ipgssfqjhzqx347xbc; d=ltts.com; t=1713354593;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=pjple3N7K1u1+TmH4sBZ9GXxe47P7tkb4dir/HgayiU=;
	b=FKCW78jioJ43EUTvW9UHIxHH04RJpGu5gZpRE8WPtbRQNMfyX193L10yvW4gNPKO
	ZMZbjUqQOqMwLAac8HlwU3anStiO5sMImn2WwOmiFhgxkcbaUS+yb3DxxrRa8XaooIO
	JC5uZWVjmvYkfnnFfyN3QgcqXuYsjfmMllW9cwed6l8zE9smQWI0odHN3MnGvCtJwKA
	uWlfFUQKGweyxJobZYTmMgq/0R9rTHGwGTxPSCKB/h5ddr5rzx1tS9jv1URRvoWRCPL
	DS1NsroTg2OP4vwF57fCq1WQOW2j9Fo4jwn/3xvcQKX42g+ZJApB5VKJlYE0Calx9JH
	pzuvJzcjOw==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=rlntogby6xsxlfnvyxwnvvhttakdsqto; d=amazonses.com; t=1713354593;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=pjple3N7K1u1+TmH4sBZ9GXxe47P7tkb4dir/HgayiU=;
	b=GXy/yh3/BvSpkYyVGSqxUiAkOFo8dtFRXiC3vIDWbV2RyiLCcLwbNQDsIfWxuOn5
	zUiHg/6HJZk+gM3wfgp1r7S1glNwhsk6VYQw6y4xBGeoibMRdZ+WGHKWcRn5CYAmUsT
	R/3iul1Wxg6XlnKMPkrOIHKAYnt0VVi8EKH5QP+I=
From: Bhargav Raviprakash <bhargav.r@ltts.com>
To: linux-kernel@vger.kernel.org
Cc: m.nirmaladevi@ltts.com, lee@kernel.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	jpanis@baylibre.com, devicetree@vger.kernel.org, arnd@arndb.de, 
	gregkh@linuxfoundation.org, lgirdwood@gmail.com, broonie@kernel.org, 
	linus.walleij@linaro.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, nm@ti.com, vigneshr@ti.com, 
	kristo@kernel.org, eblanc@baylibre.com, 
	Bhargav Raviprakash <bhargav.r@ltts.com>
Subject: [PATCH v7 02/10] mfd: tps6594: use volatile_table instead of volatile_reg
Date: Wed, 17 Apr 2024 11:49:53 +0000
Message-ID: <0109018eebe4532e-f60a4f0a-a64f-4d67-92d6-763ff0d6b2a0-000000@ap-south-1.amazonses.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240417114934.186248-1-bhargav.r@ltts.com>
References: <20240417114934.186248-1-bhargav.r@ltts.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: 1.ap-south-1./RC/PI2M8xOxQmTMPi0M1Q8h2FX69egpT62QKSaMPIA=:AmazonSES
X-SES-Outgoing: 2024.04.17-76.223.180.17

In regmap_config use volatile_table instead of volatile_reg. This change
makes it easier to add support for TPS65224 PMIC.

Signed-off-by: Bhargav Raviprakash <bhargav.r@ltts.com>
Acked-by: Julien Panis <jpanis@baylibre.com>
---
 drivers/mfd/tps6594-core.c  | 16 ++++++++++------
 drivers/mfd/tps6594-i2c.c   |  2 +-
 drivers/mfd/tps6594-spi.c   |  2 +-
 include/linux/mfd/tps6594.h |  4 +++-
 4 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/mfd/tps6594-core.c b/drivers/mfd/tps6594-core.c
index 783ee5990..089ab8cc8 100644
--- a/drivers/mfd/tps6594-core.c
+++ b/drivers/mfd/tps6594-core.c
@@ -319,12 +319,16 @@ static struct regmap_irq_chip tps6594_irq_chip = {
 	.handle_post_irq = tps6594_handle_post_irq,
 };
 
-bool tps6594_is_volatile_reg(struct device *dev, unsigned int reg)
-{
-	return (reg >= TPS6594_REG_INT_TOP && reg <= TPS6594_REG_STAT_READBACK_ERR) ||
-	       reg == TPS6594_REG_RTC_STATUS;
-}
-EXPORT_SYMBOL_GPL(tps6594_is_volatile_reg);
+static const struct regmap_range tps6594_volatile_ranges[] = {
+	regmap_reg_range(TPS6594_REG_INT_TOP, TPS6594_REG_STAT_READBACK_ERR),
+	regmap_reg_range(TPS6594_REG_RTC_STATUS, TPS6594_REG_RTC_STATUS),
+};
+
+const struct regmap_access_table tps6594_volatile_table = {
+	.yes_ranges = tps6594_volatile_ranges,
+	.n_yes_ranges = ARRAY_SIZE(tps6594_volatile_ranges),
+};
+EXPORT_SYMBOL_GPL(tps6594_volatile_table);
 
 static int tps6594_check_crc_mode(struct tps6594 *tps, bool primary_pmic)
 {
diff --git a/drivers/mfd/tps6594-i2c.c b/drivers/mfd/tps6594-i2c.c
index 899c88c0f..c125b474b 100644
--- a/drivers/mfd/tps6594-i2c.c
+++ b/drivers/mfd/tps6594-i2c.c
@@ -187,7 +187,7 @@ static const struct regmap_config tps6594_i2c_regmap_config = {
 	.reg_bits = 16,
 	.val_bits = 8,
 	.max_register = TPS6594_REG_DWD_FAIL_CNT_REG,
-	.volatile_reg = tps6594_is_volatile_reg,
+	.volatile_table = &tps6594_volatile_table,
 	.read = tps6594_i2c_read,
 	.write = tps6594_i2c_write,
 };
diff --git a/drivers/mfd/tps6594-spi.c b/drivers/mfd/tps6594-spi.c
index 24b72847e..5afb1736f 100644
--- a/drivers/mfd/tps6594-spi.c
+++ b/drivers/mfd/tps6594-spi.c
@@ -70,7 +70,7 @@ static const struct regmap_config tps6594_spi_regmap_config = {
 	.reg_bits = 16,
 	.val_bits = 8,
 	.max_register = TPS6594_REG_DWD_FAIL_CNT_REG,
-	.volatile_reg = tps6594_is_volatile_reg,
+	.volatile_table = &tps6594_volatile_table,
 	.reg_read = tps6594_spi_reg_read,
 	.reg_write = tps6594_spi_reg_write,
 	.use_single_read = true,
diff --git a/include/linux/mfd/tps6594.h b/include/linux/mfd/tps6594.h
index e754c01ac..16543fd4d 100644
--- a/include/linux/mfd/tps6594.h
+++ b/include/linux/mfd/tps6594.h
@@ -1337,7 +1337,9 @@ struct tps6594 {
 	struct regmap_irq_chip_data *irq_data;
 };
 
-bool tps6594_is_volatile_reg(struct device *dev, unsigned int reg);
+extern const struct regmap_access_table tps6594_volatile_table;
+extern const struct regmap_access_table tps65224_volatile_table;
+
 int tps6594_device_init(struct tps6594 *tps, bool enable_crc);
 
 #endif /*  __LINUX_MFD_TPS6594_H */
-- 
2.25.1


