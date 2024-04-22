Return-Path: <linux-kernel+bounces-154055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D92718AD6A9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B136B230CA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34632574F;
	Mon, 22 Apr 2024 21:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJFW4G2R"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E652D3D982;
	Mon, 22 Apr 2024 21:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713821439; cv=none; b=joogt6H6Kxuz67r8BPsxbcgMFkAjof/cBVL6JoMBLdDD/HvvuHsIpWTLoOXKS6QTIcggb+2bUYwroEKQyLC2S2Pt1z0Vfjllr1o5WyA5tUOtz0egUsNRNqh4MWtuna5Mc0GSL3zRePbqjL91fdTw3Gyi3Ed+so/xvWK6LPswCYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713821439; c=relaxed/simple;
	bh=sB7ehHaXuJrD1mIEFavkKLDZgCJJy4mygtKbCIfEgQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D94fXDKFw1cbOGsBXwBB89SgKAYKmtTdnbZoxmI4z58u3TA0vsG4E9yBzllMXqLsG8f2GnFC9GsVtdRYr2DqmqehZe6C+5wSezkRWm/RXvCWbMg65wixVz47gxolYwHQBwC8zgOhdtIz221e96a7yCcJ/JGhoJmQCTaZpuMKqy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJFW4G2R; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41a74e60753so9819805e9.1;
        Mon, 22 Apr 2024 14:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713821436; x=1714426236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AELQkiuKqfdmsNf01rdj5t0jG3Sm58XVVthgZjF644U=;
        b=XJFW4G2ROptK8UOyrLVIsbPm8wV5pORq+nfcoXr5vX9zi3gKuD2wZRgfLbivK9xnYi
         mjLfLE90QSdVgh8TPuXRO9V7LI4uWGDSL8JFJlHs8Tl1nQXUgzBweMz+Ugkqncg9o/lW
         sm5R1+CsKGvk2YUwoAiI224wWD3PwLAjuswEofwSHA6b/kBvDWOzcJ73deXXrrQC8w8z
         vVmtOl1Ll6pEB958efAvR4TffjFEOmlje31X2Hmwqpa6ZLUyjXD+cITt0WLtDdtG3ZW+
         891CfTfBdgiGkH3Xt3foHrY7WhK4DdwRA5E4ljal3hjuYfit9PZZZMPMfj+SV9IaJcn1
         fQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713821436; x=1714426236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AELQkiuKqfdmsNf01rdj5t0jG3Sm58XVVthgZjF644U=;
        b=b4J/zWRMS5ows/fiZVgsEpbaSeffzCPlr8N+vOLaCTJ91EM9AFYBVdagYSs4WjMyDp
         RA2dEM+s3PnYspe1gLj1qhHe5GVTbsVI8AfU0HNMsSQDE7EOkMyPlXxiKt1V6Gd+Ry48
         PpwE+IUYAPDUVnWytY56Z0fkVuiJFV0Cb2L8r2AGALJVBHtw49cjxvFu71wb6rRkKsW4
         wtlSEcdLKN4ZWhp+Bwp78l+jK5QCA3dtk+fR1IDzotEtf3ZkypOXSlBEFTYQOxbwua40
         Cx9ObJaNQ5XQY0QRq39gcCbK47nx9M79OhxZMSJPtD5GHcCzVOndiBvs+7bQvRkODNQQ
         2iCg==
X-Forwarded-Encrypted: i=1; AJvYcCU2tqACRsVy2YK3dKPG+73FOhGISbBJEEFpPB6AeZ8vZLRWgAYAi8BusO6Le03Cb4WDOww8rNfi89yUuIqRBYhsoJ1AqKf3SLZN8aYl6pxnGHom8O3IfjQ6VLrLdpgZmoKYyNEgneZfIikpbOJlG5Ik+mXlZ8qm/6jCQxQ8GERUx37v/I5d4tBQxx0=
X-Gm-Message-State: AOJu0Yxmu2Ed10QjLXpUm0vnO2qxnd5X7Sx1JjqV6LuiH9tj3LXWAZ6j
	zVAHyqt1NUXTKg9nfUWcb2pk6vMMdLT2hFCeTY3p5w+kDg+QVTAS
