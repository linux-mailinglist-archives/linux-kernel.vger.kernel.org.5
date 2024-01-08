Return-Path: <linux-kernel+bounces-19213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BF88269DB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 365271F22EC7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 08:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C47210A19;
	Mon,  8 Jan 2024 08:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTi7ScsO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032C1C148;
	Mon,  8 Jan 2024 08:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-557a3ce9942so858977a12.1;
        Mon, 08 Jan 2024 00:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704703969; x=1705308769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jlB0PUG7evATLc0OuzKEpt6MawbG9iqAg7BGZuj7pfo=;
        b=YTi7ScsOLPtqlozbLjGkMrr8H63Qz+pFvAGka5Y9jjmJ8KqUEDqXnO+7lj2SMxKhiU
         xKTndhH1mrhCyAPGV5ID5pRIgHIGfW3Cz5IyBeTNLAaLvAwf6jv9DRUBIFPxe5hLDeDA
         UjYIVCit9BBoVVbh/e8kDVslXxv08K5JiIoShwl1bSBmMI6UbotlN+K21Oq9C6h+fTLO
         ua3dmxYFgINAiO2+NtaDEuRSmKQjeScHbpEJoTplb7Kix7I1U4kXx79eYYL8I5uqnJP6
         2mVWNf8FL8wYJbD2xQdXN5bDqq/BqjWrM9ApHIlPXTVjjDSa6mowGSo/f3l8tp9wch5y
         9KwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704703969; x=1705308769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jlB0PUG7evATLc0OuzKEpt6MawbG9iqAg7BGZuj7pfo=;
        b=FfAJxPs3rvpUWxsSdmMQW8bzG2wuZJwXbtiURil1COK76sjNgM1mT0UY9PdD3pUaNQ
         4lYWdHJkKVnmuJ0Lxc3FrRXd5J1Gm32DWYbk3VxvHNEpZjRAkSBBb4lGL5PrZq6RWcmv
         EhSqt6ldhxt2z+KwZAvyH8PLbyHdSZfie2Rc7K+CBtHkF6SMfdhR8zwRikWYUgzQKOWM
         IhHJzep+PCkLdcSZLnSG5+1catxfNeeFhQ4jgK6jOOTovfrSkRKw9CBPL+uvP8ILXwUN
         FH1ZukfzA/i7g9EKGiD1O1acM0MX3FwwkUVHBq8albOWNZwCTjxVfW+3G65/qG7fxyY2
         FKhw==
X-Gm-Message-State: AOJu0YwVfQpw9F/QXa79N2E43lDQD+x9QdJuI548EZpgHqvGkke7n16d
	OkFmARcX01xaX0hs6mWY6RS8CLBa7IU=
X-Google-Smtp-Source: AGHT+IGHmo2J4TCjtP36Ih8IdoN/1+GtQ55zi956x1gcSfvBrvHy+Bba5xv0qyV93l2ShK/wS6etmw==
X-Received: by 2002:a17:906:f919:b0:a2b:94d:1370 with SMTP id lc25-20020a170906f91900b00a2b094d1370mr3187ejb.91.1704703969068;
        Mon, 08 Jan 2024 00:52:49 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id uz29-20020a170907119d00b00a2aae23b414sm666046ejb.26.2024.01.08.00.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 00:52:48 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Daniel Golle <daniel@makrotopia.org>,
	Hsin-Yi Wang <hsinyi@chromium.org>,
	=?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= <nfraprado@collabora.com>,
	jason-ch chen <Jason-ch.Chen@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	=?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Frank Wunderlich <frank-w@public-files.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V2 1/3] dt-bindings: arm64: mediatek: Add MT7988A and BPI-R4
Date: Mon,  8 Jan 2024 09:52:26 +0100
Message-Id: <20240108085228.4727-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240108085228.4727-1-zajec5@gmail.com>
References: <20240108085228.4727-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

MT7988A is another MediaTek's SoC with just 1 device available right
now: Banana Pi BPI-R4.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 6f2f64ae76fc..92dbfb862757 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -91,6 +91,10 @@ properties:
           - enum:
               - mediatek,mt7986b-rfb
           - const: mediatek,mt7986b
+      - items:
+          - enum:
+              - bananapi,bpi-r4
+          - const: mediatek,mt7988a
       - items:
           - enum:
               - mediatek,mt8127-moose
-- 
2.35.3


