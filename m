Return-Path: <linux-kernel+bounces-49602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDE7846C4D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 639F928E238
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A942F78689;
	Fri,  2 Feb 2024 09:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5y8ZaRr"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEBD7764D;
	Fri,  2 Feb 2024 09:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706866768; cv=none; b=dzWEend9CAxK7Pt8OyCBnCTQKV9mIrtZNphWAPpfFl7Jgbh8nEynRBFeDK88Ppg5fe/YZiYCh9Mcfdk8N7KzU6Js3aoULtOuicN92IgRdm6zOfG9XdsOI21ZhId2Shkx5KRiBVNH/peWvmkKhecQwXdQ6UzymzVYXXU1nvsH1Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706866768; c=relaxed/simple;
	bh=AELWcEChVe4gLlvFl5wXNizOpNQJ4jC/Am8toSfCdE8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZVNlR/IGn+kg83BAHi99qIw2jq+BmcbhLEMCmPvEeGH9zWWbEWPw4WwWk+s0J1qB0PmNk7eRGvEJ4rbTXIGG6c0qI0yspTdEFRCgVopn2GnxHirULc/vX1MvK9GpScvrUSc3F3qU2IJgxKJgmPag3XyG3Q4wrWShvyFbIiutUw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k5y8ZaRr; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51124d86022so3021460e87.0;
        Fri, 02 Feb 2024 01:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706866765; x=1707471565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MqRHHC9ZBCtO5NmFJWDb/lxnjNADYyih1vTffk93RiI=;
        b=k5y8ZaRr71TJ8rNZ6z4WYz8jRVizpufnXHULwwP6Api+bTLsMmXW1kaCzUPQ88nn+N
         M3BeYRgJcsUhIEXDfIyX1yuNVLi+z+T6MbqDxKu57NRKRuAmpxeFFwl10AqN5RZuKO6t
         bNkFfhCSTA5WWGff9KiO1joJnIFJ5W817YO9Z10I0GiznATYi3vMmnh5K5nR+Qf9q9Zt
         cVnV8HLgZd4YCmQd53qF39U8Rxsw1RqeW+gFTzlAshvf3vXzATNtdc5Xj8/S92Be1z8F
         uQB+syQi6SARfrn+S5fZ0g07xxMpGH76qDeGGO2IcGq5BodAV/xDrMJQogK4m4m2QKHP
         +DQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706866765; x=1707471565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MqRHHC9ZBCtO5NmFJWDb/lxnjNADYyih1vTffk93RiI=;
        b=nilNT0yMAXspGMcHOI0zEAwaEhxoLJvCM5olQUISfGRbFybAsw1p8wEzXN1UsKjTYt
         eY/Oagy5a+Sft6mjZrPtZBfTCZeIrBtLb9KCOWIQx8blQu2KCo43wmgnN9L131NcmgzD
         TXkrlKSWFcAqXJ5VAunDzPxITkuim+8aUasT37thUbK9YofsJ0FwOZE/rf3kQkVrDrhh
         nLg7EpCz6MvJglyvwCGajEhNqJPmpHGR7l+eCanDfGmVx/Zb2vj6276OGbEP9nHYhmQ0
         HbqCoMssKeDS2v3PSwekh8CXpbIzMhqLBzAVIvxJjmtI8wt+Q3HLOPOafG7sTL6EKq39
         13Ig==
X-Gm-Message-State: AOJu0Yyba/2mmvBVsHUZMZkf1tYM2b4FVxwnvvnA+7ouNXysnqKpLR6h
	Xwhysg/TM4kzUOa+BVlc+Ejwyg2EHWWCs5qqYwOACeLwgc/G8T0oBesS3RFFnRQ=
