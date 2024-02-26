Return-Path: <linux-kernel+bounces-81557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6007A867786
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA9011F23669
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5560312AADB;
	Mon, 26 Feb 2024 14:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BFBtPD+6"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDF4129A65
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 14:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708956132; cv=none; b=C+7iCYnZjapFKYmfbPjhLuP9i6srVlnQOeyunmtLR6PVDNPFgBUhhHUEQDetu/1oBtIgMJBjqdnuQdy24hals2y+jFAz+ewTO2IwsFMX8jUoJLqaO+rqUWG6jikXM4Xorc6FvfGK1WMfJoNAse5LmKqbcglHss/3psWjuFAIfXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708956132; c=relaxed/simple;
	bh=0kCH2S+hyKAqspnQK264eeLgQIfJopJ1XswPK6oxmVg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ShQSqP5QSDSzXNl4mGJnxn4ZcCQNfL3QgdYvgMbbyiQz4kdKv5hs4BHBkH+1TDAntTqB2EUSHz8Ndg2WX7OrlCmuiDIif94aLRXAaamwOC0T2mPFXS7lc5nWYm1RnIukXEY0O7xD4wTwkYXxeisQXbyumoqYxQjoEU7dAjvOpCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BFBtPD+6; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-412a9457b2eso1809825e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 06:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1708956128; x=1709560928; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ytleufDfW156KK594Ruui+vLo5tX3ovRIKKvPCU4Yc8=;
        b=BFBtPD+6fSkeGOAAjoK6NBxkE5NUn7BvcnXHy9DqpDyeVBSofizv6vupfpWK8yXcO9
         cKikZvW2biqwxDbkp98ZEznYTyO0tqzSGvbJOLY+neWvi17Aq6twCofKHASQ9GLWbzvi
         uuUv1xiwztoXwSfLDFMR886GFD7TrHUG9a2SmdKK39NHqXTPdXyuFF04DPzQnQRQA5Vb
         AKhiD7LQIkolWCjsq9I3nLDpjLyQY5xXlmZfdmgvrQEE/9IK55uMidEUjPn35ibqCbAQ
         ghNlfSscmpXZ2+vPy8Wkv4nx0S1f45EQ0Sc+N7h645DFFgaIstNsWg9QK0BCXyg3M1i9
         mE5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708956128; x=1709560928;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ytleufDfW156KK594Ruui+vLo5tX3ovRIKKvPCU4Yc8=;
        b=tm/9WU4boxHQVI++Ee+GEM1fGXA/3VvS6FJ/Kn/MC4Ru44oX39ZDM9jpHMPWnnfKcJ
         vJjQ7wrQdyV+Iv/r1GJXHFuFBl744k41Scud9mJrBgQhn3pHWfBPWR+o8g00Xt6AENQ5
         1Tschx2yJyOgja1usjQXmdbUnGsxqB3hvyvm2q14IgimNgyjFbh2r/9yYnTP0YI25vgP
         epS1ytziVLHs68DjXP8U7Qt3F4GabGv1zPRS6yi35imj+ToOkiGTyHI7nAj7WW1Oud/L
         FvgH1v9esmEUd4jpQjtGOSp4+CYYNiDujbZgV4MUcXDOwn4UNkOSA1dkgDZ3YqJzbMQ6
         dlZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUI5xyK4jpBP5HNmATm+XdTi+dESTaMoXTIJyAYwZPTGSqUkquTYEGayaruoU3IDPz3LxG+fN7pg6TtxvpUHdo0PMujM3CyjYDN4iiw
X-Gm-Message-State: AOJu0YxSGM4kpk0GKzWeIAVeVylO6rPymdzbfPIJbxiSY3toASgiagpW
	c91Ml+ldPwoWqyVtrF30790pR6epeAmiiJfYp2cjFAR3YTuOf0eXRCq/saUM3vM=
