Return-Path: <linux-kernel+bounces-122965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C29E9890079
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 644811F23EA3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A8B81ABE;
	Thu, 28 Mar 2024 13:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="BYfL54vR"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5117CF37;
	Thu, 28 Mar 2024 13:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711633096; cv=none; b=Puya923MvjiQuyV9SRlK5L8sDaz6lLfsVFN1K+6Ix4SQvhvUrRWmKaJAifEFd9ceEsQ9UzExzgd8XS1Z0t6VtucSjlkujEXeN4jaSaA/T8PRrGZ9DCIDY8lW84RHlY3BXG93KR5fUELOuXaXBimhvPHVUsr23PaI3ynlFAd8FaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711633096; c=relaxed/simple;
	bh=TgXWfahIgNNcAoMQJ59AQ0okdIQDTlo0Qo25KTDlQfM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FADdkB/8BWvSsfBnbnECkEQ/FdRhLzuZ/3fkhOAy3BHXbwpz/0DiyBECq5QL4RTJKAar3coKV7bEjNClgo011YAuYVntxpazubGWM8aQgMe62BOhcs0RvyXUf5a7z3bXae54iVMvfvIObaxx0QYNOSZvdgyIESAwg39fc7/gNr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=BYfL54vR; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id AD74F120002;
	Thu, 28 Mar 2024 16:38:10 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru AD74F120002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1711633090;
	bh=4qRZdUHB9Ov6yM433hxyPD/kVZr4M3hR3znxgjgkKUw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=BYfL54vRw+9C2l7mhlWB3W7j7xPz8+n23YBx9J3HyQO3VAhikJHCjwqqWzXZxRlvO
	 J2Ddj9ONfxY0/VePV6sUhBurxrReLL/P4fCvxgIJ7526OKRLXCz1S05rUiQiq2BbBs
	 huAP4rr8YB5/DSKYQUU1k3eKfLEnLRwU82dLsFWUvI5GpXK3GUWLJd+pIKCF1xgbF3
	 cqNUIfosqTu5BdLkVpBCJtABONxaTB+SWl03MAvi2i8pbQGWV78S9ptqpxLX6HhaM8
	 pZaBUQ4qkTAudK+RFEFIt+QxqlJiSbo37L25WUKOHjZIFgPivn3gdy1430YH8bSpbQ
	 xnniZrTai/kXg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 28 Mar 2024 16:38:10 +0300 (MSK)
Received: from CAB-WSD-L081021.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 28 Mar 2024 16:38:10 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
	<mturquette@baylibre.com>, <khilman@baylibre.com>,
	<martin.blumenstingl@googlemail.com>, <glaroque@baylibre.com>,
	<rafael@kernel.org>, <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
	<lukasz.luba@arm.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <kernel@salutedevices.com>, <rockosov@gmail.com>,
	<linux-amlogic@lists.infradead.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Dmitry Rokosov
	<ddrokosov@salutedevices.com>
Subject: [PATCH v1 1/2] dt-bindings: thermal: amlogic: add support for A1 thermal sensor
Date: Thu, 28 Mar 2024 16:37:52 +0300
Message-ID: <20240328133802.15651-2-ddrokosov@salutedevices.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240328133802.15651-1-ddrokosov@salutedevices.com>
References: <20240328133802.15651-1-ddrokosov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184470 [Mar 28 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 14 0.3.14 5a0c43d8a1c3c0e5b0916cc02a90d4b950c01f96, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;salutedevices.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/03/28 10:33:00 #24492761
X-KSMG-AntiVirus-Status: Clean, skipped

Provide right compatible properties for Amlogic A1 Thermal Sensor
controller. A1 family supports only one thermal node - CPU thermal
sensor.

Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 .../bindings/thermal/amlogic,thermal.yaml          | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
index 20f8f9b3b971..0e7f6568d385 100644
--- a/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
@@ -13,11 +13,15 @@ description: Binding for Amlogic Thermal
 
 properties:
   compatible:
-    items:
-      - enum:
-          - amlogic,g12a-cpu-thermal
-          - amlogic,g12a-ddr-thermal
-      - const: amlogic,g12a-thermal
+    oneOf:
+      - items:
+          - enum:
+              - amlogic,g12a-cpu-thermal
+              - amlogic,g12a-ddr-thermal
+          - const: amlogic,g12a-thermal
+      - items:
+          - const: amlogic,a1-cpu-thermal
+          - const: amlogic,a1-thermal
 
   reg:
     maxItems: 1
-- 
2.43.0


