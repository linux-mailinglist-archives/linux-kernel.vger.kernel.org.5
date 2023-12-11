Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C82580DDF0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 23:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjLKV7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 16:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjLKV7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 16:59:21 -0500
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2075.outbound.protection.outlook.com [40.107.241.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964DBA1;
        Mon, 11 Dec 2023 13:59:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L1SFcMxq5kj0fLeqW1j0+PviXvg/qrw7S7N66Zv6X/G8sYLU5Cwax8vA83lwJNbUHaAFEe1Cwl6KUO9i2mBUHrPrSrF/Lk3G0vUoZhfeqJaZ79FstzVTd6Fm8cwEg50fPNr6NxWNDgiXCxHGs29hXDf/s9SjgMXynC9JsqdVURScG/Efg8BxXrF7EPVnwBURhNiyNNvGwPgMih9Unk2/bZQ71bUz251oVtY6uDeTWW3bbaN4Zyuid+MkrFdJnbwduby5AqAzz/37C9enYYRCyn6/sN4Ay9r9O+iGq1sNjJlq+ueEB7hGBRTU8Q50sZ1vZNFVEc6pSt0jRODE9Y9syA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nkPmbDvnpjyM31CpLAYNJzBvlFlaahKGd2OBOlmTQMM=;
 b=H3cTEWSRffUVgxW6rdGSzXcPiRYimWnAW2OG9ZE8qbUYwl2IcLE0xha28McNSgFnqV/DV8BYzY8Lf+ASrDwTmh2vizrZbi6OukLcoeG96MTpn4Sf0SBdKXLy8EhduN8xe1bdNCEIg6qHb2HE6k0aeZiUwvpl/3yRA95fABsYPnv3quXYobnU1/bHGhsR5owDp1mN4xjqeQ8I/xfEATQUCqiA/cJW3CHwdSkK8xvRewIf+VvcmO+ok/BT0eXkZMfMfh0Cy8O25/XwCY7U8jHGqx7OV65XDLVVB6R7q4reXGONxXoHBbYabpCPD/VAvGWuCUwKbJ/3zRU2ZmFkaAgBwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkPmbDvnpjyM31CpLAYNJzBvlFlaahKGd2OBOlmTQMM=;
 b=Qo4c+GTac0R/M8iI221I+gPbKDswFzxfgGJZEhZ78VfWo8CIuJurpKpa859+L+seBO04Fe7b5OSIdACAomlsDHmzwJiCjKlRTZSUl/wU6AWkfRcZV1j2LWjNHfrjuHoZc9boUCrqwguwSd0/K4KWpDrqYU/B/VSP2726Ptppdgk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com (2603:10a6:803:51::30)
 by AM9PR04MB7569.eurprd04.prod.outlook.com (2603:10a6:20b:2d8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Mon, 11 Dec
 2023 21:59:24 +0000
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::dfaa:e869:45eb:76e5]) by VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::dfaa:e869:45eb:76e5%6]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 21:59:18 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com
Cc:     bhelgaas@google.com, conor+dt@kernel.org,
        devicetree@vger.kernel.org, festevam@gmail.com, helgaas@kernel.org,
        hongxing.zhu@nxp.com, imx@lists.linux.dev, kernel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org, kw@linux.com,
        l.stach@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lpieralisi@kernel.org,
        manivannan.sadhasivam@linaro.org, robh@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: [PATCH v3 00/13] PCI: imx6: Clean up and add imx95 pci support
