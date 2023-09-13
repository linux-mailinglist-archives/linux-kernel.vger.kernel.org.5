Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B62779E951
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 15:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234561AbjIMNc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 09:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjIMNc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 09:32:26 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2080.outbound.protection.outlook.com [40.107.8.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73CF19B1;
        Wed, 13 Sep 2023 06:32:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MS+MtThwPQ1d2Fa7c317avHwiFx8KMhFId1fFoMm8j42Jexgi1VSEt1M9g4pEmmPKVEifDSjjiwOCwPWLIoOr2lrQcQ3oJC3rcwuAMH2xhOnAEGbc6mLOqePrAk3TURQ5pWloHIaJXqZ+Ugw/vVWf8c8iZhSsSjfSof6rUEiW69tihnpuNBpdt69MvM/XDKhR6189TiRdzJwtCormO6moS9dadF2s4x5XQlFcVseZ2f1WEYIpbWC/IIba25ix1iKbgx7Vl8omqOBr2n/+mE6m1s4gvBd+UaWgKgo8yiwtEuQfvLWEDYQDmQ7/6PftiM+zvNP/EpKyFW96+o6DZMsCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5C6Nx/jjbKwh5gLGOGiID34Oli/r9fS50e0pApsFrA=;
 b=JUHSGv9zo3+ZuL7mnJXuWNNAMxWs7ZmEKMKeeuEddl3bZus75IK7yO2XOgjPFPd0DLvlgYMcygKLIgC/fWnyLgiaMncwbBzkU5waR0vYWj1O9JKll+sCjBWIXkjw+CDBMn6RaR61Pt0dWIahNl0zaKDZw6KZ4AGPDdIMNrp1/zxwv76Nxz3O1lXLWuqsQjWpgpO1nMbXdFITHQaTVnkcvbXDCKqaF4RU5e3j+2NTzyu+9e4YNC0AfMG0w1F4zKUD88UgfWs8YfWx5c5P65191iUhEMnkCHX4/U6OiJlhVFzTvQDV2Miik5Qpcz+SMI7ty4mKRILdaLy7CQhaPAj6hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5C6Nx/jjbKwh5gLGOGiID34Oli/r9fS50e0pApsFrA=;
 b=bGwHf0qH1Eh6vuJb+91rdZn6qKBH9A5RiXPP/K86nMRcHJo/obF0UvuCwqMEdZf0lAuU4wC6X2XeMG0TCmBYH7POfutgNbZ8YUIOPpdFs/rFhuoaCWEh0DjVEM9XiXnvMk/vWkV23DU6MFvu3RKTg9cCUx+ltpEygMgyXaOptE4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AM8PR04MB7235.eurprd04.prod.outlook.com (2603:10a6:20b:1d1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Wed, 13 Sep
 2023 13:32:18 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617%7]) with mapi id 15.20.6792.019; Wed, 13 Sep 2023
 13:32:18 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com, sd@queasysnail.net,
        sebastian.tobuschat@nxp.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [RFC net-next v4 0/7] Add MACsec support for TJA11XX C45 PHYs
