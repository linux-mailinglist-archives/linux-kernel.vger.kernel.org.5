Return-Path: <linux-kernel+bounces-162474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEDC8B5BC7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AED54B20A8D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6218121F;
	Mon, 29 Apr 2024 14:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="cNpCRKZT"
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54797EEF3
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 14:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.64.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714401940; cv=none; b=NincPjF+qOtD+r1AaSQRanOn+o19WVbvMNolffhUmYcQ1JaLJl7ylk1rXPseI4i7A6+hM1NI0Ns8lWd+96YhYKsj0K0v3OMS/HT0uOSIz4KntILqOLQ/ByYOTtRVrnowC3rZGhuJq8+qCJK0ZJUM1VdM//Oc5atB63DG+Vuqy+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714401940; c=relaxed/simple;
	bh=4JtJTSbLrjwGebjthC7c0OCkQzqG8Bgaqe/Z3Spl0fM=;
	h=Date:Message-Id:In-Reply-To:References:Subject:MIME-Version:
	 Content-Type:From:To:Cc; b=ffQwr3jnjGxy8/E7oowSbNzAsAAwJinjIzDNsuiSekuKRXO71wRCifIDrJRnjNdf73LfCHrXP5fETGwN3/upiq1uvlRc7DzI77TgLLZoBUL5PmgfCIvynGWiSoHoEcKfdx2kEm+9zZSb4rHL/8YIqEkBMOUyK/CaWlAdRUUgUOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rere.qmqm.pl; spf=pass smtp.mailfrom=rere.qmqm.pl; dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b=cNpCRKZT; arc=none smtp.client-ip=91.227.64.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rere.qmqm.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rere.qmqm.pl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
	t=1714401933; bh=4JtJTSbLrjwGebjthC7c0OCkQzqG8Bgaqe/Z3Spl0fM=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:From;
	b=cNpCRKZTS4BT2Od/tQPePf91WPup7BuhEp3AVYFZFz9c5JCdKO4qRNMTCzKcgSe6D
	 W0lWHX3wjCC0RUZB1bPj6nl5w4lKjtx0vLcB6MTI3Mq/zJjphah1DMDtgmcuHK8Tpy
	 kHWfmXJl+WzlHiOmI0WYQfogbEErXjXmHhFQd8ueAEyjxMia03mPSkti3q2ZF+ZGZf
	 bHFpPRfnMW8OePhcquVFtGNlPED7rPf0UobN8IEKueDi/xIIpMMIPIvbGrtYg835T2
	 3F+UeNrfT0hQXJNWZVCObFFLMZ5/ilZez1jZ32DD0qh30VxtJ8jWLKMytjt2JpU4un
	 ZttaTsMPR1lBQ==
Received: from remote.user (localhost [127.0.0.1])
	by rere.qmqm.pl (Postfix) with ESMTPSA id 4VSmMx487bz1M1;
	Mon, 29 Apr 2024 16:45:33 +0200 (CEST)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 1.0.5 at mail
Date: Mon, 29 Apr 2024 16:45:33 +0200
Message-Id: <0a480abe4913f0169f9693f6f959fbe1a397ae93.1714399603.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1714399603.git.mirq-linux@rere.qmqm.pl>
References: <cover.1714399603.git.mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 12/12] regulator/core: use rdev->dev.driver_data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From:	=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
To:	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc:	linux-kernel@vger.kernel.org

Move rdev->reg_data to rdev->dev.driver_data to follow the linux device
model more closely.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/regulator/core.c          | 15 +--------------
 include/linux/regulator/driver.h  |  8 +++++---
 include/linux/regulator/machine.h |  2 +-
 3 files changed, 7 insertions(+), 18 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 010f4db2ce60..ea2a5efd9a4b 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5630,7 +5630,7 @@ regulator_register(struct device *dev,
 	}
 
 	ww_mutex_init(&rdev->mutex, &regulator_ww_class);
-	rdev->reg_data = config->driver_data;
+	dev_set_drvdata(&rdev->dev, config->driver_data);
 	rdev->owner = regulator_desc->owner;
 	rdev->desc = regulator_desc;
 	if (config->regmap)
@@ -5895,19 +5895,6 @@ void regulator_has_full_constraints(void)
 }
 EXPORT_SYMBOL_GPL(regulator_has_full_constraints);
 
-/**
- * rdev_get_drvdata - get rdev regulator driver data
- * @rdev: regulator
- *
- * Get rdev regulator driver private data. This call can be used in the
- * regulator driver context.
- */
-void *rdev_get_drvdata(struct regulator_dev *rdev)
-{
-	return rdev->reg_data;
-}
-EXPORT_SYMBOL_GPL(rdev_get_drvdata);
-
 /**
  * rdev_get_id - get regulator ID
  * @rdev: regulator
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index c1334601cf02..680c23b13249 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -632,8 +632,6 @@ struct regulator_dev {
 
 	struct delayed_work disable_work;
 
-	void *reg_data;		/* regulator_dev data */
-
 	struct dentry *debugfs;
 
 	struct regulator_enable_gpio *ena_pin;
@@ -707,7 +705,11 @@ void regulator_irq_helper_cancel(void **handle);
 int regulator_irq_map_event_simple(int irq, struct regulator_irq_data *rid,
 				   unsigned long *dev_mask);
 
-void *rdev_get_drvdata(struct regulator_dev *rdev);
+static inline void *rdev_get_drvdata(const struct regulator_dev *rdev)
+{
+	return dev_get_drvdata(&rdev->dev);
+}
+
 struct device *rdev_get_dev(struct regulator_dev *rdev);
 struct regmap *rdev_get_regmap(struct regulator_dev *rdev);
 int rdev_get_id(struct regulator_dev *rdev);
diff --git a/include/linux/regulator/machine.h b/include/linux/regulator/machine.h
index 7c39dbc33290..378f051d4e70 100644
--- a/include/linux/regulator/machine.h
+++ b/include/linux/regulator/machine.h
@@ -274,7 +274,7 @@ struct regulator_consumer_supply {
  * @num_consumer_supplies: Number of consumer device supplies.
  * @consumer_supplies: Consumer device supply configuration.
  *
- * @driver_data: Pointer copied to regulator_dev.reg_data.
+ * @driver_data: Pointer copied to regulator_dev's drvdata.
  */
 struct regulator_init_data {
 	const char *supply_regulator;        /* or NULL for system supply */
-- 
2.39.2


