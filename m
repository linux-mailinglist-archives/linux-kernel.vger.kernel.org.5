Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA2A7875A0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 18:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242616AbjHXQkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 12:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242632AbjHXQj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 12:39:57 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2084.outbound.protection.outlook.com [40.107.241.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2566B1981;
        Thu, 24 Aug 2023 09:39:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m/0JKGc+YGncgJUzOMSDaIIF5oJ3JLU3CTE56n4zQYMSRWa/FStICmylGR37jlY01noyI8804dJ7LXNQbp6YEsz4l7Hq4EXwiS01YzDozOkT5bK+BXTQD9on2WYypph+PnokBPN6xcrusRox/m2OfZlSDTWks1WnC9Rq1uYERTWQhotOmge2Ct9lA8CODwH7d4E0XCOX5SYI/1yI8bbl5BD/kvc2xIA7/vR/JSelaCLUQH8EW79suC3YXwLDvGp6ZVDL992ifqf9OSAc2agjYtfdrvszhwjWOtTGRhYz22fGLiQV4n7OPsiwfR6fCoVnrfLSJYF5kJlGc569aEIFig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WdO29vcj4UUvd/mRUCuve8rhgnj3GkKsf4D2sgwQFkY=;
 b=gSujuZZZiy+UVGmMVzeWmU69CJT4ANVuhnJjgtcKZYwfTc/BG8R4ToZoQx7SL0LWsBtoiTvWDM8+W7EBmY634YfhMoGjzR8nLH35dlihz3JWwdFSyrbS+Pe4/yFQ02REAvN09ilC/x0pHXYtCU2yzJV26m/9kSmaF/rtsvDYk5ebN8H5I/DjKshrIz1XfgbHbxNs4Wscn8WdivC3PfwuYQSgNq5UAqPrL9ZuOwgT4tDahaWJ9VxIwNeH7326fBDoCw4YQt0DAShKmN5kVP7rXa0GEXR0JZ/yTbmkziIHFzRGmUt1wO9lbXdKLgRvKDWrwfIRLzVjLsCSxjNjxCw2PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WdO29vcj4UUvd/mRUCuve8rhgnj3GkKsf4D2sgwQFkY=;
 b=ZmFuchsmNiRwfdA75I2FZ3F9TGeyCk5The9SpTyodxabk2QsNsmPSS7gYVmHF5IJ3r9DqKYdrkn/cISx2VHP3WEvO5pLxWKjTPexvk9PiIfAuatGlDOMcSV7flvFtLBeFCuih76KyNZymdtNdREs6/T9N8XFjDgog7jAg7NFqOg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PA4PR04MB7517.eurprd04.prod.outlook.com (2603:10a6:102:e0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 16:39:51 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8%3]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 16:39:51 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     festevam@gmail.com
Cc:     Frank.Li@nxp.com, clin@suse.com, conor+dt@kernel.org,
        devicetree@vger.kernel.org, eagle.zhou@nxp.com,
        imx@lists.linux.dev, joy.zou@nxp.com, kernel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, pierre.gondois@arm.com,
        robh+dt@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org,
        shenwei.wang@nxp.com, sherry.sun@nxp.com
Subject: [PATCH v2 1/1] MAINTAINERS: Add entries for NXP(Freescale) eDMA drivers
Date:   Thu, 24 Aug 2023 12:39:19 -0400
Message-Id: <20230824163922.2952403-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824163922.2952403-1-Frank.Li@nxp.com>
References: <20230824163922.2952403-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0198.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::23) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PA4PR04MB7517:EE_
X-MS-Office365-Filtering-Correlation-Id: e20456bc-c0aa-48ea-b235-08dba4c0bce4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cAqb4lEe+3uxlPb4f0r155S8/ecjBwtOAKSiypmqlTE04E9SU+eKWaasaW+1D0lAg0sj1Otas9Qz8gYCMAfDEzMZlWH8jD7Xr4ONj7SdoIbv4di6PB1c7R3UyV42lk674tX7ox/phBocntER7qB65TTKdF5IeCgt2Geh58E6SPG/KBe89kIFDAdaHtmGdDWU6zK/9XbM96qrckM+EXPLOg6T5dxYerhb5RRd7MrdEb82iTJryi+kcBdixz0f6ZZK1DcfRulnb2qNJ4KcYQbNa/ilnVoU0zgQ13sAGZpQXwbajhbHRUjA8UADZLdX74H15nS0JmvqQbSolnQKN5PIM1wvriPd+gzZsTr9gbqXxfm+Lf0XJdLOlTwUYz193PPO+ES0D+GD/Hp0tHnl7VV/U2VM5udg3H45PyOZrjdEhMDRT4wDQ/1DAIQXyrI4Xx5sEjB6r8yZCpumSo7En5PW+YXwWhzwB3yp+qcT6qLyGel5rY9x7Qr4mdBWyXz+XSLuQ2tmxYYcZpq//tMlglOJmE+XuZ9GwjudvOWWQtZ5gMZYNAXMApXAxVbDS1fvJGkR5ZobXo4xi7shHNugkhZ6P5ouLVJTljhNpAFEIeBvFxtJcJqVTjTHCutv8nVtktpB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(396003)(136003)(346002)(186009)(1800799009)(451199024)(1076003)(2616005)(5660300002)(4326008)(8676002)(8936002)(36756003)(4744005)(83380400001)(7416002)(26005)(38350700002)(6666004)(38100700002)(66556008)(66946007)(66476007)(6916009)(316002)(478600001)(41300700001)(6512007)(6506007)(2906002)(86362001)(52116002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fDC1w0u/KRCsJTYHmG5z6xf135OmiNpiin8sBRPi7xLx3D5a3IOJlkqJyrCg?=
 =?us-ascii?Q?8/g4p/3qvy3zEHdEQnttgV0CtPjrD4i+4Rk/Pjo2q01K6ZvlmICFpeBo8k3b?=
 =?us-ascii?Q?GmvII5TF3PwcpAauWX3VjGv8qaJdMqwjhXpjWshjHJKicED+BvX+pmkaVr13?=
 =?us-ascii?Q?KqD2GolbZHYbvUjKRJV5K7Ae+G521rnE7YnN8nDtbyAgpdtIKQo3r3YdjnlV?=
 =?us-ascii?Q?wm9pG36PQArcNT3KPu7A6nZeaYYJsfV1rTRQvoztRslp9wBlDQCu1C5VgzPE?=
 =?us-ascii?Q?zSU0sR+i+abZ5XO70mOAKG3zG+3Fk6+w/9gjrK2zUgZtByoQSCgB7CA2nSYK?=
 =?us-ascii?Q?H1qRKspUTZ0wu2v0a4XtYFrbut6kPTWOmgD2OJuHCoQgWGuez0sH7whAWww/?=
 =?us-ascii?Q?VfqfGzrBbRSGPckCjtkhfXi+DM6I60v1Df9Gchd2mvrgmQKFJSLiiLzfSOKM?=
 =?us-ascii?Q?nELmTVawqhjrXKKElzIlY7J9lLbQ+/ChG0ncJ4h5YXDmY3Pol8oC7OBu0Z5l?=
 =?us-ascii?Q?WQ+/j+ZPUQqgJmRFApoVzw+E6iSjBqbdaVsK1cTwLOP5m85WM9cFWhIKxeWo?=
 =?us-ascii?Q?Zd6hDIAqpvUEsoDs7hbAy6M9lx4rK1juI8T2AZbbp2MJHOwudizvR/AyF03f?=
 =?us-ascii?Q?PNgYwq0czItlmuPw+vOAcDQAc7xKUukFNkZUPWaOS8cu8CMJwgshBVYO9NxQ?=
 =?us-ascii?Q?+ggo2Cb+oo/5pEwOzGC1HOZykpWMdRI+EymlYoID5gHK720n8egGz+afcfXl?=
 =?us-ascii?Q?CbILujTyhLJdFDy0JZII/bjT2o024ESHthYMvDO1hlv5mGcK4NaxYUOJ0eor?=
 =?us-ascii?Q?ccR0FhkCpScr6s28dh6qiVpr57CVWeEdhYxLE+O/ZiSH23nBNw3P5LESQz/1?=
 =?us-ascii?Q?BnjuviYddZ6i0qdpS6yk57CeUHLvYLELfeiAH7yG41/T5pnvpw42zC55YpKm?=
 =?us-ascii?Q?MB9/ruCc0C0PGgICDkcW7o3cJvYZBAZ26OVYmk1OO3ktHPHPBOl2ezb87gHC?=
 =?us-ascii?Q?P4h9i/ZnDN5WG5mH+lFidlcFy5wmM9aW35zan8xrz6TQmt239Zx5QlNfZh1o?=
 =?us-ascii?Q?xLmWgLVd3hPQFUDbmtZ6/tFgvTl0BM37djOPF9i2BxmO5dW/iWPukPUmiF5Y?=
 =?us-ascii?Q?UQEOYiy1iXG17etpxm8/YuaJT6PfgE1p+EZiIk78qsPQo6F+FHgLSNQ8umRW?=
 =?us-ascii?Q?nS6ihdZBgJLCjoOyU0RqlAWll6KLLFzTnDV7YibByjnX2fAM7QkTmo+oXMBi?=
 =?us-ascii?Q?xzi1LESYpbBPl+aw1+IvgykYhzYuBeiDX6MYTwMxF8d8VlWu8JXh+muoM8Dp?=
 =?us-ascii?Q?/sWhu572ObySD1nHsZ4doFB078372zG98DaO2ULApT8kemhv5gBc961xFXu/?=
 =?us-ascii?Q?ItYchHDub4LMIfjPs4XQ8Z+Y6SgJ2T802jzTOswytUnUJFiwbXoP1lS60iRG?=
 =?us-ascii?Q?eufC8M9/6hT6POb7IOD19KHLEe+OkckrSe7ewm4Qyk2qkK4LiVKR6hE6KYqs?=
 =?us-ascii?Q?1tgiHxic3L1Pmxybq8g/2QIrT/DwaI64jNxmSLpDJYi019MeOZ6uzOlmhP19?=
 =?us-ascii?Q?+FK8KcQMUrU3zogQZe/gycGdiIXoORki1cT1mCtQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e20456bc-c0aa-48ea-b235-08dba4c0bce4
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 16:39:51.5845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A+k61ufzhxUKNqxP85lWTK3LXGxCDWltc07qU+ayirF09HMTb0xrIgMK4uRrecDPPL0VH2Iy0Lq3Ov+ouAg4WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7517
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the MAINTAINERS entries for NXP(Freescale) eDMA drivers

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v1 to v2
    - alphabetical order

 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 23eafda02056..fbab3c404eb9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8215,6 +8215,14 @@ S:	Maintained
 F:	drivers/mmc/host/sdhci-esdhc-mcf.c
 F:	include/linux/platform_data/mmc-esdhc-mcf.h
 
+FREESCALE eDMA DRIVER
+M:	Frank Li <Frank.Li@nxp.com>
+L:	imx@lists.linux.dev
+L:	dmaengine@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/dma/fsl,edma.yaml
+F:	drivers/dma/fsl-edma*.*
+
 FREESCALE DIU FRAMEBUFFER DRIVER
 M:	Timur Tabi <timur@kernel.org>
 L:	linux-fbdev@vger.kernel.org
-- 
2.34.1

