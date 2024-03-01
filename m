Return-Path: <linux-kernel+bounces-88359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 159E286E073
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABD5F1F2299F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928296E60B;
	Fri,  1 Mar 2024 11:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFtdTSYK"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269B46D51F;
	Fri,  1 Mar 2024 11:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709292922; cv=none; b=ISoyRHaTRW7oDQeiao0DwtIMJQ61ywMne/bfrzrBRO+Wi4CEPodsSWMqCzqtZuybnigY4oaEmUoxPA4pPyXoPKVrpgtcACzdIMSeOWOPfq+kj9fKiXtyvK3y7Z+wIg6M/L/RTPYHDRvqlA5Q48oL1NPF/zXuP5XnnoRz7lpiWyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709292922; c=relaxed/simple;
	bh=lxHwZfFFMuz+q/k8m6q9Qr+n7MGTqEI4PHGGt5co2Hk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b+GCslv+YtzXMO2Ad/UIG1AjRazUKtiX8tCoqOn/WCZ4Y/O5OyuzWBilJNrhWTtrEBT9kO9JGzOOBj7DZd+diel+NVZV8VXaDmbgsBr4ogoxCCs67wlR8PUIiBQl9FvXEjQ4Yq4aHgSCx89060zEs/rWVvZOaXNXUPnyYaulQS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PFtdTSYK; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a3ed9cae56fso587276966b.1;
        Fri, 01 Mar 2024 03:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709292919; x=1709897719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i0wAOYZVgkdcFy2J+qEOOeWr8TgaMSGXarO6ogj2s4w=;
        b=PFtdTSYKp1VNHQWba2/fuKk/aUzl/1dk4AHOhQlnngfy/eEa35V4ZC+Re0jv72CmUH
         RBZBemRZ/51vH/xP6nljXPGof3lI6ZgRGkwWpIkmr2JPssqYnIsY3tczCfuP2bUqJIRe
         cByO5oBNmhS6mw+MasP4R//LvxcxF6nML6AFJZqoLDNNqXSUlYfo/PHf+753+Dp3rycm
         PZjQrV7E1YIEcmnQDZO5X1XDC1Thof2DfH0IX8ldUlZJQCzfLzC2CkGtKobX9PQcXL7D
         6U0I8Lcb/mrPQB4mjyaPaS1pvhmDDC73PYuXkyN1koUBlNMXMq7T+xpY2jtUugiN8m/s
         b+mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709292919; x=1709897719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i0wAOYZVgkdcFy2J+qEOOeWr8TgaMSGXarO6ogj2s4w=;
        b=rJ1nrvD9f7cbCsxdDZAh146i6AD7wtKxQePc+cONOurq7R6fhRKTFkB9ExM+Z4CN2V
         2+kbr9BBlya0q0l0qgp9VxSeaC3V23gVB6Lo+2eE/+Q14JxuZQyHgCvzjcHyFxzRDHhu
         JJXlu436mqQ/h2MBE7ayihfI9xUIlqi6SsM91A26UbXqqQfOLNQ4iHAdBQ9efzvZAjU+
         9LnEFZdwp88EuOsTu03HKPQZQOBaNWJ17+7UeKwwHY7YKh6DQOQhQ0aejr1+t9gA156O
         JrFcllctrvNkpbHE36tabifc9nhSSjkJsegtmw2Jv4KMF57FeVNoE6v0cfIV51HCwT7W
         JM5g==
X-Forwarded-Encrypted: i=1; AJvYcCUcmmJy9fWgj5cAFG3g+vFmvpLtLURbX+iy6BpStdB1zY18vkcMM7//LLuqBiR/TWTqSaf4mKyCFOFZlo6UQU1OIYUyOk9cE0ovu3Je
X-Gm-Message-State: AOJu0YwPvzQfbSHOKasxfbdFqudg+5Nuudo5PHh8yd66I2v6XmFOVf/q
	eAkR0+QPFNGxcxQLIFc618U6H1CqSXptGvxtuuf4YfoXbk5v+rmP
X-Google-Smtp-Source: AGHT+IEXFliO0HGuCUrt7SbS2edsg8fiBIE1rDbRTtIDXkoOXXOvk9mUYsdKlIItLvK8rx6/3gjEkQ==
X-Received: by 2002:a17:906:6d09:b0:a44:2cc3:2ba9 with SMTP id m9-20020a1709066d0900b00a442cc32ba9mr1094118ejr.2.1709292919368;
        Fri, 01 Mar 2024 03:35:19 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id st11-20020a170907c08b00b00a3f5c39bf2asm1618457ejc.0.2024.03.01.03.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 03:35:19 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 3/4] arm64: dts: mediatek: mt7622: fix ethernet controller "compatible"
Date: Fri,  1 Mar 2024 12:35:05 +0100
Message-Id: <20240301113506.22944-4-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240301113506.22944-1-zajec5@gmail.com>
References: <20240301113506.22944-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

Fix following validation error:
arch/arm64/boot/dts/mediatek/mt7622-rfb1.dtb: ethernet@1b100000: compatible: ['mediatek,mt7622-eth', 'mediatek,mt2701-eth', 'syscon'] is too long
        from schema $id: http://devicetree.org/schemas/net/mediatek,net.yaml#
(and other complains about wrong clocks).

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 arch/arm64/boot/dts/mediatek/mt7622.dtsi | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index 7714775d1bd0..7da4ac273a15 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -963,9 +963,7 @@ wed1: wed@1020b000 {
 	};
 
 	eth: ethernet@1b100000 {
-		compatible = "mediatek,mt7622-eth",
-			     "mediatek,mt2701-eth",
-			     "syscon";
+		compatible = "mediatek,mt7622-eth";
 		reg = <0 0x1b100000 0 0x20000>;
 		interrupts = <GIC_SPI 223 IRQ_TYPE_LEVEL_LOW>,
 			     <GIC_SPI 224 IRQ_TYPE_LEVEL_LOW>,
-- 
2.35.3


