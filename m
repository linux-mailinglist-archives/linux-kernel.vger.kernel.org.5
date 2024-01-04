Return-Path: <linux-kernel+bounces-16383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4BB823DB4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 09:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8488C1C237D6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 08:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D20120B31;
	Thu,  4 Jan 2024 08:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="NAdmoIig"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B60F20B12
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 08:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5570bef7cb8so146726a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 00:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1704357741; x=1704962541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tEGmlMiozwdCujUlwuswF2ibPRmO4ymakUkp4ma1zKM=;
        b=NAdmoIigOwWzrIB+4XV6qWuQQgrW+JQCshyXK7sLliY77QTYBu6/2sUzi2FH0VqEvH
         fK9/MZ6AlP6Ux9+XDtMcK7c1F2hIRmfR59kZE4NRan8Xv+CxT1YVU+wJEXMGCnM8IWKp
         AyZsauxGpxgIaWqY5HFP1lAXNsKXr95A1fndA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704357741; x=1704962541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tEGmlMiozwdCujUlwuswF2ibPRmO4ymakUkp4ma1zKM=;
        b=manSGBoa756/AaBcdrbRkTZ09swiicSOtr9ho5maL9XW+rVTGjpq2kAW1sK11qZPur
         NjNbmOwEWjT8Ra+H1qLnxHv0VEg5b/8D6o6GdCJg0pD+Cvhvh7xNBuuQlcwSNZrPwSxX
         2RthD+T/HjSUD4RL2kepGvSoSG4ze7VUpUrimrVUr8YaNT1sj2IqvjdYvZlcWqEU3qI3
         y0M6NkC1f41fq3vEJ1SyzA7U8igFre50w7ltbdcRZjGbn/zom154pcs+vsZl7d0RE+ZK
         yi9UGwWg1Uo08N/hBV5vLDRB0ZFdMfTyQafEzodS+Vbo7QC3Qj3P7B3OWlLQLhokLtj9
         HZYg==
X-Gm-Message-State: AOJu0Yxn/y2eXzpym+CyDqR49fVsQLP+WBRVVI9BOiKI9YIz19i8QrsQ
	GG073xESJU14sMXiwLHreL64ceTJV+yN2MCrz9Bj3uwsBZg=
X-Google-Smtp-Source: AGHT+IGcCpKatZQ/JHu3HHMVjwa84lxo4e+6glVAZYFC2qI1Q8AMacWHoR6rN9b60Qypsh4zxEW6ew==
X-Received: by 2002:a17:907:1b25:b0:a24:8deb:3524 with SMTP id mp37-20020a1709071b2500b00a248deb3524mr188633ejc.54.1704357741664;
        Thu, 04 Jan 2024 00:42:21 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com (net-93-150-255-34.cust.vodafonedsl.it. [93.150.255.34])
        by smtp.gmail.com with ESMTPSA id wh14-20020a170906fd0e00b00a233efe6aa7sm13495704ejb.51.2024.01.04.00.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 00:42:21 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Andre Przywara <andre.przywara@arm.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	=?UTF-8?q?Leonard=20G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Sean Nyekjaer <sean@geanix.com>,
	Shawn Guo <shawnguo@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v4 6/8] ARM: dts: add stm32f769-disco-mb1225-revb03-mb1166-reva09
Date: Thu,  4 Jan 2024 09:41:46 +0100
Message-ID: <20240104084206.721824-7-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240104084206.721824-1-dario.binacchi@amarulasolutions.com>
References: <20240104084206.721824-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As reported in the section 8.3 (i. e. Board revision history) of document
UM2033 (i. e. Discovery kit with STM32F769NI MCU) these are the changes
related to the board revisions addressed by the patch:
- Board MB1225 revision B-03:
  - Memory MICRON MT48LC4M32B2B5-6A replaced by ISSI IS42S32400F-6BL
- Board MB1166 revision A-09:
  - LCD FRIDA FRD397B25009-D-CTK replaced by FRIDA FRD400B25025-A-CTK

The patch only adds the DTS support for the new display which belongs to
to the Novatek NT35510-based panel family.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

(no changes since v2)

Changes in v2:
- Change the status of panel_backlight node to "disabled"
- Delete backlight property from panel0 node.

 arch/arm/boot/dts/st/Makefile                  |  1 +
 ...2f769-disco-mb1225-revb03-mb1166-reva09.dts | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)
 create mode 100644 arch/arm/boot/dts/st/stm32f769-disco-mb1225-revb03-mb1166-reva09.dts

diff --git a/arch/arm/boot/dts/st/Makefile b/arch/arm/boot/dts/st/Makefile
index 7892ad69b441..390dbd300a57 100644
--- a/arch/arm/boot/dts/st/Makefile
+++ b/arch/arm/boot/dts/st/Makefile
@@ -23,6 +23,7 @@ dtb-$(CONFIG_ARCH_STM32) += \
 	stm32f469-disco.dtb \
 	stm32f746-disco.dtb \
 	stm32f769-disco.dtb \
+	stm32f769-disco-mb1225-revb03-mb1166-reva09.dts \
 	stm32429i-eval.dtb \
 	stm32746g-eval.dtb \
 	stm32h743i-eval.dtb \
diff --git a/arch/arm/boot/dts/st/stm32f769-disco-mb1225-revb03-mb1166-reva09.dts b/arch/arm/boot/dts/st/stm32f769-disco-mb1225-revb03-mb1166-reva09.dts
new file mode 100644
index 000000000000..014cac192375
--- /dev/null
+++ b/arch/arm/boot/dts/st/stm32f769-disco-mb1225-revb03-mb1166-reva09.dts
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 Dario Binacchi <dario.binacchi@amarulasolutions.com>
+ */
+
+#include "stm32f769-disco.dts"
+
+&panel_backlight {
+	status = "disabled";
+};
+
+&panel0 {
+	compatible = "frida,frd400b25025", "novatek,nt35510";
+	vddi-supply = <&vcc_3v3>;
+	vdd-supply = <&vcc_3v3>;
+	/delete-property/backlight;
+	/delete-property/power-supply;
+};
-- 
2.43.0


