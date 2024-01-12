Return-Path: <linux-kernel+bounces-24692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A8282C0E8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 14:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BCE02871D8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 13:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2066D1B0;
	Fri, 12 Jan 2024 13:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="d8e8vYat"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274ED5D91A;
	Fri, 12 Jan 2024 13:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705066350;
	bh=a3smX73X/DO4mpCygf5S67DyKKn/F9+tabtj3srXY1o=;
	h=From:To:Cc:Subject:Date:From;
	b=d8e8vYat6IVxhJU0Nb1ligWNmsdgMgpmSW4Ig5CFnXPLLC/dxKs/kRFHjU3rF5WrJ
	 AQSIUPLG4cWI6M1Boj1UttPt+XvcuUe69jfWbxVj48PXRLqrJSBNo8ehDnCsDt4jNG
	 Cxd6SKa/5zOkhWqIaQoht8O/XzisZwFHrPhFXcSM9x14SgGiVPgqgD3yVjC/abrKHr
	 lGfxygNCxRZOnvgtVJWz/ebCmLUhsciRF9IMFhuRDu81oDJkT5JxfQVJgjmVIwIqoO
	 oWXGQQfDNkx2X0hGUK+pnx2YYt7A1qfud8lobobtNsEeVJjSvxw3EgHtVzFgpJ1nji
	 HMivCm+jberMA==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 939E53781FE5;
	Fri, 12 Jan 2024 13:32:29 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: chunfeng.yun@mediatek.com
Cc: gregkh@linuxfoundation.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com
Subject: [PATCH 1/2] dt-bindings: usb: mtu3: Add MT8195 MTU3 ip-sleep support
Date: Fri, 12 Jan 2024 14:32:21 +0100
Message-ID: <20240112133222.240038-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Of the four USB controllers present on the MediaTek MT8195 SoC, three
of them (0, 2 and 3) are behind MTU3: add wakeup controls for them.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
index a59d91243ac8..d4e187c78a0b 100644
--- a/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
+++ b/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
@@ -185,7 +185,10 @@ properties:
             2 - used by mt2712 etc, revision 2 with following IPM rule;
             101 - used by mt8183, specific 1.01;
             102 - used by mt8192, specific 1.02;
-          enum: [1, 2, 101, 102]
+            103 - used by mt8195, IP0, specific 1.03;
+            105 - used by mt8195, IP2, specific 1.05;
+            106 - used by mt8195, IP3, specific 1.06;
+          enum: [1, 2, 101, 102, 103, 105, 106]
 
   mediatek,u3p-dis-msk:
     $ref: /schemas/types.yaml#/definitions/uint32
-- 
2.43.0


