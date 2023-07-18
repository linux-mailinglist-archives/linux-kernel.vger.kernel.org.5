Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16AB2757248
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 05:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjGRD2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 23:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjGRD1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 23:27:34 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2094.outbound.protection.outlook.com [40.107.215.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52EDE19B5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 20:25:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BiavIkHtPulMgV8uqxRJUWIwK/Q4NOI3gc2wiCJmK4QOlhs933Ri3wIVA8ODc5Tor6pgS5RA0DexrndCe6zDQqHiHwP72praTsJf2+am1pP9wbVBrGoNZ00QbV40BilsMNlWQMcbaLRfHcFNV39SwVCdFX1i5yiT5RP5agq1g77xmVLpi6DOK1W4rrlUeegDUIeQwjepOZqYSxBmTq1cJGOoMqULOz/i7jUqPjyulqwp+zWJRhAC565PbeWFWuGPEjA7632rGBt49KhrgzsJGpHzM4KYmXp/oEpdaEs4k2UaYDxLTmIaz2sY8dImcNO1CqVWRVuifEPVqBv20rvl9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oVwciaBlemwynmnommsPsCO/7FxJBCgDLAsFVxM2ByY=;
 b=etMDU4rx/7hbf7+Oe/qxqnU+Qln0bh/yC2q644rGBIoGujgwVJnJt/nvA3VXJKPmdwhNDywhJEGJhY/OePEQqlzbMRsmoeD7sstFQncJOkd7UZ/IPwIfMfCvFeMlQxP/eypqre94SCp8tFMTWM0fwy11/lW1wmzI6YF0k13PRIU8UcphZyCrahSEwTt6xvGRFTMZNxtFvZTTvpyS8H9FAQyYlQwv06STTpvZcmMTUKg5TYL3nGNMn0w52UPWqVz6fiPg6F4k9hC9oAIScU+fcU/11kFlG/dK2Sowr/7241qFUOito2gDt6jxWdK3EtHSa0miA1liU2b9/xUiQ1SAMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVwciaBlemwynmnommsPsCO/7FxJBCgDLAsFVxM2ByY=;
 b=j1Dpj6kQUthxHjZ9X1SF0lnKfdmqdfPxvI3RB605ztufz/yjKQXQJ9HxZ4Zrc/RGfbqtkzJxRUBHOz9NatxweCJuAZ3u1Ght3bVIoYhKvY7lPyvd21ohhsuqQGqXzomvE0vb8l5b750oms7CE/C+hqXqbAVZ6aH1SQTIKpqN/9l9qQKMnYBokCc9qAc8jEIElEglkL0Xs7p5FfmVYaoLrV+KYh3knPeTZUveYWqNMfJ9Z5osAdrSDqh1Ggzen7QyKtoctm9M6G07HdBLjBiCXkV10hfnDhyqyVeyo8aAJZ6VGqSsKXvl896zLlwx6YF9g36VSPPINiEKKkxpsDxlSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 PUZPR06MB6172.apcprd06.prod.outlook.com (2603:1096:301:107::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 03:24:55 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c%4]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 03:24:55 +0000
From:   Wang Ming <machel@vivo.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Wang Ming <machel@vivo.com>, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
Subject: [PATCH v2] reset: hisilicon: Use dev_err_probe instead of dev_err
Date:   Tue, 18 Jul 2023 11:24:31 +0800
Message-Id: <20230718032443.16355-1-machel@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0040.jpnprd01.prod.outlook.com
 (2603:1096:405:1::28) To SG2PR06MB3743.apcprd06.prod.outlook.com
 (2603:1096:4:d0::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3743:EE_|PUZPR06MB6172:EE_
X-MS-Office365-Filtering-Correlation-Id: 992b217a-cd26-477f-ad3d-08db873e8e38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ihCbnB/n6Ry1MEbjckAQjQs6ludjrbEGdkdUH94QpVqC0Q6PeRL4SdSrk5625HgYKtYRqONLoFA9ObS4SKzRKLOy1TDQ9AGPDvIgb08qdX3Bg2oSUyfUV9wznqiDT4+jff5pA2uk1B8wPIxVi+bB7yTc7PawNgiyzrUOEQzRL4YXhwSZ8GDYcWcerUq6XoxX7RSBYgUHLvznasSz4Uj5I6r6Kgm16yYx8lLjVYfOxuN0GPIleIL0idqYC93I5RzmGch3ffhEM/aU2RgilpnSAfvMCQuyAgE5Lfyd4f/l8Hn5zqiXG2epatRStpCBR4sFdc7jOSPLdYrShSXV3ZdxTS45qS1+RjbIXIis+qQE73rOquS3FkTKcPZfPsVp9XkzQuI3LgUF2ApLYtO2y/ri15weBHyx0yntU3p27sQ+XrIPCDbluAbxmUTEwKR0A5nf++TfDRQpYSfCF1OseLgOmGJMknHDqKutqeqPjrfXvT5z9xbzdPNTvMeOxheVM2SWdjocWpYxJKyFv2xrkXApc8OHUO/3eCq/SHV96w0tKdssiCPlUaEBrjWcQfIIdX98mfJU6/c+dDmNSz3ScigME8GIKkee7UAm+XBNHvfl4aGW7O/gcmA/aXTMoQTvFxXT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(366004)(346002)(396003)(451199021)(86362001)(2906002)(4744005)(36756003)(2616005)(6512007)(83380400001)(186003)(6506007)(1076003)(26005)(107886003)(38350700002)(52116002)(6486002)(38100700002)(6666004)(110136005)(4326008)(66946007)(66476007)(66556008)(5660300002)(478600001)(316002)(8676002)(41300700001)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZtW04YZ3xUOTUfcHFu/wQKQmoS2XR9UPg+BY7TCtKBdncbRbT41KJ0ZSkp6n?=
 =?us-ascii?Q?9u9DQmXftYiCKtfx+TRoh0WUVTNSCeePP1xdYoceXzitg3GYD5HPWy3zeFgW?=
 =?us-ascii?Q?UyKCnKecCBB1SCUOa2ahxx173VMu5M4Yeq8UrEAn3Y7G4Ps6g1lxCzHD+VU+?=
 =?us-ascii?Q?Ui01NJ2yLpDED8LTaYPaxzhCPPTaVrgZk+xQW1pzdZG6yew/b4zmFycBT7v4?=
 =?us-ascii?Q?MV/73Q0obANgQUaIDyZ4uqyS51fwz70PJzPqiJBMhzjzaYpDW23Onada1zBY?=
 =?us-ascii?Q?2HOz9X5GoYoNM8YGQttWu2TY1mRWHNLH2JG92iQ26/srX2lIOgJFtzrWuvTd?=
 =?us-ascii?Q?V4kbtTm0/C/HzXh5n4fvCeszbdlXb4G2Y7mSSo3Al3x0AqLdPsQ9XViL8uv9?=
 =?us-ascii?Q?41Ho31h0XpKQxhlQbcQzk04u9WjKYYkfQ5rwcuGhNnWVS0L8jqxHk6mW2KQx?=
 =?us-ascii?Q?YjjRFEpEAr/cZ3HD9tI53+l+FkoD8Sz1L7t4NnNKQCww7XIKS3Iw7PvcH5hQ?=
 =?us-ascii?Q?MaQ/NVgz4AEBgoSug1kePMCT5TyF3FK1gf/Xk3eDX9lezHAdWSyBKGS08APW?=
 =?us-ascii?Q?6FqqQ9+GJ9bf4lqHdXyCDBDu2D4rHE/Z0kk5kYXwC6Vt/MFWFydOosMxRwQk?=
 =?us-ascii?Q?3VCV+eXoYZ0/uoLd95sqkz01wIHOAhXpb3OAzDqYBrTgUkqoTHLFTx3W1N4g?=
 =?us-ascii?Q?aeWHW+PYzI5jDKsHFuI6IQa/N4emmlwQ3rtlIXRV71LEJw1ks41ymsWf0LyI?=
 =?us-ascii?Q?V90vFuxopByBmwvaFiI4exCBO5xkeBq143c8cZcu9sM1JK6B4eNznDEdmTdz?=
 =?us-ascii?Q?EXHXGN2H93b5u2A0dFjwtNHmy4lVWkmKStL3pPrCBdpEEQFqc62YpV2LaBeH?=
 =?us-ascii?Q?QO46nN0eSy3F9emYgMIWHhsx21IpcSnygfN2cfHih97U8fWy8ieXk0xo6o3c?=
 =?us-ascii?Q?snVPSpf2l6M0vOrjOzAFgwrYuA3Kiy2OGs+s8DyGEJHUcHo5pGanCGahXhUu?=
 =?us-ascii?Q?3WxTcxX3MXObiJR2o+bvJtrQZ1DQAOKWrTU+pSe3F4iwEhnHnOBTrsPCyRp5?=
 =?us-ascii?Q?sPcgBuZRorZCLUEvkiONg9PiKzu5rDyXHTGHuIkyDJSaDgw70jvAzx6ExJPf?=
 =?us-ascii?Q?1DzibLiKUMYR5J7753GWqhoXmLX/BOc6d86BDsnMbuGD/VyBxgiPm3kWbkPV?=
 =?us-ascii?Q?HCeye8f2Qq/Yochfe/Z17IZX2aubs9OT0MbZweF4DeH+v0o5lvd7vp+De9FF?=
 =?us-ascii?Q?DHgc+vuP3ykOgX/k5JqQw7ask5982kzJTarpAEBzshSsNkRJj+2UvMS3uEl9?=
 =?us-ascii?Q?2F/TvgzT7sDXKWz32cHTE6yP1MGCtbv5Ei9dTt1ZgdUwArPT0S11UkIQa28j?=
 =?us-ascii?Q?XmAncKKzauqpiDS9kgvyRtjiWa7zuFgFnaTq+YsJdUAKFbh+zCVnw4eTfqLQ?=
 =?us-ascii?Q?fJhVNZOk8F/yCz2XW03UDZpByZywFV89v/OMF0S3NpQMgEL9MgzLcVUTePJU?=
 =?us-ascii?Q?gHHbyCwyudEdFL0BuNKEEITxRHDdV+7SDRNiInDHaWdBIwH248T8Z7MYm2Db?=
 =?us-ascii?Q?KjOJypwwmFHcHQNZp/h9SoIQwhpe/JgTwtuOr/Yn?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 992b217a-cd26-477f-ad3d-08db873e8e38
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3743.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 03:24:55.2511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MGtI7xke/5Bwf/jlA4XCkYfW+Kfu0zYD7Ed1Cj665ysv5eRNSXwIdNyeBQk2B6fWnH1VUUD2mvqgNbUIbQw0rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB6172
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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
+					"failed to get hisilicon,rst-syscon\n");
 	}
 
 	rc->rst.ops = &hi3660_reset_ops,
-- 
2.25.1

