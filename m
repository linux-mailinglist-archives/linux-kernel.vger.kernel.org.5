Return-Path: <linux-kernel+bounces-87700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A24F86D7EC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 00:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8B481F23C67
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 23:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92437A158;
	Thu, 29 Feb 2024 23:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdLGrhwI"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E6C74BE0;
	Thu, 29 Feb 2024 23:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709249768; cv=none; b=VNfwWPATCcmofgBJGfZqtx4LyzhWOuESvdIG/wlXcz7QN3KPHXq+aeioWMeq1IoPI9ykmkltbkydz1Z54b27w5j7459r6+SDxaD2F0eEuZFUoirxSLPzm81bVCwhO+2vbO6Xc4zM3Pik52JM9jXn+0owP1m0kBBL9TltifEDB2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709249768; c=relaxed/simple;
	bh=q4q7erHPk4dn/Nf8pXKLzbX4utEAaL/mtldvKHHBoS8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QRiKVya6IOgX8jgYU52dMZB/4pUGChfAUAkIbGavALFNrPBvhpNKiu8mRtPsNJZWh99hScICPAhBP3e97eGjQux9g64nOLNUN308B4f6gtgVP3EoB1zOs6IDBcFrmDlmxshjIVeDBtLv3f40MdX5PKdKF25l0TkquXHJ+l4xtDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AdLGrhwI; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3651b948db6so6013195ab.0;
        Thu, 29 Feb 2024 15:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709249765; x=1709854565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+28orNpMGgXroEpuUoZhdTb8QFxzIWPQpfl/txukD6k=;
        b=AdLGrhwIxHQ54otLwzG+YS877fft+He9Gds3o4Epfnug5a9sB++yDtbB+hlwBHnnFs
         PcjimqGxPI+gJYghY/XW9aln+wmRIqdj91tuG7ZzIx0rFIbeiYoO7bB2at4LUtkWkLlP
         GuAIeKCHUgqdqsmyW72TjP0OrWwLhaSfLoK1JYLlcdMz/4ianGBJ/0bAOALPI7fvmoNR
         3DoGW8+483oCNRUPwqWMDM1NTXPgx7ljODtIJ5on91zUMQVyiahPrwW7hwH04j1UXsDj
         Z9n3D1+bg/M0yW14efL3qt7dOZxPZ8quwFj+WBuMFpCY0U4aGWhXhafC6HHimo7Ln+Mt
         RVOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709249765; x=1709854565;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+28orNpMGgXroEpuUoZhdTb8QFxzIWPQpfl/txukD6k=;
        b=hO/qB99dAfYftscN2lrpu94v6x8+EK2sJh52/4L96telXGHIT/CT79WilTHjkubH0c
         fQxiENuyMtWB5kUb7UMDihrwkBHRX+XMf84pHy40DlNvnaAvJ9KNoHK3h+xPmm9RIFmm
         yXmwMuhzhgLrA+iJxJO+xMcCQzHUBbESe1210FBJcxvt2QIli8K1550HBx6c6K9Fdwkx
         C3mrHbSqKIgyJpAxmRhZjjSM5cc0Qcp04isD1vKrubNhX/CCYgoW0IMo92Sdb3DDV7XL
         XLexBe8vyQJFajZbgmtvsgbVlysPJXTbblYasXroU63r4JanQPI47XXixdBfMYz+2QTg
         2KKA==
X-Forwarded-Encrypted: i=1; AJvYcCVnOEx+JjWi7Y/Etm+UdISj9ZVtcpGbCqJhVniFiTxg6Zr5UDoNc92tzttd7rUDexWQTZ93ecS11LVNFbXKAn9+ahizK+e5Mul/IjKuVbwoRPtSemTm+IJasERyia9zFXcwIB9yhiGXpA==
X-Gm-Message-State: AOJu0YwJlxeOmF4UB1wg/SBOnezfHV/1uTC37OJ1PTc9KLx3ic1yozR6
	2HisNZWNIplHBEabS+KGy2LRlfV9X1rOpaHhTqOP3tdiybohmb0ks4b8qUNC5yaGpg==
