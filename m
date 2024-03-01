Return-Path: <linux-kernel+bounces-88026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 757C986DC53
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F10771F226B9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 07:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5E769974;
	Fri,  1 Mar 2024 07:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hGO07pqJ"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E6D50275;
	Fri,  1 Mar 2024 07:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709279288; cv=none; b=cOGGWy7VXf+Sa4BMwtVlNAYlNr2fm4cQZ546xO05DC8r6cnC7Z/CTvD6tg+ixjZFI1tl4FzCbHWtJ4Uchay+moQ0RVhHK14XOTpQFtOEdSQKJ/s0mssFVbtVQyLgZyJ989GG2lY5IHJR/tQ3XQlH7NSAWMZbh23F/78MuYzhVIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709279288; c=relaxed/simple;
	bh=Pofs6Iq1R1/s2g+DzmAmCcTOqm3WK2u+gBotuVmy8uI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=FoWXB+jPgqEPjzLLEOkaCND4Oa8Wkkfk9dTmnFRmcM49aR2+7tI4vdtQuzVJDq/6XDAjatebedmYmE9PxlJfmzz2KYWs2AUI9G7/OQ584ULz+jfr5wWXSBoq0GnxCSLoX5LO6KU50LZW9Biqqb/GHj9CNkB0sZsVkQXZfaEOQS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hGO07pqJ; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a28a6cef709so278799766b.1;
        Thu, 29 Feb 2024 23:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709279285; x=1709884085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=blIn0p2u3QS9iJ7wxkzaIEJOBeHVH2WoSM8ME7du+Nk=;
        b=hGO07pqJ6weukzqtPRODYokchILfX8JQEygCESdX/MGS/K+iS1oWz8LlCZ1keq0Tah
         lPVvygFD8meNAxXpa+vY+c9Omx6OtogCYfLVWgfIl7nNhTZ2By91p8CBD0cq4MQ6Sxig
         cy11q6zf3Zu3retZROXB2k1R96SnPHYZ/4CH3CynjTPaq8SHrVNJhY9wWM0G8rJVhODN
         f+KodzL4gdiEXQAeEEIfiSkpq39Vq4QmWtsdGKl7iGlRQqzKywIPN6Qx/u9x/NmP3wII
         3XxbloQEaAKwGYgPASeawlnir1hr3xelZsfBpadD6SAMjttaTB5hazqzZoRslsErmW82
         OqnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709279285; x=1709884085;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=blIn0p2u3QS9iJ7wxkzaIEJOBeHVH2WoSM8ME7du+Nk=;
        b=D6goiLuDKyiPiGeozWn/L6t7uubV8VBio2dZbBcuDkDq18S7SiPbU60UHowgK/ul+f
         So6hp2V5WuZToVAgFpgsOVSlriubViE415RdT9A0jE+nn3ewO/69qWswmOSPMwrqS7h5
         Fy+gxWO5+AuJWrHB3QLFTZN9rDhDl/3MHliRSZor160xs+YI3ZPZ696kTUxLnrTMiEG2
         zpwBVVvDR1kGe4pwNFLtHkjTgDp9C0e7sov05IF45H5eclDlMIFZHd96PHVulRlcRtu3
         65PMaAmlwG+Vflg9q6BNLXaikBdExS/ZNJ/zdrPEcjjOZw/7f0uY9L7SN0BDcPfVQb6e
         eIGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoEoJH02FM5j0nsemadM7c1+yQG3MiI4j7xumL8P/NLVc9RD04OoQx7K68Q0kdgynvZEaCtErnXVlWvr1mnHvuGJqVmZWD9NR8NfBi
X-Gm-Message-State: AOJu0YxZV03c+/yMKx9rklnucMgMqAByLQ8114yv4DthtTP7qG5MEWHF
	zKtvBEyYNCaaE+RvF+rsly6MYPrYIMfWvjLU1E6wjXQ5DkMGXsro
