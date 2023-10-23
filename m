Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8087D2EC0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjJWJoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbjJWJnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:43:53 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2073.outbound.protection.outlook.com [40.107.6.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAF9D71;
        Mon, 23 Oct 2023 02:43:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EbMoXXWiB36o5B8HCXREj60Cp/2H2Oez+fj82LlLJvF7sFGp3tAjAyRq9uqKHQF95l0rg1XxS0xv99uUDQs83HtY1WqOld6zIZOTuM1+yicFCO0DlbLeBhaUu2zJPRxSJDQS4ELWVnTOWRbhuBQt28FlHcutEmY+ZnoCjGaJqhx/frGrPxUFdokYd5inBgMuEafV+QVlsqNeH54tqdzlo9SmqGlmNpQMBQZfTOk/kePxFR1zfs2+RAHMEUipQa7m+ZODnzC8rRiTJA/xNmsnXGtlYrVpkKBm5gEVs+zky8LlcFaj3pPCtMg4OXNt3bCN6wgSKVSvRwQYRyEtnAwuyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x5iOtSKH2MAw9ZhqeiV83lh2GmFIQD8PcWmZLhbUGJQ=;
 b=ePw67QWDr1IlPwUt5J40INpZkEvB23gtvw97QX5NeHqnFpcTeYi8FB09GpuAoZHmf33HalmNo5QZaHaYhu7VguW1NUlOkcW81YgPSDCAWJ+Ba9YRkaw+UWLc3qAuptxTJSjMBqFURR06SLmv1v++FdukX4M0z58Q+RtNBsYwLqo6elya64kcLjC/Z85mdENlTW7NttMlBhu74bS+NK3FXz1Q3QNmzV/FdwF/GR8eMUfL++wtlbWv7j0GeUbENrcotyunLlhFzL1gQ6NF1dKqoN6pvYcqYLkg4jTlBUkgkMZKHjo1Yb3QiYwoJM2pBlizZno7sLCz6KCianTOC+ywAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x5iOtSKH2MAw9ZhqeiV83lh2GmFIQD8PcWmZLhbUGJQ=;
 b=i88AGMTmLEUM9NrkwkaoA9l1L5++bwezp+gxPpS9xd0kTO8tfA9XWFVer+Gwal1C8JX0FWEOVfbg0TDtMadz8mbA7EK6o2CY1A3C0fFrF2daQRfpKoA6CNOuf/xnDqLSNEEfTUSZliDGt6Ogyq1vrUwsRtgkZmFr7kWi5AZ4/UM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AM8PR04MB8018.eurprd04.prod.outlook.com (2603:10a6:20b:236::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.11; Mon, 23 Oct
 2023 09:43:47 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::b1fa:fd23:8cc2:f5ee]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::b1fa:fd23:8cc2:f5ee%6]) with mapi id 15.20.6933.011; Mon, 23 Oct 2023
 09:43:47 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     sd@queasysnail.net, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch,
        hkallweit1@gmail.com, linux@armlinux.org.uk,
        richardcochran@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        sebastian.tobuschat@oss.nxp.com,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH net-next v8 0/7] Add MACsec support for TJA11XX C45 PHYs
