Return-Path: <linux-kernel+bounces-160479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3EA8B3E0F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5CBA2847F7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9EF17BB16;
	Fri, 26 Apr 2024 17:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gT0TTmEW"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D6217AD7A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 17:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714152188; cv=none; b=WkMtQus8A+hGE8O5BliWOi4a66E2d6rGe0XwAAstyjK58C52hXYmVF9ooeVDNoXEvprSuMMz8e0A2MXQiBblleTqWVVOJgKKdkljMAvuhW5wA1Z6j8Phvo0SytD0+uTU2VQbe38uJj1JHYY3BaTj9la/clnUYe/TupA0Au5ugsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714152188; c=relaxed/simple;
	bh=SJCQ9iTy0gf3MF6NpcJbnv0eqLDS85mr0GL7yiG+BlA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XnuWKZMk2WZk1Ct33J+0+L2U1cpDW1EGVC8jzUr7vzgJ6WO1+Tb89+f2deeIs0pB0AG1eNzHyfH0mHBcBaJCDDNrboerYAk2aWJvmJC+HJBsF+FKOwHd239ENqOZCiMJCX49zUKedK8k5LvuOR/1lsk8RslVacP464pwDLVUdak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gT0TTmEW; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a5544fd07easo325156966b.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 10:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1714152185; x=1714756985; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o8YtHIDpzdHx4sXqMfJFiepO7h+jia5jAgm2xcDtDns=;
        b=gT0TTmEWd4MT2oxAgnQcgM3tlI20Erd1vqIx3y0t4Ew3JNmXDc5H/Peu1eDhIrN1rJ
         Y/7cHoo74SfeNIXP5aHIUitlzjRcn/oA+y4OAxOiudxjfgZAhil6MjkSTOUTNXeK0yFW
         CHmk6taYKgwtl711Xd8SeLzQx7QFWeNHK0tDK6KURntPgffKYN+kirClxuBgB3Pu6Jom
         SYStmGsYouMo0eykBog1ENuXYR0kNjEXjS8iZGdq9hWFDpKhc/k3k5JRe8chhnGdFg4L
         mzv1qa82Fb/xs65LZyuy/2IS5FEYjeV1Xt9sFoOwx9gTOKyhJMNP0MWzpkcMpvK0gkxS
         tpYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714152185; x=1714756985;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o8YtHIDpzdHx4sXqMfJFiepO7h+jia5jAgm2xcDtDns=;
        b=WScNtCvf42Jm85Fg9dQoMqdYuzB6Lyzp1aSr/uW6lvOfG0TOkZUq7LJX1k19ZD3R4+
         PcV3lKHVRfvOalgZFWLeq2NyuX0Bd1MQc/Y9h58LqjmsUW7y2pTfH4QZCraJLroViPps
         1izJU6kHP/ANud5Uxw0PDJ6YMITtFzpb8f9nba/EJOYtzVOc36mE9WkHMzW4lS/aw9E6
         r4FfScjAcQ85V2xvfBwJpnHochbaZ8rpaJG27i6JWR0fOOzbN1hOGzj4Q+YuynHxzxSx
         z+jaTVd6LFcQT0RFJXzhh+q+RF6k02IhmIZvy+lsYG7BT/Uc3FMWd5wZe35m/7wH6kfw
         jqmA==
X-Forwarded-Encrypted: i=1; AJvYcCVNKcbbjZGOH5onCG67TbAg5Qqn2k3d9xCLJULocWjTi5FrhaUxzN5qbl1aZ0t+ezCAfk5fVPKTvIxRymnk0Vx7zYETg0ar+ZaBdNf0
X-Gm-Message-State: AOJu0Yypa/BVR9eCN2sGlIn0ZK5S/SODFWBoX78t7P0zxmap2/4/uX9K
	bvawPMFU8G2Xe+BgOE1Zyv6rcjwH7AnmbQeAPEe0fzuW37eFFbp899enSjC1o3A=
