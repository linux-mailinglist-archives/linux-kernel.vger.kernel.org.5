Return-Path: <linux-kernel+bounces-26949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED7182E86B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 05:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CF421F236F2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 04:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED4ED2FC;
	Tue, 16 Jan 2024 04:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="lzTimnaR"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BF2882E
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 04:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-28cf491b197so4757107a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 20:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1705378270; x=1705983070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lNWOGH7VpQY6V8fQKtozhdwdDDbXnjZtAA+yG72Gg0I=;
        b=lzTimnaRDqVlnO5uGWtGw0kq3oftjo8S/OaySCU9PYzYg0Bt1DbIbGdcCmyAvaKjeO
         ggER/jZjF1dXwqkvZe6kK87izhKuYnHUz5Fh86jcJ1a3UCCHhL3BJOHcwbbQ9LDsxllM
         GuH+Ec2fKc+2uIAi3IPLXHFT1XLGFawqua+6mKBidmIyOpPQyJuCbQ32PPjRmtR+50dz
         TjtCln60cxCOcXDFs9Hk9O2HkGrg6OtaJXtBUns2IUWvNSwo8lQ9Jx0oVcSqyTsQGIxO
         gyO+eZRn3TM6V2JSK02GWLI2CBGckNLBiE2EdbamInXuabzCHp81N3owEB7zEu+qLDC3
         f4zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705378270; x=1705983070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lNWOGH7VpQY6V8fQKtozhdwdDDbXnjZtAA+yG72Gg0I=;
        b=Mwcv356ay4jmCT+FkGKaNmeF5QM5sZ/aQ07mRZSuSv39/Pad5X+CDCASwoSGa7ucQH
         t1Iorx5H+rPO5cfOA3YhRD3YpphvAQi/LnSXpo0fTKN7HC6jlVrR1njl63baN5Vtea2G
         Tr9jH/KFNpymBfaU7Hz0voNKNt37kjRw1lqLj9PXSLeM+1ZbVYzsiftQdnUM58XzsWHD
         SaYLwjPT8jW6LkJVlGtCyC+0cLHQ77t/DX727xjX/wzlNkvrqBmpy3n+Or9E6Mc6/YJU
         Dq60eTps6ANJgeYFiEbFY2Kf/7pbW3MIqLULBrDdkKVsKlfE6aU+tZgCCj+XKnUIScxQ
         wCRA==
X-Gm-Message-State: AOJu0YycbYzwF/PsjRsO65QtBez/SHpEtqkialFw+nsQIC5cwtdtrRQ7
	FPI+qXKkPYLhIuSmKQSiOCaRBYCIfE5/SxiWHG6l06Q8TAiGtw==
X-Google-Smtp-Source: AGHT+IHdLaq3l3g4Pmg80E7WRUhrwEdvo239qSRGLCobH/JD2z9cKN13WMng5fzHJO29R4gzkXw4UQ==
X-Received: by 2002:a05:6a00:4f8c:b0:6d9:aa4b:3800 with SMTP id ld12-20020a056a004f8c00b006d9aa4b3800mr3973757pfb.19.1705378270417;
        Mon, 15 Jan 2024 20:11:10 -0800 (PST)
Received: from hsinchu15.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id e3-20020a056a0000c300b006da14f68ac1sm8348585pfj.198.2024.01.15.20.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 20:11:10 -0800 (PST)
From: Nylon Chen <nylon.chen@sifive.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	conor+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	robh+dt@kernel.org,
	u.kleine-koenig@pengutronix.de,
	thierry.reding@gmail.com,
	aou@eecs.berkeley.edu
Cc: zong.li@sifve.com,
	vincent.chen@sifive.com,
	linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	nylon7717@gmail.com,
	Nylon Chen <nylon.chen@sifive.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [v6 1/3] riscv: dts: sifive: unleashed/unmatched: Remove PWM controlled LED's active-low properties