Date:   Mon, 23 Oct 2023 12:43:20 +0300
Message-Id: <20231023094327.565297-1-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0079.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::32) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|AM8PR04MB8018:EE_
X-MS-Office365-Filtering-Correlation-Id: 74363da9-4054-4639-3f4f-08dbd3ac8db6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qsw0daDgW+6cIwFGw2ziFXp+/N+9LqfhesWdD+FADSm7+YwbaeQ7kQSTjDx+8VMOYc6cBbBLsEdXWaVUW3F5OKUmdk9Uqk/0bjwE04Mo/fIB8OiFjIsHyvaNPhil2G/86H5+uT06lvwmqxQpKoaJU6qPE/qLU7r7iGr1/yaslMNwSf3uqjSSdDfPIgNehaJQ8G2z/TAAxytQipmS9OAblPkeoHbMe4bS+W/VWMqDBWykE5wUi8griFByz4Mnag7scN8KVpYCVOVdNzedreT1LtdjoxYu4p5kXVn5d/cd3UfAlqcjSo5mAp55JMyiqL+/1HB4QkHGPYqO5VM2BRHI0BHiPwBrxJusUiAI0PU6Air2bQS1t2MNgSoutMMZLE7o4lw0lMvVkTCifXVVWfCcDW5fud4yFL6N4EbrI0oNTMKjH+8hnshyv2W/xRCXL+j+eaJVnklzdU5v4j1oe5+UuK1E6PF5a6GIt4l7TtwnXwdHwOjDTYdV/WoAW+PKnigYLq9z4ba46UztjkUiajyLwca60gLZsSlmDremO5VFf6Kmb6zCLKbCwO65P1uw7+8gnG10+C4gGa/gL77OlpxJiATpJFV5eiKyRfbW3JrwolUrlD/5D7yCovriZyov8zWV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(136003)(396003)(366004)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(2616005)(7416002)(2906002)(26005)(1076003)(38350700005)(83380400001)(41300700001)(6486002)(478600001)(8676002)(38100700002)(52116002)(4326008)(5660300002)(8936002)(6506007)(6512007)(6666004)(316002)(86362001)(66476007)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IHivM/WmLtgNUBDGPx0wzzjxeV4kPlS0e4k9N1yCD+TbHuCwrXtoxjAaM0HR?=
 =?us-ascii?Q?SJ/geWDh5UDEk+ykdkzGqssFJdqPg13Z8pDpqUYUE/B6pQQVl4P0fG+9ZIDm?=
 =?us-ascii?Q?pO1Vy6Nyx65n/VFmhDLgWnmMf8IIWKysqBwz67skdVC1zrd3kdKO9J0Z8lXj?=
 =?us-ascii?Q?1DIjBREgZObFxfmaSFflNpz3QmeS/p/5scPmhOO7rBYdvoRs5HZ1yJDYgUwi?=
 =?us-ascii?Q?f1TtZjV0pY87ollf5A53jP6cVES6N+4syG2vAqci6k3WxNJCL6OJTEnzg75g?=
 =?us-ascii?Q?wKERJ2O2oBiOCupOP1OGchrEsw1aCmabUyHlmlGHB2uVe6TT6QTT8ZMaHjxo?=
 =?us-ascii?Q?s74qn4OpQid5FemYezoKFHkwaSqEAESiUQMSezaiemMWSTf8tRsSFu9lwby+?=
 =?us-ascii?Q?eUy5qKOpuWUDpAArzE3fTu8Ey97KUw70DCS1mdJxOcneSPI5xxQemhjLFjHw?=
 =?us-ascii?Q?Hak7fTDk8DngBdZABDNNkq2No4shuJJhWMoQQeb6+I9xLqVo6pq3ka4lLaee?=
 =?us-ascii?Q?GkOUo/dWp0Y+UAqDdr9PODZr7pgsnpZ6/Md7dZVSSEy9TCkxqOfpeiXz2wrD?=
 =?us-ascii?Q?iasjRz8Zh4l+cX3RPyjLjKQILMhLFWbIYFBdIpEvu5aHpXeaun0DiGMy/r9m?=
 =?us-ascii?Q?ofs2zHs6HP2OTEE/EQZr4cL4MrFkZO3oEGpy3kqLLAQS5pP/V0pxWPtxCbtK?=
 =?us-ascii?Q?iTb9PwElVvmO1kZZL1QHvxgJRpplnAxOSTFX4n+dGqtOAlN2foDCVIg32Eqg?=
 =?us-ascii?Q?Z74Vope38uyvhCBfTXAzjF/o5w58oRKUmrlZ0A8pr2309yEI7FD3cnEQEufy?=
 =?us-ascii?Q?DtgPNpfiejgHfZ368eGsIqftE2aNsnfXbLyw8++Bou2WfKuQwkuB7NH4U+k+?=
 =?us-ascii?Q?3PXdw6HckaY3Fk/v55s2/qK/p45tv+IDHcA+sy3EqZFTstA9avA+5P6dktRi?=
 =?us-ascii?Q?WVXUOwZ2CfiaVyRFcB0V2pgRZpoVkv/LeNTxP6pyz5I6lPnN3eUHReWOZVWz?=
 =?us-ascii?Q?Dxs71uSWVbnY820G5xjJClf9BUKZD7qEEd4xW0swz9i7cWUtM5YDzl7cTN94?=
 =?us-ascii?Q?2Jp3RDtucIfFuvCJGeEh6cSSDHZSnE02ZmLi3nY7bHBv6zFRHdEpvO/VeVS6?=
 =?us-ascii?Q?fZPI6U6H5jh/vO2Yc7/pQvMeAAszunaU/L2Mf1CvGNnbAE6neBQO0pcaYLI+?=
 =?us-ascii?Q?69D1CsPjSsFw4fqfzcI0a5J+kyrXAmypV9q3cGuA/ZGKS5NyZ86HzVpQQBH3?=
 =?us-ascii?Q?pOHMUEooNH2xH7gzBmdZdrXjkFoXXy3Z3evZnDcwW0CsFbs9Fh5k6cHpQUoV?=
 =?us-ascii?Q?OHCp/OfBu2hO1jgpOTJybtd4KcgdZegHNKhOjvDChnbtI8Plyf6oULgXK8rn?=
 =?us-ascii?Q?qfyhm8HGrfU7ZST0dYUcSuXbtEUYD6G7rZ+IOq+DIPSA6nqsqniYwZQ/OnCX?=
 =?us-ascii?Q?VjlmTBHtA6ZSAJm/fVDKHIEh0Veono3DH3tJQ+OrLdkuqerJxKHQI4yqKcL0?=
 =?us-ascii?Q?80lF1+q1R/pdSZU4TqaQyb/JZ9OQcN03CjSvJflcdIKqH3RX9u4VaTUcGDuo?=
 =?us-ascii?Q?Q1JZUucsOIaU6mNQmJjO9wA7h7b0tGmeD7hrMWBAlozSCmZzjSJPg50mrS2C?=
 =?us-ascii?Q?Nw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74363da9-4054-4639-3f4f-08dbd3ac8db6
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 09:43:47.1811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eukN0qw1m0Vjzddy9okFBxDV6rb98/QTqRtzuL8aQWNN5E0O9/Z3BAI3u6xbnIZuMWuzZW804wRzXI8XBa3sF4jLJm+LhEDKacGSzU1KtN0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8018
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Radu P.

