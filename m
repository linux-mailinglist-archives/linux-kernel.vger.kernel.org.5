Return-Path: <linux-kernel+bounces-66485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FCA855DAE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39B16B341C3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F5F13FEB;
	Thu, 15 Feb 2024 09:05:10 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF621171A9;
	Thu, 15 Feb 2024 09:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707987909; cv=none; b=GAfuC1Qnhmsrf+peNhvkpGcaLWjapxe3E9TAEBpNDtO7n8TAxwPlzlY/qn4fsfAg05wElmjcime73kbyX74Shz8T8JWBl7lytkZ5Gmz/MexCf88aCDSZ+8NXrc3hxeCV7hctviyqXuTooKMS1wL8ShSCvf6NrKAb7fl4nm7wjiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707987909; c=relaxed/simple;
	bh=c2Ytc7I4JEAtHKJs79kozCQcZ6U8S5voc1kf5LhshRg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k4bf3y9eu02Q4Z0+Q9PQQePuEM3Ql8WZuWBkCz3UvwVYtcc1BlGAuO9Q1Tiq9tk6LvkIJGT38wgYH6J2uoPUuBJu81QiqO8TXb9w3vKg90Qu2U1SqU+SKdsZ6hjq3kXmFHGZ3b5rttYVaHOSIYHZaywzzWbq+dpdqi9XPBOUXxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b6c.versanet.de ([83.135.91.108] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1raXfh-0002L8-OK; Thu, 15 Feb 2024 10:04:45 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: neil.armstrong@linaro.org
Cc: quic_jesszhan@quicinc.com,
	sam@ravnborg.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	quentin.schulz@theobroma-systems.com,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH 2/2] dt-bindings: display: panel-lvds: Add compatible for admatec 9904370 panel
Date: Thu, 15 Feb 2024 10:04:42 +0100
Message-Id: <20240215090442.3513760-2-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240215090442.3513760-1-heiko@sntech.de>
References: <20240215090442.3513760-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@cherry.de>

The 9904379 is a 10.1" 1024x600 LVDS display using the standard
lvds properties.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 Documentation/devicetree/bindings/display/panel/panel-lvds.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml b/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
index 3fb24393529cd..155d8ffa8f6ef 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
@@ -39,6 +39,8 @@ properties:
   compatible:
     items:
       - enum:
+          # Admatec 9904379 10.1" 1024x600 LVDS panel
+          - admatec,9904379
           - auo,b101ew05
           # Chunghwa Picture Tubes Ltd. 7" WXGA (800x1280) TFT LCD LVDS panel
           - chunghwa,claa070wp03xg
-- 
2.39.2


