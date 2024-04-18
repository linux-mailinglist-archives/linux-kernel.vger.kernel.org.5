Return-Path: <linux-kernel+bounces-149929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 643008A97FF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAF01B223AE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E55315E1F6;
	Thu, 18 Apr 2024 10:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="je29j5SS"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29D115D5C1;
	Thu, 18 Apr 2024 10:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713437892; cv=none; b=CU0LPkkaYBeG/o8L4ySUm8ol+l8dptXxvqnyOJVPcVfPHl/3prSm54V1Y+cQfMyVpeOXLhhHXoeHIxXlmQTNpDSMXyOCF1lwbs/ApEUm534e2qv+8+vNazWPTBy7/7/rt5KQoM9zB7KKBpMx3E5/ZMy1aQJx3usy9vhNSE9kH5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713437892; c=relaxed/simple;
	bh=c+HtUfU8cE/PCyrZjd9uRjkFQwV2SJ12Ui0Ms0/s8yo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hYGDQszcifkp8N2ulM99Z34KmdNqE8GCu/Thz41RVYm93Go8g7bIUqo2webYGl9efpx7pF8/M9oAOBg5s+XfbIS0jE4mcIpGBSGozbkv8fM6FWdKaUuNDY94LBvXeYK1m5MJAmIP8fetB1olkXbUzVRSU0iyfxeAjawQ6JzqW8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=je29j5SS; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2db2f6cb312so13741621fa.2;
        Thu, 18 Apr 2024 03:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713437889; x=1714042689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rrxIXj7RnRz6Inm0MPVjaqJdEXgL4gVk17zWxjNGgWs=;
        b=je29j5SSHXNsGYz215OVff9d2er5Ylt8DF9tdyXtUKGjcsTCyGKkyhsH5hLRXuQAHH
         A0CkG9HCp3e/y/lu6cpO30UCDwaYHDutEd+nJgnK73MeNeu29jrAmEO4HClqGLc5pHRq
         wo7NxvGAvMqt7FPe+Oyk3czKw92jzSMZv5FhWqPVobL/pQOFrxZxU+1fpkM/+Les8omW
         Cm/iTUjbo7uD8qTV7GB9RM65E3+M8eC1UKS88SIqackM/JNpQYazNBGGu8gkEzM3EXWZ
         DBG4yPndTbUKj3X923z+ueYgI9vaHltwHHnpKNCgr3nrOs/326OS4wDimn2eFURTNR/0
         m9Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713437889; x=1714042689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rrxIXj7RnRz6Inm0MPVjaqJdEXgL4gVk17zWxjNGgWs=;
        b=XMNlji8ByRtw732W/a/YsDVNKYEK8Db5xDvd8PPbvtXmjlZscSA24S1c4ZMjdWDtHJ
         cA4Q+MpY/K/R0YHZ1/i2rIP9cNeRNGlKsTziMdwruyK1ONw+c30Au33LMuFTTytLBGMy
         KZ0uXgnVMduHEhNcjq8N2pcVPviyRfS8oPQhnssh6gjas/7+E6BNB2oAwj569aqDaBTJ
         Yw1vUFdBthr5Uu8P8RZCpfVqAnAvg1AZXHZkByA7RckHMWvvB6iOOrK6zL2vB3exy/nZ
         dmW+FF1qkl/HV7c7HKFwIdgI2wIdZCuM+8AMI07uAoSHMgTbUtGkdOwbJmNHIJtMz45n
         WUKA==
X-Forwarded-Encrypted: i=1; AJvYcCWb9Ec40foDTdKRNNPGQh+L2WGHr0Kpej7v30iDaqah9TWnd7IEofnT1E/jxtDDcKx2LWhUTSlyfm/ZoJyy4fJs56Fx/ABdtl2gaYAw+qUbeHgxYAYZ44EkRjCuFuwL2jniLHZZyfXXhw==
X-Gm-Message-State: AOJu0YxSWbdLR3Fp8qPdYSoxSC8p11/klgyGpvYkOdIWKn28/b9S9nCD
	um+RB05XWZgipbmaEY9xEL2hOrHA9NkntevqeWdePvpqvPMlIQUQW5s1lF1/
