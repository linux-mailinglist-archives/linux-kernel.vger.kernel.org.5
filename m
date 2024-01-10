Return-Path: <linux-kernel+bounces-21921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1310482969D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25FFD1C23B65
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 09:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697523F8CC;
	Wed, 10 Jan 2024 09:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXOxy+al"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7F5E560;
	Wed, 10 Jan 2024 09:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a277339dcf4so430120866b.2;
        Wed, 10 Jan 2024 01:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704880312; x=1705485112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WUzltDE1SVp4NPPJmaVgEfCYBki5uY9woZvLrnlkkZw=;
        b=NXOxy+alh8tv/JyPvYZUrdNVKRUL2nUTuuBL06NfWbuzgsxrsZKt3eGvVmpyEmeqQi
         4TyB7qSamR9uPOlV1fHYT0bmcFRdPXxPy3ixLCmG2H1G82Cs+NuFw5dN+rS/KCyikGrP
         OeNIfA669XiwV5zXVjTjwQhKkJ0ncWyf97W+nMXORmnunb2s4YjcpogslNA2iUpBN3iw
         BbP0ki9+q/eigTMearHZYUWPZ2QQgnTauoFwF2bmInvcmIkhx+bevG+Id01Z0QK2Z8lp
         ZSMIwF1TdisFfVK38s/4ISwnELKqLbMlrjC9tKL4tCBuy1CGIH7Obs9lEM+HKVp3q8Aw
         cEKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704880312; x=1705485112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WUzltDE1SVp4NPPJmaVgEfCYBki5uY9woZvLrnlkkZw=;
        b=ocmH8ypyJDQuHKYGvV+rOErmb143LKTBO/Y483gsN6rM8itDzvhQUKUwjxChVn9QFv
         LdzQRGvC4C7zsJI1NAB0NHb0HjXsAw84Gya5GoYUb7F2hyTjbIKDFYDXfYEdZYFwJ2cg
         U5uX3nwnrpeZE54Pb+J+zi9ojLQM6Ut81rxNukjsKD+S2YdnJFUag62Rl3fWN5Fx/vH3
         qSb1O/qtS7/403lM8xAOca4jqfHaRSP8+4glRoxQ9zFGChLhnoYDtkahYlp4E0tpkd7N
         jMb1oFztncjoUee62q+9febR1w6mLawOf1Uw5hY26OJaQ/CqDA5VJ6LQMV/xBMBwBVyt
         m8xw==
X-Gm-Message-State: AOJu0YzGS5z5XQ86UuNtTdK1fq0V5mdMl66ePD3T/Xe3OT/rzPCMLCsO
	zCnnlYqxrcM+An2dVIazGxE=
X-Google-Smtp-Source: AGHT+IGhH4RtbLFmC4kd1ULInhm5JRCwhjv8vz5K7Yp73wmHntuJM1qcu9oXtISgYuTWG/FPO4OqUA==
X-Received: by 2002:a17:907:320c:b0:a27:47a9:ec85 with SMTP id xg12-20020a170907320c00b00a2747a9ec85mr583983ejb.98.1704880312074;
        Wed, 10 Jan 2024 01:51:52 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id c24-20020a170906529800b00a27aabff0dcsm1947617ejm.179.2024.01.10.01.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 01:51:51 -0800 (PST)
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
	Sean Wang <sean.wang@mediatek.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 1/2] dt-bindings: arm64: mediatek: Add MT7981B and Xiaomi AX3000T
Date: Wed, 10 Jan 2024 10:51:17 +0100
Message-Id: <20240110095118.25598-1-zajec5@gmail.com>
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

MT7981B (AKA Filogic 820) is MediaTek's dual-core ARM Cortex-A53 SoC.
One of market devices using this SoC is Xiaomi AX3000T.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 92dbfb862757..12cf02b30967 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -82,6 +82,10 @@ properties:
           - enum:
               - mediatek,mt7629-rfb
           - const: mediatek,mt7629
+      - items:
+          - enum:
+              - xiaomi,ax3000t
+          - const: mediatek,mt7981b
       - items:
           - enum:
               - bananapi,bpi-r3
-- 
2.35.3


