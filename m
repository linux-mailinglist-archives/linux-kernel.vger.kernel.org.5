Return-Path: <linux-kernel+bounces-16312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D79C823CAE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 08:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D9CF1F26716
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 07:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2324200C6;
	Thu,  4 Jan 2024 07:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="FiOP54LW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFA41EB42
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 07:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-55559e26ccfso254555a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 23:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1704353055; x=1704957855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mmQnQzOW0HVCglZmRdERbSkiK/7LfpA/GFNr/QR6hMQ=;
        b=FiOP54LWRtPAJekmY7ZJISVrwBkRGJKBAKGPH7c51kuhUOMgUj/ZI6alLrLxRJCQfc
         NdqUhquMr4KtVb5I52QgpSmR8KifiSlojkrTZkf6Og98pTeTjWOE7Y5T1B8JUiPUatxn
         G205tRAwFGzz+g1+exE6L8mt3IqH3SoYT9M4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704353055; x=1704957855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mmQnQzOW0HVCglZmRdERbSkiK/7LfpA/GFNr/QR6hMQ=;
        b=jg5aLL+qIn/AdpZ6Vfjs1iAr8IU1Xkzybj9MgOsKRoszJMbLxD+6axisQClgCMMkpj
         MtgzwyAch7OSvC62n8PC2MbK4YmCQIRBVoHSmAlStisd2VqLe6+7wgMVVWQ585c78WeC
         pQM0OpXGOcyAyL51g2ZJqJMDSv9FzBisDx+DBi8erv05FdMEEr0+cGb72nBcYBO4eXzb
         yVlRdawsGbVnTj/fnm0P33zE/ELIid/+V5gdjPwDEZcdFG5AbBaZqrAVySpmTp+/uUrm
         cmz4cqnltuTsxvCZQL7t1nPvrTjbAIh8XTXu2lEiaUcliD0PL5DpmRF13Dq5Z459EgWm
         gN2Q==
X-Gm-Message-State: AOJu0YxnXiC3JQMvGyEZG20WbWtlJG2Ge9PcdGGO77ITCgGLV2wNbzp8
	qkngqU9JmO0CIKLBMypFoHJq/palZTvpU9AQNaDS0/JGT94=
X-Google-Smtp-Source: AGHT+IGXvFWA8mDJu1Q7c0DYedSHw+rzfURNkb0c8LR8zcADT4bTICSmcFYro73weF3aE9KSua+6vw==
X-Received: by 2002:a50:cd91:0:b0:54c:4837:7d26 with SMTP id p17-20020a50cd91000000b0054c48377d26mr72929edi.101.1704353055677;
        Wed, 03 Jan 2024 23:24:15 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.. (net-93-150-255-34.cust.vodafonedsl.it. [93.150.255.34])
        by smtp.gmail.com with ESMTPSA id d3-20020a056402000300b00553772c2968sm18530735edu.82.2024.01.03.23.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 23:24:15 -0800 (PST)
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
Subject: [PATCH v3 2/8] ARM: dts: stm32: add DSI support on stm32f769
Date: Thu,  4 Jan 2024 08:23:38 +0100
Message-ID: <20240104072407.41290-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240104072407.41290-1-dario.binacchi@amarulasolutions.com>
References: <20240104072407.41290-1-dario.binacchi@amarulasolutions.com>
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


