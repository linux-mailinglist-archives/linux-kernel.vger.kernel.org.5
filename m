Return-Path: <linux-kernel+bounces-780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC328145F0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77978B22A5C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6A42C683;
	Fri, 15 Dec 2023 10:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VGwLRoad"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3027D24B46;
	Fri, 15 Dec 2023 10:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1702637168;
	bh=oXswsuW1anVDQblcp1XlaqlIZub/1g335nE50zD4/kU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VGwLRoadvlKFpw29V4QaM/mr5XBEqcnnxpzWyA7o+qpLCSFEiY9+qxBn1LO6uWmpJ
	 keLPBznLC99dLayG8ywwlErBJL07Vz3mIwXGbK+j+EtigulikTMppMCuBpdMr90zQz
	 qyeHO5HmT3ujs8QqmStlDrxczx3Z0jre+6cMI5nFzqBg1WyJo75LMVsP4tJOQ7Miw3
	 lFcVicD+CW0Cl2h8VgZdUyUWUy0M4s1bL2wiEoVW/WtI5ULZ5kjyAqsdHe9ky6EQH1
	 YjQ0zLUQzGKZO0rxx0QHNFv3ZGXEan050MO6n8TeSXXz6TrDSjf6fi3ZOFgs0+lEvu
	 gFOxjUHq1ve2A==
Received: from eugen-station.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C16F73781FD9;
	Fri, 15 Dec 2023 10:46:07 +0000 (UTC)
From: Eugen Hristev <eugen.hristev@collabora.com>
To: linux-mediatek@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	angelogioacchino.delregno@collabora.com,
	matthias.bgg@gmail.com,
	linux-media@vger.kernel.org,
	tiffany.lin@mediatek.com,
	andrew-ct.chen@mediatek.com,
	Eugen Hristev <eugen.hristev@collabora.com>
Subject: [PATCH v2 5/7] dt-bindings: media: mtk-vcodec-encoder: add compatible for mt8186
Date: Fri, 15 Dec 2023 12:45:49 +0200
Message-Id: <20231215104551.233679-5-eugen.hristev@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231215104551.233679-1-eugen.hristev@collabora.com>
References: <20231215104551.233679-1-eugen.hristev@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add compatible for the mt8186 encoder which currently works in the same
way as mt8183.

Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
---
Changes in v2:
- new patch.
 .../media/mediatek,vcodec-encoder.yaml        | 20 +++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
index 5166c1c6934e..dfabc2faea6c 100644
--- a/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
+++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
@@ -16,14 +16,18 @@ description: |+
 
 properties:
   compatible:
-    enum:
-      - mediatek,mt8173-vcodec-enc-vp8
-      - mediatek,mt8173-vcodec-enc
-      - mediatek,mt8183-vcodec-enc
-      - mediatek,mt8188-vcodec-enc
-      - mediatek,mt8192-vcodec-enc
-      - mediatek,mt8195-vcodec-enc
-
+    oneOf:
+      - items:
+          - enum:
+              - mediatek,mt8173-vcodec-enc-vp8
+              - mediatek,mt8173-vcodec-enc
+              - mediatek,mt8183-vcodec-enc
+              - mediatek,mt8188-vcodec-enc
+              - mediatek,mt8192-vcodec-enc
+              - mediatek,mt8195-vcodec-enc
+      - items:
+          - const: mediatek,mt8186-vcodec-enc
+          - const: mediatek,mt8183-vcodec-enc
   reg:
     maxItems: 1
 
-- 
2.34.1


