Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE60785F0E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 20:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237966AbjHWSBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 14:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236766AbjHWSBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 14:01:20 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2081.outbound.protection.outlook.com [40.107.104.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A3C10C4;
        Wed, 23 Aug 2023 11:01:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jlOP6d8oKR4kXEVdWFcAACIx8Hk1wFjKoiTKeiHDV6caAdiyAFZ66tVaM0YbhD8n/6BorSOU/5H+G2+Balgfl8QIcB03Sqz2J4iATkBMqN/GHR71tBsFBNiI8SA380Ej6sMElVbP+LYEpmvuvMvtOySeDhbABDHrwPK9OpoIBooS+sPhJtldRw0u/PT0KTuRirgKvvniWO8Zfii0iV1FK5A6RS3207wwq6jlRSnUEXD6GnpzyYGOJu27IZolN2mFORgf4KeTgtAPNvO93x9cnSF0ENL82ru0ka5Aa4FHS7Sp/xo3HBbVC9tMvrpzFswkeVmferdxTq58C3LZSwdJ6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BBB3qladE1zFG2bDYfZwyEv0BttKj2dIsrPvr16kfd4=;
 b=hmm/8WHRzMdhavXP3Ky4C0Js46EOqgGgr+elg8sGQhMunJhPDkEq1cGVNjB2zLDZT9fQodnNAbOmn/2dBBULkp9QcY2wcsTRi9AOaNSMfgV7aw1O6Q0UEZco7KiVxj3cNSQzvsYK28hb7u74bpx6p5VRs1zFqvoqM6LFf/TEBRJZjOEpUXv2P2oIHuYVEjw3wC9JkamS/0FMJbxBlPuYMvsfUT8O4Lko2zbBMvpRZYfInnTJOEuLZ/SUtEGtnIrFtSbxoJ32Rgf2xJ8x4oXQj7HmyQJbfmgk4Os76o5XUGAaoF+VxK+8W70Ef7jAXoPD3mDuphsGbBB4sHC2ABgmKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BBB3qladE1zFG2bDYfZwyEv0BttKj2dIsrPvr16kfd4=;
 b=RtknpxA5Yu4GJjo5zcHZLnkGW2hWcyT76vz3X0unAH50d58Nej05cjdfERd1+8KViXRggMaozlTICFF8t9vqrbVnbTupntfyY7C8Um9bi8NQyICAngsWg8LdMw+FTHCspS4zMqts2SUwQYi5l3ML0mlB+YRXSMQtQSSWOrLJN5I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PA4PR04MB7502.eurprd04.prod.outlook.com (2603:10a6:102:ef::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 18:01:14 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8%3]) with mapi id 15.20.6699.022; Wed, 23 Aug 2023
 18:01:14 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com
Cc:     clin@suse.com, conor+dt@kernel.org, devicetree@vger.kernel.org,
        eagle.zhou@nxp.com, festevam@gmail.com, imx@lists.linux.dev,
        joy.zou@nxp.com, kernel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, pierre.gondois@arm.com,
        robh+dt@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org,
        shenwei.wang@nxp.com, sherry.sun@nxp.com
