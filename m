Return-Path: <linux-kernel+bounces-106476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E1587EF23
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1CA91C2207D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C72055C28;
	Mon, 18 Mar 2024 17:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDlxi31b"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D62A55780;
	Mon, 18 Mar 2024 17:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710783890; cv=none; b=DQ2Vl+XCIG83L1Wgq4Q47iKD9YTgiNCu+a6WemdIdFXPQoBFHfKOq/Gei0CiUUNHxc/QNtCLb+klnVVxgO9to4ygHxnarUwltURZcjtdWRI9CQucakmRo9vo/TAqNIS2IFZkgTdNw+IxsqL6xwAmBSOHPPeMQtwun9f/5nX18Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710783890; c=relaxed/simple;
	bh=qfKaM5LBkZKQTIItZKKvgOoaUbhM+c7eSygjt0v+vqQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cV0mwPWi3rcfvbFSX5AfDA7MMY4exjSulIwNENmK/eEnrZNJC3nFdYkw1NEfpVvmhmVR8OaqWdLLPwnLtT0l+rBkx4XlNGqXBCbdEWO49REa/Nu4kFcctn5NAG6q8CXxA+gin/QWz7YOHJ6xFYdCcOwuE0oQJUDe/2ydV3vH+zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lDlxi31b; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-513d599dbabso5106146e87.1;
        Mon, 18 Mar 2024 10:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710783887; x=1711388687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6k38GrEZImqBDaAsrtBm+TtkuYBS+WSHMTIZNXDlWsM=;
        b=lDlxi31b1Uw0EZ3i7Sqp5RfGErhfDWMp/n1Ite7Z1z9fcYBBZly3V0jdWKl4XSg/v7
         oo1QMUZNDTsuDkwwdx+GnT7gWl8Cxzw9i9oJST46rRJWeHLRXikQA+hBW6o7sZlz6WC/
         NvQ8jH9UjW92bNhCTdBR5ZJ7mAQcZKE6F6wHpGobnoGbSfOlIp4dsTmU+NPzXVToXGkw
         fDsxfe+0Fc2zlb3x9yKZkTu2XXmmeK2LqoA/RDTbIclM47YHZgJG8vCaSwvKyWs4w5Lm
         e9TI/Qmjw61tF2ZJ0FwBlres5mRyCFKsDMYAkbDpYyiKCdB6IOfNp9b0+eT48vpb0lsD
         hi+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710783887; x=1711388687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6k38GrEZImqBDaAsrtBm+TtkuYBS+WSHMTIZNXDlWsM=;
        b=YBTDRi9jUY2OteNnRwS6NdU5fHsL5Taq3SkkNlU1XsiCTGC2V3iU3S0GmsuFLDS5NX
         B+k5S2Yf5l5aU3iwj6mCpx7qJXni2d/xZQWP4EVUq2vKE6aIuyPmigN4TZC+AYbT6uDL
         I7r54gQnWnJczB15WKnJsa0KqNbeHSy4ZbnxcJpmkCoHWPrzAgsKuOgj/zb+DpUysPuM
         shNVlay/q9ukMqNckP+1wq4UPuJvo9efUUYKsQPI2Lfh2DVa/O8K6cuWdhthqGjpJxcL
         veNhs0p6atKXUiCWZmiBxBKana6fp6NzS40Dw8iAD7KMZ2Q4y+HF1Jq8PqwkMARz9Fsv
         4uaw==
X-Forwarded-Encrypted: i=1; AJvYcCXb+Hi0lYhAFpHYKJDVwO6OoF3WBKV7MI1C91LFXrKMuTSoEiORt7bX9TsMZ54//TOdoUayaKpTyKSPBXLYZ+vj2ZY4ayKCX1w5gBg+q8Nmb68GzqGowCxFFE45ejv7hlx8vWh2PghtfV3S4a58
X-Gm-Message-State: AOJu0Yz8XPIqMVcgLMH+6SN+usIbIvwp7iy0SIA04opSpm1mASi2H9Gj
	1nKUUUXCRSFuqBuip3IZGeMj6YP2i8D9DYP3i8HH8edBNY3YAMa0