X-Google-Smtp-Source: AGHT+IFpQBqR2EjhTZVRTHRSZLs3fZz5buNTzVetrB34OkV6yZBLhzpHgpCMW625+nJLMte6I1dBBg==
X-Received: by 2002:a05:6e02:1d83:b0:365:b9c8:4436 with SMTP id h3-20020a056e021d8300b00365b9c84436mr183974ila.10.1709249764757;
        Thu, 29 Feb 2024 15:36:04 -0800 (PST)
Received: from aford-System-Version.lan ([2601:447:d002:5be:c0ab:242c:2712:ad44])
        by smtp.gmail.com with ESMTPSA id j5-20020a056e020ee500b0036576880ffcsm584260ilk.85.2024.02.29.15.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 15:36:04 -0800 (PST)
From: Adam Ford <aford173@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: aford@beaconembedded.com,
	Adam Ford <aford173@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: imx8mp-beacon-kit: Move sai3 to Audio_PLL1
Date: Thu, 29 Feb 2024 17:35:54 -0600
Message-ID: <20240229233556.116944-1-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Beacon board has an LVDS display that cannot get a proper clock rate
from Video_PLL if the DSI is operational due to the way the clock divides
the pixel clocks from video_pll.  To make the LVDS work, the LVDS needs
to use an alternative clock.

Because the clock rated needed for the LDB driving the LVDS display
isn't divisible by the clock rate needed by SAI3, move SAI3 to use
Audio_PLL1, and reconfigure the CODEC to use a 12MHz fixed clock.

Because these clocks are no longer in sync with each other, the sound
generated as the wrong pitch, so reconfigure the SAI3 to be the master
since the CODEC can internally compensate when fed a fixed clock
reference, even if it is not an even multiple of the desired rate.

This now leaves AUDIO_PLL2 completely free for the LDB without
compromising the audio sound from the codec.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts b/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
index a08057410bde..1f827ef38e36 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
@@ -211,20 +211,20 @@ sound-wm8962 {
 
 		simple-audio-card,cpu {
 			sound-dai = <&sai3>;
+			frame-master;
+			bitclock-master;
 		};
 
 		simple-audio-card,codec {
 			sound-dai = <&wm8962>;
 			clocks = <&clk IMX8MP_CLK_IPP_DO_CLKO1>;
-			frame-master;
-			bitclock-master;
 		};
 	};
 };
 
 &audio_blk_ctrl {
-	assigned-clocks = <&clk IMX8MP_AUDIO_PLL1>, <&clk IMX8MP_AUDIO_PLL2>;
-	assigned-clock-rates = <393216000>, <135475200>;
+	assigned-clocks = <&clk IMX8MP_AUDIO_PLL1>;
+	assigned-clock-rates = <393216000>;
 };
 
 &ecspi2 {
@@ -370,8 +370,8 @@ wm8962: audio-codec@1a {
 		pinctrl-0 = <&pinctrl_wm8962>;
 		clocks = <&clk IMX8MP_CLK_IPP_DO_CLKO1>;
 		assigned-clocks = <&clk IMX8MP_CLK_IPP_DO_CLKO1>;
-		assigned-clock-parents = <&clk IMX8MP_AUDIO_PLL2_OUT>;
-		assigned-clock-rates = <22576000>;
+		assigned-clock-parents = <&clk IMX8MP_CLK_24M>;
+		assigned-clock-rates = <12000000>;
 		DCVDD-supply = <&reg_audio>;
 		DBVDD-supply = <&reg_audio>;
 		AVDD-supply = <&reg_audio>;
@@ -499,10 +499,9 @@ &pcie_phy {
 &sai3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sai3>;
-	assigned-clocks = <&clk IMX8MP_CLK_SAI3>,
-			  <&clk IMX8MP_AUDIO_PLL2> ;
-	assigned-clock-parents = <&clk IMX8MP_AUDIO_PLL2_OUT>;
-	assigned-clock-rates = <12288000>, <361267200>;
+	assigned-clocks = <&clk IMX8MP_CLK_SAI3>;
+	assigned-clock-parents = <&clk IMX8MP_AUDIO_PLL1_OUT>;
+	assigned-clock-rates = <12288000>;
 	fsl,sai-mclk-direction-output;
 	status = "okay";
 };
-- 
2.43.0