X-Google-Smtp-Source: AGHT+IFKQGufEHWXBUu9F0HZgi/6g4V1k8Axa81ufjmly7iPNiTWJ446aEOcRP2RTw2v1K+EZMJ4Lg==
X-Received: by 2002:a05:600c:4f46:b0:412:9434:fa38 with SMTP id m6-20020a05600c4f4600b004129434fa38mr5678803wmq.7.1708956127984;
        Mon, 26 Feb 2024 06:02:07 -0800 (PST)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id d33-20020a05600c4c2100b004129f87a2c6sm2838475wmp.1.2024.02.26.06.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 06:02:07 -0800 (PST)
From: Alexandre Mergnat <amergnat@baylibre.com>
Date: Mon, 26 Feb 2024 15:01:39 +0100
Subject: [PATCH 01/18] ASoC: dt-bindings: mediatek,mt8365-afe: Add audio
 afe document
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-audio-i350-v1-1-4fa1cea1667f@baylibre.com>
References: <20240226-audio-i350-v1-0-4fa1cea1667f@baylibre.com>
In-Reply-To: <20240226-audio-i350-v1-0-4fa1cea1667f@baylibre.com>
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
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5536; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=0kCH2S+hyKAqspnQK264eeLgQIfJopJ1XswPK6oxmVg=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBl3JncMTn7Pva3qSLlaPLg/cPnluAh0ub2unqFS4aw
 o/sUWTKJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZdyZ3AAKCRArRkmdfjHURSduEA
 CPJ+/cDO21Vbv6JavXGbRfwQV42UFIsvpm9Tzg2PmE+GXSHwFoKdkB1mOZZFCDgbG2dW3Xs2HZhJiR
 +iI8NDm41ZA+2C0KIcd7qH6JsZ7N/fuBCRpf8tXC3TfjEbJ15U8mM4PRosdsFFtaKBHG2qWantz4bW
 ZFnck6avImi7OjOmwaaAnmsyPuLk9W2w1y320VyqsMzidfwFvedimCwQj03Tif9DfJXwuoXd8gqg4h
 Nk1RyfaW6Ha8n7NJW6T8GowjEqfTtJr2UxhBxQYE4z9lk2s8/wB3Wp4ZwA+UQv2V/B4WLYq6BlKeh5
 I71FsGrbbU3I37US9rMAqv6ADDBfHeHcfRA32w0RyeUFR4l/TaWyMDJtbCRTCz4lYS6ni3EDwN72jq
 G4wubcsZi4uJiFK/3syTEeZKj11NrJyb6EGo6j9jhSU9eor4bTbq+jS4LyITxulj3/pIS8xSclGoN+
 ALOfjFYcEVuBNpMyfWQOfQaKCchoceUQUym53JxkCHrmfhcpyIjXG+GcY5BWFq9j1wTuH0s30EzSli
 DZS89EOLdXA42pQ9DZkFE3/DSlHiMaF+Lg/Jl48BnPgVIXRRHrCYvWaUqlax6BpcEAy5CpScngO1ut
 3kmJ6PyADi5zVLfxqJWYEI8F9O8YvyzaTjvPbjClBHZ5mK2eW53ia46Wzgfw==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

Add MT8365 audio front-end bindings

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 .../bindings/sound/mediatek,mt8365-afe.yaml        | 164 +++++++++++++++++++++
 1 file changed, 164 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/mediatek,mt8365-afe.yaml b/Documentation/devicetree/bindings/sound/mediatek,mt8365-afe.yaml
