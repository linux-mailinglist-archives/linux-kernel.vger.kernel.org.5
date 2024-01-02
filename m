Return-Path: <linux-kernel+bounces-13988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5A1821689
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 03:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 075481C21059
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 02:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2189A20E0;
	Tue,  2 Jan 2024 02:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4EevxXc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274E71866;
	Tue,  2 Jan 2024 02:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7815ba075f9so390457885a.0;
        Mon, 01 Jan 2024 18:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704163295; x=1704768095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eRVOpblwQ3hnrC1ABa9hLFHr9iquzQYphLKUbyNwreY=;
        b=R4EevxXcQFa04jfqAQmBIUF+mMIHAFIMX2QgfzrwNvgfiB6EtHyXSG7WaEm7RTgbh1
         T3nmqFMiWH1Ovddzrz7eB7j/RwgGw73H27Rf7YM90V9apshhif8Iypy0cXdoty4RXjji
         /3+aJ4GFie+JmqneVzC9yTu55Tv+ssZ2jUIWMiDQ3D0uNcVmiDLXMhyNwaObjVkJu2sI
         10OFjK+AB+8Vigixt/KJxBLhQr3DkJKNuHpzr8RlprEnbJb7Lr1L9O9zcazx/z4TDeVJ
         hVdebrkTh0b+waR+ev3w6PSczwa219kNvHvK5U3A9kQOGbs+sEp/u5ynxo/BFRdrLF/y
         Xr4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704163295; x=1704768095;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eRVOpblwQ3hnrC1ABa9hLFHr9iquzQYphLKUbyNwreY=;
        b=wlvibAENScCK89wSSOuBjVbCdFLMrurOujtypsnBJ2SkSiV0kQuJzrrBM+1P+paGiM
         SpqSkNaIaFE0T9+NDg74gMg0kjYqcCrE6UhOcO6QzB0dqxby+73sJTO9Zh7d87AunI0+
         usF/gfXdaCD2ee3txy9ba/XrMWBVqBKcI3mczsSApOPDh26WT+GC84oIugjGDza7B7yz
         KppirfUkYShgxamFEamYiLTC7KruyKTbZY0evc4RFbSWr36n4fcH+UkLMnfcEqBKwTbs
         MaZUkUDnH9osTYcI1/w5oeXleoCdC3fHPUxppISL5ynM2fZvsacACwnWYRpqgsaxu1aW
         t1Ow==
X-Gm-Message-State: AOJu0YzYocXxhxTv4kIRCzJ5PrCwv05ukvznbJCQGE3fNtVV5p/4mSys
	ABkuWlRCiUnci84D+6LL/0I=
X-Google-Smtp-Source: AGHT+IEl3+Pk1MOkQjs46lysrTP/eWZLzFXJpHaRZUn8ihW9X0n1DRVLcHdsPtYNlhrgHw7yuwO0Mg==
X-Received: by 2002:ae9:e416:0:b0:781:415c:273e with SMTP id q22-20020ae9e416000000b00781415c273emr17154242qkc.99.1704163295025;
        Mon, 01 Jan 2024 18:41:35 -0800 (PST)
Received: from localhost.localdomain (107-015-241-140.res.spectrum.com. [107.15.241.140])
        by smtp.gmail.com with ESMTPSA id bk7-20020a05620a1a0700b0077d7326c60csm9161896qkb.38.2024.01.01.18.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jan 2024 18:41:34 -0800 (PST)
From: John Clark <inindev@gmail.com>
To: "Rob Herring" <robh+dt@kernel.org>,
	"Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
	"Conor Dooley" <conor+dt@kernel.org>,
	"Heiko Stuebner" <heiko@sntech.de>,
	linux-rockchip@lists.infradead.org
Cc: "Thomas McKahan" <tmckahan@singleboardsolutions.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	John Clark <inindev@gmail.com>
Subject: [PATCH] arm64: dts: rockchip: nanopc-t6 sdmmc regulator
Date: Tue,  2 Jan 2024 02:40:53 +0000
Message-ID: <20240102024054.1030313-1-inindev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sdmmc on the nanopc-t6 is powered by vcc3v3_sd_s0, not vcc_3v3_s3
add the vcc3v3_sd_s0 regulator, and control it with gpio4_a5

Signed-off-by: John Clark <inindev@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dts | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dts b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dts
index 54445f929a37..fc8add8df3db 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dts
@@ -159,6 +159,17 @@ vcc3v3_pcie30: vcc3v3-pcie30-regulator {
 		regulator-max-microvolt = <3300000>;
 		vin-supply = <&vcc5v0_sys>;
 	};
+
+	vcc3v3_sd_s0: vcc3v3-sd-s0-regulator {
+		compatible = "regulator-fixed";
+		enable-active-low;
+		gpio = <&gpio4 RK_PA5 GPIO_ACTIVE_LOW>;
+		regulator-boot-on;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "vcc3v3_sd_s0";
+		vin-supply = <&vcc_3v3_s3>;
+	};
 };
 
 &combphy0_ps {
@@ -544,7 +555,7 @@ &sdmmc {
 	no-mmc;
 	no-sdio;
 	sd-uhs-sdr104;
-	vmmc-supply = <&vcc_3v3_s3>;
+	vmmc-supply = <&vcc3v3_sd_s0>;
 	vqmmc-supply = <&vccio_sd_s0>;
 	status = "okay";
 };
-- 
2.43.0


