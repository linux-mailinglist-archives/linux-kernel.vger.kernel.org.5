Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B218C7B46E5
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 12:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234819AbjJAKeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 06:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234777AbjJAKeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 06:34:23 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2050.outbound.protection.outlook.com [40.107.21.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA40D9;
        Sun,  1 Oct 2023 03:34:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NprmKl1Vgs+MnSfUlWmrdx7IEhC1JXwTgpXSdTvanqhf/mq3IkN3Gv2lpdEqmIK5wxO5UyVw/ilTbIPnHxEejRy5QMN8YxB3U+xjfXzGsUnxjMCEmqmXmInIrK97bzaavgxgde4Y2cHgCGvZLfl8Swn9ELQHydwshkh2/+mIii9LoHpEYeDUYqrP6OBpBfUH+9BYojyqzIqDLzCP9VAP0WVV9iKPok4kwfaoMvq9k5+WdWXkW3DmD4qWFKWxny5dCL61seqNSDJGoJzapqWe6G+NX50MJyZHybCv5L/u9wgkBUKbu4FTBsrhXbyieAEe3Xoqc8pxLME0assjMc17Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8BKfi0uFF3/iYFK1Gxm4h3Gy20CylZyi/9jXV9iwfF8=;
 b=X2FzNU4smzx6MT5t3KLR4D1H2AEGtLawT33DnD7KQpbTDozz2pv02w1Qi12ZVyT1a4j/yp4GWIIjSLyDz+N3L4r8kEGMAVQDqUGTQ/L7Ozggp6rZTEOd5lxQ6jup6SONJfCtyhT4vFwVcxshKySAQrL+J7Inj/1+tBrioi3Qpql+Fc0Jsg198CpXBx5kpoIPQG2Qkc6wkLK1kfZBS/dEctFyAcmzk73AcEdqUcsEjh+o3tm7mzz6RKpYwy+Vr3yAct9ox4Z7gmZkbMSZUb0JfmbDyhC3R0jD9/VAVACbuhE43XB+TMNbW2v3kAqqAyWrTIdQpFYMt7ySgLuT1Q8VPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8BKfi0uFF3/iYFK1Gxm4h3Gy20CylZyi/9jXV9iwfF8=;
 b=UaPRs24eGqowvjwaH+qyMDC+ooD3Gek29S2qK5zR7aULEw5tKARwJEdaVygkIW5CEVsanrR17aoZrXyu8VKIcJ2P1dIt3yzgFwihOqcd3xmZBBEoI72J9flmhrTtid2tYLPipcO4VXKgr7gpF6U3xXpLfV0GHq6u2+x7Uo2/UbY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by PA4PR04MB7584.eurprd04.prod.outlook.com (2603:10a6:102:ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Sun, 1 Oct
 2023 10:34:17 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::cc84:fc7a:cffe:985a]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::cc84:fc7a:cffe:985a%7]) with mapi id 15.20.6838.024; Sun, 1 Oct 2023
 10:34:17 +0000