Radu Pirea (NXP OSS) (7):
  net: macsec: move sci_to_cpu to macsec header
  net: macsec: documentation for macsec_context and macsec_ops
  net: macsec: revert the MAC address if mdo_upd_secy fails
  net: macsec: introduce mdo_insert_tx_tag
  net: phy: nxp-c45-tja11xx: add MACsec support
  net: phy: nxp-c45-tja11xx: add MACsec statistics
  net: phy: nxp-c45-tja11xx: implement mdo_insert_tx_tag

 MAINTAINERS                              |    2 +-
 drivers/net/macsec.c                     |  130 +-
 drivers/net/netdevsim/macsec.c           |    5 -
 drivers/net/phy/Kconfig                  |    2 +-
 drivers/net/phy/Makefile                 |    6 +-
 drivers/net/phy/nxp-c45-tja11xx-macsec.c | 1724 ++++++++++++++++++++++
 drivers/net/phy/nxp-c45-tja11xx.c        |   77 +-
 drivers/net/phy/nxp-c45-tja11xx.h        |   62 +
 include/net/macsec.h                     |   54 +
 9 files changed, 2011 insertions(+), 51 deletions(-)
 create mode 100644 drivers/net/phy/nxp-c45-tja11xx-macsec.c
 create mode 100644 drivers/net/phy/nxp-c45-tja11xx.h

-- 
2.34.1

