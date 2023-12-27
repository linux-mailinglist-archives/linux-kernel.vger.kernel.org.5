Return-Path: <linux-kernel+bounces-12029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2C081EF12
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 14:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C06971C21217
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 13:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697A244C93;
	Wed, 27 Dec 2023 13:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LE8nW6o9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493EC44C62;
	Wed, 27 Dec 2023 13:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703682501;
	bh=jvUeOk62psQZsbMdkKVZNNNG5A+qB2Z6aEW45S/4p1Q=;
	h=From:To:Cc:Subject:Date:From;
	b=LE8nW6o9iLpxjsx2UDxC4w8bFvUiqBCbUaSLGN2QHFcV7Wvo3xQgjPQXLOdfJxYC1
	 e9razMUHVWO2kNDJZJA8djvpDFNJdNPgGKJ15oohl2rupU12EPGneHtvm2rwuFT8Un
	 iRw1ay/k+rjsCP6nc0VtHVpc3LA3yA+IKVdVMGvRSTKboJqy4FuEs/LqjTZ0WgV3zG
	 l2x3agZGwT7bEJ2muGWT+J2QP8ykOAGZqxQbQqLnL9ACZKfiHIEl72DcudVTqXklKV
	 ck7km5lP3naUFlSAOTHnnKSgHLKfGHnzOS6YAfbVP0Elw9NUjOydzd6cDkRgJXWC4E
	 MdXJdsUQdV6Tg==
Received: from eugen-station.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C56A237801C1;
	Wed, 27 Dec 2023 13:08:20 +0000 (UTC)
From: Eugen Hristev <eugen.hristev@collabora.com>
To: bin.liu@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-media@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Eugen Hristev <eugen.hristev@collabora.com>
Subject: [PATCH 1/2] dt-bindings: media: mediatek-jpeg-encoder: change max ioomus count
Date: Wed, 27 Dec 2023 15:08:11 +0200
Message-Id: <20231227130812.148914-1-eugen.hristev@collabora.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MT8186 has 4 iommus in the list, to cope with this situation, adjust
the maxItems to 4 (instead of previous 2).
Add also minItems as 1 since iommus are mandatory, to avoid warning
on the example.

Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
---
 .../devicetree/bindings/media/mediatek-jpeg-encoder.yaml       | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.yaml b/Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.yaml
index 37800e1908cc..60c75b9312e8 100644
--- a/Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.yaml
+++ b/Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.yaml
@@ -38,7 +38,8 @@ properties:
     maxItems: 1
 
   iommus:
-    maxItems: 2
+    minItems: 1
+    maxItems: 4
     description: |
       Points to the respective IOMMU block with master port as argument, see
       Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml for details.
-- 
2.34.1


