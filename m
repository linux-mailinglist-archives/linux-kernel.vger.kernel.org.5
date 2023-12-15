Return-Path: <linux-kernel+bounces-1811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10806815466
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 00:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 912C81F25808
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC1B18ECE;
	Fri, 15 Dec 2023 23:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b="z+z7JNPs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from ixit.cz (ip-89-177-23-149.bb.vodafone.cz [89.177.23.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECEB18EBF;
	Fri, 15 Dec 2023 23:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ixit.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ixit.cz
Received: from newone.lan (unknown [10.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ixit.cz (Postfix) with ESMTPSA id DDC151630EC;
	Sat, 16 Dec 2023 00:07:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
	t=1702681665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/Lvcvj95IcsR/8QLbZbcC4C9QGasti6VW4v97dCAcd4=;
	b=z+z7JNPse6zXEgW37fgtid7qO4feA/J5uIRVgeFCAS945C4OebLd2uxqb1Qppn6gVgum2e
	UMfm2siFpfQW8EzqFI8Mv3AXGinIM4chsgGU+IEtdkzc71Jpg+VXAQdNkN7lGcWx0tvZWl
	6bTqH9LBebGuJk6L94v43PBAyGsStj8=
From: David Heidelberg <david@ixit.cz>
To: Shawn Guo <shawnguo@kernel.org>,
	Li Yang <leoyang.li@nxp.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: David Heidelberg <david@ixit.cz>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] arm64: dts: freescale: fix the schema check errors for fsl,tmu-calibration
Date: Sat, 16 Dec 2023 00:07:35 +0100
Message-ID: <20231215230743.86194-1-david@ixit.cz>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fsl,tmu-calibration contains cell pairs (u32-matrix). Mark them as such.

Use matching property syntax and allow correct validation.

No functional changes.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 .../arm64/boot/dts/freescale/fsl-ls1012a.dtsi | 79 ++++++++---------
 .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 87 ++++++++++---------
 .../arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 81 ++++++++---------
 .../arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 74 ++++++++--------
 .../arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 74 ++++++++--------
 .../arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 73 ++++++++--------
 .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi |  4 +-
 7 files changed, 238 insertions(+), 234 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index d0733451d3ce..1e3fe3897b52 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -307,45 +307,46 @@ tmu: tmu@1f00000 {
 			reg = <0x0 0x1f00000 0x0 0x10000>;
 			interrupts = <0 33 0x4>;
 			fsl,tmu-range = <0xb0000 0x9002a 0x6004c 0x60062>;
-			fsl,tmu-calibration = <0x00000000 0x00000025
-					       0x00000001 0x0000002c
-					       0x00000002 0x00000032
-					       0x00000003 0x00000039
-					       0x00000004 0x0000003f
-					       0x00000005 0x00000046
-					       0x00000006 0x0000004c
-					       0x00000007 0x00000053
-					       0x00000008 0x00000059
-					       0x00000009 0x0000005f
-					       0x0000000a 0x00000066
-					       0x0000000b 0x0000006c
-
-					       0x00010000 0x00000026
-					       0x00010001 0x0000002d
-					       0x00010002 0x00000035
-					       0x00010003 0x0000003d
-					       0x00010004 0x00000045
-					       0x00010005 0x0000004d
-					       0x00010006 0x00000055
-					       0x00010007 0x0000005d
-					       0x00010008 0x00000065
-					       0x00010009 0x0000006d
-
-					       0x00020000 0x00000026
-					       0x00020001 0x00000030
-					       0x00020002 0x0000003a
-					       0x00020003 0x00000044
-					       0x00020004 0x0000004e
-					       0x00020005 0x00000059
-					       0x00020006 0x00000063
-
-					       0x00030000 0x00000014
-					       0x00030001 0x00000021
-					       0x00030002 0x0000002e
-					       0x00030003 0x0000003a
-					       0x00030004 0x00000047
-					       0x00030005 0x00000053
-					       0x00030006 0x00000060>;
+			fsl,tmu-calibration =
+					<0x00000000 0x00000025>,
+					<0x00000001 0x0000002c>,
+					<0x00000002 0x00000032>,
+					<0x00000003 0x00000039>,
+					<0x00000004 0x0000003f>,
+					<0x00000005 0x00000046>,
+					<0x00000006 0x0000004c>,
+					<0x00000007 0x00000053>,
+					<0x00000008 0x00000059>,
+					<0x00000009 0x0000005f>,
+					<0x0000000a 0x00000066>,
+					<0x0000000b 0x0000006c>,
+
+					<0x00010000 0x00000026>,
+					<0x00010001 0x0000002d>,
+					<0x00010002 0x00000035>,
+					<0x00010003 0x0000003d>,
+					<0x00010004 0x00000045>,
+					<0x00010005 0x0000004d>,
+					<0x00010006 0x00000055>,
+					<0x00010007 0x0000005d>,
+					<0x00010008 0x00000065>,
+					<0x00010009 0x0000006d>,
+
+					<0x00020000 0x00000026>,
+					<0x00020001 0x00000030>,
+					<0x00020002 0x0000003a>,
+					<0x00020003 0x00000044>,
+					<0x00020004 0x0000004e>,
+					<0x00020005 0x00000059>,
+					<0x00020006 0x00000063>,
+
+					<0x00030000 0x00000014>,
+					<0x00030001 0x00000021>,
+					<0x00030002 0x0000002e>,
+					<0x00030003 0x0000003a>,
+					<0x00030004 0x00000047>,
+					<0x00030005 0x00000053>,
+					<0x00030006 0x00000060>;
 			#thermal-sensor-cells = <1>;
 		};
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index eefe3577d94e..ae534c23b970 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -1026,49 +1026,50 @@ tmu: tmu@1f80000 {
 			reg = <0x0 0x1f80000 0x0 0x10000>;
 			interrupts = <0 23 0x4>;
 			fsl,tmu-range = <0xb0000 0xa0026 0x80048 0x70061>;
-			fsl,tmu-calibration = <0x00000000 0x00000024
-					       0x00000001 0x0000002b
-					       0x00000002 0x00000031
-					       0x00000003 0x00000038
-					       0x00000004 0x0000003f
-					       0x00000005 0x00000045
-					       0x00000006 0x0000004c
-					       0x00000007 0x00000053
-					       0x00000008 0x00000059
-					       0x00000009 0x00000060
-					       0x0000000a 0x00000066
-					       0x0000000b 0x0000006d
-
-					       0x00010000 0x0000001c
-					       0x00010001 0x00000024
-					       0x00010002 0x0000002c
-					       0x00010003 0x00000035
-					       0x00010004 0x0000003d
-					       0x00010005 0x00000045
-					       0x00010006 0x0000004d
-					       0x00010007 0x00000055
-					       0x00010008 0x0000005e
-					       0x00010009 0x00000066
-					       0x0001000a 0x0000006e
-
-					       0x00020000 0x00000018
-					       0x00020001 0x00000022
-					       0x00020002 0x0000002d
-					       0x00020003 0x00000038
-					       0x00020004 0x00000043
-					       0x00020005 0x0000004d
-					       0x00020006 0x00000058
-					       0x00020007 0x00000063
-					       0x00020008 0x0000006e
-
-					       0x00030000 0x00000010
-					       0x00030001 0x0000001c
-					       0x00030002 0x00000029
-					       0x00030003 0x00000036
-					       0x00030004 0x00000042
-					       0x00030005 0x0000004f
-					       0x00030006 0x0000005b
-					       0x00030007 0x00000068>;
+			fsl,tmu-calibration =
+					<0x00000000 0x00000024>,
+					<0x00000001 0x0000002b>,
+					<0x00000002 0x00000031>,
+					<0x00000003 0x00000038>,
+					<0x00000004 0x0000003f>,
+					<0x00000005 0x00000045>,
+					<0x00000006 0x0000004c>,
+					<0x00000007 0x00000053>,
+					<0x00000008 0x00000059>,
+					<0x00000009 0x00000060>,
+					<0x0000000a 0x00000066>,
+					<0x0000000b 0x0000006d>,
+
+					<0x00010000 0x0000001c>,
+					<0x00010001 0x00000024>,
+					<0x00010002 0x0000002c>,
+					<0x00010003 0x00000035>,
+					<0x00010004 0x0000003d>,
+					<0x00010005 0x00000045>,
+					<0x00010006 0x0000004d>,
+					<0x00010007 0x00000055>,
+					<0x00010008 0x0000005e>,
+					<0x00010009 0x00000066>,
+					<0x0001000a 0x0000006e>,
+
+					<0x00020000 0x00000018>,
+					<0x00020001 0x00000022>,
+					<0x00020002 0x0000002d>,
+					<0x00020003 0x00000038>,
+					<0x00020004 0x00000043>,
+					<0x00020005 0x0000004d>,
+					<0x00020006 0x00000058>,
+					<0x00020007 0x00000063>,
+					<0x00020008 0x0000006e>,
+
+					<0x00030000 0x00000010>,
+					<0x00030001 0x0000001c>,
+					<0x00030002 0x00000029>,
+					<0x00030003 0x00000036>,
+					<0x00030004 0x00000042>,
+					<0x00030005 0x0000004f>,
+					<0x00030006 0x0000005b>,
+					<0x00030007 0x00000068>;
 			little-endian;
 			#thermal-sensor-cells = <1>;
 		};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 229bb4bebe42..d333b773bc45 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -447,46 +447,47 @@ tmu: tmu@1f00000 {
 			reg = <0x0 0x1f00000 0x0 0x10000>;
 			interrupts = <0 33 0x4>;
 			fsl,tmu-range = <0xb0000 0x9002a 0x6004c 0x70062>;
-			fsl,tmu-calibration = <0x00000000 0x00000023
-					       0x00000001 0x0000002a
-					       0x00000002 0x00000031
-					       0x00000003 0x00000037
-					       0x00000004 0x0000003e
-					       0x00000005 0x00000044
-					       0x00000006 0x0000004b
-					       0x00000007 0x00000051
-					       0x00000008 0x00000058
-					       0x00000009 0x0000005e
-					       0x0000000a 0x00000065
-					       0x0000000b 0x0000006b
-
-					       0x00010000 0x00000023
-					       0x00010001 0x0000002b
-					       0x00010002 0x00000033
-					       0x00010003 0x0000003b
-					       0x00010004 0x00000043
-					       0x00010005 0x0000004b
-					       0x00010006 0x00000054
-					       0x00010007 0x0000005c
-					       0x00010008 0x00000064
-					       0x00010009 0x0000006c
-
-					       0x00020000 0x00000021
-					       0x00020001 0x0000002c
-					       0x00020002 0x00000036
-					       0x00020003 0x00000040
-					       0x00020004 0x0000004b
-					       0x00020005 0x00000055
-					       0x00020006 0x0000005f
-
-					       0x00030000 0x00000013
-					       0x00030001 0x0000001d
-					       0x00030002 0x00000028
-					       0x00030003 0x00000032
-					       0x00030004 0x0000003d
-					       0x00030005 0x00000047
-					       0x00030006 0x00000052
-					       0x00030007 0x0000005c>;
+			fsl,tmu-calibration =
+					<0x00000000 0x00000023>,
+					<0x00000001 0x0000002a>,
+					<0x00000002 0x00000031>,
+					<0x00000003 0x00000037>,
+					<0x00000004 0x0000003e>,
+					<0x00000005 0x00000044>,
+					<0x00000006 0x0000004b>,
+					<0x00000007 0x00000051>,
+					<0x00000008 0x00000058>,
+					<0x00000009 0x0000005e>,
+					<0x0000000a 0x00000065>,
+					<0x0000000b 0x0000006b>,
+
+					<0x00010000 0x00000023>,
+					<0x00010001 0x0000002b>,
+					<0x00010002 0x00000033>,
+					<0x00010003 0x0000003b>,
+					<0x00010004 0x00000043>,
+					<0x00010005 0x0000004b>,
+					<0x00010006 0x00000054>,
+					<0x00010007 0x0000005c>,
+					<0x00010008 0x00000064>,
+					<0x00010009 0x0000006c>,
+
+					<0x00020000 0x00000021>,
+					<0x00020001 0x0000002c>,
+					<0x00020002 0x00000036>,
+					<0x00020003 0x00000040>,
+					<0x00020004 0x0000004b>,
+					<0x00020005 0x00000055>,
+					<0x00020006 0x0000005f>,
+
+					<0x00030000 0x00000013>,
+					<0x00030001 0x0000001d>,
+					<0x00030002 0x00000028>,
+					<0x00030003 0x00000032>,
+					<0x00030004 0x0000003d>,
+					<0x00030005 0x00000047>,
+					<0x00030006 0x00000052>,
+					<0x00030007 0x0000005c>;
 			#thermal-sensor-cells = <1>;
 		};
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 50f68ca5a9af..1515cec23147 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -445,46 +445,46 @@ tmu: tmu@1f00000 {
 			fsl,tmu-range = <0xb0000 0x9002a 0x6004c 0x70062>;
 			fsl,tmu-calibration =
 				/* Calibration data group 1 */
-				<0x00000000 0x00000023
-				0x00000001 0x00000029
-				0x00000002 0x0000002f
-				0x00000003 0x00000036
-				0x00000004 0x0000003c
-				0x00000005 0x00000042
-				0x00000006 0x00000049
-				0x00000007 0x0000004f
-				0x00000008 0x00000055
-				0x00000009 0x0000005c
-				0x0000000a 0x00000062
-				0x0000000b 0x00000068
+				<0x00000000 0x00000023>,
+				<0x00000001 0x00000029>,
+				<0x00000002 0x0000002f>,
+				<0x00000003 0x00000036>,
+				<0x00000004 0x0000003c>,
+				<0x00000005 0x00000042>,
+				<0x00000006 0x00000049>,
+				<0x00000007 0x0000004f>,
+				<0x00000008 0x00000055>,
+				<0x00000009 0x0000005c>,
+				<0x0000000a 0x00000062>,
+				<0x0000000b 0x00000068>,
 				/* Calibration data group 2 */
-				0x00010000 0x00000022
-				0x00010001 0x0000002a
-				0x00010002 0x00000032
-				0x00010003 0x0000003a
-				0x00010004 0x00000042
-				0x00010005 0x0000004a
-				0x00010006 0x00000052
-				0x00010007 0x0000005a
-				0x00010008 0x00000062
-				0x00010009 0x0000006a
+				<0x00010000 0x00000022>,
+				<0x00010001 0x0000002a>,
+				<0x00010002 0x00000032>,
+				<0x00010003 0x0000003a>,
+				<0x00010004 0x00000042>,
+				<0x00010005 0x0000004a>,
+				<0x00010006 0x00000052>,
+				<0x00010007 0x0000005a>,
+				<0x00010008 0x00000062>,
+				<0x00010009 0x0000006a>,
 				/* Calibration data group 3 */
-				0x00020000 0x00000021
-				0x00020001 0x0000002b
-				0x00020002 0x00000035
-				0x00020003 0x0000003e
-				0x00020004 0x00000048
-				0x00020005 0x00000052
-				0x00020006 0x0000005c
+				<0x00020000 0x00000021>,
+				<0x00020001 0x0000002b>,
+				<0x00020002 0x00000035>,
+				<0x00020003 0x0000003e>,
+				<0x00020004 0x00000048>,
+				<0x00020005 0x00000052>,
+				<0x00020006 0x0000005c>,
 				/* Calibration data group 4 */
-				0x00030000 0x00000011
-				0x00030001 0x0000001a
-				0x00030002 0x00000024
-				0x00030003 0x0000002e
-				0x00030004 0x00000038
-				0x00030005 0x00000042
-				0x00030006 0x0000004c
-				0x00030007 0x00000056>;
+				<0x00030000 0x00000011>,
+				<0x00030001 0x0000001a>,
+				<0x00030002 0x00000024>,
+				<0x00030003 0x0000002e>,
+				<0x00030004 0x00000038>,
+				<0x00030005 0x00000042>,
+				<0x00030006 0x0000004c>,
+				<0x00030007 0x00000056>;
 			big-endian;
 			#thermal-sensor-cells = <1>;
 		};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index 8f6090a9aef2..8616d5e0c388 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -284,46 +284,46 @@ tmu: tmu@1f80000 {
 			fsl,tmu-range = <0xb0000 0x9002a 0x6004c 0x70062>;
 			fsl,tmu-calibration =
 				/* Calibration data group 1 */
-				<0x00000000 0x00000023
-				0x00000001 0x0000002a
-				0x00000002 0x00000030
-				0x00000003 0x00000037
-				0x00000004 0x0000003d
-				0x00000005 0x00000044
-				0x00000006 0x0000004a
-				0x00000007 0x00000051
-				0x00000008 0x00000057
-				0x00000009 0x0000005e
-				0x0000000a 0x00000064
-				0x0000000b 0x0000006b
+				<0x00000000 0x00000023>,
+				<0x00000001 0x0000002a>,
+				<0x00000002 0x00000030>,
+				<0x00000003 0x00000037>,
+				<0x00000004 0x0000003d>,
+				<0x00000005 0x00000044>,
+				<0x00000006 0x0000004a>,
+				<0x00000007 0x00000051>,
+				<0x00000008 0x00000057>,
+				<0x00000009 0x0000005e>,
+				<0x0000000a 0x00000064>,
+				<0x0000000b 0x0000006b>,
 				/* Calibration data group 2 */
-				0x00010000 0x00000022
-				0x00010001 0x0000002a
-				0x00010002 0x00000032
-				0x00010003 0x0000003a
-				0x00010004 0x00000042
-				0x00010005 0x0000004a
-				0x00010006 0x00000052
-				0x00010007 0x0000005a
-				0x00010008 0x00000062
-				0x00010009 0x0000006a
+				<0x00010000 0x00000022>,
+				<0x00010001 0x0000002a>,
+				<0x00010002 0x00000032>,
+				<0x00010003 0x0000003a>,
+				<0x00010004 0x00000042>,
+				<0x00010005 0x0000004a>,
+				<0x00010006 0x00000052>,
+				<0x00010007 0x0000005a>,
+				<0x00010008 0x00000062>,
+				<0x00010009 0x0000006a>,
 				/* Calibration data group 3 */
-				0x00020000 0x00000021
-				0x00020001 0x0000002b
-				0x00020002 0x00000035
-				0x00020003 0x00000040
-				0x00020004 0x0000004a
-				0x00020005 0x00000054
-				0x00020006 0x0000005e
+				<0x00020000 0x00000021>,
+				<0x00020001 0x0000002b>,
+				<0x00020002 0x00000035>,
+				<0x00020003 0x00000040>,
+				<0x00020004 0x0000004a>,
+				<0x00020005 0x00000054>,
+				<0x00020006 0x0000005e>,
 				/* Calibration data group 4 */
-				0x00030000 0x00000010
-				0x00030001 0x0000001c
-				0x00030002 0x00000027
-				0x00030003 0x00000032
-				0x00030004 0x0000003e
-				0x00030005 0x00000049
-				0x00030006 0x00000054
-				0x00030007 0x00000060>;
+				<0x00030000 0x00000010>,
+				<0x00030001 0x0000001c>,
+				<0x00030002 0x00000027>,
+				<0x00030003 0x00000032>,
+				<0x00030004 0x0000003e>,
+				<0x00030005 0x00000049>,
+				<0x00030006 0x00000054>,
+				<0x00030007 0x00000060>;
 			little-endian;
 			#thermal-sensor-cells = <1>;
 		};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index 717288bbdb8b..0b7292835906 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -321,42 +321,43 @@ tmu: tmu@1f80000 {
 			reg = <0x0 0x1f80000 0x0 0x10000>;
 			interrupts = <0 23 0x4>;
 			fsl,tmu-range = <0xb0000 0x9002a 0x6004c 0x30062>;
-			fsl,tmu-calibration = <0x00000000 0x00000026
-					       0x00000001 0x0000002d
-					       0x00000002 0x00000032
-					       0x00000003 0x00000039
-					       0x00000004 0x0000003f
-					       0x00000005 0x00000046
-					       0x00000006 0x0000004d
-					       0x00000007 0x00000054
-					       0x00000008 0x0000005a
-					       0x00000009 0x00000061
-					       0x0000000a 0x0000006a
-					       0x0000000b 0x00000071
-
-					       0x00010000 0x00000025
-					       0x00010001 0x0000002c
-					       0x00010002 0x00000035
-					       0x00010003 0x0000003d
-					       0x00010004 0x00000045
-					       0x00010005 0x0000004e
-					       0x00010006 0x00000057
-					       0x00010007 0x00000061
-					       0x00010008 0x0000006b
-					       0x00010009 0x00000076
-
-					       0x00020000 0x00000029
-					       0x00020001 0x00000033
-					       0x00020002 0x0000003d
-					       0x00020003 0x00000049
-					       0x00020004 0x00000056
-					       0x00020005 0x00000061
-					       0x00020006 0x0000006d
-
-					       0x00030000 0x00000021
-					       0x00030001 0x0000002a
-					       0x00030002 0x0000003c
-					       0x00030003 0x0000004e>;
+			fsl,tmu-calibration =
+					<0x00000000 0x00000026>,
+					<0x00000001 0x0000002d>,
+					<0x00000002 0x00000032>,
+					<0x00000003 0x00000039>,
+					<0x00000004 0x0000003f>,
+					<0x00000005 0x00000046>,
+					<0x00000006 0x0000004d>,
+					<0x00000007 0x00000054>,
+					<0x00000008 0x0000005a>,
+					<0x00000009 0x00000061>,
+					<0x0000000a 0x0000006a>,
+					<0x0000000b 0x00000071>,
+
+					<0x00010000 0x00000025>,
+					<0x00010001 0x0000002c>,
+					<0x00010002 0x00000035>,
+					<0x00010003 0x0000003d>,
+					<0x00010004 0x00000045>,
+					<0x00010005 0x0000004e>,
+					<0x00010006 0x00000057>,
+					<0x00010007 0x00000061>,
+					<0x00010008 0x0000006b>,
+					<0x00010009 0x00000076>,
+
+					<0x00020000 0x00000029>,
+					<0x00020001 0x00000033>,
+					<0x00020002 0x0000003d>,
+					<0x00020003 0x00000049>,
+					<0x00020004 0x00000056>,
+					<0x00020005 0x00000061>,
+					<0x00020006 0x0000006d>,
+
+					<0x00030000 0x00000021>,
+					<0x00030001 0x0000002a>,
+					<0x00030002 0x0000003c>,
+					<0x00030003 0x0000004e>;
 			little-endian;
 			#thermal-sensor-cells = <1>;
 		};
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index f176ca2e244e..6640b49670ae 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -732,9 +732,9 @@ tmu: tmu@1f80000 {
 			fsl,tmu-range = <0x800000e6 0x8001017d>;
 			fsl,tmu-calibration =
 				/* Calibration data group 1 */
-				<0x00000000 0x00000035
+				<0x00000000 0x00000035>,
 				/* Calibration data group 2 */
-				0x00000001 0x00000154>;
+				<0x00000001 0x00000154>;
 			little-endian;
 			#thermal-sensor-cells = <1>;
 		};
-- 
2.43.0


