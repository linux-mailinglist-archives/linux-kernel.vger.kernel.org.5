Return-Path: <linux-kernel+bounces-123764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F4E890D74
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21C261C2FCFC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F249113E6CF;
	Thu, 28 Mar 2024 22:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKBW6Kxw"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B5313E6BB;
	Thu, 28 Mar 2024 22:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711664014; cv=none; b=DEKQJTA1iw9IJU9akuHYjMl9KR5A1HcW0nGjNx6qN6ZxXjAZv5S2v4GkXCIibO4lPe9rwj7PWOkAoIOjPhehXBBW18eYveS8HQpYtQD0a/1nYwlqxULLGnWpy2H3RPc3PNsOPSN0fpwp3zR4tV+fsGl1nU5kQRCYsG8pl8HT/Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711664014; c=relaxed/simple;
	bh=hNKwxlpIRMofjLKgvThjdMhRnTxXaAUQdW94byqwPUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sPv6BVtj0KZhh+shIttcZtq/C2KTjNETY9cnsXGBp+CiuvvDNVQj9q1BDZQY7/xJMEHnPO0sGkAcojXMiBLr5/IOCO8CX/ma59nu6lUPYgcvzFik6DsrRnf17aVSbTe5TuTmIpc/yaxOfHHO3mUgBVnczUuYnjEfQwGqKTq+NNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QKBW6Kxw; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41545e9f482so6699325e9.2;
        Thu, 28 Mar 2024 15:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711664010; x=1712268810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sOXglrUw9o7LU52nMs5DSblSu76XNxKwQCT3ejBLoqI=;
        b=QKBW6KxwpRJ2m7lO7/srhrDJS/e9wGxwN1wz7a/QX7KZsE0UEg2epz5hrm6OxZiaL7
         b17yOWXRHheiw2g32zAwq11UQ5mcQxSvm3MNgaSiVNqrdDlbT76Gz4eRHHFJYLWP4uT4
         /3EHKeYDn2pqBSBHlYZYsA7oW/FxZ4/be2RduvJSJjHZLhQXFJ9eyIi9d5iWrdujMVhG
         AXDY4UfnAgWQICoYGqM3mtU5NYypFI8NscHlF4CGbsYC8l5kD22VfQsf89CKAYh70DHK
         u1cO5swLJpEIrFpeSoPXDWiDw1fA7IHCqALfXeH6zr944C7eRyk+xoB9bVR84EWqBkqS
         cZ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711664010; x=1712268810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sOXglrUw9o7LU52nMs5DSblSu76XNxKwQCT3ejBLoqI=;
        b=XfsX/ZEYicdPechWDNFW5wRXAJCgQfjUkpoGXEqxsQue4j1pB11f+jPKm2cIZKRqQF
         YaPKabGQam0wm6glvcw7G6L7JrHKoAarLgTlsh4EnMJLxq5WExBYZgcclCFqYAMmd0Jf
         ll0PcBzjp35Kn817PcA7LFd4WWyywWdMpo/IUML1PpMCu0zl8MHJVxbfTgqXPKtN5Qsz
         FIpNB6Doj3arocbg1bkPZznpEW+qtvr7aQz23f09Mc0wttkbggQ9m0bGr5eqP9E35MVH
         mApteOLFJuA/SdzuX7a24QGwJlnLsKwDVIToYyw+HoKIVin6+zV5zSnUebu+PuP317er
         yaTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMj1rlOslwCqIlxqGlA1QFdIYEUyH/JP0i2n5Qsl/u8iRCXqKWC0a6R2iXu8XVbVL+353lFvDQV2peGX4pqhI8rieeKqjoSWuCkF4Mv7XxO9eZYlfpt2cOe2gq1/MPcUxJIjG1AwgctRc=
X-Gm-Message-State: AOJu0YyqIXPt3Kydf2xRGB2RRuJ/zknbmYEcUUjNkTO8amB/AsleY3l+
	MHND9jBof/K94CMTDet+txVneU3OvT7uRGKihmc0o2pFVOFDP1SP
X-Google-Smtp-Source: AGHT+IEJUhgfiOmN6ES+J7vKqXcRGgIgi8PdumL9xICNsiyilUOcjol7mAdrwxdau8gLwLk5m3TfJg==
X-Received: by 2002:a05:600c:1daa:b0:414:8869:1ef3 with SMTP id p42-20020a05600c1daa00b0041488691ef3mr443930wms.39.1711664010425;
        Thu, 28 Mar 2024 15:13:30 -0700 (PDT)
Received: from lmc-playground.localdomain ([188.25.208.244])
        by smtp.gmail.com with ESMTPSA id m28-20020a05600c3b1c00b00414688af147sm6666778wms.20.2024.03.28.15.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 15:13:30 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: broonie@kernel.org
