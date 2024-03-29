Return-Path: <linux-kernel+bounces-125419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29AC48925B9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 22:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78A8DB223E9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 21:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6317413C9D4;
	Fri, 29 Mar 2024 20:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="agDG4XBR"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A6C6A346;
	Fri, 29 Mar 2024 20:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711745960; cv=none; b=pjyAVHs1UYGwbDjIdL1/CKnrBPqcpauEqyWVz/N770vArt1L099Ggrwd/KhAhKS9niD4I1UYs03f7n5MuHl0BSyghJhYsFl4RbRH9bCGbvMP2znI4lqJxu0t5Czi6ZhJJpiDthgXL/anrpAgkBX2xWMRlDhaCrmryL0yXFoaW/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711745960; c=relaxed/simple;
	bh=fQG7RkxFpVAs8VCuTFYO1i8R7fwQxPFK98xCHgwGQ6M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=paTBa4Bo+ChdgwgIrPI/kGCf5d/wu1tYMc5KBq/0hgmpXQfMPKrFXhugh8SOsDbuEEd4S2zpj4m6KgJ8gVDiakOxM2E+ASc4e2AMjLlbSer9gqC+wJgsVEDgoFEN9CzWjhCLw7PnAdUGk0DRCqFOfcg7BAJ/7G6rgWR2IEezCqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=agDG4XBR; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id F0C8D100011;
	Fri, 29 Mar 2024 23:59:15 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru F0C8D100011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1711745955;
	bh=DrmO+tIeBCXapp2zcIeIlXqhuBgPFPDTHSHdR6pIN7M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=agDG4XBREf556BHDm9ibntiw/9IL8jHOPjRyLdUGYPiEcH+H+M8Gvz0uZGnIILq8w
	 1WEbNYmoh/jS4YpkzwBbgER2bxwXJcTp50gjw3BJJH7uGqFnesjSdzMmpuirac5WB+
	 pH8ZaD3qOgZJ+i+WjAhUHIMcVx6Tynd01DrfymQfL5We+fRxkiZIgYenaqqzJdhZNh
	 6PSgGip9wbi1FCIYd3DUgM0j6dsJo2TtRs+eDqLKP1TWdjOTvCcjTB5p18L9zARXdT
	 7PTGK1EkDBYzWPwmotM0d+SgcPObdkCRu9ysq0uvseH5bHHD0rXYUVFew2ttl6q/uh
	 SvDMUAdPF4Log==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri, 29 Mar 2024 23:59:15 +0300 (MSK)
Received: from CAB-WSD-L081021.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 29 Mar 2024 23:59:15 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
	<mturquette@baylibre.com>, <sboyd@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <khilman@baylibre.com>,
	<martin.blumenstingl@googlemail.com>
CC: <kernel@salutedevices.com>, <rockosov@gmail.com>,
	<linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Dmitry Rokosov
	<ddrokosov@salutedevices.com>
Subject: [PATCH v1 3/6] dt-bindings: clock: meson: a1: peripherals: support sys_pll_div16 input
Date: Fri, 29 Mar 2024 23:58:43 +0300
Message-ID: <20240329205904.25002-4-ddrokosov@salutedevices.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329205904.25002-1-ddrokosov@salutedevices.com>
References: <20240329205904.25002-1-ddrokosov@salutedevices.com>
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
X-KSMG-AntiSpam-Lua-Profiles: 184500 [Mar 29 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 14 0.3.14 5a0c43d8a1c3c0e5b0916cc02a90d4b950c01f96, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;100.64.160.123:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/03/29 16:52:00 #24511844
X-KSMG-AntiVirus-Status: Clean, skipped

The 'sys_pll_div16' input clock is used as one of the sources for the
GEN clock.

Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 .../bindings/clock/amlogic,a1-peripherals-clkc.yaml          | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/amlogic,a1-peripherals-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,a1-peripherals-clkc.yaml
index 6d84cee1bd75..f6668991ff1f 100644
--- a/Documentation/devicetree/bindings/clock/amlogic,a1-peripherals-clkc.yaml
+++ b/Documentation/devicetree/bindings/clock/amlogic,a1-peripherals-clkc.yaml
@@ -29,6 +29,7 @@ properties:
       - description: input fixed pll div5
       - description: input fixed pll div7
       - description: input hifi pll
+      - description: input sys pll div16
       - description: input oscillator (usually at 24MHz)
 
   clock-names:
@@ -38,6 +39,7 @@ properties:
       - const: fclk_div5
       - const: fclk_div7
       - const: hifi_pll
+      - const: sys_pll_div16
       - const: xtal
 
 required:
@@ -65,9 +67,10 @@ examples:
                      <&clkc_pll CLKID_FCLK_DIV5>,
                      <&clkc_pll CLKID_FCLK_DIV7>,
                      <&clkc_pll CLKID_HIFI_PLL>,
+                     <&clkc_pll CLKID_SYS_PLL_DIV16>,
                      <&xtal>;
             clock-names = "fclk_div2", "fclk_div3",
                           "fclk_div5", "fclk_div7",
-                          "hifi_pll", "xtal";
+                          "hifi_pll", "sys_pll_div16", "xtal";
         };
     };
-- 
2.43.0


