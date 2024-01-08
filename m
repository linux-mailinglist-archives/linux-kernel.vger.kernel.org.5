Return-Path: <linux-kernel+bounces-19216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B438269E1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EBAA1F22F43
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 08:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279C913FF9;
	Mon,  8 Jan 2024 08:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfNkh7au"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED79712B7C;
	Mon,  8 Jan 2024 08:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a2a225e9449so122575466b.0;
        Mon, 08 Jan 2024 00:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704703974; x=1705308774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SAFmBKE8MRjmMBDbLuBVUNc8Ts/SzeTOhwN0vFnmrGw=;
        b=gfNkh7auhs+PHyX58sDxTftNQ0n5Jvy7cX9d2cMqIulR/NxuEXQ30ba4P4r3d57VM2
         jGQuMxUpge0gOzMC1qpIRTDb6TvNp/1wOtRNPaX2x4q5vQrJxX25LV5Q30Q+q6QzS3SF
         dB5d/ac3Wmev8VN7iSeYESb2OV5De11NRvrVVD9JYPB1O3k/iv5cKNN/ZNLLjPmIu/pM
         wU0Gbt2LTI59sKgW5Cg60s7vy2zgcejn9JEPNl+7Zd9+9ATth3n0uZaDVHi+ksSOjLrE
         USY7BrWhlhCPF+1EOSVgTYRPEdTNxEBWYsTTiegTeSRAiIUIr/qBaaYbv01l7ueohamM
         eySw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704703974; x=1705308774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SAFmBKE8MRjmMBDbLuBVUNc8Ts/SzeTOhwN0vFnmrGw=;
        b=PClQqgyu8vLpJNi7xjryW7R1hgFNlAHO9ZCwS27dK929bsoHVD+Ea57AcJPCAI1qR9
         MA1NaN4gNd9l5T4IZbUglYVegtzaYQT3kS5Q5LTVgzd+kUJW+aJwy9gT7Quc7UwXDGiy
         uI5LtEr879FKYGUNMln85ET6eT7wsWIB9+KB3rLvXAn6+d1bQVo1ECX5ooo8RToX1E9r
         FvlXUyHVNJgs72AyRJ2Oe27ccDBUeworDocHdHkNB5ig+zRnx7dOQf4u0AsPQlUNb/zU
         /LQHN8YWAMjLosR1WZBUbUUD9sQbmFI40UVnOWPpF/brdCiWtwy58ZfNrWsxCkdEA6TK
         /Y7w==
X-Gm-Message-State: AOJu0YwDgrepi37w/BE892qctW0cdF43TSNQhUPQil7AeIgKeqcbtOXC
	s0NHKNsHz/67ZFpePHZmDto=
X-Google-Smtp-Source: AGHT+IEEr1hR5n0BZpIAwYcpn9HJF+jFZ6KtsDNL4MS0u3E/k+bU/Mv+Eyh48nxjcAYXkBt0sWBufw==
X-Received: by 2002:a17:906:1cc5:b0:a28:c9d3:19e9 with SMTP id i5-20020a1709061cc500b00a28c9d319e9mr1467382ejh.35.1704703974054;
        Mon, 08 Jan 2024 00:52:54 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id uz29-20020a170907119d00b00a2aae23b414sm666046ejb.26.2024.01.08.00.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 00:52:53 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Daniel Golle <daniel@makrotopia.org>,
	Hsin-Yi Wang <hsinyi@chromium.org>,
	=?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= <nfraprado@collabora.com>,
	jason-ch chen <Jason-ch.Chen@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	=?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Frank Wunderlich <frank-w@public-files.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V2 3/3] arm64: dts: mediatek: mt7988: add clock controllers
Date: Mon,  8 Jan 2024 09:52:28 +0100
Message-Id: <20240108085228.4727-4-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240108085228.4727-1-zajec5@gmail.com>
References: <20240108085228.4727-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

Add bindings of on-SoC clocks.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
V2: New PATCH in the series thanks to Daniel's bindings work

 arch/arm64/boot/dts/mediatek/mt7988a.dtsi | 41 ++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
index 5a778188ac21..bba97de4fb44 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
@@ -78,12 +78,51 @@ gic: interrupt-controller@c000000 {
 			#interrupt-cells = <3>;
 		};
 
-		watchdog@1001c000 {
+		clock-controller@10001000 {
+			compatible = "mediatek,mt7988-infracfg", "syscon";
+			reg = <0 0x10001000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		clock-controller@1001b000 {
+			compatible = "mediatek,mt7988-topckgen", "syscon";
+			reg = <0 0x1001b000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		watchdog: watchdog@1001c000 {
 			compatible = "mediatek,mt7988-wdt";
 			reg = <0 0x1001c000 0 0x1000>;
 			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
 			#reset-cells = <1>;
 		};
+
+		clock-controller@1001e000 {
+			compatible = "mediatek,mt7988-apmixedsys";
+			reg = <0 0x1001e000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		clock-controller@11f40000 {
+			compatible = "mediatek,mt7988-xfi-pll";
+			reg = <0 0x11f40000 0 0x1000>;
+			resets = <&watchdog 16>;
+			#clock-cells = <1>;
+		};
+
+		clock-controller@15000000 {
+			compatible = "mediatek,mt7988-ethsys", "syscon";
+			reg = <0 0x15000000 0 0x1000>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
+		clock-controller@15031000 {
+			compatible = "mediatek,mt7988-ethwarp";
+			reg = <0 0x15031000 0 0x1000>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
 	};
 
 	timer {
-- 
2.35.3


