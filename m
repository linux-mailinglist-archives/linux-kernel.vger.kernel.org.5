Return-Path: <linux-kernel+bounces-103129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A4087BB62
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62D3D1F21FBB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CEA6EB66;
	Thu, 14 Mar 2024 10:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="r0aP0w+C"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF195FEE3;
	Thu, 14 Mar 2024 10:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710412552; cv=none; b=gXoogXhZR9yuhVBU3Rtp+vSc7IoLv/pkiVZxfYGNpkrWXyP17x+ivh1PRL/VioQj23dU5LXBUAQkK/78S2aIiEDbAJ7D8Bu8M8KeZyetp87/ZSPKjcx7Mtpwd1VKzGYotpKMJ4EOHgEGzPVmnVvC6Wt/3f+RXq84Ql8J290J514=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710412552; c=relaxed/simple;
	bh=QReK/KWVzgQf557F87tkZ7/Pys1J7fmBggS/0JRuhqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EjHipPm+wN2dZZCJBh9uxNAk8Kb/NBqWDXo0+IODq22tFGVKIO6W9eq1r38OFIbhfKYkRgsNXtYZEztXq91hpo6vD21zX09a25hXONET6lCTcC5k4L9NZSSihAhB/POD5Ba6uCVKaq9cm5jB4ALf7dpxoJwoF7QKcX4iGeOODUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=r0aP0w+C; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710412548;
	bh=QReK/KWVzgQf557F87tkZ7/Pys1J7fmBggS/0JRuhqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r0aP0w+C0idVItdhVePghwV+j80xy/2P7aDOE+0QbCvBNlu2+Ko/y3sxZRl3fnTDn
	 xQdZ+b6v+etgrCxP+9t2TSIBkEuztj5seYouoiLGvgZhg8FjtMYV0ofcXYYtiWWwEJ
	 mPMgqv+Br2q80+FdoaF1FL7tKowKKeLICE5OvrNNCiUu8rq8h3euGq+8WmblBdPAhX
	 U67KMSrqvTTAGzNfT3tEqrvyqd2o7556Bm3Ex08B/7aHKoimYuHTdV8wHRZRjXq8FL
	 enHq05yixx5b3mynSZRUqnnX8mTPJQlH0gahSBQ51MDWA1ch2eUYd6Bs5uA3FhjHxv
	 ioPPCml0y53Tw==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0C2A437820D9;
	Thu, 14 Mar 2024 10:35:47 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-mediatek@lists.infradead.org
Cc: robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	wenst@chromium.org,
	jenneron@protonmail.com,
	kernel@collabora.com
Subject: [PATCH 1/2] dt-bindings: arm: mediatek: Add MT8195 HP Chromebook x360 13b-ca0002sa
Date: Thu, 14 Mar 2024 11:34:59 +0100
Message-ID: <20240314103500.93158-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240314103500.93158-1-angelogioacchino.delregno@collabora.com>
References: <20240314103500.93158-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the MT8195 Cherry platform's Dojo machine, a convertible design
commercially known as the HP Chromebook x360 (13b-ca0002sa).

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 09f9ffd3ff7b..5524b095bf3b 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -342,6 +342,14 @@ properties:
           - const: google,tomato-rev3
           - const: google,tomato
           - const: mediatek,mt8195
+      - description: HP Dojo sku1, 3, 5, 7 (HP Chromebook x360 13b-ca0002sa)
+        items:
+          - const: google,dojo-sku7
+          - const: google,dojo-sku5
+          - const: google,dojo-sku3
+          - const: google,dojo-sku1
+          - const: google,dojo
+          - const: mediatek,mt8195
       - items:
           - enum:
               - mediatek,mt8195-demo
-- 
2.44.0