Date:   Wed, 13 Sep 2023 16:31:58 +0300
Message-Id: <20230913133205.3749628-1-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: WA2P291CA0007.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::10) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|AM8PR04MB7235:EE_
X-MS-Office365-Filtering-Correlation-Id: 27c5cf95-4e1c-4e6b-b5b8-08dbb45dd9a9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ojWp3y6inkbMQz8VhtfOJnYzzBifVwBgoQl/3m9PgO1jxY0dUECX1kPf9/PwlMTqw/zhAs8SuOJdeLGJ8gAVgSKou2VPWDyVKGT3NSUZZXIVi4GXSCbSbxM0hQoyyqqLkvLaI2oUb/JpfG5ukn0ji0ydpAf4520dMa533jkfLJvnuIKGq6iBEA1FL4UONvDainGACZykC1PMO1Y6BTmEyKbhRe4Up9UtAyz2AfuDgC5WjT7woiVrRhYKmSW4LTmg98H3aNdkLRcNo83eMb8Zn33iCwMcykn38O+3WX+/Lsd0Hs9Tmk3Br98ndypp9d2ivomJ6p49Cr6gem8TjAbdoPqUkXa48KiRxj1clk05J8nw6oNjBx5AbAoGmIQmMDiPmNyxcTWwynhc3FN4JGRY/DHO7H6BJvz9xQNSuynSIkKQAv0DfjUTZP61/trcLFE7yjkySOwM37tPKuRiADGt/y1hxP9FD/DxDmq8gYegj543ZcpLHABUJL+tLPcHRayTdVIi1THe/7HCGTgnrhp5ET7EbMWCbM/vYEkz0f1I+qzwweReadPZl6pD8NJJ+5CdGQFGCLY0ys9QQR4UBZDBZkN8v9hCGRq2dMlGrZq7W+RO3CEgGowIdkcYxKrlZtUZefzaR0+bW8xaSPUzetSBVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(396003)(136003)(366004)(186009)(451199024)(1800799009)(26005)(4326008)(8936002)(8676002)(52116002)(6666004)(1076003)(38100700002)(921005)(2616005)(478600001)(83380400001)(5660300002)(66476007)(66556008)(66946007)(41300700001)(6506007)(6486002)(316002)(6512007)(7416002)(2906002)(86362001)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w0W9zyy+seWx0FQMb7eR48T04yXPdfqvem4wv0fjlus61rhvPCmkn+Wxwrwz?=
 =?us-ascii?Q?I9ZfN+CdXO0KF3NxWaMeYnwI1UR6uBQ8QxA6V8axlWgzoqU/7nNtArNbEuwV?=
 =?us-ascii?Q?6kr2dFBEEtjm8YBLCelRML0HHh4fDTpJojvY2sSy9VaJrLIRclkxXEEAaSIE?=
 =?us-ascii?Q?FrxqOabgltlYph/yI87yVvZLTBVKGiwWBr0++YTeXY8PFw1KJCZ8MnAS3Y93?=
 =?us-ascii?Q?FYw4QprQhusMQZrxXuhJ+GsM9/KBXWxCzFAAB0OlFDDnBt2nmFjwfiR8TeLv?=
 =?us-ascii?Q?mGCFgfd+RW/A3LzAj4GnduVzwDYUBKK8VnAExFzbBDoHmgz/fTtPBlQlYEq0?=
 =?us-ascii?Q?1+k1rtp3UsjjvtcJje0QYS277m01xh/BpMAmLLN8PU1HxPFuPhF0HWBpmScp?=
 =?us-ascii?Q?koKEe9Ts7BMqoovIUCNCgV3gzny+Ox8oX4BlFw+tOLkEa/XTg4r4MDboUhBO?=
 =?us-ascii?Q?5u0I6HONqet3TvPO7ssVOBaBamU6M6AjIvAmXKg4P///tHJVXScFnZXzWiKu?=
 =?us-ascii?Q?ATbZbc7Owy8O0c4D0omhf//uDE9y/rDynj91vhYXe+CpNjwn2uo8/9t/QGQv?=
 =?us-ascii?Q?fa2yVeCQG0uRLdI2DvluCm3lnmiTnfyBQAk0efFM6sDghZ0i6Q9UJ0jcDuue?=
 =?us-ascii?Q?xhyHsEaFG15QAob6D4R3KT3GfQ49YTH84szJpar8VB3wjGf9SvL+0kmSA4J4?=
 =?us-ascii?Q?spTbLsH7AZh8LQfIM1/vZLOpOElrncFkVHgwVElo89g7IE+jWHi5NXcUQAL+?=
 =?us-ascii?Q?Pb0nvUy20N6tuL1cyfiRUdyKU/UH0kkWi7/t6eqUZw5x2hRiNUNxkwpauym9?=
 =?us-ascii?Q?ZkMyJq86rE2lODJ1G4sKYA/d+x5zzVA4cdYNzFjsM6GNPTQ5BEPGxY5Rby6z?=
 =?us-ascii?Q?U6UUylZt2xJIoy31zVxsqeHaanORpfP+LR39XNLyMpckgaBGMO37cHQ541Oq?=
 =?us-ascii?Q?lRGrUCUt1lkWYUE4fncrhDU+u4C+xVUVCdERkF+3ALl9OWuGK1qaj5xXDWdW?=
 =?us-ascii?Q?CyBaBv7z0O+LmE8/Wb+KxZkmBrHBJRwL4YF/upDo6c5Ylk/Z1qq8AvaLAKew?=
 =?us-ascii?Q?eg/SKRfat002FPBNIEXjjJ0FL12qIfXPYTwS9mOHOigTOxrk3g1WRzyLGSHe?=
 =?us-ascii?Q?9ug1PFeTmAANlQySMwI5lN/rUaZQluEyiVUu5UrZ3UOp/F2JA8iE6CjX89Fr?=
 =?us-ascii?Q?9hJszxyRbdAp0CFrWphFzjOUgkGkuNeDHK55UEZe8j79q1UVbXOMse2z7Kf+?=
 =?us-ascii?Q?sHhE9SFSO9kM9qvWDKwxBVBfOI18J75x1OScKTOKjY5wntPjx78QF9fiYfOG?=
 =?us-ascii?Q?aR4LJnTxiNbMm9VgQAj+PCaD6xptIKJjcuencA3AaAHbUJPE6QGDIFzGQGF0?=
 =?us-ascii?Q?sAaB/h3rtYrVXGYCZCGCbEoIYdhUi7ljqo3+GZyxzX8nZoPSmLAYq121up9C?=
 =?us-ascii?Q?u1qfA/srZxKbFTKSedN0zJBXe9m4sNky1GWVlIp1p+B2WfpXMdd/MVthSrGN?=
 =?us-ascii?Q?fs2Unbiyy/Y01dqg8CXHkE8EfbK8aXnPSPe4iuYB9Z2QpgSfkm5vpG+RmH3h?=
 =?us-ascii?Q?bvVEPd07Qr0bWdKjYD3ya6cj1GmA26yAEpCEwvSwLjDypk+ehudg+PBUhAAc?=
 =?us-ascii?Q?nw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27c5cf95-4e1c-4e6b-b5b8-08dbb45dd9a9
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 13:32:18.2498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6PJpiatDfPxIS3ZDQ1w2arj4UQXmD8XSetKs6JtUFjzlOzHo8o3OuKywH3cuUQSmoCWRSIwzyMYML8o7wbA8PdpcJjrs52Q4pAeYe3D2Vwo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7235
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

