Return-Path: <linux-kernel+bounces-63555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36330853134
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B56CB24D80
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20649524A9;
	Tue, 13 Feb 2024 13:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YcW+hVLs"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E4151C21;
	Tue, 13 Feb 2024 13:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707829369; cv=none; b=PG5JpUVpfELSftoqeJ1V7zFD9lHkmy8Y69bs+jP2EvpAKSAihXAxqRoaZlXKSd4BUd7n2I33aMOkRpQY8vOihkAOdz2vJZN9ko6YAn+vSBVFzs+S0b72Y0ipDr9sHOxVH3YuUDfC3ELocxeoU/7Xm2aCTemF7kyoMELT9ITOlZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707829369; c=relaxed/simple;
	bh=28DdTYEVF+5wxUwB+sr99no14Iop58sGq02oHT+28+I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tMIVsNO7LS4mP/eefOrSIQCmy0Rg2NtVm+E/dPQtLyyIp/B0v/9M8qqqCZOzbBGjB/Kujk2LX2ppaKzcGB8rTgKQ/mnb1okeGzZkweM0A9YPcymNcsl8Iu9dazM1ckx4yTKoYOIMDV8tGwWZViVUvcYlBbZ+oLd7eJdrc6Ueq2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YcW+hVLs; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5610cc8cc1aso4762187a12.1;
        Tue, 13 Feb 2024 05:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707829366; x=1708434166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Cq+iI48CDe+5VO7sSMk/e7qj86AX8EMGUWgbiDs5Ns=;
        b=YcW+hVLsjGCOpGmrlia+QuAiTdsNOHUKbQskDh2z3F2jgxasPMgylT5v7SpnxDn1nS
         gTegyldYwRKf336Gkc/cFTSi9NWMZdGr6eBwkrLjdZxzk4Mhg6R8c7+YVDT8fsNXK1Dn
         W9f/EowMLVKtjl0fzRVIAjCa4DMtUWcpCsdN8aHwZ/DOlT6XJaPaAl2PqbbvyzkIbj2U
         2AVLDtpBgasRv/M3L2TeOVQLyTB9GeabdqyC1AqE3Lc92wRI5Kb2+6LTpyVvieT3CbqM
         J8fmR7X4iuFNRlA0vbQowMZwYX3vfyr2Uz1tflIBNvPfIhbPoW18CH2ksyWt48Et2gyN
         6Kew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707829366; x=1708434166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Cq+iI48CDe+5VO7sSMk/e7qj86AX8EMGUWgbiDs5Ns=;
        b=CQoN+z5XE7+wwFmfhgsj/IBGdYmfcuWXXa4majYig0d58WgJdNTpiR6gTTS6llT9OE
         udV102iPNwMhl8a8+g/K5eLXLc6fF7KECzuHfBzdCdGGhOSZ720FHFwkPR+3+Sss0XCh
         Tt1mmD7KYFG/gCGuXs9ubaQ5OpDUP/Ot36Fqemdr/ys4o1a2+Wx0f2fICRzI3d7/sEnd
         Wjm7bjO+dn+tq+BrxnsOMQg5cwwh8yEdqYZDoAPfCRXr5X5btwA290PPpMFeVOXVh4Iz
         oMmBa+k5ZbB+fHuirYP3bb6lwBD0Ycyp1gsr/z59fzKfpywvT08uBKK67fUBRsFvNwxT
         pHRw==
X-Forwarded-Encrypted: i=1; AJvYcCUYS0Y5ZIldHC4bEtnVpz8+luD1eY/EjTEy74vH+buPUqMSritsWdWgM8we33drA8Nt3x0hqmUdXUKHzlMhdl8EWB5PS7PFn0rmyvyS99SwJgUn4dxMM3GsSf1a5VPuUaLJwBaLBvIUeCsqLDV3viHt6FlfyIbPEFdmYOQa6a05uE0/RA==
X-Gm-Message-State: AOJu0Yw9yLI5/wyivlO+q8BecidIXyVrzekoS7nHbupYVQF08oVP9Dos
	K79cfGQRmjd/kAMMhnJ88hOvsd4QuZ0TisaVUlXp9xqkv7bCakqX
