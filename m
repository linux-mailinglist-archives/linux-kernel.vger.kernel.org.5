Return-Path: <linux-kernel+bounces-128590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AE1895CC9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45F1E1C23647
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F02A15E1E4;
	Tue,  2 Apr 2024 19:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFsEbGq6"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AC415E1E7;
	Tue,  2 Apr 2024 19:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712086570; cv=none; b=tqDqegvrmM7+9Q9enYRYSI1gSx7qUk2f3nsufJQ/adPc/oCrMfBlGOxmKVJ2XwPOifs8uRWUhviH925hY1RDYAqxRrX9ZAw2J1dbnLEW1P4hAslTpsBy9cPjeIQVlgJAHjKeT4DdtKVQmg3xqty9OrSa/fJ2cKi+JEjZlMr4u4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712086570; c=relaxed/simple;
	bh=FqcX9lW6dxlrrJOo+l21rwvIfvzj0I2E4OSXtkHPLw4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G+Yg+VcIAULFJEid8qlJ76qPSCnoG9WEimJO1TXb0rmodz8C7931galwGT4hA6BFp98ayEbjZfyxQMksJvgmMkt2TEy/spzBi2/eFbI+AV5j+f3peFCjgR2s/+wMZtS6o3wobhhwUp6lGpcJYw+G+NtqVOVDXdEV8wADjU0fGXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JFsEbGq6; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e034607879so45000545ad.0;
        Tue, 02 Apr 2024 12:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712086568; x=1712691368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JbxPPy4wEo1HL7BaDCFsf3rGTD0Y12Ia1owrqy3ZBlQ=;
        b=JFsEbGq6T1ObgangZPuHJU9NZG2N2i8ynb/ioxXkYU9Xle5zs1ZL49tnGCt/4va89U
         j7+l8xrBfM/yESj9MEWYdXv2psB0eNheW6Ib5VKkhjoIVfzqtYTSwTbgRGGW87MdhfuJ
         bS9idvq5eK0WSU/hOgdh+tDFrvUP9PbRQWwTEt5BCxJdY9Pb4bP2j9qOi/wXA8UW83W2
         0PKvaGWdtmuoaZrewecUeXVaVnVdAiksfdeu4UuhQLbJufL8th2J1NUV3IlJXzlsjtc6
         dVx21tEjtKYZLGg64f4A54G+SinmdVecGoB9zH5ZUS8aklaEai0ZGnaANnAWp3ck6Mrq
         0eHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712086568; x=1712691368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JbxPPy4wEo1HL7BaDCFsf3rGTD0Y12Ia1owrqy3ZBlQ=;
        b=XIuuP1x0GW9FiWhM2XZkmxCgamRDsgT/CDmLT0Xx7CZYf4xSKWjm6ln6tkOm092Ctw
         3I2Gz3+dLTdNqEyYkadlg/74R0SczvybL69ERYTaI6Wj69a7/1jtZjAht8sxc0wPFmC1
         mshyZkMra1inG+GrWbU9upbPEfa+da+cvi6yuZr937iC81QS5PH8ZpEIGLC3OO4dqKoC
         zAqolClKPKMOVh3lRC3tOs6UY93HTo2Aib/Th+f06UMXEq/MgzkWWqmeMKjUqdVpTkSk
         5cWAZSIVuPe4vHCffXlPg5eMe2YWYLensM3WbmrCp3A+mtq7IS7DFYO703wgwKukaHA+
         uzZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQ6XIzyOQYUEo+iTpkJT5zU+QM8G8xlpWgYrDd2zw/AZ+nG6YEaTQkiBU6C+ans8nNAtG6R1oU+kgHc5W4MxsBEb7EK9yTKD0GO5sUPXatzGYcUO6KDPkBE2bFcKoLSPo6WFVs+hu4iw==
X-Gm-Message-State: AOJu0Yz3oKBGelQ1uTVKr764+gjyXU8D+d9WVmIhNZKFQUQVff0adlWk
	ia+XbAA/07Pg+9kHrMzkjdAWnbRwVK5IRKmegpCUBy0/gJdSXQ2o
X-Google-Smtp-Source: AGHT+IFGlYKSW7YOzLKAnP83ZtpNC7x2eE5WHe0YrBZg38dpc8yY2U9KHdDzwe3YnxPDG8s1U5vtaw==
X-Received: by 2002:a17:902:d488:b0:1e0:3447:8dc5 with SMTP id c8-20020a170902d48800b001e034478dc5mr19190201plg.63.1712086568120;
        Tue, 02 Apr 2024 12:36:08 -0700 (PDT)
Received: from frhdebian.. ([2804:14d:8084:b86e:ac17:f518:b547:13a8])
        by smtp.gmail.com with ESMTPSA id g6-20020a1709026b4600b001dd59b54f9fsm7775841plt.136.2024.04.02.12.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 12:36:07 -0700 (PDT)
