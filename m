Return-Path: <linux-kernel+bounces-131092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7198982FD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 171F51C22539
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFC95FEE3;
	Thu,  4 Apr 2024 08:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dStsbZdk"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AF85EE76;
	Thu,  4 Apr 2024 08:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712218695; cv=none; b=KZcPCRYxkOu82wgpT1EFBcGUfAcWIn+1DUm7FbchpDatU6ojoz554wU1LwE1lkoKIks0/bvJ2sVNSg8afjI9UuTa3YY1S+LkB8QbgFOobohC3LfYmITtg+6A56US31PRyafP1wVX2/CBUeeHKQgO6AAe1GGQu+TlhMQE01+y+vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712218695; c=relaxed/simple;
	bh=qNIQsRN63cUz3fWMTVMY3OVNv9ArpXhRU38uV3pGBZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k7o8aouN4lIoiGfWsYJof4fGyBfAgXk48bBZ0YvyS3KrA1zG1DS8KJWtOFOe3zmGSTEaPJ8PtlpVFzs91B0JBN+T2K9OKigYvgIBz1m6VQEi6w9p+Z/pK5bnlobv0H4PD8l2x5tTZkXIzjrtIG0u23XR0mhLQKPtBFNrhdib0Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dStsbZdk; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712218692;
	bh=qNIQsRN63cUz3fWMTVMY3OVNv9ArpXhRU38uV3pGBZ0=;
	h=From:To:Cc:Subject:Date:From;
	b=dStsbZdkhPsfyZzFRVUrtm8IM9PzGbB+AuNpRGGes+uBvZ+QtQzq2WBq3QNL8z2zH
	 gDXj9viF/xWxNYcQDCmbWhQIMGxLf3qqH49Eq2ONQRU8r/ZPLsCa3IyP+2gUuhnVaP
	 eaaBPWWm2sFzSumPhqCenBWwip1uubRdLyIlcfB3raBaSvqy9178CDNoYMgDE+j+BQ
	 F1ioO9xsIkbFGspD+V5OQXNQDbRNqcjnhO8WF4dxhetawSczO2yZOWPk+g7h8ZvXE0
	 cihfTVlHQFlKgKwA9VAI5VLALS/RqnAvvftMNGt/0/V3sjOt1+Bhn7MfFSbydtxGgr
	 W2qTevEKwiXSA==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 94749378200D;
	Thu,  4 Apr 2024 08:18:11 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: u.kleine-koenig@pengutronix.de
Cc: robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	jitao.shi@mediatek.com,
	thierry.reding@gmail.com,
	miles.chen@mediatek.com,
	xinlei.lee@mediatek.com,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	wenst@chromium.org,
	kernel@collabora.com
Subject: [PATCH] dt-bindings: pwm: mediatek,pwm-disp: Document power-domains property
Date: Thu,  4 Apr 2024 10:18:08 +0200
Message-ID: <20240404081808.92199-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow the power-domains property to the PWM_DISP block as on some SoCs
this does need at most one power domain.

Fixes: b09b179bac0a ("dt-bindings: pwm: Convert pwm-mtk-disp.txt to mediatek,pwm-disp.yaml format")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml b/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
index afcdeed4e88a..bc813fe74fab 100644
--- a/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
+++ b/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
@@ -52,6 +52,9 @@ properties:
       - const: main
       - const: mm
 
+  power-domains:
+    maxItems: 1
+
 required:
   - compatible
   - reg
-- 
2.44.0


