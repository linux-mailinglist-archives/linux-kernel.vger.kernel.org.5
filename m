Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83B475ECD2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 09:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjGXHx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 03:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjGXHx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 03:53:57 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2074.outbound.protection.outlook.com [40.107.8.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45ECD19C;
        Mon, 24 Jul 2023 00:53:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P7hMRAZbn9b1/H4WAMcXI9/cthRnNoEn25loBbfMR1CLwbnW6FC4BGWYRglbBBUkD79n9+wF3+eczyG2j0hPxzDrV1nfzXrLx1j0ALOr/oK4jtfo9yXUn0B56ODJivqt2F64iFHsLsNXS8CFi8VrQzRALhHIk1YYNI7zRsHx3c1A0Zr0CCAdl9X4zZyOJO7fxd9R8TbYac9SFuaduVuBbSsDMDtUrYFeu9TAoctHOR61EECf4vyGTYNhhIl4VnN6XZ+hRcaNxuUq3m0y4MFQ2SHrLxvUR9ZT+ZTC6UNty2Um9565oDkmLd/lp6nSTN0z8JUHEGW6O7E+XdhPbW0twA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O72BmON9xYhDQN3NFLt36PqPUYRNwLEcRcPUPS9M2LY=;
 b=DUJV4qS6SvY4KUzY4pn9jOK7XhjBzJFiBtAz+qF0o6CDM4snoXZ1llx3QKEDUBkP+pMAQ6NLBtk7LXhbByCCSiP0CukyBkUOfWBbCD+hkZJnBjBup4+do81zrsfoQxsVwWQRxlWvQ7K6gEx7XTlsgo1FNEHS9Zjr+lVfqQn+gXwzlYlyLfpf7gPsXhl4c5tFWBSl1IcSEzBbYJMgI20yEQMtjOmOfS+oDaqzMOCl1+BPqTl6bsFTPM4aqx+sctAFHwN7sXxH0GOj4D8oRspNiUmPm7GTeX9B5ikhI1jG0HwhEChbNpGJAfqyg/eFcshrAkxMVPbp4rWNRy8xCQDgKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O72BmON9xYhDQN3NFLt36PqPUYRNwLEcRcPUPS9M2LY=;
 b=HJ6zvk20cYZe9IKfz/brnkeuQaS1+nzRnkvCcrGlKEvQy1jbKu9PgfYEt5jI8AfN8bQNPIj62CPorK/BQNPEOsrInkol7zXPAVgYn6FXR/s/dQYMam3bDzjjJfRrIF3Fed+Tbp5kgru+Rzp5hJr2/ItnvaPLILCjvsRxNPWMk54=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DUZPR04MB9794.eurprd04.prod.outlook.com (2603:10a6:10:4e0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 07:53:52 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 07:53:52 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 00/10] arm64: dts: imx8ulp: add more nodes
Date:   Mon, 24 Jul 2023 15:58:23 +0800
Message-Id: <20230724075833.2763190-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0191.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::6) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DUZPR04MB9794:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bd57d4f-451f-475f-e149-08db8c1b1f33
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GVFm1dhLY5S/e4W62QINSjImd8jbT3SgCofbIbI5BqpDEWGNm0riaNhqaA+Zfrjc7+O+vsAIx2rZCFNQbjzjWGoGfCLatIKheJjJgEoER89nTE0FSXiTobbon1aBaz6MQY6VT2+Hlot/9+VUsJgNlkRPeXDZkoh1CyYSY8lq0EA6sP+xSGASZO8AqYjr5Jk2tEhEcZavg49YX1iPt6AsWyr90v1reErPw4QRNcNrRetpqLFLkpvYHYCDPKd7P20YbK1kkc774uaZj/XPAn/S0dzGiDfisH4+H3TN7rbxJG1TTiTSnOFyI8K6WyJpckzDuoIF2i31ls8KU5xvwqtnP4pi1668KZ7RVnc13MVpNRrmctFvvYYhM0z4kpuyor77yhWeCRhr+4uQ/VROVn+zvxkBPAKzTxV5BtLEkh+6c3byVYaT5hEld3JbBy5MyRtzyiOfWGkhJDiFtxz128b2Vmc6P/VCuhfBmKavzMsdoclf2dv06KNLZ0xpIpHZvusNC/i9PYPyzAGO7aFa7FHEkiT/oxH2l1vCJrHLuYy3NH/yopEh2LG1RHxra/Xa9qiORmOGLDvo2xcWUtf5MU8xOJH9VKdCsfoWs1WpCxM27wenXILHTkWcSMD6CGZ+8EB/j2d+K0hDvS4OtOhcz2XvPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(366004)(136003)(346002)(451199021)(6512007)(6486002)(52116002)(6666004)(478600001)(186003)(2616005)(6506007)(1076003)(26005)(2906002)(41300700001)(66556008)(4326008)(5660300002)(316002)(8676002)(8936002)(66946007)(66476007)(38350700002)(38100700002)(86362001)(83380400001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9+SklHVTepKv+1laxWP+tq1db7IdZy6gVyg3aQ4PqcBb1UWufQrI6m77gEZj?=
 =?us-ascii?Q?4Ao7UwpFFJsW0PjzMtbYvfclJxcT45MO1ottmGSd/CNDxDNiAeFwv1EgDRy8?=
 =?us-ascii?Q?rftZIuER5bw4ls6HczaDhUqbOX1/Je1729glErfdO8mXh+025OA2qKhleXFd?=
 =?us-ascii?Q?nGWYiJumxEMp78JwNie3OCj0rR+TD318F1lAfd20n9xfaz3L0n+U3PuFVnBV?=
 =?us-ascii?Q?IEQc7U47qpO5i1+lxVAhOxO4Q3X3epg2jICqXMC7EYezndml+wp1fZ2/ajJt?=
 =?us-ascii?Q?5PSq7DVW1pYDJQvpKbAtQhPRlifNMFq3F7UvRkxa1jDBVjlma7l1fNirvxEX?=
 =?us-ascii?Q?A18AdJXjiyifTaTt9aeNb30y6jtaM//NZ9xuMT5BhQiS9yHS6hzT9oOqqZUb?=
 =?us-ascii?Q?DDO7I7ZnAncJNr193L/1zCCLaDa8B35bMKjlLFGDaJLtenJYPdDgHebIuReT?=
 =?us-ascii?Q?5egdB332YozgLRW1oxmCtVqekuFFYPRTiDqlA+KHx+U+HKKQLQMBt635XyyX?=
 =?us-ascii?Q?JIpYgKO1VvL2Czx58JelT1tpMQRc/hcvFsuw7kUPeC1ttKESWmzknAgg3+Vp?=
 =?us-ascii?Q?Nof/suUcPHVSB6ScQncJ1DdGsrzs9S2mDCo0+4wnD9wLyQkNH8q6XKi4k3Y4?=
 =?us-ascii?Q?+B9n/q4yFiQtZSJuxIkkBwYnh2WhRvbVtisaAT5jvQlW9xw/PjzepU28Ac7A?=
 =?us-ascii?Q?LfaSqIJ/NkVmZ7HmaJ0HNKJSGkmOuVUyLcsbrcsCHnuW0NtPGcrSx22lku9p?=
 =?us-ascii?Q?ZkxzTJQdC20H7Ae8UiiY3cjzylJssRPw5eccPGurD8/VORl8J//EFyhfBYCn?=
 =?us-ascii?Q?7ObsYuOMlhJodleqrRf18GfT/oYtA/wK3qCPnAw6eF3+SwsgpiaIbHWxwpJJ?=
 =?us-ascii?Q?pJmZREKwBNjFu1JsGT/F6aA98JRTxUTxBNX20NuudkSppYZEN+PdqQdgjTPV?=
 =?us-ascii?Q?8xWFT4PusYdQ1NJ7u96j4uLKb4qQeuL2kCvg93sxSw6tJAAxnOMtsGxufE5W?=
 =?us-ascii?Q?Ff2s1Bro+ElFTQvJ8pQXIbOSqqxiF9MUXrwCD3LNYkCDASL8BUNccoiHJmVB?=
 =?us-ascii?Q?9abptjTcoxX5N/DrKbqIsQetSM9BylsJFreGaBl+AMOS2+7YrB8j857UqxaW?=
 =?us-ascii?Q?bri3V3L5qYWUEr0Yyj2nLASaR25pg3lEvi/yks2wP5jAnQ0GeZEWNojvPRLp?=
 =?us-ascii?Q?mUOqYRK8j7nDEZ+alWi7edzM/izajKZNPv6nwhryc9qW7mjZZf5538ieE7cf?=
 =?us-ascii?Q?UTRlJR6+Uwx/dk+QXKMVS95yLt9vZ6etiuPgX3vdHt+CIfhm7IrKB5tSUESV?=
 =?us-ascii?Q?hrzIhnYEGIm9hoOiKTrRJ01pixNSMtgc9zqKRIWuTJBKTlFjHclM50wEWYM0?=
 =?us-ascii?Q?h2HxtZZyveb/hIaBXpz56U3y6LHHQ/jjQRi0a+9IazY0RiMKBVRXf7LqKy2K?=
 =?us-ascii?Q?2MGf2hYSTI8NQq380HmJc4JE7eVHH9XX4Cxc+7PAAoJASEiV/Gf2C4ByQfpo?=
 =?us-ascii?Q?HCG+UMaKTokk7yOW+MU7rdjsyw3TzBzPye0dw5ZSvEFbSaG7zE1/6VnspU6O?=
 =?us-ascii?Q?KQyoyFgFik5mivIgvWhN9CrF792AcHbAkpfgYFBb?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd57d4f-451f-475f-e149-08db8c1b1f33
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 07:53:52.2462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kR79NAfpGnFPOWhKdJqtNwWelk+yNk0fmo+XQA8kOtDOF5sAZaOzmNOP7LLeEtuP8XH2LtBLomxUJfinu6B5sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9794
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V2:
 Add blank line between property and child node in patch 3
 Move compatible in the beginning in patch 8
 For patch 9, the pinctrl settings are same, because drive strengh only
 has a enable/disable bit.

Add flexspi, cm33, thermal, cpuidle, reserved memory nodes
Enable flexspi, lpi2c7, spi-nor, cm33 for i.MX8ULP-EVK
Set default clock for SDHC

Haibo Chen (3):
  arm64: dts: imx8ulp: add flexspi node
  arm64: dts: imx8ulp-evk: add 100MHz/200MHz pinctrl setting for eMMC
  arm64: dts: imx8ulp-evk: enable lpi2c7 bus

Han Xu (1):
  arm64: dts: imx8ulp-evk: add spi-nor device support

Peng Fan (6):
  arm64: dts: imx8ulp: add cm33 node
  arm64: dts: imx8ulp: set default clock for SDHC
  arm64: dts: imx8ulp: add thermal node
  arm64: dts: imx8ulp: add cpuidle node
  arm64: dts: imx8ulp-evk: add reserved memory for cma
  arm64: dts: imx8ulp-evk: enable CM33 node

 arch/arm64/boot/dts/freescale/imx8ulp-evk.dts | 145 ++++++++++++++++--
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi    |  73 ++++++++-
 2 files changed, 205 insertions(+), 13 deletions(-)

-- 
2.37.1