From:   Josua Mayer <josua@solid-run.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Josua Mayer <josua@solid-run.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Li Yang <leoyang.li@nxp.com>
Subject: [v6 0/4] arm64: dts: freescale: Add support for LX2162 SoM & Clearfog Board
Date:   Sun,  1 Oct 2023 12:32:55 +0200
Message-Id: <20231001103259.11762-1-josua@solid-run.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0151.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::12) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|PA4PR04MB7584:EE_
X-MS-Office365-Filtering-Correlation-Id: 3922198e-f45e-4058-8127-08dbc269f6d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0sVxLVd0S/D+PG6HhcYBaQbOpQBVYft9Wg42WWgZoR9Ghk/e+J7WNwduChxRFhqYuHKwPfEjV+g5RuJtKAMzdpKY4R/rqNOHaHYxzQ9k0Acg3qyi9oqdSEI1fTgSM39HObe8ar7N6Es1dkZv8jUl1Rmd4FyDE+7Q8Np2o4TGdmARiWaR0PgAy5gi0u6hQAT9kF+dKIpjyLAULTrrhcsGRw3obdiJ8eZOeGDcnbVCIk3ZCqam7+R2mE/CNTpUH/VHqdhwyov7wogliSNpKXuh78Ez09lqIPTGNvieeho4Tnvwm2P6OB3XaX9W/ONdygFRtmYVtihWd2n3QFCtZefKk/JrhSCSb0LJgSWaNK1Wxk9zBW4NpRFMMMt16Q1qTh0YxG0D8nXe+fXQ246ZCIbKsdpnehLTS9oL77h3fH3BCAHivYkpWZQVoztZ6jh7iwyttxDiAgg4cvM+7JusEpuQ4xgtqldop0kKoSrLIyrq7rrSLetkUuT+i3tMEiPG7bwwOMD5Dg+yQvAjJmNv36hZ/VxYaun+XqGczxRJzXmzfSe/ih/a/T4oCEPUe/j5Wl2DCDGnOFqisoL4ss6mRhuTlQg+QoKxoZcpV8KEzbRDfHkPtq2ujhg6Amv4pmfaduVO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39840400004)(136003)(346002)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(41300700001)(52116002)(6506007)(26005)(5660300002)(8936002)(54906003)(7416002)(2906002)(8676002)(4326008)(316002)(36756003)(86362001)(1076003)(83380400001)(6512007)(6486002)(2616005)(66946007)(66556008)(478600001)(38350700002)(38100700002)(6666004)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FzKfpJ0ae1242WE1P1iQUI7jsJfFhj1dKlE3qmoY6zYP3XBE9RgAL/kD82jR?=
 =?us-ascii?Q?QS2i4USTENkmwqIN+xXyRE56D4FJkltBXU+ue9Zu35J059LowzmUhrJWqswT?=
 =?us-ascii?Q?oUnyfdBKmFNkUizsgd79nnS0G2AArqXg6bAjoFlhX+Yrl8HPBoui+HjofABt?=
 =?us-ascii?Q?p7AwqGMqVjuj7F8fzHTM7R4aHj04ROoJ6jKM7okZlTKGOtPkaeB8LQTEDQ9X?=
 =?us-ascii?Q?y1n9AK4r6Xisuz+4wCkSIWiFlBR78aQYOg9AoWvVb2vb106nsBZZmn88A/ir?=
 =?us-ascii?Q?ysqohfd6c+SMJrslgDzh3uMFfs4QCEeLlYmnLR5PKsgcaGKw6W7c9kSniEFT?=
 =?us-ascii?Q?enifx0AynCNG0MHOyXHAoJb3ZutcAOGOn8Go9pIMau2TKFAE41SKopGQ4mJp?=
 =?us-ascii?Q?rmPU97Zw1FtZNed3xgHBiQCRik7zFYXIb8XzIMr5kO2soHSFTrxmM2IU6LAO?=
 =?us-ascii?Q?iUsen9e/EEb37faHWOijhC4G0ZOblG7F/6uuQa+Lt9zo1K1Y+sMmsMFvYVHg?=
 =?us-ascii?Q?0ICGrFpQ0GJMyNxfFvxbfO0T9qWMY+fctynSDMB7x3HjhbCDCmG3aKNvdqrQ?=
 =?us-ascii?Q?eUx1K+hmdnu2KqqbTYw6WLoN30VFXcjWMZnhFl/ExFQ/vXcriUyukK9uypdN?=
 =?us-ascii?Q?UHCTpiWF+Sm1FqwiyhGBd1OCGpH5JgUQGUfD+ZLtgTA05Kv1wjwA/hkOrcDw?=
 =?us-ascii?Q?jlhBZtXM7Xhr+RTFwKDs9Zn8Mo/Jxf/FojYI6oUqLn3AFg/8hiMoFceIycr2?=
 =?us-ascii?Q?AT08buKXLuwE4Q1DI7Y2zW+3ss5NmZ+wZfFx2LV4RuxWQ9Dl54mL2bfuBkOf?=
 =?us-ascii?Q?pO2Px/u6Wr6SmFI1OSRcYFCxgObmATKtex2zoeFP9KVc6is9ptIBJ0xvDwQD?=
 =?us-ascii?Q?6PvSzjZ1ahY6WdhwtMudIehNJ/ado8GbpejGC97JgKfwTtLmMsN2x8hc/Hhk?=
 =?us-ascii?Q?jzf7H0hLREdnX/u38AdJ4qOXNpN6gCuwbMA/mcYsuASyI+6IiG+sev8WFqZn?=
 =?us-ascii?Q?CZBqSpwN9kTEQsUoJ9r0Q+E49efuNQIGEGr/z0wx6pxcd6yM7KNjWwpBIOE1?=
 =?us-ascii?Q?OUh0ZvHSnBX2LQX4uX1wUhi2bVa6otba/yl0tMwLqLFGZaQoV2LhciV9B8kE?=
 =?us-ascii?Q?XJNXtveLB6rQnRm5YLv2SjXgxzlyjlhKgkch/c3KNP4VxIAUMjB/MqtQWVlQ?=
 =?us-ascii?Q?SfuSHwy7Q15Hj3pnyKCd/KmSgrWskd1rm8zayAStgM5mEkeG9mvORRUJajqI?=
 =?us-ascii?Q?AlVMYYLkm5rRhUSHOVDU/4c6eefJE19b8x64ebLHq3sqMy+gaMzRgW2dn0hO?=
 =?us-ascii?Q?ocIkM2y8uxjtCRwZPcWKCrkvhFeNc+LNaRrcE1mQRCySP1I6j3fkusMz/Xks?=
 =?us-ascii?Q?cSbqTFoHLi2faGkeLof493XV9sLB3dTzP9fB3p2nyECdSlSBtgWP54HMwUZk?=
 =?us-ascii?Q?3j+fltvYo2JA33fIZHDE1cciKqaKladaRkDIOHvZNmV7AXKjxSinksJWW3Og?=
 =?us-ascii?Q?TH2Hkq5Zb6cH+4C81UiyJYH0EKllAkIjPKJBQPy0fjWZXaT7rD+naXkCzYe2?=
 =?us-ascii?Q?TZxB7Bm02nBLg+VTRdSC3C2HkJLUcDZNLTnsu4kH?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3922198e-f45e-4058-8127-08dbc269f6d8
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2023 10:34:17.3366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qEywXAp8VDkDplWZwfrmAj0aOxdKAwUkXdNDdvG5Ai6y5gPOb+mdIZgssk00k7/7MFBE/2xdbGdI1Nqaw5xWlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7584
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the SolidRun LX2162A System on Module (SoM), and the
Clearfog evaluation board.