Cc: lgirdwood@gmail.com,
	peter.ujfalusi@linux.intel.com,
	pierre-louis.bossart@linux.intel.com,
	daniel.baluta@nxp.com,
	iuliana.prodan@nxp.com,
	linux-sound@vger.kernel.org,
	imx@lists.linux.dev,
	laurentiu.mihalcea@nxp.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ASoC: SOF: imx: drop usage of the imx8_*_clocks API
Date: Fri, 29 Mar 2024 00:12:00 +0200
Message-Id: <20240328221201.24722-2-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328221201.24722-1-laurentiumihalcea111@gmail.com>
References: <20240328221201.24722-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Currently, the driver has to keep track of all the clocks
it uses via an array of "struct clk_bulk_data", which doesn't
scale well and is unnecessary. As such, replace the usage of
the imx8_*_clocks with "devm_clk_bulk_get_all()" and friends.

Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
Reviewed-by: Iuliana Prodan <iuliana.prodan@nxp.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 sound/soc/sof/imx/imx8.c    | 41 +++++++++++++++---------------------
 sound/soc/sof/imx/imx8m.c   | 40 +++++++++++++++--------------------
 sound/soc/sof/imx/imx8ulp.c | 42 +++++++++++++++++--------------------
 3 files changed, 53 insertions(+), 70 deletions(-)

diff --git a/sound/soc/sof/imx/imx8.c b/sound/soc/sof/imx/imx8.c
index 07f51489d6c9..d65e09a927f6 100644
--- a/sound/soc/sof/imx/imx8.c
+++ b/sound/soc/sof/imx/imx8.c
@@ -41,13 +41,6 @@
 #define MBOX_OFFSET	0x800000
 #define MBOX_SIZE	0x1000
 
