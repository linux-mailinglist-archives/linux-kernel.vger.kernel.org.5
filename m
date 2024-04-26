Return-Path: <linux-kernel+bounces-160478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D92848B3E0C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 631281F271DC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5102117BB10;
	Fri, 26 Apr 2024 17:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SPH8NSzt"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188F3179958
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 17:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714152188; cv=none; b=kYhWeBYK4EIhc2k+iIfvuFZVNXk+QGXeUgoNK4NUZM1oEYkV3Y6xF2noV+cHdw1nj/2AVyJ8Qf1TwsCeElLgvzxHJ5flx3ATNz7HeQNxdbQLBTkoF2ZBcz5urV8UGF6L2YC/TZN2TxDTFt2FwB1pkXoZ9PB1dw+2R0JYMRmuph4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714152188; c=relaxed/simple;
	bh=t0tf5ggyvEv3KEhg9dzpup8fwcOHLyJsYbfkqMonRjM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sx92/2ZgKQ2np3w6oyAm0Cq9AmeBxXO/ON6Qiy2KWBx4fiYH3CC/BwN83fcKroT2n4UgUbfMjvowskJFBPw7EB/RCC1keSrRx8MLmJGM6zIHPe9qc9utIy8C7e+/Pv/5nAxA8borZ/nNjZOQ7y5axW/KgjZiE+o8nNev5TbJov4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=SPH8NSzt; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a5883518135so279572266b.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 10:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1714152183; x=1714756983; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qi1a6qRL/sSf88RkAxOBKeEEBw29sLy7LzarlapS72s=;
        b=SPH8NSztKPcEn605XZ5/OoEwLM/gGovS1u64EWrkrAcO1DewMR/KKvbOrQzEGLxwr+
         iPF9i2/RCf4DpqrrfS00uprg4whKvvnQ1Pg9tm3do+M/+wGxf7/mYzpygisndpSOOCtx
         6BF8FHmK67+iHTtwHsDhawNTEgTGxkgEmnMxZZurXcabQIevsXmZXJIj9dPgLkUEb77L
         RoiZThpIQhXUsraF/sTcuf8dYhdKNMPlwWsGFpitQROlN2iNi0b2SzleGQLG5kwi5Tmm
         KFXs+ZzfkMSJNb3JTrFIwg1SZ7ROPCdf+rRXHofZwJGnIksCzqOPeQdtPIZar7SIY5kx
         uSIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714152183; x=1714756983;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qi1a6qRL/sSf88RkAxOBKeEEBw29sLy7LzarlapS72s=;
        b=BzY6AlJxcOTVdGbQOybR+s8D1eVdlGb5atNDTKsNbCnlo6d6FHy0g63MM78DdYx13u
         I2Gy/liqNdvfIpVRCDouPjRtBnUuWYk6dDrQcwOPTJVwMiFITUVe4+BwLFMuXq63Nll3
         vafuxKkVWOOKqlJg9lw+fGSb4kvoCsE/sqvoQm95MSznsMDhMWimsOJiSxqDOTYuawLu
         tOBdTMT8Qi63YekJJryKjF7g9QedmhFNQ5sTDuFLpwBX7uHi9xFD9duCHbqGFfpUW4su
         eW+PdWZ3KOFpBljdu9/YzVEpgw1qOX9UaSrwTufTUnvOaSR2TUSVpsCkTe6QQD6cqp02
         Swbg==
X-Forwarded-Encrypted: i=1; AJvYcCU9e0UUPZHuK2Fm66ZGmpx2eKGEM+vTs6YcyfeKtl7T3pcAigdQPA+yStPoMxtD5XeIg+PeDOF+T8Oy+qPIhV8Fxifmb7jTjd1ZPs6w
X-Gm-Message-State: AOJu0YzNoI+TKceCm2KXEyVXVNaeotwLxhzeYP4IYJyO2KpS1KWLnmq8
	aGkeQRfVmPTPFaqpMwQTC9QHyajvL6WWutyoYNQUNZIwVpD8MLYIEUf+YHCl9j8=
X-Google-Smtp-Source: AGHT+IHHf2XIxcORUWzjtLX1VaD207j1YSFJervSBcjnJPk8N+OEALIdFKf7g6Y8lzNaper92rOirg==
X-Received: by 2002:a17:906:4a83:b0:a55:5e89:a158 with SMTP id x3-20020a1709064a8300b00a555e89a158mr109798eju.68.1714152183470;
        Fri, 26 Apr 2024 10:23:03 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id ot15-20020a170906cccf00b00a5239720044sm10763363ejb.8.2024.04.26.10.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 10:23:03 -0700 (PDT)
From: Alexandre Mergnat <amergnat@baylibre.com>
Date: Fri, 26 Apr 2024 19:22:44 +0200
Subject: [PATCH v4 15/16] arm64: dts: mediatek: add afe support for mt8365
 SoC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240226-audio-i350-v4-15-082b22186d4c@baylibre.com>
