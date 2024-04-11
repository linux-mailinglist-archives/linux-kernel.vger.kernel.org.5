Return-Path: <linux-kernel+bounces-141300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D86B68A1DEC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53FF3B27946
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B0715E20C;
	Thu, 11 Apr 2024 16:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Frce3vEG"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F64F15E208;
	Thu, 11 Apr 2024 16:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712852106; cv=none; b=E/Emrq9efIZGvUEw1w/b9hHnTbYNRyIMG20VKwMhngNHYynyMW727fU6pceijmaqTXnjG3g18XLhoOKJOs3Lpa257TVpRkT1DC1BV2ckRzjYwuZ3GVgp3DYsGMpvGykATqSZIewcjpYnTcZNOUIXwDh6FekiQVq6YfjgEagIIiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712852106; c=relaxed/simple;
	bh=zFthHjjh9Aso3EVZFd6I/EjfK4r2+rzfemyi6bGp4hI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bv4MsA2amkJbw/0k50zZjWcsvZYloE+b5TUtnGkKsWQTc6zjiWONNwZnABUK+XERDHCD+XWAtrkY7z100hS4p7Btu6sPZrpb1vEI5GK9zggszHouTLFMd4x5fterOOndi8h6I7nMgKFn6Hr0tajBiu1NRL2r+7aAhUiOG6eMiPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Frce3vEG; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ecee5c08e6so38018b3a.3;
        Thu, 11 Apr 2024 09:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712852104; x=1713456904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bHKLXIL7AGZ7PCEor3/6k+rOZmYsF608r3G1HPhZ/Ds=;
        b=Frce3vEGai+M6/ExhG5Tpba6zw8jl9RYa+DDE/FMyjkpyo4O40Gnf0mp5c8qGQy6QO
         ltSwqpxE/5p6WDvEeuWpbPmJmMXM2FSF9rOliY8dv4wDSlht7o9vXi2oEoqhFI9pCKTX
         CKCUg7YkPq7QLKmwN2VHwgYwuqqWV8swvWPB5W9ySqxe7gtS9mPxicNVISdde58C8h+j
         WT2IFNMYCYGwtL4wRRE1OeI85kRQN/XHVSmnjdbMo1MK5jaqMjW6C/G6dp5VftxZz/xT
         u5afE+B6pY/+cX2zRuWpPLmAi9G/SNDvy5jtmDBdwMgxUueXcVr3FvBfGQFoYppVaHor
         JKzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712852104; x=1713456904;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bHKLXIL7AGZ7PCEor3/6k+rOZmYsF608r3G1HPhZ/Ds=;
        b=RMLjO3lXNA8mVozIB8hL29SqeCkZW1C/doQ6nlPgGhyYZZ3IRZp3WQOGq3KLT2xH6B
         CtfFvpvIZyDTnEBH/2ClEM+QLPg+lKTEFpvDaHMDZvqvDg02CZoUvgZQ/b8D+73kmn5n
         k7UXeU5bUP+n3fUJ+NwMcFo2pwYjQsdUr9vQDKIIltqVZKj6pG1ZWydX1mFtPIZIKfdJ
         /Vtn4iNpAdj98rknopkdDvoUBPyeGTe6RNjogKOv422nB/tKOvBaT7b1sz/jj7UOMZs8
         QRn80baDXlWr7LBCYhezSnMM4RT+fcIpDeDD0AlnEsvPzJlIF19Hh9IOYWIf7TM6qtIB
         zM9w==
X-Forwarded-Encrypted: i=1; AJvYcCWin5Ke2OB7JarSkJ3VqE9P8qhZRkHL+iGGZ/wD/WfYjw4iwWiae2AOiqUXsYBTLMYy0nesMJJPPeumPWqk5i6OkloCik/mb5H0IInjXAV9JfBNvbpazGuPF/gYrWCOUN+n8LiB7GDQ/A==
X-Gm-Message-State: AOJu0YxHDOuV/NBzEhdVJIkonln0OHQmwuZgvk+pOVv1UOHwd3c/JxD1
	/EZWR1NvaUQylrDpKV0rojg232jMWWcEi821M5RrIluAtBQQpLPu
