Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECFAA769147
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbjGaJQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbjGaJQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:16:41 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2044.outbound.protection.outlook.com [40.107.8.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6F610B;
        Mon, 31 Jul 2023 02:16:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P79+cnwCnl6NgcAIG33z+8ZtQcFIRa+UurbRzfYQFyFFA0MaUM7Txhy9ggmb6y9M6uFtSGzIqyX184+a69O7szG+c2+2L/JM7zgdqj507opbIbrZIulcVUQMBoJoasJIJgGky/6ic7GU4MRuz5p2g/DLd9s5hpMJLNHMc1Hc3gawyIVWGy5M02h90Cq9t/CBSWZYptEDPENNOlcQhdVgrptf3VPdZzP24G9oJxQNtJJNBMzcCFaKtuVhSXqwds/aEfUQMnXR72pFAzisLxSI2eRNF+/3MYEg0HFtKdrz60wph8wzPl5uMdTxgR97EGDjxySyBegLkA4VZPq3SAyuLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o5KoFZiUbaqvuaaXiH0Mjo/SIiA63I0U16Rvyicwd+E=;
 b=Dwr5yQfsoFihw457yiG9985I7qL5GKWvBT0DQOdj+c5KM8fo/9WmkrxOrkly/GPndrRfD+t/U6l4su65mNEv4CqWl7ybs+9cs0FIjQKxtceWsGYQjnBmLLiXzPxPz53iBjMamfiW9ZJF4NyixpKwBUFbtkuCb6h6rODLL1gHrH46tecSpO4v2uuxKLbuY9BWQy08t7Imn/EQ/p4kT9tW7KQeXDSh3a0u3310b84Qpkb7ssgO76SPSyjBr2G4dkRGW2a1GjOZ269JNBy38bRIv8hc2akPNOjqGBSrrSS5L+fiohN51PvIsNgrI9jRNOWl9bQranOWBwjbPL8t0h067Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o5KoFZiUbaqvuaaXiH0Mjo/SIiA63I0U16Rvyicwd+E=;
 b=GtqqUWc+Z7v8FMk56TiNTbwEQlQpXPTPLaoyqF2svgQtrqDYNrMNtpFxQBQd99BQVtq4RRBqjXsrYjmLRuSZ08c2qraOmAt/KJmBzmbnZH+1ZAKHfSOlkVkZbQ7tqZ127xY3EemOx7aaiVlh3aRN6lOARsz9x4CdeH3OeFG+BFU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by DB8PR04MB7018.eurprd04.prod.outlook.com (2603:10a6:10:121::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Mon, 31 Jul
 2023 09:16:37 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::74e7:6384:dbdc:e936]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::74e7:6384:dbdc:e936%5]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 09:16:36 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH net-next v5 00/11] Add TJA1120 support
