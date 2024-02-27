Return-Path: <linux-kernel+bounces-83645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30796869CBA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 660002836C8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B44D4EB43;
	Tue, 27 Feb 2024 16:47:26 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B240F1D698;
	Tue, 27 Feb 2024 16:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709052445; cv=none; b=S60NyuQ8vIKtGbvOzyw34XURpsP2BbSjErcC/0lykj+d2fMQLGZNJ4deTDwNn2/RPJLpw6IAwCtat4qe95o5l+htSz8/RAtHo28xjyoSgw0xsBkmMf0rHPfi1JhVr1XuwlwLMCviGLqB/kbsx8boH2aX0w4jprVjaneagl4BLhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709052445; c=relaxed/simple;
	bh=4YgqCK8WBP7AmGB7o9PSymrPmWweUxISragNOxh6s0A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nsLoLNLF9It+76giP4u3EJyLOPDX9eRfvDVicklwllbmWZBjfnTh9GF2ezmlkrRMPLJZrfXYXBwRuugos0M0o+TGJK1Nkqjhl0WDwIpkToTv3SIkSe8tEuQDC1N2l/kKvdzXXKQ/X9I5tvECr3xxAHUNvrvkvBaPi1i4GGoXec0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b6c.versanet.de ([83.135.91.108] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rf0bl-0006qV-2r; Tue, 27 Feb 2024 17:47:09 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	quentin.schulz@theobroma-systems.com,
	heiko@sntech.de,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH 2/4] dt-bindings: arm: rockchip: Add Theobroma-Systems RK3588 Q7 with baseboard
Date: Tue, 27 Feb 2024 17:46:57 +0100
Message-Id: <20240227164659.705271-3-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240227164659.705271-1-heiko@sntech.de>
References: <20240227164659.705271-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@cherry.de>

Add binding for the Tiger Q7 SoM when used in conjunction with the Haikou
baseboard.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 5cf5cbef2cf55..864d7c77077e4 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -898,6 +898,12 @@ properties:
           - const: tsd,rk3588-jaguar
           - const: rockchip,rk3588
 
+      - description: Theobroma Systems RK3588-Q7 with Haikou baseboard
+        items:
+          - const: tsd,rk3588-tiger-haikou
+          - const: tsd,rk3588-tiger
+          - const: rockchip,rk3588
+
       - description: Tronsmart Orion R68 Meta
         items:
           - const: tronsmart,orion-r68-meta
-- 
2.39.2


