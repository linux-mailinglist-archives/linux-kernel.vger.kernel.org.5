Return-Path: <linux-kernel+bounces-20096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD66827938
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 21:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A527283E47
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 20:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EC654BE9;
	Mon,  8 Jan 2024 20:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nuvoton.onmicrosoft.com header.i=@nuvoton.onmicrosoft.com header.b="kfAEPqD9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01rlnn2045.outbound.protection.outlook.com [40.95.110.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479F855C2C;
	Mon,  8 Jan 2024 20:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=taln60.nuvoton.co.il
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YVWl6iN1QF8u1RSfewnGPBkR2wv56e1fS4lgQBT5ZK9bDFDhWpilP7su/t/zuWp2d2qjfiFS5rW6DEDbAl8TRackPHoQJtGR7t2DtG0VlS0Siaz5Dhuv1s+MbRnIr1IWgVK9lrQ2BojILX3L2Ec/cHFd6Gzo1JPpfkk2+D8Pz6q1QXtSl8+7z6buEKsQVEmj6J30QU8qdAXPjts9eorNZBpqc/iHnn7MCA+PYzkAvfCnBvaYRyD80N2+ePj+g6/i4X9XrY8VaLgQR+6u2SmSQyy426F5zINrA+T4UnIEyowhergR/KfToCEQNqzzapApqYgBhGrZjJKEjai9mgahuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zY8s7hL1jWM32I5tZuFHUstdY+XmbEDMFLcUrhza4lY=;
 b=l1VP2OCX0W36ClAmppWtgtealr0LnTmmlNp85ji2jRVCUwV3Dv20RZAvwKS0Z7Auk2GflhMz+bAMSq96x7Cr5YX2K04J/WNztXs+xb0FNE+wXfBqdMLck+jFo2VlxV+c31uQTfEAN5MLGDvYyW74k0KSi51Rzmnong6eG+psH08NjEPtURBd4fIA2QxoCKYnbiXLbtAH7yCZNVleFNkXfEynn5ER8XdMAwcG5wgbcMFbwYqrll+eUfM/2iSBvkWHKXazjZlh8L2FCmmV13VVc5cSEHhwrQrX3PzdQl201LeCdJyju+HWDZS5xCrdHUeyN4Fl+pIJ8R0WO2c5DZPhOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 175.98.123.7) smtp.rcpttodomain=baylibre.com
 smtp.mailfrom=taln60.nuvoton.co.il; dmarc=fail (p=none sp=quarantine pct=100)
 action=none header.from=gmail.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zY8s7hL1jWM32I5tZuFHUstdY+XmbEDMFLcUrhza4lY=;
 b=kfAEPqD9xvy9vpZus7mKjeFLMNDazR85qJBmhgG7nv0TQD2yQ2Oi+jYI5h1D3xKoiMug/4OFrSjLQKgHu8xkAo5RNQi/Dzz/3k9wxFS3JHCckDeqICxJSBCnOmcEJ14ZCUwzXhbHQ22G4FPN3a8dD6GRygTyWf6RZnQDZWdcp2U=
