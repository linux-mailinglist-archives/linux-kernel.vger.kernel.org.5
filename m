Return-Path: <linux-kernel+bounces-119019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B428C88C2BF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 399EE1F6276A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E2774BF8;
	Tue, 26 Mar 2024 12:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThsOq3r7"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C136FE2B;
	Tue, 26 Mar 2024 12:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711457872; cv=none; b=IFfc+AOGD/LctgjtdTm2iPnRl7KcbQqiJdbTuFi43YVXCnJx9dW/2NortuMj7kkM6hIJfcrpkm/wPaahUwBTyLe25cdloT17pHeqcgpPVI426sNCYqS55vM0rDVumctl7aXjCgJqouwzio0fs9h+832To2mH4u2NMl3NsPlFlbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711457872; c=relaxed/simple;
	bh=VVfKZNtCb9V4D5d2R27uiLVNnuWqBQo/x6JP2e61reo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cs+tsGoT26wdQ/rXyJLmaiJ87eKrZklAyvel0xhafuEg6zbx4FDk9NtZQAUnXWo+QE39KCA1yNOkAYOiwEuzwkv9yQNfhdZmz07+5JZWDh6fiyFzOQOe+fwypgKEhs1sf8dvWRc49xDXfIhuQ8JjI2Hd72HaJJ3PNWDgcGG8xsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ThsOq3r7; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56899d9bf52so6930877a12.2;
        Tue, 26 Mar 2024 05:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711457868; x=1712062668; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DhjVIBYXgilrvF2jB9Ugd2HXeJdQ/8B8gpJLX/y89mM=;
        b=ThsOq3r72Nck57DCpYFeWo94+ZPEWn3GE/U841/90Sg20EiPy3dOGDA6K8j0r5FBb5
         RQG82nBxhrc6045k2e97HAqy6DU2T7ebZLeMNYWyqrWvhVnB6ZJ3Sa28OISnOiro7EFA
         BDhLhrW8Rxh2S0HQ0FyeaBZJcJsGtdsh8yLozZmmDic07Ls/92/O33knuRWBPZAjObNZ
         luHObMemSqIfn7p/op2+MhSLCzV3KeIs/MwoZHv8l27j/fnvZo8MzTuZBB4cJLQcN57N
         I2k50ZFIRSAsVmYpRIXRcRZifUeiWtelMQHO6aKvOXykw/p36FkvFx/0YDVpJe4VOZLB
         C79A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711457868; x=1712062668;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DhjVIBYXgilrvF2jB9Ugd2HXeJdQ/8B8gpJLX/y89mM=;
        b=xTTtvPXdsXMADpCWHFWua2S3GxcyxtAdcVS1NR6DRJaMGVO/FImryd01T85gfQw5Q2
         D+m98sxi+qW3NhPYaL1RsuyR1TW2+w9dZsQj/OzXRHjphe0VNcqQyJSP7gvE8sY7FPeG
         R1yPxTxyAcdoYclg7at2xcuzGuUoVSjrrRi5YzNrzjlU6vnrTef+JeFcne/jx9+t8/6s
         qLmfB8ftovBkiu1Kg3hZoGl1OIuauVmfWh4PfuoDTjAc8ztVgS7qdyWUQD3jhpixHb4m
         s2eu328am/XxQTB43BJVUjtsxfqNPVJXcGnhoVOi8PkrcZyMeF42uAdMCC0pPHdFpjb0
         Xsvw==
X-Forwarded-Encrypted: i=1; AJvYcCUyYM/HyhNoQk2UJSeCHfOg6WmG4KoIwdHAlpzWaZYTJUTEc0RxbIwq7cjx4BYkFktJHZKuvOmMQLacHPLtUHnZL7pyjRTjdOQEjaRJV2ObeTZnZak2kILRXvjpydhVsDVGkq7zuLd5
X-Gm-Message-State: AOJu0YxIw+JGjuaSFriAITAUzz+UNpGh7f2H7iFZ/i7DXZ8GZ/3KLGHA
	TrGAdD80GCHsiMOc/JYxi0Y+ZgW9cTNteqMlJrwXWnU6nbDVnDRwym94nqyx
X-Google-Smtp-Source: AGHT+IHRUIEuQKsZyqqkvfv5b9zL9PWL1x0GvFX0rhOSPMwaem2w5LAf4k8+suZpWfZ1MlQmSPmvKQ==
X-Received: by 2002:a50:d608:0:b0:568:c621:c496 with SMTP id x8-20020a50d608000000b00568c621c496mr6713775edi.42.1711457868190;
        Tue, 26 Mar 2024 05:57:48 -0700 (PDT)
Received: from [192.168.1.253] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.googlemail.com with ESMTPSA id n1-20020aa7c781000000b0056bb65f4a1esm4101413eds.94.2024.03.26.05.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 05:57:47 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Tue, 26 Mar 2024 13:57:39 +0100
Subject: [PATCH v3 2/5] clk: qcom: apss-ipq-pll: move Huayra register map
 to 'clk_alpha_pll_regs'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-apss-ipq-pll-cleanup-v3-2-15c4aeeb14ac@gmail.com>
References: <20240326-apss-ipq-pll-cleanup-v3-0-15c4aeeb14ac@gmail.com>
In-Reply-To: <20240326-apss-ipq-pll-cleanup-v3-0-15c4aeeb14ac@gmail.com>
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
index ed3e6405f99cb..8cf17374a2e2a 100644
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
index 9dc886d2ef978..08a783b28241f 100644
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
index fb6d50263bb9d..c9457009be24f 100644
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


