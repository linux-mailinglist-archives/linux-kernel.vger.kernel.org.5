Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0AA27B46EC
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 12:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234860AbjJAKee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 06:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234777AbjJAKe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 06:34:26 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2050.outbound.protection.outlook.com [40.107.21.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E47DD;
        Sun,  1 Oct 2023 03:34:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d/rotzMBaZxxCAmqb46fgYCb3OLuf5HGSeV6whw0Hh7F5TBWi5PXfcMLObETMKydeklUJaa1zerccm5nike0aLF+i0EjE6DVPtgHkLWXzzEIbe5j/aZ2qTL223acBTXeYTjL8+CFaNMKAXO+n8OP+Xm7vqLTdzws+GLt8bFAs1KIqv0l0EiR5o0TcuftXnJZrY2Qe7s/OS846SR4ikrUwXTUNc/BBnOduIIasQ28DDV72X1GW0sehV74QHZ6NxHcCp/uu8E425EQWJZEBnc5crbE+HK32NIBmLrTdbZ/Zt4mZwJ3/Z3rQ52S2PlnA1uqtfkm9pQNbO0G4ySb5q7TUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/kMZRWg37MsrhxB0ve8V8H3Ak3czJa/x43C8INCvUg=;
 b=LTSelEziQd4YIqRGIWxTGvciXsRsmQMbkcDYpH8XYolfLVe2SbpaIkFp7T/UEgnHSLnoYfMmXEvHWEEWLNlyMrhUW/PCIt7wtQEfrzUHz+Wd78RWzMovLZkzDY5rLdRh/P15yV9h1uklvcbrIqWknIG+enGFkLE9exHwqatu7nwztJPfds0ijuaY8IpSyDqciVujFFUAznPjPthhoimnY0ABxj6zT2SLudF7N3Tpyo4zJ6Ce7MNopqU7LOt+OrrIzMZmKcMRJ7DKJ8LUNG8rE7WQitI1gaouMX2Coib+iCY+/lepQHVf8xQjL3oos7gPo24maSQ73OxlaCSiPa4oJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/kMZRWg37MsrhxB0ve8V8H3Ak3czJa/x43C8INCvUg=;
 b=qz4Ic4KRASUZKynetRfZpF/mla5RgolEfrS1qbQICHp7SgZ/3pruZuhZd0G5cg4qHAoVxE8N3rBT3hZTaeIghr5p+xomGlWlwhaMm7Euoky9s4BuO02ien0a+oNriGxd6jgSHh+57TxeV4iEGKOMj4k4a4COa97BvYd3mDVR6G0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by PA4PR04MB7584.eurprd04.prod.outlook.com (2603:10a6:102:ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Sun, 1 Oct
 2023 10:34:23 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::cc84:fc7a:cffe:985a]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::cc84:fc7a:cffe:985a%7]) with mapi id 15.20.6838.024; Sun, 1 Oct 2023
 10:34:23 +0000
From:   Josua Mayer <josua@solid-run.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Josua Mayer <josua@solid-run.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Marek Vasut <marex@denx.de>,
        Fabio Estevam <festevam@denx.de>,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Jesse Taube <mr.bossman075@gmail.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Li Yang <leoyang.li@nxp.com>
