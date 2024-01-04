Return-Path: <linux-kernel+bounces-16378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFA9823DA9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 09:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8429C1F24A1B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 08:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1921D1EA8F;
	Thu,  4 Jan 2024 08:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="RDncaYam"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD941E51E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 08:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5563944b3dfso310490a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 00:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1704357736; x=1704962536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mmQnQzOW0HVCglZmRdERbSkiK/7LfpA/GFNr/QR6hMQ=;
        b=RDncaYam2gQJ+/YQIrSs8QsGLjI4TdTMWhwfSKE5goeb8S5bezuUdFEDTJnt6M3CmE
         0r+w+iorWaWcyHrM+10K6488ttCrkU/84UFetH3OEoJJ6jOJXjLSB3icspt70KuX2q19
         PA1VMxFN/EKmiSnVrwnNIexBKw7M3v1Uw8vF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704357736; x=1704962536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mmQnQzOW0HVCglZmRdERbSkiK/7LfpA/GFNr/QR6hMQ=;
        b=OqHx28UKncXrZIO8yFeVndzLbGR2mvIRQW/uSsIMSwMvFRvRtblTULow5eKs0a5La9
         NuA20DBWLFEIkzeNFdprxUPIKMhYcqZkdY4Vbtv06XsGTuQaB/54YGhkyavw6slnTl2V
         n7mYwDBoIdsGwbO5OM6IfZ0MjguRHbPzblTg91vi5Hdf6UM0LdDfEsYLKAs9zFCFtlUm
         ok9bnP6b/C/JIcYWgc/FzUtoJ8oftEEIvTzyKcb242C9V/mayAakrGrP9s/OJkOy3kvw
         u+IpbZ+vAe8CJ3nbQXfOlgXFbOjed6Paz0/wM2KnaAr4ezkpDWDGU0hpOND87jktXHWC
         TwDg==
X-Gm-Message-State: AOJu0Yy2yxkYy7NrnWL9SlJy9Z5VdTSy+wvI2m6yVRPKthI5Swf7o+RM
	lObulNrgdXjnuJ6rCTFkpamzPiKFNME/JmUUTpe7VnJPlu8=
X-Google-Smtp-Source: AGHT+IHSYPcVifjg7WaTw/q5gyvP9LIwxVEzE68+cuj6LtkM0cSU6dPkyvmWyHhxnoLtxki+J+/I7Q==
X-Received: by 2002:a17:906:c244:b0:a23:35d2:cf97 with SMTP id bl4-20020a170906c24400b00a2335d2cf97mr149261ejb.64.1704357735999;
        Thu, 04 Jan 2024 00:42:15 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com (net-93-150-255-34.cust.vodafonedsl.it. [93.150.255.34])
        by smtp.gmail.com with ESMTPSA id wh14-20020a170906fd0e00b00a233efe6aa7sm13495704ejb.51.2024.01.04.00.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 00:42:15 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v4 2/8] ARM: dts: stm32: add DSI support on stm32f769
Date: Thu,  4 Jan 2024 09:41:42 +0100
Message-ID: <20240104084206.721824-3-dario.binacchi@amarulasolutions.com>
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

Add support for MIPI DSI Host controller. Since MIPI DSI is not
available on stm32f746, the patch adds the "stm32f769.dtsi" file
containing the dsi node inside.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 arch/arm/boot/dts/st/stm32f769.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 arch/arm/boot/dts/st/stm32f769.dtsi

diff --git a/arch/arm/boot/dts/st/stm32f769.dtsi b/arch/arm/boot/dts/st/stm32f769.dtsi
new file mode 100644
index 000000000000..e09184f7079c
--- /dev/null
+++ b/arch/arm/boot/dts/st/stm32f769.dtsi
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 Dario Binacchi <dario.binacchi@amarulasolutions.com>
+ */
+
+#include "stm32f746.dtsi"
+
+/ {
+	soc {
+		dsi: dsi@40016c00 {
+			compatible = "st,stm32-dsi";
+			reg = <0x40016c00 0x800>;
+			interrupts = <98>;
+			clocks = <&rcc 1 CLK_F769_DSI>, <&clk_hse>;
+			clock-names = "pclk", "ref";
+			resets = <&rcc STM32F7_APB2_RESET(DSI)>;
+			reset-names = "apb";
+			status = "disabled";
+		};
+	};
+};
-- 
2.43.0


