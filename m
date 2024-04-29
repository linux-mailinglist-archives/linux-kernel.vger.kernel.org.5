Return-Path: <linux-kernel+bounces-162475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8048B5BC9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59BEF281AFD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57ACB83CB1;
	Mon, 29 Apr 2024 14:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="KGMr4KWU"
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9DD80637
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 14:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.64.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714401940; cv=none; b=biH7wKO1xwPRTDK4M05gEXnfQSxzYSsqO0Vqy3npZf8s6Rgd0EaR+uvWY6Ssr8iZkSG7N4mq/GF2ELSqEf4bu4JoaKZKOfQYXkAqq2UuWXJQrcvPUbTEsHD89arhO4OLy3rUMKQawJlGztdymn1YAmedo1gj3Lpjqwv6FepcTvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714401940; c=relaxed/simple;
	bh=DmXR99HJmp8ntT6M7eWZkiJS2A4EI6AFe4l7VHsorYU=;
	h=Date:Message-Id:In-Reply-To:References:Subject:MIME-Version:
	 Content-Type:From:To:Cc; b=ex5RvKCN67jE1j6YRrYdHXUTHPjZoX4yuEW0PVfAEmsLHkQIMS5XOFvvIRCopAR3KW5X712k1htC+SuEZR7VQcFoSQE5BOWuqKhb99ZfnTwLlInLGYAFfbq90a7mVzcRTrfrwpBA1LgzpktoTSUI0bAO7zuGwU2a9RityIhhFEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rere.qmqm.pl; spf=pass smtp.mailfrom=rere.qmqm.pl; dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b=KGMr4KWU; arc=none smtp.client-ip=91.227.64.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rere.qmqm.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rere.qmqm.pl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
	t=1714401933; bh=DmXR99HJmp8ntT6M7eWZkiJS2A4EI6AFe4l7VHsorYU=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:From;
	b=KGMr4KWU9Epg0duIA8sCnxE6z2DBCDqjdqqYeyVyNM2JXuYHjdQWm5sFyqHQDSqzw
	 4Q2hGab7SCvh0HVk+885DV2/cS0qpdjjNPB1578yOx1UKnYYKmxZ0/EJ1mQCsGy0jS
	 eQwaTrtUm8OLYxOXlf+jnN1dqfCGRnkEJRIBcpi31FMQRhpgWxSe1d7efzfSWxf27z
	 qN50S6so7z3cmk924vaAnyj4JDhpRiM9FptmkCCqFOLT2QNzJlju6Zag4c2QPj97IL
	 gfbYfLODHEfc94IqYuj2tyVIPgEYigRL+yP4xQpZUSyMhN4WiknucfDCATrDBkJ8rl
	 beQvkYudK2ibA==
Received: from remote.user (localhost [127.0.0.1])
	by rere.qmqm.pl (Postfix) with ESMTPSA id 4VSmMx03SpzsP;
	Mon, 29 Apr 2024 16:45:33 +0200 (CEST)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 1.0.5 at mail
Date: Mon, 29 Apr 2024 16:45:32 +0200
Message-Id: <0c86e0d9585a4153049ac3eb0b9b8b1793a62e75.1714399603.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1714399603.git.mirq-linux@rere.qmqm.pl>
References: <cover.1714399603.git.mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 11/12] regulator/core: remove regulator_get/set_drvdata
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

There are no users of accessing regulator driver data via `struct
regulator` and there shouldn't be any as the struct is representing
a power consumer not the regulator itself.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/regulator/core.c           | 24 ------------------------
 include/linux/regulator/consumer.h | 14 --------------
 2 files changed, 38 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index d7192530d3e0..010f4db2ce60 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5908,30 +5908,6 @@ void *rdev_get_drvdata(struct regulator_dev *rdev)
 }
 EXPORT_SYMBOL_GPL(rdev_get_drvdata);
 
-/**
- * regulator_get_drvdata - get regulator driver data
- * @regulator: regulator
- *
- * Get regulator driver private data. This call can be used in the consumer
- * driver context when non API regulator specific functions need to be called.
- */
-void *regulator_get_drvdata(struct regulator *regulator)
-{
-	return regulator->rdev->reg_data;
-}
-EXPORT_SYMBOL_GPL(regulator_get_drvdata);
-
-/**
- * regulator_set_drvdata - set regulator driver data
- * @regulator: regulator
- * @data: data
- */
-void regulator_set_drvdata(struct regulator *regulator, void *data)
-{
-	regulator->rdev->reg_data = data;
-}
-EXPORT_SYMBOL_GPL(regulator_set_drvdata);
-
 /**
  * rdev_get_id - get regulator ID
  * @rdev: regulator
diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
index 4660582a3302..ee84adba390a 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -268,10 +268,6 @@ int regulator_suspend_disable(struct regulator_dev *rdev,
 int regulator_set_suspend_voltage(struct regulator *regulator, int min_uV,
 				  int max_uV, suspend_state_t state);
 
-/* driver data - core doesn't touch */
-void *regulator_get_drvdata(struct regulator *regulator);
-void regulator_set_drvdata(struct regulator *regulator, void *data);
-
 /* misc helpers */
 
 void regulator_bulk_set_supply_names(struct regulator_bulk_data *consumers,
@@ -607,16 +603,6 @@ static inline int regulator_set_suspend_voltage(struct regulator *regulator,
 	return -EINVAL;
 }
 
-static inline void *regulator_get_drvdata(struct regulator *regulator)
-{
-	return NULL;
-}
-
-static inline void regulator_set_drvdata(struct regulator *regulator,
-	void *data)
-{
-}
-
 static inline int regulator_count_voltages(struct regulator *regulator)
 {
 	return 0;
-- 
2.39.2


