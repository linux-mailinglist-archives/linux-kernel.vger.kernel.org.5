Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A12780AD0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 13:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376486AbjHRLLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 07:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376537AbjHRLKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 07:10:43 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2049.outbound.protection.outlook.com [40.107.14.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE103590;
        Fri, 18 Aug 2023 04:10:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BDW9PSifGoshQmh1yo8IJhPUVhaBgB8atkzGirCsk87zoYvjSMt9Ix2SRwtwb/pUNI4kN4MRnELOFMN50xtuel/p3L3SMTzJa0x38ZzFsvh0aAlygwd2HGWTE6MDF8HkHzn/2snR6233W1TYocxYNRJMsqF2xxg4A3IwXeyretcZn56k5XsT3ZOl+48877j4rn9fp5NgsSuOW+ULRPxdcBKNKZMstDfkVhFdfK90ApJ53KKxc/D85n29eCDHsmYkZPuPMyI0UmQ+SUn44P5Mim1efsLDOExsLmvtUN/IFKoiO6GgyEnoAG9uE9K/aP3xCfZMRXGrjVAuvOyIf3476g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4IhvUTogF4iPojnG+b/1bEz9tgJqbhk+exdZZA3DOIs=;
 b=JEUg9ilTKDS/ZrKk7eW+HQ4C3A5Z73pGkU3BTUrPWJoIfmMovt7mwPVQgh3lnpbsD8Jrq2ZW0GV1siui6YWMZWW7EOO3h79oNN8xYZKdh6ArrAC6cWoHGTEq61PAFyKC0q1bE/QJsiotizqzmDDMzegHqRFyX5SDD6DJ3ln4GcSM2neXMRbkzhjkxET7VNvt9bVbRFNhulpKeJ9e/8ggmmc2iLD8U+958jkg6wOw2GcMbV2QJeGWzjhBtBz6lRRiPV44OLqzBd8w93YF2TASFg9hRJRCXaLyHQsrmYxaug7G00fR7rXAqgIFUEAxuHtbIOPqRSL6AfcP9ICymy6grQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4IhvUTogF4iPojnG+b/1bEz9tgJqbhk+exdZZA3DOIs=;
 b=XxjHMGfCQFdztjZgBgmfx3zXi9I23ngWBv8I0kOLLzylGmuEeVS6kK6N9rpsT4w9rmyLIJt2uK39CPVQseMjO2wQZ5emeJCPsvaltBhe6lgSlAdD2rO+uqT6YKM3V9++FBMRO3wVV66sOMQe2RQA6CRMY9GxVmotn+sRabsWgeo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by AM8PR04MB7969.eurprd04.prod.outlook.com (2603:10a6:20b:24c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 11:10:36 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::c19e:3b5a:c081:ce3b]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::c19e:3b5a:c081:ce3b%4]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 11:10:36 +0000
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
Subject: [PATCH v5 0/4] arm64: dts: freescale: Add support for LX2162 SoM & Clearfog Board
Date:   Fri, 18 Aug 2023 13:10:12 +0200
Message-Id: <20230818111016.11271-1-josua@solid-run.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DO3P289CA0013.QATP289.PROD.OUTLOOK.COM
 (2603:1096:790:1f::16) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|AM8PR04MB7969:EE_
