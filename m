Return-Path: <linux-kernel+bounces-62947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B588852842
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 06:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 733011C22FDE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 05:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1395125B4;
	Tue, 13 Feb 2024 05:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O84/rl74"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5462911725;
	Tue, 13 Feb 2024 05:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707802685; cv=none; b=rARSb6zAGjQ5+CNtaeSu0clW4VuZeLqOZZM8tVkBg06pKzMtBb2YOTwcu2LDtBKEMuBNqnbb+nwP2mjSKbBDbJn5/xh0LEw8DATpxna3qtcJlkXJPF2Dv6xoXny3ll+yp+7nCm/ETNCNq8kxV5cGTal9nxBctlvJRFIClmX/suA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707802685; c=relaxed/simple;
	bh=pSp04aOyww9UF/J4h2MrS8urw7o/puKj5e0F7MbsGgI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=dHeyLagj4JwESgdgEG9EJwneEsVmbdDh9TAe8ZdsrAnh0JvLkT1U4WEtomgsMBKDdRAcDFZN6+zU6OCCNjXqyd8JjwY8UQbN3L/4GcGXQ73nSmP0LEfGx0FDXCGbamupU1HslLoBCk0zaZJ5CW/0eTF7IBKzUyUjlu8R0kNugn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O84/rl74; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5116bf4dcf4so4742557e87.0;
        Mon, 12 Feb 2024 21:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707802681; x=1708407481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y6whheju3NN4BqY6LFcpmmPqXluoagcef/LFMHep7Sw=;
        b=O84/rl74cA4DhWn4E+fsukDFdEUHpu0xC1OzyHGKe8DashgeSny2bNZTWZ0ttYXhFm
         Euob3R6m2GwRipGIcu3LoXS3n53Ogr5D6VjfGaHIx6ZzcgWXsBnlPOMwe2c/9z/O26I1
         Zl/5cI/dlX6439BQNcrxEgoaKZvtjYr835VIPE2IG1SltHMlLlm1RAMjAUuTy7TCLSvs
         ZOqbOdGFiFqZCP61tyAMXAmDuZFbAp1H+L0tTE6l3fCquXwVRzVenwnej3JpEHzlC5t1
         kOcO+xUrV8h179KLJBxy/DOxCmccbVJa53SItuHkqlLDRk6treXXy5a2i7RnQhfyE7/9
         3RuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707802681; x=1708407481;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y6whheju3NN4BqY6LFcpmmPqXluoagcef/LFMHep7Sw=;
        b=cRWbZPUNw/i30JgRIelSKvhPtOlmkBNrP/lzwrsg4yBuVCEGdOwcMPFYWqCBPtfsPk
         qQnZ0dFQtbqLLIo/RVB8ymB/wVZhqEKfbherkFt0hLSW99UzYVebw573gtX/WcG5DiW/
         8fkLFVB9Ipr6IAPZ0REQ2F4GA2J0/1XAJ1bfQQPDcaI1w7bNSq7XPkqdc/Bhl+gtZXXH
         g/+6oOYSr/XXeQs9VRpyxQ1oEuewkf+MdXVb/2OADIxlOHe5LChC9KzNVEB/xYYsNAtt
         Zyg3WjNU5b5hPyFQMnr4Z9CHxOeYMLHBBfjHci031/G8PnEd6KGBwqbAFsrkP5enQnL9
         5ewA==
X-Forwarded-Encrypted: i=1; AJvYcCXa6oktEzmRDtx7Ktvop4CXIk5yeS/pRtNvZOYHvxgbRfUeklt+sLSGa1p+LJL0AUYGRk2FeNlZkDLtxUBJEIFqFMdqVbtzqjwDPW/nF7K7HrI2QBklKIDSM99CisFVXCBaw/oWTUROPQ==
X-Gm-Message-State: AOJu0YyZ/CxaMOJNLJ2rEvBk4TQMeeiIXy+i2INyBL56pqWH0ODlKGMK
	aG18iocxWktsvc0xQ+OFVhnsIEgcfhdZO+JoFCCYR+t4b5sOcIrf
X-Google-Smtp-Source: AGHT+IEYv4/4ALvGa72xiNOOaY7e3dOG1YKfoXOw/ZHT+6/YMgv2cMGO57rgfPdiN9NDpTVQDjxNeQ==
X-Received: by 2002:a05:6512:ac2:b0:511:4a01:2faa with SMTP id n2-20020a0565120ac200b005114a012faamr6840591lfu.32.1707802681119;
        Mon, 12 Feb 2024 21:38:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW2tGrtBOg8KcRwmQRPgHXd6qJA+pLVnJmF6/vU3yx1sVl0gNb0EESWJdYs5iEbETyMYMJBl6Al6rNlTUDRqhCxcJjy5Cl6u7RBSbr2avovnwBm56c4ec/Qm1b9mfEwYlUwwR6hZaac86g914HXwvV/3/nIZPVB9Y0gK46QVRH0/893u5tjOCudcyilGfAwfVktFhGV51sLOJntmdksuIut8aNbUu6V1k2oyr3ljjz9kQzDLmNVc2zWFQqipiODhNpV+LrUiQJz5PB7rGqxCEjbpBqG+/YQ7pB4V1zk+KTR8lZZv3g9Nh8vpaP8GYhHgVAudqydYEcoXgKD03duxB5NCMJStAF1SKZMyK9gTko2J+Kfq6ehhk0HRpqhkYLTI+ZvGY0Fo3Ri1eoppMJeWKoLGcmfgcye/7mbGltoZ98aken7lT24sao6c4Rm9UjXSnjL8YGRpmQ07fZcXtZ4cO7tfSw6I7hGi9RmcDPIbnd/PlEeh4YKPlMxuOt41fXCTJ5sXBXdkrsT1KDsMHFcKNE=
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id ll9-20020a170907190900b00a3d125b9c0asm16659ejc.81.2024.02.12.21.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 21:38:00 -0800 (PST)
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
Subject: [PATCH 1/3] arm64: dts: mediatek: mt7986: drop invalid properties from ethsys
Date: Tue, 13 Feb 2024 06:37:37 +0100
Message-Id: <20240213053739.14387-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

Mediatek ethsys controller / syscon binding doesn't allow any subnodes
so "#address-cells" and "#size-cells" are redundant (actually:
disallowed).

This fixes:
arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dtb: syscon@15000000: '#address-cells', '#size-cells' do not match any of the regexes: 'pinctrl-[0-9]+'
        from schema $id: http://devicetree.org/schemas/clock/mediatek,ethsys.yaml#

Fixes: 1f9986b258c2 ("arm64: dts: mediatek: add clock support for mt7986a")
Cc: Sam Shih <sam.shih@mediatek.com>
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
index b3f416b9a7a4..228e02954e85 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
@@ -492,8 +492,6 @@ ethsys: syscon@15000000 {
 			 compatible = "mediatek,mt7986-ethsys",
 				      "syscon";
 			 reg = <0 0x15000000 0 0x1000>;
-			 #address-cells = <1>;
-			 #size-cells = <1>;
 			 #clock-cells = <1>;
 			 #reset-cells = <1>;
 		};
-- 
2.35.3


