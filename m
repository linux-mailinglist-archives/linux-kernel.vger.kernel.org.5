Return-Path: <linux-kernel+bounces-160465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2FD8B3DE3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61FD6289E1A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C206716DEA5;
	Fri, 26 Apr 2024 17:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="E8WmN+kh"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD41016DEA6
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 17:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714152163; cv=none; b=bQSowScRftNYu4psRmhFU0O8tkqSmtymig1hJUpJqYAVs2yuEr4wk0Gtd2ppbC3Y11uXd5OZHcUWvFLs5DIlxJ//zhhDMXbvhil/nRSQp2KBoUQnRDnVBSEJQiMH2g/gt6ygQ/RTrwrSvqW4BQIVVHzlRg9xE3ndxreaJNrCWY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714152163; c=relaxed/simple;
	bh=RfcGWh4J4Ru+vCmoaCssck50D44laU1fHfw1FIxcYyA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dlAp6eMI3wyLEMH/GKrEk5uR6/YKzKUOs+cMxz3ETFd/L/1i+R1B7iV8Zcp8XfnHvn59FET+SNc2NHnMHr7n60d1NOxHtCySlmnU4XeMJO2kj3nRy1r424VY7IdnMIqnW3kdrYURFgcQsbjUyhihcjRdCj6WbChZiFsyfGIxlDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=E8WmN+kh; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a58c09e2187so218576066b.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 10:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1714152160; x=1714756960; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4TU43dOQH6UMfjQS6G859NG2HaMeSGxyH5T3QTnjRnY=;
        b=E8WmN+kh3Bj6tIRwJwM7OrEBlMuDdceV8F30yM1I8FqOmmczAEtSe1tqGR7HI8iQ+w
         YzoM3eBLPRt0xh82qFwCBn/M+FAYc8eYwWL4H9Dl8bZRT0Alr6z1k8CmQo720WdH+vPg
         a+LBiEtqd8FFj0E6SMcpSV8v2nbCnKsJCxRxU/yZ/t04oS+GgzXkoQqTHkH4SXDsGe/1
         0aaesHhQ6CYTcPuPijSM06OM1f279/TBPeMrl+ZtdYoB+m2qGNcMRIPOwoBNJnmP83hx
         JE1n8S2PgONmtOh7YmzO/a8M/ChCJHGfCw+SjqAPEP/Ad8GHTtWhfEhSoNV6vQQJbtmn
         Bh4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714152160; x=1714756960;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4TU43dOQH6UMfjQS6G859NG2HaMeSGxyH5T3QTnjRnY=;
        b=aaFwuyMUGRnwUfMTUukth3zN8hw9MszmHvmaxCCiYXrfVU34gYfgzD5FCZYeyHUGIq
         pfIQMWKnQSj7icu7ABnTF7XMVOqngROKwKkQUXEWd5VBOb+3li9LDQVjW3ZDavGqTOHK
         Y5rf15k/uc8y5731wf060uoR/BP1kF0sTqdVgftY+Odck9pTxcSxObY1OIWXgqXBLODv
         Nql3fJxKZY16aalvHT+A+f0pOSN1aVTBDYA8L8St5AZ7IGgXPSdt42HREX4T862pVQHR
         nCHXX8o95vPMaopOgjX5yqlZ+UtRCHORZ/LTn93Xb5AkWGcy9NpiqHDAm6jGwR2vuMLK
         8HyA==
X-Forwarded-Encrypted: i=1; AJvYcCW9JWCQh9dMKri9xpA578JI9+IllY+E3KbhpiTY3RaKWECzXvr6Xn0FrW/nMt0SMSbIbqnIKxXX7QUFsuHuGtkJ9j18KCJOjkHpmIt8
X-Gm-Message-State: AOJu0YwuF+JF8Tg4u4WQ76kL6ldWZJkRaFsGV3PpEEwiBKv9mpYm9nVZ
	eXQeI8nN3AdUIV+IX/jaqiLd+U5O4MQeWBWMl6iIwlq+ZrVIrjhIpqoDgaKZf0A=
X-Google-Smtp-Source: AGHT+IHcBmX2GHh34oFPQvGPIaePMc8392KtBItCgcwB4NvhhucWlDZ3EAw/bb4ovkR1+MLNq0adww==
X-Received: by 2002:a17:906:c288:b0:a58:7283:f587 with SMTP id r8-20020a170906c28800b00a587283f587mr2140675ejz.33.1714152159933;
        Fri, 26 Apr 2024 10:22:39 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id ot15-20020a170906cccf00b00a5239720044sm10763363ejb.8.2024.04.26.10.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 10:22:39 -0700 (PDT)
