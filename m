Return-Path: <linux-kernel+bounces-139872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B678A08BC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A92CB1F26A13
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E53C13DBAC;
	Thu, 11 Apr 2024 06:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZFKc09GO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6059F13DBA5;
	Thu, 11 Apr 2024 06:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712818020; cv=none; b=q3dyhIZyRdBk+x3rzFNr+Zykix7SVNb3vqDzCAj83OLKSssWqaEs8WlD3X+vzWaiWHmFdkUQgkeyJTBv4RTd257MQyJJJdUxFr+/le0WCO8neuPVv388zsjD59V5azgSyqrspFFnzEmb8rBZYOMEkaGVBQ1FgspVnSopROBrYCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712818020; c=relaxed/simple;
	bh=GlRh8UW057t9Bq8GK2coWR2MWUDzOJl27L0JCrjgaf0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eH9Ut0FHX00iRnFivoLHN68QOoFcSRo83NRbqegtwEdb+pWWf1Po71ebNkUaIJBQDQ4t3XsNlRWqQzZTaKsVfA6AhQR/dK/aULT9TY1zZrU7u2cUuDQwL+hyFE7KbA+bVk2yGZZ9qpXCeB2rs1cZq1VlwXDw26aLdUFyjSbTPao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZFKc09GO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3E6CC43390;
	Thu, 11 Apr 2024 06:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712818020;
	bh=GlRh8UW057t9Bq8GK2coWR2MWUDzOJl27L0JCrjgaf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZFKc09GOz2pyCjFCQEQ7BKvIvyvN4vJYweQ6qxwCoEii02GvFk6M3OceD33dErEmE
	 WPTg7FvmEh6qU9vHd/IdEeSZCl4kSpOTpwM/HXc49zq50w/tCjpvpO4Q871zufnxHw
	 iE1+omGnughItTcCtnltH5ji09DkK6WDCVla6Wb2pNwCS+/v8InKy4IIpUsFKJugsb
	 ijFfsyRq0KP753r3KrhM5pYkHGvfGfHNti7g/TbniHp7ZOLBmdoLPaxbWOl0T5RQAV
	 P/ZPTWC5ttBuCJIfmXSQN4I9loBcO0ahg7+T/vB9w/EHxXPvyVeNRi5D8NQ/VM0HB6
	 KetL8uwhApKqw==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dong Aisheng <aisheng.dong@nxp.com>,
	Fabio Estevam <festevam@gmail.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Jacky Bai <ping.bai@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Sean Wang <sean.wang@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	zhanghongchen <zhanghongchen@loongson.cn>,
	Yinbo Zhu <zhuyinbo@loongson.cn>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-gpio@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-msm@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 5/5] pinctrl: realtek: fix module autoloading
Date: Thu, 11 Apr 2024 08:46:14 +0200
Message-Id: <20240411064614.7409-5-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240411064614.7409-1-krzk@kernel.org>
References: <20240411064614.7409-1-krzk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add MODULE_DEVICE_TABLE(), so the module could be properly autoloaded
based on the alias from of_device_id table.  Pin controllers are
considered core components, so usually they are built-in, however these
can be built and used as modules on some generic kernel.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes in v2:
1. Add missing yank-yank.
https://lore.kernel.org/all/1d96377f-2a9d-49df-ada3-086d1e6b9dab@kernel.org/
---
 drivers/pinctrl/realtek/pinctrl-rtd1315e.c | 1 +
 drivers/pinctrl/realtek/pinctrl-rtd1319d.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/pinctrl/realtek/pinctrl-rtd1315e.c b/drivers/pinctrl/realtek/pinctrl-rtd1315e.c
index 10afc736a52b..86f919122bed 100644
--- a/drivers/pinctrl/realtek/pinctrl-rtd1315e.c
+++ b/drivers/pinctrl/realtek/pinctrl-rtd1315e.c
@@ -1414,6 +1414,7 @@ static const struct of_device_id rtd1315e_pinctrl_of_match[] = {
 	{ .compatible = "realtek,rtd1315e-pinctrl", },
 	{},
 };
+MODULE_DEVICE_TABLE(of, rtd1315e_pinctrl_of_match);
 
 static struct platform_driver rtd1315e_pinctrl_driver = {
 	.driver = {
diff --git a/drivers/pinctrl/realtek/pinctrl-rtd1319d.c b/drivers/pinctrl/realtek/pinctrl-rtd1319d.c
index b1a654ac30dc..474c337d2d05 100644
--- a/drivers/pinctrl/realtek/pinctrl-rtd1319d.c
+++ b/drivers/pinctrl/realtek/pinctrl-rtd1319d.c
@@ -1584,6 +1584,7 @@ static const struct of_device_id rtd1319d_pinctrl_of_match[] = {
 	{ .compatible = "realtek,rtd1319d-pinctrl", },
 	{},
 };
+MODULE_DEVICE_TABLE(of, rtd1319d_pinctrl_of_match);
 
 static struct platform_driver rtd1319d_pinctrl_driver = {
 	.driver = {
-- 
2.34.1


