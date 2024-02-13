Return-Path: <linux-kernel+bounces-62949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E64C9852846
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 06:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E2BF28593E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 05:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B79156E4;
	Tue, 13 Feb 2024 05:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HiobKH55"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65195134A7;
	Tue, 13 Feb 2024 05:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707802689; cv=none; b=A+Zj2A3TEbHkg5fA1VpuHqhVfxeEHWAA3T/O/sHyKDQztizpdjCEW4Y1fBuX8yXScv9JngNBJBpUTF/58Qnf7aUynpJo7fUTsNU8Ux6bM/ERR4uPWCibBHDC68FPiB4nHJL7fSu0CUJa5vZv2TDthra8xtTesN/2qW1zykDFdwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707802689; c=relaxed/simple;
	bh=omVVZqAPwzo6zZ/ZclaeNjfVjhamkChXexUh9lvdRVU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jsR14zf6l5EHtnvB/4lKzNwdwRaKJ6yCjXcWeqFmfsuQcScjH20y5Fx6i5aC0/AhSoL/BSJARLJeGS2fSC5o1sCOn/Jya+dNQXtIwfplhzCF3eok3mixONHfh+0HkqfDcO9OQ8vtzmP+dGmkN1hX6oqJM3GKtmKC9WTKa8Yaw2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HiobKH55; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so534257566b.0;
        Mon, 12 Feb 2024 21:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707802685; x=1708407485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bYXdB3+zSKU+ziwTscLVWPyxXG/8J4FJdNu2+Hvv5wQ=;
        b=HiobKH55fo/HAgEAojY0LPFLfOGDd6IJk+0m2IoI55iQIGv2rXkDCzfmdBw+pY/zDf
         +78FqZdZl1ATh/GUPMcEAWvXZAXM0trInbbHRmMdKROs5O5d+YALDaoAdoUg2Wd3p+9i
         zOqVmNQfqu43moLbJHQovc5IsIGFtkOWZdGsrH/syxEaolHCSz0QKNZ6WhHo/Iawj4+A
         FpuJfon2kayiLwErh8KevCkVTt9NLedEJVl7jij0bH4R2Jxip4gTxxDccHao/XYTnfS/
         Vk/FVe0Cb7i7fCh6QVIZFvX1WFGhQ8/IKMp0yDiXQkozZFkB55hG2ucm/6TPh6BV0edh
         LxTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707802685; x=1708407485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bYXdB3+zSKU+ziwTscLVWPyxXG/8J4FJdNu2+Hvv5wQ=;
        b=IznXI6P0skNEOBC0R4tPa+t3IWgyFhLu1FD2LX2r9TLdputjKEQqIFNeALaZO9GwE6
         MIZfUn9leV113VvYQ/U64ZmzgBUrgXtuZrjjI5LhmS+AotBvbfJp6IJAtH/ZXGL99Dss
         ky++CUJiaXyNO2AWMywXc7Bll3GWRpcDYHO6jp+SQcNuJHxpyBWnrfjyQzyzOTZLZ9RS
         P+4e6uts3MZ9KfegJ0s7KTGt+WCKQkjeYtI5MF75ffIdIMxxuT7nJ8Q88Cf/fJ+5beAT
         x7gS9AgJcHmO600IL60h5z+76rm69wFhc0rkTZ/doaNttDh+wtUfsRItYseFYpqF7IF8
         MIrA==
X-Gm-Message-State: AOJu0Yyzanfqtls0Mq+exJqnUMPzJfTY3obdFUQRK0iifRoqWQ09oe9e
	lqzC/p9cRRwRKXZLd6/1lQnk/qACLmqe+JdRfSZaXSYXzOR82Cx5
X-Google-Smtp-Source: AGHT+IH1RI7+JKCAoucQct5YWa3nTZGYqSTFR3J5hmCbgkfu3eIRUhtFS0zPvYnp2GIoXhZ46YJTvw==
X-Received: by 2002:a17:906:370e:b0:a38:215c:89b with SMTP id d14-20020a170906370e00b00a38215c089bmr6335504ejc.73.1707802685274;
        Mon, 12 Feb 2024 21:38:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVzK/M5LmqBMpnrz+fUmQDlVL/XtC8+joam+QwRswGCuUyU/QeYQCN4iLP1hFPuUSg6PROoJPLn3bJTpX3G8I9WqT6JK0YduVZTZnfAVw6sJ26y5el3AE1I/bQXS+sT54F6pstFw7Z9PWC/jZHRRfsT7NF/3R/xCClupGPJm1R8qebInSfQTnuFRsjxyESbyWuvqRk2g9afuq3AdbDCy+8nV7uKOO595E+yrGpMvEHEU2nMNT/K7sAZA3BzEvx5h2nfTlcELq+2J/nhNMDlItRjinHMhzFDYncAqUzlN0e4PuEW7w2tY5kPvekWofxTxZysfu66X9m0ZQ/aRn9s1nuV6zHm8nb3GvlWOvS5Zm0fxZ85Atcx5Jj0c5Fg+q12QdK3DT2ZO5DWcx/3wyLMdUUesBRKwFWO/IAdJki/QqSINXqmMUo6lgCJvj8RnDvgvTO6jqoXLZzvKHx4YLP+7B/5tP8MMvHL+/zqtFEegDlrIKJqFixrRaX92wB5WTQ2eKCF+vuzOtfyyVwxjGY2UGY=
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id ll9-20020a170907190900b00a3d125b9c0asm16659ejc.81.2024.02.12.21.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 21:38:04 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Sam Shih <sam.shih@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Daniel Golle <daniel@makrotopia.org>,
	Frank Wunderlich <frank-w@public-files.de>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 3/3] arm64: dts: mediatek: mt7986: drop invalid thermal block clock
Date: Tue, 13 Feb 2024 06:37:39 +0100
Message-Id: <20240213053739.14387-3-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240213053739.14387-1-zajec5@gmail.com>
References: <20240213053739.14387-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

Thermal block uses only two clocks. Its binding doesn't document or
allow "adc_32k". Also Linux driver doesn't support it.

It has been additionally verified by Angelo by his detailed research on
MT7981 / MT7986 clocks (thanks!).

This fixes:
arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dtb: thermal@1100c800: clocks: [[4, 27], [4, 44], [4, 45]] is too long
        from schema $id: http://devicetree.org/schemas/thermal/mediatek,thermal.yaml#
arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dtb: thermal@1100c800: clock-names: ['therm', 'auxadc', 'adc_32k'] is too long
        from schema $id: http://devicetree.org/schemas/thermal/mediatek,thermal.yaml#

Fixes: 0a9615d58d04 ("arm64: dts: mt7986: add thermal and efuse")
Cc: Daniel Golle <daniel@makrotopia.org>
Link: https://lore.kernel.org/linux-devicetree/17d143aa-576e-4d67-a0ea-b79f3518b81c@collabora.com/
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
index f3a2a89fada4..559990dcd1d1 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
@@ -332,9 +332,8 @@ thermal: thermal@1100c800 {
 			reg = <0 0x1100c800 0 0x800>;
 			interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&infracfg CLK_INFRA_THERM_CK>,
-				 <&infracfg CLK_INFRA_ADC_26M_CK>,
-				 <&infracfg CLK_INFRA_ADC_FRC_CK>;
-			clock-names = "therm", "auxadc", "adc_32k";
+				 <&infracfg CLK_INFRA_ADC_26M_CK>;
+			clock-names = "therm", "auxadc";
 			nvmem-cells = <&thermal_calibration>;
 			nvmem-cell-names = "calibration-data";
 			#thermal-sensor-cells = <1>;
-- 
2.35.3


