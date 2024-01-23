Return-Path: <linux-kernel+bounces-34663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B831E8385D4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0054E1C280FF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCEA2107;
	Tue, 23 Jan 2024 02:57:04 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788C6A40;
	Tue, 23 Jan 2024 02:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705978624; cv=none; b=iqQLGC6ArtNIJ69nyzr8YGLCGSOO5k4u+c2wlg2LDhRBhWG8hsz4LBX+SRRz3zxycgLltlS9BFzo+Au+MdeBIVEw06HyPKN+J4a0J1OqXJmejL6ByplWsHe6fXptjhO/cDqiC+TcbExeUBvuzR10femfU7x4jMnn4wsBQnAw3tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705978624; c=relaxed/simple;
	bh=HO+P9HHk5xdN8+9NMbhUtb2fAk3bvYT5z8UnLdpzVaE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cs6Yrp2JYFH47NADkm6Ewo7ZV5RT0Vdnp0fCI+z+h8zOWXXC1ae9/y2vBiTzc/lKeHUAjDVnpHsNW420Cocarv3MblzkEfmdQ4wQgsxVKHfQsMq7gAcidSG/KYIQU48/nVmoaqxwFhBGN1hVXJJPQ06vP5Var9AQOlkaIzSxtds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 40N2uJox022812;
	Tue, 23 Jan 2024 10:56:19 +0800 (+08)
	(envelope-from zhifeng.tang@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx04.spreadtrum.com [10.0.1.214])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TJs3t5pckz2S82tk;
	Tue, 23 Jan 2024 10:48:58 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx04.spreadtrum.com
 (10.0.1.214) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Tue, 23 Jan
 2024 10:56:18 +0800
From: Zhifeng Tang <zhifeng.tang@unisoc.com>
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
	<sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang
	<baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC: <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Zhifeng Tang <zhifeng.tang23@gmail.com>,
        Wenming Wu <wenming.wu@unisoc.com>
Subject: [PATCH V4 3/3] arm64: dts: sprd: Add reset controller driver for UMS512
Date: Tue, 23 Jan 2024 10:56:13 +0800
Message-ID: <20240123025613.3976-4-zhifeng.tang@unisoc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240123025613.3976-1-zhifeng.tang@unisoc.com>
References: <20240123025613.3976-1-zhifeng.tang@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 shmbx04.spreadtrum.com (10.0.1.214)
X-MAIL:SHSQR01.spreadtrum.com 40N2uJox022812

From: "zhifeng.tang" <zhifeng.tang@unisoc.com>

In most of Sprd SOCs,The clock controller register block also
contains reset bits for some of these peripherals,so reset
controller and clock provider are combined together as a block,
and put it under the driver/clk/.

Signed-off-by: zhifeng.tang <zhifeng.tang@unisoc.com>
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


