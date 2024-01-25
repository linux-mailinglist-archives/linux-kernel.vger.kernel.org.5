Return-Path: <linux-kernel+bounces-37997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D485683B973
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 07:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EC47286D72
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 06:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF22110A11;
	Thu, 25 Jan 2024 06:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/U4Nsdt"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A31101CE;
	Thu, 25 Jan 2024 06:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706163086; cv=none; b=I6yCqPY21ecGbrhPuRkEEWLZi2am71GNCRZL4w5uNdopoB8GiPlU4v/FI/GQMcMgpWvc1GqF2s29TM89nriXmJcwjgyjAyc8Pm499fb6ghOWgqquq0gX+m3qxSo82cpEXUTfSOSpQ8UmcuxAS1HVb0mpFO+1jz6BtdXHpP4wwkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706163086; c=relaxed/simple;
	bh=jJupIHqrOnPdDff8QmxFswf2LMMVUpq/tkO/ho9VH/U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q6fqar9jBF+FeG3ZfRqs81ZbqFAFSydoOJU6LFL36WPhpYXOqmVjshBh5m1KZ5KaQwam71JipdnMJx8AZxfmqX3ND9ZR3oFPZfCHeDxlFYTV2Bzj7kkwHj9SvVRulbh3l7qvwszF0J4N5G8mxAmvRLw4cHvJFHIDYTJY+oOsz2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i/U4Nsdt; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-214917ed35aso1284335fac.2;
        Wed, 24 Jan 2024 22:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706163084; x=1706767884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s517sYCaoEVuNYB9syue5DUwwMbcTuE6IgQKf5uVU5s=;
        b=i/U4Nsdtn5YbNNEMPmMXSxuUQqI5tPS2K7DQGDYx0e1g80PwMPenYAN4m2X5s4cN/h
         JG3uaromRz9MkvSYm6aoH+SFSz+vdQGczr0lpMz2O8wdoIAVYPaEI+LlNjVrmHntehKN
         wbXYA9yiYXwjjSeWmFWwHKhk834h7tJlQd76PEajT/k5nFTOV1yW3aIt0JbEBSgKW0O1
         PoeU0WZ9I86ANfnXBuCTJSuJM8CqXshtDDsLfJ5vUqw5mb2FPbimcGHPh6lSOysV0rOM
         bbyalI4UsgXrb3P6qX+4aV5VhQCqESIf7yASCvrpkvZKz9j+7ldPYQa6TVvZgNKS9djK
         Ylyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706163084; x=1706767884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s517sYCaoEVuNYB9syue5DUwwMbcTuE6IgQKf5uVU5s=;
        b=pmNg6JAPdHUtHghxJ/8zL049UCnHARV/C86D/opXZeiHLVfiIgd9Esrcs2nRX+Ll+0
         1mY1H4ZCL4eAuf8Z8pNnIpWO/ad569XLgv82bceZbrzjO2KZk40U+CqB3xVZsPVUW7S+
         XCzwUDqzIETxI08+bhQCMoK1SWfw+G32aNyg959jdHYc8fsl9l3y0Ph99l3loEBD5j9v
         YUMtE6f3fTZ1FkJPRGLS2sf0ex8BcVqBBs06oqsm0aunTRvT5PTQOyMWYnQ34Jf4Eaj3
         hF6qdfkuS5NpUs+edr/XRyxhUwcZ/ltYR4VUSqayvVII6hFwnK1/sKbQDcQHP8p3/P2F
         Zy4g==
X-Gm-Message-State: AOJu0Yy35aFlH/Sr4XDQtT4BqkwDqcEunR4DeRvOhpVUUOH6ukbRG+Gv
	zw6YvsnoqLiJvefq6+Yf+Ogw3SE5YkDhyjr/5Yf4BdNr6WnpVm5F
X-Google-Smtp-Source: AGHT+IEQ9QanoWE9WjkHB5disI5RqKPULpsFY5mHnV3nVO8tLPap+XHggGE5/ZXYYkVX3otzhrBTDQ==
X-Received: by 2002:a05:6870:c0ce:b0:1fb:165c:473a with SMTP id e14-20020a056870c0ce00b001fb165c473amr524241oad.57.1706163084004;
        Wed, 24 Jan 2024 22:11:24 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id o6-20020a9d5c06000000b006dbffa39d39sm2910066otk.55.2024.01.24.22.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 22:11:23 -0800 (PST)
From: Chen Wang <unicornxw@gmail.com>
To: aou@eecs.berkeley.edu,
	chao.wei@sophgo.com,
	conor@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	p.zabel@pengutronix.de,
	robh+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	haijiao.liu@sophgo.com,
	xiaoguang.xing@sophgo.com,
	guoren@kernel.org,
	jszhang@kernel.org,
	inochiama@outlook.com
Cc: Chen Wang <unicorn_wang@outlook.com>
Subject: [PATCH v2 2/4] reset: sophgo: add SG2042 reset generator driver
Date: Thu, 25 Jan 2024 14:11:14 +0800
Message-Id: <34650036ea5f1c500da54c67c3a67b91c4419399.1706161530.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1706161530.git.unicorn_wang@outlook.com>
References: <cover.1706161530.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

Reuse reset-simple driver for the Sophgo SG2042 reset generator.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 drivers/reset/Kconfig        |  1 +
 drivers/reset/reset-simple.c |  2 ++
 drivers/reset/sophgo/Kconfig | 10 ++++++++++
 3 files changed, 13 insertions(+)
 create mode 100644 drivers/reset/sophgo/Kconfig

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index ccd59ddd7610..09ba59cc4bc5 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -318,6 +318,7 @@ config RESET_ZYNQ
 	help
 	  This enables the reset controller driver for Xilinx Zynq SoCs.
 
+source "drivers/reset/sophgo/Kconfig"
 source "drivers/reset/starfive/Kconfig"
 source "drivers/reset/sti/Kconfig"
 source "drivers/reset/hisilicon/Kconfig"
diff --git a/drivers/reset/reset-simple.c b/drivers/reset/reset-simple.c
index 818cabcc9fb7..276067839830 100644
--- a/drivers/reset/reset-simple.c
+++ b/drivers/reset/reset-simple.c
@@ -151,6 +151,8 @@ static const struct of_device_id reset_simple_dt_ids[] = {
 	{ .compatible = "snps,dw-high-reset" },
 	{ .compatible = "snps,dw-low-reset",
 		.data = &reset_simple_active_low },
+	{ .compatible = "sophgo,sg2042-reset",
+		.data = &reset_simple_active_low },
 	{ /* sentinel */ },
 };
 
diff --git a/drivers/reset/sophgo/Kconfig b/drivers/reset/sophgo/Kconfig
new file mode 100644
index 000000000000..9ad96e49e1dd
--- /dev/null
+++ b/drivers/reset/sophgo/Kconfig
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config RESET_SOPHGO_SG2042
+	bool "Sophgo SG2042 Reset Driver"
+	depends on ARCH_SOPHGO || COMPILE_TEST
+	select RESET_SIMPLE
+	default ARCH_SOPHGO
+	help
+	  This enables the reset controller driver for the Sophgo SG2042 SoC.
+
-- 
2.25.1