Date:   Mon, 11 Dec 2023 16:58:29 -0500
Message-Id: <20231211215842.134823-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::14) To VI1PR04MB4845.eurprd04.prod.outlook.com
 (2603:10a6:803:51::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB4845:EE_|AM9PR04MB7569:EE_
X-MS-Office365-Filtering-Correlation-Id: c449b642-dff6-4887-c91f-08dbfa946c71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /VVlY993bQ0H1PmMgx7rCWLih4YYbUAe1j+ZGjV8zE8s2jbmrBVPTpAF+qmRRHsjhiwMiMV0BtjG9wsVkfhLNDX9NkairKxuKsI13+99v35hLWb+SF2ZnzFY3rI69e1lhcWvxWpvassj4adCyBc8rZFnSul0+x2KxC4yu17yfqiKmREU/0PUTFOw6gwIjErBMHEplWvBkjOZ8MO9ofaqCqDN7kZTp5TW0I59ca4Rp0b8BaX+TE1P0vKle3ER+LUfSBwc/sumgMDtN+Yc03jPpsHuWYMiyl8DjlJdMLzcNw2X0ot7Ool4/jCxB/cD7HRJ+hfObzXRewFmqGZ69Wo8nw9IFy1mAiV4dIT4hUNhBITJKwI+K2T4zlNTgqMQUoxRfLqEZzdAbNVBRdJrcoptTYXClR1AH49fKyatlPx0v6K0iQgg1mPzepg2CM8akQGUH71jrUo3dUzFE3VIsNuE++Lw7gH3cpKbySeHLZPqObCZonumS3G9fXJ44Ja71OgBPP1MrR+yD/6s0tNqR0wtPNQUcyEuh07TCT5VhP0uJRdkCeR45wcSHeYS7XFXeI7Ru/u/LzAi+sxHn2IxE2FEeq+8HXiEPhGw2U11gGnnyk4v6xjxhSx5KFGCalLI/xdQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4845.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(346002)(366004)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(1076003)(26005)(2616005)(6666004)(6506007)(6512007)(52116002)(83380400001)(5660300002)(7416002)(41300700001)(2906002)(478600001)(6486002)(8676002)(8936002)(4326008)(66946007)(66556008)(316002)(34206002)(37006003)(66476007)(86362001)(38100700002)(36756003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6d//fEzbyXFM0MnTcyNYJuP2PbTNk0FzTO2bCwBszHymvrVwODqvTyj/5V8X?=
 =?us-ascii?Q?CrgqAASfIGkI38Mo//P9vlHW1M7BGHApeQTCVjwB+Wm/60q1BY+g5hU3rukZ?=
 =?us-ascii?Q?VEHxSFSCfOJVjj6x+gvSr5EMoAhSt7DvMZm7MzsppsDInHO7DJdtI6jLnysj?=
 =?us-ascii?Q?ND9EkqtLgta93nv80C+ZVp5yzl5BnMmwrUv4ZHJCJp3WblUQXbvRtjnIdYNm?=
 =?us-ascii?Q?HsFbSdxt/Kz6GrVDziCHZ3MD2JgnJnRRheOefOWRrvoZcNVSvyaaCswaG1dG?=
 =?us-ascii?Q?PQ1mh4iVZ5iucEI7fEiQhNo56CXqx+5ZXfLjpMglz0I+r1TugOaPeTYdRGJz?=
 =?us-ascii?Q?/+DaEI3ZigT1RModwlF5a5pJjrtzTBznAyEYNZXK4qZ73c8P2zd6ZlhhVFsq?=
 =?us-ascii?Q?xOe1m/B9Fq8VvvIzOg82m4q8u2VC/uZ04x2aplRjiiQnESs4b+KKBEdmufGD?=
 =?us-ascii?Q?gsIOoW5rM1UJgj5NY+UL3pumvGrlxVwxCRFNiCktd3NbglZW4hDU3tLe1+0o?=
 =?us-ascii?Q?fyJyn08tbekqenMkhp/K4hpy4HiKM2wt0YmHKyQiDtERl3H6F/ozExuFp3v5?=
 =?us-ascii?Q?4YWU1bB8F6zDgv/S31JBBpIx1BtSt2RWqlqflyBLR2pGoypmOtnAdtUvHd2a?=
 =?us-ascii?Q?knsbA/8fwf0hhXUsAulZRWd04cYibrDK4cJcEQG469IaRBVj9Lhb+TZ6QMXk?=
 =?us-ascii?Q?Zt6NVhrbZqD/CX1NDLIISomzAahHv7T3y+m1CEEzIy/KGyqYuYfwsQsNtXej?=
 =?us-ascii?Q?IpiOMrzEiKoz8zvFtc+dN2v3VBfTH+cHh8fRbZ6g92fsLrcw0qGq2DniS8kc?=
 =?us-ascii?Q?cw3CaFntS3rlkw3xDbTAyDDv5d6f1cS3HdFo48noj/7PQEwJt0i/IesI37tW?=
 =?us-ascii?Q?TIOPJQq6E9c+MPO36RPxGIeXNLnzVbR2WtqhP8BJ07ziBaUG7wH/j3Pql93O?=
 =?us-ascii?Q?n68jHNV8s4xXG0Njzg5WcfGHB2XpjSsjHZONakssJ5aDJvFW8nZ7Kt/NiBpl?=
 =?us-ascii?Q?C/0ZePns8eV9NX/w8/ip+mGzzgaD+A2CNUNaYYbGSYKgWnZPGG1p45IhtEbn?=
 =?us-ascii?Q?rXHNFA2b81biGUtAbfXeeu2Dd8NjNFHFzRIq9ksexYXxpwcIzr5Mvf5ITrai?=
 =?us-ascii?Q?oUCQRss1GZgfqHFI/gC3Nt/Ex1Eav3dn5zvUThHEsVr43YfoLku31R1oO1og?=
 =?us-ascii?Q?Za3f7O8bR+D7ErXDW6+xv8jOOOz+gnjN7VwR9dQzjE9OqpFsZE7gUutR/VaI?=
 =?us-ascii?Q?/wh5V5LqxVO6XxS1UY+OxJ+XHvuQIRyHqyKILyKA/B45lHMZWmaXKJLT47xU?=
 =?us-ascii?Q?cnPy/ejwduvSdkvxgKPC5gsEsIKgLv57z+d/KE1GMmi2WY9lr4T1UgUORuoL?=
 =?us-ascii?Q?Rv8nFPtnd3MrvLQUm97WPDxxC3oDT/RcOv5DCcNgGZVtJGddHvYFVjpSxTBA?=
 =?us-ascii?Q?0nS/MF6NQJY1Gdp7QqKfgsm+yceMHN6zpjxY1d6SpwXmkndOLeaPiJUikO4n?=
 =?us-ascii?Q?r9UqWOGBdESkarU4G6v4LfdpF6rTroR0++aSsphGaAYqpXvdxpTncBeyzJtr?=
 =?us-ascii?Q?h0ZqmdIg8DwFVK/7ClYejbbnPAegszSn034FSjNT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c449b642-dff6-4887-c91f-08dbfa946c71
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4845.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 21:59:18.7923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /XkAIXc9S8UwBQTM9rXAnYMf/zFYDobdvsmM5broeoSFe/ClWmGZq+CK2fa374qEsvWKrIFKn1N0QXCdwGPLhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7569
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

first 6 patches use drvdata: flags to simplify some switch-case code.
Improve maintaince and easy to read code.

Then add imx95 basic pci host function.

follow two patch do endpoint code clean up.
Then add imx95 basic endpont function.

Compared with v2, added EP function support and some fixes,  please change
notes at each patches.

Frank Li (12):
  PCI: imx6: Simplify clock handling by using HAS_CLK_* bitmask
  PCI: imx6: Simplify phy handling by using by using
    IMX6_PCIE_FLAG_HAS_PHY
  PCI: imx6: Simplify reset handling by using by using
    *_FLAG_HAS_*_RESET
  PCI: imx6: Using "linux,pci-domain" as slot ID
  PCI: imx6: Simplify ltssm_enable() by using ltssm_off and ltssm_mask
  PCI: imx6: Simplify configure_type() by using mode_off and mode_mask
  PCI: imx6: Simplify switch-case logic by involve init_phy callback
  PCI: imx6: Add iMX95 PCIe support
  PCI: imx6: Clean up get addr_space code
  PCI: imx6: Add epc_features in imx6_pcie_drvdata
  dt-bindings: imx6q-pcie: Add iMX95 pcie endpoint compatible string
  PCI: imx6: Add iMX95 Endpoint (EP) function support

Richard Zhu (1):
  dt-bindings: imx6q-pcie: Add imx95 pcie compatible string

 .../bindings/pci/fsl,imx6q-pcie-ep.yaml       |  20 +
 .../bindings/pci/fsl,imx6q-pcie.yaml          |  18 +
 drivers/pci/controller/dwc/pci-imx6.c         | 578 +++++++++++-------
 3 files changed, 393 insertions(+), 223 deletions(-)

-- 
2.34.1

