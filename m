Return-Path: <linux-kernel+bounces-71802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B20685AAB2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E06F5B215BC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46AF482DC;
	Mon, 19 Feb 2024 18:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ucmLAF/B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA5D481AB;
	Mon, 19 Feb 2024 18:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708366466; cv=none; b=eFzPIs+WqxHaiPdJzkWb+RB1bBB/a+NFFRwicqimALyPFCSv1lMOyfia7giSlyBPNYwGl5ZZD+NLtheabLYSQdIcku0oLzxZpBdscvPXFN+GugKMNztY2MC4ECt8T9PuwCNUjydGFCmJbgkeRz20o6WeOf7xZ23qXI5b4oj/I5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708366466; c=relaxed/simple;
	bh=lI9ZJUjL9ybYuRVZPP8gR27T34yW1aM09ufVi90sVcU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=prO+2tysoaDStzN5oowhEFoV+8vlfkprjG4j09dNeeKShHWPbXTHBcRnawqUEECvtBJsM9qmbEPu1xt11M3/U0oWFSDJMYXLs1b4V9+fhVyeQHgOv+6y8BiMgMrtqJIDpl2ZdDNXxX2ENmgMlHfN3JF5erGVkqE94dYLA/yuht8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ucmLAF/B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8C5AEC43394;
	Mon, 19 Feb 2024 18:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708366465;
	bh=lI9ZJUjL9ybYuRVZPP8gR27T34yW1aM09ufVi90sVcU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ucmLAF/B5eTgPnHUOBqtBQ4THscpCui0NFbA3cDzLIOEOOBgOcu7DIpvLY7IHa0OQ
	 bore+x2/ASI9mT3xjDSz21ThdIeaAqcnjGJy1JSWY6qkJL0yRiuQdXvH3JCv+chD64
	 +kgciaLMJfi2hNw8zuHTUXTn7/vVFkbPe2SmqOI63m0q/yWEwe/gdrjdDgQiCTsWED
	 DxUgs4P9xEIZD41i/1d/GYypC9YcwqYyKmVKYn6uFiFLptqH1QNa0YkC9uptEywl/d
	 65BmOrbaIOJs4aBW5PNLQ3RIBInGzpSbOAOPm2D5YTGCOCgeSPcK8Cg+t7XdMlbCRy
	 2LKV5CLeEWVNw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0EBC48BC3;
	Mon, 19 Feb 2024 18:14:25 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Tue, 20 Feb 2024 02:14:26 +0800
Subject: [PATCH v2 2/2] dt-bindings: watchdog: arm,sp805: document the
 reset signal
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240220-hisi-wdt-v2-2-63edc4965b4c@outlook.com>
References: <20240220-hisi-wdt-v2-0-63edc4965b4c@outlook.com>
In-Reply-To: <20240220-hisi-wdt-v2-0-63edc4965b4c@outlook.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Viresh Kumar <vireshk@kernel.org>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Yang Xiwen <forbidden405@outlook.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708366465; l=1096;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=Y/0S+rlwzPt8yQv5SlX93rhiayW10MfuG7cp9vIgSlo=;
 b=74+vFdustM4jpfDiqXRrX52ettc3+5FsfpFWBdwErZQESubrKlLo/hEYyYhs3NwNvVUwfmAcz
 mIV0+fgFjDlC5SMtcaITXYcskRk3um5HuiO+azexYWsZq1s2a0oKuNX
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

The reset signal needs to be deasserted before operation of sp805
module. Document in the binding.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 Documentation/devicetree/bindings/watchdog/arm,sp805.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/arm,sp805.yaml b/Documentation/devicetree/bindings/watchdog/arm,sp805.yaml
index 7aea255b301b..bd7c09ed1938 100644
--- a/Documentation/devicetree/bindings/watchdog/arm,sp805.yaml
+++ b/Documentation/devicetree/bindings/watchdog/arm,sp805.yaml
@@ -50,6 +50,10 @@ properties:
       - const: wdog_clk
       - const: apb_pclk
 
+  resets:
+    maxItems: 1
+    description: WDOGRESn input reset signal for sp805 module.
+
 required:
   - compatible
   - reg
@@ -67,4 +71,5 @@ examples:
         interrupts = <GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>;
         clocks = <&wdt_clk>, <&apb_pclk>;
         clock-names = "wdog_clk", "apb_pclk";
+        resets = <&wdt_rst>;
     };

-- 
2.43.0


