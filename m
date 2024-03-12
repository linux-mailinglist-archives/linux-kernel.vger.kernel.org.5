Return-Path: <linux-kernel+bounces-99975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C64CA879018
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A6E01F2190D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 08:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B0078298;
	Tue, 12 Mar 2024 08:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b="OrLhFyCU"
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC4277F00;
	Tue, 12 Mar 2024 08:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.87.146.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710233550; cv=none; b=UR3Jqxzi2+quUj0dHgRPB4tO2kbT2x0mTchpXZx/SaukIrUbkpvx67NK09vd/dfbblnirzqLxfy5r1hEQ6Zj7RGzlqpELSY67YWdAmcl2tcO3W/Uhy7makY+gsvylYXvENc8kPqBEqNPVC8meKfsHmqUSSUFTjFS/+IvUyItQgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710233550; c=relaxed/simple;
	bh=NKm3cS5bpgt3v620fkcC0oV7ymGvQfMSuZxyekLTAqs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ct/vqraOVhx/SrjQ+x77S45AVM7jHbC14RdB7+WwMZlRnuvGf1zFViLKjmu0n/ig2gBCbfne7QpK6lwo+gZ3bzyANf4tcah7eO0XWB6wFG8Z/yWaSct8zg0XqhYEoUgQeG1e97MZK50Osh+ozIcxBA9mrINOu4C1E7uOoWkSgqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru; spf=pass smtp.mailfrom=trvn.ru; dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b=OrLhFyCU; arc=none smtp.client-ip=194.87.146.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trvn.ru
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by box.trvn.ru (Postfix) with ESMTPSA id 11915408C7;
	Tue, 12 Mar 2024 13:42:22 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
	t=1710232942; bh=NKm3cS5bpgt3v620fkcC0oV7ymGvQfMSuZxyekLTAqs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OrLhFyCUCUQFAF0NDKkDa28afp1DJHrcop0ljfQC0S62Krt+fWth7CsxzAY/tlmZb
	 tXC9OQUfv6GBhvi2N5HuDSwGvWMwwXbr23JYylWf5M3NHI+pZUiFhxHqQqJEz7rS2a
	 N0rVSdqFPFLzu20NWaQJrXRypafXoyVPVnvub48gd3Qwn1HY/PXjWNj06jD2ysBPSM
	 +hJpV1zTDPBiOtgQl7GX31aP1Mq7UdhsNlHP+keUwP4a122XHBnX60uW4ztbE8tINs
	 o1sC2nzXAfMZ5RVJWBYbfPIwv/rNDx5J3l/acPyrM1ajgTydXzCuh+DZYMI7HRE2ds
	 abbQminEAwfSA==
From: Nikita Travkin <nikita@trvn.ru>
Date: Tue, 12 Mar 2024 13:42:08 +0500
Subject: [PATCH v4 2/4] platform: Add ARM64 platform directory
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240312-aspire1-ec-v4-2-bd8e3eea212f@trvn.ru>
References: <20240312-aspire1-ec-v4-0-bd8e3eea212f@trvn.ru>
In-Reply-To: <20240312-aspire1-ec-v4-0-bd8e3eea212f@trvn.ru>
To: Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 Nikita Travkin <nikita@trvn.ru>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3772; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=NKm3cS5bpgt3v620fkcC0oV7ymGvQfMSuZxyekLTAqs=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBl8BVrHlfNUqhLjkcNvlxGQsNJ/hfLMgiR72zsI
 +9iGEtGvm6JAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZfAVawAKCRBDHOzuKBm/
 dV+jD/9VtorPvAP5xXp6LCei+KmEz14DPs2HebqDFnymKTLmnD52htYfPlKZVqQTU3TXPZZIpF2
 rN6o90GzPgu+KK0ZI7vYY0f+r8tyBJIkeZGNkBJuz+KSgz7ZoLxsUa/coMA4ZFfRIjgunq2zXG5
 4+YeIJ2M6qvt5/gWw/rrwGiT4vahkNrPCO7iBPU2S1ZRhUgIEfIMROfVz5APqeRX2MH5f5OC476
 G7nrhXfiuoWjn8uMGVwN4e7dUCe3E8LkhqNegL7QvLRqAv/6pSHK5Yo5vQ3BIaaoBqDUkAStQgu
 hfTwoNGONlMe4jjkhJUoc4OnNQ2uMuM2XAiHZz+1NtD/is98dvPcY7SOEOU0jN6tks9gAdkMZwK
 QbwnnGRqVFfQ+Sqeww9Ycb06W63OC0xm3iOUDlC7eXlbQLcfm79V81RahUrUpHgF8JfGVkr+JMV
 tf7LJ/5VlC0h6Dnr71sIoP6YUP4UnJaD1wq/o/ac4GrxNlncfUwiAf71nvL9ZTAvTM0DHqN9MKh
 FyK8F2G78e1Yf2GTw1O5c8Pn0Nuk+yfK3DsXFEpJuQkvKd+8KxzExA70yc9XNY5ZxhOARUt3k4L
 SNFVfM8FyTN0ouHTcdXT3i+enp1hqrhJiR5Y1ilf/Z/M6Jpt2eWUXygjsXgYD8i/PhvUj3wKQbi
 65Y0IVprRNPLYNA==
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
Hans de Goede and Mark Gross).

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 MAINTAINERS                     |  9 +++++++++
 drivers/platform/Kconfig        |  2 ++
 drivers/platform/Makefile       |  1 +
 drivers/platform/arm64/Kconfig  | 19 +++++++++++++++++++
 drivers/platform/arm64/Makefile |  6 ++++++
 5 files changed, 37 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b43102ca365d..ec8d706a99aa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3050,6 +3050,15 @@ F:	drivers/mmc/host/sdhci-of-arasan.c
 N:	zynq
 N:	xilinx
 
+ARM64 PLATFORM DRIVERS
+M:	Hans de Goede <hdegoede@redhat.com>
+M:	Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
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
2.43.2


