Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04144780AD7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 13:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376533AbjHRLLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 07:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356757AbjHRLKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 07:10:55 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2061.outbound.protection.outlook.com [40.107.22.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAF135BB;
        Fri, 18 Aug 2023 04:10:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XtrtAsBTNEItkmJIFrWKOzKjNEq3+TmXLgoNNl7ejgaZddudUunKVgOYzvdHyMm02PzrefFaRUdwU9ymGpVZYCni8WKQlLigIa1q9iAQwQOld3QUPB/Zqr8bcy3RatJiLRroFxu2f4m/KEoHd9mS3wSG1JFPZzYTTHQOh9d/YOco/NQO885jzV/CbzBfQD5YXlEudp5Xp9GK0D0YhcC3ZxTRHI5FX5dRy4m6ZMUtKVp1ur/pWMfTk2VZCK4ml2q3I1++Ikkw+okvMDQGYaImj8tFI8iT9An3Pk06bEbzXHpu/f7H8TazhpyjlfsrMdXOZgdXA5wt6bHkGH+d9o8OJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0B3b/ucyjOAYWlQFGDQjlTeWZr8CxeOTg0uej/vw2o=;
 b=h1S1Gc0bBNJpS/sL6sg2FQEwi5oYWBnOJkaTNcsqwmgufFFhlPIEiv6Mh18JYfIBk4/t699XUHSEn9XcdJm7CFBet5pN/vHNfq9PXCBnpQ5lPBlSULSPDJjDr4vhyELgMKKtxJPzn7SgCoezJzDgjzUVPGRscm5dJY4yuGhDjHgG197sz5XH45/sLAxftsTG+VTjjyWbvuRnbfne3JTw6QoRGJ2+xFkU1isGSa6DD+wed0YE4rSdvLP8hHc8GX9YGUEadLDxlFGRPpjXagiMzlkmnvU67DeeKDfXPLdpv8nWuycfnHC4KR8zY5QbnbEAnBeYeE2O7Jv9NBsvhH9ZRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0B3b/ucyjOAYWlQFGDQjlTeWZr8CxeOTg0uej/vw2o=;
 b=PhRdCliupZkjgIVFbFHH8lWY19SWcXuPJPaURCSJ9MDKEkTGcGuai983bssdRDS/ajgeuJhYTgJU2ATCqjNrx+2oKPyRWCNx5MFuhTNJhfC9fzhxqprqNQm5VJafYAI3ruk6tkzpR2DB2Z7Q8Btjve74XhxJkTN70FPp6a1mB24=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by DU0PR04MB9441.eurprd04.prod.outlook.com (2603:10a6:10:359::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 11:10:46 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::c19e:3b5a:c081:ce3b]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::c19e:3b5a:c081:ce3b%4]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 11:10:46 +0000
From:   Josua Mayer <josua@solid-run.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Josua Mayer <josua@solid-run.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH v5 2/4] dt-bindings: net: dpaa2 mac: add phys property
Date:   Fri, 18 Aug 2023 13:10:14 +0200
Message-Id: <20230818111016.11271-3-josua@solid-run.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230818111016.11271-1-josua@solid-run.com>
References: <20230818111016.11271-1-josua@solid-run.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DO3P289CA0013.QATP289.PROD.OUTLOOK.COM
 (2603:1096:790:1f::16) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|DU0PR04MB9441:EE_
