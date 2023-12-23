Return-Path: <linux-kernel+bounces-10601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D86581D6D2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 23:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22667282AB2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 22:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFBB18C16;
	Sat, 23 Dec 2023 22:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="bDwJYrI4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B44818B1B;
	Sat, 23 Dec 2023 22:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wNnMpPSuWfDBc3iHywduR+Ih2mlWoXSvgD9/nDYl3K0=; b=bDwJYrI4eAUzGR4S7S/zojT8+7
	64BMJ+nQq+hoz4+tr5lmrmMEfP4k7idGp2zCzLMJ4kegGKmw4cLxMZW97SOwO82gCCkrm90oKIdBy
	VpGRCSqHtlnKqyERFHnrBt3rjl9MPXhyBV8ZQCBBlOfvv57Thdth1CXN8KrVTDau9c8AUxHuIVJKp
	eQm08vbj7mIxSCz59yDW0ojGk37SzHiUdWy2S6IPqX4Hu2jzT4Lxh9DCLvTL9dhrqLH/Idn7ElrTV
	k69Bc+R7MKj4UHCOhYrhW6/94RDMgo2eQ9to3yEi8iSxc6jDXRyVuVqOfjfbdDZtYAQgZsGsQbx1j
	iEOh+yGg==;
Received: from p200301077700c3001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7700:c300:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andreas@kemnade.info>)
	id 1rHAEK-007f7a-4q; Sat, 23 Dec 2023 23:12:24 +0100
Received: from andi by aktux with local (Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rHAEJ-003FaC-20;
	Sat, 23 Dec 2023 23:12:23 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: dmitry.torokhov@gmail.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	rydberg@bitmath.org,
	andreas@kemnade.info,
	linus.walleij@linaro.org,
	Jonathan.Cameron@huawei.com,
	u.kleine-koenig@pengutronix.de,
	heiko@sntech.de,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Rob Herring <robh@kernel.org>
Subject: [PATCH v3 2/4] dt-bindings: touchscreen: neonode,zforce: Use standard properties
Date: Sat, 23 Dec 2023 23:12:11 +0100
Message-Id: <20231223221213.774868-3-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231223221213.774868-1-andreas@kemnade.info>
References: <20231223221213.774868-1-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable touchscreen orientation to be specified by using standard
properties.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/input/touchscreen/neonode,zforce.yaml  | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/neonode,zforce.yaml b/Documentation/devicetree/bindings/input/touchscreen/neonode,zforce.yaml
index c39662815a6c5..c2ee89b76ea13 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/neonode,zforce.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/neonode,zforce.yaml
@@ -9,6 +9,9 @@ title: Neonode infrared touchscreen controller
 maintainers:
   - Heiko Stuebner <heiko@sntech.de>
 
+allOf:
+  - $ref: touchscreen.yaml#
+
 properties:
   compatible:
     const: neonode,zforce
@@ -26,9 +29,11 @@ properties:
     maxItems: 1
 
   x-size:
+    deprecated: true
     $ref: /schemas/types.yaml#/definitions/uint32
 
   y-size:
+    deprecated: true
     $ref: /schemas/types.yaml#/definitions/uint32
 
   vdd-supply: true
@@ -38,8 +43,6 @@ required:
   - reg
   - interrupts
   - reset-gpios
-  - x-size
-  - y-size
 
 unevaluatedProperties: false
 
@@ -60,8 +63,10 @@ examples:
             reset-gpios = <&gpio5 9 0>; /* RST */
             irq-gpios = <&gpio5 6 0>; /* IRQ, optional */
 
-            x-size = <800>;
-            y-size = <600>;
+            touchscreen-min-x = <0>;
+            touchscreen-size-x = <800>;
+            touchscreen-min-y = <0>;
+            touchscreen-size-y = <600>;
         };
     };
 ...
-- 
2.39.2


