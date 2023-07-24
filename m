Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8485775E987
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 04:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbjGXCJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 22:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbjGXCJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 22:09:02 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on0629.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1e::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0114201
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 19:04:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8sq6Fhj/VqsJL/RFLI8zdI+S6+Z6CjMUNxRK0Nt2NkHxsgbBZs8/rZwssYtWOKbwnRA3C+dwCIWxZ/FlOEukXW4QJpwP/2/Vy0cVVkIsEYoKzpWMdyj8RUTg+Twq/yW3x2Qp70cFzlNDeWM44I4Ywg/TL2tpZaz2aELl50Fs8hYvlu+zZbt8vj0k+8ccruTFwGNADDlnStxCmCQusNFq0kE3yglGGn/2cigVfHd3LEZPIdjVQwDwSm1slsea1FzFoVAxgXTdrua5fwvAAgWFXfC6ESBrEh7cm018zAxZVhiXCdTfkXnVqixElYmHPukUkBavmCIzsCJkWZWWHdrOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L26rWEZbdrv+527LR1zi2UlAdGfwYxKOMu5wCAXRzF0=;
 b=kaogov0fz+kWF0I9GkxcytXi58YlJmCqzQC/SBbrI92Jyg8zXGw8K3Qn2UVC4DhyscaX83vz3ZNi/pXKXYJqpMPh3KjkQNR0KelUeXrwqQCfIIlWVJ7q/5aja4WOu/Oqykih04cHhPuaK/82e2VW2iW40xC8Z3m9pMa5dXh5omfbMKGWOoj0i8hTaK9ui1FGCHZwLhS9L4PwyiNEdTvaSa92cjjyQksS5xy5NJR2KmgIN0o4zG8U4LjDHgh4HkzR0O1MfsrftWul0wPlyJzGCSWiKneNjHrtiMp68m/T5OnNOUA7rc3YgGJhO9p3p9DbSTFuS80lWaVzUKZeT0IECA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L26rWEZbdrv+527LR1zi2UlAdGfwYxKOMu5wCAXRzF0=;
 b=Dx5Dprj+gpqxgFtRuAFfgR4RGtCZflKXCgoTSb4XRiUpmluw2ZtWoOs6FQqzxBPfApl69ipvV1P99CgSEdA0iklSPU7BxZStEqqnjQVbNPCKry2MCQOPz77Uv8bMslyDMFYKYc7MNv/YN6La7JpaTlc93I9R0QwJP8GO94LrbKw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8797.eurprd04.prod.outlook.com (2603:10a6:102:20c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 01:42:59 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 01:42:58 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, alexander.stein@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 09/10] dt-bindings: power: fsl,scu-pd: support i.MX8DXL
