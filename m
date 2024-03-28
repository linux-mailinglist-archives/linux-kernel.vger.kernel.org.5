Return-Path: <linux-kernel+bounces-122677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4713F88FB46
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6991A1C2D542
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00797134CB;
	Thu, 28 Mar 2024 09:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pg1rnvD+"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E08A7C08E;
	Thu, 28 Mar 2024 09:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711617810; cv=none; b=rF0omWMpNNDqjkbkgdXZDFsSOWfjxkYcHnyVNlsocziWiYYDMZnsr/RVEaXraqJNFMfoHTEx1QZph1YkT3La28aJ5I2Wc/no8Xxpu9LFU2DdZEji1809S31bcITXB4XBmhGG3rT1bkJ3JhWcg/q6WYdvDUFiYiNA1xNqLbc9OIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711617810; c=relaxed/simple;
	bh=Pcj6wq13Q2zMT6Z2Uam+tVJ0LEM1dkNhmKNJG7xfxbM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VdZdpWtgeLQtJ8ZllEz1EcKv3nKvcQE/gWNwJ0NEKHhl6wE9mF1pYujHZ6iojx6VXuRB/O1QxTd/ZOq7/O5oCcyozHbK+eIMPgtMyb14kKt2IuDlYzvlR9Zl3JNrYTewwbkmWp8U6C5XR05NC9K70wWN20VZtUlPwSrEVVII42Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pg1rnvD+; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56b0af675deso791487a12.1;
        Thu, 28 Mar 2024 02:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711617807; x=1712222607; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4fIcsg8gcugtMmlVw+LmPC2bgw0Si2DZI0WsD/Dma5Q=;
        b=Pg1rnvD+ICWDwPdDod8UkktDDH9IXT2fcE+mmN9It59vCkI0RYGaGuwmdSCpQgCQAp
         n3oTpyg0NyzwNvhN4x1lS2GIxnpUNNut5Se3G74L0EUQS6wB2q11BAxbFS/YQCkckZ+m
         WXb6LLbkFkDj/pnuKC9xSnTFKD/EMPM6RgWe7WtxLDQtF7Nn95LVbY3aEYQHvkVTHqGP
         cfOo8FpLZKZ+XRA1Sk7HValYsEmSjEFIbjUN8rLGIfSv3Jtg+Er9K6poAKyviDUiN04W
         1hWq1OZzKj8LxdrbtOSa7NUcfWarIGbT1HhGo3kvflAMvojyu2Epi3WwV9+WfA9J93Rg
         FmUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711617807; x=1712222607;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4fIcsg8gcugtMmlVw+LmPC2bgw0Si2DZI0WsD/Dma5Q=;
        b=KuPNNC81SnyrDI7Y+ywtWGtcAB3+r7QhZ/+/vZc3xVNAvMnxu20yfT0YrmlnNFdm5J
         /f3zWCfZadPKAeFyknfVRMkt8tWFPDORatRJxYvUJXfVEIx3HOZ8dqiwayOGr65akOGV
         Hp6dmPUtlMxEXnzMTWNH8/WbBSELJPeK6CLbELFcYvBEenYbVR8XFhi8HZ5bzig8rusQ
         SKdRnWl3go7OOShi0Xa0IMj062kw4jKli2aC4HkSXBrI2Gkd/WKkMADaANjZ7ecrYPw1
         6n/vAyPE/AOk3h1opsL+zlzTA/s/AKYPe/N088Fomju2H7yuwmX5wyljewnensOkMc+4
         l7Sg==
X-Forwarded-Encrypted: i=1; AJvYcCVkwPPTh62ohdkN8mArXD5AbwbPArTarvXGtT4rIGeQDx152n38yEtKSsKSjgD5+6+EokoMDnR+t/nXoJijPuSLxr6xDqeP22CkzlQDB39OQ4xL0O/wPMzrv7m4yRzU0hIy5YLiXqjR
X-Gm-Message-State: AOJu0Yzr4j3QZV+yOdsSt7jSdLlKca7XNLHLf/FOrPf1GPELjfohfOeh
	v1Volf+Ze9QMK11Q8/E20B6EwXpJeOkXLaYyZ1pUPx2D3U6Ei8T7
X-Google-Smtp-Source: AGHT+IFZrXR3laMUTXAUaCNTQmsPgCkWeEvX2BaAsO9AeLFJaKEMFPnVJ7THgfa7l5KpqiINQd1SRA==
X-Received: by 2002:a50:d486:0:b0:56c:1ac8:65bc with SMTP id s6-20020a50d486000000b0056c1ac865bcmr1810570edi.36.1711617806536;
        Thu, 28 Mar 2024 02:23:26 -0700 (PDT)
Received: from [192.168.20.102] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.googlemail.com with ESMTPSA id cf2-20020a0564020b8200b0056b0af78d80sm609298edb.34.2024.03.28.02.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 02:23:26 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Thu, 28 Mar 2024 10:23:11 +0100
Subject: [PATCH v4 2/5] clk: qcom: apss-ipq-pll: move Huayra register map
 to 'clk_alpha_pll_regs'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-apss-ipq-pll-cleanup-v4-2-eddbf617f0c8@gmail.com>
