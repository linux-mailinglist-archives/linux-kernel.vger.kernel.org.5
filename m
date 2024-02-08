Return-Path: <linux-kernel+bounces-57898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBC184DEC7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40EC9B28651
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CFE6F501;
	Thu,  8 Feb 2024 10:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CUuy6TUv"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B127B6DD15
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 10:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707389515; cv=none; b=FbehtGUlQoer8p+15vQ+3ovfe6BWYFmVeIzg0PmPP8BNfcvg7R2wmPSKjDyDssPUI11bajfNClLwpgPJLi7J7RTSeo29SBbs0iVO/YcCicpye3L46Rp/VqS/phNRX1EGteeEVp4SE6pNdg3Euwua1ncaHSn5XXZ5iIjWmXEQIGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707389515; c=relaxed/simple;
	bh=y7/ClX8jm9pNoqbAeiUFGdcPlFjmP639s6GQLJvW8Vg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mWroS/xrj4YZT1KV9fgctsueOyO2ygP6mPSNpRz8VjwkUDkSk5splOT9JpMgP+p6r2diaLtafDL5sz4IOaK8QP+EieMgGrqBBS4OpiDHfyCaPvOGLAyr5G7/x7ppcE0uCSZ/EzEw9RgYjiu3niyj6u07Ziv01FWqzQ2+X0Hhv2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CUuy6TUv; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4103be6e938so3020865e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 02:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707389512; x=1707994312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T87H/XSByhpOmvKnsfYAKLCX6VAhuwKnoaIswNJ+Sbo=;
        b=CUuy6TUvZE9gNVxp0C3RRhKN+RenUWcM5A/UD4HYWTSGCOvRrOduQq9V766LRRX+uN
         01UxL7kzegKzzYxF3E4lV4bMqcgTaHDlxx/U4iKvfmyMlzR5ybWQVjVXkiLBUZSIC1j2
         ziBCDKOFWFz6YKH3Nv1u5ZHkDR/uCcJmnS7ZK5gxUjZ9g8sidISf12H/0wUfZvvIdDI5
         hNHctzWByQBJ66gMbPfU3rgJMaJIchk1DH6FhgLZWZtm9kmWinT7yrXiVRXwhs/EMdEo
         7bvQR31966o2MH8R4xs/iVEeoQ2nuMTsaZAfddedSGcVXKRW/i2mo0suqnMZzLohgFu5
         +0/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707389512; x=1707994312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T87H/XSByhpOmvKnsfYAKLCX6VAhuwKnoaIswNJ+Sbo=;
        b=VfDnWDsn1q79j3kvdOc4wO1tFXmPVV9iyL36NdLgtrUFwpnpHFMst25dqD2JF6tFxY
         MC4zLs7MzOBChEOg01nwrpfLew1dI3gG1reN2H8TZAIxXHs7rW/M1b3DEjZd02aEcWIa
         gUv6OUy372kM14C3aXqdYPi8oIe2AaQTu7QHSfOQKyaF1QfkxV5WUoEqpx3AH7ihTm7h
         gRAQJOzA4nuSc9gY+Fz2APXByI5yDtTB68HmzgbRAiSozmJ0DsHsWHZXapJAISMputZO
         tshNcvh0JeHIDP5e0O+CM6t6Wermm0dSYOTI0WZzKo0miB9PTJ7zNdUYC8YLmcPRSL9N
         BMqw==
X-Gm-Message-State: AOJu0Yz+cMxCGt9gF48WX/c9VX2NHJW+j1woo8O5QcF1SOY2y0fh7F/T
	E3wHatng9hFK3VAmjgMsIccE97sS6FJE//5TAvr8YnoprXKWhCxaNpo6Qm4IXZ0=
