Return-Path: <linux-kernel+bounces-163976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB2E8B76C3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A15F11F24188
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D041171E68;
	Tue, 30 Apr 2024 13:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ltts.com header.i=@ltts.com header.b="pfHG4ACU";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="VqPQpiy7"
Received: from c180-41.smtp-out.ap-south-1.amazonses.com (c180-41.smtp-out.ap-south-1.amazonses.com [76.223.180.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBBA171E4D;
	Tue, 30 Apr 2024 13:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.223.180.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714483007; cv=none; b=gSnzV0p52GR8n6rpvMkWjqCAhMWAHX011Fihjvz1SnnzxvCKdZgh9f9GnetcmZeoASYhH8tYBKTnWotejbnUj0FIlLi04tagXa6DhigcSDPSkiuZT21GkyZwpbeMetQR0xSNvYqy0w4+uK06LJ0poscs75WKpgqAv6XfVV753ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714483007; c=relaxed/simple;
	bh=pjple3N7K1u1+TmH4sBZ9GXxe47P7tkb4dir/HgayiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JM259C8QfEseJDoB/5ncSJIkx3g7T50aSEVBnd5EbdP7qoThaMQCw6OXkQks58EDBVo2pNDFkEN1J3ILBwkR51eu3rruWPNKV5nBNWP4B6KItTuVKh9hy2c82x0WDbKT9rCmE5M/gHyugVUeCo9iamg94Ldc03vRI6YUpcmQvzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com; spf=pass smtp.mailfrom=ap-south-1.amazonses.com; dkim=pass (2048-bit key) header.d=ltts.com header.i=@ltts.com header.b=pfHG4ACU; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=VqPQpiy7; arc=none smtp.client-ip=76.223.180.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ap-south-1.amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=i3fe3efcd4pbz7ipgssfqjhzqx347xbc; d=ltts.com; t=1714483003;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=pjple3N7K1u1+TmH4sBZ9GXxe47P7tkb4dir/HgayiU=;
	b=pfHG4ACUxeb5g1kCijTyT0hxmOpbaYR1Lb5sZPI50/zqlzdpq45tfyXVg0geFJtP
	3WQOshRLXBv2kl710qFcRn5tgkgtXlu3KRRftCi4Y0R8Q99yZ5QIZjM9l8SFDwWmMhZ
	CILhWlk/iIzGO2eisZ4Cuu1gQZeGBNkXbp9mEX6dmv4xQAjxChr98zI9XZcc8zO/BYq
	I9pYgrqvyoxk6hhvupSpoTwSNS82X/9NiBGiTt5zG8POIdRUW9MuPFegGFLUFJCjdkg
	RWr1uCeqbG/bv3HgSwwydcKbdwz+gsaTjl4UvYnuvMt81fiAg65azSaNvCrUx+L/QLW
	cW7y/m/Vlw==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=zpkik46mrueu52d3326ufxxchortqmoc; d=amazonses.com; t=1714483003;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=pjple3N7K1u1+TmH4sBZ9GXxe47P7tkb4dir/HgayiU=;
	b=VqPQpiy7SZNXpoKGiGlto8R6xeMh6b9x9jY3GyXgiPbHFHc6sFuTPknKsJEjSwvN
	75gJVKEDXU0cf7R/Mbmine1WT3jknGEPNKHqumPe/XoRm2scFd759jhBuVhkC2g0Bm3
	0Sayue5DGmmkwU5bNGFN9pT7KQzlZnJoeNNobJ4g=
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
Subject: [PATCH v8 02/10] mfd: tps6594: use volatile_table instead of volatile_reg
Date: Tue, 30 Apr 2024 13:16:43 +0000
Message-ID: <0109018f2f267f6e-3121fa42-4816-45f7-a96d-0d6b4678da5a-000000@ap-south-1.amazonses.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <0109018f2f24c15e-c50bfc29-5f1d-4368-a4b8-2c9f1d398abb-000000@ap-south-1.amazonses.com>
References: <0109018f2f24c15e-c50bfc29-5f1d-4368-a4b8-2c9f1d398abb-000000@ap-south-1.amazonses.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: 1.ap-south-1./RC/PI2M8xOxQmTMPi0M1Q8h2FX69egpT62QKSaMPIA=:AmazonSES
X-SES-Outgoing: 2024.04.30-76.223.180.41

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


