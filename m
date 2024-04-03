Return-Path: <linux-kernel+bounces-130554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8788979E3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D020A1C25693
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0A3156871;
	Wed,  3 Apr 2024 20:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OgdzyJqt"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CEB15664C;
	Wed,  3 Apr 2024 20:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712176600; cv=none; b=EFcKZKnuFle2z9F0HoHY6rD+gsuSMBtFl9Q2ZlS9DGwrvKkghkrqlJnQDy3zIMUFGCVzZie+3b5fss5xOEBDZWpo/0rRvnm6Zq29/cKN9Jp/MMq+i0j7fqXJOTEYipfEwE20Bi8D8BghSf37M/kQzyM3zIlSniXsa/BV4oZKLn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712176600; c=relaxed/simple;
	bh=Rf+y8FQVuuQXfKxCEsh04t/PdScQxZALL39km6vyDc8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ORpPXhyv7zpBLlFbrh4GtI8Khvo6GvsH21Z1mbd3jayTYGDJO5dBqV1pIiaW06EPCt3Jl6XcAnaZgPa2TMmLLPlDkfvYf6XGJY0SXD3NQNkhR9VZ17QkInuhulkJCcFJuooZhvvROMMZgetZnkZAc7oO8suIdTJ1Jceej0qFjXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OgdzyJqt; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4162a3e2cb7so261835e9.1;
        Wed, 03 Apr 2024 13:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712176597; x=1712781397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WIhSDuKRxtReMhoBOeQdaM5SSml7tb0U0bOehxLDLJ0=;
        b=OgdzyJqtO9UcREDtwLFUTWYcS8WfphaT8zDwO61W1J+HYa6akncNXWWIHw8JFEhVkB
         ZTMh9I0FEEpTVP9TUKFZoXfav/1n9kbrgdYxndvgeoFG/F7rDp9Of4tbmEpSVEjDZ/4X
         JBcMBUbDKIBLf3CTtPvfCWMBKtpprbECWHQ0pzQiBMH81gpKDwNz+on5FfzbQG08+K1g
         7z1Ya5ELIRGuh/ufVkDmsZQ8HTL2N/7xWZuiMqSMjW4TkoZNJMzQeZcTycLfsqwjGcEX
         QctHJZUEG5CjIrUjyzQGD4Px/njoR96AVlNX/5pYmltqB/5SvB8joMCnmjXfuDVzTSuv
         k3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712176597; x=1712781397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WIhSDuKRxtReMhoBOeQdaM5SSml7tb0U0bOehxLDLJ0=;
        b=MtJoJfr5GS2ncLPJs9MHeOxTdxddBJvNCrQCnWl0l2LXykGvBICtxHaPfdm7kUH2Uk
         z0II0veXqrmSyDMYA1wkpSCocGDeej3Ca0tfEH5qp3L3JqAEtTsCmvxo2WHyXGpLQzLC
         gj1nVCuT65H8PnIjNmjV/Gi2hJ0PoICRDKtJJEYi3iEEJfTc+1R1u9vrVRQ246U/b2bP
         faSk2sNqTGBEuCLozcQptwnyiORoXGCKybFofJV7+jAJP5uR+f3VCgycmIKXDRdnlMq7
         dlcrp+uK0z0ODEeEedO2Xli17yZ8N2Wpobf3jgQ+AZ0P9UBxvTkqmwuG3nkzpxet6a5Z
         RM1g==
X-Forwarded-Encrypted: i=1; AJvYcCWAUno82K9jMT0ovGXoo61nI0vABrfXwC8AsK3nys4GNa3RNq5TKexmnovYWj3+53XOgKgTnYP1x3K1VvvyVR5kKXIp4g2W7mb+NG7+p/UaGfmesNcUiQVcqYeGrDcBkNMsmF6/QhW96UW9EqEn
X-Gm-Message-State: AOJu0Yx7tRhexhMD/OsRbEyQYU2pZL7LMtvEx1ZYENdAlBg3x9xoaqfx
	7WE6KieKXdoaI0uZbBjk4BW/l1tX8GblS1YVsQlL/l1gNZqwn4qVeCc5W1LW
X-Google-Smtp-Source: AGHT+IEBf4EI90GwLyWaZhn9tNMQRNMUHp0wiyU3VQSutIIF0BpUCmJKhP6GflB/sJ4C1FaR3PGQ1Q==
X-Received: by 2002:a05:600c:1d27:b0:415:4824:3686 with SMTP id l39-20020a05600c1d2700b0041548243686mr471596wms.25.1712176596939;
        Wed, 03 Apr 2024 13:36:36 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:5eb:3d93:f2b6:25e8])
        by smtp.gmail.com with ESMTPSA id p4-20020a05600c468400b00415f496b9b7sm244910wmo.39.2024.04.03.13.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 13:36:36 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 3/5] riscv: dts: renesas: r9a07g043f: Add IRQC node to RZ/Five SoC DTSI
Date: Wed,  3 Apr 2024 21:35:01 +0100
Message-Id: <20240403203503.634465-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240403203503.634465-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240403203503.634465-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add the IRQC node to RZ/Five (R9A07G043F) SoC DTSI.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2
- Dropped using SOC_PERIPHERAL_IRQ() macro
---
 arch/riscv/boot/dts/renesas/r9a07g043f.dtsi | 75 +++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi b/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