References: <20240226-audio-i350-v4-0-082b22186d4c@baylibre.com>
In-Reply-To: <20240226-audio-i350-v4-0-082b22186d4c@baylibre.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lee Jones <lee@kernel.org>, Flora Fu <flora.fu@mediatek.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2357; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=t0tf5ggyvEv3KEhg9dzpup8fwcOHLyJsYbfkqMonRjM=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBmK+LaFSju2HTEJJUlWwHPPq7cLwG3TIXZFwziZS9e
 4Ndyr3yJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZivi2gAKCRArRkmdfjHURepjD/
 97NUzCvItOp1IP3I06MoHhHvjQUV16QIZ462zo18PKYz6IOSU0Q53W0KrB4Awgr5T3o5wwwQi1w6cZ
 OUV0dR6H58erDJR16xRZk+YWtdSs67XXC72rmHb41qYDwoyHXemShR8E279guAnE7Tbx4ZPo8ACYMc
 3JmtdNg+M+d9Cxjokjl9k3zJ//9MnyNIVzrxwJO12N+Yo6mKuUfDjBVoEPhEi/yeOXcgea8dNL7KHQ
 ZDZhqi7u/iK5mawCxqIVbf72ly2fB7Dt1heFWlYc3qP7IJuTjU6D0vrr1LLOc5SuUV8Rqga7gVXAIo
 mYO9qXOd5JFk2I7y+F2LvL6xYqTgKCjWAc30pH1eBO0Nqab7RjEUh4EJBdnIoa1rbSrt5uF/5S+uC+
 Cwn3Bb1jofzgvU3ty+c7gNN5GTf+j+CQF99el4eZk2IUs9wP+ackEu25Ox/4I+CijWimgylznvh+yz
 A01xh3kn9MI03Y9HebFSM2lHe7iVkz+pfZo/jxAMNifMZsc2OuFTM0//JCutoMpbtfYUSfK59b8e8x
 FvWKt2Q+1DWnz/jz9jVBLrbzrJVhwgF7u4t9TKhZtzqhcDohsrXMw+mkEAMTrSAB4RHtZu8CsH0MR9
 KN+57ulLLxu4t92OP7ZWl3tq8A2QrY96atz2Olvugu76QClJPWJ2XX28O/pA==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

Add audio front end support of MT8365 SoC.
Update the file header.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365.dtsi | 43 ++++++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
index 24581f7410aa..0051d5613bcb 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
@@ -2,9 +2,11 @@
 /*
  * (C) 2018 MediaTek Inc.
  * Copyright (C) 2022 BayLibre SAS
- * Fabien Parent <fparent@baylibre.com>
- * Bernhard Rosenkränzer <bero@baylibre.com>
+ * Authors: Fabien Parent <fparent@baylibre.com>
+ *	    Bernhard Rosenkränzer <bero@baylibre.com>
+ *	    Alexandre Mergnat <amergnat@baylibre.com>
  */
+
 #include <dt-bindings/clock/mediatek,mt8365-clk.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
@@ -813,6 +815,43 @@ apu: syscon@19020000 {
 			reg = <0 0x19020000 0 0x1000>;
 			#clock-cells = <1>;
 		};
+
+		afe: audio-controller@11220000 {
+			compatible = "mediatek,mt8365-afe-pcm";
+			reg = <0 0x11220000 0 0x1000>;
+			#sound-dai-cells = <0>;
+			clocks = <&clk26m>,
+				 <&topckgen CLK_TOP_AUDIO_SEL>,
+				 <&topckgen CLK_TOP_AUD_I2S0_M>,
+				 <&topckgen CLK_TOP_AUD_I2S1_M>,
+				 <&topckgen CLK_TOP_AUD_I2S2_M>,
+				 <&topckgen CLK_TOP_AUD_I2S3_M>,
+				 <&topckgen CLK_TOP_AUD_ENGEN1_SEL>,
+				 <&topckgen CLK_TOP_AUD_ENGEN2_SEL>,
+				 <&topckgen CLK_TOP_AUD_1_SEL>,
+				 <&topckgen CLK_TOP_AUD_2_SEL>,
+				 <&topckgen CLK_TOP_APLL_I2S0_SEL>,
+				 <&topckgen CLK_TOP_APLL_I2S1_SEL>,
+				 <&topckgen CLK_TOP_APLL_I2S2_SEL>,
+				 <&topckgen CLK_TOP_APLL_I2S3_SEL>;
+			clock-names = "top_clk26m_clk",
+				      "top_audio_sel",
+				      "audio_i2s0_m",
+				      "audio_i2s1_m",
+				      "audio_i2s2_m",
+				      "audio_i2s3_m",
+				      "engen1",
+				      "engen2",
+				      "aud1",
+				      "aud2",
+				      "i2s0_m_sel",
+				      "i2s1_m_sel",
+				      "i2s2_m_sel",
+				      "i2s3_m_sel";
+			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_LOW>;
+			power-domains = <&spm MT8365_POWER_DOMAIN_AUDIO>;
+			status = "disabled";
+		};
 	};
 
 	timer {

-- 
2.25.1