X-Google-Smtp-Source: AGHT+IEJfx6XAqYXMAIa0p+t0zH3vWHxwgqvk0lGQNaaRWs6vBOi6ibGjoscpmELLS6VnZaMkLU5PA==
X-Received: by 2002:ac2:5df1:0:b0:511:3139:7441 with SMTP id z17-20020ac25df1000000b0051131397441mr2577131lfq.58.1706866764538;
        Fri, 02 Feb 2024 01:39:24 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXSK9PRdWg6OXOwVI5N/XF7iycIIJdj/uOLC3WtKjbOefyGkrpGb9HKJj3raexl5L6FredL03tfot1udN+MUvT4x4n/rYUT1p3nzTE9FLOBox4ulBYz8JCDKAi2Kgr6xaj6evhib5tzSdJqVIZcdUGy0JNO+jMNapNJ27wGTYj+OeJ/w7NwO/2SvLH47XtRbDhy3ehSjiH4WraVYUIJDhn9fVCbtw6CQORjtN0oVEe+jcJ1VEJ+IpVALsO9zWbhCNlQHf50jvX41gnbhoMKbSg6DvRAcXx1bRrOTSC/FKpUw7GGzoFYMdjgs79zs97WMM1Kf7oZeQXiz436J4ye2a7w/QRpHuAzwRLRjSe9Ie8pEYcK4x7odjmAB9HGTnQf4hRJaYXLJOOTiD/kwGz0ZqpXRCAuzNlUiRKeMEcuswJkv/QsxWfE1IwYCvkptom+ou62lL/HpwgdgiFtZqahTG4bJ+zvgN0h8FDdfmqhHLE=
Received: from prasmi.home ([2a00:23c8:2500:a01:a994:230a:9969:dbf7])
        by smtp.gmail.com with ESMTPSA id bg10-20020a05600c3c8a00b0040fbdf77ca3sm3827530wmb.42.2024.02.02.01.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 01:39:23 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 2/3] arm64: dts: renesas: rz-g2l-family: Add missing interrupts from IRQC IP block
Date: Fri,  2 Feb 2024 09:39:06 +0000
Message-Id: <20240202093907.9465-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202093907.9465-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240202093907.9465-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The IRQC IP block supports Bus error and ECCRAM interrupts. Update the
IRQC node with the missing interrupts, and additionally, include the
'interrupt-names' property in the IRQC node.

Fixes: 5edc51af5b30 ("arm64: dts: renesas: r9a07g044: Add IRQC node")
Fixes: 48ab6eddd8bb ("arm64: dts: renesas: r9a07g043u: Add IRQC node")
Fixes: 379478ab09e0 ("arm64: dts: renesas: r9a07g054: Add IRQC node")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g043u.dtsi | 12 +++++++++--
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi  | 22 ++++++++++++++++++++-
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi  | 22 ++++++++++++++++++++-
 3 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi b/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