index f35324b9173c..e0ddf8f602c7 100644
--- a/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
+++ b/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
@@ -54,6 +54,81 @@ &soc {
 	dma-noncoherent;
 	interrupt-parent = <&plic>;
 
+	irqc: interrupt-controller@110a0000 {
+		compatible = "renesas,r9a07g043f-irqc";
+		reg = <0 0x110a0000 0 0x20000>;
+		#interrupt-cells = <2>;
+		#address-cells = <0>;
+		interrupt-controller;
+		interrupts = <32 IRQ_TYPE_LEVEL_HIGH>,
+			     <33 IRQ_TYPE_LEVEL_HIGH>,
+			     <34 IRQ_TYPE_LEVEL_HIGH>,
+			     <35 IRQ_TYPE_LEVEL_HIGH>,
+			     <36 IRQ_TYPE_LEVEL_HIGH>,
+			     <37 IRQ_TYPE_LEVEL_HIGH>,
+			     <38 IRQ_TYPE_LEVEL_HIGH>,
+			     <39 IRQ_TYPE_LEVEL_HIGH>,
+			     <40 IRQ_TYPE_LEVEL_HIGH>,
+			     <476 IRQ_TYPE_LEVEL_HIGH>,
+			     <477 IRQ_TYPE_LEVEL_HIGH>,
+			     <478 IRQ_TYPE_LEVEL_HIGH>,
+			     <479 IRQ_TYPE_LEVEL_HIGH>,
+			     <480 IRQ_TYPE_LEVEL_HIGH>,
+			     <481 IRQ_TYPE_LEVEL_HIGH>,
+			     <482 IRQ_TYPE_LEVEL_HIGH>,
+			     <483 IRQ_TYPE_LEVEL_HIGH>,
+			     <484 IRQ_TYPE_LEVEL_HIGH>,
+			     <485 IRQ_TYPE_LEVEL_HIGH>,
+			     <486 IRQ_TYPE_LEVEL_HIGH>,
+			     <487 IRQ_TYPE_LEVEL_HIGH>,
+			     <488 IRQ_TYPE_LEVEL_HIGH>,
+			     <489 IRQ_TYPE_LEVEL_HIGH>,
+			     <490 IRQ_TYPE_LEVEL_HIGH>,
+			     <491 IRQ_TYPE_LEVEL_HIGH>,
+			     <492 IRQ_TYPE_LEVEL_HIGH>,
+			     <493 IRQ_TYPE_LEVEL_HIGH>,
+			     <494 IRQ_TYPE_LEVEL_HIGH>,
+			     <495 IRQ_TYPE_LEVEL_HIGH>,
+			     <496 IRQ_TYPE_LEVEL_HIGH>,
+			     <497 IRQ_TYPE_LEVEL_HIGH>,
+			     <498 IRQ_TYPE_LEVEL_HIGH>,
+			     <499 IRQ_TYPE_LEVEL_HIGH>,
+			     <500 IRQ_TYPE_LEVEL_HIGH>,
+			     <501 IRQ_TYPE_LEVEL_HIGH>,
+			     <502 IRQ_TYPE_LEVEL_HIGH>,
+			     <503 IRQ_TYPE_LEVEL_HIGH>,
+			     <504 IRQ_TYPE_LEVEL_HIGH>,
+			     <505 IRQ_TYPE_LEVEL_HIGH>,
+			     <506 IRQ_TYPE_LEVEL_HIGH>,
+			     <507 IRQ_TYPE_LEVEL_HIGH>,
+			     <57 IRQ_TYPE_LEVEL_HIGH>,
+			     <66 IRQ_TYPE_EDGE_RISING>,
+			     <67 IRQ_TYPE_EDGE_RISING>,
+			     <68 IRQ_TYPE_EDGE_RISING>,
+			     <69 IRQ_TYPE_EDGE_RISING>,
+			     <70 IRQ_TYPE_EDGE_RISING>,
+			     <71 IRQ_TYPE_EDGE_RISING>;
+		interrupt-names = "nmi",
+				  "irq0", "irq1", "irq2", "irq3",
+				  "irq4", "irq5", "irq6", "irq7",
+				  "tint0", "tint1", "tint2", "tint3",
+				  "tint4", "tint5", "tint6", "tint7",
+				  "tint8", "tint9", "tint10", "tint11",
+				  "tint12", "tint13", "tint14", "tint15",
+				  "tint16", "tint17", "tint18", "tint19",
+				  "tint20", "tint21", "tint22", "tint23",
+				  "tint24", "tint25", "tint26", "tint27",
+				  "tint28", "tint29", "tint30", "tint31",
+				  "bus-err", "ec7tie1-0", "ec7tie2-0",
+				  "ec7tiovf-0", "ec7tie1-1", "ec7tie2-1",
+				  "ec7tiovf-1";
+		clocks = <&cpg CPG_MOD R9A07G043_IAX45_CLK>,
+			 <&cpg CPG_MOD R9A07G043_IAX45_PCLK>;
+		clock-names = "clk", "pclk";
+		power-domains = <&cpg>;
+		resets = <&cpg R9A07G043_IAX45_RESETN>;
+	};
+
 	plic: interrupt-controller@12c00000 {
 		compatible = "renesas,r9a07g043-plic", "andestech,nceplic100";
 		#interrupt-cells = <2>;
-- 
2.34.1


