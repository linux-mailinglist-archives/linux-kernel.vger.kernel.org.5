Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B4079D4DD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236380AbjILPbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236414AbjILPbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:31:13 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2051.outbound.protection.outlook.com [40.107.7.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB0A10F1;
        Tue, 12 Sep 2023 08:31:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TRbMeTImFNFlVYyh4Y1A6Ys2hy8PrCKUpLT1H844xrXHdIgy4ENr1RzGzNJtCIhCaK/ulmPNm9pdWDaT5x1sQfpZb9DXG1C4Y4rgI1gvuAfBEisersi6WeSpWD2g7RFUJXmP1cZFxGgsYic4iAuuwl4hiijNsNHCgPBvnfAIhJ1R5Z6VZz94G+TyLqzDt1Vk2nIwmY4RrHrbNLalr4AjLlGW6h/Uho0UwbnPoDGQadOWJXejVoJtOJE8blPv2dQdJT5WqT1ZaxmYsRV4UOe6q5kNc2zX9lOmepQA/cVTXVam0dLJRFEXZFSvQo8Wma4730pMYCu0iwJyn4bQZNDjKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=spsaVNUNh/3VFuawqy3mCL/YNz+pKrVAaVclE+J7sZ4=;
 b=ezW8zAGtqqhFa5AWU1buZjPbGPTD8opOzcfysmXg4nweqriym4API3Ar1h9oCJ2bSg9Pd/ES55+orOY8EFh/v9h7JCuHCxz6Kbo4PJZT1PD6MYzY83xak3bipnGdJSmfchrHAqAw7TFzxvcY7sfLvtGh7IdavqoyO/OlHaWWwTIzzmVGpT1fzmckNODvJlwuO+j6xWvY7DGzI3fl8oT/eOWvWNiyMMjR4X6n5B5V5HoT3XCOr9rxOL5pKEuhYQ+rR98TiOj2ngiS8ED2nk6oBIesbSy20XEr/TpAKF5VIXwtl4F0h85oFcJquqxmPdQJ5xd0YgiAFDa8mcR4TmXLzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=spsaVNUNh/3VFuawqy3mCL/YNz+pKrVAaVclE+J7sZ4=;
 b=UH7TuRPS1MQtJtg1AHiCVgFObUPODl6RxAWrNgnY9NrGCNNOnVhy/hA8OyWNsRa7ny+d0iy9FUw93B0eqjWWS1b3FkeL3jFCImdI1avzZ+zpP5L6dh8yUtCpzbwq/0awQx93J6HCZb2cYMJWJ25JIvrfjFU2SfTgv+HbjOAx2vg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com (2603:10a6:10:2e1::21)
 by PA4PR04MB9415.eurprd04.prod.outlook.com (2603:10a6:102:2aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Tue, 12 Sep
 2023 15:31:05 +0000
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::ad2:49f8:14b:25c7]) by DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::ad2:49f8:14b:25c7%7]) with mapi id 15.20.6768.036; Tue, 12 Sep 2023
 15:31:05 +0000