Subject: [PATCH 0/3] arm: dts: imx93: add edmav3 support
Date:   Wed, 23 Aug 2023 14:00:52 -0400
Message-Id: <20230823180055.2605191-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0051.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::26) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PA4PR04MB7502:EE_
X-MS-Office365-Filtering-Correlation-Id: 2943d525-6861-40a4-2ac4-08dba402f0ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4HpOAjRLhrsW+B3QBKeWPnaEPttcTXyu043ROXg7680iuPm+Ln6w9XhD7wev8vHR5FGc2yqbW+LvKbNyZcZcuc9lEZpp1cJhgUwPUqjdEkWf02h919E6tlqCbYcDqSoLMxwOpBRn0aum3iRqMOw2cBnGARCpJRiZY9K7Nb2P6JD7LGEg9/UKoH1iUQtugrpxfeNkw7FJScO7WLTfOmJsQVGHd40KG5Bri9TRrIeuf4VwkYsb97EUaff/dmJ5CagvRB32c3DWdSJT394wOHZNWWk+VX1fJqSbugXKuqCRZIQKmf3tAsGv/cfwhxzv5UsGyQQa+NLsFpULozJ+ul9x7eGVuaSnlh5MnQbzG9cWpdo0+cXVK+2y1BY2N3UlbLpycHO/Id0db+jMxUE6MKJH3Zb2T/UTKi0WwUU7rblW2H9KBsCtTUzx2VYtNl4/n2RtKY5pBMpWC2wNLZQ5fMM58tE3pVfxZLvTMx2QpFdA9G8uLmmJnuic5RNfwONZzgsNLDMWlBJlE5XoO8B3lJLyx/ZoZa4maypSBLmkLCdErRXl3H6iojNbkxdTUPNRdxDZPIR9V2SwXU7xuRuQDGbTApoy6odwGnakJTaXy3Hrv8Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(136003)(396003)(376002)(451199024)(1800799009)(186009)(2906002)(7416002)(6506007)(6486002)(52116002)(38350700002)(38100700002)(4744005)(5660300002)(26005)(86362001)(34206002)(8676002)(2616005)(8936002)(4326008)(37006003)(66946007)(316002)(6512007)(66476007)(66556008)(966005)(478600001)(6666004)(36756003)(1076003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/COXx0GWJQYap+5Y2JHiqEbKjhRl4JXsSb3yb8Wm2xVQLj4fte1jERJlzzox?=
 =?us-ascii?Q?dhK+qB4C6LoUcPX7JOEor45L+LC0dmsCzpi4P0xI0rGQ3GP6eYH/ozBIMaQc?=
 =?us-ascii?Q?q8inGDI2IjhV0qvB9Rzi9g99/fpNBa3H7u607fcD/eAXgv61Kl8cZuYaxrU0?=
 =?us-ascii?Q?kQQA362OFrRNB2kaL0gVpAKlMapg2oo9ZrTu9EXk/7zGDMcnvGMpiac6m2ig?=
 =?us-ascii?Q?iIsUEQCRS+VvP+wEcA8heSsjBhKmfpjN3UALhSAHTtsml2upPmpesopIBNZ7?=
 =?us-ascii?Q?zRTGNV/ShuPnyoJED+oI27bRTuw3NmUa3seTvYPUAO2uCPrHIfbZ62DdUW4F?=
 =?us-ascii?Q?kX7pJDBR4K0o2Hw+TKYWdk6B5cCLsSmlGvvbPfZYU2rcKd6tgVs8HNtLNot8?=
 =?us-ascii?Q?KBYYuNscIRxks9CCQxSCjsV6QdJBpGHKGG4ct2hEI1hbMRGIwGRafIe8dRRT?=
 =?us-ascii?Q?LW5Zsin9822VlmnPmlehfikz3wyQidw0tCCNuLKiFaDmU5HcCigNl0r0g0Sp?=
 =?us-ascii?Q?e+CN2zTqsg0U0oFrSMfwFV0Xo/soL07alxzdcVWSTVPOU3w5pfPpMsEd65m+?=
 =?us-ascii?Q?2ho9UC85GyC+Fljx0uKH0TmyMPiwFp1359EPXmRI1Ao0fHro7Dy3nowDYHdo?=
 =?us-ascii?Q?7B5/sPCj7h+kMPtAdIL80cBc3P7PuatWhl/eO2zrVO+F3XcCk6kVukvTaACa?=
 =?us-ascii?Q?Icq82QYu5uJFHLZgAWGfP2hWBwvi7tdTVWzpQk4ILaWqYdaFdNRuPeui5iF9?=
 =?us-ascii?Q?71t//mC30xSUuZG0ffkELLUI9L0QeRsxmGoN7gYfiTHZ6qzRtvHE3F1iYBnz?=
 =?us-ascii?Q?ETblOITVLVfK1k8gIdKZJM7chK8dDjHmwVFgx5TUBGXqSxXgmIIuaT1/eq1w?=
 =?us-ascii?Q?RDfB76XtXLGK5vdN2B7hKNpp0cLE9Yir7Nvh27azAWutTQIT/0AF3j+XOWFJ?=
 =?us-ascii?Q?E5OKGUXqCobATFpHUUtYQEHi3w93Qi9SkBDwl2lulTqxip1XqMDX+a3UTEH+?=
 =?us-ascii?Q?5La+ZfK8AIxeO522vs5WAtR2fbrGWa1t/FoFolFf6bWQPO/decQWFjta0hyc?=
 =?us-ascii?Q?I751HzG0U+BR+OZZ5ROlJ0j/0efbmLNg8bictAlGJwcjImrbjBDlSZoRmC2F?=
 =?us-ascii?Q?s5gZUdx94SUxPVB8kb5LgGKQi/+gSJyawggbT5ndvda5dO2uXLy2YWs9Sgk0?=
 =?us-ascii?Q?812fHaXGjsDUxwmzz1cluTC3L3SqVPSrvqA4t+/qauQqBjjKWXVkraRMI+l7?=
 =?us-ascii?Q?lMaQgb4CXeCWK7WQQUAWZoiU31OoQfkix28xxfDYvWUhkCgQNeM6bZEEHxfk?=
 =?us-ascii?Q?NnvD2HvNqHajsJtCveJ3RuTVEK/SZQnPQkLkNhxynUTooWwD50O3uWPb3sKo?=
 =?us-ascii?Q?4zP1ioYDq1PK2A/Qe7AxSnaFZPIRN2pz738QJuqS1Q77EULhtkEce4kWdMWb?=
 =?us-ascii?Q?XguvCQrQ+p5wAA/Z9ARaR99b08Byii/COXz691PyfepCKkSu/PMeQb9tBO0U?=
 =?us-ascii?Q?ayykBYSMJBNh2iArM5G3C4lqIeqnNmS1BCYYDItAobhvs7vwWAu/CRisK6lb?=
 =?us-ascii?Q?zN4OFsmAeslkmDjwxJw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2943d525-6861-40a4-2ac4-08dba402f0ab
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 18:01:14.1525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: whLInxK7OrEpsK2h8PoPUf8F0q62AOmVsusm0BJATo9u46f+M0qQSa4gnX35qwxR0ExfDmXF6zcNdf8/1U7alQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7502
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

edmav3 patch already accepted.

https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git/log/?h=next

Add dts part for imx93

Frank Li (3):
  arm64: dts: imx93: add edma1 and edma2
  arm64: dts: imx93: add dma support for lpuart[2..9]
  arm64: dts: imx93-evk: add uart5

 .../boot/dts/freescale/imx93-11x11-evk.dts    |  15 ++
 arch/arm64/boot/dts/freescale/imx93.dtsi      | 130 ++++++++++++++++++
 2 files changed, 145 insertions(+)

-- 
2.34.1