Radu P.

Radu Pirea (NXP OSS) (7):
  net: macsec: move sci_to_cpu to macsec header
  net: macsec: documentation for macsec_context and macsec_ops
  net: macsec: indicate next pn update when offloading
  net: macsec: introduce mdo_insert_tx_tag
  net: phy: nxp-c45-tja11xx: add MACsec support
  net: phy: nxp-c45-tja11xx: add MACsec statistics
  net: phy: nxp-c45-tja11xx: implement mdo_insert_tx_tag

 MAINTAINERS                              |    2 +-
 drivers/net/macsec.c                     |   94 +-
 drivers/net/netdevsim/macsec.c           |    5 -
 drivers/net/phy/Kconfig                  |    2 +-
 drivers/net/phy/Makefile                 |    6 +-
 drivers/net/phy/nxp-c45-tja11xx-macsec.c | 1723 ++++++++++++++++++++++
 drivers/net/phy/nxp-c45-tja11xx.c        |   75 +-
 drivers/net/phy/nxp-c45-tja11xx.h        |   62 +
 include/net/macsec.h                     |   55 +
 9 files changed, 1986 insertions(+), 38 deletions(-)
 create mode 100644 drivers/net/phy/nxp-c45-tja11xx-macsec.c
 create mode 100644 drivers/net/phy/nxp-c45-tja11xx.h

-- 
2.34.1

