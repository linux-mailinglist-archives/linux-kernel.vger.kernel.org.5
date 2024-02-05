Return-Path: <linux-kernel+bounces-52932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 242F0849E86
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D369B28CF8E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB0E481AF;
	Mon,  5 Feb 2024 15:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fQsDjQt5"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4144E44C6C;
	Mon,  5 Feb 2024 15:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707147320; cv=none; b=ftFCLXQGN5yTVddGjtwYU1TsYeDkn/31n1w812+OeTAhP5PLDTBYTiUN16fUrypyBHwWeAZBdkhMiH85GOaD28rZ2vpERnjLVkjO3pzximG3etIaxAOrTpzUTMDZjhBIzlfsaCyb5ZFwJHk0ypUwUH43d8LTRopg/FFwKw0PPO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707147320; c=relaxed/simple;
	bh=OJMjQNuB0qxgKO2LYN0rXZkkE3imz1k4MttK5ciBgZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q0eRpwYahYeCeVAOgzYU4IY8twPW29D6CYjTrzPWXRmaLTkx417hdKYQrSCFbJg0m9t7skl+e2ysXrCpwNt2M0sYQ+cbw4hux5mlzMnYzuNDQcORr45oJrKlTcWf/AhPICDgm3Zomtt4jMJUx2xnXoYvPYJmMfzNSnb2XWDxv44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fQsDjQt5; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CDB3E240006;
	Mon,  5 Feb 2024 15:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707147316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KDGmhKsrXnlDJMy644fDIA2mW0aZ/el8TnwmSRWTTPU=;
	b=fQsDjQt5kfBRVdMLEgG+6GBxH3N0LCBXcX31QFWPxqXoMDUcGlP/Hxl3DNVSJ5F7qpGUxB
	6DmFi6EJ9FurB7L9IF9MfFpMKMyhUm1iRqHfnEoqRxD7a44u/l75ifp7fBOPb3R4OIeejP
	C8RTULuzFhNFPyDvmT0Nbux/AdlHOo5fY025AYa/gMVyiq3ZRbspAMiU5LJy/ACv1xinHy
	8XLs0bFh+9cwiNigKGl8ho62kzWbZeqU6xev+W/1QKIjA5PwkhYSH0jhYxzCra8lwjHfqI
	SiWx0lA6NcbfOceluqJNfo5yit09ktA1XYP+UfIjU41RxUNheGymnhfHPdMZ0Q==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Paul Burton <paulburton@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Vladimir  Kondratiev <vladimir.kondratiev@mobileye.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH v7 11/14] MIPS: mobileye: Add EPM5 device tree
Date: Mon,  5 Feb 2024 16:34:57 +0100
Message-ID: <20240205153503.574468-12-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240205153503.574468-1-gregory.clement@bootlin.com>
References: <20240205153503.574468-1-gregory.clement@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: gregory.clement@bootlin.com

Add a device tree for the Mobileye EPM5 evaluation board.

Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 arch/mips/boot/dts/mobileye/Makefile       |  4 ++++
 arch/mips/boot/dts/mobileye/eyeq5-epm5.dts | 23 ++++++++++++++++++++++
 2 files changed, 27 insertions(+)
 create mode 100644 arch/mips/boot/dts/mobileye/Makefile
 create mode 100644 arch/mips/boot/dts/mobileye/eyeq5-epm5.dts

diff --git a/arch/mips/boot/dts/mobileye/Makefile b/arch/mips/boot/dts/mobileye/Makefile
new file mode 100644
index 0000000000000..01c01c3aad81d
--- /dev/null
+++ b/arch/mips/boot/dts/mobileye/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright 2023 Mobileye Vision Technologies Ltd.
+
+dtb-$(CONFIG_MACH_EYEQ5)		+= eyeq5-epm5.dtb
diff --git a/arch/mips/boot/dts/mobileye/eyeq5-epm5.dts b/arch/mips/boot/dts/mobileye/eyeq5-epm5.dts
new file mode 100644
index 0000000000000..6898b2d8267df
--- /dev/null
+++ b/arch/mips/boot/dts/mobileye/eyeq5-epm5.dts
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Copyright 2023 Mobileye Vision Technologies Ltd.
+ */
+
+/dts-v1/;
+
+#include "eyeq5.dtsi"
+
+/ {
+	compatible = "mobileye,eyeq5-epm5", "mobileye,eyeq5";
+	model = "Mobile EyeQ5 MP5 Evaluation board";
+
+	chosen {
+		stdout-path = "serial2:115200n8";
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x40000000 0x0 0x02000000>,
+		      <0x8 0x02000000 0x0 0x7E000000>;
+	};
+};
-- 
2.43.0


