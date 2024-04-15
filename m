Return-Path: <linux-kernel+bounces-145156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEBD8A5036
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B935428A1BE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24974131187;
	Mon, 15 Apr 2024 12:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="tICqBGUd"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D113476033
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 12:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185449; cv=none; b=vE/fdxoRf/55Na90iYzWMZjoT5Qu0Teo+b1EvoJ5DWuq3XzPZP2yKWd2Zij06SC059SqWLoFBWwFkX47XS93Wc9yTJcJEx9p8WJGpFia++j9D5SDBXxAOqDLyOJiM8s1ng0GSX/KVVZ56oFbWJPleryK6+gsVf1OX7UlC1tzIjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185449; c=relaxed/simple;
	bh=jm3Ue9Nbd4Ke4ovJH14S8X19gT0B/9VD6SAIXhnTMl8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iArax42KPUGNvtMUX4tmz9IlzoxD3TTCntgDBvDwULy08O0vIT+v1ItvDPMIdcBVCzBawCUss+eqG0IWC23pDG/NgWNZo2rKl7k4U5i7Rj4V6ENmzI/RpQ5MbTHmod+RS2SOxbMZRQwpIKMFUuWKBFc0SlujTVcMpHP+PGkPb3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=tICqBGUd; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D777341236
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 12:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1713185443;
	bh=/+lz4gvRbuYKUPO9p5AcEAQ4a8bxIR1nS1c0YAZAbpc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=tICqBGUdaWq3yAIJOaxwAFBsmwT0xs8lzrTJJIlID30W6QzitqwCqEVSHPmpD9Vna
	 BIMEl3Dym3LGqCiIaPQ8E173zOtv2yxqY6OwJ1MmPTtpzxAjbnDyKc+a+HOTMbBDvC
	 Ze4l1FJSnJHHizpAOw0JSf9Bw8nBdeiWr2UipSCa3YZWNGziQwuwbmrDJ9kYpaQhCk
	 V8N4e4e4s0DVC85v4nsLyoJ7WfJeNpOEOSWwj1uO4CutTXFq8fMH+Vp3KEnlh7OdxO
	 H0GXCp6YlOX4Oi2W6G9tT1JVFCSYLT9IzkSbxFTwtDALkZVPWoATBAeebJM4w/5w8f
	 u3EJovuDVvoIA==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a46938e24dbso53768366b.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 05:50:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713185438; x=1713790238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/+lz4gvRbuYKUPO9p5AcEAQ4a8bxIR1nS1c0YAZAbpc=;
        b=FU8UZCNPo3PjsHLdv2E4r3NBJR66Rhuk6JKvtaezXHv3wtFvUPzujPbn2sSQr564I3
         UgV5oAzgPiwaQFqg5T3CWv1aK0tevIVBCOqjUzM6BMM+V1yak2xxJHemvw+zMEaWa7zU
         glwpN1xvhAF6ipYeODCapWO8JN2KHDnSFHTsRkfJpIR5RsTN8yZgkvPzyXeaxMqKk39O
         /xpDKbYSRKBIt9JAOahPn8uhUCsQt4MVi2rVACHHcSNMUbDRHthyEXcL8omSuwLokI6x
         HRWcuKoymqWHTNQ/C2QbFRblS3BAZmOmZsOSuxB8Ls/16QW9xUmlHaKlmZJ5L5vuZfJy
         wIwg==
X-Forwarded-Encrypted: i=1; AJvYcCXVtrE2Rm8WTfc2hAAjBbpPe5z0aj//826w4+1McnkUxCaBaORRx0aIlCNuhQ3Ep7WuuSCFW3jmI/VeqhNeiXeAR5wfGXHog7QQtFaE
X-Gm-Message-State: AOJu0YzW56zTK1iF1MZxO4tEno4WkSeLEr35rQLAmKyxLgjHaE6rDMJB
	K0Y5+Sbq4FPAnv4NXWkdiSpBbrVjiPjpcv0V8EScSbHJaBiUDh9GfaNeG6TJ0T2PGBVOEdYJmmd
	msV2KjxdC/sxNQgVzciqGbtAVj9sqjyq3+IorZjb0bJammZ5QUAZbiN9ch9Gji6A6vQe0KU9O/B
	9keQ==
X-Received: by 2002:a17:906:6d0e:b0:a52:561c:ca87 with SMTP id m14-20020a1709066d0e00b00a52561cca87mr2392079ejr.1.1713185437898;
        Mon, 15 Apr 2024 05:50:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZfcd/TjRul4GHXkO5qH5k2zYzb1Tgdzi4hxLh3ejZJdiWBUESLY7cEG1prI/RLPSXTbTpRg==
