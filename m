Return-Path: <linux-kernel+bounces-133023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20184899D9C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CFA4B241E6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBCB16D31D;
	Fri,  5 Apr 2024 12:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3vz4DoX"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4439C16C879;
	Fri,  5 Apr 2024 12:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712321717; cv=none; b=FcKkblW7uPJfzV1B7btQOD7XVAvnq8BgXKpiZGA/8m88ESSRmq3q3vcE/itzB4KrQeuiEUpx5StoU7w317nmD850nN8hm+s6/1Y3L97YB+xafhtjUStIxNkl2q5ouAdOYHzdcK93exUzwcSUNWVbr59o4DYP4pBVfaALk0LkVn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712321717; c=relaxed/simple;
	bh=MUigmBEuUiqA2PWglpQ6m4NChQ4ArIkifmrAqsF7jwk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=UE9uc1sRLQrz+71+CAt+Q7BIPw2nbpCqDglsFAn+8d6PDA3rS7OrPbA7Xc84ugnPvpjLWG3djLyP2fM2ln4PiTAv7D139B0XCztOqWNJRxb1nQNdtsEhyCzOpjqEUMt07zFpcVvsErxkCi5fRl+XjrkIwpP8svQkQ9AlOHzB1+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e3vz4DoX; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a51ad517450so31082066b.2;
        Fri, 05 Apr 2024 05:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712321715; x=1712926515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wMGkaqW0zsEZBb0QXAO9E3nrh0bhvj+Vu7d85c8cRE8=;
        b=e3vz4DoXO2+JTeXH0Zat27PVayQhsJXLT/4aDb8IC+BQrvp1XhUasBR5q7bPBXgL6d
         kvt7rKOeM2oUla8sr0W21e6b6CETFonoSE2ME0E28iNiFqtJTG3owecIEBctCcMxTTOl
         r+59G85nRIc/nkzio321A1pyCXDGg0KE9hgVptm3rWgPpKRLYTb4dVeF/5vniflXCdGy
         o8y3qZ8/HnhZPq2bz7OyCKlEmLNnEGzoH1tZXVzQ5n9QiRlSaJnCRvXIF1KoEO0XisSg
         +KQ79jDS/5W6rPU/GGXZ3uurGS6RlUCIdL9Z0GC6Ho71S/EDXv6bfrk+J2+iuJeXtO1O
         USwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712321715; x=1712926515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wMGkaqW0zsEZBb0QXAO9E3nrh0bhvj+Vu7d85c8cRE8=;
        b=hwkdqF0uqNG7vju0+/Hruh0P7Q6wkRM38QbpI/SRzOO8m1VAYuEVCMUfxtImjShLqw
         nRzVpbO9lhoxzkAzGBHDEPmQWdRWrdOw8rmMEsRMC8JCX4mzB7pj7wKLDkNnV2MUbhxk
         40+Gx5HeE/IwsGgquuWWLE/XkPUTWPBny8hh1szOVF5t+Oye0lFa9x2i8T0m4WqqhUEn
         ryFNt5wukBUR4fHyLXNBQnAklKDSsaYYYcGcY1mu+InvWln9oBVV4ioS0CdqmNE6GqXt
         REZl/w/BeJmBa6t2rQc9+U9KiTexP/L8EO7cGGwUJtWtkkoTYZrfnovBimhaLFuTh6bA
         sTlg==
X-Forwarded-Encrypted: i=1; AJvYcCVUzbP3pRq197MeyeWNQ9Yd/CyJTA/FKICiCG4PiyxAEHpIp/8ukJwjfSm1+raSYAc6jM4QWfh+kKPJ/70h+VlhkBivFycq8xS0MtNP
X-Gm-Message-State: AOJu0YyC2/corT4aFAswruXynYmhdtXzTdapCZvpTFww2A5SGJzV2uwH
	wsvAtII1clP20XIBL1QPzZo4POGVm0XKQcJ6SnJ3DaDi0dxAvMFH
X-Google-Smtp-Source: AGHT+IFdUYG+ySoMDDUxApNdQt7x3SbDSjAuJR5giJgu03oOgXmZErEU9wejUpMsm8XGs61pQvMr1Q==
X-Received: by 2002:a17:906:4ecf:b0:a51:8250:2b52 with SMTP id i15-20020a1709064ecf00b00a5182502b52mr962825ejv.61.1712321714404;
        Fri, 05 Apr 2024 05:55:14 -0700 (PDT)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id jy15-20020a170907762f00b00a4e26570581sm805434ejc.108.2024.04.05.05.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 05:55:13 -0700 (PDT)
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
Subject: [PATCH] arm64: dts: mediatek: mt7981: add I2C controller
Date: Fri,  5 Apr 2024 14:55:05 +0200
Message-Id: <20240405125505.11837-1-zajec5@gmail.com>
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

MT7981 has one on-SoC I2C controller that differs from recent Mediatek
blocks by having a different SLAVE_ADDR register offset (thus a custom
binding compatible string).

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 arch/arm64/boot/dts/mediatek/mt7981b.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
index 8a6263cc569c..2d7f91196e64 100644
--- a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
@@ -94,6 +94,23 @@ pwm@10048000 {
 			#pwm-cells = <2>;
 		};
 
+		i2c@11007000 {
+			compatible = "mediatek,mt7981-i2c";
+			reg = <0 0x11007000 0 0x1000>,
+			      <0 0x10217080 0 0x80>;
+			interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&infracfg CLK_INFRA_I2C0_CK>,
+				 <&infracfg CLK_INFRA_AP_DMA_CK>,
+				 <&infracfg CLK_INFRA_I2C_MCK_CK>,
+				 <&infracfg CLK_INFRA_I2C_PCK_CK>;
+			clock-names = "main", "dma", "arb", "pmic";
+			clock-div = <1>;
+			clock-frequency = <100000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		pio: pinctrl@11d00000 {
 			compatible = "mediatek,mt7981-pinctrl";
 			reg = <0 0x11d00000 0 0x1000>,
-- 
2.35.3


