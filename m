Return-Path: <linux-kernel+bounces-136638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E8489D67E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F9C41F2204A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2DE85656;
	Tue,  9 Apr 2024 10:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RXV8pm2x"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A085823A8
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 10:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712657627; cv=none; b=Ns8dPHdZthooqe4KqW+mGj983jU3BGfIsUDzALiS76KBSTogj/c6/m3GKGpiqO63XZ+TZF81QCnvJrCv/9ITT6plWTGAgCPGMv096287RVHSZ3pa789pJuQiqgTZEBKIiCCO6pjvn3G8TE/xAg+8MMx0Y0noamUddNi9gPRtDAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712657627; c=relaxed/simple;
	bh=bcex9J3pUiKsSDmYMrLdaDcykBaj5YDYBra4ZvFBZJo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DVJjbNTWycQVtjgX+2xP/BVvWe1n3lnhI5jicr9oPWTAiVQIUjOm1u21Vz1MXg+TRHTwSafofyJYXTQXuy4wrPv2FyOhfAsfNX9bPhlnobdEQJ8ycpYFIbT6vw0x0JcbWbPg23/UydW0qt+snqdRYNuapIyOXhx0qxp8bSKBtdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RXV8pm2x; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4169d7943c1so5965575e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 03:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712657623; x=1713262423; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LGt34+sJLdk3MLx6big+T+CAqaWtPyYycofqseF0Aok=;
        b=RXV8pm2xAjzDDbh9nK4Ffult29Eq2mWZ31U+LOfUyDdfrqIoMQyy6pTxV79GFdiG/P
         /CQq9NjA5bbXPIFFu5bnyC1WtgbGsffSQnOtro51ZkmqshgXmTF8v/dpezR2Y0ShAjS4
         ZbMHffWovQzrQY38V4qxY4RdsPoQxs+SlnoZAH4b+NEZQBm14D4NehH7R3wJ3zr4KyKU
         9+PUjV4VZh9kI6yl0ikPMgM+nz9b10XKetW5J5Rvg0E63WLHeh+/9r+7p0ofFY7WXSV6
         RSOU36szfvYAn5sNOFMfMwWz2s6xSWOWVp39xveh8nHpYpVF/qD/IeqatfD24gbXV64R
         E3fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712657623; x=1713262423;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LGt34+sJLdk3MLx6big+T+CAqaWtPyYycofqseF0Aok=;
        b=ijrK6A9xsAd4jB5iznTZrHlAZ+nDB/C+8WfGo3E7rqNoSJ/GH1f/r/OCtDu7zAIEn5
         bDQ3A/9Wh/t+PXv2dB+XVuHqwsBIjNI/fzP+wj8TIYWn+xF2JPArSmG3zCFsmusQkDeL
         F0ex9L5Iwn8agGnTN/JDOmfgwS/8CF1VTBeLnmh/aAwi+y3jJ/Zy933UvhNXvIqFiAlR
         QDRZI3vEsG1EWrpQzKkoob7LW3PilZvYmHPdkIBUkBCuYMMXGI2JGZywEGtbITgbAo5g
         pNOibYlMFiV3q8IoHpLxveVZZXYpmoMLqsyedIRejmShW2PCEPef1pyHYfxRmCq+IB9P
         eyyw==
X-Forwarded-Encrypted: i=1; AJvYcCWWD9qAaKKarv2+0Mi15ixjcEftuw6LPiKaTLjuVMo7cVcgSDjbgDbzNAaACnzgmKUnVza4gdziIVvxDonhVffXEXkZdBSrhphNVlem
X-Gm-Message-State: AOJu0Yw3MWdN4P6xHXxeuI7ck1EhoylSdtGcJOxk3iwwZZeFC7uZjnDq
	O4lG71lgftjyXu4eD3wOGykTZKjba4jLA4OVj+uJJTnVm7+61AF3fZRaimWPz94pqhzpaXyRjWA
	E8Mk=