X-MS-Office365-Filtering-Correlation-Id: 183c0ea0-6547-4571-56fa-08db9fdbbf5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NVWaTESFdOx8G2ZRyty6XrxJW+SEaoSlNXjWlwRi9mn1n86b5OMDSCeI8yhS6PKK0t8VhpwyK83RNRjBjHwp3ktcIILtK/Bwt4L4Gv4o04kShMN2M4JmG5EvkSjf99gngqKk4uPbYqDC4Kc3IR8oGkF4ioCinp4VyfQaklhQSIF26DPZyCL76BSCreV23TDJz5NllYOMxdH4ozLLxlFvLoVSmZj3z5QTjzRcT5pWcca9lWz9xpaXUUtZ5orGriJO/budCq9nPVdD4NGPu/QMU/qPO/HSAKa1yuCyrh8/a5Lj6/29XLV4OoCl7Ek+uc85l5ciJClvAVkg5mM5zdxYLXL+8L7ozilUTdQkQyzzVXDACNtbyCZerpjoY7lXDv8/zkWHJt5MOcszgnunsKi9R1csHDJBe+QLXxxUlWGEdfg+mcBx6qhpBqVhVSOpmLqTiSHlSNZSp6Q1/ePwLc7ecjRaGazF7CGuxFKC3zUiMiiAfJv1MgGK+XkJfEP+mLA3fbN3/RC7cJ5x3lQpGpXAW/sthy6adAmQ36LoVyrwsGmAnepnmKoKbJKvkAAF4Jrm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(366004)(396003)(39840400004)(451199024)(1800799009)(186009)(86362001)(36756003)(38100700002)(2616005)(5660300002)(66556008)(478600001)(6506007)(66946007)(66476007)(6666004)(6486002)(54906003)(316002)(52116002)(1076003)(6512007)(4326008)(8676002)(8936002)(41300700001)(83380400001)(7416002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tPGiMH39DoCfjdmajCxYZo6hN7pjx5ofEh+r1lAAHOqQ7BwE3QPEtNWAXnbE?=
 =?us-ascii?Q?Xl6DC3v9846YcJdvpqbwiuwOvef6iTslrrOlohiN7A/kiEcrtJwPkkmRwcFI?=
 =?us-ascii?Q?wwIlbgiflckqUPv8IwLG1zSJBMtxfPXUuxBlEyCkDETD7zXEgCopVxKKbwAQ?=
 =?us-ascii?Q?5lR2HvurSjEBtIHFd6gR/x2q6bHrIiKjqx8bujXzeqrtXOKfjDkDoUX4gQ9r?=
 =?us-ascii?Q?ubHVnE5E3z94YV1xvHnzGK+Sr/0yxT0tukJzI9fWhbln3p2tFU9ylvU+AREJ?=
 =?us-ascii?Q?FfBK7mj78i39JGKT/eAANorI+lewKD9F/CA5nT1BpBidBAFcEPs+PO+Vgr6c?=
 =?us-ascii?Q?X9QK2Y5sMwQqCnVizcfriwsOeeJOlol15XLeHn/yhFFYl4uHKkxUfKl0UBdA?=
 =?us-ascii?Q?NOGz72ybFbOVrYE4edAG5DSMf/sBVOUOErmOxT3TF99TL4XEEv4y55sFn7JB?=
 =?us-ascii?Q?8/77IEDS01NCd+g6yPmEAr3J6kEO8GiFD6sF1ptgrTDs6t+0fR8pqykgthyJ?=
 =?us-ascii?Q?KGcwU9oO2t/UIxdJx15a638h50RH6JUCkWslRREJ37L51JAXgfliAPK++0dC?=
 =?us-ascii?Q?2tOY889Fns79tk0Og7civrLG0A8OexAgUikexjkAuD+Q3TBHCjM1c0SR4ueY?=
 =?us-ascii?Q?WH3dNNSR6S4/aQ6MAxDaIvapRowyTHbn6lXN8yDF0ZAMGmj1ccnQPEjObp7f?=
 =?us-ascii?Q?n/JXuZx8JbMc1e/rcOUh1m3JG5K9fwhnclpZRGk21Uyrp7cbF9GVYHSvf2E7?=
 =?us-ascii?Q?109+VshCG+zAE86TntvA7EiHfATqNAYc3cdPbmRlmrjRX9J7hJbt53LPBROK?=
 =?us-ascii?Q?N4PFQkxxR9ing/NM0uJ8WNLrWtjVaAMUMK87xEaqV/b/K5G71s0TD925QWvu?=
 =?us-ascii?Q?1lPWJiXT9ztiYW1V/vxqCzP/sFGyhUqoVIdXyo/bRKYgQ7W5ncCmsFhGNy3N?=
 =?us-ascii?Q?nkAQFBK+bqIw71+PZHUPSD0PwAbJee6snkWrm86jnCpsfqDebo09lKgElum/?=
 =?us-ascii?Q?SjSYsctzxLFzSzwb+lKh+2kipuPImP38g9JDc98BLgDuDAYMzOTN7XHuEMaf?=
 =?us-ascii?Q?GAYuxmCHImXUHoAb8XmbM10DKxaPTVJNi4wVqkGyuIm95wI2LnWtbl1MsFFS?=
 =?us-ascii?Q?s8xFESfL+IYboTYy+m3vk6Pc0+4dgfqWWGxWqsrS8M0Ik3ZwNTmcAyLhIVB2?=
 =?us-ascii?Q?MOl4+NnduwtDxwxpkVpg+QYjJ81DdRZ33cZLIr19PwWxNqWkVywVke4CznQN?=
 =?us-ascii?Q?8S/SaBTZ3icVdzFsXJFxbADlctyn5PMZfhRYL3pChXoVmgQFRzewh2ere4Ik?=
 =?us-ascii?Q?AHX7UhtzycAjBWzkA8p99yyMEmO2SxQAMRstI0+7Jl6CiO7WBeRJL/HnDj9E?=
 =?us-ascii?Q?/oP/e7BRViW5k/lh4SbdLc4DVNb5sX/qV/Qiq784guoTgXwE0PeOBV786/DD?=
 =?us-ascii?Q?aVXhtS1m/f68EQjYKO+ilKPDYoBVBeLgrPk9ut5/HIIpT10xlzqIOoncO+04?=
 =?us-ascii?Q?kKuUMjSEgIZVYJW8BwVtpJ4kG78FiGOu5N5zZX1Dx0IeSd1HwifrAs+gsc0S?=
 =?us-ascii?Q?XYMjhBmm67EQ8yNc8Gnc+fmcZLC1TQy+gFHtdV1rkJAtRM0AEmXPdDGH0qrj?=
 =?us-ascii?Q?FT3AQBcA8NkqrYZOdIejTRA=3D?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 183c0ea0-6547-4571-56fa-08db9fdbbf5c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 11:10:36.3324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +VdKC6arstppHDzIu+6ZCgjplAyiCujgZuxS4c2r+TqGHE8Uu8TgEohSsc3iTlfyB6Lzsijj0X4s0T5ZRIex3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7969
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
 .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi |   6 +
 .../dts/freescale/fsl-lx2162a-clearfog.dts    | 373 ++++++++++++++++++
 .../dts/freescale/fsl-lx2162a-sr-som.dtsi     |  73 ++++
 6 files changed, 465 insertions(+), 1 deletion(-)
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

