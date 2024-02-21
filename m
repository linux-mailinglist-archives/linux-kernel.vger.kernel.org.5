Return-Path: <linux-kernel+bounces-74245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFCD85D186
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9F23284CEE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372DB3AC26;
	Wed, 21 Feb 2024 07:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XI7BgLZQ"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83EF3C06B;
	Wed, 21 Feb 2024 07:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708500972; cv=none; b=ppw7ThE6FDVdWW+5yNiRFwJij62gKW+vYF/AehqdbHz79CtNFnhmGxItK7lG23vv6AkI+Bm6TZ926F+0VO+JnFkz7c9gfmHOWER+ktzH0s5jR2GmR+z/yciS0kyOeiAUmCM/t4T4Nr2gSzmShFZm2LYm/4vyQv6S/H+laaszj2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708500972; c=relaxed/simple;
	bh=/rqvRqPz555WBEPWYgi8I6tJAQsgb09feIiJ08a5xdo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YnlJQp6IhoB7KuXbvy3dFGVsfvRonikWP4ByZfH0RxcU1Zie48o6wEW5fIPNIzuXHlTcDwDR9c/r9mQ0eKHEkao1Z7sQimQFE+U4UyA9lPcYngrzYl9tO7mbtFu7junUhaGCPfzA0HhXYVenheU7yjGEQisXXwJqvXBlhirOGQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XI7BgLZQ; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d21e2b2245so4530041fa.0;
        Tue, 20 Feb 2024 23:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708500969; x=1709105769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5K+LPUTpDWl7CTSQ7wwWQlCqZnBOjCKam3sPzq3LFCk=;
        b=XI7BgLZQPqro8himtR+2CL66xZ0ny3fQf6vAa1pxCrqKMsr4CH8xCMCioc36OLnqGr
         ZRVoSN9BX1t2FRvFv6AeLC/oRo+HwGJLFd7oNSbMwsm+nTnptVqv50S82NkK+UCol/AR
         /I18TB9qDGwdYh1zZ47rAvQAj+7p0BnLMU7pGyUE09liV3N4aa9wN0j9a7mt+jZxj3q2
         xSqEoMiZHVoVnTS3HiRldWPoAkBkQv/S8gok/VLcemGkWNUJIrwcq/tIH413f9PLI8WR
         UAj8F7hBwrTtF0CB0TTXFdZ6JEhuz0nwTd9LJ+Ddc6M+oqoH7N+lJabkCqXXvRGQHTn+
         ftCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708500969; x=1709105769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5K+LPUTpDWl7CTSQ7wwWQlCqZnBOjCKam3sPzq3LFCk=;
        b=USG9+69alO+jGFthNZWro61DQaVesywbPBlgaqqs+MBE6XOZDJYXenIHqRa/JyJ2LE
         6m/Dccw7e2RKh+V3DtGtz8pAuCbIO1+EKMJVV6jtDSAzU/8Ts9gBPoHnhsdSUl/6nrBB
         CAZmoXldnhS9egeHXlLagzdXxz/n48laEvb7Q9PGhrZW8jTHhUgqK5nw2Wk2LDfGPenv
         NZjkq3rTPVCWaJ9HwyaSX8FPHBm82Sy/E+GR8gE1WGJ7av0WwfOuH0napIjI8/iyMvlk
         AG+B8e3c6uk4Sr8LRuz8dR+oivsnTZhjrB0hjBoa5lXGgTiVPMyLs3IsB/mbvHRg7rOn
         q9Eg==
X-Forwarded-Encrypted: i=1; AJvYcCXtgRcTIpP8oqrKkJt5SwOg0plMoMIji4Y/fLsBdKk9krJOhtBAzHRtS9T+LYxzg5unKM8A3Kd+CfUwls7DsJxugMrmnPNuA3nNJW0Oa+URv7ThL+eRLyHkGPF2jX4AZc+gWn3UYYm5xg==
X-Gm-Message-State: AOJu0YxmOxU628/g0ebIVOMKIrvEtsqGk3vsVnAQfYpvkYsLWoGuL+rW
	uufrZd8h8pstWN6fyhu7qi9a8JPgHhmH4ivUGeiVB2tu8W6IcVFV
X-Google-Smtp-Source: AGHT+IFCRIUB71wvbXRhTRzpy+rQD1aWwOBIh3hXm5/xx0yOSjW8vja0s/q45MUSdS0SGtkyDZ9S2A==
X-Received: by 2002:a2e:854d:0:b0:2d2:3a2d:d2fa with SMTP id u13-20020a2e854d000000b002d23a2dd2famr4765275ljj.28.1708500968737;
        Tue, 20 Feb 2024 23:36:08 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id z3-20020a2e7e03000000b002d0f99a7fc4sm1722330ljc.79.2024.02.20.23.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 23:36:08 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	Hsin-Yi Wang <hsinyi@chromium.org>,
	=?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= <nfraprado@collabora.com>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sean Wang <sean.wang@mediatek.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 3/4] arm64: dts: mediatek: mt7981: add pinctrl
Date: Wed, 21 Feb 2024 08:35:23 +0100
Message-Id: <20240221073524.20947-4-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240221073524.20947-1-zajec5@gmail.com>
References: <20240221073524.20947-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

MT7981 contains on-SoC PIN controller that is also a GPIO provider.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 arch/arm64/boot/dts/mediatek/mt7981b.dtsi | 37 +++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
index 4feff3d1c5f4..fdd5c22cfc9c 100644
--- a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
@@ -86,6 +86,43 @@ pwm@10048000 {
 			#pwm-cells = <2>;
 		};
 
+		pio: pinctrl@11d00000 {
+			compatible = "mediatek,mt7981-pinctrl";
+			reg = <0 0x11d00000 0 0x1000>,
+			      <0 0x11c00000 0 0x1000>,
+			      <0 0x11c10000 0 0x1000>,
+			      <0 0x11d20000 0 0x1000>,
+			      <0 0x11e00000 0 0x1000>,
+			      <0 0x11e20000 0 0x1000>,
+			      <0 0x11f00000 0 0x1000>,
+			      <0 0x11f10000 0 0x1000>,
+			      <0 0x1000b000 0 0x1000>;
+			reg-names = "gpio", "iocfg_rt", "iocfg_rm", "iocfg_rb", "iocfg_lb",
+				    "iocfg_bl", "iocfg_tm", "iocfg_tl", "eint";
+			interrupt-controller;
+			interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-parent = <&gic>;
+			gpio-ranges = <&pio 0 0 56>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			#interrupt-cells = <2>;
+
+			mdio-pins {
+				mux {
+					function = "eth";
+					groups = "smi_mdc_mdio";
+				};
+			};
+
+			spi0-pins {
+				mux {
+					function = "spi";
+					groups = "spi0", "spi0_wp_hold";
+				};
+			};
+
+		};
+
 		clock-controller@15000000 {
 			compatible = "mediatek,mt7981-ethsys", "syscon";
 			reg = <0 0x15000000 0 0x1000>;
-- 
2.35.3


