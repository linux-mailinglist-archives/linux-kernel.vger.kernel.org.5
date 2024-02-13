Return-Path: <linux-kernel+bounces-63931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F107F853686
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7BAA28D76C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C811604DC;
	Tue, 13 Feb 2024 16:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fx+WGuHj"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E735FEEF;
	Tue, 13 Feb 2024 16:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707842823; cv=none; b=cnL9Q+LfHBJ+Ae4tB82XQy/qcbYS2D5RepR0jDA9iCY2YaqdWt0O/3GG5mQ219nqAuVZNvheTRBSkHIQWgFPv3YeiGooT47CtNTMG8m/PtCc+f8X1JvYF3TtYkcQEcNk+f8SiUpv0Dh5bS44+xPaYroOQIDk1oWQ0LibI1zbdn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707842823; c=relaxed/simple;
	bh=Ts9rTkO5j5nGKALcg9pGKYCXK/axLho53cM/U24J3OE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gJ129xpWKItu3rrpNHP0zlaeALwn+5/o0S2rkv6J95USRviP1tFP2alds/U1DMRZx/wtblObkGja8awIFSXT33J6YpGpRmO8xUotYybItQNBPVh96K3LNAeFHozkfGDLrA9iLLHDcpUrdIU/DBcSsLR8wakSrbvXQ8E81bjw/hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fx+WGuHj; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5600c43caddso5516582a12.2;
        Tue, 13 Feb 2024 08:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707842820; x=1708447620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+F4oKcixpMDMjtibRGARd2c9eJAlVuiYPpkn0XIejY=;
        b=fx+WGuHjAHU5PapbnPHuRCYMGl5v2hMJiF59DXTnlIAGfc9dfkh8vpO3gS3YwWXTC4
         1PTfVkxk5FNDsEOUivy18Vyg7Sk5dRa5eNUmG7ldJRvf65jLKTPPBSGLgKyulb6Ss/Fj
         tilYH2mDJtUFplUCkYnE3Ugr4Vqw5yd1PzFL3pSoS5YTM5fet51ljFbsO5hyQ8Bmuqo5
         TQ/LX54AUtsWt2UH2EmjlmxmniMrEJc4Ya+FxkhgZPCdYzwUPnsBPmNlDW52WzSarFvX
         vISuj1+UqklYZH9DJMxOtKrVLGkTj8FPh9UB/WwLjHGxBMYVjxOzlrPdAtc/wjdyB3Bl
         Lo3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707842820; x=1708447620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T+F4oKcixpMDMjtibRGARd2c9eJAlVuiYPpkn0XIejY=;
        b=WRUAlHJDh3LADk4y3hgK1xpzUb+OudC+Coo6LZEp8HilBNVYarK7sauj2GQJKow5Tt
         tM5xRV4fV5BWfOmIKEkcjhIU7IXKkq4dOrhJ42dnKqwkUQHLC7qhbdP3AAt/xGA3QL1x
         SaFa/pPa6t/ea7ASAEBmHEZeC+RPSliLAksyIzpmehnf36sceVPl8nPYHDipuU+IvDpc
         KNs6bavDgBqzviUDn1HihZLiQ1rnCAvgkG0nR8xvkzylALgiW2hGTrc2mwKfvhfxUiRj
         +v1oEG/b0uFrmoXybiGFdk4uqpMCfdsjh/OQ+JsJve53WNMKuQxPnuxliyHQti87sDJ4
         2Wqw==
X-Forwarded-Encrypted: i=1; AJvYcCWpic/vnPmCoUDqu+RQHOdG7+XLZmuW9TS7bd7sofV0tYeFzSj02QTfOH1OWKpFJauC1MqL10sg1jDp1/+2dIQTs2flE4NM3bzkKtYmy3rndoFc1m+I4oU/Eds+tL2/ALei0WS3emcU5evWW8XRSJPS3vrP9oTZCE1SCE0BsI4xb9wFiQ==
X-Gm-Message-State: AOJu0Yydv7whHh7OhdvYd5uGYJBpjkzlzmvIO5PTuB8/2kxzX3hFhcIS
	KkQgHCRcbVsIjVoZdqFHrBNDyhZBP5Oo5hGH7mc1RZdDTQvPtkRU
