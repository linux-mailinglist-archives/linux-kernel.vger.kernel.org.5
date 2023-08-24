Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F94786B58
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 11:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238609AbjHXJRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 05:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235655AbjHXJQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 05:16:51 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2079.outbound.protection.outlook.com [40.107.105.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEA3E67;
        Thu, 24 Aug 2023 02:16:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Za3NVA21QcbQPvsvKsCAUtf+zBwlak5p9aNSAgIEN6OcKhix691OtITzU9vNPXSUaW1YBRKQ+o6Qc9YrptDehkSRO6BsSElmiLl87YW0Lk9TylmVFxLoCyFUnI4eMhGY5byYZz7lUuRW5VSTsDFa+nGxH6cbxr/Obq7ONPzknFLG4r8As0VoKnN8saZCC/oTPg4YJp2QwKbybIhvRVOeakE5ZY/oDc5mus5ZwbGjwXJLm76rmk1QFjFmXigW8r0939BEe5tuXzmOMHgfAqCmaJNJk7tph3p4nOYI38UOKazwqCambeUJJlN3RRVUx9VTzeE6l+MXBCABZ2YOa2FrSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bz4d5QgfJsM1JACZXhgGYWq7XAvNt0arNLip1fO9B/k=;
 b=JIP4dSF/5GF0Ll+AZpPjzvAL5VSBeAuwhZFLewRu/0W8LoLLcHX6fPAn+nS4eB1Rvq7LjR9vDmn5Ti5cOZua1Nps8YesDah0XifrCtaC2TyiMCYBhQw+2kdcfRPUVBXvn/rdxU5eN3KXcggzRJHqhoA8hnSJAmTelp6rcul43C1k489JgWhHrsyP35ibGpl9pInRteRbtUPbnasJvQdiqxad203Prub41s79Qm0g3FDGi4GzholOYp8UNcOFVmWADr486qUmxzjaLQk1bYXJjsme0Yt8zqKf4O8YRJUKNTCvFtJe1ckQ7w+JFG2hTQKwGrRoq+7AUNraffSo5eP2cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bz4d5QgfJsM1JACZXhgGYWq7XAvNt0arNLip1fO9B/k=;
 b=OhDLFpIiPgFJiVMbkpsyechWuw41w1KLKE+cBtImS3RGi8ndDl1Ut3yOyNK/VBDuyP6g8Ucuddh8o7IEvWMITIFHFFvkvcTs+C3Qyizgp8n7KrrmmikZtOYlg4i9e7wKBEJCTFpnlAMgnCRUJnFc6yoH9CAILWo77dwmCEgbP1w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AM9PR04MB8260.eurprd04.prod.outlook.com (2603:10a6:20b:3e6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 09:16:46 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::2545:6d13:5905:bf50]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::2545:6d13:5905:bf50%5]) with mapi id 15.20.6678.031; Thu, 24 Aug 2023
 09:16:46 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com, sd@queasysnail.net,
        sebastian.tobuschat@nxp.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [RFC net-next v2 0/5] Add MACsec support for TJA11XX C45 PHYs