X-Google-Smtp-Source: AGHT+IGFtEPQKiuEQiynF7E0e+oZQ/02XP6gKtgqvqBPUSFKvM58AzS0FM2xcxRBqwpZ7OTrkf1t5g==
X-Received: by 2002:a05:6a20:f3b0:b0:1a7:52f7:8a38 with SMTP id qr48-20020a056a20f3b000b001a752f78a38mr307671pzb.15.1712852104412;
        Thu, 11 Apr 2024 09:15:04 -0700 (PDT)
Received: from frhdebian.corp.toradex.com ([201.82.41.210])
        by smtp.gmail.com with ESMTPSA id t184-20020a632dc1000000b005f410b67e60sm1254185pgt.22.2024.04.11.09.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 09:15:04 -0700 (PDT)
From: Hiago De Franco <hiagofranco@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Hiago De Franco <hiago.franco@toradex.com>
Subject: [PATCH] arm64: dts: freescale: imx8m[mp]-verdin: Update audio card name
Date: Thu, 11 Apr 2024 13:14:41 -0300
Message-Id: <20240411161441.70262-1-hiagofranco@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hiago De Franco <hiago.franco@toradex.com>

On the Dahlia and Development carrier boards for the Verdin family
(iMX8MM and iMX8MP), WM8904 and NAU8822 codecs are used. Instead of
module-specific names, switch to more generic names based on the codec
employed on the carrier board itself.

This modification facilitates access to ALSA card names, ensuring
consistency across iMX8MP and iMX8MM, as they share the same carrier
board.

Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-verdin-dahlia.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/imx8mm-verdin-dev.dtsi    | 2 +-
 arch/arm64/boot/dts/freescale/imx8mp-verdin-dahlia.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/imx8mp-verdin-dev.dtsi    | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin-dahlia.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin-dahlia.dtsi
index 1cff0b829357..45f7b8d87517 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-verdin-dahlia.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin-dahlia.dtsi
@@ -10,7 +10,7 @@ sound_card: sound-card {
 		simple-audio-card,format = "i2s";
 		simple-audio-card,frame-master = <&dailink_master>;
 		simple-audio-card,mclk-fs = <256>;
-		simple-audio-card,name = "imx8mm-wm8904";
+		simple-audio-card,name = "verdin-wm8904";
 		simple-audio-card,routing =
 			"Headphone Jack", "HPOUTL",
 			"Headphone Jack", "HPOUTR",
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin-dev.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin-dev.dtsi
index 3c4b8ca125e3..1f6a37f232da 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-verdin-dev.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin-dev.dtsi
@@ -10,7 +10,7 @@ sound_card: sound-card {
 		simple-audio-card,format = "i2s";
 		simple-audio-card,frame-master = <&dailink_master>;
 		simple-audio-card,mclk-fs = <256>;
-		simple-audio-card,name = "imx8mm-nau8822";
+		simple-audio-card,name = "verdin-nau8822";
 		simple-audio-card,routing =
 			"Headphones", "LHP",
 			"Headphones", "RHP",
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin-dahlia.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin-dahlia.dtsi
index 7e9e4b13b5c5..e9ef9c553a47 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-verdin-dahlia.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin-dahlia.dtsi
@@ -10,7 +10,7 @@ sound {
 		simple-audio-card,format = "i2s";
 		simple-audio-card,frame-master = <&codec_dai>;
 		simple-audio-card,mclk-fs = <256>;
-		simple-audio-card,name = "imx8mp-wm8904";
+		simple-audio-card,name = "verdin-wm8904";
 		simple-audio-card,routing =
 			"Headphone Jack", "HPOUTL",
 			"Headphone Jack", "HPOUTR",
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin-dev.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin-dev.dtsi
index a509b2b7fa85..65cbf905a1d9 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-verdin-dev.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin-dev.dtsi
@@ -22,7 +22,7 @@ sound {
 		simple-audio-card,format = "i2s";
 		simple-audio-card,frame-master = <&codec_dai>;
 		simple-audio-card,mclk-fs = <256>;
-		simple-audio-card,name = "imx8mp-nau8822";
+		simple-audio-card,name = "verdin-nau8822";
 		simple-audio-card,routing =
 			"Headphones", "LHP",
 			"Headphones", "RHP",
-- 
2.39.2