X-Google-Smtp-Source: AGHT+IEnaxJjPFvGEVHV2AJPn5rK9q/wGwFArQkhNwfFo41T53iJo9bm5Ud2gkymL1QDpEaN0drT2g==
X-Received: by 2002:a05:6512:3f0b:b0:513:ca40:fafc with SMTP id y11-20020a0565123f0b00b00513ca40fafcmr1950544lfa.11.1713437868011;
        Thu, 18 Apr 2024 03:57:48 -0700 (PDT)
Received: from andrejs-nb.int.toradex.com (77-59-154-235.dclient.hispeed.ch. [77.59.154.235])
        by smtp.gmail.com with ESMTPSA id hx11-20020a170906846b00b00a46d2e9fd73sm724794ejc.222.2024.04.18.03.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 03:57:47 -0700 (PDT)
From: Andrejs Cainikovs <andrejs.cainikovs@gmail.com>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] arm64: dts: k3-am625-verdin: enable nau8822 pll
Date: Thu, 18 Apr 2024 12:57:30 +0200
Message-Id: <20240418105730.120913-1-andrejs.cainikovs@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>

In current configuration, nau8822 codec on development carrier board
provides distorted audio output. This happens due to reference clock
is fixed to 25MHz and no PLL is enabled. Following is the calculation
of deviation error for different frequencies:

44100Hz:

fs = 256 (fixed)
prescaler = 2
target frequency = 44100 * 256 * 2 = 22579200
deviation = 22579200 vs 25000000 = 9.6832%

48000Hz:

fs = 256 (fixed)
prescaler = 2
target frequency = 48000 * 256 * 2 = 24576000
deviation = 24576000 vs 25000000 = 1.696%

Enabling nau822 PLL via providing mclk-fs property to simple-audio-card
configures clocks properly, but also adjusts audio reference clock
(mclk), which in case of TI AM62 should be avoided, as it only
supports 25MHz output [1][2].

This change enables PLL on nau8822 by providing mclk-fs, and moves
away audio reference clock from DAI configuration, which prevents
simple-audio-card to adjust it before every playback [3].

[1]: https://e2e.ti.com/support/processors-group/processors/f/processors-forum/1175479/processor-sdk-am62x-output-audio_ext_refclk0-as-mclk-for-codec-and-mcbsp/4444986#4444986
[2]: https://e2e.ti.com/support/processors-group/processors/f/processors-forum/1188051/am625-audio_ext_refclk1-clock-output---dts-support/4476322#4476322
[3]: sound/soc/generic/simple-card-utils.c#L441

Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
---
This patch requires https://lore.kernel.org/all/20240409121719.337709-1-andrejs.cainikovs@gmail.com/ to be applied,
if not the audio will just stop working because no code will ever enable the required clock to the codec.
---
 arch/arm64/boot/dts/ti/k3-am62-verdin-dev.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin-dev.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin-dev.dtsi
index 74eec1a1abca..5c1284b802ad 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-verdin-dev.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-verdin-dev.dtsi
@@ -14,6 +14,7 @@ sound {
 		simple-audio-card,bitclock-master = <&codec_dai>;
 		simple-audio-card,format = "i2s";
 		simple-audio-card,frame-master = <&codec_dai>;
+		simple-audio-card,mclk-fs = <256>;
 		simple-audio-card,name = "verdin-nau8822";
 		simple-audio-card,routing =
 			"Headphones", "LHP",
@@ -34,7 +35,6 @@ sound {
 			"Line", "Line In";
 
 		codec_dai: simple-audio-card,codec {
-			clocks = <&audio_refclk1>;
 			sound-dai = <&nau8822_1a>;
 		};
 
@@ -107,6 +107,8 @@ nau8822_1a: audio-codec@1a {
 		reg = <0x1a>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_i2s1_mclk>;
+		clock-names = "mclk";
+		clocks = <&audio_refclk1>;
 		#sound-dai-cells = <0>;
 	};
 
-- 
2.34.1