Date:   Thu, 24 Aug 2023 12:16:10 +0300
Message-Id: <20230824091615.191379-1-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0116.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::33) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|AM9PR04MB8260:EE_
X-MS-Office365-Filtering-Correlation-Id: d6e1db38-0f23-4168-4fec-08dba482d685
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fiH/W5TLfhZkGHINdTbwo7nCDsdUaG+RO0et7B4DANTsfzaNmPrfX3xrKg3u7dY7Kb5G+0IkOn70Dx8MTiwF1vvDADYWYMvlcMPQNZDUKTBrPEn+IXSz4/2WvaCIGW4OwccJ1TporEWTj57xHNWc64IRJNIhnZEMMDNNItlj0TryiAgCAdkX68EkjrukwDBnq7LyniDwFMvbuMCENSboyxD7fZSvJNDnHHvqugsRR3r92t4jVudUrCEt1tYUXRxDjd0N/vqK2lNYhyY13vUHJ4u/KAU3Kp+px113l7YLaBo1mZIAP7BMJykXCCdWdE2mJNsEmmQXMbE5qwQcb80TYTQsJDZIcCddudhDDxWctcv1Rb7q8iFvn59AYV/G63ubT4TGT7LPCzZ4RoytHIOKH2gCNX4QDCTNPO+cuKSaPcIRCWFhqwG7BhOzpbMrHeu2Ogh2/HvIRdq/vPY858IeSzuZoDXExVkA290FyOijfMVkQRl83T2zJCtI/EAZRprWn/riP0sHJc6xG9pvbkmFRzo0QUHExYL9r2d5bthGVjE0YUWsJ/zBL1EElGbV2Cw0ArIKK66WeZF83hcZ1t2nmcYZoSOjx9cHVcPwnUeh5nNDVUPSF0J4iT65vei7Pc9xSC6ElBryD6V3nIgklYu6HA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(39860400002)(376002)(366004)(451199024)(186009)(1800799009)(66556008)(66946007)(66476007)(316002)(478600001)(26005)(38350700002)(6666004)(921005)(38100700002)(41300700001)(52116002)(86362001)(6512007)(6486002)(2906002)(6506007)(4326008)(8676002)(8936002)(1076003)(2616005)(5660300002)(7416002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9B2AZx/F5XiPHm4KDUNIv9lAxpFEO2sfJTbw0qC0jZKLKFCVspgxgIi6ID4Z?=
 =?us-ascii?Q?NDclhgVBNtcTl0hjzG/xcly/X+Zn8OXjuD71m2wuAORaPQN2xb3wfIwX/iKz?=
 =?us-ascii?Q?75f2Irf6ZnJ4onh7yNv/4y2qHlygdw6U4Y25rE6KU8BSDv/T6jBaDWdTFzcd?=
 =?us-ascii?Q?PwF3mSNMPvLYMRDvgSh7G+DVIvsV9ZzZASCdXDHeiiUGJvVt1NhxrLZWLtIs?=
 =?us-ascii?Q?zxoCXFE9R0jn5LqDpIJihaaXZA4x1WQN3mh5YnZSz0osFPfpkfirb+U7a5jE?=
 =?us-ascii?Q?t/zLroYB7yYGmBrN3tYJ82Qr7+hlyrDTSFCwXuVPexXEpJn9U5jzMWnVhLzM?=
 =?us-ascii?Q?ZXL01LAG2s+6gkyeT6PU34monBWHOuBDS3rca1V3GoT/vqaTE6OxY82028kq?=
 =?us-ascii?Q?8lxDN90F0SP+2vt9IKJ6fU8n/oTDDuN7FpP6XN9eML0dt55cZrV8LMjd6Hs/?=
 =?us-ascii?Q?0hDzL0vCgLii6B4qxE9MXx/PL0HTLDzh2p0pYcgrAz5h8hJLoyrVDjmT80Eq?=
 =?us-ascii?Q?Hduy0b9Oj3qDsprI5hD/DYmqDNU3/YzVvBoJ3okQnPb9pRRFqkDHhtSAwHEL?=
 =?us-ascii?Q?wryYN0V5YXUgutoi0/ce4sDiTVSnplsduaREBCmYoO95okBdrAeR5iSHC6ds?=
 =?us-ascii?Q?mTK1cSirE2SuYxTvSkA+PHPJdQDbMRYpPYqM28RvV29gtKwOz9bScs//p1XS?=
 =?us-ascii?Q?0/fooFX9+6VvKFP9q06yToIcA8OBsB01DdL6dzM6qfQlbZ1p/xEEh6hJfV3T?=
 =?us-ascii?Q?lnkDZGXkU93sXxlAL4IuzPWtb0lMZVnHUAHdWVqvP/kkx2+cNwZwSXtxa0TP?=
 =?us-ascii?Q?BUb7WfLNp7kjA2AFZyHZjoCnAVXezKEXrAUVxfpjCtnwdItoftVltUBkwVfE?=
 =?us-ascii?Q?oKkrBYXZ5QOSGaGcOElQLe17y5RAojIRSgauIBkq1oWX/+QhUBykg8JQALrt?=
 =?us-ascii?Q?J4MMLvDDEaJVDrYBCsYe+MHMEZR/Mk3QqXLhb+EmQKGXcu/mwsUTi6ZsTN+V?=
 =?us-ascii?Q?G3tKtKwyAENDUlLVLrYasjypcsEceNkzRn2Z0VrqNNo//nOd72ctUXKB13jM?=
 =?us-ascii?Q?Ma5WCVQFxb4+uuglI2a2ey3YutOn9H+/5WIiJvHy3QF1asjTgDRbmsJ96zOx?=
 =?us-ascii?Q?XRUev+A3lR45udqik6oYMKOo00q64LkC8O84LposRe+ais+ZLV6ZmQKdgiAX?=
 =?us-ascii?Q?PcpydyNFR+anXbwYKSe9sDId5r/akdaXp3YuMZ+rURZV0bMovwjir8U1J1Gm?=
 =?us-ascii?Q?Sqrcsx7c/W7Z2cYG5Sr+HJh05zDcpQvFdjcV6wgP8Awe4f+LgbQYnnanP3vj?=
 =?us-ascii?Q?ElMwMRmMhbHdRT/Oe4uWF1QESZtR/TmlFi2xfCmdyRXjbbCHMEr1+tWrQqRH?=
 =?us-ascii?Q?ZarxuwlG/GoxheRX5P+BwDw0NeJy2nVur+DMsiOlELV6QrsOJc9O0MdjJSrg?=
 =?us-ascii?Q?EoW0eqMXbcdLkDuqvrjUVRlNj4dn0VfE7Sugehe6C9XnaeRucDyfAT7kkFm4?=
 =?us-ascii?Q?V22SdO10z6iDnqw2amg/8bC27oXcrCgRidk1j+74gVevfrx18xxraNbdBSQe?=
 =?us-ascii?Q?xdiW846VpoU3oTyPN1EM/ANQRXe1skIy2CcBGUcm8W6KWxCHo2y8II+DLyQB?=
 =?us-ascii?Q?WQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6e1db38-0f23-4168-4fec-08dba482d685
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 09:16:46.1383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vvvX5Dmo2toDx4oRlLsKotDuaQsOqTunQLO6KnmQVHSyr30iXgEZS1zobV/qBcxXGNlQDfC0664MC6geuJZJv8FCRfxp/aNRNbFqavQ+5Zg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8260
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the MACsec support for TJA11XX PHYs. The MACsec block encrypts
the ethernet frames on the fly and has no buffering. This operation will
grow the frames by 32 bytes. If the frames are sent back to back, the
MACsec block will not have enough room to insert the SecTAG and the ICV
and the frames will be dropped. 

To mitigate this, the PHY can parse a specific ethertype with some
padding bytes and replace them with the SecTAG and ICV. These padding
bytes might be dummy or might contain information about TX SC that must
be used to encrypt the frame.

On the RX path, the PHY can insert a similar tag that contains
information about the RX SC which received the frame. However, the RX tag
is not enabled in this patch series, but I consider this important for the
review.

Radu P.

Changes in v2:
- added documentation
- reordered and split patches
- WARN_ON_ONCE if reg address is not properly aligned
- removed unnecesary checks in insert_tx_tag
- adjusted mdo_insert_tx_tag parameters. macsec_context replaced with 
 phy_device and sk_buff
- added extscs parameter to allow the user to choose the TX SC selection
 mechanism
- improved patches description

Radu Pirea (NXP OSS) (5):
  net: macsec: documentation for macsec_context and macsec_ops
  net: macsec: introduce mdo_insert_tx_tag
  net: phy: nxp-c45-tja11xx add MACsec support
  net: phy: nxp-c45-tja11xx: add MACsec statistics
  net: phy: nxp-c45-tja11xx: implement mdo_insert_tx_tag

 MAINTAINERS                              |    2 +-
 drivers/net/macsec.c                     |   96 +-
 drivers/net/phy/Kconfig                  |    2 +-
 drivers/net/phy/Makefile                 |    4 +
 drivers/net/phy/nxp-c45-tja11xx-macsec.c | 1877 ++++++++++++++++++++++
 drivers/net/phy/nxp-c45-tja11xx.c        |   72 +-
 drivers/net/phy/nxp-c45-tja11xx.h        |   55 +
 include/net/macsec.h                     |   46 +
 8 files changed, 2122 insertions(+), 32 deletions(-)
 create mode 100644 drivers/net/phy/nxp-c45-tja11xx-macsec.c
 create mode 100644 drivers/net/phy/nxp-c45-tja11xx.h

-- 
2.34.1

