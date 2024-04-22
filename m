Return-Path: <linux-kernel+bounces-152804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7268AC479
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 843BF1F219C8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 06:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D270A3FB3B;
	Mon, 22 Apr 2024 06:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="J1fyflLZ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="iWh6WZmh"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EE63FB09;
	Mon, 22 Apr 2024 06:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713768603; cv=none; b=L/QiD8iduH7eXbw3TF67tH64auuib8Rrb5EXJXES+A2/7A6gNkW9b4VC3g/1X0Zwa2hYAGiCJIEMrVXoNeSGHdvGM9Cqd86Wyx5ttOj9tMKtOwagFeJl0rKxl6D6yS0tVgs8L6TsMvPxs+mbKml5oXrLDbMV6i9xZaUdEisLI1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713768603; c=relaxed/simple;
	bh=sizjEXdnQIm4DoN/Y0pcUBhana0MS1upvGYwNtl05/k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Kwk8y0EtP+aU/0JPpIqR9D1m2ogPTc8DPio/lBTZS4ubN7lQovJ1nN2MxDbfRtqGQ+Ty21Rzye9wVytMs6pkfBHTclF9wAq2gNI7S78pJzAkpa/31Z/FYwy55e8PY8zxvsqn3KjRxajg0jMlYggImO5d+jSmnoaOozbyqxglE/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=J1fyflLZ; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=iWh6WZmh reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1713768599; x=1745304599;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+sgIu3vs+pfjr2GCben4TQs4zEyijSBG80TUgm+psUs=;
  b=J1fyflLZv9QeMfgt3jZsjdnnE3+eFIFwDWpgG1lr0tBgvyS6/B4vj0OI
   WZjS5hPUrmmybj4tubdCvaau2hQfSTfe3YnUhwRD4c74kVOf0ack657Fj
   YYoMIxdB1jqEXSZxFuLMP+dtFcL/yOQt1rv1hl/zOFOESwMND8Qhk1++F
   SP+Vm5GNZdwmQ2Nh5W/zegiIOJf4Cp60KugHf5OFAHYmQC4RcHaqXbxvd
   PoaQxXPZjFYWVJkPj7hMgB/pH4AxOiaUdLOlcqKDBgaUZFwkWx3KQgDKa
   aTKjTjMLavOhlQTdqShItvTU7GgRCoz4/XAFpfqTt7t2vjiwtYJh2iHlz
   w==;
X-IronPort-AV: E=Sophos;i="6.07,220,1708383600"; 
   d="scan'208";a="36531778"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 22 Apr 2024 08:49:56 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4824316E4ED;
	Mon, 22 Apr 2024 08:49:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1713768591; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=+sgIu3vs+pfjr2GCben4TQs4zEyijSBG80TUgm+psUs=;
	b=iWh6WZmhXAGE0BU9uXxNHZ3Cj3i0mdprnyFEnb+3fzPy5aU9ZlQzUbqmrgylTjTvbHd9Yw
	XHivKZLfW65Bs5LO7V8HY1idTjyiL2mUnFkRBLlEqO75GgCKRwCeNgDVOHG4EAJJJ1plsQ
	h1dlJSn8mRfmwLbLtdj4uo2jGEBie2a+e1IhzJelt7HHR8ymXOz6QZX6gzgQzm/NeQwb2A
	K0eHAbv5zajBuHVxkXJSoU2XMwsuk0ccGNIIsHnZJynmyNq1E/oLZvN37pI5QsuH+hIvAO
	8qN1XNiy58ETzE39JMfeC5Cw86ld23k1csllxPrCNlzpp9HCymFZYK3+psGiOw==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v3 1/1] dt-bindings: interrupt-controller: fsl,irqsteer: Add imx8qxp support
Date: Mon, 22 Apr 2024 08:49:49 +0200
Message-Id: <20240422064949.70778-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Some SoC like i.MX8QXP use a power-domain for this IP. Add a SoC-specific
compatible, which also requires a power-domain.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
Thanks for the feedback.

Changes in v3:
* Move 'allOf' before 'additionalProperties'
* Remove superfluous 'minItems: 1'

 .../interrupt-controller/fsl,irqsteer.yaml      | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml
index 20ad4ad82ad64..3d33b75d6ecfa 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml
@@ -14,7 +14,9 @@ properties:
     oneOf:
       - const: fsl,imx-irqsteer
       - items:
-          - const: fsl,imx8m-irqsteer
+          - enum:
+              - fsl,imx8m-irqsteer
+              - fsl,imx8qxp-irqsteer
           - const: fsl,imx-irqsteer
 
   reg:
@@ -42,6 +44,9 @@ properties:
   clock-names:
     const: ipg
 
+  power-domains:
+    maxItems: 1
+
   interrupt-controller: true
 
   "#interrupt-cells":
@@ -70,6 +75,16 @@ required:
   - fsl,channel
   - fsl,num-irqs
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: fsl,imx8qxp-irqsteer
+    then:
+      required:
+        - power-domains
+
 additionalProperties: false
 
 examples:
-- 
2.34.1