X-Google-Smtp-Source: AGHT+IHdioA8PTx5y82UjtAJPGYFft+UzvbI2ibTO7LC32U5TPjod1UxcwK7ti2/ZasmC/apjkRmgw==
X-Received: by 2002:a5d:540f:0:b0:343:efb7:8748 with SMTP id g15-20020a5d540f000000b00343efb78748mr7066310wrv.66.1713821436244;
        Mon, 22 Apr 2024 14:30:36 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:ab0d:124:447c:bf37])
        by smtp.gmail.com with ESMTPSA id n4-20020a5d4844000000b00349f098f4a6sm12886793wrs.53.2024.04.22.14.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 14:30:35 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-mmc@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5/6] arm64: dts: renesas: rzg2l-family: Update fallback string for SDHI nodes
Date: Mon, 22 Apr 2024 22:30:05 +0100
Message-Id: <20240422213006.505576-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240422213006.505576-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240422213006.505576-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Use 'renesas,rzg2l-sdhi' as a fallback string for SDHI nodes, where
hs400_disabled and fixed_addr_mode quirks are applied.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g043.dtsi | 4 ++--
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi | 4 ++--
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
index 6212ee550f33..2eccab9c8962 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
@@ -646,7 +646,7 @@ dmac: dma-controller@11820000 {
 
 		sdhi0: mmc@11c00000 {
 			compatible = "renesas,sdhi-r9a07g043",
-				     "renesas,rcar-gen3-sdhi";
+				     "renesas,rzg2l-sdhi";
 			reg = <0x0 0x11c00000 0 0x10000>;
 			interrupts = <SOC_PERIPHERAL_IRQ(104) IRQ_TYPE_LEVEL_HIGH>,
 				     <SOC_PERIPHERAL_IRQ(105) IRQ_TYPE_LEVEL_HIGH>;
@@ -662,7 +662,7 @@ sdhi0: mmc@11c00000 {
 
 		sdhi1: mmc@11c10000 {
 			compatible = "renesas,sdhi-r9a07g043",
-				     "renesas,rcar-gen3-sdhi";
+				     "renesas,rzg2l-sdhi";
 			reg = <0x0 0x11c10000 0 0x10000>;
 			interrupts = <SOC_PERIPHERAL_IRQ(106) IRQ_TYPE_LEVEL_HIGH>,
 				     <SOC_PERIPHERAL_IRQ(107) IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
index 88634ae43287..c07ddd8124e6 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
@@ -1050,7 +1050,7 @@ gic: interrupt-controller@11900000 {
 
 		sdhi0: mmc@11c00000 {
 			compatible = "renesas,sdhi-r9a07g044",
-				     "renesas,rcar-gen3-sdhi";
+				     "renesas,rzg2l-sdhi";
 			reg = <0x0 0x11c00000 0 0x10000>;
 			interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
@@ -1066,7 +1066,7 @@ sdhi0: mmc@11c00000 {
 
 		sdhi1: mmc@11c10000 {
 			compatible = "renesas,sdhi-r9a07g044",
-				     "renesas,rcar-gen3-sdhi";
+				     "renesas,rzg2l-sdhi";
 			reg = <0x0 0x11c10000 0 0x10000>;
 			interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
index e89bfe4085f5..8448afa8be54 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
@@ -1058,7 +1058,7 @@ gic: interrupt-controller@11900000 {
 
 		sdhi0: mmc@11c00000 {
 			compatible = "renesas,sdhi-r9a07g054",
-				     "renesas,rcar-gen3-sdhi";
+				     "renesas,rzg2l-sdhi";
 			reg = <0x0 0x11c00000 0 0x10000>;
 			interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
@@ -1074,7 +1074,7 @@ sdhi0: mmc@11c00000 {
 
 		sdhi1: mmc@11c10000 {
 			compatible = "renesas,sdhi-r9a07g054",
-				     "renesas,rcar-gen3-sdhi";
+				     "renesas,rzg2l-sdhi";
 			reg = <0x0 0x11c10000 0 0x10000>;
 			interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.34.1