X-Google-Smtp-Source: AGHT+IEeCwyqkHpoeY0sJgs+ZgFzlmCq6/tbYDuHpnER0Oiuvl6HmAKPTXql31UVCs75XR7jLk+zFw==
X-Received: by 2002:aa7:d590:0:b0:55f:d9d1:6de1 with SMTP id r16-20020aa7d590000000b0055fd9d16de1mr169835edq.16.1707842819607;
        Tue, 13 Feb 2024 08:46:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUJ01uweZYgi6dyBpmqVKNY1aQLUGcn9okDSZxLvkc2fCvETs8lVM4QVRx/Z3UztsF9TRQeXuZv/iau8+VVonrwh0Ry0Mn+5XUDbCYIjne4NE/Pej4Qh5E1hwcPPtAMJGpCWAKslgCCvepxqQ06Hx8Gg07VgFvdvx2whcix6fexV8J/r+KnLQYAo6JhhK5/sSxEtCpj8m9DTrcYMfZlrkph73xQOjSKo377khXaBW77sEJwhLlkYHDU0T3M5T+uVtl0sUQKeyQzJt8IhVwCCBIf3qeTzMdGEhd9Lq44n126Mco+rueEbFSuBpU4oAicwyj7dVz/ed2U3kq5x+HRBurmrth8PDMvEhsSQblKFMG4ct8vP2knzwvgwbO5aeMz2AjDS5zJ1x2vezF6F6UHPtE4ic66Btj5guMzAD4gLoVsrO//Z9smQwShv2+xuG7D0mFdQR6dyYJTosntQHSxY4zinuFqQ+HkqSVDgeDL7p7MLKbTm3VGuOUrf9ioWbafHveji9qflnl8zgS5jjke
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id v10-20020a056402184a00b0055f0b3ec5d8sm3863582edy.36.2024.02.13.08.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 08:46:59 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: John Crispin <john@phrozen.org>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 2/2] arm64: dts: mediatek: mt7988: add PWM controller
Date: Tue, 13 Feb 2024 17:46:33 +0100
Message-Id: <20240213164633.25447-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240213164633.25447-1-zajec5@gmail.com>
References: <20240213164633.25447-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

Add binding for on-SoC controller that can control up to 8 PWMs.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 arch/arm64/boot/dts/mediatek/mt7988a.dtsi | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
index bba97de4fb44..67007626b5cd 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only OR MIT
 
+#include <dt-bindings/clock/mediatek,mt7988-clk.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
 / {
@@ -78,7 +79,7 @@ gic: interrupt-controller@c000000 {
 			#interrupt-cells = <3>;
 		};
 
-		clock-controller@10001000 {
+		infracfg: clock-controller@10001000 {
 			compatible = "mediatek,mt7988-infracfg", "syscon";
 			reg = <0 0x10001000 0 0x1000>;
 			#clock-cells = <1>;
@@ -103,6 +104,24 @@ clock-controller@1001e000 {
 			#clock-cells = <1>;
 		};
 
+		pwm@10048000 {
+			compatible = "mediatek,mt7988-pwm";
+			reg = <0 0x10048000 0 0x1000>;
+			clocks = <&infracfg CLK_INFRA_66M_PWM_BCK>,
+				 <&infracfg CLK_INFRA_66M_PWM_HCK>,
+				 <&infracfg CLK_INFRA_66M_PWM_CK1>,
+				 <&infracfg CLK_INFRA_66M_PWM_CK2>,
+				 <&infracfg CLK_INFRA_66M_PWM_CK3>,
+				 <&infracfg CLK_INFRA_66M_PWM_CK4>,
+				 <&infracfg CLK_INFRA_66M_PWM_CK5>,
+				 <&infracfg CLK_INFRA_66M_PWM_CK6>,
+				 <&infracfg CLK_INFRA_66M_PWM_CK7>,
+				 <&infracfg CLK_INFRA_66M_PWM_CK8>;
+			clock-names = "top", "main", "pwm1", "pwm2", "pwm3", "pwm4", "pwm5", "pwm6",
+				      "pwm7","pwm8";
+			#pwm-cells = <2>;
+		};
+
 		clock-controller@11f40000 {
 			compatible = "mediatek,mt7988-xfi-pll";
 			reg = <0 0x11f40000 0 0x1000>;
-- 
2.35.3