-/* DSP clocks */
-static struct clk_bulk_data imx8_dsp_clks[] = {
-	{ .id = "ipg" },
-	{ .id = "ocram" },
-	{ .id = "core" },
-};
-
 struct imx8_priv {
 	struct device *dev;
 	struct snd_sof_dev *sdev;
@@ -64,7 +57,8 @@ struct imx8_priv {
 	struct device **pd_dev;
 	struct device_link **link;
 
-	struct imx_clocks *clks;
+	struct clk_bulk_data *clks;
+	int clk_num;
 };
 
 static int imx8_get_mailbox_offset(struct snd_sof_dev *sdev)
@@ -196,10 +190,6 @@ static int imx8_probe(struct snd_sof_dev *sdev)
 	if (!priv)
 		return -ENOMEM;
 
-	priv->clks = devm_kzalloc(&pdev->dev, sizeof(*priv->clks), GFP_KERNEL);
-	if (!priv->clks)
-		return -ENOMEM;
-
 	sdev->num_cores = 1;
 	sdev->pdata->hw_pdata = priv;
 	priv->dev = sdev->dev;
@@ -313,17 +303,18 @@ static int imx8_probe(struct snd_sof_dev *sdev)
 	/* set default mailbox offset for FW ready message */
 	sdev->dsp_box.offset = MBOX_OFFSET;
 
-	/* init clocks info */
-	priv->clks->dsp_clks = imx8_dsp_clks;
-	priv->clks->num_dsp_clks = ARRAY_SIZE(imx8_dsp_clks);
-
-	ret = imx8_parse_clocks(sdev, priv->clks);
-	if (ret < 0)
+	ret = devm_clk_bulk_get_all(sdev->dev, &priv->clks);
+	if (ret < 0) {
+		dev_err(sdev->dev, "failed to fetch clocks: %d\n", ret);
 		goto exit_pdev_unregister;
+	}
+	priv->clk_num = ret;
 
-	ret = imx8_enable_clocks(sdev, priv->clks);
-	if (ret < 0)
+	ret = clk_bulk_prepare_enable(priv->clk_num, priv->clks);
+	if (ret < 0) {
+		dev_err(sdev->dev, "failed to enable clocks: %d\n", ret);
 		goto exit_pdev_unregister;
+	}
 
 	return 0;
 
@@ -343,7 +334,7 @@ static void imx8_remove(struct snd_sof_dev *sdev)
 	struct imx8_priv *priv = sdev->pdata->hw_pdata;
 	int i;
 
-	imx8_disable_clocks(sdev, priv->clks);
+	clk_bulk_disable_unprepare(priv->clk_num, priv->clks);
 	platform_device_unregister(priv->ipc_dev);
 
 	for (i = 0; i < priv->num_domains; i++) {
@@ -373,7 +364,7 @@ static void imx8_suspend(struct snd_sof_dev *sdev)
 	for (i = 0; i < DSP_MU_CHAN_NUM; i++)
 		imx_dsp_free_channel(priv->dsp_ipc, i);
 
-	imx8_disable_clocks(sdev, priv->clks);
+	clk_bulk_disable_unprepare(priv->clk_num, priv->clks);
 }
 
 static int imx8_resume(struct snd_sof_dev *sdev)
@@ -382,9 +373,11 @@ static int imx8_resume(struct snd_sof_dev *sdev)
 	int ret;
 	int i;
 
-	ret = imx8_enable_clocks(sdev, priv->clks);
-	if (ret < 0)
+	ret = clk_bulk_prepare_enable(priv->clk_num, priv->clks);
+	if (ret < 0) {
+		dev_err(sdev->dev, "failed to enable clocks: %d\n", ret);
 		return ret;
+	}
 
 	for (i = 0; i < DSP_MU_CHAN_NUM; i++)
 		imx_dsp_request_channel(priv->dsp_ipc, i);
diff --git a/sound/soc/sof/imx/imx8m.c b/sound/soc/sof/imx/imx8m.c
index 222cd1467da6..3e0b88002b4f 100644
--- a/sound/soc/sof/imx/imx8m.c
+++ b/sound/soc/sof/imx/imx8m.c
@@ -26,12 +26,6 @@
 #define MBOX_OFFSET	0x800000
 #define MBOX_SIZE	0x1000
 
-static struct clk_bulk_data imx8m_dsp_clks[] = {
-	{ .id = "ipg" },
-	{ .id = "ocram" },
-	{ .id = "core" },
-};
-
 /* DAP registers */
 #define IMX8M_DAP_DEBUG                0x28800000
 #define IMX8M_DAP_DEBUG_SIZE   (64 * 1024)
@@ -54,7 +48,8 @@ struct imx8m_priv {
 	struct imx_dsp_ipc *dsp_ipc;
 	struct platform_device *ipc_dev;
 
-	struct imx_clocks *clks;
+	struct clk_bulk_data *clks;
+	int clk_num;
 
 	void __iomem *dap;
 	struct regmap *regmap;
@@ -163,10 +158,6 @@ static int imx8m_probe(struct snd_sof_dev *sdev)
 	if (!priv)
 		return -ENOMEM;
 
-	priv->clks = devm_kzalloc(&pdev->dev, sizeof(*priv->clks), GFP_KERNEL);
-	if (!priv->clks)
-		return -ENOMEM;
-
 	sdev->num_cores = 1;
 	sdev->pdata->hw_pdata = priv;
 	priv->dev = sdev->dev;
@@ -250,17 +241,18 @@ static int imx8m_probe(struct snd_sof_dev *sdev)
 		goto exit_pdev_unregister;
 	}
 
-	/* init clocks info */
-	priv->clks->dsp_clks = imx8m_dsp_clks;
-	priv->clks->num_dsp_clks = ARRAY_SIZE(imx8m_dsp_clks);
-
-	ret = imx8_parse_clocks(sdev, priv->clks);
-	if (ret < 0)
+	ret = devm_clk_bulk_get_all(sdev->dev, &priv->clks);
+	if (ret < 0) {
+		dev_err(sdev->dev, "failed to fetch clocks: %d\n", ret);
 		goto exit_pdev_unregister;
+	}
+	priv->clk_num = ret;
 
-	ret = imx8_enable_clocks(sdev, priv->clks);
-	if (ret < 0)
+	ret = clk_bulk_prepare_enable(priv->clk_num, priv->clks);
+	if (ret < 0) {
+		dev_err(sdev->dev, "failed to enable clocks: %d\n", ret);
 		goto exit_pdev_unregister;
+	}
 
 	return 0;
 
@@ -273,7 +265,7 @@ static void imx8m_remove(struct snd_sof_dev *sdev)
 {
 	struct imx8m_priv *priv = sdev->pdata->hw_pdata;
 
-	imx8_disable_clocks(sdev, priv->clks);
+	clk_bulk_disable_unprepare(priv->clk_num, priv->clks);
 	platform_device_unregister(priv->ipc_dev);
 }
 
@@ -336,9 +328,11 @@ static int imx8m_resume(struct snd_sof_dev *sdev)
 	int ret;
 	int i;
 
-	ret = imx8_enable_clocks(sdev, priv->clks);
-	if (ret < 0)
+	ret = clk_bulk_prepare_enable(priv->clk_num, priv->clks);
+	if (ret < 0) {
+		dev_err(sdev->dev, "failed to enable clocks: %d\n", ret);
 		return ret;
+	}
 
 	for (i = 0; i < DSP_MU_CHAN_NUM; i++)
 		imx_dsp_request_channel(priv->dsp_ipc, i);
@@ -354,7 +348,7 @@ static void imx8m_suspend(struct snd_sof_dev *sdev)
 	for (i = 0; i < DSP_MU_CHAN_NUM; i++)
 		imx_dsp_free_channel(priv->dsp_ipc, i);
 
-	imx8_disable_clocks(sdev, priv->clks);
+	clk_bulk_disable_unprepare(priv->clk_num, priv->clks);
 }
 
 static int imx8m_dsp_runtime_resume(struct snd_sof_dev *sdev)