X-Google-Smtp-Source: AGHT+IGwFZ/B7NIFFcOnp2yFup95b+UeJUZ6E+6zkb73wGvSwm0cn063bkqvcUbgz2zWlqx3KDTONA==
X-Received: by 2002:a17:906:f88c:b0:a3c:8770:3795 with SMTP id lg12-20020a170906f88c00b00a3c87703795mr4365644ejb.15.1707829365845;
        Tue, 13 Feb 2024 05:02:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUQd7FhW+1Uji0/Kw8nyU5iosaUylTYW21ZHKoUoT9ZyjzXWSFkwAIhE6Op8Ai/8id8BMsPSYCUjv/0QPqvImddI3pTh5U3rNX76vbsxis4r65rvE9S4ka4TixwJvOdwq94CbIxE7qh+NgiRyva159qE7FTL0xCmmLMleU7R1sknZS/ZZatTKaJGqqo+iI6b657bbo6hBx/G/cAGOzfGRxZcGNxoXZ2t0i2uxmQ7TpiLASQJxbBX9BJ599Ksk2UCqJZrbtQDsuIlDmw943oOQDrMfaRxHTGsJAgC8dAN3c7bLNZwIfp5udFq1Qmc4PGKcO7RbRvzRbUy5DaRcujhAcakboeIaiUrBnCcE9Is7TEn2KGwALWXK1Ao7e98mNC3rH6mbNiyequTN/yiFmfDmE5KbLBgjO44/c1JDuGj2YuLx3wlwbOSSeLDEC4WwjutfpiTecOlOZKeCAA2hWGinRelblNGFcmaFlTLfRaUpH0ifPBICKQgcAm87xGbrGjhILR+66YG2HkRzR20wBYbFwmRI2pATXlTDvdBISYEnxyBQ==
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id cw15-20020a170907160f00b00a3d004237ebsm633078ejd.212.2024.02.13.05.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 05:02:45 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Daniel Golle <daniel@makrotopia.org>,
	linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 2/2] arm64: dts: mediatek: mt7988: add XHCI controllers
Date: Tue, 13 Feb 2024 14:00:44 +0100
Message-Id: <20240213130044.1976-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240213130044.1976-1-zajec5@gmail.com>
References: <20240213130044.1976-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

Add bindings of two on-SoC XHCI controllers.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 arch/arm64/boot/dts/mediatek/mt7988a.dtsi | 32 ++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
index bba97de4fb44..3eb5396dea22 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-only OR MIT
 
+#include <dt-bindings/clock/mediatek,mt7988-clk.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/phy/phy.h>
 
 / {
 	compatible = "mediatek,mt7988a";
@@ -78,7 +80,7 @@ gic: interrupt-controller@c000000 {
 			#interrupt-cells = <3>;
 		};
 
-		clock-controller@10001000 {
+		infracfg: clock-controller@10001000 {
 			compatible = "mediatek,mt7988-infracfg", "syscon";
 			reg = <0 0x10001000 0 0x1000>;
 			#clock-cells = <1>;
@@ -103,6 +105,34 @@ clock-controller@1001e000 {
 			#clock-cells = <1>;
 		};
 
+		usb@11190000 {
+			compatible = "mediatek,mt7988-xhci", "mediatek,mtk-xhci";
+			reg = <0 0x11190000 0 0x2e00>,
+			      <0 0x11193e00 0 0x0100>;
+			reg-names = "mac", "ippc";
+			interrupts = <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&infracfg CLK_INFRA_USB_SYS>,
+				 <&infracfg CLK_INFRA_USB_REF>,
+				 <&infracfg CLK_INFRA_66M_USB_HCK>,
+				 <&infracfg CLK_INFRA_133M_USB_HCK>,
+				 <&infracfg CLK_INFRA_USB_XHCI>;
+			clock-names = "sys_ck", "ref_ck", "mcu_ck", "dma_ck", "xhci_ck";
+		};
+
+		usb@11200000 {
+			compatible = "mediatek,mt7988-xhci", "mediatek,mtk-xhci";
+			reg = <0 0x11200000 0 0x2e00>,
+			      <0 0x11203e00 0 0x0100>;
+			reg-names = "mac", "ippc";
+			interrupts = <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&infracfg CLK_INFRA_USB_SYS_CK_P1>,
+				 <&infracfg CLK_INFRA_USB_CK_P1>,
+				 <&infracfg CLK_INFRA_66M_USB_HCK_CK_P1>,
+				 <&infracfg CLK_INFRA_133M_USB_HCK_CK_P1>,
+				 <&infracfg CLK_INFRA_USB_XHCI_CK_P1>;
+			clock-names = "sys_ck", "ref_ck", "mcu_ck", "dma_ck", "xhci_ck";
+		};
+
 		clock-controller@11f40000 {
 			compatible = "mediatek,mt7988-xfi-pll";
 			reg = <0 0x11f40000 0 0x1000>;
-- 
2.35.3


