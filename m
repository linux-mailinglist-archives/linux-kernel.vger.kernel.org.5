Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12BF67B46EB
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 12:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234845AbjJAKea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 06:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234820AbjJAKeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 06:34:25 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2050.outbound.protection.outlook.com [40.107.21.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDF4BD;
        Sun,  1 Oct 2023 03:34:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ak49z21MEI6jU2qZmV9Ekba3XeS4R6cNHIC5VYGOellLlQRby/X4jLjZ2DbcIdZmaczFIY6Xn8s61e3K2FMjRkzxvplyNj7OGwCg9YPSmcelbSk4Eaz1ZJDpTFLJ7+eDH1MXYyE5wCHnJBPANP06+jU11N1SdAvXjpfqCQrJxDvsOdJ7S9j2c0tX6NzIfkdRMgRm65IH4/45f5xNPcTkXlZPKUGXqgchr4Mq5YVPXCWmcJhdNyrvuSLZ8F27IE3nO5/BhaEu8sLHIjb/5XPT1AovD1mGzrutWriWpTUZy4W67Q08icBq/bYw0wsMPJCvCDARwBaiR9k+PSYptN9KyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0B3b/ucyjOAYWlQFGDQjlTeWZr8CxeOTg0uej/vw2o=;
 b=PrGKA78J2VlVxurDZf13CLXUdXyjrN2I1m7TW3Pi3MGq2TrZhA+0t+L/1NpmTw7nqLCcphB/RBhW6SI+SpBq3cTu+jnvQPbCjRcxPe7f3+JAckJQQeu7glgsDjiAy4tU2B3fFslHld4ew1+WM/sjoy5q+bYv882Of+/O82jwXXq6tPNnjQ0ZonSoiQ9hx9uLIDWq/L+vh+Ea8dbdiljmiccfAgVG/DnuWlCILxa9fdLS55lj0kSqJzOqAMwcmSZMB/RihK1CimAMrGJHb48q+J7ijxbD3S1+p3qpoiiZKCF6l4/3VWo/Um7IIBqItCqyfjUq0Rf/LFB+LiQKDFQiuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0B3b/ucyjOAYWlQFGDQjlTeWZr8CxeOTg0uej/vw2o=;
 b=pW03eRS4tPMWsoVX1m8ysN7uNGF9CDNBNsV5OKv4EuhbGSK7puF7PSZFkQgUlsr4A/icXd7diqHFZlcZJZV0gql4i1Pw7GGw+UapRsaszXj4+hR0IowBku7Z3N6b+i8nWqW1dsUA5ncQQ19mn74s0DEGs6zjtgOsHDWK5LT1NRQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by PA4PR04MB7584.eurprd04.prod.outlook.com (2603:10a6:102:ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Sun, 1 Oct
 2023 10:34:20 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::cc84:fc7a:cffe:985a]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::cc84:fc7a:cffe:985a%7]) with mapi id 15.20.6838.024; Sun, 1 Oct 2023
 10:34:20 +0000
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
Subject: [v6 2/4] dt-bindings: net: dpaa2 mac: add phys property
Date:   Sun,  1 Oct 2023 12:32:57 +0200
Message-Id: <20231001103259.11762-3-josua@solid-run.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231001103259.11762-1-josua@solid-run.com>
References: <20231001103259.11762-1-josua@solid-run.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0151.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::12) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|PA4PR04MB7584:EE_
X-MS-Office365-Filtering-Correlation-Id: 27133236-5a75-4f5f-7360-08dbc269f888
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Dwf+JRPgousJjqiiN+aQRUm0dKFggyB0WXscu5RyZ2Nd4UpHVm+hpomN02xj8IP33Rly1IfjYdF8u6tnZNMsCvb7e+H/6wNsi8d9x9Li6gtL+Z6AaX9GeZQyXH8b3hae7+Adk1mEZ+IXahZIjeCL0qTumwEmTbBFqtq9vKiswKuCWUNCCa3TLuiq2eHNw36/jPpCSpgnsJUnWnujIDliUP7aL+N2zothdZtIdkZ0RmBIp1smTDcgM5bcC/oIIXsZChLr+EBLrTbIarQaiD4eZnP0fC54neCC/GrLVpXeSbeOkFJxyfTuhB516D+L7TlnrkYx2NAk6inZ4kKV+qFhXnfnP4O/zaM8K8ATm0BXBjmONWvn2yy2kojlzK/gOOj+T6mdyGaNWZM2LlDS4aYFaQXg74H68bwce1jMhadNuZj0HAPm+abU55PsnvXg0FS/fCfoyA4R340E1LeaK8VcBAYu6wvbBwJemR4cWMBD84domZr/EsmX0ufy9S161IkNjqR5sMCWwQLvGfM49Q16Cl9m3cCiRYc3aKCBcX2e3QHpp2W0GTXoj28fWWoR5xL5xC66sgFpzw6XiCSftzWQjM+xNOgG+9qb97Wgt9s+QGapSbiMQaiRg5Ebi0LVe/S
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39840400004)(136003)(346002)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(41300700001)(52116002)(6506007)(26005)(5660300002)(8936002)(54906003)(7416002)(2906002)(8676002)(4326008)(316002)(36756003)(86362001)(1076003)(6512007)(6486002)(2616005)(66946007)(66556008)(478600001)(38350700002)(38100700002)(6666004)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zvNJQ46so43I8iwdlF6dTSDLcqjbODzGz5Nl7ENlU8daght61Rpww8LMUiQc?=
 =?us-ascii?Q?glgjbJXc709tOsw+7VYBpG4uGu9vGkA54NJTuFUFuWYbro60XxdmQx9+LIEw?=
 =?us-ascii?Q?4L6bWsOx1DUGfuEZ4R99eqM8B6d3Lh5wEPuwLc8Xtjv/Azrz/zs7aKNbqgtQ?=
 =?us-ascii?Q?zf2CYDzA/ahIXX0B3nttZABddMFSuK+9jfXm4PXngf7Cfj23cPUC1TwuxHpp?=
 =?us-ascii?Q?HJZ31Ku4n/2LQl2fwRvroolRPqVugNemRaC7zvfK+pDN3rjIrTrBZK7Gnmys?=
 =?us-ascii?Q?DATGrXAYfPG6dtAx5RTOACCB4ZDvVU5jZhL3sNO0eokbZawQQJwyTRgrp054?=
 =?us-ascii?Q?bgrDxeLmVAU4bnjDuBQUcTCrxNJTzsKC8HdAq/ws4oAYora6gh79XqiwOBGu?=
 =?us-ascii?Q?XzhejHRvS0d203eEltcSqFlwE5Ff88zGzErIg/OoZ5oUq2NcK2EO8bmnOZG+?=
 =?us-ascii?Q?USGOlp0pnRULUTO1XMv2sDglpTa7hexQ5k6CeNpvgn5C6zQwKVJxx8gOttz6?=
 =?us-ascii?Q?4Qr6Z6NwnVxOSKJrP0Ko+HXuvESRFXQXXlWmOY8LCHBVzf1BErF4BfjDXPuS?=
 =?us-ascii?Q?UWEJWG6nbhiJ09sXbtaWbrOMEPhvwiT/QHpDa43B1RGu2m0p1FEjwFGwc2yG?=
 =?us-ascii?Q?6ZLZDUxxDD1U1sic3aNcVYoku3wxMvRCpCoGfUoTR/uuU+Jv83SZdjwseR3L?=
 =?us-ascii?Q?i2tWjYEexMlajZUho9dF980/Q3bq8bdtk4GLSFk8tqsmGsQ8o+Wb+FlRI86u?=
 =?us-ascii?Q?jGetYi5yTFmI+4O5uYjF9hCtAZh+M6eK1SERrEJj6RatfpVubimLVa9FWAVx?=
 =?us-ascii?Q?V2UL0lKuZk38CwyphjYUhXI2AIEfSo/BzTU0yvQitZ1m0SH/I5CVu7GMZ880?=
 =?us-ascii?Q?/Ng3aWqRLFebdG6f9Zh1WOEvPP8R9ZA84FWJgKpTHEtB3uU3Bwx2oIGCMLKE?=
 =?us-ascii?Q?/3mmmdWnAhrBLshyXLc0z/oqFmFbjZDkPaEuHhvLUi1u0eRGK+7jvbzXq5a9?=
 =?us-ascii?Q?qBXtixs9hIzYUu4PHBqOAxpicuHSffocL4GRLmyvzYXcnOi5R6whRc51stRi?=
 =?us-ascii?Q?syWWcLKm7UEvdXbVLPpAgvGmHCxQp+b84qQKX8jbWxkePPCYkird9yLzpWTa?=
 =?us-ascii?Q?GR+mrHxUDtg9bNELsiBmzgZejt1bdHmviQBxGVNdDr382G9dRgyRiDvxw1cv?=
 =?us-ascii?Q?BdGsislVKZSBpg4+0jFgDAmWqyQITCClymOuvqvxGVsArng5B3AtIZw250bH?=
 =?us-ascii?Q?bgU3VFZJduwMmkLk0MfGVkzU7T8+UE4d0QggpCX+Bv1thhlFqnLQn3VZGTnS?=
 =?us-ascii?Q?k9j4nVcOoL/Pww6/vHFRLHy8mzM1+sm0xEsnMi9a49Qmpp0gd37+c2S9cFD2?=
 =?us-ascii?Q?8YYCZ9sQeL+2/WPCMvcQMNxFc1XzkjOawez2J/pVf+xv9VhNYQds/HNZaLMa?=
 =?us-ascii?Q?X1VHM9/dsYl5Fp8ebC2J4IdhUod7PLjICOl1IWQms/Q0TE6q0UUAg5dbUuJt?=
 =?us-ascii?Q?ZEzfuJWWbmBTS3cvkPxPqm+1eEisZyBD5wMm+LDzVSKHCNgP4frmK7NrOMrq?=
 =?us-ascii?Q?CLLnld9sDjN1NZuTfpWoGqe795wilZn8zJSoSIhb?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27133236-5a75-4f5f-7360-08dbc269f888
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2023 10:34:20.1708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bvgKhnVWA4RYPQnUM6RfpTkvv/yQoEE7EuGO/ovGe/+e74dZPBrKGbjvhrcA4zQ2KWZDTG1HGfx606M6yzPoBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7584
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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