Received: from PS2PR02CA0073.apcprd02.prod.outlook.com (2603:1096:300:5c::13)
 by KL1PR03MB6286.apcprd03.prod.outlook.com (2603:1096:820:a5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 13:54:29 +0000
Received: from HK2PEPF00006FB5.apcprd02.prod.outlook.com
 (2603:1096:300:5c:cafe::74) by PS2PR02CA0073.outlook.office365.com
 (2603:1096:300:5c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21 via Frontend
 Transport; Mon, 8 Jan 2024 13:54:28 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 175.98.123.7)
 smtp.mailfrom=taln60.nuvoton.co.il; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: None (protection.outlook.com: taln60.nuvoton.co.il does not
 designate permitted sender hosts)
Received: from NTHCCAS04.nuvoton.com (175.98.123.7) by
 HK2PEPF00006FB5.mail.protection.outlook.com (10.167.8.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.7181.12 via Frontend Transport; Mon, 8 Jan 2024 13:54:27 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.14; Mon, 8
 Jan 2024 21:54:24 +0800
Received: from taln58.nuvoton.co.il (10.191.1.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 8 Jan 2024 21:54:25 +0800
Received: from taln60.nuvoton.co.il (taln60 [10.191.1.180])
	by taln58.nuvoton.co.il (Postfix) with ESMTP id A36305F64C;
	Mon,  8 Jan 2024 15:54:23 +0200 (IST)
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
	id A2E5ADC0047; Mon,  8 Jan 2024 15:54:23 +0200 (IST)
From: Tomer Maimon <tmaimon77@gmail.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <tali.perry1@gmail.com>,
	<joel@jms.id.au>, <venture@google.com>, <yuenn@google.com>,
	<benjaminfair@google.com>
CC: <openbmc@lists.ozlabs.org>, <linux-clk@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, Tomer Maimon
	<tmaimon77@gmail.com>
Subject: [PATCH v22 6/8] dt-bindings: clock: npcm845: replace reg with syscon property
Date: Mon, 8 Jan 2024 15:54:19 +0200
Message-ID: <20240108135421.684263-7-tmaimon77@gmail.com>
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
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB5:EE_|KL1PR03MB6286:EE_
X-MS-Office365-Filtering-Correlation-Id: fb3907f9-4e6a-4a00-3165-08dc1051544b
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
 yLLXCp249SaCAj2KB1EpIxy5hg/zAFIpIuArWUih9ulyeZmyFMfqOJed+6RTgS2nmQki7Aq+iFLkVSrTiJ8BQGFeF1v76Jax694LimXA19LnW188BA0hu0WNLB7tATiUss+K8UaXf66S+ZA3O77PkZZZnpKhICk6M2Yr4hVrhrflH+Jsa9rozcUAixOQAwynudQqA2XnQFbaK402IqpBl+PPQC+VfhDUdvMU/+U7eMhVXSfcu6wEHgcPZZ0tY8HZdiXPfNbcS+YY7lJA+YC6kVvpx5DREnw1DXYG4R+b7xFwz+C8P+/VKzmFLS1Pq1OTob/ZVikSOghSHzT42ESht0ZauJa4agwUni1Hn9Cc51/rknBG+EJqoGCGVnM4pxhL6ZUYMIOP/pcs2EIsrnwUyEXbEqzIGxCug7gHEVzuuSv04+w+FlQ7mdyD2ZQRUaN4mX9mkKlUJQ1xMayMnAxtIvkxJ8mX0QSVq/NM7WDxdzh8IrJfnba4BN4dU2nn2JwGiAf0z0TcBLReoDDDLudubUXZdV3OjDSJXFvWGAd7lvq/5q4PifX04/2Uj5OLvbtYAQSG87mjfqSphee9uJ2gJVWJVT4D3ghbHVz8z7dFlEY5ox186fLDccLHodhS9GGeVL27396TsBD/H2AsnkEx/9fnCrdswVb2IEMwuoBjbXvCPyHuy8oEdtWdJdhVi2BgrzZRP7p7yNC3OEgOUkG73d85xjj4VwfkZSX3xoFjDwdAxvZVWCkt+FbU3MS9UZkk35T54OYN1JYWYYwSRnyc6Fej1kz7Rl0vhkrSP98QUYtOuyY1z18Qxiq5IafJVYgabzH52n+hGXcGaNGRC6uxC85K9T0G0kjOKy46RdjhG9k=
X-Forefront-Antispam-Report:
 CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS04.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(136003)(396003)(376002)(84050400002)(230922051799003)(61400799012)(451199024)(48200799006)(64100799003)(82310400011)(40470700004)(46966006)(41300700001)(336012)(47076005)(1076003)(73392003)(83380400001)(6266002)(42882007)(82202003)(6666004)(40460700003)(40480700001)(54906003)(70586007)(76482006)(70206006)(2906002)(316002)(110136005)(83170400001)(498600001)(2616005)(26005)(35950700001)(82740400003)(356005)(55446002)(81166007)(42186006)(36756003)(5660300002)(7416002)(8676002)(4326008)(8936002)(45356006)(35450700002);DIR:OUT;SFP:1022;
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 13:54:27.0970
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb3907f9-4e6a-4a00-3165-08dc1051544b
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS04.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource:
 HK2PEPF00006FB5.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB6286
X-OriginatorOrg: nuvoton.com

Replace reg with syscon property since the clock registers handle the
reset registers as well.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 .../bindings/clock/nuvoton,npcm845-clk.yaml   | 22 +++++++++----------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml b/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml
index 0b642bfce292..c6bf05c163b4 100644
--- a/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml
+++ b/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml
@@ -18,8 +18,9 @@ properties:
     enum:
       - nuvoton,npcm845-clk
 
-  reg:
-    maxItems: 1
+  nuvoton,sysclk:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: phandle to access clock registers.
 
   clocks:
     items:
@@ -37,7 +38,7 @@ properties:
 
 required:
   - compatible
-  - reg
+  - nuvoton,sysclk
   - clocks
   - clock-names
   - '#clock-cells'
@@ -52,14 +53,11 @@ examples:
         clock-frequency = <25000000>;
     }; 
   
-    ahb {
-        #address-cells = <2>;
-        #size-cells = <2>;
-
-        clock-controller@f0801000 {
-            compatible = "nuvoton,npcm845-clk";
-            reg = <0x0 0xf0801000 0x0 0x1000>;
-            #clock-cells = <1>;
-        };
+    clk: clock-controller {
+        compatible = "nuvoton,npcm845-clk";
+        nuvoton,sysclk = <&clk_rst>;
+        #clock-cells = <1>;
+        clocks = <&refclk>;
+        clock-names = "refclk";
     };
 ...
-- 
2.34.1


