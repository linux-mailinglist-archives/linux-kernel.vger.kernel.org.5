Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE8575720C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 05:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjGRDFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 23:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGRDFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 23:05:52 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2109.outbound.protection.outlook.com [40.107.215.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B61CE51
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 20:05:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H5dA2rPyl908sWkm6R1W4J0o+bsH1WCvvQhNl0RFhFHpnvk9Fmg8RX3IjjBsEjnLbi/PuS92Ypt9NA2JMhjTSuwWMoMNJ0iXdw5vJv3s4PVEw6T2nVDDXVnI83IXFzYuYYGMTDWa9EXphjMnPW+2YV7um68ZdpPvYACf+4yZ2RkXixevEtLgc6FG6XSiH/l1GYH9y5r3ZaOfb4WUVXA1znJN0FJLOpJEwR3iy9P4Ndb5LBASUBa1bruWuXRlmrKGiF9pHVQjiO7vhOZY69ag2/fZWFAYHBlfVZoEDMq6HGVyqHmRCmH/PXVm6ADC6DGascGC5qIuOwdHo7XxUpU0fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lF3NZ1D4t6CaeybDGr2xaKRipPu7S/MFyxpFfnWpYsg=;
 b=Wvg9JKJZVi77M45Mnh00hNz2uYXcRaFALh5uUlk64uGX4crJMnAqNv70DTXixWW7CY6ZsqXSYvMn2cDm8yqC37iTaknTNSBQKD9RKcSYihui7EKKSfKMKyUleoMv4mYAa+omU3NC0vYuuQ3HKHlFWG8jI4QSb+YrTMrzyDIdHc5zxM/kl10pfMI/veEi4CRypWKwFp80gflmnYpGWsfUSqK9ik3faXr//WGdk5rlrWP8mrYwoj9PbGqZU3XwDPwoFgkdphegM4K9YEwd7BDYCAoXJcawB+68W7ZJSCLkprx7x/onPKsZsWin/zXAlaS9EOeNL+BKPpQXYWhrNFn2/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lF3NZ1D4t6CaeybDGr2xaKRipPu7S/MFyxpFfnWpYsg=;
 b=SKgwAPe/y681j2c5PsUi4bvk6YMfH0eDkV2ZqRfo+OWlNFiPjVW4a2smcVpP0ITjSi5Jr3a5l8dgXNNYr999jeQ9mjJgz3i2nAl4cZ01Q+NeWa1mEttlyiqb1skW8hpfNtWOGJWAKxCQRGokOjqdfUpT/d7j4jEvFIP4kqA+1FAwIcqWxvFJJ8UD8oYZv7WOpXcbk5kYyV+qFSLstmSrSfOPPlm1WsYXsgj+tKmKrfNwHGOC6larz3UEgk9nZyuI5W4oCg5rE0CTK8gqZHtPjv6mrww6fzcN2LeGUK04Ll2sBgDM/uJzjUqwEg0jadS/gaw0KAWtEOKXItScQevb9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 SEYPR06MB6181.apcprd06.prod.outlook.com (2603:1096:101:de::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.31; Tue, 18 Jul 2023 03:05:44 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c%4]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 03:05:44 +0000
From:   Wang Ming <machel@vivo.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Wang Ming <machel@vivo.com>, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
Subject: [PATCH v1] reset: hisilicon: Use dev_err_probe instead of dev_err
Date:   Tue, 18 Jul 2023 11:04:56 +0800
Message-Id: <20230718030511.16065-1-machel@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR0101CA0024.apcprd01.prod.exchangelabs.com
 (2603:1096:404:92::36) To SG2PR06MB3743.apcprd06.prod.outlook.com
 (2603:1096:4:d0::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3743:EE_|SEYPR06MB6181:EE_
X-MS-Office365-Filtering-Correlation-Id: dc89e20a-7ccc-4982-e149-08db873be020
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QJaslWgs6wV3JTtlW4/OYZlUH6roS+xn8ty4ZpFQdF3HLau22uZU3391/TKusdQ4BDDOwe+sSDo7e7eUaeE+ePhcwcrK6usAAq6skm+6E37rniNO3+EFHrVVaBVubL996DK62P2rR5rw/9wV3N8faiNVhnPc6RpjLGb0ebCxK54kc33dU8QAml+UvI2ntECHzZ7TIyg9EmTHaQ+Z6UaX1LRhrv1T6LVpvXPR/0e0XosMKrpKGQVG0wKRxxe82AZkj/iPsi0217DIuqVaN9YQ6mXGw8sCRQD16H3NWrYGP+nPHBFSs2R0fxa1W/8mXGYYfwEdA/HNoR7C3Fhfps4ifOuwTYa9AesyrqQV3r+7fspwr+KrfkGc5njEAgyVShaIKweJHBF8q0/bPmP+PL6SBhsuutIlNp9+3qNSLb8lpUNkio1SDyxbW+GLiYl0CFv4J151T8SPXcWdh5/TymMiTl9hEfSTp5I+4934/nNhwRdsgVW5LKVWggk2RBAzljoMYNMnGD3ASeVSrChFPlTGsVyueA24Ywf+2qs/ke74fsr2BDRCG/B/KxopIRubLDY7Q2Wbam1RLAWp3Ux+x6MnpT3+H+jBpUrHXdjK+c86yuuySvIUeAFhcR9L0PH5TiZz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(396003)(376002)(39860400002)(451199021)(52116002)(6666004)(6512007)(6486002)(1076003)(6506007)(186003)(83380400001)(36756003)(38100700002)(38350700002)(86362001)(2616005)(26005)(107886003)(66476007)(66556008)(4326008)(66946007)(2906002)(41300700001)(316002)(4744005)(8936002)(5660300002)(110136005)(8676002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: t7fk/uIV0VaQAEjBdTwE/2swNR3hbOVKWun68wCZheXcxdiXheln3IssYI7uaP/RXJUaMmG0KRWEQ2fsKtX/+OHvBcK2hRskRWVzsaXXBDH6wO8lUXfq+yPM/NzQUQVlYbUNKHkRAQ2d20d3UM/RohvVA0l6ZNDQKOhKjLiJKgtm8orWhCcziGy3IAgrA0+I5qncKDuZjXvLEqwUtMGPAN6yTnQ1CbsI/0Nv+3D4EvhuRhkZLtcgqto8RaJljZuss6RvBKThQiP/8Pm4rNqB6HR1TNBftd3FVS6tk8FgdebZMgeWtB9kDXFIb4hz/unAFtguRz6YDoHMHKzDziIinNmVaNjhREwzBzCAV2qSFSJ0AvEWy4OrrjsN00/qAZHHseuHLPkZO2vl48Nm9XZx9PI5H6tTd7WuBx3LFjaGbqU=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc89e20a-7ccc-4982-e149-08db873be020
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3743.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 03:05:43.8172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wADhQ1l8EiRr+mKEFgHEha1YE/19qGOKEA1bdLkBg0Mc6houItF/ex9BkDW+ggS4YOhLXjKgl/dHENv9FE1NTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6181
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/reset/hisilicon/reset-hi3660.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/hisilicon/reset-hi3660.c b/drivers/reset/hisilicon/reset-hi3660.c
index 965f5ceba7d8..bc8fee6dc14e 100644
--- a/drivers/reset/hisilicon/reset-hi3660.c
+++ b/drivers/reset/hisilicon/reset-hi3660.c
@@ -90,7 +90,7 @@ static int hi3660_reset_probe(struct platform_device *pdev)
 							  "hisi,rst-syscon");
 	}
 	if (IS_ERR(rc->map)) {
-		dev_err(dev, "failed to get hisilicon,rst-syscon\n");
+		dev_err_probe(dev, "failed to get hisilicon,rst-syscon\n");
 		return PTR_ERR(rc->map);
 	}
 
-- 
2.25.1