index 01d08ebb4a78..964b0a475eee 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
@@ -178,7 +178,13 @@ irqc: interrupt-controller@110a0000 {
 			     <SOC_PERIPHERAL_IRQ(473) IRQ_TYPE_LEVEL_HIGH>,
 			     <SOC_PERIPHERAL_IRQ(474) IRQ_TYPE_LEVEL_HIGH>,
 			     <SOC_PERIPHERAL_IRQ(475) IRQ_TYPE_LEVEL_HIGH>,
-			     <SOC_PERIPHERAL_IRQ(25) IRQ_TYPE_EDGE_RISING>;
+			     <SOC_PERIPHERAL_IRQ(25) IRQ_TYPE_EDGE_RISING>,
+			     <SOC_PERIPHERAL_IRQ(34) IRQ_TYPE_EDGE_RISING>,
+			     <SOC_PERIPHERAL_IRQ(35) IRQ_TYPE_EDGE_RISING>,
+			     <SOC_PERIPHERAL_IRQ(36) IRQ_TYPE_EDGE_RISING>,
+			     <SOC_PERIPHERAL_IRQ(37) IRQ_TYPE_EDGE_RISING>,
+			     <SOC_PERIPHERAL_IRQ(38) IRQ_TYPE_EDGE_RISING>,
+			     <SOC_PERIPHERAL_IRQ(39) IRQ_TYPE_EDGE_RISING>;
 		interrupt-names = "nmi",
 				  "irq0", "irq1", "irq2", "irq3",
 				  "irq4", "irq5", "irq6", "irq7",
@@ -190,7 +196,9 @@ irqc: interrupt-controller@110a0000 {
 				  "tint20", "tint21", "tint22", "tint23",
 				  "tint24", "tint25", "tint26", "tint27",
 				  "tint28", "tint29", "tint30", "tint31",
-				  "bus-err";
+				  "bus-err", "ec7tie1-0", "ec7tie2-0",
+				  "ec7tiovf-0", "ec7tie1-1", "ec7tie2-1",
+				  "ec7tiovf-1";
 		clocks = <&cpg CPG_MOD R9A07G043_IA55_CLK>,
 			<&cpg CPG_MOD R9A07G043_IA55_PCLK>;
 		clock-names = "clk", "pclk";
diff --git a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
index 66f68fc2b241..081d8f49db87 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
@@ -905,7 +905,27 @@ irqc: interrupt-controller@110a0000 {
 				     <GIC_SPI 472 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 473 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 474 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 475 IRQ_TYPE_LEVEL_HIGH>;
+				     <GIC_SPI 475 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 25 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 34 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 35 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 36 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 37 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 38 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 39 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "nmi", "irq0", "irq1", "irq2", "irq3",
+					  "irq4", "irq5", "irq6", "irq7",
+					  "tint0", "tint1", "tint2", "tint3",
+					  "tint4", "tint5", "tint6", "tint7",
+					  "tint8", "tint9", "tint10", "tint11",
+					  "tint12", "tint13", "tint14", "tint15",
+					  "tint16", "tint17", "tint18", "tint19",
+					  "tint20", "tint21", "tint22", "tint23",
+					  "tint24", "tint25", "tint26", "tint27",
+					  "tint28", "tint29", "tint30", "tint31",
+					  "bus-err", "ec7tie1-0", "ec7tie2-0",
+					  "ec7tiovf-0", "ec7tie1-1", "ec7tie2-1",
+					  "ec7tiovf-1";
 			clocks = <&cpg CPG_MOD R9A07G044_IA55_CLK>,
 				 <&cpg CPG_MOD R9A07G044_IA55_PCLK>;
 			clock-names = "clk", "pclk";
diff --git a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
index 1f1d481dc783..0d327464d2ba 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
@@ -912,7 +912,27 @@ irqc: interrupt-controller@110a0000 {
 				     <GIC_SPI 472 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 473 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 474 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 475 IRQ_TYPE_LEVEL_HIGH>;
+				     <GIC_SPI 475 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 25 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 34 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 35 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 36 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 37 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 38 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 39 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "nmi", "irq0", "irq1", "irq2", "irq3",
+					  "irq4", "irq5", "irq6", "irq7",
+					  "tint0", "tint1", "tint2", "tint3",
+					  "tint4", "tint5", "tint6", "tint7",
+					  "tint8", "tint9", "tint10", "tint11",
+					  "tint12", "tint13", "tint14", "tint15",
+					  "tint16", "tint17", "tint18", "tint19",
+					  "tint20", "tint21", "tint22", "tint23",
+					  "tint24", "tint25", "tint26", "tint27",
+					  "tint28", "tint29", "tint30", "tint31",
+					  "bus-err", "ec7tie1-0", "ec7tie2-0",
+					  "ec7tiovf-0", "ec7tie1-1", "ec7tie2-1",
+					  "ec7tiovf-1";
 			clocks = <&cpg CPG_MOD R9A07G054_IA55_CLK>,
 				 <&cpg CPG_MOD R9A07G054_IA55_PCLK>;
 			clock-names = "clk", "pclk";
-- 
2.34.1


