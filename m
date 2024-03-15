Return-Path: <linux-kernel+bounces-104468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F93B87CE59
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 14:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FBA71F2213D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 13:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBF53838C;
	Fri, 15 Mar 2024 13:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b="VMsQ+k1v"
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1382CCAD;
	Fri, 15 Mar 2024 13:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.87.146.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710510718; cv=none; b=QCu7/SbTZ0o9jNFQMr4h0yP21duPkxywui9e8Uah6Fi6RZW7UWas8gBlmIMgYWDmyQuEfQPbsKnDegsVpLqgik8vauzvEUCOytKFspwfvOEk5uFc1oF2hlH67Gy1OqAVyQ33aviygDxWTdHMCXNSXtdJGL10OSu9EdBvHYbCYyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710510718; c=relaxed/simple;
	bh=JrN770EdBryMxnh0Oh99guIP9VQQameiq0rHefV8pac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DyN7+c6m2cCUv4qBFL4tQFwP9PSN6nTdLgkqaq5AHeebN//TJc/NgvHFoqRR7Oe2FiEcFAMC1lAwBEJVECCRPhbIS8NaA7AGRX0RKbtHPMP4gn5YHYm7SjnmVOAFI9VnRc+db8/Z83ThMT7SDvjgmr1Q7p6gmrJe8+SV2PI9rW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru; spf=pass smtp.mailfrom=trvn.ru; dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b=VMsQ+k1v; arc=none smtp.client-ip=194.87.146.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trvn.ru
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by box.trvn.ru (Postfix) with ESMTPSA id E1B7F41EF2;
	Fri, 15 Mar 2024 18:51:36 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
	t=1710510697; bh=JrN770EdBryMxnh0Oh99guIP9VQQameiq0rHefV8pac=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VMsQ+k1vmGItKQ5U6NmGqU2qDSQIF0phX2FNowWTobMMazdW9FkciUuNHGIKxRg/G
	 fXihIuE0CBY1G/Q+FnpohDUeFBQlbm2FGpWfzI5IrQDimhujpnO4KDQQkC8v4pXcRh
	 HEjWwxgwqfWzAenyuhBLK6SaKXJblDuJg0E/3K4NE0Eo9yfxrIICmeANy7pKFK3ZWu
	 pK8R9bR3iW42dG7Z9RAXRU//1x0JUqKZ2XwrYBDP/DRM4GBbhs+VxKCMxXufyHyYIT
	 1gjxrqOZqo7o3gI4K1M8tmpLD1gDTfAyyKVd6EZoS2+WMC1jFid1pJKM67QYJT8VXF
	 OMDtcJt25uHmQ==
From: Nikita Travkin <nikita@trvn.ru>
Date: Fri, 15 Mar 2024 18:51:16 +0500
Subject: [PATCH v5 2/4] platform: Add ARM64 platform directory
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240315-aspire1-ec-v5-2-f93381deff39@trvn.ru>
References: <20240315-aspire1-ec-v5-0-f93381deff39@trvn.ru>
In-Reply-To: <20240315-aspire1-ec-v5-0-f93381deff39@trvn.ru>
To: Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 Nikita Travkin <nikita@trvn.ru>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3905; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=JrN770EdBryMxnh0Oh99guIP9VQQameiq0rHefV8pac=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBl9FJmunF3ZxQvDUhdFk9TYCpzrVtq7859rIaxQ
 GwZk1aqj/2JAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZfRSZgAKCRBDHOzuKBm/
 daiQEACNmmQYzv5oErLKVrAkzVYSfPoM5fJvDuVkkKvxaZA/sOhyjGdkLbuMn1lya8NRzfRWtvC
 6OgqWbY8L2lhqmd+N78tzmB6jl22BorP1PSKz/5jscOJiCT3sMuMFHOgwumPEYxqL6Jv22xVXIE
 MD1Fyy7wYDi04qRoo87GEisXIukrvrw1y0XoOBAKDxAnl53r2/ga+slmjYqQJQ8gRcVIJkXtlpf
 kvx69Ruje0wrQTlFukRyAiDw67UoUno8Tdp2Oqp4SRVb+TJB1t4G9y+WVS3wbrxXK0aDxYrypjZ
 20khUkQnE3lFCB/GZTOb/ms90TA7RXwt4ZdxdioS6b6oAJP+EZH/fB+iu/GqVdu6PUfCN8BoI1I
 vXLd5+DQaO2Qrz3TtHe5jARrI2GE4NM4Mm68APwCpjDiG9kcUhkmdLHJacdJhqLXjYll2Jlilzg
 RzJjKjPNwBfgNd5gvwoFo6S9zKxvcGzdkngc2c+BGk8bVtPXF2BEI1MEtT3sov0x59AiWdcMB6X
 3WR1W0bTwHAAvV5a/ievw6612IqKZE1g4G9YaDpB07JQ6vA4zNitJ+NG4W7va2Q2aKq5IFa0AIG
 gXMTfLtlHSvsE80TfLi3m759tkEZgYIspjvX/mzTKo1hnPSKjH6mC/VUfq8gq1SX8rS4DBKnysQ
 ILD2vTNsuJffK7A==
