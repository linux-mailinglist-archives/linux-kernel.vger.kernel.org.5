Return-Path: <linux-kernel+bounces-14818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFB28222CD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 22:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35CC4B20EE3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 21:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0DE16432;
	Tue,  2 Jan 2024 20:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QgLktwFg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D2C1641B;
	Tue,  2 Jan 2024 20:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a26f73732c5so650378766b.3;
        Tue, 02 Jan 2024 12:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704229189; x=1704833989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jlB0PUG7evATLc0OuzKEpt6MawbG9iqAg7BGZuj7pfo=;
        b=QgLktwFgVcUMbmLOrroJ7i4iOOQuZigCS1YeCiZ8FfI1VQTEMrmU321o6a7E4t0tSY
         cztEqSWn01E0dF+Tn1B07tia/9y8dJ7MvAg73V5EVtKQgFDu0Sg7o1hYv1VgozEhR5qx
         vAspTFCIim3294Yd4wDgmOeordUiGhSr7JKyN+uU+9lLOrDNganT1zrTR1DhnCxkApU+
         sGTNm87cnWcpJ1fqE8uFMKg/TCOroQDVChj0o6rsyGiIhPXW0L9UbSX1RXkniI0nH/Dj
         VUdyMyXMiZGSWNczTDOMsCIObh6J6ZJsh/69/U4zo1j4eATAoBNCP2LEma7gfyLMx7vQ
         hclg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704229189; x=1704833989;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jlB0PUG7evATLc0OuzKEpt6MawbG9iqAg7BGZuj7pfo=;
        b=gjrKnG9PpCS4gYDAtzp4Dj5K63UT4icw7w+BTgnhZ844eQ0bAoZZxzg1/49PPsflqW
         TP1wcZCifPIUXUQtEKQCK4qgZtYvnQZDabokr30++7LN1X5LjpHQqOElQNPj+18tAY4V
         NtXI3V5Tew2DQLNscpY8uS2HGekSL57RkY/rQhtI+zCsPEdlw+RRLn0QiOMByEzP6Sf9
         ScwC87s9gFxbxG6xwt7p0VOi7c3f3FSBBxBUVUXhyMUVvyWuYG21sR4ak9Fio28VRNSA
         7PtCfIK2WoK3Zc5c/DYZfzYIAUCaXc9gwj+Gdzw84d67406o6+yUz95OBrmuFTz+Tf3h
         VnPQ==
X-Gm-Message-State: AOJu0Ywp32lSvZqmMlhiXjFlhnRP3j4FlzwZcy/jGw1MEayXtai3dMF+
	yRjjsXrayePkARuXf0ythQE=
X-Google-Smtp-Source: AGHT+IEZDtyjr3TDGl71MjIXeUnjOYvve+ifXX/rtGtFSzaJ2n4S8WtkBLuo7hGh0LPIgO2MSMlsUw==
X-Received: by 2002:a17:906:3987:b0:a28:2374:f39d with SMTP id h7-20020a170906398700b00a282374f39dmr1156014eje.50.1704229188691;
        Tue, 02 Jan 2024 12:59:48 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id f15-20020a17090660cf00b00a26f66ce72fsm7941200ejk.83.2024.01.02.12.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 12:59:48 -0800 (PST)
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
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 1/2] dt-bindings: arm64: mediatek: Add MT7988A and BPI-R4
Date: Tue,  2 Jan 2024 21:59:40 +0100
Message-Id: <20240102205941.29654-1-zajec5@gmail.com>
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


