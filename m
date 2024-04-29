Return-Path: <linux-kernel+bounces-162473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A175A8B5BC6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CDD0281E1C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED9E82869;
	Mon, 29 Apr 2024 14:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="o8cd8ajn"
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A7D7EF04
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 14:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.64.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714401940; cv=none; b=I9JNxhxv4ukCP/cruzwmWnHbrMSJN8FE+xxcp5dxHp+OQSD6wpH9m+s+vNK9zUtRNNXOpe3wOMRl00gPAty3Fyxrtj2P1bTKLrnlqvwePFQKlAC985E2/U/taf5Ubofgwedw2nOAmKey8xRBiY9RW4wysF7vVcAd4ZzYlON03rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714401940; c=relaxed/simple;
	bh=ALJ3a2lN8gTuNkfwOUbs2XXgVwKG43Au7jQay+z9jLo=;
	h=Date:Message-Id:In-Reply-To:References:Subject:MIME-Version:
	 Content-Type:From:To:Cc; b=HdmWb83yvYiRXuSG9CmU02+QSSQQdXM/oG3YbH1peP3OWvLipJ5RqLQnwtSFns3VmbvWhYYWqAyeqQkgaPGZADwNOLffopbgqmdF1khe1Z0lDpLLz4j8CkNrQHgswQkyavCTIkEnU/JYX9s7LNMXCFYJKd5e4LCCYI4393TxR74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rere.qmqm.pl; spf=pass smtp.mailfrom=rere.qmqm.pl; dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b=o8cd8ajn; arc=none smtp.client-ip=91.227.64.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rere.qmqm.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rere.qmqm.pl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
	t=1714401930; bh=ALJ3a2lN8gTuNkfwOUbs2XXgVwKG43Au7jQay+z9jLo=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:From;
	b=o8cd8ajnyyhrxSSiD6U8g8JnpFXWWK1pMOxNyh2Zt29WreK2PQn6jaT//0yEPloDJ
	 WEzM5EzOKqWWqwuXx1+tpvB7yMtRvqL4oBK2GisXxWXklzKYUQNOFvVQEeDmmhQk4i
	 cJBMDRLT8skn6uETl37+G5lErxMi3oSNcPsVL2NSgQ0bQxpZ2lTypVL1Y5fheVmzeJ
	 tcp9IEmcIdoqN8RaKZFMrTyhSJEq31yOj+ZdUK1cxj67yvt0b0wlKAKS6s+g04bMeo
	 EFtrHsqq8JbuK9RV2BMp5F7RKJ7JqdzeYLxq2N4jSCoIQzYGZ7JuWWdR3jJh3hNIo5
	 vdqOfwiw35ueQ==
Received: from remote.user (localhost [127.0.0.1])
	by rere.qmqm.pl (Postfix) with ESMTPSA id 4VSmMt5bqlzPG;
	Mon, 29 Apr 2024 16:45:30 +0200 (CEST)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 1.0.5 at mail
Date: Mon, 29 Apr 2024 16:45:30 +0200
Message-Id: <80d42ba84110eb04d451f832ba6033955aba90fa.1714399603.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1714399603.git.mirq-linux@rere.qmqm.pl>
References: <cover.1714399603.git.mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 07/12] regulator/core: remove regulator_get_init_drvdata()
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

There are no in-tree users.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/regulator/core.c         | 6 ------
 include/linux/regulator/driver.h | 1 -
 2 files changed, 7 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index be45983e1d23..efb68a5c85af 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5955,12 +5955,6 @@ struct regmap *rdev_get_regmap(struct regulator_dev *rdev)
 }
 EXPORT_SYMBOL_GPL(rdev_get_regmap);
 
-void *regulator_get_init_drvdata(struct regulator_init_data *reg_init_data)
-{
-	return reg_init_data->driver_data;
-}
-EXPORT_SYMBOL_GPL(regulator_get_init_drvdata);
-
 #ifdef CONFIG_DEBUG_FS
 static int supply_map_show(struct seq_file *sf, void *data)
 {
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 22a07c0900a4..c1334601cf02 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -753,7 +753,6 @@ int regulator_set_active_discharge_regmap(struct regulator_dev *rdev,
 int regulator_set_current_limit_regmap(struct regulator_dev *rdev,
 				       int min_uA, int max_uA);
 int regulator_get_current_limit_regmap(struct regulator_dev *rdev);
-void *regulator_get_init_drvdata(struct regulator_init_data *reg_init_data);
 int regulator_find_closest_bigger(unsigned int target, const unsigned int *table,
 				  unsigned int num_sel, unsigned int *sel);
 int regulator_set_ramp_delay_regmap(struct regulator_dev *rdev, int ramp_delay);
-- 
2.39.2


