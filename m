Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5AB876358F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbjGZLrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 07:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234284AbjGZLrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:47:37 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2101.outbound.protection.outlook.com [40.107.255.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992862703
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 04:47:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nNY3N0/2QbRoHDPCQNoQrQKnp5daj4ctF33XX2YUr5Y+5HWBkZ/8oJSR/1DYlmkr6RpBvOfwKlmKuSSRJN+lW47Y6D/cMX4j2gpi0tbhPq7gP8Mqfney1P90H2cH5EFwqf6PiZCEbdvdCx1qTpo68XyBZWo2TrhoC2z88aCuP25j1XtRLCOmqlhrqdKYc7HmbAj1gefXclo6P3vo6K8JXMde/5AdeWT+rPhrLFCEYORFfmQtLWcjpVv194Oa2EQ2N8yWrPJKegRgb6YsYRO+Q5q3MfvjqgAHJgzjvq/B34Qy04o5S1pQXJvjaaiXfVRFYVPN0xZrmD8B2S0gA2Fe9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oVwciaBlemwynmnommsPsCO/7FxJBCgDLAsFVxM2ByY=;
 b=B0pVOhcdATAEreNEKVeE0j3m8v3ROln9ucByGDmuU1abzwuNrSkfzrP6b5LNUCiWXMk/AN+ReBOX//jpm62jZT8k4oafoyVCoPaIdKexjzZpV7kSU9T52JidkPmrhb9OtVWGtN+hXAZuh01Fsdq84Y5oEo/9ItkCKabaFnwyDRl0iLzZK8S6nFxCSCfQw9OBql+TPUZpVkzD3uRrZq6jWhCnAQmd7wvOgMfAFq9Qy9Rza4wmpoi4J7iW435/sAxyueCTdTn0+1Vj+sP0mcsI8DiL3gMJ/POLxwHql9AqL3NSlwocJayns4UzsUoRwJrN+c7gQTA8vvCddIBwpviOCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVwciaBlemwynmnommsPsCO/7FxJBCgDLAsFVxM2ByY=;
 b=jMeCmxgok/iQkT6pT7+xUVGOzLgevTMSlC6EGwnM5JKHUyBXWTv+dRPEPAKjPiHmbxGaTZpAiLgf1mmcpD+jBKXKyUHGK5Hi23LJuibcm6h4qYbythwOe7n/dueqX9hS7vJt1Kav6s/nUV4qhAoQkDuammPWmxw44SR8Z9dgAfmTrxrIob4l+moWANTzyU9Pgezx4Eb1CMWtk1fqMg0eAeDOVXY3dlUple8btRcO2sFpT1P0A4fmoy/XLrrKrbgJUqS47wcIL3mcXi3Tv5q+ZhNUZENFe9YifPSKQZex6gyonbfH71aQgHB3/lYkYsyFr3lzvv7bUZxDWfpCzEMlXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PS1PR0601MB3737.apcprd06.prod.outlook.com
 (2603:1096:300:78::18) by TYZPR06MB5027.apcprd06.prod.outlook.com
 (2603:1096:400:1c9::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 11:46:05 +0000
Received: from PS1PR0601MB3737.apcprd06.prod.outlook.com
 ([fe80::74f9:2f8c:e5b8:a573]) by PS1PR0601MB3737.apcprd06.prod.outlook.com
 ([fe80::74f9:2f8c:e5b8:a573%6]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 11:46:05 +0000
From:   Wang Ming <machel@vivo.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Wang Ming <machel@vivo.com>
Subject: [PATCH v3] reset: hisilicon: Use dev_err_probe instead of dev_err
Date:   Wed, 26 Jul 2023 19:45:45 +0800
Message-Id: <20230726114555.5011-1-machel@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0092.jpnprd01.prod.outlook.com
 (2603:1096:404:2c::32) To PS1PR0601MB3737.apcprd06.prod.outlook.com
 (2603:1096:300:78::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PS1PR0601MB3737:EE_|TYZPR06MB5027:EE_
X-MS-Office365-Filtering-Correlation-Id: c3183f6e-3d94-406d-8777-08db8dcde4b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h3pLdHFu22QEz5GmVIz2pTPW5vCq1rMiDMlhJA8UTxuj5hjJADdFQkAHFZftIxmu5uA3AJ8oEPu/EMzoRqzCxj+U9N42huUCe5EuXQWvcDtTIzbMyalMbNn5A2aw7AHK9VNT3owecAD1vPFOT30vGqWvVLrQLtiWsTPGqvYqx27LnJLI/MInO37wUqn2VDcc9QWFgou8bzCjfmGIID6iSiBa2ZjwffCl9CO/K5N6oyP70eohFE9PHjCURLsF15vJsgSFYVqo8m1Y48FAdbf1lmgCyGzxy936pquo2y9Mr6z2bYE8cZJHwosGAIwyvdoTji3VqLAUxnEVm4YTu2kCGhi5AuZiHZIZglYQCwKVGYu+0YqSgGYO4YW1HHwbwwGXezLtTTN8rh4LIXeV0cGtK8B1OYNdmoyulW2uhtoeigxUsvCBPcSNykdaxwIYhA8Hr2Z7C0toC0DmdtUAf9o4n8KYnsLHk3WRnp3hxgWnnHICQL0SPcVeFnrYQNYKQeP6SAKz07g+RE8nMjwY3TvBvtDFPcZh1b0XoFuMdncoYw1k+Ucx8doplHL5UMb08nT+Eu8YKhzp+0pNoNzcc09NXceDPqKL5PuPdX79SFKTbLCGN7QQ2D4wTl7k1YdBXF0x
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PR0601MB3737.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(366004)(376002)(346002)(451199021)(6666004)(6486002)(52116002)(478600001)(83380400001)(6506007)(107886003)(6512007)(1076003)(26005)(4326008)(66476007)(66946007)(110136005)(38350700002)(38100700002)(66556008)(186003)(2616005)(5660300002)(41300700001)(4744005)(316002)(2906002)(8936002)(8676002)(86362001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?73EGvTeNzKyoNB1TmSF3Wm1zYX+yhOMRSoAt6tHG6nx5qxFsQGDy4kjkZYmg?=
 =?us-ascii?Q?DoCI6luackaQ0qzx7O1w5nbt2ZXcqHPfVPzCx2YTHS2BbjG9sg2NQvn6Qp4t?=
 =?us-ascii?Q?mOX3zgCgrX2HUE0QaEyIz9yMEbel80Ind61ztSfgaCDBgJIfL5+wyuKd3uET?=
 =?us-ascii?Q?E+AQrN6O1bYoI73f0s0s/Ief7yVKpmO+tPvZTuiw8UXXYM8NDGSSN5nIUZnX?=
 =?us-ascii?Q?1JtBvON0mFcBKoAQX6cCprlvwsv+eHe6T+DWq0OkwzBieaiVnwmxQGq3NNnn?=
 =?us-ascii?Q?fJwam6fOUV85QoYlXj+LYC5L3EJ+2Zf8JBpEMWQpg+sVU/cI5OxJlmM7ctCf?=
 =?us-ascii?Q?pc6cfWm6JiJp61qffmWl9PrNuIH8CJ6livXuUog6n+X8BJw/Fx3u35fhjOQ3?=
 =?us-ascii?Q?AK7UdPFAI6G/lZYE7ZicsIIfX+ltc3aHHHdX+KN2kZWE0WZMeP3jGHg2fkA6?=
 =?us-ascii?Q?9e4GBsHeCJbHvWsIKMsGixqbxgxgIEZzf5Tg/6H4D8VaN69xQPdSyMDLF1HW?=
 =?us-ascii?Q?zQvG3Xo/GyX6gFm5JWzMygRK8fRUdvj9JOgrnIfsnDnVmCyWg1IyQTHQJ0dG?=
 =?us-ascii?Q?WgzlavUTF+XY3VelzMZ2I4rDrhXfffEK2LOPWwOMQmKe+Q0wJefEjiO+T+5M?=
 =?us-ascii?Q?eF2LiaMhgD4ppijI+4lvPmQ3Pxqbml7gZSPvTx4VcTE5vPT0mYT6zyGsIdaW?=
 =?us-ascii?Q?4LIvzhc+ePXBAAStr43cXrmmc8RGTQ40rFaI9UkIKZEqzoMctyd8HDF8ui7L?=
 =?us-ascii?Q?Vb/WUqoRSs7SDARwZzonhgD0pbJBXKeMdj7nnTsM0KxnsrLtI0bIjnlyhH64?=
 =?us-ascii?Q?yuPGHMBetoCWIahoxjBSh5mPb+lzL00PYWGA9/JNEzGKJ3iZ7Eh0oG9YrfFF?=
 =?us-ascii?Q?SUOP66hF7DDaJ4DfvQXgbext7PZJtGF5M4kkH84+n2BVv8Q7EbzbSk3rVRXD?=
 =?us-ascii?Q?GM4zUiXg62UekDm6+SUH4TXjNGhvCMThfCcJJd7yj9A6ddy3dZ8ea4ePG7RM?=
 =?us-ascii?Q?37WioYlbJMFcN8jLB3MAIXDW9mAcqGTzqBZIIMvTIb7tYkha2Tqzhsfwg0Nm?=
 =?us-ascii?Q?B/0wMzE7lBdgbe4+Ie0724MyHbRPpb5WuikWsOl6/9qWAIabRDNBZZgy+DRQ?=
 =?us-ascii?Q?BM0ABqv7GsKrdknT/K9eAyOiFjW6pEg2W0k9H+vb448EBid8pBOGlL1c3zXc?=
 =?us-ascii?Q?Lus2sZkx+1aSn5ja1pyHXAY2JU2eFQl6yEGJxhiAC1pxepYuRvh7XK5Worxt?=
 =?us-ascii?Q?8qIhgr+dlFD6hdLFJRexJdVOS3tOV/hufa1qfTY8iBC5gh78/3f+m5tl3myR?=
 =?us-ascii?Q?eHwFcXmgt4POScdXVdx+asXWUI0kZP+LK72NgVtIzVEs0pKsyWZUPYVGeJNG?=
 =?us-ascii?Q?P5fCM/adRsftHmH/hPq4mcGfrDAdyEDHf33Ak6O+cxEHJApj2sWwHy07XXe4?=
 =?us-ascii?Q?k4r32i+xkajkPonDCsfNw5ZK2BgN6i+gIOJARHacgwbc/M+bcGHYrs7EX1y6?=
 =?us-ascii?Q?XFRR1LqoGTIrDq+oGHilidkhjkXOxR0/6LP8tthFV1F0FbNg8KzoqVWDvZx7?=
 =?us-ascii?Q?1PnHNbIygpzGCehhH8oAN+PKeNMctrcaNkWadnsm?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3183f6e-3d94-406d-8777-08db8dcde4b2
X-MS-Exchange-CrossTenant-AuthSource: PS1PR0601MB3737.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 11:46:04.9389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ntA7GEB0L0nz0Tu5nlJ5o5ff+1gTN5w0ieGwjCl74jP6HOXF7nYkEFH5MyWIMXC+DTeUcmY3CiGPlW2XX0p/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5027
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The probe process may generate EPROBE_DEFER. In this case,
dev_err_probe can still record err information.
This helps simplify code and standardize error output.

Signed-off-by: Wang Ming <machel@vivo.com>
---
 drivers/reset/hisilicon/reset-hi3660.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/reset/hisilicon/reset-hi3660.c b/drivers/reset/hisilicon/reset-hi3660.c
index 965f5ceba7d8..22a9f87b4979 100644
--- a/drivers/reset/hisilicon/reset-hi3660.c
+++ b/drivers/reset/hisilicon/reset-hi3660.c
@@ -90,8 +90,8 @@ static int hi3660_reset_probe(struct platform_device *pdev)
 							  "hisi,rst-syscon");
 	}
 	if (IS_ERR(rc->map)) {
-		dev_err(dev, "failed to get hisilicon,rst-syscon\n");
-		return PTR_ERR(rc->map);
+		return dev_err_probe(dev, PTR_ERR(rc->map),
+			"failed to get hisilicon,rst-syscon\n");
 	}
 
 	rc->rst.ops = &hi3660_reset_ops,
-- 
2.25.1

