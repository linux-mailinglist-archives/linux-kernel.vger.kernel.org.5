Return-Path: <linux-kernel+bounces-41118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 161B583EC18
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 09:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 483331C2187E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 08:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C331E874;
	Sat, 27 Jan 2024 08:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="p0X6hNJ0"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7281DDDA;
	Sat, 27 Jan 2024 08:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706344995; cv=none; b=RCOGjPM60aYw45ww0QJxGcH7i/X48vIohwZNWE+e4APEN64/nsEbr2OqfGe2NKLN4XZ3MfBlAqoaITOtz2kD9WeKAfoKA50bnCGWA7Xl76gjxojRXfJWNZzMv0CgbORoKG4naGJU/VchqF3izcOU0iwHgDFZDe1jMJBQNaZdGro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706344995; c=relaxed/simple;
	bh=8dRsLzcjxuiEqHzBiXW/6CBdzTfn9KdLsULhFxOyGP8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZGwyCfhAWayt2rFSK0ZeSaJ4C5uU2Ml9QFQZo8LXo5jL99l9rjTBbBdTvUQTdTxXkD26xTTWNAHf4Fpo+TcY6sqekCg/hSVbUT2wjhTCyiWytfTRwfLC6hQIdv07IXclZJKnQPCGluFZUrHORmZHYYrhVIVNubPnI2af5S2cJNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=p0X6hNJ0; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706344991;
	bh=8dRsLzcjxuiEqHzBiXW/6CBdzTfn9KdLsULhFxOyGP8=;
	h=From:To:Cc:Subject:Date:From;
	b=p0X6hNJ0/FNbHA3OoNK9VWsNQk1wTfyIk7rVN5WxanigwvN3uMMNOy+NbhOFePM+Q
	 f3oG0AhM7w4NI8jCaIJjZKVgeapnd4i2FDK0z+TUH1WpLYmV6bsAnm1h8HgiabB9qB
	 YmUB7LAN/0ZfJWFcX9y4XAeBTue3leCepR5Z2/9frosmd+l1cqEu1r2zOQEPFhdt1r
	 4/Yq2e6rdDMZgG6xxC9XzAEDeHg+4fa/68DtBZkeCPk126eyb6qeIpbhCbQlI1hb/u
	 rMi4WKI61iFLIM0poe6SqENgedUxqXHar+CMB3MuAGXkx0mIcTS+F/6TTVdDkSCG38
	 29WBSqkdpARVw==
Received: from eugen-station.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 21F1D37809D0;
	Sat, 27 Jan 2024 08:43:07 +0000 (UTC)
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
Subject: [PATCH v3 1/2] dt-bindings: media: mediatek-jpeg-encoder: change max iommus count
Date: Sat, 27 Jan 2024 10:42:57 +0200
Message-Id: <20240127084258.68302-1-eugen.hristev@collabora.com>
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
Add also minItems as 2 to keep compatibility with current devices.

Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
Changes in v3:
minItems changed to 2.

Changes in v2:
fixed typo in subject

 .../devicetree/bindings/media/mediatek-jpeg-encoder.yaml       | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.yaml b/Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.yaml
index 37800e1908cc..83c020a673d6 100644
--- a/Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.yaml
+++ b/Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.yaml
@@ -38,7 +38,8 @@ properties:
     maxItems: 1
 
   iommus:
-    maxItems: 2
+    minItems: 2
+    maxItems: 4
     description: |
       Points to the respective IOMMU block with master port as argument, see
       Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml for details.
-- 
2.34.1