X-Google-Smtp-Source: AGHT+IFe8cPyxYKPbB10bsA22HXOnNfS2uZCqL9dCr5CCChCqjSUjXJYhasnPEIlUBFiAuMlS60jng==
X-Received: by 2002:a17:906:2c06:b0:a55:64bd:2544 with SMTP id e6-20020a1709062c0600b00a5564bd2544mr2122960ejh.60.1714152185108;
        Fri, 26 Apr 2024 10:23:05 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id ot15-20020a170906cccf00b00a5239720044sm10763363ejb.8.2024.04.26.10.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 10:23:04 -0700 (PDT)
From: Alexandre Mergnat <amergnat@baylibre.com>
Date: Fri, 26 Apr 2024 19:22:45 +0200
Subject: [PATCH v4 16/16] arm64: dts: mediatek: add audio support for
 mt8365-evk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240226-audio-i350-v4-16-082b22186d4c@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3675; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=SJCQ9iTy0gf3MF6NpcJbnv0eqLDS85mr0GL7yiG+BlA=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBmK+LaAKHbepcmLOlZloUS5NBbwlGYMM92geHkpJU7
 XXa0I1qJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZivi2gAKCRArRkmdfjHURTMzD/
 9qgSi0I2CHYULuwM1Nav9rRhgAYJZAbLZdgfNHsBQc8L4p0cJrd9BxqKmxruQ4EwPq8BkmZJTpIzWE
 iExHW/L8zCFlE6ksIo7WhitWXf5jkNImBAqiEDrhcImecZMqWJuCrE3+RTKcYi0432KkK8ZP/uxnHB
 pBvGzyTTbbVz3kmVZ3fmAfCsYEgeO0b/tUMVqZGYuBexCYTKHrvDlqOJ4cX7BfJg4v5cGSDnjaqi8E
 TLDGHYHZ18jQYlYrUwmsqQ2w0hpnDwb+1HJ7A8ahgjdwJEf4LEBJVYZR1NL86N8ZMi2zg5QUW5qhZ1
 dZqON3mLt5LIcg8AbAZpwK8oRy/dsHkC+78KqmjleWYhCFwupn4oYUi87ZWNGmpZvOynMhtk+ZTvCz
 2l7DMC/2Q0XF643D8disbp/yiMevYeBnnPg/ayz7A4evpXVmOEBPN4bb/aB2qKYru1vKz5teiWLFAC
 +Av/KPOz3MQwqUcjThylnvpy7+Enhq0WVK4i7bUoC0LlClRV4MblSz4vkmC4/CtX+t3Y3Ipb5t87c2
 Y+oHm6LmIGV4dVLgez38gDWlGSxW6xs71wlTPyYgaxs3QCO6UklKMLcBZwPBhraGMQoYuNElQRpW//
 hTPVT5adtgXdUQQn4Rt/rXB/0zCVw2PoI7W/Kbg7YMrjQfHssQjxtLVyEzQQ==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

Add the sound node which is linked to the MT8365 SoC AFE and
the MT6357 audio codec.

Update the file header.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365-evk.dts | 89 +++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
index 50cbaefa1a99..32ae7d599272 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
@@ -4,6 +4,7 @@
  * Authors:
  * Fabien Parent <fparent@baylibre.com>
  * Bernhard Rosenkränzer <bero@baylibre.com>
+ * Alexandre Mergnat <amergnat@baylibre.com>
  */
 
 /dts-v1/;
@@ -86,6 +87,28 @@ optee_reserved: optee@43200000 {
 			reg = <0 0x43200000 0 0x00c00000>;
 		};
 	};