Subject: [v6 3/4] dt-bindings: arm: Add SolidRun LX2162A SoM & Clearfog Board
Date:   Sun,  1 Oct 2023 12:32:58 +0200
Message-Id: <20231001103259.11762-4-josua@solid-run.com>
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
X-MS-Office365-Filtering-Correlation-Id: e3095e1a-8f72-41bd-b42c-08dbc269fa46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wFf//tLxw5mOe00MGsTbE60VJt+tGhiKTSAVisGudFfiv4iavtQgTri5M62/YcKorLYTwXTwtNx8ir55N/qu+G9fkwsTy+iBn5KZbMttJv/npKqaSS6sjDEiz0t4ne30Y47oXxvZmKlkZ8CPn1qPpRAZEdF4cykbq3nuchJi+nsFT7ABhBMctt6X70xMB8DGTp5xW4W1GQDUEc6vAStc3FjI8h0OOdWTniW0MTO7pWDDeFBm/6o5nBYDRk3Hzw8zqKO8wVhATf1tiCED6v9MSgKfnh5aIzrLNTylUDYcCpP27UTINpONP3GCbX92zEHynwrXenXW6QiYCYJbUDZGRO1U18EKWLXf73ZDv9W/Uv66vhpTSJ7jOG8OrBlcmVVuODZTYFb6K295k6GM+VQpqPoND04nOZ7T2WJHg5opGmtvNzopzwXWZkprvZZWYe7R0pvRJFjjztJmvfKXQunDr1u9Kay8peqgvrK8I5CAmFyX8sich4ivbh83ty4ZjlFbFBYoiVm8peSAWs+xp2JMHrlgk5kKoq6bNBswIatxCccFNb5/upY5PBGKGTuyktJ8+9+oz+mntH8bkoQxkm1Tw4x9lWMrrgfUZzPXTcOqScJIqLIH9ONlFigwL5qVMR3E
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39840400004)(136003)(346002)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(41300700001)(52116002)(6506007)(26005)(5660300002)(8936002)(54906003)(7416002)(2906002)(8676002)(4326008)(316002)(36756003)(86362001)(1076003)(83380400001)(6512007)(6486002)(2616005)(66946007)(66556008)(478600001)(38350700002)(38100700002)(6666004)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1BUabvV01S7jaFL+3v4IkDWjGQUarAqmpEseDLmnSUho1PJnZYhbdUjHkiQt?=
 =?us-ascii?Q?IvzAFO0ucRzB/Eutf+9OppEMQGcKVEyvumweE/LAa2xlQhT0Me4KzVE27rk5?=
 =?us-ascii?Q?Mdo4doqaSuzhbDK/UrHLX3KruUBzRBurUJBimx/p9Z6gUqiQyn1PCO/+VGzF?=
 =?us-ascii?Q?0MIX7wTpaiVmmZgcNWdJWnAYJRmQFhqmPB03WbsdEnCVNtaFCfmDVjoG55uR?=
 =?us-ascii?Q?8p5StPtESDGi2Lp+v/3jKQFlnPNJE0bySG91aXlEmdDpAcf2x6pg1n//IkPm?=
 =?us-ascii?Q?ZRUphQtxDHCspFFPZGAVDdOov8hSCp5AfJ6QcffD2S7yBlJfuxZHGQAO1oLl?=
 =?us-ascii?Q?3USH+HM+OW5HghVqclRokd6a59DrBWqPMIP5fIKgnr/8Q0QU0Vyp0TteUcCS?=
 =?us-ascii?Q?TTD3ziBiZsWxQdOrdBrHvG17prMU6qxgPuKJQhRJctESbngx7LqboGGLN69q?=
 =?us-ascii?Q?OA2dEwbtp7Joyk30xo9oPc61fEv1jDiwnQ8RCWSZQJuyikTsgVSn8AUTYhBo?=
 =?us-ascii?Q?1TY8WiVJAmuYu8rK8zFRMCXTo+kNaAdnGCVLZTsYTfq9LrEz71L0ycqy2cjA?=
 =?us-ascii?Q?RfSpmhiRvkLrN/d0KtybX+iuBXoyoIhw+E+8Oi3iIC6YtyKT70kqxiOhI4Hv?=
 =?us-ascii?Q?BbS/ImCssRD/zPsO9pZ6vtBTRqoS2mtEK5Bzgao2MzHtftOSnVgMsTknzqDt?=
 =?us-ascii?Q?V5KuzLD9DoPEtKupWLTIk9V4CKnjrQPCbd4EMPs4LqoC3+DqxcfknpXDyf92?=
 =?us-ascii?Q?YHggB7/RHJ2L2Ca6YVjQf3AZ17FIFcDbY6za4MI+g/1g1W2yCEww4XXOAHy5?=
 =?us-ascii?Q?GlJSYrli8VrHhX8422x+/TJuDZUK1D/KjIEPJ0NOpTbsADZyw8WD1/4n4E49?=
 =?us-ascii?Q?0Q6zfsuBtYPPmWBflK0F+9uiZqB/zlQZQ0QdFvO6EEvY8D8tDOBl2E+r82a6?=
 =?us-ascii?Q?18PVZL50pDTzHwyzSFfYlejJJXDiymcJLYRDo6yubCbTzZuqfFIAueUP2Zbc?=
 =?us-ascii?Q?L6Or9zQTKBjRvX8HgWjIfApTH0dLKgfyAAfLi/DmtJOiR2/BRvwbF5ruZmxp?=
 =?us-ascii?Q?2/rkZJ8MehlJb0nAkF7hB0AioQq9O36xvq8CBGSTUXx5xCk0Tckr0nBATkj4?=
 =?us-ascii?Q?FlNvJTKPpO91iW/NPyyTHh24sWuuFtc3LEyF9wkPVboiMt7psgoq+7iA7ncf?=
 =?us-ascii?Q?86mPCS+Z6IAdbYC16gzigBvBF91fCuechqc37hWEShl2heXhSoGhWLTnE501?=
 =?us-ascii?Q?Uhk/9pGA9jGVih0MyqdRm++LcPuA2QyjeN2VFphH84+99EIE9Q1V1q9Pblxa?=
 =?us-ascii?Q?Mvb5gxTusLXWqTJBmzIPluZkh+PytxO/T40hOxlyRExZc9URPPjKoGvvuxXW?=
 =?us-ascii?Q?nqJ70bTM0qfUEwRSKxbQCQCIU7iZdRTc55tW0lvC7HvJ2js8XLRv1bkSfink?=
 =?us-ascii?Q?th/ump/UtRMgLx4d55tkSc4/RoqQflS8VTADf83EfGl48kpcd791zyWYKNeZ?=
 =?us-ascii?Q?N2nmsxW+9qIpZkboWr4t24BsHVTmeEoIYgoo7dHQ9afh5suYwQPSqOCCcwcW?=
 =?us-ascii?Q?DClGqWIGZT96f8K70FxU59vm2bkmgQ/zKWL4jt8t?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3095e1a-8f72-41bd-b42c-08dbc269fa46
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2023 10:34:23.0695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xf0coUCwBaz6rW7+sTmk/UqvzU4fKF078dI86F+nxNyaViOdVLQzA19eihStAAOrp/zkLuDa7OJ5mHTbqX1N0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7584
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SolidRun now have 2 product lines around NXP Layerscape SoC:
- LX2160A COM Express 7
- LX2162A System on Module

