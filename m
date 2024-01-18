Return-Path: <linux-kernel+bounces-30314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B26831CFB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF0C1286EC5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A432D797;
	Thu, 18 Jan 2024 15:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ao9vC9F3"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195212C87B;
	Thu, 18 Jan 2024 15:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705593200; cv=none; b=B0Er9kCMGYdla++jU0c3qGIQhqYv78fBuDbCNAgJjBv0gz0e5Q2YHacY9MtlrYBFeM011cunItxUTFy4ItyBP967j4NAvNxnkZe7RFrxqzvPxyRDqWUmu6N+XFHOZGuGDZ5NJmLbCQgSs+Uf8Kbr8zD/2WcSPSIwxnAMgBH1q+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705593200; c=relaxed/simple;
	bh=xzQLFAs+rRFfxr6J7S8JlG4vDnB1j5DDn8mbNfzk1ls=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-GND-Sasl; b=HZh0jxGKM+g+KVIq5lMsVgcvPLPoJnx6C98NSSb71+VOG+VOZ5lAI9oUK7qUIBS0bEDMPlLiAZOO8q3KXQb7bqA0IrNASGbGWT89uXVHe459nUFWYD3chFM/MbolqBhToiHi9uTk5hjgHP35JD5Jr04o+ppSmzF14kbNgMH1HoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ao9vC9F3; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 80730FF80E;
	Thu, 18 Jan 2024 15:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1705593196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rupw/qNEahXEF1JzKP5nTnlz5TBibUxNV4VZL8oYtQI=;
	b=ao9vC9F3NhLvnS+h+nvf1DYYi5HsezeiClWz1wX3PjBn/BWKmrit20JSNsmrHIkuOTu1Yb
	BZ6iFqFt9YW3WRraVqFvbgHbTLUEnXjN/iXcCOuVM0JGhqAsggYz30pLzLAICrCTfe8Tzu
	wj5Hn1HJeJCDSr50BqCccnFZC21aidsVtGfCYBO48Kxl6NAN1PU7MRcxS4cU4rrtLfd6Gj
	KWa0esBoJWs6Y0eWt08yc80crAWOaqQjn/flEBVpB3QEapu1iShNIUZVg6VUUf9nyOKs9K
	HwOsYx6IEuNSvFJ2W6OlRJVSviHY1VO/T2UrTeAaAU28AzkExEIv3Z91l3fNlg==
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
Subject: [PATCH v6 12/15] MIPS: mobileye: Add EPM5 device tree
Date: Thu, 18 Jan 2024 16:52:41 +0100
Message-ID: <20240118155252.397947-13-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118155252.397947-1-gregory.clement@bootlin.com>
References: <20240118155252.397947-1-gregory.clement@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: gregory.clement@bootlin.com

Add a device tree for the Mobileye EPM5 evaluation board.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 arch/mips/boot/dts/mobileye/Makefile       |  4 ++++
 arch/mips/boot/dts/mobileye/eyeq5-epm5.dts | 24 ++++++++++++++++++++++
 2 files changed, 28 insertions(+)
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
index 0000000000000..ff16c3c760a19
--- /dev/null
+++ b/arch/mips/boot/dts/mobileye/eyeq5-epm5.dts
@@ -0,0 +1,24 @@
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
+		bootargs = "earlycon";
+		stdout-path = "serial2:115200n8";
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x08000000 0x0 0x08000000>,
+		      <0x8 0x00000000 0x0 0x78000000>;
+	};
+};
-- 
2.43.0