From: Alexandre Mergnat <amergnat@baylibre.com>
Date: Fri, 26 Apr 2024 19:22:31 +0200
Subject: [PATCH v4 02/16] ASoC: dt-bindings: mediatek,mt8365-mt6357: Add
 audio sound card document
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-audio-i350-v4-2-082b22186d4c@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3263; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=RfcGWh4J4Ru+vCmoaCssck50D44laU1fHfw1FIxcYyA=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBmK+LaS/TeL9lgDhsOUZkB6fGKdDfM1W9MWsbPfEMi
 JmdJbfKJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZivi2gAKCRArRkmdfjHURUymEA
 CNNp4DesNUeM0GUuDt/1G0pbD4jz4uHrL7JeY0bqC+GS59MxGwPSYDsmHoHACfSv4Auy7Mr6AI/lCZ
 eeXcrfAg3jGsLq5nDOLFW2YyqcKs2qvOvG9RpMGF1E/wmT67od51GEjhsbpTb36vjAi0fxcm3BKCm+
 DpW18Cq1LhI9Y9ZU66I3WaBcrXlVHRnkEIZeB5yop2GKPBii9g335yPsuoh22bIBH0raZGWiSiqAwd
 hKwCfsgHJtLO5wzTELCojIwEEn4N06TOk5GNSaihM875N7w1zaVYNte+wgcnALZJdRDXkbHL9aeQ19
 zJ8793FsDW8jCjldeIdQO2LKbFejGNT7FUSJU3pKTZUh0M9pQjxi/9mk3OeBTVdCy1+fiauYHLWcwl
 xDZzjUtyxaykzBuf3jD1/VWlOGLa2gj6Ks5F7CzvMRM58kzZIgqlxPEG0+3hlaHXLSguDTThAfAxdb
 /JzwzQRxVhd4RyTRjGlFjWaati4BOFMtSpzeTn4wWF8y0xig/3+US5yuIVRD3c73+AxRGQ1dWmsXH1
 nRIIcapVKL3KCjh+OlxcOV5kON4yPMVq0Dm2sPXnyhlWYq8I5oBQ8pM9zMSDrRXbSpiw0XvKYR73M3
 FnWVbmFMca+bUJ5NXumQ/E9Edev7275CsD60sYOS7BYPnfZ/wvs1w8kOqAzg==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

Add soundcard bindings for the MT8365 SoC with the MT6357 audio codec.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 .../bindings/sound/mediatek,mt8365-mt6357.yaml     | 107 +++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/mediatek,mt8365-mt6357.yaml b/Documentation/devicetree/bindings/sound/mediatek,mt8365-mt6357.yaml
new file mode 100644
index 000000000000..f68883da1bb8
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/mediatek,mt8365-mt6357.yaml
@@ -0,0 +1,107 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/mediatek,mt8365-mt6357.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mediatek MT8365 ASoC sound card
+
+maintainers:
+  - Alexandre Mergnat <amergnat@baylibre.com>
+
+properties:
+  compatible:
+    const: mediatek,mt8365-mt6357
+
+  pinctrl-names:
+    minItems: 1
+    items:
+      - const: default
+      - const: dmic
+      - const: miso_off
+      - const: miso_on
+      - const: mosi_off
+      - const: mosi_on
+
+  mediatek,platform:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: The phandle of MT8365 ASoC platform.
+
+patternProperties:
+  "^dai-link-[0-9]+$":
+    type: object
+    description:
+      Container for dai-link level properties and CODEC sub-nodes.
+
+    properties:
+      codec:
+        type: object
+        description: Holds subnode which indicates codec dai.
+
+        properties:
+          sound-dai:
+            maxItems: 1
+            description: phandle of the codec DAI
+
+        additionalProperties: false
+
+      link-name:
+        description: Indicates dai-link name and PCM stream name
+        enum:
+          - I2S_IN_BE
+          - I2S_OUT_BE
+          - PCM1_BE
+          - PDM1_BE
+          - PDM2_BE
+          - PDM3_BE
+          - PDM4_BE
+          - SPDIF_IN_BE
+          - SPDIF_OUT_BE
+          - TDM_IN_BE
+          - TDM_OUT_BE
+
+      sound-dai:
+        maxItems: 1
+        description: phandle of the CPU DAI
+
+    required:
+      - link-name
+      - sound-dai
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - pinctrl-names
+  - mediatek,platform
+
+additionalProperties: false
+
+examples:
+  - |
+    sound {
+        compatible = "mediatek,mt8365-mt6357";
+        pinctrl-names = "default",
+                        "dmic",
+                        "miso_off",
+                        "miso_on",
+                        "mosi_off",
+                        "mosi_on";
+        pinctrl-0 = <&aud_default_pins>;
+        pinctrl-1 = <&aud_dmic_pins>;
+        pinctrl-2 = <&aud_miso_off_pins>;
+        pinctrl-3 = <&aud_miso_on_pins>;
+        pinctrl-4 = <&aud_mosi_off_pins>;
+        pinctrl-5 = <&aud_mosi_on_pins>;
+        mediatek,platform = <&afe>;
+
+        /* hdmi interface */
+        dai-link-0 {
+            link-name = "I2S_OUT_BE";
+            sound-dai = <&afe>;
+
+            codec {
+                sound-dai = <&it66121hdmitx>;
+            };
+        };
+    };

-- 
2.25.1


