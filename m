Return-Path: <linux-kernel+bounces-24500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C199D82BD87
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 10:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60E231F21AD5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 09:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABDB5732C;
	Fri, 12 Jan 2024 09:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LsmGPgn9"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DECF56B9A;
	Fri, 12 Jan 2024 09:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705052799;
	bh=mRwByIiVTJreubbEqTLuMGGfCpZaH/6lxKTlnASbr/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LsmGPgn9ccNOnvg4YmWWBMpw82iRH7rByQdJildqyIjWjvzmE6iKHk4S+l6HmrZq3
	 teW9KvAzdWDRNXGHuFsqvqHMEBtClyLtv8bY+m7nC09hdLB1zjtPtvL6NqY3Z/QnlD
	 DuTrbvVMqfAsY9KOyvdKd9BNgzA9/hT0cR01GoUZ47klzaKmLSFbs3tFcSvimhE5uS
	 daMnzWLTbtIe53nhfpfV+/ddyvBbip4O7absmWKzDOCfqCFdjnbDtiJtOi702s+lck
	 rHK+B9b+5pa05KOz0x5HHmtSDH04ji8j9jQ665TItRnuEJ9Z4tYx5jXJ/VH4OROmR6
	 AGYwxZGZBouPg==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9A5203782021;
	Fri, 12 Jan 2024 09:46:38 +0000 (UTC)
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
	kernel@collabora.com
Subject: [PATCH 01/15] dt-bindings: arm64: mediatek: Add MT8395 Radxa NIO 12L board compatible
Date: Fri, 12 Jan 2024 10:46:18 +0100
Message-ID: <20240112094632.66310-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240112094632.66310-1-angelogioacchino.delregno@collabora.com>
References: <20240112094632.66310-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a board compatible for the Radxa NIO 12L, based on the MediaTek
MT8395 SoC.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 5d49c7af50e5..cc37c88d8d4a 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -345,6 +345,7 @@ properties:
       - items:
           - enum:
               - mediatek,mt8395-evk
+              - radxa,nio-12l
           - const: mediatek,mt8395
           - const: mediatek,mt8195
       - items:
-- 
2.43.0


