Return-Path: <linux-kernel+bounces-589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B50D2814351
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BD3E1F231C7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22A514284;
	Fri, 15 Dec 2023 08:09:20 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D4311192
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 08:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 3BF88pRX008963;
	Fri, 15 Dec 2023 16:08:51 +0800 (+08)
	(envelope-from zhifeng.tang@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx04.spreadtrum.com [10.0.1.214])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4Ss1sx5Zj5z2PDtHV;
	Fri, 15 Dec 2023 16:02:45 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx04.spreadtrum.com
 (10.0.1.214) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Fri, 15 Dec
 2023 16:08:49 +0800
From: Zhifeng Tang <zhifeng.tang@unisoc.com>
To: Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang
	<baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Zhifeng Tang
	<zhifeng.tang23@gmail.com>,
        Wenming Wu <wenming.wu@unisoc.com>
Subject: [PATCH 3/4] arm64: dts: sprd: add reset controller driver for UMS512
Date: Fri, 15 Dec 2023 16:08:47 +0800
Message-ID: <20231215080847.8233-1-zhifeng.tang@unisoc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 shmbx04.spreadtrum.com (10.0.1.214)
X-MAIL:SHSQR01.spreadtrum.com 3BF88pRX008963

The reset register has the same base address as the gate register.

Signed-off-by: Zhifeng Tang <zhifeng.tang@unisoc.com>
---
 arch/arm64/boot/dts/sprd/ums512.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/sprd/ums512.dtsi b/arch/arm64/boot/dts/sprd/ums512.dtsi
index 024be594c47d..08d0adf6624c 100644
--- a/arch/arm64/boot/dts/sprd/ums512.dtsi
+++ b/arch/arm64/boot/dts/sprd/ums512.dtsi
@@ -7,6 +7,7 @@
 
 #include <dt-bindings/clock/sprd,ums512-clk.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/reset/sprd,ums512-reset.h>
 
 / {
 	interrupt-parent = <&gic>;
@@ -182,6 +183,7 @@
 				clocks = <&ext_26m>;
 				clock-names = "ext-26m";
 				#clock-cells = <1>;
+				#reset-cells = <1>;
 			};
 		};
 
@@ -316,6 +318,7 @@
 				clocks = <&ext_26m>;
 				clock-names = "ext-26m";
 				#clock-cells = <1>;
+				#reset-cells = <1>;
 			};
 		};
 
@@ -333,6 +336,7 @@
 				clocks = <&ext_26m>;
 				clock-names = "ext-26m";
 				#clock-cells = <1>;
+				#reset-cells = <1>;
 			};
 		};
 
@@ -348,6 +352,7 @@
 				compatible = "sprd,ums512-audcpapb-gate";
 				reg = <0x0 0x300>;
 				#clock-cells = <1>;
+				#reset-cells = <1>;
 			};
 		};
 
@@ -363,6 +368,7 @@
 				compatible = "sprd,ums512-audcpahb-gate";
 				reg = <0x0 0x300>;
 				#clock-cells = <1>;
+				#reset-cells = <1>;
 			};
 		};
 
@@ -380,6 +386,7 @@
 				clock-names = "ext-26m";
 				reg = <0x0 0x100>;
 				#clock-cells = <1>;
+				#reset-cells = <1>;
 			};
 		};
 
@@ -401,6 +408,7 @@
 				compatible = "sprd,ums512-mm-gate-clk";
 				reg = <0x0 0x3000>;
 				#clock-cells = <1>;
+				#reset-cells = <1>;
 			};
 		};
 
@@ -416,6 +424,7 @@
 				compatible = "sprd,ums512-apapb-gate";
 				reg = <0x0 0x3000>;
 				#clock-cells = <1>;
+				#reset-cells = <1>;
 			};
 		};
 
-- 
2.17.1


