Return-Path: <linux-kernel+bounces-20039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6286E827887
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 20:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC5CFB215C0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8F855764;
	Mon,  8 Jan 2024 19:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nuvoton.onmicrosoft.com header.i=@nuvoton.onmicrosoft.com header.b="E83Rq2hT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01rlnn2059.outbound.protection.outlook.com [40.95.53.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7E354F9A;
	Mon,  8 Jan 2024 19:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=taln60.nuvoton.co.il
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CdBqQlcv6XsPhDb7IWYDv5qkbIEK1iakUm3eGpTg/Z1mOZ95bMxaHN+sINEtNKSjvYkPsHw4xDvRb1PFobo9okQmpUYX7OpbjtJ/L8kqXv3RxNLiwBLtltmP+/1gOap4Xl99sWY+JBYsJjNguClG6GYol3+522Odq10lwfc3lOlmyOeVHOCNb4igONtCpmzfSev7oXZ2cAOwF6T64MvfB/ylKz7oLq28t8zjwhARsbPDUaTmzdLqz5B9StlNjZYUybU+tZSFtzqitHmWHdjPUD77UB2GXGdgj1OKHFRI8b42ZEsgjMhLZr1rOewKUnwsEw7msm7F9yEh1pJtSDG3mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oTDBqhtG79Qcgr0/MTD7QS5cQnpcScK+QVZSf3W+EIo=;
 b=NrzOcVOVRoKex6cZ2zULgI6g+M70W64dlnqq8cySk4gFATP9pnd5tkftueAGPLjgM5/LmL1gDr07jTWs+v9i18AnLvFAmTX+Q+OWTgsGAQvSYXTnSNsuoLTuuMuyLiqMKa5Zo/QIkXPzKqOpR9eNST6Zp9aXuTmT0i+FuN5l/BSUEGmlKcjeHf0PH5W0kLXRpUkWwnY8O3AXRbWVOzgC9uOcyberOvn6hQuGVeiMS0OzxEqsqe44mWf2e9wSGUW0LX1nuVCVqOyW3qCAHgjXbrLC8kxIAplDH02VE4rOYl05pGUxLQyrTZ3G3CiflBprSrVKve6FskzQYE2NOfzd/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 175.98.123.7) smtp.rcpttodomain=baylibre.com
 smtp.mailfrom=taln60.nuvoton.co.il; dmarc=fail (p=none sp=quarantine pct=100)
 action=none header.from=gmail.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTDBqhtG79Qcgr0/MTD7QS5cQnpcScK+QVZSf3W+EIo=;
 b=E83Rq2hTHFU2qOy0cch4UuQZZ2I+e54l6+KRAM7c736cTWeXXVRgiIYnSGYWNuFEXQEmKJW4PacpdOMqr6TamatGepjWSedXSesVU6dnlWr1+OFleAmuTrMuX0llMsFsi46XqLBwg/nh4k9GYAMrKmlJTdi3I1DJzLSp5/8F+JI=