References: <20240328-apss-ipq-pll-cleanup-v4-0-eddbf617f0c8@gmail.com>
In-Reply-To: <20240328-apss-ipq-pll-cleanup-v4-0-eddbf617f0c8@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.13.0

Move the locally defined Huayra register map to 'clk_alpha_pll_regs'
in order to allow using that by other drivers, like the clk-cbf-8996.

No functional changes.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
Changes in v4:
 - no changes
 - Link to v3: https://lore.kernel.org/r/20240326-apss-ipq-pll-cleanup-v3-2-15c4aeeb14ac@gmail.com

Changes in v3:
 - rebase on top of v6.9-rc1
 - add Reviewed-by tags from Dmitry and Konrad
 - Link to v2: https://lore.kernel.org/r/20240321-apss-ipq-pll-cleanup-v2-2-201f3cf79fd4@gmail.com

Changes in v2:
 - rework the patch as requested by Dmitry Baryshkov by moving the register
   map into clk-alpha-pll.c instead of keeping that locally
 - Link to v1: https://lore.kernel.org/r/20240318-apss-ipq-pll-cleanup-v1-2-52f795429d5d@gmail.com
---
 drivers/clk/qcom/apss-ipq-pll.c  | 20 +-------------------
 drivers/clk/qcom/clk-alpha-pll.c | 10 ++++++++++
 drivers/clk/qcom/clk-alpha-pll.h |  1 +
 3 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/clk/qcom/apss-ipq-pll.c b/drivers/clk/qcom/apss-ipq-pll.c
index ed3e6405f99c..8cf17374a2e2 100644
--- a/drivers/clk/qcom/apss-ipq-pll.c
+++ b/drivers/clk/qcom/apss-ipq-pll.c
@@ -8,27 +8,9 @@
 
 #include "clk-alpha-pll.h"
 
-/*
- * Even though APSS PLL type is of existing one (like Huayra), its offsets
- * are different from the one mentioned in the clk-alpha-pll.c, since the
- * PLL is specific to APSS, so lets the define the same.
- */
-static const u8 ipq_pll_offsets[][PLL_OFF_MAX_REGS] = {
-	[CLK_ALPHA_PLL_TYPE_HUAYRA] =  {
-		[PLL_OFF_L_VAL] = 0x08,
-		[PLL_OFF_ALPHA_VAL] = 0x10,
-		[PLL_OFF_USER_CTL] = 0x18,
-		[PLL_OFF_CONFIG_CTL] = 0x20,
-		[PLL_OFF_CONFIG_CTL_U] = 0x24,
-		[PLL_OFF_STATUS] = 0x28,
-		[PLL_OFF_TEST_CTL] = 0x30,
-		[PLL_OFF_TEST_CTL_U] = 0x34,
-	},
-};
-
 static struct clk_alpha_pll ipq_pll_huayra = {
 	.offset = 0x0,
-	.regs = ipq_pll_offsets[CLK_ALPHA_PLL_TYPE_HUAYRA],
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_HUAYRA_APSS],
 	.flags = SUPPORTS_DYNAMIC_UPDATE,
 	.clkr = {
 		.enable_reg = 0x0,
diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index 9dc886d2ef97..08a783b28241 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -83,6 +83,16 @@ const u8 clk_alpha_pll_regs[][PLL_OFF_MAX_REGS] = {
 		[PLL_OFF_TEST_CTL_U] = 0x20,
 		[PLL_OFF_STATUS] = 0x24,
 	},
+	[CLK_ALPHA_PLL_TYPE_HUAYRA_APSS] =  {
+		[PLL_OFF_L_VAL] = 0x08,
+		[PLL_OFF_ALPHA_VAL] = 0x10,
+		[PLL_OFF_USER_CTL] = 0x18,
+		[PLL_OFF_CONFIG_CTL] = 0x20,
+		[PLL_OFF_CONFIG_CTL_U] = 0x24,
+		[PLL_OFF_STATUS] = 0x28,
+		[PLL_OFF_TEST_CTL] = 0x30,
+		[PLL_OFF_TEST_CTL_U] = 0x34,
+	},
 	[CLK_ALPHA_PLL_TYPE_BRAMMO] =  {
 		[PLL_OFF_L_VAL] = 0x04,
 		[PLL_OFF_ALPHA_VAL] = 0x08,
diff --git a/drivers/clk/qcom/clk-alpha-pll.h b/drivers/clk/qcom/clk-alpha-pll.h
index fb6d50263bb9..c9457009be24 100644
--- a/drivers/clk/qcom/clk-alpha-pll.h
+++ b/drivers/clk/qcom/clk-alpha-pll.h
@@ -15,6 +15,7 @@
 enum {
 	CLK_ALPHA_PLL_TYPE_DEFAULT,
 	CLK_ALPHA_PLL_TYPE_HUAYRA,
+	CLK_ALPHA_PLL_TYPE_HUAYRA_APSS,
 	CLK_ALPHA_PLL_TYPE_BRAMMO,
 	CLK_ALPHA_PLL_TYPE_FABIA,
 	CLK_ALPHA_PLL_TYPE_TRION,

-- 
2.44.0


