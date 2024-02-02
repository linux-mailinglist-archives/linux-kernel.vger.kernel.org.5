Return-Path: <linux-kernel+bounces-49786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA6F846F63
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 695B11C22A2E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A5E13E228;
	Fri,  2 Feb 2024 11:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="wAuE95Fe"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7155FDC3;
	Fri,  2 Feb 2024 11:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706874510; cv=none; b=OQuhmp13fANFx73fb+SfQVZtEPWiOlyhyCpPcVvSm2b+5EQ8wJXVv0YZk4Eb/L3q5ikNIFGA1aHsDCpJV7VIRFwr7WImh2UdvHvRRz/wzH7hkfEqpN7RmytzPdLv8AnrDTuvh4DCN0qe2ZtaYAEeKYS+P88Ny35r/QDfK6rRuII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706874510; c=relaxed/simple;
	bh=jOBNaj2dKnYfO4IjqztTr2cvYISm8hQDlE/7wryo+2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=raoUMMURBLaiH4Y8BDpB55EkXKCzs+rOjyxWzhOei21P3KKUiqThX2kMWjqoI8HEyA3y1O6nCAHabdZrekyAZ1fS4ZyRmE8vJe4uMR+wSumPJcqb/HLFFpmyxfgr89lhHe44VpCU/vpB1jndRYbF+kZ1BiLt9It3zbqpphNtGIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=wAuE95Fe; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706874506;
	bh=jOBNaj2dKnYfO4IjqztTr2cvYISm8hQDlE/7wryo+2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wAuE95Fek4y1oOi1S7Oh4emT68MyEpuhsKzoCCZuX55c7Eag9J78gRoTwh2iFlKbk
	 Okh//gWossyB9wJktKvwaoYEvXT5u0UTLCucVGOMyfyQ8T+p4zDP2twglU14f+vYVl
	 q6q+hBBrDmz01P3hn5AJfZ8uljFMVRd2s+SMVD1dfBzRqn8gVC0GoB0JFyMTJohFeD
	 7thODRLeAXqUI/0Rv0XWGl1PKBK1ceXjtXCfbF37qARx26uc/Ux2i5Bwm+ixLYddfL
	 QQz2YKo2Dpf4KWuMuDH1dNOOiIVuV/VCyld+anagfdrTLs+yASB6s5gGGHjIiVic4R
	 N2Yrros7+9hxQ==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A86263782093;
	Fri,  2 Feb 2024 11:48:25 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-mediatek@lists.infradead.org
Cc: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	wenst@chromium.org,
	hsinyi@chromium.org,
	nfraprado@collabora.com,
	macpaul.lin@mediatek.com,
	sean.wang@mediatek.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com,
	stephen@radxa.com,
	tom@radxa.com,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 1/2] dt-bindings: arm64: mediatek: Add MT8395 Radxa NIO 12L board compatible
Date: Fri,  2 Feb 2024 12:48:20 +0100
Message-ID: <20240202114821.79227-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202114821.79227-1-angelogioacchino.delregno@collabora.com>
References: <20240202114821.79227-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a board compatible for the Radxa NIO 12L, based on the MediaTek
MT8395 SoC.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 6f2f64ae76fc..168538887fee 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -287,6 +287,7 @@ properties:
       - items:
           - enum:
               - mediatek,mt8395-evk
+              - radxa,nio-12l
           - const: mediatek,mt8395
           - const: mediatek,mt8195
       - items:
-- 
2.43.0


