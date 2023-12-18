Return-Path: <linux-kernel+bounces-3412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D900816BF1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4253C284307
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8DB1C2B2;
	Mon, 18 Dec 2023 11:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gaNksvEp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE31C1B28E;
	Mon, 18 Dec 2023 11:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a236ade46e7so6125266b.2;
        Mon, 18 Dec 2023 03:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702897631; x=1703502431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lerjiFsv40IIbLDp1yKfCOrHgxz1kvFlDa/xJlfcdo0=;
        b=gaNksvEpnyqzbghpic1iMVz7pOQ3JyxURSYeA14gLobNA5tkvFMTt9VVuImOTBiy/n
         GOXy9AyAjaTGq7tPJTdrdwth3IsKIQ21xqVK51ThPJsgaUcPrqOV9gXaRkW3jJTViA3L
         BPWc3KwqtLMxUK9ZvW4iFjdAxMKZde07l4b41bGTEiHSzD63DpJy2rea3YPzpp9inuxs
         lE+tnnWumNGgVN7Xk5hBIcRQm/nFDXPQRHzYQpZ0pQ6oiDoTalngD5kKnkw8LJjp5I9S
         f/d9baHWv484rPLyKmPN1FfB2Ud/2Z2Ewscnu98Z7nJNjFtAlxWPEGVyXoEmrf/V3Im6
         FVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702897631; x=1703502431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lerjiFsv40IIbLDp1yKfCOrHgxz1kvFlDa/xJlfcdo0=;
        b=aUV5MVaTBC4WpmvcsE3hyeRJbepx5HVZomaQMjMTRur5F85lrNHxRDnY7cZIrlRBOr
         ZVGZX1R4jPRu21bWh1fRlY7JHrVk5UXDNVNuYAVPNXCfbVZ2uZ0p7UK+9xbhud0Fczqy
         mAvxv9Uu5h9y/xJo0GVQTu8aTC1cL+F0RKx+6WngvIZwbDCHytp8auIBjVrFAhGJLZOu
         A1WcFG8u40QRIGBL76IjdO7Kl4NeSWXPofJyrhItWLJ/GGDBEIH5WkdyWDA8PWWVclCA
         zuTIsxSEXT2Z+LtIZY/MjJvCuyGePZKanbvbXIiJWL9Eq4xz6QYWYwsPwZxjbj+ARX/b
         Tkag==
X-Gm-Message-State: AOJu0YyJZYMxoG8WoR82b07p1VW7ys/gBvIkfblYQKl2H8c8k+0qQJvX
	VeSxl3VfaM8GiP37mVXQw0w=
X-Google-Smtp-Source: AGHT+IGQMtd6fso8NFusjQjFPqt6Spt8yZ8CBjuG18cqbhcpV/I/x5LWeBsLrRHnA3YL1WPAg7whNQ==
X-Received: by 2002:a17:906:11cd:b0:a23:365d:fc74 with SMTP id o13-20020a17090611cd00b00a23365dfc74mr870108eja.125.1702897630746;
        Mon, 18 Dec 2023 03:07:10 -0800 (PST)
Received: from localhost.localdomain ([154.72.163.164])
        by smtp.gmail.com with ESMTPSA id pj4-20020a170906d78400b00a2353af1f7bsm1406769ejb.92.2023.12.18.03.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 03:07:10 -0800 (PST)
From: Brandon Cheo Fusi <fusibrandon13@gmail.com>
To: Yangtao Li <tiny.windzz@gmail.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Maxime Ripard <mripard@kernel.org>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Brandon Cheo Fusi <fusibrandon13@gmail.com>
Subject: [PATCH v2 5/5] cpufreq: Make sun50i h6 cpufreq Kconfig option arch generic
Date: Mon, 18 Dec 2023 12:05:43 +0100
Message-Id: <20231218110543.64044-6-fusibrandon13@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231218110543.64044-1-fusibrandon13@gmail.com>
References: <20231218110543.64044-1-fusibrandon13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the Allwinner SUN50I cpufreq driver from Kconfig.arm to the
main Kconfig file so it supports other architectures, like RISC-V
in our case, and drop the 'ARM_' prefix.

Signed-off-by: Brandon Cheo Fusi <fusibrandon13@gmail.com>
---
 drivers/cpufreq/Kconfig     | 12 ++++++++++++
 drivers/cpufreq/Kconfig.arm | 12 ------------
 drivers/cpufreq/Makefile    |  2 +-
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index 35efb53d5..50aa66cfc 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -301,5 +301,17 @@ config QORIQ_CPUFREQ
 	  This adds the CPUFreq driver support for Freescale QorIQ SoCs
 	  which are capable of changing the CPU's frequency dynamically.
 
+config ALLWINNER_SUN50I_CPUFREQ_NVMEM
+	tristate "Allwinner nvmem based SUN50I CPUFreq driver"
+	depends on ARCH_SUNXI
+	depends on NVMEM_SUNXI_SID
+	select PM_OPP
+	help
+	  This adds the nvmem based CPUFreq driver for Allwinner
+	  h6/D1 SoCs.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called sun50i-cpufreq-nvmem.
+
 endif
 endmenu
diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index f91160689..98b8e6eef 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -29,18 +29,6 @@ config ACPI_CPPC_CPUFREQ_FIE
 
 	  If in doubt, say N.
 
-config ARM_ALLWINNER_SUN50I_CPUFREQ_NVMEM
-	tristate "Allwinner nvmem based SUN50I CPUFreq driver"
-	depends on ARCH_SUNXI
-	depends on NVMEM_SUNXI_SID
-	select PM_OPP
-	help
-	  This adds the nvmem based CPUFreq driver for Allwinner
-	  h6 SoC.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called sun50i-cpufreq-nvmem.
-
 config ARM_APPLE_SOC_CPUFREQ
 	tristate "Apple Silicon SoC CPUFreq support"
 	depends on ARCH_APPLE || (COMPILE_TEST && 64BIT)
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 8d141c71b..110b676d2 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -78,7 +78,7 @@ obj-$(CONFIG_ARM_SCMI_CPUFREQ)		+= scmi-cpufreq.o
 obj-$(CONFIG_ARM_SCPI_CPUFREQ)		+= scpi-cpufreq.o
 obj-$(CONFIG_ARM_SPEAR_CPUFREQ)		+= spear-cpufreq.o
 obj-$(CONFIG_ARM_STI_CPUFREQ)		+= sti-cpufreq.o
-obj-$(CONFIG_ARM_ALLWINNER_SUN50I_CPUFREQ_NVMEM) += sun50i-cpufreq-nvmem.o
+obj-$(CONFIG_ALLWINNER_SUN50I_CPUFREQ_NVMEM) += sun50i-cpufreq-nvmem.o
 obj-$(CONFIG_ARM_TEGRA20_CPUFREQ)	+= tegra20-cpufreq.o
 obj-$(CONFIG_ARM_TEGRA124_CPUFREQ)	+= tegra124-cpufreq.o
 obj-$(CONFIG_ARM_TEGRA186_CPUFREQ)	+= tegra186-cpufreq.o
-- 
2.30.2


