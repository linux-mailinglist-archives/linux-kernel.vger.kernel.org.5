Return-Path: <linux-kernel+bounces-21903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E77F829670
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4C441C21C1D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 09:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC49D3EA86;
	Wed, 10 Jan 2024 09:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="FIfjWd4w"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2C93EA73;
	Wed, 10 Jan 2024 09:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1704879824; x=1736415824;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Oe+RPWEWGt5ubRnnGnoeB42BPxrjzjK1FGQalske8Mk=;
  b=FIfjWd4wDE1owmq4aSP60pQllYAA1gZ0VBycC3AGiZgy932SnG3mClzp
   2ay56FMEvZs/Q8+i8RLpBGf3UyvbPd8P5sTpCSQlMR/xX/5csicDzDZ9H
   kSAafzrtUpsmKY2+0yemUmLYxbxhstXtXNXXnT0QWP2RZ4nLcc/FTuV/Z
   Igs5RdnCQUIxUpkZDoM8whUkNKhgfAzU8F+G5GwIuM9I+2pOlmQbXRvBJ
   JBvUs77EBK9wktbJhApfeOUtTfIopPZMHh77AG6YR9fr5UVi4Mc+lqm92
   vgH1trFUDd7ZhTjTO0a1hw6jcewZBRaIX17gdsTjro5J1e2oMog9v85v6
   A==;
X-IronPort-AV: E=Sophos;i="6.04,184,1695679200"; 
   d="scan'208";a="34824491"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 10 Jan 2024 10:43:41 +0100
Received: from steina-w.tq-net.de (steina-w.tq-net.de [10.123.53.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 3BC58280075;
	Wed, 10 Jan 2024 10:43:41 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] dt-bindings: interrupt-controller: fsl,irqsteer: Add power-domains
Date: Wed, 10 Jan 2024 10:43:38 +0100
Message-Id: <20240110094338.472304-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some SoC like i.MX8QXP use a power-domain for this IP add it to the
supported proerties. Fixes the dtbs_check warning:
freescale/imx8qxp-tqma8xqp-mba8xx.dtb: irqsteer@56000000: 'power-domains'
 does not match any of the regexes: 'pinctrl-[0-9]+'
from schema $id: http://devicetree.org/schemas/interrupt-controller/fsl,irqsteer.yaml#

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---

Notes:
    Please note that both the board dts and the DT node for irqsteer being used,
    are still work-in-progress.

 .../devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml
index 20ad4ad82ad64..cb4fcd23627f6 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml
@@ -42,6 +42,9 @@ properties:
   clock-names:
     const: ipg
 
+  power-domains:
+    maxItems: 1
+
   interrupt-controller: true
 
   "#interrupt-cells":
-- 
2.34.1


