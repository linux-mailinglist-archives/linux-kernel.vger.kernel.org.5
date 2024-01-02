Return-Path: <linux-kernel+bounces-14254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5887E821A05
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 11:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04D021F226E5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 10:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8104FDDA7;
	Tue,  2 Jan 2024 10:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="M6FRHFMn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B716D507;
	Tue,  2 Jan 2024 10:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704191886;
	bh=M7Xvx7dEYV5/Uj992gYqxQaLymoVlWi/PbPy7cgkjUQ=;
	h=From:To:Cc:Subject:Date:From;
	b=M6FRHFMnNf101tyVbQwluru0ACn738DHhwyLERK/KmF+dRrs3xYWo9tKuyPw82ufs
	 hLrbXcwc6ZO6rSlEITpP1N7DgnlNSPTLjG4V15Hxsf8bvtwVvrzYPaZOvDDgdkIonl
	 3j8wFrj8yUD6dwdebN/gQU0zLXcD/7eQuI2cbEF7jvfbSYT1dw9hTPr7QD3wl7J0lI
	 tySu70fkNZN/s0cTU6TjsuNAOd24aJmBSfpH6vGb82ImrZGVxIaQ+F432LnfhGz3jz
	 y6GnyphNK7onHffNSkBT5ncqUVx0cMVgxsRfUM6it7WLur1Gu1NaM9lWAibZNII945
	 lD4i5HpdeyuOw==
Received: from eugen-station.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id BD17D3781FFA;
	Tue,  2 Jan 2024 10:38:05 +0000 (UTC)
From: Eugen Hristev <eugen.hristev@collabora.com>
To: linux-media@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	bin.liu@mediatek.com
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	angelogioacchino.delregno@collabora.com,
	kernel@collabora.com,
	eugen.hristev@collabora.com,
	matthias.bgg@gmail.com
Subject: [PATCH v2 1/2] dt-bindings: media: mediatek-jpeg-encoder: change max iommus count
Date: Tue,  2 Jan 2024 12:38:00 +0200
Message-Id: <20240102103801.268647-1-eugen.hristev@collabora.com>
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
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
Changes in v2:
fixed typo in subject

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