Date:   Mon, 24 Jul 2023 09:47:10 +0800
Message-Id: <20230724014711.2048958-10-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230724014711.2048958-1-peng.fan@oss.nxp.com>
References: <20230724014711.2048958-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:195::10) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8797:EE_
X-MS-Office365-Filtering-Correlation-Id: ed23aa16-842c-4bc2-bc4d-08db8be74f39
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2mb3PqSNBQOudNfiuMXVq8Xj8Nk8gVHucOaNdF5WfBgh+W6QDLeBwW/DfMF3Bn8m7CWpMtX7BY3ewr1CDZPfsJjfysQqUs2ILu/MxYmcgS9ZgVdr11htUnq43sovMgz2nvFAxdDZT9zFPEBk0CQbRnyEEBmIzuRMW50fJ83b/iAnYoesPEO1OcnrzYH5SOvoYkglDkKQfZe00oebxsjodLODYukCfAa6Vhvl714EQc8pIk4sVu3nzXUUivOdN62JS1St5DTkI7536YQ6E8BpBigGatKSccKKs5EF0LW7uIcn7zcHgZJewItFDR9v8pETeSVi8bNzLzR1IelQ6a+nQbgF9/vRI/rzECN4Y8BhI/1bQqbX1HLj8pZm3at3fKF4MFUs4xFR3aIKrlAWe4Rbd2iZZcliddoQX6NS3dBBt5kqYZZeKkw2hCDUtv3h6x1pAlKfIjinTLstTiesBMs1DfgchsfR/YHnV+mVk401Iz3R0/L6NdU4Eoi/puc8buFkp2xB9ElfSdjGxdbzWGGgsT74ljux15jEBC/3v/CCFQ6pam8RmqdewLsjypA8kKrIB7SIHuuEhuAp/Xz9neoTdsmckJPMfBNqa1+B2kZTrspdjAMfGkBr9ND3IbUFvVK5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(39860400002)(396003)(346002)(376002)(451199021)(38350700002)(38100700002)(86362001)(4744005)(478600001)(2906002)(1076003)(186003)(26005)(6506007)(6666004)(6512007)(6486002)(52116002)(8936002)(5660300002)(8676002)(316002)(41300700001)(66946007)(66476007)(66556008)(4326008)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ELTkuw4urrciNVQeBKMLIlH0cA/ukqItQIaN8WmjsH6CuNXvo3FpFpTvK5wl?=
 =?us-ascii?Q?HWOpW4FPW4lfP1StrMOQab5qBlqkPByuxMpCLHKChgBgpCO1zEOQOwSVkWtz?=
 =?us-ascii?Q?X1xVFZ9VSw/IVUF0+DFGEe/r39azby0Y7YvvxSiMfw+iwgEva2JlAhcIiknf?=
 =?us-ascii?Q?TOSjf4jxgKYWzWfExNtkjI8AOeDbjHSevKb/Aimt8vL1QWO/cqPsv9ruoGG6?=
 =?us-ascii?Q?l52ox52K3yTCpOGO/atedS6QlxqHbn/56Tm7VfyXKGmMnil5SVxCDmwmz+df?=
 =?us-ascii?Q?E7Tnx8l9wr4oUi/8HFuDIIkZpiDDeEqDiVHD3c/8W7AZ32QTzH8n2fg4ld8V?=
 =?us-ascii?Q?b5Ge0U7YbPDhUodCME+EMb/aHExQdU8wC5Be0+lOT/cW5iWkslpfabO/XSh8?=
 =?us-ascii?Q?A8D1Xy9lsMjvVqCgsFCFof1yNC6xD2YV88wEawc82ZN6dy3BJnWdKMGwEJ8F?=
 =?us-ascii?Q?Uz8NlfOGxhhUTpJ8n9CUNe+FnmKleIFUtqv9hRV+9ycAG22UAiKQ7JPMnrRQ?=
 =?us-ascii?Q?7+OXd4Io2AMGLu1GBzAzvfZnrScM0OgS92jj6UEupp8ayUauF9zHznNRh7j4?=
 =?us-ascii?Q?E/A6PudMXczBDgE5Lxq27xK5VYzbYKHPfwYq3gB7vLacAebmq6OPmnQ1RaS7?=
 =?us-ascii?Q?RZ67Bi9pAUJxWrrC19TNunXZuD8lLRQIEL5k5w4P73f0r1EbWVXLKBISaSsH?=
 =?us-ascii?Q?DG3z9efwSsRdq21DhakiSMqBN5cow4a5z6CLAoYPAAKzucFVGdsll2APXAJo?=
 =?us-ascii?Q?tLTB9e4aPWr4p1yF0lPuf5u94cEr9wXgqg6532ZbBPDy3wBHMyvZZL3eF3jT?=
 =?us-ascii?Q?inXyTOY+6t17Ab56dN7OGKCoZ3gmSF2rPIVYSJ27qittvHATfkUNgkiHJCIo?=
 =?us-ascii?Q?XrTeUw6b+dOW3Vktf/Yb6BN392PD/CK0vvSlnqlTDvTdHcOATdLofcJynLYi?=
 =?us-ascii?Q?ZQc7+ZEJGraabLiqwY+6FOpTJQiq3LKnJr5T23BkkED/uAyH/vILkOnBz8+7?=
 =?us-ascii?Q?NNYtIcNA/E8th10wHarLWR4PXaw37ebRSm2JPqsozGS/1GrfLZ1dGNrvMua5?=
 =?us-ascii?Q?chzu6IkwWrA9/MimoZb7Cohiktr+a3RERBX29RtboGVCZqeygC7mSJ+uPaaO?=
 =?us-ascii?Q?/zTtpvP7cyIELKni7IYAS3+/DXWDj0yXOaLIS/CJRm0xuuNpC49zAc2eXrF3?=
 =?us-ascii?Q?yZwjEbn4qKDY1+0XiCgiKxRi7e81mXOAjIoIIj0YHOH9gifgb8yI1bsn5nsW?=
 =?us-ascii?Q?FSYw/u7VHeiPiZeGc4UyrBhqgXR5xk/AdUOPgRcTrtvkuiQpuuUuSbDL3mcJ?=
 =?us-ascii?Q?AD9FOvWnJYDQt++b5w4KVFzNMCUuVhzHkGZq8zGFDrW94LENv5KG0jR1ECGq?=
 =?us-ascii?Q?KG3ug6LHsBF9y8P9BQfOpjlai1a15XLJVwvssjlYKKCm9Y35MGT6d8tYDqJH?=
 =?us-ascii?Q?W6eQXwRbCPeENryQ/xFE2dTWiLcNQ8WESgkUqyPoCwlK05xkfiobLtabKq82?=
 =?us-ascii?Q?83kvQu8bakcu5ycAxVORfAfzhJS3vd0BISPc/cuz/2ACOYlAC+fZRU/1CRyx?=
 =?us-ascii?Q?3MikQk6mqnA9NqQLw/4GgtVB8QT07oryWTzHCPfr?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed23aa16-842c-4bc2-bc4d-08db8be74f39
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 01:42:58.8892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hXDfMeJHL3j5gxLmpOLndtvoTlZJR3YaTmR39hSBXISnSQxECN/NNcoP4PzgrZhQvW4taRgNWBuNIX49Z60N4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8797
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add compatible string for i.MX8DXL

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/power/fsl,scu-pd.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/fsl,scu-pd.yaml b/Documentation/devicetree/bindings/power/fsl,scu-pd.yaml
index 407b7cfec783..4d38f9cceaab 100644
--- a/Documentation/devicetree/bindings/power/fsl,scu-pd.yaml
+++ b/Documentation/devicetree/bindings/power/fsl,scu-pd.yaml
@@ -20,6 +20,7 @@ properties:
   compatible:
     items:
       - enum:
+          - fsl,imx8dxl-scu-pd
           - fsl,imx8qm-scu-pd
           - fsl,imx8qxp-scu-pd
       - const: fsl,scu-pd
-- 
2.37.1

