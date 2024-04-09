Return-Path: <linux-kernel+bounces-137001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DD489DAF3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24AF51C209FA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C931311B5;
	Tue,  9 Apr 2024 13:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="olf9AP63"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB78130A73
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 13:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712670133; cv=none; b=fiXX5zFckNRQK/P9UtAyBg68dba9cZZKoxoddAA5YkjrlaFwEBb05V436hnIBFpvrMqFE3OH0pntcVgMZYX8ezXqaufl98ilV/SyswbzO4WcO8a5aMXnn4/5hg18J5H3D5++JDsB+BKmumoXIY7RMELuTqTQO5tTLC3UL373S98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712670133; c=relaxed/simple;
	bh=bcex9J3pUiKsSDmYMrLdaDcykBaj5YDYBra4ZvFBZJo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GmbxTkBUZ0lMeCZ7aI13y5p/OXVMs5+CulVCdIZSZvG2pg1CezydPZI2xv4wVSyyMTaNTX4rrllV1X1u8OBvJ1XYC4FXrZMLuyDULwIv5ox5Yys+l1uFtdbXzUF43mgJpn7KaC5nJSP88/nxtm9nYPqLm1xxMIaqWgYlWnAue9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=olf9AP63; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-343f62a762fso1313813f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 06:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712670129; x=1713274929; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LGt34+sJLdk3MLx6big+T+CAqaWtPyYycofqseF0Aok=;
        b=olf9AP639qHUEAN3GPdWUWAvjnhKzolMaH1k6G88Hs4bh/PcyyFISmX7BUgHWsFqgq
         iJFHHlF+Z0VhZOE+GKkjvK+1brtcfmsQ+BG0eBaJ2ipLbtLstTKLRc+tUGbgkRhfxvGt
         5kqaG70wTjrmKROBkDmD5zond7oQHcfqSv43Ix6kHopQqLEM+8nGamPTReBvLxSjJwbY
         Co1NL5sGJd87JLNUx2k7yTrlOkxP53JX/8MNLUc3fGL3bIdIWoKVli/pVhX4UJ7el/O9
         4nalFrFVbh+c3Vg0zCZvMLJoP3wn6BQ36hjCCajW8mdR0//soNYHYvHbUKJwxV1qUlLZ
         ywag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712670129; x=1713274929;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LGt34+sJLdk3MLx6big+T+CAqaWtPyYycofqseF0Aok=;
        b=RoJ1IHQD8M8LCasrv09J2nsxsBDFlRKHMeztTVb5L5qlZKlN+9dON+x46arWNIMYdr
         L5NNxT7T7hx0rODlKz8au/DFMkig+mDOhrng26A4nWBGNrMo+sQinZLF8VamuFZz1AFt
         q0qWSVpbaX9t0pdZnMuDm+yn9mCV18IPUyKHHFHxK65X4JVpM7u2EbaEMLmLLUcervv6
         7NEI+M/f/oiF2AkreclfQxa03Q6Blz6lPuJWIrVuj8ZHD56VToBYLE6ta2f+EWblLUT0
         ho5g7lB+ZeJtBD5Ggn3YMkF9YR9wZ4RIuwiGncLtYZDMANg6IIHJuo50BhjcbWnlaJlq
         I04w==
X-Forwarded-Encrypted: i=1; AJvYcCXuKranbdJOEY/h73xG2qDvrSJfpKqqSDB5LtkLVMmPhbQsVkKvsWynmvvTOaI62RZpeAASueG2kEpPZ7be/IM7R4iFwwUKpzSgcuMN
X-Gm-Message-State: AOJu0YwjmbH3WIltc9mqWRUu3J6TsZcab5dEDGmoQB1quob6Im0UIh3c
	XA/9djGZRL7v0vWCZK8IZ7qUjzBGU4vFHxmAsq58DUFpk9a8SpZwk88kuDq2CeQ=
X-Google-Smtp-Source: AGHT+IHs+PVJes9bcU5J+hkjaytIEisTo/t9yMkWk6trmZIfpsRZXqQx9bQrZmBp9veYPw3+BYfK+w==
X-Received: by 2002:adf:e802:0:b0:33d:fb3:9021 with SMTP id o2-20020adfe802000000b0033d0fb39021mr7947332wrm.54.1712670129306;
        Tue, 09 Apr 2024 06:42:09 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id j11-20020adff54b000000b003433bf6651dsm10753579wrp.75.2024.04.09.06.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 06:42:08 -0700 (PDT)
From: Alexandre Mergnat <amergnat@baylibre.com>
Date: Tue, 09 Apr 2024 15:42:00 +0200
Subject: [PATCH v3 02/18] ASoC: dt-bindings: mediatek,mt8365-mt6357: Add
 audio sound card document
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-audio-i350-v3-2-16bb2c974c55@baylibre.com>
References: <20240226-audio-i350-v3-0-16bb2c974c55@baylibre.com>
In-Reply-To: <20240226-audio-i350-v3-0-16bb2c974c55@baylibre.com>
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
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBmFUWsk5RNDHaaRzybw5abcV5vneXW5vP8Vm6SQhmY
 0Md7TsaJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZhVFrAAKCRArRkmdfjHURR2zD/
 9KNc4raiGk9xEnimPxYM2FegfDoBhRKHwIpxu8KF1g1GPWr+l5FFDRfIHQfZXB8Ot+wawVk7PSSlaM
 4pyNeUkltjPieiUonFHchDVseFFwJpX0UDgw2+IfosUkM4NlPdhpb9FhGaO6TlOf9rUVhJ0c8klDTy
 O4N3ZFgDsVufRwZX3ENmrao8VNuxZWn26KM5bJRscJh+K5AGRszPfo/qCWNZXjbVaFPBDyLxo7luj4
 7JVdtsY/2RGmNPbrK9ohyDF7bzI54u5tHi2vn6cqYY79YQk9OkxgR+gzQhUKw9NkVoSzrsdUjqjflc
 6EGZnw1xfAuZUoDf/VypXBwRP45T0H584H4iU4aVO3VJUz1XHV+kM/5GBR8cvoaAbYDzaI0pt7m0AV
 kc7bUqhGcg8mEawUzz1n0Ru3A5ND6NbfD8URPAAxbrwxMGn5DJvI3cktuDutx9qdRWTNb4V07j+Cz3
 Dx2ReCOH3j9HlP0W55LVvhIKVmxwjE+hIdaHq04uyG5tldw5sjVyhJvUxk7GsBPar04VfUdvrx5hUh
 cYxVhmfbMvicDTADR0JXa1L+MyjsoLZMk/CR8nBfC41xK0a6gYVFeCgQCwLHVlme8O0niJDTfzI/VR
 ebzFyQyVU+mmBRXoMqA3Zu9x4j/f7ATZhcRXhMTZZQEouCyW6g8cAggL11CA==
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