Date:   Mon, 31 Jul 2023 12:16:08 +0300
Message-Id: <20230731091619.77961-1-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0044.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::13) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|DB8PR04MB7018:EE_
X-MS-Office365-Filtering-Correlation-Id: 641da765-827d-4517-6ae2-08db91a6d75f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LFBvM/c6WomsQXjng5FuFy6Kcz3D+54j4uh6kCfogYPN1dwGUouGhe311fY3ztqgqEDiWL/QYwR5EwKj71gjq1eAeFIfLNdH/aBxw+KlYdeHhdR43QRaTyhfxN6FWk1CqVFZdwnY5wDCcg4CR/5Yhp0PedLl/vhLWBY65v4+1j5qi3ex8Q9KXAD/eBGZnsINSyu8MfpvOWhNNZW1UfZ6E5AhO9mOr6w+SWoifuK2kq9vFsLVAmuxDnK9kNq31LrUhdKIDxVYsv+DbWK7oYH185EorSsd44rMoE8EUOafS7DLg/6FeT42c9ZSQCYR4D+E1W0az8r05vxKPpTscLn/F5yFjsw0MGXlTCGWmVSIqf6k6imZGEWG75St5jqBLTlZ2lX50/mh0ENZ7yrSLejdzsAH007gyad1vPbZc4E3wiXlI44Acq+s7gUcLGWKaTsoDIKP1WyiQfVSGU9qsocsrCm2U3P54TZcTCTgpWYnPWB3bmAbEM1p8EvDRA3UUADx/xgLpwZLtbB5HLzeF0sj8VwGYMW4rIMMj7dFd++NyQbrIJR+pmfs4KVsmWGavxaam5utXUkyQvonNmF5Wtz2RDEcHQa60ZM0IRt8sjV+k9KMvxR9Kvr8LWEikyHwBiQb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(39860400002)(346002)(366004)(451199021)(66476007)(86362001)(41300700001)(8676002)(8936002)(316002)(5660300002)(4326008)(7416002)(66946007)(66556008)(38350700002)(478600001)(2906002)(38100700002)(6666004)(6512007)(52116002)(6486002)(6506007)(1076003)(26005)(83380400001)(66574015)(186003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WkV1uILUjlP2sb+Uwf/yzEVRlC5h2vJVsTdCkajLw5yYeTl5x9JS5/fVEw6K?=
 =?us-ascii?Q?aeNs49TtIFCA61BxH6mujcB6zRk/U52bP6SDLoZ4b+tnzrkfgg7OmUhHAEAs?=
 =?us-ascii?Q?KXmxJH9BOQ/TIJNjWpBKtXyrbN3VVS6XuxljsCpLmiR5JRWNa5dcyu8G6u8P?=
 =?us-ascii?Q?ze6+wLW31cvKYwQ2BrDkzlIyMVmtItLVMAQO4FZNjiVpFrGVGFVzOuXcWQXx?=
 =?us-ascii?Q?6baiosP/QtnLjUtuVKbzKIbT3LK3v+8AQqVDJbSzjQJMdIj0Un/MyXPrC9s0?=
 =?us-ascii?Q?9WYvAyN97L0jf6X/10Azyiakx2vq+rQ6JVlXfipS/RzU5Ont0KlV78OjC6Hk?=
 =?us-ascii?Q?pHjJ1gI+e2EcTygeDJBwh/y7IAcujvmDj/gp7ArW/m+SQmaHEPlGjyTmsWZv?=
 =?us-ascii?Q?ylWBz7B0uBqT/ZPhXBMdno7YT2dpMLnL04qnT1zPE5QWFBpk9yqh0u4i8+rh?=
 =?us-ascii?Q?qmMzt8IdRU+6ENlo2yn1mem5k85YoyH/epeyaBkDZ+mMB+7zeIeLjaGgKX7D?=
 =?us-ascii?Q?eoeTxauXdn1Yv/ylSh0Db8rcTTTWqh205a0MIpwqSV0OMM7n7XLHh5FOrN8m?=
 =?us-ascii?Q?yjGsd0J2+o5RFNIeMgE0pi6YGlsFn8+GEpmY0LInEHT1DnY16lsH52Ag6pO6?=
 =?us-ascii?Q?wTcEn0SPkzESOAu96zaBtgU4BNVyed3jfrFncccqESfj8EfiMBVUraF6TYHS?=
 =?us-ascii?Q?i81MX31nYUZ8vmOT0BiJR2sPo6klK8ZcHVMcE/lhQ7qxnluPdYnkDEyIt3gN?=
 =?us-ascii?Q?yrcUgBGEv4BSp153Av+X5vegqUFFx0JADlj3Pflni2tb/Td40wj2WWk15K0B?=
 =?us-ascii?Q?HNb0HfsU92iUIYrcaG7dU0qqVlghn/B1BBzsjZhOp/NvfxPbaC3CJt7kACVO?=
 =?us-ascii?Q?AJEeuR/JsGL2xqV+yUNYwavt1vqB6hRpzfT20FA0/US90RQeg9AT6/xMv7nQ?=
 =?us-ascii?Q?2vzDvKbGg9c7eTn1dmF4gwnIBuT2CQpEXdLCE/pSb7PrMWR+uBR9WRFaLgtR?=
 =?us-ascii?Q?r3ij2bdVHDE6gH/c+L5lN7/2ASXVnMy/INyLaZBURmFqETK4a38xwdSplMjz?=
 =?us-ascii?Q?WmHDY1DX+TlqcNmPeWL8Xk95ntbStrN0Zd1qBH/uGtPieRdP6eKbEYrhaW1A?=
 =?us-ascii?Q?tFHYtwRpmWBYHnTlL6aidzNIJPdbvKYGgHeaxdO+qxkavhOxP2p8ArpuBeDl?=
 =?us-ascii?Q?CGCfq8Ac829t2XNkoH/Q7tReTRvrON/3dgSO1gEbIpTNg+L+BkYwCr36jAUH?=
 =?us-ascii?Q?gupmE6xc4q/xeSvjvgvAP5xRUEKfi5s6NueZgyHEasRqoAnxM0z6hyt7jf6C?=
 =?us-ascii?Q?oZhasq3FTGWyDLBgFxTrtgse5BK6BnhlBMhcpUSYzDUZqAeIVfnVzVu/1Dsr?=
 =?us-ascii?Q?Au6LwomxHwmrJl9042632oIc9g2vErrVicEIRqqo8pYhSJpXBbI2S22rnzV6?=
 =?us-ascii?Q?Jc+6SEG74mQYksmxky7jpaa7q2uhaqrohEHuH/p0u4XXfiXPJU+I0PkuQtL5?=
 =?us-ascii?Q?xYhLI5f7RnFEr9BmfKt4UObkgdhUOK7gXZ08F8LVZ/PSePFYY+k4rNBDDd/9?=
 =?us-ascii?Q?B1Qo3i0/MkhwnQ3drAvm6UODzPd9gqdDIRyfQnkq6Zwq3MJfmdJS7WLS8aCd?=
 =?us-ascii?Q?gg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 641da765-827d-4517-6ae2-08db91a6d75f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 09:16:36.8781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oaj5e+dR0InW4qrcfJRudUSDuU7o5ItG0AN+qfRmU9Mxa2sAaqiYxaFxAQAeE7VOrKJTr2FSBWRlFgnd4CK77Bha4bBgr9WXVkDJCHcEKs4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7018
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

This patch series got bigger than I expected. It cleans up the
next-c45-tja11xx driver and adds support for the TJA1120(1000BaseT1
automotive phy).

Master/slave custom implementation was replaced with the generic
implementation (genphy_c45_config_aneg/genphy_c45_read_status).

The TJA1120 and TJA1103 are a bit different when it comes to the PTP
interface. The timestamp read procedure was changed, some addresses were
changed and some bits were moved from one register to another. Adding
TJA1120 support was tricky, and I tried not to duplicate the code. If
something looks too hacky to you, I am open to suggestions.

Cheers,
Radu P

Changes in v5:
- replaced strncpy with strscpy
- reseted -> reset

Changes in v4:
- rebased on top of net-next/main
- dropped "net: phy: c45: detect 100BaseT1 and 1000BaseT1 PMA abilites".
 Already part of upstream.

Changes in v3:
- merged "net: phy: nxp-c45-tja11xx: add *_reg_field functions" in
 "net: phy: nxp-c45-tja11xx: prepare the ground for TJA1120"
- rephrased the commit message for "net: phy: nxp-c45-tja11xx: remove RX
 BIST frame counters"

Changes in v2:
- dropped "net: phy: nxp-c45-tja11xx: fix the PTP interrupt
 enablig/disabling"
- added error msgs to nxp_c45_set_reg_field and nxp_c45_clear_reg_field
- used phy_err instead of phy_warn in nxp_c45_write_reg_field and
 nxp_c45_read_reg_field
- removed null checks for .driver_data and its fields
- added 100BT1 and 1000BT1 features bit
- replaced .features with .get_features
- dropped changed on TJA1103 EXT TS behaviour
- improved timestamp reading workarounds
- merged patch "net: phy: nxp-c45-tja11xx: timestamp reading workaround for
 TJA1120" to 9 and 12
- implemented PCS reset workaround in link_change_notify callback

Radu Pirea (NXP OSS) (11):
  net: phy: nxp-c45-tja11xx: use phylib master/slave implementation
  net: phy: nxp-c45-tja11xx: remove RX BIST frame counters
  net: phy: nxp-c45-tja11xx: prepare the ground for TJA1120
  net: phy: nxp-c45-tja11xx: use get_features
  net: phy: nxp-c45-tja11xx: add TJA1120 support
  net: phy: nxp-c45-tja11xx: enable LTC sampling on both ext_ts edges
  net: phy: nxp-c45-tja11xx: read egress ts on TJA1120
  net: phy: nxp-c45-tja11xx: handle FUSA irq
  net: phy: nxp-c45-tja11xx: run cable test with the PHY in test mode
  net: phy: nxp-c45-tja11xx: read ext trig ts on TJA1120
  net: phy: nxp-c45-tja11xx: reset PCS if the link goes down

 drivers/net/phy/Kconfig           |    2 +-
 drivers/net/phy/nxp-c45-tja11xx.c | 1136 ++++++++++++++++++++++-------
 2 files changed, 864 insertions(+), 274 deletions(-)

-- 
2.34.1

