Return-Path: <linux-kernel+bounces-123457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCD18908E9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC44AB23B41
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEE313341C;
	Thu, 28 Mar 2024 19:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="DgZvvm2W"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9A86168C;
	Thu, 28 Mar 2024 19:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711653216; cv=none; b=nV3YeG4fSWDE+4ospActE4/DxttfTOzZLwxj3cZjfksQMoOehp0J03YRzA6ku93Gj7XmM5aGgLq+qEVE5UFwxW3Mv6ga1iSzXC8LAAmx3pQOg6jljNy4i5jSptEAH90YG3KRojlVF7VqCIy7YHv4m1evnJ1oMcHZ0z6Fvxbar9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711653216; c=relaxed/simple;
	bh=OypLeR3ba2cp7JYsisXrwA2TgrpAHG1HOZQfRBh1c+4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sYSy2873ft/yWPNR5S72MHaNm6cNP2gIs3ArrXrq2JTZ13P3anMQa2FSsTbusSM6DR1mQMuU0J4PZR/OL7EIKnq+Ax4Wem/kAHC0toISSSKTjsf/IEPVlPgHurihl1IoeF0bmAIOzHxZcyyrPXEnJ2FpGBtabnsX5lZXvSvAD7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=DgZvvm2W; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 6CA6A100008;
	Thu, 28 Mar 2024 22:13:30 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 6CA6A100008
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1711653210;
	bh=DK0xYCxxFrCvVT2ZbbKPGpYfLWfHUluSqxo/nCVf490=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=DgZvvm2WNnBfGrPZALl4e+3Vmx+3aW+S51L119d0MM9ygJXa/sWs86FqwNhgN84Jr
	 ZxJU82G9IX4NvapcrdIa2MM/abMD6Eb0Cl3yq7UufKuufxucThRezOO6PfDyTTBpOR
	 uA3XZ4JQS6Qkb9AO5TaFS8WlaAedAGxDXPwytaG5YE5/aOUqJXy1275qFFzfK7skEc
	 ewYi07twpk/TTqZX3a7SnerdTrIwyClu+KbnXtm8cHMnjxqwLFBketxI9iMZ8Iqsbi
	 j9Q6JMwQn0mYNu5v7JhH9HwNf+/1I8BmzXckaXL4OOXCEut8oWbwfVJ04QaSiSfe0E
	 XvocW8b9FYaAQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 28 Mar 2024 22:13:30 +0300 (MSK)
Received: from CAB-WSD-L081021.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 28 Mar 2024 22:13:29 +0300
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
Subject: [PATCH v2 1/2] dt-bindings: thermal: amlogic: add support for A1 thermal sensor
Date: Thu, 28 Mar 2024 22:13:10 +0300
Message-ID: <20240328191322.17551-2-ddrokosov@salutedevices.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240328191322.17551-1-ddrokosov@salutedevices.com>
References: <20240328191322.17551-1-ddrokosov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184477 [Mar 28 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 14 0.3.14 5a0c43d8a1c3c0e5b0916cc02a90d4b950c01f96, {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:5.0.1,7.1.1;100.64.160.123:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/03/28 18:13:00 #24496606
X-KSMG-AntiVirus-Status: Clean, skipped

Provide right compatible properties for Amlogic A1 Thermal Sensor
controller. A1 family supports only one thermal node - CPU thermal
sensor.

Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 .../devicetree/bindings/thermal/amlogic,thermal.yaml | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
index 20f8f9b3b971..01fccdfc4178 100644
--- a/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
@@ -13,11 +13,13 @@ description: Binding for Amlogic Thermal
 
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
+      - const: amlogic,a1-cpu-thermal
 
   reg:
     maxItems: 1
-- 
2.43.0