From: Hiago De Franco <hiagofranco@gmail.com>
To: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hiago De Franco <hiago.franco@toradex.com>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/4] arm64: dts: freescale: Add Toradex Colibri iMX8DX
Date: Tue,  2 Apr 2024 16:35:12 -0300
Message-Id: <20240402193512.240417-5-hiagofranco@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240402193512.240417-1-hiagofranco@gmail.com>
References: <20240402193512.240417-1-hiagofranco@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hiago De Franco <hiago.franco@toradex.com>

Add support for Toradex Colibri iMX8DX SoM and Aster, Evaluation Board v3,
Iris and Iris v2 carrier boards the module can be mated in.
This SoM is a variant of the already supported Colibri iMX8QXP, using an
NXP i.MX8DX SoC instead of i.MX8QXP.

Link: https://www.toradex.com/computer-on-modules/colibri-arm-family/nxp-imx-8x
Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
---
 arch/arm64/boot/dts/freescale/Makefile           |  4 ++++
 .../boot/dts/freescale/imx8dx-colibri-aster.dts  | 16 ++++++++++++++++
 .../dts/freescale/imx8dx-colibri-eval-v3.dts     | 16 ++++++++++++++++
 .../dts/freescale/imx8dx-colibri-iris-v2.dts     | 16 ++++++++++++++++
 .../boot/dts/freescale/imx8dx-colibri-iris.dts   | 16 ++++++++++++++++
 .../arm64/boot/dts/freescale/imx8dx-colibri.dtsi | 11 +++++++++++
 6 files changed, 79 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8dx-colibri-aster.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8dx-colibri-eval-v3.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8dx-colibri-iris-v2.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8dx-colibri-iris.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8dx-colibri.dtsi

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 045250d0a040..cf221a862cf7 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -98,6 +98,10 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-tqmlx2160a-mblx2160a-14-11-x.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-tqmlx2160a-mblx2160a-14-8-x.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-tqmlx2160a-mblx2160a-14-7-x.dtb
 
+dtb-$(CONFIG_ARCH_MXC) += imx8dx-colibri-aster.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8dx-colibri-eval-v3.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8dx-colibri-iris-v2.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8dx-colibri-iris.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8dxl-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8dxp-tqma8xdp-mba8xx.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-beacon-kit.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8dx-colibri-aster.dts b/arch/arm64/boot/dts/freescale/imx8dx-colibri-aster.dts
new file mode 100644
index 000000000000..c974f5dc0283
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8dx-colibri-aster.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2018-2021 Toradex
+ */
+
+/dts-v1/;
+
+#include "imx8dx-colibri.dtsi"
+#include "imx8x-colibri-aster.dtsi"
+
+/ {
+	model = "Toradex Colibri iMX8DX on Aster Board";
+	compatible = "toradex,colibri-imx8x-aster",
+		     "toradex,colibri-imx8x",
+		     "fsl,imx8dx";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8dx-colibri-eval-v3.dts b/arch/arm64/boot/dts/freescale/imx8dx-colibri-eval-v3.dts
new file mode 100644
index 000000000000..f2bf15463ae8
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8dx-colibri-eval-v3.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2018-2021 Toradex
+ */
+
+/dts-v1/;
+
+#include "imx8dx-colibri.dtsi"
+#include "imx8x-colibri-eval-v3.dtsi"
+
+/ {
+	model = "Toradex Colibri iMX8DX on Colibri Evaluation Board V3";
+	compatible = "toradex,colibri-imx8x-eval-v3",
+		     "toradex,colibri-imx8x",
+		     "fsl,imx8dx";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8dx-colibri-iris-v2.dts b/arch/arm64/boot/dts/freescale/imx8dx-colibri-iris-v2.dts
new file mode 100644
index 000000000000..fd425c70cf2b
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8dx-colibri-iris-v2.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2018-2021 Toradex
+ */
+
+/dts-v1/;
+
+#include "imx8dx-colibri.dtsi"
+#include "imx8x-colibri-iris-v2.dtsi"
+
+/ {
+	model = "Toradex Colibri iMX8DX on Colibri Iris V2 Board";
+	compatible = "toradex,colibri-imx8x-iris-v2",
+		     "toradex,colibri-imx8x",
+		     "fsl,imx8dx";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8dx-colibri-iris.dts b/arch/arm64/boot/dts/freescale/imx8dx-colibri-iris.dts
new file mode 100644
index 000000000000..e5e2346ce4f1
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8dx-colibri-iris.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2018-2021 Toradex
+ */
+
+/dts-v1/;
+
+#include "imx8dx-colibri.dtsi"
+#include "imx8x-colibri-iris.dtsi"
+
+/ {
+	model = "Toradex Colibri iMX8DX on Colibri Iris Board";
+	compatible = "toradex,colibri-imx8x-iris",
+		     "toradex,colibri-imx8x",
+		     "fsl,imx8dx";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8dx-colibri.dtsi b/arch/arm64/boot/dts/freescale/imx8dx-colibri.dtsi
new file mode 100644
index 000000000000..66b0fcc6687d
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8dx-colibri.dtsi
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2018-2021 Toradex
+ */
+
+#include "imx8dx.dtsi"
+#include "imx8x-colibri.dtsi"
+
+/ {
+	model = "Toradex Colibri iMX8DX Module";
+};
-- 
2.39.2