Received: from PS2PR02CA0092.apcprd02.prod.outlook.com (2603:1096:300:5c::32)
 by TYZPR03MB6621.apcprd03.prod.outlook.com (2603:1096:400:1fe::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 13:54:26 +0000
Received: from HK2PEPF00006FB5.apcprd02.prod.outlook.com
 (2603:1096:300:5c:cafe::a4) by PS2PR02CA0092.outlook.office365.com
 (2603:1096:300:5c::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23 via Frontend
 Transport; Mon, 8 Jan 2024 13:54:26 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 175.98.123.7)
 smtp.mailfrom=taln60.nuvoton.co.il; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: None (protection.outlook.com: taln60.nuvoton.co.il does not
 designate permitted sender hosts)
Received: from NTHCCAS04.nuvoton.com (175.98.123.7) by
 HK2PEPF00006FB5.mail.protection.outlook.com (10.167.8.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.7181.12 via Frontend Transport; Mon, 8 Jan 2024 13:54:24 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.14; Mon, 8
 Jan 2024 21:54:23 +0800
Received: from taln58.nuvoton.co.il (10.191.1.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 8 Jan 2024 21:54:24 +0800
Received: from taln60.nuvoton.co.il (taln60 [10.191.1.180])
	by taln58.nuvoton.co.il (Postfix) with ESMTP id 6FCE75F5FA;
	Mon,  8 Jan 2024 15:54:23 +0200 (IST)
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
	id 6B50EDC004A; Mon,  8 Jan 2024 15:54:23 +0200 (IST)
From: Tomer Maimon <tmaimon77@gmail.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <tali.perry1@gmail.com>,
	<joel@jms.id.au>, <venture@google.com>, <yuenn@google.com>,
	<benjaminfair@google.com>
CC: <openbmc@lists.ozlabs.org>, <linux-clk@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, Tomer Maimon
	<tmaimon77@gmail.com>
Subject: [PATCH v22 1/8] dt-bindings: clock: npcm845: Add reference 25m clock  property
Date: Mon, 8 Jan 2024 15:54:14 +0200
Message-ID: <20240108135421.684263-2-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240108135421.684263-1-tmaimon77@gmail.com>
References: <20240108135421.684263-1-tmaimon77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB5:EE_|TYZPR03MB6621:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e49ca8c-c36b-4473-68b1-08dc105152de
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0bJTba4SiXT+jOHiz8pSm9kXAbUZZxwGFYdY9+/LEv40sDCIvSkLL5+nBvzDw1Tcl/F/uI/jn00gqfy3JhvJ0imWDgd0KOgaMef/EYuKgpBTUBE0WWYFThSkwZq5QN4tTdO+YPL7Oa0VTe7NDdGxtJ1R9LerANqsUntfWJrf6xr7n6mMHnl0chVDm2OhCZbgBNubcaebN88FFYXJYiz11tI/rHQutv28mJ51Q/lznqvBgg4EVMQIkYfeeeeC/CIA/tS+CMoIaukAwHLDvtd4MwbP7/vQnbZIbqY47xQfs+yLHxMrTB3EE5Qf5R2sdZ//cK9F2JAxVCLuzjwmYs7aH8+ss03x+sO0KbYN9l7NESAXzqGuXsnV9itfquKv8FBb+d/ZxPQK5wJNaYXv4JNDF2BoY6s7CwiDegkARF0BLN42GTSR//J5AU9XEYeJ5k59vGoiZOITX9JrVQE5EITfJ4Fl/BetAD8ijq35dVcVsIWwbksDKLMnxzJ4IKPbSWWnnzhSVOK3Y8pPYNaF+fVYwpSK3bY+UL6/L4FBSmDVKzOthRfPZhXcfDpB0iT8dEpyt5YcFQhFsm09/6uIFyol/794xDwuEsau+0d8xSBJng99PgGNaPmu+K4XS4LNhKaHkuB5LGj7rlQPS0eZkT+xe7wEovKImapfNKaqFi+exx3lvKzqViwdpYL9cbQ6yrWxrFvWFHuXfrE8ElbDLeAXnH9PCKOEl9DpQyp+EMgK52H2Q1aMTjm4Hk80xnSND6bZlNew1bu6GdT0C4cXmEIw8U/of3eCNVy/29zEWKDSjGy0eWofxj4IUEqw9aMG6JLK0j6OrSJDmR4VLwN9H07Z/UklD4pHkZiK5WI8sJFVQogkl240UD8Hbql+C7ksX+Hm
X-Forefront-Antispam-Report:
	CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS04.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(376002)(39860400002)(136003)(84050400002)(230922051799003)(230273577357003)(230173577357003)(64100799003)(451199024)(48200799006)(61400799012)(82310400011)(46966006)(40470700004)(40460700003)(40480700001)(6266002)(26005)(2616005)(336012)(1076003)(6666004)(498600001)(82740400003)(36756003)(55446002)(356005)(81166007)(83170400001)(2906002)(5660300002)(7416002)(41300700001)(47076005)(83380400001)(35950700001)(82202003)(73392003)(42882007)(8676002)(110136005)(54906003)(42186006)(70586007)(76482006)(70206006)(316002)(4326008)(8936002)(45356006)(35450700002);DIR:OUT;SFP:1022;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 13:54:24.8002
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e49ca8c-c36b-4473-68b1-08dc105152de
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS04.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB5.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6621

The NPCM8XX clock driver uses 25Mhz external clock, therefor adding
refclk property.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 .../bindings/clock/nuvoton,npcm845-clk.yaml      | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml b/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml
index b901ca13cd25..0b642bfce292 100644
--- a/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml
+++ b/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml
@@ -21,6 +21,14 @@ properties:
   reg:
     maxItems: 1
 
+  clocks:
+    items:
+      - description: 25Mhz referance clock
+
+  clock-names:
+    items:
+      - const: refclk
+
   '#clock-cells':
     const: 1
     description:
@@ -30,12 +38,20 @@ properties:
 required:
   - compatible
   - reg
+  - clocks
+  - clock-names
   - '#clock-cells'
 
 additionalProperties: false
 
 examples:
   - |
+    refclk: refclk-25mhz {
+        compatible = "fixed-clock";
+        #clock-cells = <0>;
+        clock-frequency = <25000000>;
+    }; 
+  
     ahb {
         #address-cells = <2>;
         #size-cells = <2>;
-- 
2.34.1


