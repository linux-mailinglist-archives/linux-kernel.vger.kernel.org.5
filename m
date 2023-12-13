Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C6D810B07
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 08:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378745AbjLMHGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 02:06:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378880AbjLMHFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 02:05:52 -0500
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF93A183;
        Tue, 12 Dec 2023 23:05:48 -0800 (PST)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
        by Atcsqr.andestech.com with ESMTP id 3BD74DLb032612;
        Wed, 13 Dec 2023 15:04:13 +0800 (+08)
        (envelope-from peterlin@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; Wed, 13 Dec 2023
 15:04:09 +0800
From:   Yu Chien Peter Lin <peterlin@andestech.com>
To:     <acme@kernel.org>, <adrian.hunter@intel.com>,
        <ajones@ventanamicro.com>, <alexander.shishkin@linux.intel.com>,
        <andre.przywara@arm.com>, <anup@brainfault.org>,
        <aou@eecs.berkeley.edu>, <atishp@atishpatra.org>,
        <conor+dt@kernel.org>, <conor.dooley@microchip.com>,
        <conor@kernel.org>, <devicetree@vger.kernel.org>,
        <dminus@andestech.com>, <evan@rivosinc.com>,
        <geert+renesas@glider.be>, <guoren@kernel.org>, <heiko@sntech.de>,
        <irogers@google.com>, <jernej.skrabec@gmail.com>,
        <jolsa@kernel.org>, <jszhang@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-sunxi@lists.linux.dev>,
        <locus84@andestech.com>, <magnus.damm@gmail.com>,
        <mark.rutland@arm.com>, <mingo@redhat.com>, <n.shubin@yadro.com>,
        <namhyung@kernel.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <peterlin@andestech.com>,
        <peterz@infradead.org>, <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <rdunlap@infradead.org>, <robh+dt@kernel.org>,
        <samuel@sholland.org>, <sunilvl@ventanamicro.com>,
        <tglx@linutronix.de>, <tim609@andestech.com>, <uwu@icenowy.me>,
        <wens@csie.org>, <will@kernel.org>, <ycliang@andestech.com>,
        <inochiama@outlook.com>
Subject: [PATCH v5 13/16] riscv: dts: sophgo: Add T-Head PMU extension for sg2042
Date:   Wed, 13 Dec 2023 15:02:58 +0800
Message-ID: <20231213070301.1684751-14-peterlin@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213070301.1684751-1-peterlin@andestech.com>
References: <20231213070301.1684751-1-peterlin@andestech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 3BD74DLb032612
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xtheadpmu stands for T-Head Performance Monitor Unit extension.
Based on the added T-Head PMU ISA string, the SBI PMU driver
will make use of the non-standard irq source.

Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
---
Changes v4 -> v5:
  - New patch
---
 arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi | 128 ++++++++++----------
 1 file changed, 64 insertions(+), 64 deletions(-)

diff --git a/arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi b/arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi
index b136b6c4128c..1d0b236f2e7a 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi
@@ -260,7 +260,7 @@ cpu0: cpu@0 {
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
 					       "zicntr", "zicsr", "zifencei",
-					       "zihpm";
+					       "zihpm", "xtheadpmu";
 			reg = <0>;
 			i-cache-block-size = <64>;
 			i-cache-size = <65536>;
@@ -285,7 +285,7 @@ cpu1: cpu@1 {
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
 					       "zicntr", "zicsr", "zifencei",
-					       "zihpm";
+					       "zihpm", "xtheadpmu";
 			reg = <1>;
 			i-cache-block-size = <64>;
 			i-cache-size = <65536>;
@@ -310,7 +310,7 @@ cpu2: cpu@2 {
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
 					       "zicntr", "zicsr", "zifencei",
-					       "zihpm";
+					       "zihpm", "xtheadpmu";
 			reg = <2>;
 			i-cache-block-size = <64>;
 			i-cache-size = <65536>;
@@ -335,7 +335,7 @@ cpu3: cpu@3 {
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
 					       "zicntr", "zicsr", "zifencei",
-					       "zihpm";
+					       "zihpm", "xtheadpmu";
 			reg = <3>;
 			i-cache-block-size = <64>;
 			i-cache-size = <65536>;
@@ -360,7 +360,7 @@ cpu4: cpu@4 {
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
 					       "zicntr", "zicsr", "zifencei",
-					       "zihpm";
+					       "zihpm", "xtheadpmu";
 			reg = <4>;
 			i-cache-block-size = <64>;
 			i-cache-size = <65536>;
@@ -385,7 +385,7 @@ cpu5: cpu@5 {
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
 					       "zicntr", "zicsr", "zifencei",
-					       "zihpm";
+					       "zihpm", "xtheadpmu";
 			reg = <5>;
 			i-cache-block-size = <64>;
 			i-cache-size = <65536>;
@@ -410,7 +410,7 @@ cpu6: cpu@6 {
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
 					       "zicntr", "zicsr", "zifencei",
-					       "zihpm";
+					       "zihpm", "xtheadpmu";
 			reg = <6>;
 			i-cache-block-size = <64>;
 			i-cache-size = <65536>;
@@ -435,7 +435,7 @@ cpu7: cpu@7 {
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
 					       "zicntr", "zicsr", "zifencei",
-					       "zihpm";
+					       "zihpm", "xtheadpmu";
 			reg = <7>;
 			i-cache-block-size = <64>;
 			i-cache-size = <65536>;
@@ -460,7 +460,7 @@ cpu8: cpu@8 {
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
 					       "zicntr", "zicsr", "zifencei",
-					       "zihpm";
+					       "zihpm", "xtheadpmu";
 			reg = <8>;
 			i-cache-block-size = <64>;
 			i-cache-size = <65536>;
@@ -485,7 +485,7 @@ cpu9: cpu@9 {
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
 					       "zicntr", "zicsr", "zifencei",
-					       "zihpm";
+					       "zihpm", "xtheadpmu";
 			reg = <9>;
 			i-cache-block-size = <64>;
 			i-cache-size = <65536>;
@@ -510,7 +510,7 @@ cpu10: cpu@10 {
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
 					       "zicntr", "zicsr", "zifencei",
-					       "zihpm";
+					       "zihpm", "xtheadpmu";
 			reg = <10>;
 			i-cache-block-size = <64>;
 			i-cache-size = <65536>;
@@ -535,7 +535,7 @@ cpu11: cpu@11 {
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
 					       "zicntr", "zicsr", "zifencei",
-					       "zihpm";
+					       "zihpm", "xtheadpmu";
 			reg = <11>;
 			i-cache-block-size = <64>;
 			i-cache-size = <65536>;
@@ -560,7 +560,7 @@ cpu12: cpu@12 {
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
 					       "zicntr", "zicsr", "zifencei",
-					       "zihpm";
+					       "zihpm", "xtheadpmu";
 			reg = <12>;
 			i-cache-block-size = <64>;
 			i-cache-size = <65536>;
@@ -585,7 +585,7 @@ cpu13: cpu@13 {
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
 					       "zicntr", "zicsr", "zifencei",
-					       "zihpm";
+					       "zihpm", "xtheadpmu";
 			reg = <13>;
 			i-cache-block-size = <64>;
 			i-cache-size = <65536>;
@@ -610,7 +610,7 @@ cpu14: cpu@14 {
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
 					       "zicntr", "zicsr", "zifencei",
-					       "zihpm";
+					       "zihpm", "xtheadpmu";
 			reg = <14>;
 			i-cache-block-size = <64>;
 			i-cache-size = <65536>;
@@ -635,7 +635,7 @@ cpu15: cpu@15 {
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
 					       "zicntr", "zicsr", "zifencei",
-					       "zihpm";
+					       "zihpm", "xtheadpmu";
 			reg = <15>;
 			i-cache-block-size = <64>;
 			i-cache-size = <65536>;
@@ -660,7 +660,7 @@ cpu16: cpu@16 {
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
 					       "zicntr", "zicsr", "zifencei",
-					       "zihpm";
+					       "zihpm", "xtheadpmu";
 			reg = <16>;
 			i-cache-block-size = <64>;
 			i-cache-size = <65536>;
@@ -685,7 +685,7 @@ cpu17: cpu@17 {
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
 					       "zicntr", "zicsr", "zifencei",
-					       "zihpm";
+					       "zihpm", "xtheadpmu";
 			reg = <17>;
 			i-cache-block-size = <64>;
 			i-cache-size = <65536>;
@@ -710,7 +710,7 @@ cpu18: cpu@18 {
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
 					       "zicntr", "zicsr", "zifencei",
-					       "zihpm";
+					       "zihpm", "xtheadpmu";
 			reg = <18>;
 			i-cache-block-size = <64>;
 			i-cache-size = <65536>;
@@ -735,7 +735,7 @@ cpu19: cpu@19 {
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
 					       "zicntr", "zicsr", "zifencei",
-					       "zihpm";
+					       "zihpm", "xtheadpmu";
 			reg = <19>;
 			i-cache-block-size = <64>;
 			i-cache-size = <65536>;
@@ -760,7 +760,7 @@ cpu20: cpu@20 {
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
 					       "zicntr", "zicsr", "zifencei",
-					       "zihpm";
+					       "zihpm", "xtheadpmu";
 			reg = <20>;
 			i-cache-block-size = <64>;
 			i-cache-size = <65536>;
@@ -785,7 +785,7 @@ cpu21: cpu@21 {
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
 					       "zicntr", "zicsr", "zifencei",
-					       "zihpm";
+					       "zihpm", "xtheadpmu";
 			reg = <21>;
 			i-cache-block-size = <64>;
 			i-cache-size = <65536>;
@@ -810,7 +810,7 @@ cpu22: cpu@22 {
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
 					       "zicntr", "zicsr", "zifencei",
-					       "zihpm";
+					       "zihpm", "xtheadpmu";
 			reg = <22>;
 			i-cache-block-size = <64>;
 			i-cache-size = <65536>;
@@ -835,7 +835,7 @@ cpu23: cpu@23 {
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
 					       "zicntr", "zicsr", "zifencei",
-					       "zihpm";
+					       "zihpm", "xtheadpmu";
 			reg = <23>;
 			i-cache-block-size = <64>;
 			i-cache-size = <65536>;
@@ -860,7 +860,7 @@ cpu24: cpu@24 {
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
 					       "zicntr", "zicsr", "zifencei",
-					       "zihpm";
+					       "zihpm", "xtheadpmu";
 			reg = <24>;
 			i-cache-block-size = <64>;
 			i-cache-size = <65536>;
@@ -885,7 +885,7 @@ cpu25: cpu@25 {
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
 					       "zicntr", "zicsr", "zifencei",
-					       "zihpm";
+					       "zihpm", "xtheadpmu";
 			reg = <25>;
 			i-cache-block-size = <64>;
 			i-cache-size = <65536>;
@@ -910,7 +910,7 @@ cpu26: cpu@26 {
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
 					       "zicntr", "zicsr", "zifencei",
-					       "zihpm";
+					       "zihpm", "xtheadpmu";
 			reg = <26>;
 			i-cache-block-size = <64>;
 			i-cache-size = <65536>;
@@ -935,7 +935,7 @@ cpu27: cpu@27 {
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
 					       "zicntr", "zicsr", "zifencei",
-					       "zihpm";
+					       "zihpm", "xtheadpmu";
 			reg = <27>;
 			i-cache-block-size = <64>;
 			i-cache-size = <65536>;
@@ -960,7 +960,7 @@ cpu28: cpu@28 {
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
 					       "zicntr", "zicsr", "zifencei",
-					       "zihpm";
+					       "zihpm", "xtheadpmu";
 			reg = <28>;
 			i-cache-block-size = <64>;
 			i-cache-size = <65536>;
@@ -985,7 +985,7 @@ cpu29: cpu@29 {
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
 					       "zicntr", "zicsr", "zifencei",
-					       "zihpm";
+					       "zihpm", "xtheadpmu";
 			reg = <29>;
 			i-cache-block-size = <64>;
 			i-cache-size = <65536>;
@@ -1010,7 +1010,7 @@ cpu30: cpu@30 {
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
 					       "zicntr", "zicsr", "zifencei",
-					       "zihpm";
+					       "zihpm", "xtheadpmu";
 			reg = <30>;
 			i-cache-block-size = <64>;
 			i-cache-size = <65536>;
@@ -1035,7 +1035,7 @@ cpu31: cpu@31 {
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
 					       "zicntr", "zicsr", "zifencei",
-					       "zihpm";
+					       "zihpm", "xtheadpmu";
 			reg = <31>;
 			i-cache-block-size = <64>;
 			i-cache-size = <65536>;
@@ -1060,7 +1060,7 @@ cpu32: cpu@32 {
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
 					       "zicntr", "zicsr", "zifencei",
-					       "zihpm";
+					       "zihpm", "xtheadpmu";
 			reg = <32>;
 			i-cache-block-size = <64>;
 			i-cache-size = <65536>;
@@ -1085,7 +1085,7 @@ cpu33: cpu@33 {
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
 					       "zicntr", "zicsr", "zifencei",
-					       "zihpm";
+					       "zihpm", "xtheadpmu";
 			reg = <33>;
 			i-cache-block-size = <64>;
 			i-cache-size = <65536>;
@@ -1110,7 +1110,7 @@ cpu34: cpu@34 {
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
 					       "zicntr", "zicsr", "zifencei",
-					       "zihpm";
+					       "zihpm", "xtheadpmu";
 			reg = <34>;
 			i-cache-block-size = <64>;
 			i-cache-size = <65536>;
@@ -1135,7 +1135,7 @@ cpu35: cpu@35 {
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
 					       "zicntr", "zicsr", "zifencei",
-					       "zihpm";
+					       "zihpm", "xtheadpmu";
 			reg = <35>;
 			i-cache-block-size = <64>;
 			i-cache-size = <65536>;
@@ -1160,7 +1160,7 @@ cpu36: cpu@36 {
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
 					       "zicntr", "zicsr", "zifencei",
-					       "zihpm";
+					       "zihpm", "xtheadpmu";
 			reg = <36>;
 			i-cache-block-size = <64>;
 			i-cache-size = <65536>;
@@ -1185,7 +1185,7 @@ cpu37: cpu@37 {
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
 					       "zicntr", "zicsr", "zifencei",
-					       "zihpm";
+					       "zihpm", "xtheadpmu";
 			reg = <37>;
 			i-cache-block-size = <64>;
 			i-cache-size = <65536>;
@@ -1210,7 +1210,7 @@ cpu38: cpu@38 {
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
 					       "zicntr", "zicsr", "zifencei",
-					       "zihpm";
+					       "zihpm", "xtheadpmu";
 			reg = <38>;
 			i-cache-block-size = <64>;
 			i-cache-size = <65536>;
@@ -1235,7 +1235,7 @@ cpu39: cpu@39 {
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
 					       "zicntr", "zicsr", "zifencei",
-					       "zihpm";
+					       "zihpm", "xtheadpmu";
 			reg = <39>;
 			i-cache-block-size = <64>;
 			i-cache-size = <65536>;
@@ -1260,7 +1260,7 @@ cpu40: cpu@40 {
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
 					       "zicntr", "zicsr", "zifencei",
-					       "zihpm";
+					       "zihpm", "xtheadpmu";
 			reg = <40>;
 			i-cache-block-size = <64>;
 			i-cache-size = <65536>;
@@ -1285,7 +1285,7 @@ cpu41: cpu@41 {
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
 					       "zicntr", "zicsr", "zifencei",
-					       "zihpm";
+					       "zihpm", "xtheadpmu";
 			reg = <41>;
 			i-cache-block-size = <64>;
 			i-cache-size = <65536>;
@@ -1310,7 +1310,7 @@ cpu42: cpu@42 {
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
 					       "zicntr", "zicsr", "zifencei",
-					       "zihpm";
+					       "zihpm", "xtheadpmu";
 			reg = <42>;
 			i-cache-block-size = <64>;
 			i-cache-size = <65536>;
@@ -1335,7 +1335,7 @@ cpu43: cpu@43 {
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
 					       "zicntr", "zicsr", "zifencei",
-					       "zihpm";
+					       "zihpm", "xtheadpmu";
 			reg = <43>;
 			i-cache-block-size = <64>;
 			i-cache-size = <65536>;
@@ -1360,7 +1360,7 @@ cpu44: cpu@44 {
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
 					       "zicntr", "zicsr", "zifencei",
-					       "zihpm";
+					       "zihpm", "xtheadpmu";
 			reg = <44>;
 			i-cache-block-size = <64>;
 			i-cache-size = <65536>;
@@ -1385,7 +1385,7 @@ cpu45: cpu@45 {
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
 					       "zicntr", "zicsr", "zifencei",
-					       "zihpm";
+					       "zihpm", "xtheadpmu";
 			reg = <45>;
 			i-cache-block-size = <64>;
 			i-cache-size = <65536>;
@@ -1410,7 +1410,7 @@ cpu46: cpu@46 {
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
 					       "zicntr", "zicsr", "zifencei",
-					       "zihpm";
+					       "zihpm", "xtheadpmu";
 			reg = <46>;
 			i-cache-block-size = <64>;
 			i-cache-size = <65536>;
@@ -1435,7 +1435,7 @@ cpu47: cpu@47 {
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
 					       "zicntr", "zicsr", "zifencei",
-					       "zihpm";
+					       "zihpm", "xtheadpmu";
 			reg = <47>;
 			i-cache-block-size = <64>;
 			i-cache-size = <65536>;
@@ -1460,7 +1460,7 @@ cpu48: cpu@48 {
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
 					       "zicntr", "zicsr", "zifencei",
-					       "zihpm";
+					       "zihpm", "xtheadpmu";
 			reg = <48>;
 			i-cache-block-size = <64>;
 			i-cache-size = <65536>;
@@ -1485,7 +1485,7 @@ cpu49: cpu@49 {
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
 					       "zicntr", "zicsr", "zifencei",
-					       "zihpm";
+					       "zihpm", "xtheadpmu";
 			reg = <49>;
 			i-cache-block-size = <64>;
 			i-cache-size = <65536>;
@@ -1510,7 +1510,7 @@ cpu50: cpu@50 {
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
 					       "zicntr", "zicsr", "zifencei",
-					       "zihpm";
+					       "zihpm", "xtheadpmu";
 			reg = <50>;
 			i-cache-block-size = <64>;
 			i-cache-size = <65536>;
@@ -1535,7 +1535,7 @@ cpu51: cpu@51 {
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
 					       "zicntr", "zicsr", "zifencei",
-					       "zihpm";
+					       "zihpm", "xtheadpmu";
 			reg = <51>;
 			i-cache-block-size = <64>;
 			i-cache-size = <65536>;
@@ -1560,7 +1560,7 @@ cpu52: cpu@52 {
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
 					       "zicntr", "zicsr", "zifencei",
-					       "zihpm";
+					       "zihpm", "xtheadpmu";
 			reg = <52>;
 			i-cache-block-size = <64>;
 			i-cache-size = <65536>;
@@ -1585,7 +1585,7 @@ cpu53: cpu@53 {
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
 					       "zicntr", "zicsr", "zifencei",
-					       "zihpm";
+					       "zihpm", "xtheadpmu";
 			reg = <53>;
 			i-cache-block-size = <64>;
 			i-cache-size = <65536>;
@@ -1610,7 +1610,7 @@ cpu54: cpu@54 {
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
 					       "zicntr", "zicsr", "zifencei",
-					       "zihpm";
+					       "zihpm", "xtheadpmu";
 			reg = <54>;
 			i-cache-block-size = <64>;
 			i-cache-size = <65536>;
@@ -1635,7 +1635,7 @@ cpu55: cpu@55 {
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
 					       "zicntr", "zicsr", "zifencei",
-					       "zihpm";
+					       "zihpm", "xtheadpmu";
 			reg = <55>;
 			i-cache-block-size = <64>;
 			i-cache-size = <65536>;
@@ -1660,7 +1660,7 @@ cpu56: cpu@56 {
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
 					       "zicntr", "zicsr", "zifencei",
-					       "zihpm";
+					       "zihpm", "xtheadpmu";
 			reg = <56>;
 			i-cache-block-size = <64>;
 			i-cache-size = <65536>;
@@ -1685,7 +1685,7 @@ cpu57: cpu@57 {
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
 					       "zicntr", "zicsr", "zifencei",
-					       "zihpm";
+					       "zihpm", "xtheadpmu";
 			reg = <57>;
 			i-cache-block-size = <64>;
 			i-cache-size = <65536>;
@@ -1710,7 +1710,7 @@ cpu58: cpu@58 {
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
 					       "zicntr", "zicsr", "zifencei",
-					       "zihpm";
+					       "zihpm", "xtheadpmu";
 			reg = <58>;
 			i-cache-block-size = <64>;
 			i-cache-size = <65536>;
@@ -1735,7 +1735,7 @@ cpu59: cpu@59 {
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
 					       "zicntr", "zicsr", "zifencei",
-					       "zihpm";
+					       "zihpm", "xtheadpmu";
 			reg = <59>;
 			i-cache-block-size = <64>;
 			i-cache-size = <65536>;
@@ -1760,7 +1760,7 @@ cpu60: cpu@60 {
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
 					       "zicntr", "zicsr", "zifencei",
-					       "zihpm";
+					       "zihpm", "xtheadpmu";
 			reg = <60>;
 			i-cache-block-size = <64>;
 			i-cache-size = <65536>;
@@ -1785,7 +1785,7 @@ cpu61: cpu@61 {
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
 					       "zicntr", "zicsr", "zifencei",
-					       "zihpm";
+					       "zihpm", "xtheadpmu";
 			reg = <61>;
 			i-cache-block-size = <64>;
 			i-cache-size = <65536>;
@@ -1810,7 +1810,7 @@ cpu62: cpu@62 {
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
 					       "zicntr", "zicsr", "zifencei",
-					       "zihpm";
+					       "zihpm", "xtheadpmu";
 			reg = <62>;
 			i-cache-block-size = <64>;
 			i-cache-size = <65536>;
@@ -1835,7 +1835,7 @@ cpu63: cpu@63 {
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
 					       "zicntr", "zicsr", "zifencei",
-					       "zihpm";
+					       "zihpm", "xtheadpmu";
 			reg = <63>;
 			i-cache-block-size = <64>;
 			i-cache-size = <65536>;
-- 
2.34.1

