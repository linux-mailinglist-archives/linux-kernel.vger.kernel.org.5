Return-Path: <linux-kernel+bounces-105580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CA687E0B5
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 23:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01E5D1C20AE4
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 22:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D90223765;
	Sun, 17 Mar 2024 22:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cel4jNV3"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4000225D9;
	Sun, 17 Mar 2024 22:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710714743; cv=none; b=Y893lUKk7NT1k7SSWafqDZT7gHXaMoiufnN21/3q+oqrNAHfv6MGM6t0+oxhMlYElviBDosRLJrbF3TnEVVexPPrVKED8NvZZ+G6Ifp2MKluguD+amZ0ZwiLqKtA0Ik0etEroglDR2ok4Nze4e0QCJuY45fXaVBjwF392EHJ1XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710714743; c=relaxed/simple;
	bh=lY8dgNekOCEdrVjKt68krBeC8X9xOlcUCI/JxikP07I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BwC0dTzTgYkWtBOAi7XtylURoH9CY0cvGtsOu6hpsNV6YafZVL/5eMUrdc0izLMfQtlQMU0ziBJnJ1PE1lp3rDlM90DMDk1zugGdnyd7l3Zjjt2H2pBe3rIp2lidSAvvwom1enXadjEVIzOL0WL1/V11qwWY+uOwXdcV6JFGd9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cel4jNV3; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-513a08f2263so3960553e87.3;
        Sun, 17 Mar 2024 15:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710714740; x=1711319540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GavwCOAQVbhDQ+vdRdLwuJP4i+t3za5/lzx/uEHUH9I=;
        b=Cel4jNV31XjGpsbugKDB3slh+j3jA5AP9VF0nNd1yCvfNWI+2EWZnWgTRrcj3lNw6N
         77woqUJTMuz3Us3FOfrFc/+V7QJNVd9WJlJoDrXJ2KGiNxxlppHbDvTC4T1HVgwaUmLF
         r7qwjerbAVSOjZ1HQPxzx3WjcPS4BZ2jDgHxSmpCA8wgXvLMmMLGRm1ITRTFph1HOYs1
         v6SCemc9Ue8aMi5pWTuyZksAUie+5QvLi9MXNgAPAd5B8UUbYI4xn5QFiP3G5OSBbaqS
         j+XEqrrqC07JojtHIsDuR0im5e6hOvz0THMeBTmT1+s6WiB5zrgqlrvpQwzD6APbqtCB
         //jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710714740; x=1711319540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GavwCOAQVbhDQ+vdRdLwuJP4i+t3za5/lzx/uEHUH9I=;
        b=dcuZtB1sWAdgrYkatoS7OvQLe8DPxVhTxK0RO3ak/I21sZgPNUO2SjZrfZEBq0tfda
         HEdJ/WCU1KjeE30Ewnjgvpu2/SNqJgXTCKYnEtgITh5WaVZScPbHbG51yyDYWfcujFmP
         URa1l3j7b9qVzwv/REqQBjtdEBvy+tUKL7P2pputIbxeEUzFFNNuLXsyZxGeFhMMk0yL
         WkVolQ8mBTZ78ESke0TZID1al1fpU69K3olQWByAG2OddxdGnxjGiA6UIkcxDlkJyf7T
         gloIEBmWCiviFgutFaVq36mTLN80H70hfEWQwkW30mkvTgCRtTqGNbl/VunSzefKWNxD
         Y2yw==
X-Forwarded-Encrypted: i=1; AJvYcCVefhZlBuN4KRK84xoyFdZP6vPABghOfw0ZnDp1nR8MvjM4gzt0QtkLdmfeslrO9RPchU+84IR9m/iH5NzOEkvHVdATOmzN1NAa0AoORvqFMAS0MMZ8itVzJkS2ZSoEZ4NQXb3kvdVrNA==
X-Gm-Message-State: AOJu0YxYtJhSVr+jLo9XTnkfGoBzZtJe8x/3StgtjdzY/GxSk6BLI1X4
	ckjkT5rVcaX2p+It8+ql8UloAO/Edbdm8cDTZiCYQsi8pesc4suQJlp9Qf58
X-Google-Smtp-Source: AGHT+IH2QUUdKpCb2MBt9QJkoYk74bgy89kZwcAUoxzCuORsr4QlNkeeYPDyLt6hR7T3gwPPeGpP8A==
X-Received: by 2002:ac2:48b5:0:b0:513:5971:10c9 with SMTP id u21-20020ac248b5000000b00513597110c9mr6728299lfg.56.1710714739667;
        Sun, 17 Mar 2024 15:32:19 -0700 (PDT)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id x5-20020ac259c5000000b0051322c11100sm1366981lfn.221.2024.03.17.15.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 15:32:19 -0700 (PDT)
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
Subject: [PATCH V3 3/4] arm64: dts: mediatek: mt7981: add pinctrl
Date: Sun, 17 Mar 2024 23:32:05 +0100
Message-Id: <20240317223206.22033-4-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240317223206.22033-1-zajec5@gmail.com>
References: <20240317223206.22033-1-zajec5@gmail.com>
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
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
V2: Drop board specific code

 arch/arm64/boot/dts/mediatek/mt7981b.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
index a187a34d12ee..5674ac81d1f8 100644
--- a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
@@ -94,6 +94,28 @@ pwm@10048000 {
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
+		};
+
 		clock-controller@15000000 {
 			compatible = "mediatek,mt7981-ethsys", "syscon";
 			reg = <0 0x15000000 0 0x1000>;
-- 
2.35.3


