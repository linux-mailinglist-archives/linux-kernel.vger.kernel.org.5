Return-Path: <linux-kernel+bounces-777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85EC18145E8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2598F1F2360E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FD624A18;
	Fri, 15 Dec 2023 10:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="tI07Sy1t"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C9A1A711;
	Fri, 15 Dec 2023 10:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1702637165;
	bh=Sv5bStRniU7BlQ2lH9mBsZ8VDZEclT6+b2lYCvkM7yU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tI07Sy1tbkkyJC92kNuBzpUFvGbbH845ZXpo/Qo15BSqjgRDo0ZDSqIJuLWLl4pcw
	 lWp75z2xZjLU+JWhEC7Xcvs8V6oAR3Gr3lb9zjGySN1VA1yYJN1pfC81eBRpZ8QXQK
	 Mm4bQWvHEP/epNMd/kAp3cY+kDM5BU0WiFKiinomSJqysURg5M+jSPWvx8cEu5wYE8
	 Av2Lkfl5K/KCa87lrF396h73z1xtmlzNwubZ2G3Vq7DxKhLdk+toFfLaQbkCj2TEg9
	 82QrCctaJBsmmTMZKsCSJnCTyMPTcZfhUr2xqsC+Por97/hK3msX6JnxsnTOWz0bWW
	 qFXmmp3dB6lHw==
Received: from eugen-station.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B198F3781FD5;
	Fri, 15 Dec 2023 10:46:04 +0000 (UTC)
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
Subject: [PATCH v2 2/7] dt-bindings: media: mtk-vcodec-encoder: add dma-ranges
Date: Fri, 15 Dec 2023 12:45:46 +0200
Message-Id: <20231215104551.233679-2-eugen.hristev@collabora.com>
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

As IOMMUs are supported, dma-ranges is not mentioned but
additionalProperties=false, thus we have an error when adding dma-ranges.
Add dma-ranges as a possible property because this may be present.

Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
---
Changes in v2:
- none.
 .../devicetree/bindings/media/mediatek,vcodec-encoder.yaml      | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
index a2051b31fa29..403530de5624 100644
--- a/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
+++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
@@ -38,6 +38,8 @@ properties:
     minItems: 1
     maxItems: 5
 
+  dma-ranges: true
+
   assigned-clocks: true
 
   assigned-clock-parents: true
-- 
2.34.1