X-Google-Smtp-Source: AGHT+IGjvcG3NiU3BthL7n7m+TBWOhPmabQI29Jtj8gY4+rhklgDETXkIcNQ2rOzg+GWx51/qkCVIQ==
X-Received: by 2002:a17:906:c49:b0:a3e:e678:556 with SMTP id t9-20020a1709060c4900b00a3ee6780556mr646579ejf.58.1709279284547;
        Thu, 29 Feb 2024 23:48:04 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id f26-20020a170906139a00b00a4417c46efbsm1438684ejc.82.2024.02.29.23.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 23:48:03 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH] arm64: dts: mediatek: mt2712: fix validation errors
Date: Fri,  1 Mar 2024 08:47:41 +0100
Message-Id: <20240301074741.8362-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

1. Fixup infracfg clock controller binding
   It also acts as reset controller so #reset-cells is required.
2. Use -pins suffix for pinctrl

This fixes:
arch/arm64/boot/dts/mediatek/mt2712-evb.dtb: syscon@10001000: '#reset-cells' is a required property
        from schema $id: http://devicetree.org/schemas/arm/mediatek/mediatek,infracfg.yaml#
arch/arm64/boot/dts/mediatek/mt2712-evb.dtb: pinctrl@1000b000: 'eth_default', 'eth_sleep', 'usb0_iddig', 'usb1_iddig' do not match any of the regexes: 'pinctrl-[0-9]+', 'pins$'
        from schema $id: http://devicetree.org/schemas/pinctrl/mediatek,mt65xx-pinctrl.yaml#

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 arch/arm64/boot/dts/mediatek/mt2712-evb.dts | 8 ++++----
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi   | 3 ++-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt2712-evb.dts b/arch/arm64/boot/dts/mediatek/mt2712-evb.dts
index 0c38f7b51763..234e3b23d7a8 100644
--- a/arch/arm64/boot/dts/mediatek/mt2712-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt2712-evb.dts
@@ -129,7 +129,7 @@ ethernet_phy0: ethernet-phy@5 {
 };
 
 &pio {
-	eth_default: eth_default {
+	eth_default: eth-default-pins {
 		tx_pins {
 			pinmux = <MT2712_PIN_71_GBE_TXD3__FUNC_GBE_TXD3>,
 				 <MT2712_PIN_72_GBE_TXD2__FUNC_GBE_TXD2>,
@@ -156,7 +156,7 @@ mdio_pins {
 		};
 	};
 
-	eth_sleep: eth_sleep {
+	eth_sleep: eth-sleep-pins {
 		tx_pins {
 			pinmux = <MT2712_PIN_71_GBE_TXD3__FUNC_GPIO71>,
 				 <MT2712_PIN_72_GBE_TXD2__FUNC_GPIO72>,
@@ -182,14 +182,14 @@ mdio_pins {
 		};
 	};
 
-	usb0_id_pins_float: usb0_iddig {
+	usb0_id_pins_float: usb0-iddig-pins {
 		pins_iddig {
 			pinmux = <MT2712_PIN_12_IDDIG_P0__FUNC_IDDIG_A>;
 			bias-pull-up;
 		};
 	};
 
-	usb1_id_pins_float: usb1_iddig {
+	usb1_id_pins_float: usb1-iddig-pins {
 		pins_iddig {
 			pinmux = <MT2712_PIN_14_IDDIG_P1__FUNC_IDDIG_B>;
 			bias-pull-up;
diff --git a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
index 6d218caa198c..082672efba0a 100644
--- a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
@@ -249,10 +249,11 @@ topckgen: syscon@10000000 {
 		#clock-cells = <1>;
 	};
 
-	infracfg: syscon@10001000 {
+	infracfg: clock-controller@10001000 {
 		compatible = "mediatek,mt2712-infracfg", "syscon";
 		reg = <0 0x10001000 0 0x1000>;
 		#clock-cells = <1>;
+		#reset-cells = <1>;
 	};
 
 	pericfg: syscon@10003000 {
-- 
2.35.3


