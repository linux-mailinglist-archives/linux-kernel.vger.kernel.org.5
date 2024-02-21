Return-Path: <linux-kernel+bounces-74670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4AA85D782
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 860F1283809
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7D54C60C;
	Wed, 21 Feb 2024 11:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GfrpCFkX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF94482DD;
	Wed, 21 Feb 2024 11:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708516606; cv=none; b=VHwl7SOScaBKaXohww2S22jX8suIAgWzijrjjtrHwMJykrdVCQ1FY3Psis5Z/6GnQuTUULz2UQXnthVjAlDwpZpDm5EaE7KjLF4uWwcYsOlOMXzmIPXDQXE8GK8lqrIAThcmPFHwFxHHLqqN/Qmlg7+QIhgxzbRtb86KwiAuXdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708516606; c=relaxed/simple;
	bh=lI9ZJUjL9ybYuRVZPP8gR27T34yW1aM09ufVi90sVcU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ymx/Zqo9rJOyYZt8BTbLMQOD49fiT6yfi7Ey5j2ZRzwCuqWZFoWruPIRc4INNTmCpl7ervt8waELdB5CLYAoJTeODpUlcaxdXALbNVmToSpGPryBNbecqduRHVZHJQwm5M3xZWRYhAaiKHrCTXjh3sgCa1DTPo3CFiiGwDTV6kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GfrpCFkX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D58D1C433A6;
	Wed, 21 Feb 2024 11:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708516605;
	bh=lI9ZJUjL9ybYuRVZPP8gR27T34yW1aM09ufVi90sVcU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=GfrpCFkXjvJbbaQFtNLQKBttgHU/P76DXvBvf1pO8g0nOYIYMBLzze+NL4h6bhqdj
	 2H0w5MFQXyHn5SDQ+K+ysKlpI2APE+VlbBGROXTcd/hqFnviOOI+kAc5EvBzTLWWMo
	 66vb8dOf9JhcWJPg0uIpluu8f7V9vL//IazSdv1Iwu5ImOCHoN7O2FMqqilK759Mfd
	 9XJqDnvoMpSpvwT1ggXrsSni4aMnyO2zqMJZ0hyTNRj4SqRvmnzGMeXKBKkO1pUHVh
	 p8b0Zofc+0oEw9UyvvFk6iXBuJDiEZkzYLUn06CEHWUstbIaFRh3wheuLqemXA36sx
	 /9b459/Ifv3hQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1270C54787;
	Wed, 21 Feb 2024 11:56:45 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Wed, 21 Feb 2024 19:56:42 +0800
Subject: [PATCH v3 2/2] dt-bindings: watchdog: arm,sp805: document the
 reset signal
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-hisi-wdt-v3-2-9642613dc2e6@outlook.com>
References: <20240221-hisi-wdt-v3-0-9642613dc2e6@outlook.com>
In-Reply-To: <20240221-hisi-wdt-v3-0-9642613dc2e6@outlook.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Viresh Kumar <vireshk@kernel.org>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Yang Xiwen <forbidden405@outlook.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708516604; l=1096;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=Y/0S+rlwzPt8yQv5SlX93rhiayW10MfuG7cp9vIgSlo=;
 b=WAnlEEfrbRpjG0jx4dwCj49jhQD2lZrFbD3WokV1xI133SJv8xB8yB1Uuj9KnDAItIC1doRVQ
 9vHJ8rPx4xxCsm/Luh0VWWK67UJNNnBQt3vx7aQ200E8AxkIRcXKH1Q
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