This patch-set introduces:
- dt node for lx2160a serdes block #2
- dtsi for lx2162a system on module
- dts for lx2162 clearfog

Firstly Please note that checkpatch was complaining about the EEPROMS:
- DT compatible string "st,24c02" appears un-documented
- DT compatible string "st,24c2048" appears un-documented
- DT compatible string "atmel,24c2048" appears un-documented
However to my eyes these *are* already documented in at24.yaml,
and are also used in existing device-tree.

checkpatch is also complaining about various parts of lx2160a.dtsi,
as well as the use of "sfp" property in dpmac nodes - which are common
across layerscape based dts.

Secondly the MAINTAINERS file has not been modified.
Is it required I add myself or *someone* for these new dts?

Changes since v5:
- moved status property to be last in esdhc1 node
- added empty lines between led nodes
- moved i2c2 node according to alphabetical order
- lx2160a.dtsi: disable serdes_2 node by default

Changes since v4:
- extended commit hash reference to 12 characters in description

Changes since v3:
- moved status properties to be last
- changed ethernet-phy on som from /delete-node/ to disabled,

Changes since v2:
- fixed property order in som dts such that compatible is first property
- added reviewed-by tags to bindings patches

Changes since v1:
- fixed DT binding changes to not break existing boards
- explained new board / som DT binding in commit message
- added missing DT binding for dpaa2 mac "phys" property
- reordered "compatible" and "reg" properties: first "compatible", then "reg"
- replaced chip-specific DT node names with generic ones

Josua Mayer (4):
  arm64: dts: lx2160a: describe the SerDes block #2
  dt-bindings: net: dpaa2 mac: add phys property
  dt-bindings: arm: Add SolidRun LX2162A SoM & Clearfog Board
  arm64: dts: freescale: Add support for LX2162 SoM & Clearfog Board

 .../devicetree/bindings/arm/fsl.yaml          |   9 +-
 .../bindings/net/fsl,qoriq-mc-dpmac.yaml      |   4 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi |   7 +
 .../dts/freescale/fsl-lx2162a-clearfog.dts    | 376 ++++++++++++++++++
 .../dts/freescale/fsl-lx2162a-sr-som.dtsi     |  73 ++++
 6 files changed, 469 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2162a-sr-som.dtsi

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Li Yang <leoyang.li@nxp.com>
-- 
2.35.3

