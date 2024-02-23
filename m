Return-Path: <linux-kernel+bounces-78111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E785860F0B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53B77286B44
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757715D75D;
	Fri, 23 Feb 2024 10:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFcAMb+9"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E8C5D737;
	Fri, 23 Feb 2024 10:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708683445; cv=none; b=PUaynres2JOEfmbQntO3/9q8Zxd6Ld98a8B+iFEopjT8C6vrQXY8/HEOSyfZgKA/ApCclS8UDIpBSqKZ4jwg8KHba+0ByxuM1kzZQ+pfWRoJbZZQyppeL+yRfRspb4DKbVuGPgPtqUUPTAaxRC5IXVfdlZpU3u+Hai1GgV/Ltr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708683445; c=relaxed/simple;
	bh=pgzTUadOsNHs+VXmdqR5lDqqy54fCGno+iv3WPXiM/M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A/Rqp1IPhS4PRcGN2T+7A/XMt3sjVRdic8wV0wy9hbI4g7zyVbMR6zrOhAf2wzcnQksGAVv4MzqftRP4DSgscd4BOo9hVMuuKQWoLoYKVd7YvFBKAWujxyAOuV9vy3QzX2dxEbiyMZgQj7dAla9DFkbB1prMclUI8iFaE7yH8CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AFcAMb+9; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a26fa294e56so109934366b.0;
        Fri, 23 Feb 2024 02:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708683442; x=1709288242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/O3ksA4hTWY+K92YS4jtl+yo4GjNFqWPajb0hU9Fy0=;
        b=AFcAMb+9tXGVhO9vD5M5A1/v8eV89f9+oS3p25q8YyVBInofYpDSv61SFEenjJMLYe
         e5lK6yYiSy8Lrj62R86cQI3ITnvXCgcn3qa9tFe+GaeNRv2BoT3Z9sfNluaL2JXfhrPg
         I+Oq0oIFaz0Kxe429qHx2TtHWETTDRcYWdMa2TDwStuV2CpVAx0AhxMLsB+N1Xl4prJu
         Sx4hIoYphbr8D3WBBEjUeLsYeFOYyfPgqcq0dYiVsAjbSmFpeXU0iOxf515dMIe8NlaB
         i4bTBBUw8nZvQ5IyKcqbKVA+vwy0sHBfqushFPTIRZsgbTNqPVNmXNOgPDdjARhIF/5W
         vOpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708683442; x=1709288242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y/O3ksA4hTWY+K92YS4jtl+yo4GjNFqWPajb0hU9Fy0=;
        b=SXLc3eTcLkSVQso9iqnOOy+Pw932jy2fKlzVGR2cIUvrIOLTsxwnDpNRvDTRzTby26
         VYS1WGmt5WnPjzlDnYIeD0phdCq2IsXdpIhJ21r2pbuY0WnXg4U8KnlvTLEuM3L6MR/Z
         1aqzYp64vuQNgGKFlfufxQ6KXNZCBDx+QJxALeB0MpfdAtirCREnCFwj0Ju0qy+C1R37
         rxP5dgdfQHIFg/UdFNNXMZ5JH5iN6eMaGcgsJv6wU04H/cP/b5pojPP2xEN1WXwwgOfQ
         n0EXIXM9CQS03e8CUI8J0ADo12Tk09opaarqC/pIR6/EFwBcKvOfcelhq0bOHy+WX4KA
         qzLA==
X-Forwarded-Encrypted: i=1; AJvYcCWWwH4hK1R5/SaE6pTt4OFbIvGIXIFlM5pjHMHTvrAAyyd1xQ6vJiCXCa0qsB29DsrFCbVaDVHugTaDOiyKbeKM+0ugRTCQbwwNQFoqCZoRkcpf6g7ZTQcGX6vf2pAwTOeTp8sWfmdICQ==
X-Gm-Message-State: AOJu0YwStn4YpaRFZ4VBVGCwgzu4zATQwMjf82W+ZHSg8p01qU+5ypS/
	agcxpUKq4TOnAxEnN7oanh+2gNl0kk+zg0PcprnOulsaGHYE0YJh
X-Google-Smtp-Source: AGHT+IG5VUmyyKRrQhInbKERyLXwLXU4+G+23MuclTDO4DirdFc5S4LWW/fcfGxF1T3ne/aCDoNwpg==
X-Received: by 2002:a17:906:2297:b0:a3f:8968:78dd with SMTP id p23-20020a170906229700b00a3f896878ddmr925100eja.55.1708683442666;
        Fri, 23 Feb 2024 02:17:22 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id ti7-20020a170907c20700b00a3d99dc3f3asm6667250ejc.67.2024.02.23.02.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 02:17:22 -0800 (PST)
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
Subject: [PATCH V2 3/4] arm64: dts: mediatek: mt7981: add pinctrl
Date: Fri, 23 Feb 2024 11:17:08 +0100
Message-Id: <20240223101709.30072-4-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240223101709.30072-1-zajec5@gmail.com>
References: <20240223101709.30072-1-zajec5@gmail.com>
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