new file mode 100644
index 000000000000..1d7eb2532ad2
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/mediatek,mt8365-afe.yaml
@@ -0,0 +1,164 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/mediatek,mt8365-afe.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek AFE PCM controller for MT8365
+
+maintainers:
+  - Alexandre Mergnat <amergnat@baylibre.com>
+
+properties:
+  compatible:
+    const: mediatek,mt8365-afe-pcm
+
+  reg:
+    maxItems: 2
+
+  interrupts:
+    maxItems: 1
+
+  mediatek,topckgen:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: The phandle of the mediatek topckgen controller
+
+  power-domains:
+    maxItems: 1
+
+  "#sound-dai-cells":
+    const: 0
+
+  clocks:
+    items:
+      - description: 26M clock
+      - description: mux for audio clock
+      - description: audio i2s0 mck
+      - description: audio i2s1 mck
+      - description: audio i2s2 mck
+      - description: audio i2s3 mck
+      - description: engen 1 clock
+      - description: engen 2 clock
+      - description: audio 1 clock
+      - description: audio 2 clock
+      - description: mux for i2s0
+      - description: mux for i2s1
+      - description: mux for i2s2
+      - description: mux for i2s3
+
+  clock-names:
+    items:
+      - const: top_clk26m_clk
+      - const: top_audio_sel
+      - const: audio_i2s0_m
+      - const: audio_i2s1_m
+      - const: audio_i2s2_m
+      - const: audio_i2s3_m
+      - const: engen1
+      - const: engen2
+      - const: aud1
+      - const: aud2
+      - const: i2s0_m_sel
+      - const: i2s1_m_sel
+      - const: i2s2_m_sel
+      - const: i2s3_m_sel
+
+  mediatek,i2s-shared-clock:
+    description:
+      i2s modules can share the same external clock pin.
+      If this property is not present the clock mode is separrate.
+    type: boolean
+
+  mediatek,dmic-iir-on:
+    description:
+      Boolean which specifies whether the DMIC IIR is enabled.
+      If this property is not present the IIR is disabled.
+    type: boolean
+
+  mediatek,dmic-irr-mode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Selects stop band of IIR DC-removal filter.
+      0 = Software programmable custom coeff loaded by the driver.
+      1 = 5Hz if 48KHz mode.
+      2 = 10Hz if 48KHz mode.
+      3 = 25Hz if 48KHz mode.
+      4 = 50Hz if 48KHz mode.
+      5 = 65Hz if 48KHz mode.
+    enum:
+      - 0
+      - 1
+      - 2
+      - 3
+      - 4
+      - 5
+
+  mediatek,dmic-two-wire-mode:
+    description:
+      Boolean which turns on digital microphone for two wire mode.
+      If this property is not present the two wire mode is disabled.
+    type: boolean
+
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - power-domains
+  - mediatek,topckgen
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mediatek,mt8365-clk.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/power/mediatek,mt8365-power.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        afe@11220000 {
+            compatible = "mediatek,mt8365-afe-pcm";
+            reg = <0 0x11220000 0 0x1000>,
+                  <0 0x11221000 0 0xA000>;
+            interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_LOW>;
+            power-domains = <&spm MT8365_POWER_DOMAIN_AUDIO>;
+            mediatek,topckgen = <&topckgen>;
+            #sound-dai-cells = <0>;
+            clocks = <&clk26m>,
+                     <&topckgen CLK_TOP_AUDIO_SEL>,
+                     <&topckgen CLK_TOP_AUD_I2S0_M>,
+                     <&topckgen CLK_TOP_AUD_I2S1_M>,
+                     <&topckgen CLK_TOP_AUD_I2S2_M>,
+                     <&topckgen CLK_TOP_AUD_I2S3_M>,
+                     <&topckgen CLK_TOP_AUD_ENGEN1_SEL>,
+                     <&topckgen CLK_TOP_AUD_ENGEN2_SEL>,
+                     <&topckgen CLK_TOP_AUD_1_SEL>,
+                     <&topckgen CLK_TOP_AUD_2_SEL>,
+                     <&topckgen CLK_TOP_APLL_I2S0_SEL>,
+                     <&topckgen CLK_TOP_APLL_I2S1_SEL>,
+                     <&topckgen CLK_TOP_APLL_I2S2_SEL>,
+                     <&topckgen CLK_TOP_APLL_I2S3_SEL>;
+            clock-names = "top_clk26m_clk",
+                          "top_audio_sel",
+                          "audio_i2s0_m",
+                          "audio_i2s1_m",
+                          "audio_i2s2_m",
+                          "audio_i2s3_m",
+                          "engen1",
+                          "engen2",
+                          "aud1",
+                          "aud2",
+                          "i2s0_m_sel",
+                          "i2s1_m_sel",
+                          "i2s2_m_sel",
+                          "i2s3_m_sel";
+        };
+    };
+
+...

-- 
2.25.1