diff --git a/sound/soc/sof/imx/imx8ulp.c b/sound/soc/sof/imx/imx8ulp.c
index 7b527ffde488..296fbf11f6d0 100644
--- a/sound/soc/sof/imx/imx8ulp.c
+++ b/sound/soc/sof/imx/imx8ulp.c
@@ -40,13 +40,6 @@
 #define MBOX_OFFSET		0x800000
 #define MBOX_SIZE		0x1000
 
-static struct clk_bulk_data imx8ulp_dsp_clks[] = {
-	{ .id = "core" },
-	{ .id = "ipg" },
-	{ .id = "ocram" },
-	{ .id = "mu" },
-};
-
 struct imx8ulp_priv {
 	struct device *dev;
 	struct snd_sof_dev *sdev;
@@ -56,7 +49,8 @@ struct imx8ulp_priv {
 	struct platform_device *ipc_dev;
 
 	struct regmap *regmap;
-	struct imx_clocks *clks;
+	struct clk_bulk_data *clks;
+	int clk_num;
 };
 
 static void imx8ulp_sim_lpav_start(struct imx8ulp_priv *priv)
@@ -175,10 +169,6 @@ static int imx8ulp_probe(struct snd_sof_dev *sdev)
 	if (!priv)
 		return -ENOMEM;
 
-	priv->clks = devm_kzalloc(&pdev->dev, sizeof(*priv->clks), GFP_KERNEL);
-	if (!priv->clks)
-		return -ENOMEM;
-
 	sdev->num_cores = 1;
 	sdev->pdata->hw_pdata = priv;
 	priv->dev = sdev->dev;
@@ -259,16 +249,18 @@ static int imx8ulp_probe(struct snd_sof_dev *sdev)
 		goto exit_pdev_unregister;
 	}
 
-	priv->clks->dsp_clks = imx8ulp_dsp_clks;
-	priv->clks->num_dsp_clks = ARRAY_SIZE(imx8ulp_dsp_clks);
-
-	ret = imx8_parse_clocks(sdev, priv->clks);
-	if (ret < 0)
+	ret = devm_clk_bulk_get_all(sdev->dev, &priv->clks);
+	if (ret < 0) {
+		dev_err(sdev->dev, "failed to fetch clocks: %d\n", ret);
 		goto exit_pdev_unregister;
+	}
+	priv->clk_num = ret;
 
-	ret = imx8_enable_clocks(sdev, priv->clks);
-	if (ret < 0)
+	ret = clk_bulk_prepare_enable(priv->clk_num, priv->clks);
+	if (ret < 0) {
+		dev_err(sdev->dev, "failed to enable clocks: %d\n", ret);
 		goto exit_pdev_unregister;
+	}
 
 	return 0;
 
@@ -282,7 +274,7 @@ static void imx8ulp_remove(struct snd_sof_dev *sdev)
 {
 	struct imx8ulp_priv *priv = sdev->pdata->hw_pdata;
 
-	imx8_disable_clocks(sdev, priv->clks);
+	clk_bulk_disable_unprepare(priv->clk_num, priv->clks);
 	platform_device_unregister(priv->ipc_dev);
 }
 
@@ -303,7 +295,7 @@ static int imx8ulp_suspend(struct snd_sof_dev *sdev)
 	for (i = 0; i < DSP_MU_CHAN_NUM; i++)
 		imx_dsp_free_channel(priv->dsp_ipc, i);
 
-	imx8_disable_clocks(sdev, priv->clks);
+	clk_bulk_disable_unprepare(priv->clk_num, priv->clks);
 
 	return 0;
 }
@@ -311,9 +303,13 @@ static int imx8ulp_suspend(struct snd_sof_dev *sdev)
 static int imx8ulp_resume(struct snd_sof_dev *sdev)
 {
 	struct imx8ulp_priv *priv = (struct imx8ulp_priv *)sdev->pdata->hw_pdata;
-	int i;
+	int i, ret;
 
-	imx8_enable_clocks(sdev, priv->clks);
+	ret = clk_bulk_prepare_enable(priv->clk_num, priv->clks);
+	if (ret < 0) {
+		dev_err(sdev->dev, "failed to enable clocks: %d\n", ret);
+		return ret;
+	}
 
 	for (i = 0; i < DSP_MU_CHAN_NUM; i++)
 		imx_dsp_request_channel(priv->dsp_ipc, i);
-- 
2.34.1


