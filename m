Return-Path: <linux-kernel+bounces-12613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D186B81F7C1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 12:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D4E028720A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 11:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFEBE57A;
	Thu, 28 Dec 2023 11:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="P/Txb1Jl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FED58829;
	Thu, 28 Dec 2023 11:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703763179;
	bh=1fDv/5V6e9fx+iroantkLNTc4mnm6R4J0fjeEoEc4gY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P/Txb1JlYklMHWMqG5aL1Rd6kvgcuOFKWHiJPZb2JM9vbOVhLzip4crXixn6QzW9f
	 0GD80b2W55XA+b1YY/FSIrSYlMBqWai6uxlxWh6zquqIaVFSb9UcTB/1he33Ecjs8G
	 CCd+ApnsTMfWVQP+sMYDRwOpngI7oPH7ZNVOUnflTxoGJVDQ5/SetHH8vQPJLA4yBy
	 R4I4SrQ33x5cSHDxi28A6FuRLJzL0NwZWR4l1zZBCcGkwjUeJDJrdvJIr5nC1RHtEY
	 PGeKgHQxzc8zk9cIUvT08vnxbmhlT8nKOq14ZZnffXrvkUfmXD0nkQ10eCEqGtLapA
	 Iy0zYYJjIL9Kg==
Received: from eugen-station.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 05F3D37813D0;
	Thu, 28 Dec 2023 11:32:58 +0000 (UTC)
From: Eugen Hristev <eugen.hristev@collabora.com>
To: tiffany.lin@mediatek.com,
	andrew-ct.chen@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-mediatek@lists.infradead.org
Cc: eugen.hristev@collabora.com,
	linux-media@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	robh+dt@kernel.org,
	kernel@collabora.com,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v3 4/6] dt-bindings: media: mtk-vcodec-encoder: add compatible for mt8186
Date: Thu, 28 Dec 2023 13:32:43 +0200
Message-Id: <20231228113245.174706-5-eugen.hristev@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231228113245.174706-1-eugen.hristev@collabora.com>
References: <20231228113245.174706-1-eugen.hristev@collabora.com>
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
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes in v3:
- collect R-b
Changes in v2:
- new patch.
 .../media/mediatek,vcodec-encoder.yaml        | 20 +++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
index 849721c0571a..b45743d0a9ec 100644
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


