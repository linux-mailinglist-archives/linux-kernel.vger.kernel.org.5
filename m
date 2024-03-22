Return-Path: <linux-kernel+bounces-111214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 036D288693F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3FED1F22AEC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FE81CD3A;
	Fri, 22 Mar 2024 09:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="cRN5ZVmp"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C537383BA;
	Fri, 22 Mar 2024 09:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711099752; cv=none; b=HrpxIwt68Yg1Vmj3J+Jc6GJDGXWvd8C/XFydczCtYjY+caayl7ULMlIlvnVhhjFa7ZRmoPr5QfQTu0GRRYQFwkCvTxW1xNAWEJJUzqBBmhbStBtueIJzHim5+/F2mqQvOrhs2v5okM6VwhkUO4Rsdq/JKc7olCGekBcAPbI2KvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711099752; c=relaxed/simple;
	bh=AjiPCKYIJ6cIRh/6wA9+tKFj1BougxdVEi/ByygD0oU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OruXGhZDB3o5v21NdAlRZk5zKUs1RpkuDokVrxfkoZvRxpwd/HesCPw/G5eMiOvKJcOVVZO0Rtnny0tABUxfe+IRCL/d788CCrGUOhZQyvMgq9V6xYA6/8gqDK061bXDb0eB4l4RUvEvfPowjea4vB4HBC+v1f7zFr+bpf0egTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=cRN5ZVmp; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711099748;
	bh=AjiPCKYIJ6cIRh/6wA9+tKFj1BougxdVEi/ByygD0oU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cRN5ZVmpqpseHFn4sGGAQbVwTyV9UPtQPKcbTGkxQnVPOv/qW/D06Wa+ii7Q0UzSV
	 GhKr7wFpuyyJlv7n5nz9m8J+Vin7mcNV+aLFXlbBvJxOgEaMaNMa6w3881dWuOi4Z4
	 /Zt1aMNEG3qwdV0SABWIQsnEmOVcbiN6RP8UoaXKSLpKPA5zIx8yWO2aP7tl58lf4c
	 p8HgeCRjFStuf4kYEwXxq1lQLnVC7og8sRfmQRqAfE7e60YJd41xSrhutkMQm6osd+
	 j+1qQmd5OHI2l7sx//zRjsA4SMzxZIewWvt90ixuhpeSHXDDqigVE0yWEgFh8QDUZa
	 bJwnHtyI3EAqg==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 11104378211B;
	Fri, 22 Mar 2024 09:29:07 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-media@vger.kernel.org
Cc: mchehab@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	amergnat@baylibre.com,
	moudy.ho@mediatek.com,
	hverkuil-cisco@xs4all.nl,
	sebastian.fricke@collabora.com,
	u.kleine-koenig@pengutronix.de,
	chunkuang.hu@kernel.org,
	p.zabel@pengutronix.de,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH 3/4] dt-bindings: media: mediatek: mdp3: Add support for MT8188 RDMA
Date: Fri, 22 Mar 2024 10:28:44 +0100
Message-ID: <20240322092845.381313-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240322092845.381313-1-angelogioacchino.delregno@collabora.com>
References: <20240322092845.381313-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a compatible for MediaTek MT8188 RDMA, which supports only a
subset of the MDP3 components of its similar MT8195 counterpart.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml b/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
index 59db8306485b..18603f6c5e06 100644
--- a/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
+++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
@@ -23,6 +23,7 @@ properties:
     oneOf:
       - enum:
           - mediatek,mt8183-mdp3-rdma
+          - mediatek,mt8188-mdp3-rdma
           - mediatek,mt8195-mdp3-rdma
           - mediatek,mt8195-vdo1-rdma
       - items:
-- 
2.44.0


