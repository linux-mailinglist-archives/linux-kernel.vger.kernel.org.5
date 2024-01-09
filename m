Return-Path: <linux-kernel+bounces-20641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF288282D7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 10:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A77101C23E42
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FEB2E636;
	Tue,  9 Jan 2024 09:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HiF51jzn"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CD932C63;
	Tue,  9 Jan 2024 09:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3bbbf5a59b7so2503769b6e.3;
        Tue, 09 Jan 2024 01:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704791844; x=1705396644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aWGh9TyULl5axYB+y4TjSKeR1pcTY+hQLJUbaZKUyYM=;
        b=HiF51jznc9NSNV0q/6NkKsvjyj+wwcomj/A+bXkQFSNydKRMfilsPErMy+96qxMlLU
         SBI2g4PskJimlX+xcvQrrDQx4U02rdMAhsAj4p6qZxBdPcCsE2VqjGMHp1AVExhdiHjP
         +uNBgtqNlMl8Xed7pmAELSShOBslAN8wfJZ2IyIL6yPPnJNnvRPQMk+uerICILra1nzV
         OTq2MtjwhzYDE7ZpRGXD2V/f1H7EvwpFaoCIs7+gtQ16s7Dol5kEQYXHw6wmNanHlFCc
         dZssazuBqkhd4xN5wBkBOJYFTxy69XulyJXRZ9niN3Ma02DWbrQqDmpOfoD0iSp/TphV
         sccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704791844; x=1705396644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aWGh9TyULl5axYB+y4TjSKeR1pcTY+hQLJUbaZKUyYM=;
        b=gooakEFkaifFs2CzYWJpTEwpned+qMmVZVgbIzw1kBGHYUzarkgnu8luptWFrBj0kP
         HVIs5S16EWr/SCPCS50cBjom3+ZFiBgks5zvo8/9bL4rsYtNsB2NPxXFlbNQ8HkhOhRR
         wjEWemzXnEvCjHf8owwl1ulCHWsL/7ioPSknNabCthZ6iobNLUe+7eVQwebf/L7bL9wj
         9W+dvRJb0nx8l4GLal+W7QTerI5Bf6MIn6udA+QggkXmmhv22KNARLA/U3TfuaCcgRxp
         Bo+6bjWeTIdLvbc1xh84fvInaDsgqijWx2I4y4EW6/YQ8hEvYaRu+kgr3GNcqANe0SKD
         9/Cw==
X-Gm-Message-State: AOJu0YxUY24s6qyTcA5Y27ujA2/9yIvADZFuE7s0k/nAh7gkVy/IjYza
	deGXj7DhFyRkahxuAPvPuMlsdczZZ/g=
X-Google-Smtp-Source: AGHT+IFKxoZ8douUKwO8MFgZ99uh8kdpDWRiWeKVgDWpGH6Bgdpj0FIy2C86fhkHBmvt++YSJBspxA==
X-Received: by 2002:a05:6871:3a26:b0:1fb:17cc:1786 with SMTP id pu38-20020a0568713a2600b001fb17cc1786mr6467549oac.4.1704791844714;
        Tue, 09 Jan 2024 01:17:24 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id o22-20020a9d5c16000000b006dc0802ddf5sm305361otk.5.2024.01.09.01.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 01:17:24 -0800 (PST)
From: Chen Wang <unicornxw@gmail.com>
To: aou@eecs.berkeley.edu,
	chao.wei@sophgo.com,
	conor@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
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
Subject: [PATCH 2/4] reset: sophgo: add SG2042 reset generator driver
Date: Tue,  9 Jan 2024 17:17:15 +0800
Message-Id: <06e493ad0d64c1ba5c5897eb452ff04095f05e7a.1704790558.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1704790558.git.unicorn_wang@outlook.com>
References: <cover.1704790558.git.unicorn_wang@outlook.com>
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
index 7ea5adbf2097..69b631eb8127 100644
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


