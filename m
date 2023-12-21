Return-Path: <linux-kernel+bounces-8125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 859FA81B269
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B79391C24BFE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5CA4E1A2;
	Thu, 21 Dec 2023 09:29:19 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF5647771
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 09:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 3BL9SZV7042635;
	Thu, 21 Dec 2023 17:28:35 +0800 (+08)
	(envelope-from Chunyan.Zhang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4SwlLx5gQHz2PgWHy;
	Thu, 21 Dec 2023 17:22:17 +0800 (CST)
Received: from ubt.spreadtrum.com (10.0.73.88) by BJMBX02.spreadtrum.com
 (10.0.64.8) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Thu, 21 Dec
 2023 17:28:33 +0800
From: Chunyan Zhang <chunyan.zhang@unisoc.com>
To: Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, Baolin Wang <baolin.wang@linux.alibaba.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH 1/3] arm64: dts: sprd: Removed unused clock references from etm nodes
Date: Thu, 21 Dec 2023 17:28:22 +0800
Message-ID: <20231221092824.1169453-1-chunyan.zhang@unisoc.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 3BL9SZV7042635

Remove these unused clock references to fix dtbs_check warnings:

etm@3f740000: clocks: [[11], [35, 34], [36, 8]] is too long
etm@3f740000: clock-names:1: 'atclk' was expected
etm@3f740000: clock-names: ['apb_pclk', 'clk_cs', 'cs_src'] is too long

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 arch/arm64/boot/dts/sprd/ums512.dtsi | 32 ++++++++++++++--------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/sprd/ums512.dtsi b/arch/arm64/boot/dts/sprd/ums512.dtsi
index 024be594c47d..012b3a4bbe7c 100644
--- a/arch/arm64/boot/dts/sprd/ums512.dtsi
+++ b/arch/arm64/boot/dts/sprd/ums512.dtsi
@@ -682,8 +682,8 @@ etm0: etm@3f040000 {
 			compatible = "arm,coresight-etm4x", "arm,primecell";
 			reg = <0 0x3f040000 0 0x1000>;
 			cpu = <&CPU0>;
-			clocks = <&ext_26m>, <&aon_clk CLK_CSSYS>, <&pll2 CLK_TWPLL_512M>;
-			clock-names = "apb_pclk", "clk_cs", "cs_src";
+			clocks = <&ext_26m>;
+			clock-names = "apb_pclk";
 
 			out-ports {
 				port {
@@ -699,8 +699,8 @@ etm1: etm@3f140000 {
 			compatible = "arm,coresight-etm4x", "arm,primecell";
 			reg = <0 0x3f140000 0 0x1000>;
 			cpu = <&CPU1>;
-			clocks = <&ext_26m>, <&aon_clk CLK_CSSYS>, <&pll2 CLK_TWPLL_512M>;
-			clock-names = "apb_pclk", "clk_cs", "cs_src";
+			clocks = <&ext_26m>;
+			clock-names = "apb_pclk";
 
 			out-ports {
 				port {
@@ -716,8 +716,8 @@ etm2: etm@3f240000 {
 			compatible = "arm,coresight-etm4x", "arm,primecell";
 			reg = <0 0x3f240000 0 0x1000>;
 			cpu = <&CPU2>;
-			clocks = <&ext_26m>, <&aon_clk CLK_CSSYS>, <&pll2 CLK_TWPLL_512M>;
-			clock-names = "apb_pclk", "clk_cs", "cs_src";
+			clocks = <&ext_26m>;
+			clock-names = "apb_pclk";
 
 			out-ports {
 				port {
@@ -733,8 +733,8 @@ etm3: etm@3f340000 {
 			compatible = "arm,coresight-etm4x", "arm,primecell";
 			reg = <0 0x3f340000 0 0x1000>;
 			cpu = <&CPU3>;
-			clocks = <&ext_26m>, <&aon_clk CLK_CSSYS>, <&pll2 CLK_TWPLL_512M>;
-			clock-names = "apb_pclk", "clk_cs", "cs_src";
+			clocks = <&ext_26m>;
+			clock-names = "apb_pclk";
 
 			out-ports {
 				port {
@@ -750,8 +750,8 @@ etm4: etm@3f440000 {
 			compatible = "arm,coresight-etm4x", "arm,primecell";
 			reg = <0 0x3f440000 0 0x1000>;
 			cpu = <&CPU4>;
-			clocks = <&ext_26m>, <&aon_clk CLK_CSSYS>, <&pll2 CLK_TWPLL_512M>;
-			clock-names = "apb_pclk", "clk_cs", "cs_src";
+			clocks = <&ext_26m>;
+			clock-names = "apb_pclk";
 
 			out-ports {
 				port {
@@ -767,8 +767,8 @@ etm5: etm@3f540000 {
 			compatible = "arm,coresight-etm4x", "arm,primecell";
 			reg = <0 0x3f540000 0 0x1000>;
 			cpu = <&CPU5>;
-			clocks = <&ext_26m>, <&aon_clk CLK_CSSYS>, <&pll2 CLK_TWPLL_512M>;
-			clock-names = "apb_pclk", "clk_cs", "cs_src";
+			clocks = <&ext_26m>;
+			clock-names = "apb_pclk";
 
 			out-ports {
 				port {
@@ -784,8 +784,8 @@ etm6: etm@3f640000 {
 			compatible = "arm,coresight-etm4x", "arm,primecell";
 			reg = <0 0x3f640000 0 0x1000>;
 			cpu = <&CPU6>;
-			clocks = <&ext_26m>, <&aon_clk CLK_CSSYS>, <&pll2 CLK_TWPLL_512M>;
-			clock-names = "apb_pclk", "clk_cs", "cs_src";
+			clocks = <&ext_26m>;
+			clock-names = "apb_pclk";
 
 			out-ports {
 				port {
@@ -801,8 +801,8 @@ etm7: etm@3f740000 {
 			compatible = "arm,coresight-etm4x", "arm,primecell";
 			reg = <0 0x3f740000 0 0x1000>;
 			cpu = <&CPU7>;
-			clocks = <&ext_26m>, <&aon_clk CLK_CSSYS>, <&pll2 CLK_TWPLL_512M>;
-			clock-names = "apb_pclk", "clk_cs", "cs_src";
+			clocks = <&ext_26m>;
+			clock-names = "apb_pclk";
 
 			out-ports {
 				port {
-- 
2.41.0