LX2162 is a smaller package and reduced feature set to LX2160A;
LX2162 SoM is also a smaller form factor and reduced feature set to CEX.

Since both product lines are physically incompatible,
the existing group "SolidRun LX2160A based Boards" has been renamed to
include "CEX" in its name, meaning products based on LX2160A COM Express
Module, following this pattern:
"solidrun,<board>", "solidrun,lx2160a-cex", "fsl,lx2160a"

Add DT compatible for both SolidRun LX2162A SoM, and LX2162 Clearfog
boards to a new group based on LX2162A SoM, following this pattern:
"solidrun,<board>", "solidrun,lx2162a-som", "fsl,lx2160a"

Signed-off-by: Josua Mayer <josua@solid-run.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
V1 -> V2: fixed to not break existing boards
V1 -> V2: explained new board / som DT binding in commit message

 Documentation/devicetree/bindings/arm/fsl.yaml | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 2510eaa8906d..ff9bf9956972 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1384,7 +1384,7 @@ properties:
               - fsl,lx2162a-qds
           - const: fsl,lx2160a
 
-      - description: SolidRun LX2160A based Boards
+      - description: SolidRun LX2160A CEX-7 based Boards
         items:
           - enum:
               - solidrun,clearfog-cx
@@ -1392,6 +1392,13 @@ properties:
           - const: solidrun,lx2160a-cex7
           - const: fsl,lx2160a
 
+      - description: SolidRun LX2162A SoM based Boards
+        items:
+          - enum:
+              - solidrun,lx2162a-clearfog
+          - const: solidrun,lx2162a-som
+          - const: fsl,lx2160a
+
       - description: S32G2 based Boards
         items:
           - enum:
-- 
2.35.3

