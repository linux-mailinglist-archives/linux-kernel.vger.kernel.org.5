Return-Path: <linux-kernel+bounces-13107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 615D881FFD1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 14:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0323282896
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 13:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815CE11CAD;
	Fri, 29 Dec 2023 13:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="EPb2A/v2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661C211726
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 13:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55590da560dso1499415a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 05:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1703857941; x=1704462741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fm4SMpBWyIuCnxOoIcwbmnLaagYfOE7lx8vpRJXcsrs=;
        b=EPb2A/v2TBrCrNqkp+eefHPRr5SCIPbYUXfw5j+b1pWUaCRB5lO4+cFzKWYrZDaTWj
         e+4jJOj+4OTu3dhnFHZhYl8zdGtkq6IlWpJSZAkn86AE/Njpj9b2kvXYV6nOWQzXSrzt
         Na5oZ6metb1eDob3KbtjciFI7w7obXx8qvH3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703857941; x=1704462741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fm4SMpBWyIuCnxOoIcwbmnLaagYfOE7lx8vpRJXcsrs=;
        b=EvB9n+95fAyGz8LOVD/RtyiXVuY5JgvJm00neCNLTzX/So1gcXb7EdVypbbBB/XbM/
         k8wiaHEZWfgV9jursKZWjOK6hPjEu6FdZXifdfx7tP3MBD6RazNhuMwlOvi7eOcL7Uvc
         Vi10MRtT8Yies6L7drGlgChD+Bb+nkdLAXmIlOQbd3P+BYL/GXu/QkjFX/JrYmZiv5Km
         cM0Hvr1MyCVpL8BRgsd1/QrORzy4B/EVasbVzJrc0HunlnRjE5ftCo2/9bWKhtWGwEdO
         c2Fpxvv6c8lu1vFJDSTmw0llEBLrW50kGiSVGCCIYy8NEPNI9cen5ryKb/XemKmNzW7L
         b37A==
X-Gm-Message-State: AOJu0YwBx4mj61e3kosur5mKq6lI83iBHHG1/2dF2xhVZLi/2SBcRsug
	/4r48B5iVgIr1rtFIAvaX3p+KqOC1B7XEQ0Ejlek4MsWtQc=
X-Google-Smtp-Source: AGHT+IH8tQ2PxRJuCxjDJpcQd+9IgU90NXBL+k8pDgz9gTMDYVTdTri9Wy4GyD3WctlqM/sYzFDvxw==
X-Received: by 2002:a50:951e:0:b0:553:6a5b:c61f with SMTP id u30-20020a50951e000000b005536a5bc61fmr7239728eda.0.1703857941534;
        Fri, 29 Dec 2023 05:52:21 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-49-57-70.retail.telecomitalia.it. [79.49.57.70])
        by smtp.gmail.com with ESMTPSA id i16-20020aa7c710000000b00553b243b1a8sm11019160edq.92.2023.12.29.05.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Dec 2023 05:52:21 -0800 (PST)
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
Subject: [PATCH 2/8] ARM: dts: stm32: add DSI support on stm32f769
Date: Fri, 29 Dec 2023 14:51:17 +0100
Message-ID: <20231229135154.675946-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231229135154.675946-1-dario.binacchi@amarulasolutions.com>
References: <20231229135154.675946-1-dario.binacchi@amarulasolutions.com>
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