From:   "Iuliana Prodan (OSS)" <iuliana.prodan@oss.nxp.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "S.J. Wang" <shengjiu.wang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mpuaudiosw <Mpuaudiosw@nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>
Cc:     linux-imx <linux-imx@nxp.com>, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        LnxRevLi <LnxRevLi@nxp.com>
Subject: [PATCH v2 2/2] arm64: dts: imx8mp: add reserve-memory nodes for DSP
Date:   Tue, 12 Sep 2023 18:30:21 +0300
Message-Id: <20230912153021.21786-3-iuliana.prodan@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230912153021.21786-1-iuliana.prodan@oss.nxp.com>
References: <20230912153021.21786-1-iuliana.prodan@oss.nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0006.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e2::11) To DU2PR04MB8774.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8774:EE_|PA4PR04MB9415:EE_
X-MS-Office365-Filtering-Correlation-Id: e5ba2dae-99ad-4e61-1353-08dbb3a5478c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K5Li0wr/gonn9cQPIaEA2rYQfJc9hJLha8IkkAQ0yyUzuGytlqWzfsseA98ri0RFtVl9IBqiK5oUFo7SE7kQbCj/kqWuFdgbZmpc0O6qsHyDucP7YTCHUsEfjmq9cs0VCK3EZIBatQ3y4GwSNa68qWwCQlH85SjtmfalgyML95gYYg3J0R77dZJ6un5/jOY/HqKHGBT0B3XT3mVFt+XSfVxFnX2NObTsbxtg1FFmKO2QIx92GHS+hByfL0OVDU/Im+QaSr81yiRfaDjZXio8EetpyiW8PjwZUg1nimtObUWLy2AshwAQyPXmFvuCWwAvfWBYe0HAEqM6o01izdGnNP/GETkn3NWRlyAvrpn2LTur61hFIQD6nBPd+peR3iYAleQepXOIPRL6cz1yUCkbAlVl8R7MdBazy7xhqP+xmufiCYOFwUcdChwYK40vX1s56gXuCU5RzR3TqJ6pThVbfmEFhdkzVcFpeqWnspwCnK5Kl1IO2MDeBt/fU0bisnF+klAAxVgpMqPFZ7cGiOflZ8t1T3XfHjTbHW9UdnrWVvEy8paFOYsPpOD4xTTOk/J4BweAQ5RMNJ3GpjdrlXjXpQ6iI3Rn/9weL/qr9Jc1ruKeMwNSvm9GKqwMLKaaOGOfNyqJ/E8pXKpoKcmcLEWpiJQI6hMMQO2rrh6e0WIrjcY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8774.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199024)(1800799009)(186009)(6512007)(38100700002)(921005)(38350700002)(86362001)(6666004)(7416002)(66556008)(6506007)(5660300002)(66946007)(316002)(4744005)(110136005)(8676002)(2906002)(54906003)(478600001)(66476007)(8936002)(52116002)(41300700001)(6486002)(4326008)(2616005)(26005)(1076003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w9+z9dgHk3VsdWcTnAFX3dX7Ji/73u9RrNuEVN8hN7672RKNYy7IHNss2I5R?=
 =?us-ascii?Q?Fk4k2tgH5RfDZW/I76A8K9FWt6pD+TkYpE3nySk+abPx2v5qq6L6QVEJBtJX?=
 =?us-ascii?Q?vn0wa3HyqtXKn5UOByUZdnu4yYh7roWnTCcLgmopnFbLk6reRB+87dBxl8h2?=
 =?us-ascii?Q?6Z6W+F86Lak2LYqbi7KOw2SqnOA/JjAUwy8r+DDkBAlIo+/tCp+Xz1CKx67Y?=
 =?us-ascii?Q?MB2s2H4BIrNlKvjFwI3jb1uY3xY/ZuT+GhD2baZ5PXTN8l0toxA1l2G1rWBV?=
 =?us-ascii?Q?fkxRcbXgssl6dhB6iG+RRyyf5x5B19gP8rp1Nmt9NRgEUcRJsSuNgU5A6/Lz?=
 =?us-ascii?Q?CoKwX0K4Hjz9JXLMz/uQ6ofJXZOQup0vSJmmbM8crhIKXZ3x5j2lMeMwxfhQ?=
 =?us-ascii?Q?DD+mduLg+0mxI+akV5QPUcKXka8ihIXiiwVx9C1SJjaMz9nUQ9aE01m1XkiC?=
 =?us-ascii?Q?O8A1Xhwnq6eA0UqQ99rVpt0WyK/OBwxHwXV479Nr0dYwbzoKkzPAVLRpqfJK?=
 =?us-ascii?Q?sAGQuVXClG2BZB2IUcaew091JTk7sbqXSjjedVLATFGP0noa/m3cu/UsiBBW?=
 =?us-ascii?Q?PsOV+rartCmIJf90/0zBbS3TlnmT4wSyndtSTPKqNAeM7yKZUd0ansLhjF//?=
 =?us-ascii?Q?Od7okS7nTyB8MaH6G2k8oGLtP4K/KE+er7yRsVUTi6QHOC0tQ/uwjDTbfiVs?=
 =?us-ascii?Q?4fkBzisdxtQsyCmvuN/fe8t9IwFoCfju1uH0uFXoipcyOWh30dbY/BH6vLSX?=
 =?us-ascii?Q?MLIzq+dZBxRahskl+WG1olc32f4zRqVYi/mosZbdzVkoo8ekIhXmQKCYcpoY?=
 =?us-ascii?Q?f8lWJuem4f06rlTuwXfUcmq1WK2RX52gkEms18SSPvH535X0yoiVkT9v/RXj?=
 =?us-ascii?Q?eZQf+O3HFObjNVHD/v07EoY6H25NpHBonRM6kxlX1M9QDY/4MjFxforc0Ka9?=
 =?us-ascii?Q?eWeFzk/HROOxIdJ2yTl4dUsPbgOnCd5Ze/0I++gUn8rqyZcRwwE7VbbmJjDJ?=
 =?us-ascii?Q?QAIxlhbOYh/JCkW6r6J/5wG0TSRnEYOx8lD4mr1Ce4N/f72RzmnsPRMa5ngk?=
 =?us-ascii?Q?fo6qWnjg81i1XzEp0LxTHODH9V1qv0f0LJHwj00AoUYibi3YIm6c8hwK08n1?=
 =?us-ascii?Q?4FELC6KUmMs8xk60Id6uFg91vWg4s+wMPkBuzpGUj6rM8UyriJvzFLFWbrSc?=
 =?us-ascii?Q?Cf7HEP9WzUINGZa/Rcd/1eKo52yeQpt7yq5F/kWup7wAl4nzfCP9xJGQ7h9X?=
 =?us-ascii?Q?Ck2KRNPE/5XyZeG5ZJVp1KVTlrwRqBlqtLA8nUkAotZIrlD6eNUBEnLDdqOs?=
 =?us-ascii?Q?tj3hrXTSeznYk2AcAcYEWmBVIRP1lP9sGvF3st7UgE7YIjP52V+6HbzEoyN3?=
 =?us-ascii?Q?EG4QUkTtSP0TbWlyuAkRi94OKtr46ehq76FFbHXn/Ntan4xy+50zH2RaoXTs?=
 =?us-ascii?Q?t3xFz3S841P4WfisAxJH2MzY9c+vS/eyDxNqBQI7hgF+ZoaleGKWsiwSAzsA?=
 =?us-ascii?Q?VfiACc6AIrbHgB+Z+TPQuHGvXkQwuEE7poqM82zdGPSg9dhjOWqAjB2GOXUn?=
 =?us-ascii?Q?9COE+tRh+H7il1RrNJwRU58VFMgyl5tJ4RHnDtgssh7oy+JiUFS122otVgal?=
 =?us-ascii?Q?gg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5ba2dae-99ad-4e61-1353-08dbb3a5478c
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8774.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 15:31:05.6748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L0E9S1esC1AKdrqSEfljkOLleV/VlLIHq5+Vd7H+H+m4Y2U6ACieGC966cpwq7IHOuv8DiANyvcXLyullElwhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9415
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Iuliana Prodan <iuliana.prodan@nxp.com>

Add the reserve-memory nodes used by DSP when the rpmsg
feature is enabled.

Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index cc406bb338fe..59e672382b07 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -211,6 +211,19 @@
 			reg = <0 0x92400000 0 0x2000000>;
 			no-map;
 		};
+		dsp_vdev0vring0: vdev0vring0@942f0000 {
+			reg = <0 0x942f0000 0 0x8000>;
+			no-map;
+		};
+		dsp_vdev0vring1: vdev0vring1@942f8000 {
+			reg = <0 0x942f8000 0 0x8000>;
+			no-map;
+		};
+		dsp_vdev0buffer: vdev0buffer@94300000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x94300000 0 0x100000>;
+			no-map;
+		};
 	};
 
 	pmu {
-- 
2.17.1