X-Google-Smtp-Source: AGHT+IGzfaK4n2/g8axda9rEW09xuGb8tQgLRNvycpCGtQ33o2AX8GkVbCTGFTgBOJIHcyo7EAPzsg==
X-Received: by 2002:a05:600c:3592:b0:416:8152:8a70 with SMTP id p18-20020a05600c359200b0041681528a70mr2710612wmq.33.1712657623706;
        Tue, 09 Apr 2024 03:13:43 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id r7-20020a05600c458700b00416b035c2d8sm1124149wmo.3.2024.04.09.03.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 03:13:43 -0700 (PDT)
From: Alexandre Mergnat <amergnat@baylibre.com>
Date: Tue, 09 Apr 2024 12:13:23 +0200
Subject: [PATCH v2 02/18] ASoC: dt-bindings: mediatek,mt8365-mt6357: Add
 audio sound card document
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-audio-i350-v2-2-3043d483de0d@baylibre.com>
References: <20240226-audio-i350-v2-0-3043d483de0d@baylibre.com>
In-Reply-To: <20240226-audio-i350-v2-0-3043d483de0d@baylibre.com>
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
 Rob Herring <robh@kernel.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3125; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=bcex9J3pUiKsSDmYMrLdaDcykBaj5YDYBra4ZvFBZJo=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBmFRTTZEodaz6gWD8MRUgu0ITSSraVYxIjQYi8MKb6
 nkjJEj+JAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZhUU0wAKCRArRkmdfjHURXk0D/
 4/ZJ3u2KfDNF648wt0JHA6iCjSPOuj6vLD588gTo+Re1qpqu68/joP8w3rhRELxW6/iHZ4xt/QFj8C
 oO+X6o8CASS6dbwjDvRmkR4BJ2/Ku0pnYzNrm2kshLM4OEV/b7fix7ed8oFLJUjubS6BiwPy3GJs60
 vu6anJhjf4YaUnISMBRimlkMamBn2UsSVJtwEuvVHaiovp553a9iKTHBIDeBXNkHDffAJzI1aL4tRn
 iUDVy96b4ShE8+MENftXo3FISeURWuizKpXkQ1bmd9yv3v+51HHQWpxHFchIeONrJrZ7k9Zep2WTG4
 UkS2JXJ55Ywr5w8Iltjkqq31cuicllUklzPCrDNBdlsoPdW3vykmolaDVPYK6sYc9/4eGkPGrPh3BU
 vaWjrfhqvUgiDDYI77J9ugPtdzZXrF38VpIAW9GgDqYEFh4P9gwVnoAq17S5JCEUaNGPRgdAPi32hw
 tqpTZfZ4GsC1trFbNq8ObvZg0RD0l2LrM2w25Xf+Vs+46aDVTOS7cL2fE9O1YQo4Sgrb3KxV+OBtCE
 HOZNSh3te3PjB3b2DSruFSi503sxBNQse4BHacJIli3TwHCCtcAcd0gz5kFogwXoOyqd2H1WffjR4S
 j0+fk+qLCPqeqeFydlpoWD+tYzmV2IaYX3dmPQ4E85uI8m9PSKEiJ/+9oENQ==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

Add soundcard bindings for the MT8365 SoC with the MT6357 audio codec.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 .../bindings/sound/mediatek,mt8365-mt6357.yaml     | 99 ++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/mediatek,mt8365-mt6357.yaml b/Documentation/devicetree/bindings/sound/mediatek,mt8365-mt6357.yaml
new file mode 100644
index 000000000000..831c5b4665b8
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/mediatek,mt8365-mt6357.yaml
@@ -0,0 +1,99 @@
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
+        description:
+          This property corresponds to the name of the BE dai-link to which
+          we are going to update parameters in this node.
+        items:
+          const: 2ND_I2S_BE
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
+            link-name = "2ND_I2S_BE";
+            sound-dai = <&afe>;
+
+            codec {
+                sound-dai = <&it66121hdmitx>;
+            };
+        };
+    };

-- 
2.25.1


