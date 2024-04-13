Return-Path: <linux-kernel+bounces-143769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B22208A3D35
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 17:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BAC7281DE7
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 15:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D685F482D7;
	Sat, 13 Apr 2024 15:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SO+4uYcw"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0625647F45
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 15:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713021405; cv=none; b=rapxjo7vP3eg6rqTPlBb+BSBEj1sB8G3umyRJgjWWSPv2JJabctotN0Y7qAUOvW6z68IAppth/S25shksMuyo9RK/W0ozWaV6sAaV+EZa3mDWh4teU+AX5nq7ONgjs7vPYpPdtqtOM1JHW/J+MUSAX9LF6gEcsHy/UrqQTHPgyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713021405; c=relaxed/simple;
	bh=hH/i56/VVMXc5h7IY9kB8GOOP4BZo9JkA0T8zeB0y1M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pCqEgb9D4SBmh62IK3x5MHFW5jJJiJ77zJFlEhBQqjLqyifTHOc7gRus8Ag10FbkfXkhodoGbWn16Xg1twGlE/FUCVKJMMF9z4cIaFedoVhGTkMjXPtGxkJZI4SEQMg9NYkxRKncFqKq/FVfM1MSBp8cVP0WNn8JSu75pNcWUA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SO+4uYcw; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2da01cb187cso32209391fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 08:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713021400; x=1713626200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3KLUzTPW+KpN4IRI1ic6uWm66ErzBdD1Xi0Bbn1RRvE=;
        b=SO+4uYcwgRmR13xE9xpgbjeLoTcy2dS9rLlXQ4iT0DCVUisbhVTPemX8ehvEMZ3foT
         lOlCCZU299HCe6mm/AmTFLZFKa41W16TbBLBK49PCbJMbLb8ydiuCywSA30abNmKv0sy
         D98+s49v4V43n+KWWpMvP3ip9Kp1xR9eXol1hY6/eivWTb1wIiirh/9DWsaLIAXYuIZr
         ko1mDWsz8s8Xa5lgCwtQlWZVg+ZYKD7aMxwP+WoVsYDIdCCeSKiD/ROaPlZ/E+rrfhPu
         rwIaRSn1iJ9h9cc4sNtFrs77Y24roJQQTsnGC5J+lxzjDf/zbSYu63aK+MNwRS+LY5Xb
         UmQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713021400; x=1713626200;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3KLUzTPW+KpN4IRI1ic6uWm66ErzBdD1Xi0Bbn1RRvE=;
        b=wEC3hTYygToRow1CVn2Um0tKRZoURVvEFGvLSeI54yvg9X4LOiZWHjVMeIZRNj3IKC
         BG/NjSDWiUWZUv+w41UYVziwi1toY7Lwq0+nTcjDbWj5rTWZMs7TG8veyoiEQzAyIRHq
         UjJoBYCs02hnJER/eQL9OhORXpliE0eYUTP+as2pLy8jYdy97EgP+4Jqq4LesapRYxil
         a0qe6sd45/1wswJV+wOLSFWy82o/W+WFoJj5xdc68UBGZdcN9XVIvyxrd4bGtIa+cxHM
         nsD7iomxPXVQrEq7renfTtni0UODqZ0efhiYwTtE3XqqpSUeeSwMxly+0Zv/SxCYZl99
         micQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQPuSb9cF3IQaPyu1eJaGdUFkXWBCrBu6qFn7YOzPJSFk1ggG8No2D6KO9WXcXw+IdP14tJN3H7w+idYhkvfQf9OmX1DyiwGaH0DHm
X-Gm-Message-State: AOJu0YzQX3xwIf5f3oIeHfC9ZZ9t6L8b9LekVj7ludS0rjaS1NXJ7Buy
	ofYz2RU3Jg46mKqhUSRXlQ0bZ4nlZYmJrph02KaiHTzprR3xeDwMgR2BHtWZArM=
X-Google-Smtp-Source: AGHT+IG1tNnKVrVnl2J/+j+UL2Wl4h4NMws2XRL9Lu8vXwFs1VUku2GIOwL+IkYjq0NdIfadi6221Q==
X-Received: by 2002:a2e:9ed4:0:b0:2d9:fd90:af57 with SMTP id h20-20020a2e9ed4000000b002d9fd90af57mr3723839ljk.51.1713021399920;
        Sat, 13 Apr 2024 08:16:39 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id kj15-20020a170907764f00b00a51a60bf400sm3104956ejc.76.2024.04.13.08.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 08:16:39 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Will Deacon <will@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Srikanth Thokala <srikanth.thokala@intel.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Sergio Paracuellos <sergio.paracuellos@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Mark Kettenis <kettenis@openbsd.org>,
	Tom Joseph <tjoseph@cadence.com>,
	Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/4] dt-bindings: PCI: cdns,cdns-pcie-host: drop redundant msi-parent and pci-bus.yaml
Date: Sat, 13 Apr 2024 17:16:14 +0200
Message-Id: <20240413151617.35630-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The binding reference common cdns-pcie-host.yaml, which already defines
msi-parent and has a reference to pci-bus.yaml schema.  Drop redundant
pieces here to make it a bit smaller.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v3:
1. None

Changes in v2:
1. Add tags.
---
 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
index bc3c48f60fff..a8190d9b100f 100644
--- a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
+++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
@@ -10,7 +10,6 @@ maintainers:
   - Tom Joseph <tjoseph@cadence.com>
 
 allOf:
-  - $ref: /schemas/pci/pci-bus.yaml#
   - $ref: cdns-pcie-host.yaml#
 
 properties:
@@ -25,8 +24,6 @@ properties:
       - const: reg
       - const: cfg
 
-  msi-parent: true
-
 required:
   - reg
   - reg-names
-- 
2.34.1