X-Developer-Key: i=nikita@trvn.ru; a=openpgp;
 fpr=C084AF54523FAA837E2EC547431CECEE2819BF75

Some ARM64 based laptops and computers require vendor/board specific
drivers for their embedded controllers. Even though usually the most
important functionality of those devices is implemented inside ACPI,
unfortunately Linux doesn't currently have great support for ACPI on
platforms like Qualcomm Snapdragon that are used in most ARM64 laptops
today. Instead Linux relies on Device Tree for Qualcomm based devices
and it's significantly easier to reimplement the EC functionality in
a dedicated driver than to make use of ACPI code.

This commit introduces a new platform/arm64 subdirectory to give a
place to such drivers for EC-like devices.

A new MAINTAINERS entry is added for this directory. Patches to files in
this directory will be taken up by the platform-drivers-x86 team (i.e.
Hans de Goede and Ilpo Järvinen) with additional review from Bryan
O'Donoghue to represent ARM64 maintainers.

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 MAINTAINERS                     | 10 ++++++++++
 drivers/platform/Kconfig        |  2 ++
 drivers/platform/Makefile       |  1 +
 drivers/platform/arm64/Kconfig  | 19 +++++++++++++++++++
 drivers/platform/arm64/Makefile |  6 ++++++
 5 files changed, 38 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 76b3714710c2..186338451099 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3050,6 +3050,16 @@ F:	drivers/mmc/host/sdhci-of-arasan.c
 N:	zynq
 N:	xilinx
 
+ARM64 PLATFORM DRIVERS
+M:	Hans de Goede <hdegoede@redhat.com>
+M:	Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
+R:	Bryan O'Donoghue <bryan.odonoghue@linaro.org>
+L:	platform-driver-x86@vger.kernel.org
+S:	Maintained
+Q:	https://patchwork.kernel.org/project/platform-driver-x86/list/
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git
+F:	drivers/platform/arm64/
+
 ARM64 PORT (AARCH64 ARCHITECTURE)
 M:	Catalin Marinas <catalin.marinas@arm.com>
 M:	Will Deacon <will@kernel.org>
diff --git a/drivers/platform/Kconfig b/drivers/platform/Kconfig
index 868b20361769..81a298517df2 100644
--- a/drivers/platform/Kconfig
+++ b/drivers/platform/Kconfig
@@ -14,3 +14,5 @@ source "drivers/platform/olpc/Kconfig"
 source "drivers/platform/surface/Kconfig"
 
 source "drivers/platform/x86/Kconfig"
+
+source "drivers/platform/arm64/Kconfig"
diff --git a/drivers/platform/Makefile b/drivers/platform/Makefile
index 41640172975a..fbbe4f77aa5d 100644
--- a/drivers/platform/Makefile
+++ b/drivers/platform/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_OLPC_EC)		+= olpc/
 obj-$(CONFIG_GOLDFISH)		+= goldfish/
 obj-$(CONFIG_CHROME_PLATFORMS)	+= chrome/
 obj-$(CONFIG_SURFACE_PLATFORMS)	+= surface/
+obj-$(CONFIG_ARM64)		+= arm64/
diff --git a/drivers/platform/arm64/Kconfig b/drivers/platform/arm64/Kconfig
new file mode 100644
index 000000000000..644b83ede093
--- /dev/null
+++ b/drivers/platform/arm64/Kconfig
@@ -0,0 +1,19 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# EC-like Drivers for aarch64 based devices.
+#
+
+menuconfig ARM64_PLATFORM_DEVICES
+	bool "ARM64 Platform-Specific Device Drivers"
+	depends on ARM64 || COMPILE_TEST
+	default y
+	help
+	  Say Y here to get to see options for platform-specific device drivers
+	  for arm64 based devices, primarily EC-like device drivers.
+	  This option alone does not add any kernel code.
+
+	  If you say N, all options in this submenu will be skipped and disabled.
+
+if ARM64_PLATFORM_DEVICES
+
+endif # ARM64_PLATFORM_DEVICES
diff --git a/drivers/platform/arm64/Makefile b/drivers/platform/arm64/Makefile
new file mode 100644
index 000000000000..f91cdc7155e2
--- /dev/null
+++ b/drivers/platform/arm64/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for linux/drivers/platform/arm64
+#
+# This dir should only include drivers for EC-like devices.
+#

-- 
2.44.0