X-Google-Smtp-Source: AGHT+IEqtVu9usyP0unuxoRg0f29LAa+qrWbC8Np4ynINyK/Rzbu6COEV7UbZIMgRR8eoYPPFrDPLg==
X-Received: by 2002:a05:600c:3514:b0:40f:d113:44f3 with SMTP id h20-20020a05600c351400b0040fd11344f3mr6370906wmq.0.1707389512127;
        Thu, 08 Feb 2024 02:51:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVkVwBXkJAAGAS8/WAE8KOK3vp1byWcWcFMlof34Tmu7AElG53LAuiMcqOEUw3dCqBy6/+oYTjPl0Ul5Yh0Pp7JW7l269gt1KbusqXGKMl0wvcyrytWn9MPzepznYH8LH/saX7pbA3M9cP3/ZLd2a/kI7Ds1Dsk0MiCLjkwR7DJZz5+UFRjMfbxBPhXIU0VTQyPp913izVT5q6FT+M/J73Ifcet60h0NqUd/1GXE2kQkcI3VuQA1eFqRm5yJ2M3+uvcqjJgAR1TOODd2wGuUQBxydnlsNvjc9RT4mRLQUzKy322/lG8ZMUjW++xkoeFqo4HcsghzAVotpAS4tPIvH3yAfZmR2dcQOmMk4/UD8N5J54=
Received: from krzk-bin.. ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id je3-20020a05600c1f8300b004101bdae3a0sm1247037wmb.38.2024.02.08.02.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 02:51:51 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
	Tony Lindgren <tony@atomide.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	linux-omap@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] ARM: dts: ti: omap: minor whitespace cleanup
Date: Thu,  8 Feb 2024 11:51:46 +0100
Message-Id: <20240208105146.128645-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208105146.128645-1-krzysztof.kozlowski@linaro.org>
References: <20240208105146.128645-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DTS code coding style expects exactly one space before '{'
character.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/ti/omap/am33xx.dtsi | 8 ++++----
 arch/arm/boot/dts/ti/omap/am4372.dtsi | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/ti/omap/am33xx.dtsi b/arch/arm/boot/dts/ti/omap/am33xx.dtsi
index 989d5a6edeed..0614ffdc1578 100644
--- a/arch/arm/boot/dts/ti/omap/am33xx.dtsi
+++ b/arch/arm/boot/dts/ti/omap/am33xx.dtsi
@@ -80,7 +80,7 @@ cpu0_opp_table: opp-table {
 		 * because the can not be enabled simultaneously on a
 		 * single SoC.
 		 */
-		opp-50-300000000{
+		opp-50-300000000 {
 			/* OPP50 */
 			opp-hz = /bits/ 64 <300000000>;
 			opp-microvolt = <950000 931000 969000>;
@@ -88,7 +88,7 @@ opp-50-300000000{
 			opp-suspend;
 		};
 
-		opp-100-275000000{
+		opp-100-275000000 {
 			/* OPP100-1 */
 			opp-hz = /bits/ 64 <275000000>;
 			opp-microvolt = <1100000 1078000 1122000>;
@@ -96,7 +96,7 @@ opp-100-275000000{
 			opp-suspend;
 		};
 
-		opp-100-300000000{
+		opp-100-300000000 {
 			/* OPP100-2 */
 			opp-hz = /bits/ 64 <300000000>;
 			opp-microvolt = <1100000 1078000 1122000>;
@@ -104,7 +104,7 @@ opp-100-300000000{
 			opp-suspend;
 		};
 
-		opp-100-500000000{
+		opp-100-500000000 {
 			/* OPP100-3 */
 			opp-hz = /bits/ 64 <500000000>;
 			opp-microvolt = <1100000 1078000 1122000>;
diff --git a/arch/arm/boot/dts/ti/omap/am4372.dtsi b/arch/arm/boot/dts/ti/omap/am4372.dtsi
index 5fd1b380ece6..0a1df30f2818 100644
--- a/arch/arm/boot/dts/ti/omap/am4372.dtsi
+++ b/arch/arm/boot/dts/ti/omap/am4372.dtsi
@@ -92,7 +92,7 @@ opp-120-720000000 {
 			opp-supported-hw = <0xFF 0x08>;
 		};
 
-		opp-800000000{
+		opp-800000000 {
 			/* OPP Turbo */
 			opp-hz = /bits/ 64 <800000000>;
 			opp-microvolt = <1260000 1234800 1285200>;
-- 
2.34.1


