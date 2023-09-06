Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6F0794103
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 18:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242862AbjIFQCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 12:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242861AbjIFQCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 12:02:42 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2040.outbound.protection.outlook.com [40.107.13.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A8A1982;
        Wed,  6 Sep 2023 09:02:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YfbS8F6u59w9aUsOJAsmbIi4vS5OJlIG0q2HxPPW/zIsfQROKeLeHIR7snvMurV2wKAypzTdq/tRhFN6+dFAJ6cLPzePyltqAHNyYqaPMFjtGSWZ3iB7nefuJB7fMizRHOVyiT9hJUPgb1e148lGxKVJm9Cu1agFXspvBgHHomYWneFpHe8WgxGt3z272+yVF2JAGPAgZFpl2bRTDgApsGgYGlYUDPQh8QCUtyjpPdgRjbLP1B4dOipzvFqE6FhduOlpJgQe80LlPrB5vIgLPHypysQ8oorBpfObm+sD+WolqP5ssRQySc9ivwjohVSRFYg/tT5+aYgu6vr3h+MGdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tugcOGiyu2JHRWXElrYNxD8S6E5AiyZdam0xSehR4vw=;
 b=m3SjALY5TvwY+Y3d3hpOOW+JCtrqp12Pu7/t5oXVC4DKIzvjNmFlFRJoZdWLvN+Uci1mRVIaLyPszIkElJ5pvEN1X3pC39vTQA8JNYv5g9r529r4v3XNbTSTJEw14PYnyenP80y94hqCFPgffSLAlJcTv87oTMuZR9otISYQ/JskuwI+dAOp5RkNrS1rzpSHc+sDYld//V43ZPsrTrFc/7khQfaGslzNT3p/UM/V/szMEAxayGPhWCA0o2UBefETxU0AFJuTGzHxp0ljzW9jS0Miy0acvHsA+dmNSqI8+gWef1/leiVHdK/8u+QhTfdROTl7mnL5l+9YIaO1CDRkiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tugcOGiyu2JHRWXElrYNxD8S6E5AiyZdam0xSehR4vw=;
 b=PaoMJ4l/omkIXan7IvvyoWTH4QnTm+uwbCvKRzk5xTm+ngVMDe+mDVm9IYL7MjrDgN5Rfoh9/0myQXMJRv48RkXKFtneMx4Sdk/k73dtKF9+p2K62ql4XDy1grMw+Xt6j1w/cwZNQrt8CScMpxON6YVuUJ79GTsIlzfZiUmf1sE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8958.eurprd04.prod.outlook.com (2603:10a6:102:20d::11)
 by AS1PR04MB9429.eurprd04.prod.outlook.com (2603:10a6:20b:4db::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 16:02:28 +0000
Received: from PAXPR04MB8958.eurprd04.prod.outlook.com
 ([fe80::d7c:390a:4105:65ee]) by PAXPR04MB8958.eurprd04.prod.outlook.com
 ([fe80::d7c:390a:4105:65ee%6]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 16:02:26 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com, sd@queasysnail.net,
        sebastian.tobuschat@nxp.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [RFC net-next v3 0/6] Add MACsec support for TJA11XX C45 PHYs
Date:   Wed,  6 Sep 2023 19:01:28 +0300
Message-Id: <20230906160134.311993-1-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0007.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::17) To PAXPR04MB8958.eurprd04.prod.outlook.com
 (2603:10a6:102:20d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8958:EE_|AS1PR04MB9429:EE_
X-MS-Office365-Filtering-Correlation-Id: 05fa4c7f-06d4-4446-d56e-08dbaef2a9e4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rbUVRvLCQRgvWjETcHLm/oEFi5QtSHezt/4y63NRR+v5qAX2jn1nMajSWf6IZNQgieP7FUF0L1z0nCjAkHm0Cw/OZBj/9GhYGaaGdBcgiR0hKqpCW2ne2q7SNa+uWGpSGBFvx5+Mv4aEHEF9Mgcnk3uun5oi3nX6sTOmi9Xde0oNmX1ka0Sq1d6X7WDsKZrGFBgdaIDiaqHshR52NJ6E7x+ZVuoFC41OAz9Caq/MYZKbMzictofHVox3UcUirKHszrv8scIwv7Wv7imBdGxx3LzJZUBx0T4kaPNbirEntp0AQSeCoWV6W70VZpr9T5rFPidv9wjL9x8ZFTiawyxeXaoagtONeEus+jdQNc1SXkWC0dlhXFJJHdZHPynz2jT6PFJ5qQtJsjoQPPs8pAvRoBkQY4n8Wb+6dbwmcgonzPCwrUgr6rZ3S9eXn/sH0DbsCCEYhvA76LYb6rFg21/01rMz1nP9U7Q/ULnsgiGAO2IXWnIzWtt8x6BfjHonXTu+O1uqAD5wOGyNLA3NkEYKApIIcV4jup3zs1bYN8Bn/qQ/JQ0qWeNuRyRXgDHwJ7d+chyP8nR0uHPJTpT0HVcffbmLwDe/O/Xmtq4zTp+KO55RQ1PXcpmhsvP1lw5y9eBQ6ahZpJsetuTw/AAmRujI8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8958.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(346002)(39860400002)(136003)(186009)(1800799009)(451199024)(41300700001)(7416002)(921005)(38350700002)(86362001)(2616005)(478600001)(83380400001)(26005)(6512007)(1076003)(6486002)(6506007)(52116002)(38100700002)(66476007)(66556008)(66946007)(316002)(2906002)(8936002)(5660300002)(4326008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3q7rPDbbQ7O51zdZCXNfAItmvaPFJ0qmcYR5aZNRzmcU2JQer979oHO9Kztb?=
 =?us-ascii?Q?mhqIfYHbh5SBaRjewbch6PfAxTxLfmh/BgXw+hhJpAjBW9hlTLEaNBWDiqhL?=
 =?us-ascii?Q?toiahyV5nT1kGoTjVVAgCtW4BGtkhcY0+JlkN0mBA6pezfhrAwVCE0JwyNJN?=
 =?us-ascii?Q?RwU0SiZ8Yl+5IqKIRGs+ykzStHTM2dc5MRRaFXOCBt2kM0EDbyu5G4IydWio?=
 =?us-ascii?Q?IA+Use10U0KEPuK7BF1J84T7Ek+jEc4WHB2M+2wOJ9g5pqq94xrru38+ct4r?=
 =?us-ascii?Q?3dWQcdODCr+p7JZ5NIZhHWv+8t151/OvEvymBRVwzK7ixSAUfSdISAGX9k5N?=
 =?us-ascii?Q?crlOeSYYZwMV1LB0gYGDPrydQ43ocAfoVrpN4sYqB+wb5/2WF+zklUww36mp?=
 =?us-ascii?Q?/T2r7Kb4XtrOBvqqwq0gvm3GQAwssE0hs4AqAVfoISfJZF1olCGb+Y7hKAfq?=
 =?us-ascii?Q?gbC+OJ0z5J677szr2KDk5t7gO+WuUf30GqtmgNkNERcrigsnIJ7sx4UVD4H7?=
 =?us-ascii?Q?mofYBPBv+lW9NvuZU1wBc80nzCPWa9D9UGPqrfH9Ic019/ec/hEZMnWGWsWc?=
 =?us-ascii?Q?B54K9R16258bd1T0XhOLTvI0f9DXi5Uuy0i2e3TAmxHqXcd90y8FtR0eo7y3?=
 =?us-ascii?Q?8V99NlzaHn0YQQWX7QqY0X09v8bniYuGAJrc8mnVUWCn+psVr1q/qegeILt2?=
 =?us-ascii?Q?3rD4A++FwUcDILrlwrXrF76YrivR/B+QGQYB40+f17P9e/StMhdTzJe9Lbhm?=
 =?us-ascii?Q?j6ctY74BzHt3XNFumEZLHbxR7J02k8wY3ilOuVd1yF0FCO5j38F8R8ecv/zc?=
 =?us-ascii?Q?Vur76UHrZkYu+wSQ4uh0WKjBUYwwcdjyhGg/CesENkIxI2sJHKwR9dPLbFw9?=
 =?us-ascii?Q?mVPxOPCuHjA7wYkQtMwqBNDf4QuNxGkBruC7sRsFOwMoXJKS0L6QuRuUxJ0L?=
 =?us-ascii?Q?Nf0dV8hAEpC2RWUfxZ1XJI48PESTyRLBxtooHALQvMKYZxqdGxoJlkgVjwCL?=
 =?us-ascii?Q?oks0/pepQVwSuNN6v7qtKNUO5unsqBvUofVG9zbxohh5xzirTyL0cOLPerXS?=
 =?us-ascii?Q?WmWOpDWVMW3Qwfy7wJj5HwhOZ59VyFwsctOL2FC7NWCSDsljOqQ6PoXp8mTY?=
 =?us-ascii?Q?RasK43cW/0qWQi0DNP7qFYmoxVfQ3R2EgjiUW1ybnwNvApJXSSNkd6+Dbqrr?=
 =?us-ascii?Q?itHeRNXI1ABYguM7rXd7X3ZGLPp1WP6EbhTOBQZ60xKPIJHq7JgXlL0y8Gu2?=
 =?us-ascii?Q?cFcyESu0bhTt1pgjeZRWJCQrq4lCUBiReKxJqUocBLGHgV/O0UdZvuCJtOeS?=
 =?us-ascii?Q?qj8dVNzmbSUCR0cYBAcRrTl+/YwYZBSs2sxIEHwUhvextyk3g+SQBtc6SI6+?=
 =?us-ascii?Q?bezMpE32IvgVJV6ExBPfO+z9ASs2lI8dIkXmf+a5ygoc80NRf6DZiXEhl7et?=
 =?us-ascii?Q?r8NPXmNHMSosa5xeH33XhUSCnmuaPcI3bAfj81Bx/Mc/BMfzmBXFBnQv4lzH?=
 =?us-ascii?Q?0m7zFO9v1otlPMlHNoUHb4pwttS3Dp9JOX1/hTez63c6xWD5yp9G8FjhZv4y?=
 =?us-ascii?Q?HvUKGvwVD3fdMojgQWQ7XX7wntJpSoO7SUbgO67whaCzHLOz2XnNavwokL2X?=
 =?us-ascii?Q?Tw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05fa4c7f-06d4-4446-d56e-08dbaef2a9e4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8958.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 16:02:26.6990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q5vzp+Z7FOBbeFif6WVNTJubN6JBlQeCMWxlQhDCX061ZMeN66jLS/fWdZZu0r9aOD/6oTDNuge8/KXk1/S0vPseA/a+4N3+C3PsHPANyDk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9429
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

Radu Pirea (NXP OSS) (6):
  net: macsec: move sci_to_cpu to macsec header
  net: macsec: documentation for macsec_context and macsec_ops
  net: macsec: introduce mdo_insert_tx_tag
  net: phy: nxp-c45-tja11xx: add MACsec support
  net: phy: nxp-c45-tja11xx: add MACsec statistics
  net: phy: nxp-c45-tja11xx: implement mdo_insert_tx_tag

 MAINTAINERS                              |    2 +-
 drivers/net/macsec.c                     |   92 +-
 drivers/net/netdevsim/macsec.c           |    5 -
 drivers/net/phy/Kconfig                  |    2 +-
 drivers/net/phy/Makefile                 |    6 +-
 drivers/net/phy/nxp-c45-tja11xx-macsec.c | 1716 ++++++++++++++++++++++
 drivers/net/phy/nxp-c45-tja11xx.c        |   74 +-
 drivers/net/phy/nxp-c45-tja11xx.h        |   56 +
 include/net/macsec.h                     |   53 +
 9 files changed, 1968 insertions(+), 38 deletions(-)
 create mode 100644 drivers/net/phy/nxp-c45-tja11xx-macsec.c
 create mode 100644 drivers/net/phy/nxp-c45-tja11xx.h

-- 
2.34.1