X-MS-Office365-Filtering-Correlation-Id: a187c452-47cd-43d6-6c4e-08db9fdbc529
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GKSxJppszT4u/8PDg1uxYlpM5DAPhItr6tV49OcvLFhQPzMV5GqwvZ0Wzkddsamys2iZimCzNH17iMWuwAgMb6uoI0uPp8Ba8ukHZbo6udLCORC3he1EYAzpIK8Sym3fFDWorTJtIbdeKUPPaQ8W4tm+yUmeP0JH6VfkVhpEJu3XeLkDqZPu2//q+eWtlWjm2q5YgYXbBRsvIQNFplRy8aMvSV74k++zo/yHHsJUmI5dytkKeOScCHK9XPL8PxX3pDBpLwoDUlJi2rKpSU3erpio8yHpIHX3+HmKUMycZKB+RaKe4Vs4SzbOowgqVik6vWyWwYP1iSk2DghUEYuKxmU2E7F6EHtDiYe+JV9mFHjTu+hBCZgwEhLz1C0xl45cjBu95hFbHYgmahDDFbGFfEsFGe+tegc+OrHq9g2/bpfQ8/F4zWdorF61E09I6WJ3j5ArTVUvXqdXn0U/xgUapDAAiCxX67v8v6fvxZ7S6IP7uj4ryB+aRGRWlKmfahJPIN4AuESVSzi6lcknfY4bODxPTJc1r8zH1CE2GOIDDq35eiG4niM32mxeMlQ9BxI0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(396003)(39830400003)(136003)(451199024)(1800799009)(186009)(316002)(2616005)(1076003)(6666004)(6486002)(6506007)(52116002)(6512007)(4326008)(5660300002)(8936002)(8676002)(2906002)(7416002)(478600001)(41300700001)(54906003)(66476007)(66556008)(66946007)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OiUugkqnK2z0Prcd/vW6S3R6UY7SxE3a+QpLURTEtchu9bCS+kOJrWhCP+t0?=
 =?us-ascii?Q?8IkZ7VkfrtKSMAn5Vq92+7JVqLUWgvBweMyH56Iem4CAR3eKtHV5DRLERHUN?=
 =?us-ascii?Q?jsalSIfWMM9Hwh3uxzbx8aBxeFFQWN9bk1cIeb2STU9PGJrbY/zfzC5+aeav?=
 =?us-ascii?Q?R827yQnbxTBr9PODiioet9sJf5CF/Dx+2YowNUVWaLt2Q5bKChhuyznOH6ma?=
 =?us-ascii?Q?7GkAjxeKBsKGYB3mywk8Gw6hE6vKb4+/zYE/sJTvPrrkPlyTIXzKifuGa05k?=
 =?us-ascii?Q?JX4G0yVBy+KWj+WD34vxRb0RKEDZOlY/L5n5T6SShBj69THgRV4UEp5OUktx?=
 =?us-ascii?Q?vl/nAPtTBlvzPILIwAsYNTsDfuyr+xyEOIxhqV3LKx6ATqw4smvMxRPLLLrb?=
 =?us-ascii?Q?NSZAYdiJmviMF8DjDSZdNbn27rMo0VKh3StCqd4guJDNlFx00PzWJUYHnnu9?=
 =?us-ascii?Q?fu47U9REDyBayI4AAiSIyGiSWdSF18zwo56OnK0IlJely6rla42v1ra94oHx?=
 =?us-ascii?Q?RY66DRrRzl7RmY2GfG7f+ssf3V9oqhQeIcZSFxoUpG44zhboOrVZsZiclra4?=
 =?us-ascii?Q?+Tf5fC/EY03+GEUjUpIfNlW2S3uP0jxoVMAo2WQ1q958MAa3P6uUcLcLaFa9?=
 =?us-ascii?Q?Uu2XGnZkDuFDBwQW5yTyNEA0jWn4zsl6u/1Q78q5Bkhz+OJZHppDOupOGW1B?=
 =?us-ascii?Q?TtLRX9bAvpTIlp9CfcakbUDtTi1cYIOg4mmLJvtsEabXROi1tEeEtmC3WJDq?=
 =?us-ascii?Q?2UzOvdJPDbJpfNxJ9LS0iME56B4M8eugcKMXFg0GD0y+chZky0LWKRdZfqf7?=
 =?us-ascii?Q?YPzdkIZ7Lz/boZu4G5/UB+JcyDhHpfjuG8roGJ0oVKqsGwymE1BXx6ziyjLE?=
 =?us-ascii?Q?OpvFZOzOZlOOa2nD3UH+Dk47y5zyFQ9ZDrY57LwW0qE1NhCIDat4Dgx++vdr?=
 =?us-ascii?Q?TjRKcm4BKfRhSwYYJKPmjXWIsIuzfaxZ4FtK+maTrGCMR5N3VDCb+NQidztS?=
 =?us-ascii?Q?WPlBH6BvSN/yhjXlBp4gCubkbl7vfComx+7r5DedXkTDQal60scF1yaiTYV9?=
 =?us-ascii?Q?5Y9/xhnbkDYkqI7T1UOriV5LihFAdWkjwAMjMszPOXB/zlUJZC7wDNJqWpFK?=
 =?us-ascii?Q?hidUmVli0UnBvfFyO/FazdnkxGDq1w29nONXyUKQQxL274o+sCXJXXhAsRHI?=
 =?us-ascii?Q?rUpIdM7SN6P0ikCG7Qlwal7vP95mx3dqzy3as5RDTJnPC/yiFmIRFrzEqvvG?=
 =?us-ascii?Q?vXccEiLJKysbLxR1ygquEGV2VnlZuoVJo3upWqWs1i8SWu31XT2WbdAj6lhz?=
 =?us-ascii?Q?YY+CsxdPw3RpBQ5hwgPOmYaHySVYaTqD2DwwM4pUhcE/+/s7gN5jyfBwbTSN?=
 =?us-ascii?Q?RX3w56yrRXUXZVEqou3cv79csfZXEuXPFz/8eLP8J0LKzemhEMh0A28cZSDZ?=
 =?us-ascii?Q?3Q4jhyADjTk7LPE0l62Ub4BulEphABa36yF1SRmVhgLfSWzS+g/4vSfJAafI?=
 =?us-ascii?Q?UywwIVvTXXN83rhTthFelOhA+tfRJWkyfsP+ODO0zAkt/YSyAWD1MZFfLvq2?=
 =?us-ascii?Q?R5xqJvthH6JGoCU+qMo/b2VEKBeTol8X7NuZySDjpXSDLdi4HaiMRZXnVlCC?=
 =?us-ascii?Q?vHJ5r6WObxNajCnS67Moad4=3D?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a187c452-47cd-43d6-6c4e-08db9fdbc529
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 11:10:46.0497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HeEFUTE0x7REgRNuaNteSuN4LEDY/N7HKMSXIiXTbnBeXwh07i8m0C18rVx4BZtSpo96z8xePx0yLGs/Yqo5wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9441
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dpaa2 mac supports runtime configuration of network protocols on a
generic phy object specified via the "phys" property.
It is currently used with the SerDes28G driver to switch SerDes
protocol between SGMII and USXGMII at runtime.

Support was introduced with:
f978fe8 "dpaa2-mac: configure the SerDes phy on a protocol change"

Add bindings description for the missing "phys" property, to fix dtc_chk
errors present in various layerscape based dts:

'phys' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Josua Mayer <josua@solid-run.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
V1 -> V2: this patch is newly added to patch-set

 Documentation/devicetree/bindings/net/fsl,qoriq-mc-dpmac.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/fsl,qoriq-mc-dpmac.yaml b/Documentation/devicetree/bindings/net/fsl,qoriq-mc-dpmac.yaml
index a1b71b35319e..a40c7a84af2a 100644
--- a/Documentation/devicetree/bindings/net/fsl,qoriq-mc-dpmac.yaml
+++ b/Documentation/devicetree/bindings/net/fsl,qoriq-mc-dpmac.yaml
@@ -24,6 +24,10 @@ properties:
     maxItems: 1
     description: The DPMAC number
 
+  phys:
+    maxItems: 1
+    description: Generic PHY for SerDes runtime configuration.
+
   phy-handle: true
 
   phy-connection-type: true
-- 
2.35.3

