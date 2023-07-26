Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D5D76352F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234106AbjGZLio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 07:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234095AbjGZLij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:38:39 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2126.outbound.protection.outlook.com [40.107.215.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247221FF2;
        Wed, 26 Jul 2023 04:38:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dnYOuK8ua0t+b/eEK8yRf4ErJrB4n1aDpZpwNRToQGYIn4JvNbGSwrfrIhKfMHA3pJVFpOvL/nmiPNNtAaJCQn0dhQcbzdrVv6dqpu3R/1t9OxBBEEPWioKXCDSpbGoxB2+GhiIvqiOniRatc/cbnZfN3HUwM8L3ijI78Ra/REVWPOSZj2ekpYmZVP4deecqvTHxy2qw+tQO8qeDdvCoVPoDWEFZel3rYrh7IkDFxF5b13WTrBgbuUFyJA/omJaQzFKfcRTjGj6KoEFVJ95Xg6Kf/UiZFbfoPtzYbvcSASEvOGCdjUzGCK9Lwrg99WNLlB94ibf8tMaqRMWN9r7Ufg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v8Fj0MzjfsMbtub1RbMTfz8JPuqXLQhflYxBP5U5nG4=;
 b=SVHLGzNALHOjfxjQ+fTdqmblOHsg/emUObmXm2OCpFBIH9HdlaG5Joue1p6skUHl4BvOjWTKOy8IxgvzgUJCbf1nMgiL/004MNvKsriCpOlvtG8j74ZdesJN1WwGMAH3LwFQykOVNMpez3tBJW97dG6MqIib3o2N/Li2QiGcOSlze2PUDSPvKgDgV2g0L6Wzt0vDywryB3F2Sof9J8Eu/pXTjsmNoDGE31x6yIsO3w1HZuNCd8QZej8adFYNAWiR3AHrnoglQfE/u9bVPuAAa0cQfr/dt94R95yv3WBFxFPr1LUmANdqJQGNfEZKsMVdm/QecWzxUNxZVJER0bZKkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v8Fj0MzjfsMbtub1RbMTfz8JPuqXLQhflYxBP5U5nG4=;
 b=J6mbOaaIQXyb1uFLB649W8s/RpRb2aeCTQzyvTlBdrnkSj8JzfwAGDRBlDe8cIaODaSSscPuLbNgw15c0mfb70bpfPHUjrtmUl2ghuUT0FZp7QeZrXuG1qmlZvMWkD2Nyz28hB5QcAvlByySCY9gcwyHyf1ILwt9s4Yrqik51D38uu+PIQLMJl3f45Ra9O6aJh7QqGqBw8cX0t3ROOXdFI8pHnZr6T5yw18N7DyxHrbP6ULH2Xp959yoeqVpzbnVCrCVdVHlscZ6pG8hjyy65jbtDOpNrgiy9PnFqxcyz2Z5TrlUaPwwqfq0Bg2PZwXjfIr6i1y6NnpgRbsNfu53MQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR06MB6210.apcprd06.prod.outlook.com (2603:1096:820:d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Wed, 26 Jul
 2023 11:38:29 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 11:38:29 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/30] usb: chipidea/core: Use devm_platform_get_and_ioremap_resource()
Date:   Wed, 26 Jul 2023 19:37:48 +0800
Message-Id: <20230726113816.888-2-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230726113816.888-1-frank.li@vivo.com>
References: <20230726113816.888-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0033.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::21) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR06MB6210:EE_
X-MS-Office365-Filtering-Correlation-Id: 67fcbc28-697c-4477-cb38-08db8dccd488
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7d4qzhgVWM4afZqVMlK14LpJewRFNi2BbmMO2tnupP86daDK1k2TE2kV+sysygagJsjlHU9pMsjtyHHc5KeWUrUupGgif6EI3X6Qx0UPMIuFtE0qjRYt2j/ZsAyy9VNUpc/CwCbmzzFy/BQ2MDycM8Xr18DvnrkIuhf1R02j5GPA03R/Tg1OGaimM1JBDOhYoRF9V7kR8R33WctPjA5liR++R6bb9VlsNpEuc8YmzAftStV1zZw1IDAehCBrcL5+OxY97D6ojyube3+rtmTmPaaQyNlzCAAvPKWBof2XQwPKQHqIO1gb6wDRuFKrE/h3Gr4gQwz3XGRbQ68S2SVrW2np9TSQUvrGWkc25S++oMixff/Y3DBF3PKF3zqnvYBUaW2hmWNFYTiNczK3QH/mTso+GH7WZZF2gs9+Se8XEERi6z+52A0+kSYJ1F4yPHW9it8fIpJobpNOQl3Obj33aP8+Ryq75LQWiBj9QT5Oz/aNosPfO5rfRHr7Ww8RNp/AxT2nmPmrAvaTH2Kd+5XQfFKbD/WQhEWsznzC7IfrqB7FMCdxskojCgWlWVlrUx+rrw4uRDgPAAl8H95SIdt44U+qOWvEV09HvPZJ+oYTCbDUBR+wtxfF4vA2iM0QMqER
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(376002)(136003)(39860400002)(451199021)(6506007)(8676002)(5660300002)(8936002)(41300700001)(316002)(4744005)(478600001)(52116002)(110136005)(2906002)(6666004)(6486002)(186003)(1076003)(6512007)(26005)(2616005)(66556008)(4326008)(66476007)(66946007)(38100700002)(83380400001)(38350700002)(36756003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m5GD/E6Skw6IaxjEg0owlnjDte+fQTkKe79Tj3rOrJORGxKRuV1Vk8NFjAcN?=
 =?us-ascii?Q?g/4AjVPCQQFx5WNAu+zKzRJegJChrPB0W8YCTN/m41YmIwQSrCNGRR6lv8Cc?=
 =?us-ascii?Q?RfZHPy0AiJ75rogAp5Mb6JpjeHy+RpkzM/eqcdS5pS3wBtwmDzoWc15edQuI?=
 =?us-ascii?Q?Ir1psjosBmTdq5fyIDssoxYAn0zj+xAUmCO6Uwa2Hp5SDlw5KLA6KYKwNAS+?=
 =?us-ascii?Q?Ujj6rgaQY9hfjYRHrFUyMKc3B4HFuarue6K4+eY6ghYJjyivht3fL3hS9Ago?=
 =?us-ascii?Q?4oCbvEmJxShJXPQZY/FNC50tYmSeYNAuME+QORjV8e6mNW/OONXhVQdSlgF+?=
 =?us-ascii?Q?yiFSfhLuwmGQIS7jWKneVZX6ZNvf45F/g0Dtr25hzu4F1SGl/3oqtZZ5D1f0?=
 =?us-ascii?Q?LGnfxK2b9K/jAjBqchwLSkJ+TZ50VrctDbzcLZD8l4lO7vy+pu9NG/Nebi5W?=
 =?us-ascii?Q?ezsDZ6S+wYvvO8gbCr/eohe/raSio785TIqVQ3SBeRT2xv4UBPXNlIjzcr8k?=
 =?us-ascii?Q?epQMFVdfbvNYiISVP3EDkn4c+/QLwC+UV9+pYFrgi92qbcTdyG/58Z1ySHDW?=
 =?us-ascii?Q?8KFBkiOxsHPWndtl0H0/2shFmEHaoKvjQ9GXsaaHu1hF6+1pN9cPAiEy7nvp?=
 =?us-ascii?Q?/ekmcNf6ysRJ5ZXQ4wpeSza4j2icMrT79qOzxQ46UMVGtDb80L1DnVLFrWnC?=
 =?us-ascii?Q?1M8wIu4AwijhrssJiTZp8YZA/smE2sp82mVrU3elqJY9wts4dHzVyv9iyKg8?=
 =?us-ascii?Q?fxt7KFrVTBeDru8Mfv6uvbzMqzv8jeMn39Z8Jagw3k6fkYG87nEHhY+4uct2?=
 =?us-ascii?Q?DIDtAp0mfJJVrHGDBvNJTREnD53lYGsW2ppgiOsOaXYezvV1W7Dd4rOkKv7i?=
 =?us-ascii?Q?o84PeoRhuqP6G+sdZpoNSpAxyVK2aWgZQZE4k+ZK2Ev3eoY4pl+vlKcKm4bJ?=
 =?us-ascii?Q?QuFIhiTpQawb7BvWGBngMeV/5yTvG4PnpduR2oViDQT7pMo4kiK5yD4zQ6Ya?=
 =?us-ascii?Q?Onm9RLzdoA1l4+BwUNmvsy7ksN9VrMGVePOfCMZKSQdLTP0inMEeZuxZfS/t?=
 =?us-ascii?Q?CgMaMHyJ+TZb0Qshuj1hC+1XUvjkjVP+2IqEgp4dJwqXS89dIGMRDMraa2fO?=
 =?us-ascii?Q?gIBv/jbuDQflSIdXIuR1dRnufLZTg+9sVIk5+kVK/XMl7N6O2RryWWfVaz6E?=
 =?us-ascii?Q?H6/W2ecnKiDpLe1CguMYrSgxEdfU0RaFv0ycuB3U3dia8OfjiR+SoP49x+TH?=
 =?us-ascii?Q?/w+zYytAs0TDJ2+DLtjsVOsmaMNX/HGrOkT058FhFZHt0FqPqbH+lsnn2w/L?=
 =?us-ascii?Q?+i6oycAidt8C1XUUCsBJfHO5SJ563Po1KdARug9Wk82yLu/VG7RFRxLkxQeY?=
 =?us-ascii?Q?9Fg978e07dYc8c+LA6JtvMNK26ZwCFT20IDZmZ6BnNSOomacMtRzN1B3ukUG?=
 =?us-ascii?Q?595v/tlAUoxURL8QnPXP6KTjHeJwzKP2hvQkfYOqGLfKuJCdiQc9Qx7MgIPr?=
 =?us-ascii?Q?txjolVRogR+NjFN060EN3qn1Zblb5YzDka3n0MUzAiwhN8Pt9T0kct4TvpLK?=
 =?us-ascii?Q?v7l1uo0N6i/DrzI6RouX+yA1SpFmtfvopxBHj+M0?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67fcbc28-697c-4477-cb38-08db8dccd488
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 11:38:28.3932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e+7VCSSdYP366w7ZR51Bk5fg4afhksQwI3vBbVsApR8WtGvKYWgUk0WHX1lVhWZDvbRgygZhLvZE3eJ9kG/e7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6210
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/usb/chipidea/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 51994d655b82..6e1196b53253 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -1028,8 +1028,7 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(dev, res);
+	base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-- 
2.39.0

