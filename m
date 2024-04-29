Return-Path: <linux-kernel+bounces-162472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F05288B5BC5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC91728214E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AF7823AF;
	Mon, 29 Apr 2024 14:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="qkSLMEwh"
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B923A7EF18
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 14:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.64.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714401940; cv=none; b=sB4pmJsrrKbwlBCW5fmdgKZnjDjNmqzFrbfTuM1ANwvYhuCXfxElUTCqz3mdvwWvTbJWG8wPrUtVaEslWJoWkStGsQRIofRRBe2puEUy82LdbeV9vaM9Nt92aZvzN0s9bHNqx1qlz53Z7cj7CyEeVKgVaV7/68yWOe7nKCnG9jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714401940; c=relaxed/simple;
	bh=VgBNW+KxT7+rgLFryVkEDoWc1+7GQwAEoJRu2QC0sx4=;
	h=Date:Message-Id:In-Reply-To:References:Subject:MIME-Version:
	 Content-Type:From:To:Cc; b=QIsaWM3VA/fkpN6Gh5uCsgTLnQjjGuoWhgPUt8mqMjFGEkYwP+Fx9qH6sRmz1NWkP76Mh5Ux7YLKLMn/oskjRMenWjo1vkTT8tMqmLG8x4eqFHWC4uYRVmtNZVrz7sLXeZfqvU5VzZJtMSSvEJhJpgLVW9TEocW4Eyr7BBHzpQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rere.qmqm.pl; spf=pass smtp.mailfrom=rere.qmqm.pl; dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b=qkSLMEwh; arc=none smtp.client-ip=91.227.64.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rere.qmqm.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rere.qmqm.pl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
	t=1714401930; bh=VgBNW+KxT7+rgLFryVkEDoWc1+7GQwAEoJRu2QC0sx4=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:From;
	b=qkSLMEwhPh9Cx193H1xCghs8GC2tPDH04D8kAJUKmPTYsZUrvIAiFquMvxb6BQ0AM
	 nbEcqRRBfZt3+2laeih6pEbZX/0BXXxqxBM1lhfEUT/qLOtUHn87iPPv6+1OzSqB2I
	 YzsDVFKkOojnyBtEJ3mlwg3a0iCHRTnj10oT9aZqhtmn33oHnDwEmlkR0UT7ibqTyj
	 ZURO2As//UBNR7MbiWbbRF7cX9X3yLA8hym/3V5kbJnfIFQSKq+Tha5u6WrhlRTT3v
	 hei0dV7CmK8mJpBj3C0MufuE+fFEkitVeOIrneZCF4kap4ddBW8KqdaXtU6nOteOcI
	 5LC6fyr8oyjFA==
Received: from remote.user (localhost [127.0.0.1])
	by rere.qmqm.pl (Postfix) with ESMTPSA id 4VSmMs6XZBzKb;
	Mon, 29 Apr 2024 16:45:29 +0200 (CEST)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 1.0.5 at mail
Date: Mon, 29 Apr 2024 16:45:29 +0200
Message-Id: <799e847ea819c9972d4c0b6a7f427a41ff652412.1714399603.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1714399603.git.mirq-linux@rere.qmqm.pl>
References: <cover.1714399603.git.mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 06/12] regulator/core: remove regulator_init callback
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

There are no in-tree users. The only usage went away in 2019 in
8c44e448583c ("regulator: stpmic1: Simplify regulators registration").

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/regulator/core.c          | 7 -------
 include/linux/regulator/machine.h | 7 ++-----
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 4cb30e49c03d..be45983e1d23 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5679,13 +5679,6 @@ regulator_register(struct device *dev,
 		resolved_early = true;
 	}
 
-	/* perform any regulator specific init */
-	if (init_data && init_data->regulator_init) {
-		ret = init_data->regulator_init(rdev->reg_data);
-		if (ret < 0)
-			goto wash;
-	}
-
 	if (config->ena_gpiod) {
 		ret = regulator_ena_gpio_request(rdev, config);
 		if (ret != 0) {
diff --git a/include/linux/regulator/machine.h b/include/linux/regulator/machine.h
index 0cd76d264727..7c39dbc33290 100644
--- a/include/linux/regulator/machine.h
+++ b/include/linux/regulator/machine.h
@@ -274,8 +274,7 @@ struct regulator_consumer_supply {
  * @num_consumer_supplies: Number of consumer device supplies.
  * @consumer_supplies: Consumer device supply configuration.
  *
- * @regulator_init: Callback invoked when the regulator has been registered.
- * @driver_data: Data passed to regulator_init.
+ * @driver_data: Pointer copied to regulator_dev.reg_data.
  */
 struct regulator_init_data {
 	const char *supply_regulator;        /* or NULL for system supply */
@@ -285,9 +284,7 @@ struct regulator_init_data {
 	int num_consumer_supplies;
 	struct regulator_consumer_supply *consumer_supplies;
 
-	/* optional regulator machine specific init */
-	int (*regulator_init)(void *driver_data);
-	void *driver_data;	/* core does not touch this */
+	void *driver_data;
 };
 
 #ifdef CONFIG_REGULATOR
-- 
2.39.2