X-Google-Smtp-Source: AGHT+IEkUiXLyxU5UPRstO9MUMp5QcKxm7rDr3KID4QPK+LYjmiPv0g1RPmMqWb8AsO3TXBOvAdSLA==
X-Received: by 2002:ac2:442e:0:b0:513:db34:7caf with SMTP id w14-20020ac2442e000000b00513db347cafmr146224lfl.17.1710783886410;
        Mon, 18 Mar 2024 10:44:46 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:c23f:76ae:8149:291])
        by smtp.gmail.com with ESMTPSA id n20-20020a05600c501400b00414112a6159sm3433274wmr.44.2024.03.18.10.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 10:44:45 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] ARM: dts: renesas: r7s72100: Add 'interrupt-names' property in SCIF nodes
Date: Mon, 18 Mar 2024 17:43:45 +0000
Message-Id: <20240318174345.46824-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add 'interrupt-names' property into SCIF nodes for clarity.

This allows us to update the DT binding to mark 'interrupt-names' property
as required for all the SoCs which have multiple interrupts and also allow
us to validate the DT binding doc using dtbs_check.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
Note, all the SoCs with multiple interrupts using renesas,scif.yaml already have
interrupt-names property apart from this SoC. This change allows us to validate the
DT.
---
 arch/arm/boot/dts/renesas/r7s72100.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/renesas/r7s72100.dtsi b/arch/arm/boot/dts/renesas/r7s72100.dtsi
index e6d8da6faffb..08ea4c551ed0 100644
--- a/arch/arm/boot/dts/renesas/r7s72100.dtsi
+++ b/arch/arm/boot/dts/renesas/r7s72100.dtsi
@@ -125,6 +125,7 @@ scif0: serial@e8007000 {
 				     <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi", "bri";
 			clocks = <&mstp4_clks R7S72100_CLK_SCIF0>;
 			clock-names = "fck";
 			power-domains = <&cpg_clocks>;
@@ -138,6 +139,7 @@ scif1: serial@e8007800 {
 				     <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi", "bri";
 			clocks = <&mstp4_clks R7S72100_CLK_SCIF1>;
 			clock-names = "fck";
 			power-domains = <&cpg_clocks>;
@@ -151,6 +153,7 @@ scif2: serial@e8008000 {
 				     <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi", "bri";
 			clocks = <&mstp4_clks R7S72100_CLK_SCIF2>;
 			clock-names = "fck";
 			power-domains = <&cpg_clocks>;
@@ -164,6 +167,7 @@ scif3: serial@e8008800 {
 				     <GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi", "bri";
 			clocks = <&mstp4_clks R7S72100_CLK_SCIF3>;
 			clock-names = "fck";
 			power-domains = <&cpg_clocks>;
@@ -177,6 +181,7 @@ scif4: serial@e8009000 {
 				     <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 205 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi", "bri";
 			clocks = <&mstp4_clks R7S72100_CLK_SCIF4>;
 			clock-names = "fck";
 			power-domains = <&cpg_clocks>;
@@ -190,6 +195,7 @@ scif5: serial@e8009800 {
 				     <GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi", "bri";
 			clocks = <&mstp4_clks R7S72100_CLK_SCIF5>;
 			clock-names = "fck";
 			power-domains = <&cpg_clocks>;
@@ -203,6 +209,7 @@ scif6: serial@e800a000 {
 				     <GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 213 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi", "bri";
 			clocks = <&mstp4_clks R7S72100_CLK_SCIF6>;
 			clock-names = "fck";
 			power-domains = <&cpg_clocks>;
@@ -216,6 +223,7 @@ scif7: serial@e800a800 {
 				     <GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi", "bri";
 			clocks = <&mstp4_clks R7S72100_CLK_SCIF7>;
 			clock-names = "fck";
 			power-domains = <&cpg_clocks>;
-- 
2.34.1