Date: Tue, 16 Jan 2024 12:10:52 +0800
Message-ID: <20240116041054.11641-2-nylon.chen@sifive.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240116041054.11641-1-nylon.chen@sifive.com>
References: <20240116041054.11641-1-nylon.chen@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This removes the active-low properties of the PWM-controlled LEDs in
the HiFive Unmatched device tree.

The reference is hifive-unleashed-a00.pdf[0] and hifive-unmatched-schematics-v3.pdf[1].

Link: https://sifive.cdn.prismic.io/sifive/c52a8e32-05ce-4aaf-95c8-7bf8453f8698_hifive-unleashed-a00-schematics-1.pdf [0]
Link: https://sifive.cdn.prismic.io/sifive/6a06d6c0-6e66-49b5-8e9e-e68ce76f4192_hifive-unmatched-schematics-v3.pdf [1]

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Co-developed-by: Zong Li <zong.li@sifve.com>
Signed-off-by: Zong Li <zong.li@sifve.com>
Co-developed-by: Vincent Chen <vincent.chen@sifive.com>
Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
---
 arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts |  8 ++++----
 arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts | 12 ++++--------
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
index 900a50526d77..11e7ac1c54bb 100644
--- a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
+++ b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
@@ -49,7 +49,7 @@ led-controller {
 		compatible = "pwm-leds";
 
 		led-d1 {
-			pwms = <&pwm0 0 7812500 PWM_POLARITY_INVERTED>;
+			pwms = <&pwm0 0 7812500 0>;
 			active-low;
 			color = <LED_COLOR_ID_GREEN>;
 			max-brightness = <255>;
@@ -57,7 +57,7 @@ led-d1 {
 		};
 
 		led-d2 {
-			pwms = <&pwm0 1 7812500 PWM_POLARITY_INVERTED>;
+			pwms = <&pwm0 1 7812500 0>;
 			active-low;
 			color = <LED_COLOR_ID_GREEN>;
 			max-brightness = <255>;
@@ -65,7 +65,7 @@ led-d2 {
 		};
 
 		led-d3 {
-			pwms = <&pwm0 2 7812500 PWM_POLARITY_INVERTED>;
+			pwms = <&pwm0 2 7812500 0>;
 			active-low;
 			color = <LED_COLOR_ID_GREEN>;
 			max-brightness = <255>;
@@ -73,7 +73,7 @@ led-d3 {
 		};
 
 		led-d4 {
-			pwms = <&pwm0 3 7812500 PWM_POLARITY_INVERTED>;
+			pwms = <&pwm0 3 7812500 0>;
 			active-low;
 			color = <LED_COLOR_ID_GREEN>;
 			max-brightness = <255>;
diff --git a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
index 07387f9c135c..b328ee80693f 100644
--- a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
+++ b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
@@ -51,8 +51,7 @@ led-controller-1 {
 		compatible = "pwm-leds";
 
 		led-d12 {
-			pwms = <&pwm0 0 7812500 PWM_POLARITY_INVERTED>;
-			active-low;
+			pwms = <&pwm0 0 7812500 0>;
 			color = <LED_COLOR_ID_GREEN>;
 			max-brightness = <255>;
 			label = "d12";
@@ -68,20 +67,17 @@ multi-led {
 			label = "d2";
 
 			led-red {
-				pwms = <&pwm0 2 7812500 PWM_POLARITY_INVERTED>;
-				active-low;
+				pwms = <&pwm0 2 7812500 0>;
 				color = <LED_COLOR_ID_RED>;
 			};
 
 			led-green {
-				pwms = <&pwm0 1 7812500 PWM_POLARITY_INVERTED>;
-				active-low;
+				pwms = <&pwm0 1 7812500 0>;
 				color = <LED_COLOR_ID_GREEN>;
 			};
 
 			led-blue {
-				pwms = <&pwm0 3 7812500 PWM_POLARITY_INVERTED>;
-				active-low;
+				pwms = <&pwm0 3 7812500 0>;
 				color = <LED_COLOR_ID_BLUE>;
 			};
 		};
-- 
2.42.0