X-Received: by 2002:a17:906:6d0e:b0:a52:561c:ca87 with SMTP id m14-20020a1709066d0e00b00a52561cca87mr2392062ejr.1.1713185437542;
        Mon, 15 Apr 2024 05:50:37 -0700 (PDT)
Received: from bojack.fritz.box (197-53-142-46.pool.kielnet.net. [46.142.53.197])
        by smtp.gmail.com with ESMTPSA id bz2-20020a1709070aa200b00a51a9eccf2asm5455573ejc.125.2024.04.15.05.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 05:50:36 -0700 (PDT)
From: Hannah Peuckmann <hannah.peuckmann@canonical.com>
To: linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Emil Renner Berthing <kernel@esmil.dk>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Walker Chen <walker.chen@starfivetech.com>,
	Hal Feng <hal.feng@starfivetech.com>,
	Xingyu Wu <xingyu.wu@starfivetech.com>
Subject: [PATCH v1 2/2] riscv: dts: starfive: visionfive 2: Remove non-existing I2S hardware
Date: Mon, 15 Apr 2024 14:50:33 +0200
Message-Id: <20240415125033.86909-3-hannah.peuckmann@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240415125033.86909-1-hannah.peuckmann@canonical.com>
References: <20240415125033.86909-1-hannah.peuckmann@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This partially reverts
commit 92cfc35838b2 ("riscv: dts: starfive: Add the nodes and pins of I2Srx/I2Stx0/I2Stx1")

This added device tree nodes for I2S hardware that is not actually on the
VisionFive 2 board, but connected on the 40pin header. Many different extension
boards could be added on those pins, so this should be handled by overlays
instead.
This also conflicts with the TDM node which also attempts to grab GPIO 44:

  starfive-jh7110-sys-pinctrl 13040000.pinctrl: pin GPIO44 already requested by 10090000.tdm; cannot claim for 120c0000.i2s

Fixes: 92cfc35838b2 ("riscv: dts: starfive: Add the nodes and pins of I2Srx/I2Stx0/I2Stx1")
Signed-off-by: Hannah Peuckmann <hannah.peuckmann@canonical.com>
---
 .../jh7110-starfive-visionfive-2.dtsi         | 58 -------------------
 1 file changed, 58 deletions(-)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
index d89eef6e2633..2b3e952513e4 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
@@ -279,24 +279,6 @@ &i2c6 {
 	status = "okay";
 };
 
-&i2srx {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2srx_pins>;
-	status = "okay";
-};
-
-&i2stx0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mclk_ext_pins>;
-	status = "okay";
-};
-
-&i2stx1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2stx1_pins>;
-	status = "okay";
-};
-
 &mmc0 {
 	max-frequency = <100000000>;
 	assigned-clocks = <&syscrg JH7110_SYSCLK_SDIO0_SDCARD>;
@@ -447,46 +429,6 @@ GPOEN_SYS_I2C6_DATA,
 		};
 	};
 
-	i2srx_pins: i2srx-0 {
-		clk-sd-pins {
-			pinmux = <GPIOMUX(38, GPOUT_LOW,
-					      GPOEN_DISABLE,
-					      GPI_SYS_I2SRX_BCLK)>,
-				 <GPIOMUX(63, GPOUT_LOW,
-					      GPOEN_DISABLE,
-					      GPI_SYS_I2SRX_LRCK)>,
-				 <GPIOMUX(38, GPOUT_LOW,
-					      GPOEN_DISABLE,
-					      GPI_SYS_I2STX1_BCLK)>,
-				 <GPIOMUX(63, GPOUT_LOW,
-					      GPOEN_DISABLE,
-					      GPI_SYS_I2STX1_LRCK)>,
-				 <GPIOMUX(61, GPOUT_LOW,
-					      GPOEN_DISABLE,
-					      GPI_SYS_I2SRX_SDIN0)>;
-			input-enable;
-		};
-	};
-
-	i2stx1_pins: i2stx1-0 {
-		sd-pins {
-			pinmux = <GPIOMUX(44, GPOUT_SYS_I2STX1_SDO0,
-					      GPOEN_ENABLE,
-					      GPI_NONE)>;
-			bias-disable;
-			input-disable;
-		};
-	};
-
-	mclk_ext_pins: mclk-ext-0 {
-		mclk-ext-pins {
-			pinmux = <GPIOMUX(4, GPOUT_LOW,
-					     GPOEN_DISABLE,
-					     GPI_SYS_MCLK_EXT)>;
-			input-enable;
-		};
-	};
-
 	mmc0_pins: mmc0-0 {
 		 rst-pins {
 			pinmux = <GPIOMUX(62, GPOUT_SYS_SDIO0_RST,
-- 
2.40.1