+
+	sound: sound {
+		compatible = "mediatek,mt8365-mt6357";
+		pinctrl-names = "default",
+				"dmic",
+				"miso_off",
+				"miso_on",
+				"mosi_off",
+				"mosi_on";
+		pinctrl-0 = <&aud_default_pins>;
+		pinctrl-1 = <&aud_dmic_pins>;
+		pinctrl-2 = <&aud_miso_off_pins>;
+		pinctrl-3 = <&aud_miso_on_pins>;
+		pinctrl-4 = <&aud_mosi_off_pins>;
+		pinctrl-5 = <&aud_mosi_on_pins>;
+		mediatek,platform = <&afe>;
+	};
+};
+
+&afe {
+	mediatek,dmic-mode = <1>;
+	status = "okay";
 };
 
 &cpu0 {
@@ -178,9 +201,75 @@ &mt6357_pmic {
 	interrupts-extended = <&pio 145 IRQ_TYPE_LEVEL_HIGH>;
 	interrupt-controller;
 	#interrupt-cells = <2>;
+	audio-codec {
+		vaud28-supply = <&mt6357_vaud28_reg>;
+		mediatek,micbias0-microvolt = <1900000>;
+		mediatek,micbias1-microvolt = <1700000>;
+	};
 };
 
 &pio {
+	aud_default_pins: audiodefault-pins {
+		pins {
+			pinmux = <MT8365_PIN_72_CMDAT4__FUNC_I2S3_BCK>,
+				 <MT8365_PIN_73_CMDAT5__FUNC_I2S3_LRCK>,
+				 <MT8365_PIN_74_CMDAT6__FUNC_I2S3_MCK>,
+				 <MT8365_PIN_75_CMDAT7__FUNC_I2S3_DO>;
+		};
+	};
+
+	aud_dmic_pins: audiodmic-pins {
+		pins {
+			pinmux = <MT8365_PIN_117_DMIC0_CLK__FUNC_DMIC0_CLK>,
+				 <MT8365_PIN_118_DMIC0_DAT0__FUNC_DMIC0_DAT0>,
+				 <MT8365_PIN_119_DMIC0_DAT1__FUNC_DMIC0_DAT1>;
+		};
+	};
+
+	aud_miso_off_pins: misooff-pins {
+		pins {
+			pinmux = <MT8365_PIN_53_AUD_CLK_MISO__FUNC_GPIO53>,
+				 <MT8365_PIN_54_AUD_SYNC_MISO__FUNC_GPIO54>,
+				 <MT8365_PIN_55_AUD_DAT_MISO0__FUNC_GPIO55>,
+				 <MT8365_PIN_56_AUD_DAT_MISO1__FUNC_GPIO56>;
+			input-enable;
+			bias-pull-down;
+			drive-strength = <MTK_DRIVE_2mA>;
+		};
+	};
+
+	aud_miso_on_pins: misoon-pins {
+		pins {
+			pinmux = <MT8365_PIN_53_AUD_CLK_MISO__FUNC_AUD_CLK_MISO>,
+				 <MT8365_PIN_54_AUD_SYNC_MISO__FUNC_AUD_SYNC_MISO>,
+				 <MT8365_PIN_55_AUD_DAT_MISO0__FUNC_AUD_DAT_MISO0>,
+				 <MT8365_PIN_56_AUD_DAT_MISO1__FUNC_AUD_DAT_MISO1>;
+			drive-strength = <MTK_DRIVE_6mA>;
+		};
+	};
+
+	aud_mosi_off_pins: mosioff-pins {
+		pins {
+			pinmux = <MT8365_PIN_49_AUD_CLK_MOSI__FUNC_GPIO49>,
+				 <MT8365_PIN_50_AUD_SYNC_MOSI__FUNC_GPIO50>,
+				 <MT8365_PIN_51_AUD_DAT_MOSI0__FUNC_GPIO51>,
+				 <MT8365_PIN_52_AUD_DAT_MOSI1__FUNC_GPIO52>;
+			input-enable;
+			bias-pull-down;
+			drive-strength = <MTK_DRIVE_2mA>;
+		};
+	};
+
+	aud_mosi_on_pins: mosion-pins {
+		pins {
+			pinmux = <MT8365_PIN_49_AUD_CLK_MOSI__FUNC_AUD_CLK_MOSI>,
+				 <MT8365_PIN_50_AUD_SYNC_MOSI__FUNC_AUD_SYNC_MOSI>,
+				 <MT8365_PIN_51_AUD_DAT_MOSI0__FUNC_AUD_DAT_MOSI0>,
+				 <MT8365_PIN_52_AUD_DAT_MOSI1__FUNC_AUD_DAT_MOSI1>;
+			drive-strength = <MTK_DRIVE_6mA>;
+		};
+	};
+
 	ethernet_pins: ethernet-pins {
 		phy_reset_pins {
 			pinmux = <MT8365_PIN_133_TDM_TX_DATA1__FUNC_GPIO133>;

-- 
2.25.1


