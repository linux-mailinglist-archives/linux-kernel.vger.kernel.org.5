Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C4F762A17
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbjGZEK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbjGZEKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:10:09 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on20718.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::718])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E855597;
        Tue, 25 Jul 2023 21:05:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XFmMdUfZcer8QCUxOwK2nMC9rxtXiQhg4jX9OU94+CQAAXGu52sdfrDmCAMjwlOBngfoFjl99FkNIBdW2zZWKLK7MU8I1BAHTzLtSNZWjoPwpdOSELgjflrq7hMF6arzpCVC1+7Yflxt76PpgG+QJNRmcq53MD1D9K8RE/BmLuVI0kNFP7MM7Dr8dZDJIBg8dMBaqXXdWKl4k6StkDrXdNh3MY6tuPmp4WYyb8vgSEGEWFFYJN/mrwXbl+S+JhqSnuyoNFf+Yk/z09HuEiJFMe2d/yCFRh8sL1PktCq4nqoiVKaoDS6NKoU+CEYfOEKq9OdVjqjDOC9bh+uigH5yXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+AftkKfw0z8AD4ham5M5MC4dYIWJjDbvgy5EIjA9X60=;
 b=GWXLfAG1S6kESBGdTD9VZmWV/kMShWnFnDSSMUWg2Mrvy3hjfZYpfjf+R7c5P5cObDPyG3Oumwc/y8vswg3lOoKUzFbRQS+o/FjZP06UPZ19ZE5AEq3Qex+pbGRSbc1vPM7lUH2srvED6ww5PsFzqnhveyQqw4R0Wf3feh8kAJui8ZzKhb6wYY52RIiUhz6G2US2w/BIYYGpItz25PZXCLB1TyrIxOGnFulm6EuWSLz5zHJ5aaviv8I/SsMlRw5riLmsMn/D8bHtNZrJFRh+ZG2aDc0WJ0OsjiV5J/vQ7/O+qazj3V39AU3yXErMT613uW6VSCUyPDLVzD9DiT9joQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+AftkKfw0z8AD4ham5M5MC4dYIWJjDbvgy5EIjA9X60=;
 b=G08KKUJn+edEq2g+ZE6HEBzCRmFbjsoKZWhPlgTtJ2fo4oa/Ug+pzBKzkDAVU8YcrRMQjsOoxTMQzgkfWKGQcYNCPVu8pmdBrXmmNpgY2ba8c4cdJWfEby3mvpFY/Tt3tJpFBXdooBIGFH4dwoMNrR9+MqLlBv7QcOjgnxPv98Qo5R+D/jl0nylY7FD4/QYYChrRbDY6dlutf9hiD6nz8BHOinaYx+o6fZ7Uw+oBkjSC6+/oynt6SY3JFsXT/8AiizYiG1088500Wvjmv/Qrvlx1ML1qGqvYyjB3OR7Tf6r6sVVbtHOTpI9PHfLuyYGI/4Omb7Ok129SSPmvAcEwNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB5139.apcprd06.prod.outlook.com (2603:1096:4:1ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 04:02:35 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 04:02:35 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 54/61] mmc: pwrseq_simple: Convert to platform remove callback returning void
Date:   Wed, 26 Jul 2023 12:00:34 +0800
Message-Id: <20230726040041.26267-54-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230726040041.26267-1-frank.li@vivo.com>
References: <20230726040041.26267-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0093.apcprd02.prod.outlook.com
 (2603:1096:4:90::33) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB5139:EE_
X-MS-Office365-Filtering-Correlation-Id: be08069b-72cc-4222-2be0-08db8d8d22de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OSCh1UtellOofNo+Md4b8dvXahhYvaU6WQE3fxrtQzkKIsuRjaqwXcHJy7NvamCBgAxpmyZp9+3mYxPnM6DgF71bJzKG/xXjNdFAHVFmPpy4o9ahkMCQ7ifTDC8eNq6qkL4OlNooqhrvnzePnJ/CJs30XvTcEM9c3F/EFfxmUmnpPPUuCM2YC4XNP/S6GPSN9h+BatDGqkZaxlZo3L1qCzsZf26YPbccMyyJ9c79/jDNqhgnDckoDFOX/U7Dbed79Tcu6HeIZUdYWhGzt70x0jKnkYYAtUomB9JDfMwSGoKXzlIhyGz2RyA+BksUDzIf/JguWmZ3PyV4csJzMBJ+AL/OMNzXJ+JcLk4KtOPHBxJRO15LnsQ3K4NnbV3vQlRLieHKnVn1vB4I12kaDJVoB9cVQ0tCYVw46j5f1WilgYUnAXaxvrtXjsThFglVgE3GPD5ZBa24ecK70ndG0UFr8R16NpgAyz8l3sJC+9E6gPBOnU0lzsF0aEYn8IOq4cFaHZyIyf8kB+iiReefID+n82M7mbbqqq7dJJORaBX32Cd7wUVUGdxu6B8XkmZfgbWvZTnLtUkk5ERW4RxGjUcAUf4e/TeNYDPD6zWx0AFwLFEYIsdcCAsiogxQsUWy1Yty
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199021)(54906003)(38350700002)(6512007)(38100700002)(52116002)(6486002)(478600001)(41300700001)(5660300002)(2616005)(8936002)(8676002)(6916009)(66556008)(4326008)(66476007)(66946007)(316002)(186003)(83380400001)(6506007)(26005)(1076003)(86362001)(2906002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WERPbTNyWmhicWZOZmFUVnpraFhIcjNXbFpIS1NZMmF5TTFwWEVsaS96WkNT?=
 =?utf-8?B?ay9mR3d5cmRlS21ZRmF5VzJGYS80eEllZFdyRjJvWm1kRWZ4d3pvNFRDZXNO?=
 =?utf-8?B?ZUZpR2JubDBBNHpLcnNwa3U0VHRyRHBNZjh4bVo0QmNIaTNqcnhkNm04bFhC?=
 =?utf-8?B?SWdhTjhFZGczeklzTFNLdDF2Uy9ZVlVodmYwL1d1VDhDTHVPZnhPT0c2YmxG?=
 =?utf-8?B?V2o3dThIUWhrcTl4aXdLWDBRaU5Qc3l2UnpkNk5mZDVBNWc1T2VaQ0Z5UXgx?=
 =?utf-8?B?bGEyRjV0dnhhSkVIL2JmNmJkWTlCeWhEQU9QR3VSaXdFZmJYQlk5dnkzeTRy?=
 =?utf-8?B?V2p4NDR0b2xkWGIxUnI4YjNCbExWcFhkR1NXUmlYTFVZUWpvSzFPQk12YXZO?=
 =?utf-8?B?REg0QkpCNUJRSUdmR00rR3gwRm93THQxWWhFKy9pMDZnQkZGVFBDWXBPOWdt?=
 =?utf-8?B?YS93TUVncTQxbXlLVk1WaDZBMUswWTQxVDZVSExlMklVSitIWlkva0h2dUxa?=
 =?utf-8?B?ZVR4dXhPMUZ2eFU4cHBZRTZCM1lOR3laWmI2dE82ZlN0ZzQrQlRpNzNKYUxw?=
 =?utf-8?B?ZWR4UlN6THljTjZYSE05TmlxMUVZMzU3czVsK1VOTTd4VmxHZkpyTjU5d0tU?=
 =?utf-8?B?TXhOU2dGR1B1bGpwbnViVWNkdE02YzIxNDJSaHFYbTEyVGJ6ZGwyY1JyY255?=
 =?utf-8?B?WmhJVkdUUGpQMUtlSG9YcmdJcldBWEFxKzV0ajBoemV1ZXVqZmdRQUtjYWRo?=
 =?utf-8?B?ZnpYNFVsNnMwM3kzU0Rud3N6cHpGd0kxSFRWekFVSm80Y2ttN2FNU1RWM3U3?=
 =?utf-8?B?Q29JYm1DekJ0ejErWnphbzhPNFlmWlc2d2dJTElNUlpOeS96akhVQmRTbXM4?=
 =?utf-8?B?cUZNMDk5M2ZFWkRYVW92NGVEdzdCYXZ1a1JkRStmYmExbWNjUEhmek9Hb1o3?=
 =?utf-8?B?Tys3Vk1NTUV6K0ZrYUNzMTVLYWtVVUZtMGZvSmhpL0ZXWFNRazl0YmdqblZW?=
 =?utf-8?B?ZkdRM05yc3Y5VDdGUlZuWGpFZldZU1pHazIwTkprdWdQcHp2WURvTVF1L2p0?=
 =?utf-8?B?RFBZVnJIblNyT0VTc2tNc1RKbVVvVDVEZkFKZXc4UkUzMTB1dXZUYnNEbVlD?=
 =?utf-8?B?ckpGVWFtVjc2RGV4VHlQYkZXWTJoL1BqSXFOZ3UyRWFEempSK1dnei84Sm1Z?=
 =?utf-8?B?SnJtVnFmK0lwQnBqVGxmNVNVL3BYc3J1TWh3NDd4U3BsVjRFbXVDWmJxS0VG?=
 =?utf-8?B?RmNJOGR5UkdNK0VBbkhmZ0FUaHhVU1JEMUUrNTNNUFg3NERMWXp5anFQT2cx?=
 =?utf-8?B?ejV2Q0ZGTUNlaTNlWXlhOVJWWmlsNzBUTnpmTGZVeEFUZnlZVUl4NXV6ZmhH?=
 =?utf-8?B?aVZ4Z3lDZHV1c2k2OEdXMEhhM0ZjWVZJSGU4RXJWRWZzSThHSTVVcGtWcmRQ?=
 =?utf-8?B?cy9MQnZ6bTJ0bEYxUUV4eDFxMHJINjJQSkc1OFFJZEljNFBXeUNjbFhlcnNu?=
 =?utf-8?B?TW5OTUZqNk0yamJVMHB6UE1zTU1PVGkwd3Y1ZFY5ZG5xNlF1b2JuYlVsb2s1?=
 =?utf-8?B?ZTZ0b0owbmZvVThON2FGMURjQzBzMzVERmROLys3Tmxhbk84MXFEMklEYjB1?=
 =?utf-8?B?SHhmcUR6eExKekU3cHhQOWdFUDIvSnFPZlRYSmNjRThMRyt2M0tQT2xXRDRF?=
 =?utf-8?B?RW9zc3Q5RlZXVzNTYVlsM0p0MklJdE13Y01hR0hiR05vakR3TXNIZ2tGSGRK?=
 =?utf-8?B?d2cxdXhHR3ZTNzYrMDNFbzUvZDdwNTJuaHVwV2t0Z2Y5UEZKS3hxOTZaZitN?=
 =?utf-8?B?azIyY1BIa1FVRVRtWXVlZnlId2h3ckphV2FJazNtWTJIUEtCTjJOb0hNV25z?=
 =?utf-8?B?VUNIMlBZQXdoLzlWY2huUklZODZXaE05NUU3TE5ZNlJpaHFZZTQ1RFNDN1VM?=
 =?utf-8?B?L0Fybi9FdVVJTktYZjRLQno5L1NSNDFZaFR3NmJHTzVzNDFhWnZBN3QzMTg4?=
 =?utf-8?B?bVRaK2kzZHpOWHdocWNiOXNZb0NJUC9NTWUzOFUweFd4NE0xQnVuWjBhdTla?=
 =?utf-8?B?RzZYVG1rNkJQaVdpV3RLaUZKWkhqamNlWkVjQ2ZNSVF5T0M3YWNCdDJxdi9h?=
 =?utf-8?Q?S/RJjHkqJkTfmKSR58+J8uv4B?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be08069b-72cc-4222-2be0-08db8d8d22de
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 04:02:31.9691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /UBu3dpkP/kDBx+xLlulznCMYQH+G4PIug1L7UHHM6qDq+mPZya+W/m2VofhRHEsJ0GxPLYK0ZAjCmG+jQHHgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5139
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is (mostly) ignored
and this typically results in resource leaks. To improve here there is a
quest to make the remove callback return void. In the first step of this
quest all drivers are converted to .remove_new() which already returns
void.

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/mmc/core/pwrseq_simple.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
index 3bac1e71411b..df9588503ad0 100644
--- a/drivers/mmc/core/pwrseq_simple.c
+++ b/drivers/mmc/core/pwrseq_simple.c
@@ -142,18 +142,16 @@ static int mmc_pwrseq_simple_probe(struct platform_device *pdev)
 	return mmc_pwrseq_register(&pwrseq->pwrseq);
 }
 
-static int mmc_pwrseq_simple_remove(struct platform_device *pdev)
+static void mmc_pwrseq_simple_remove(struct platform_device *pdev)
 {
 	struct mmc_pwrseq_simple *pwrseq = platform_get_drvdata(pdev);
 
 	mmc_pwrseq_unregister(&pwrseq->pwrseq);
-
-	return 0;
 }
 
 static struct platform_driver mmc_pwrseq_simple_driver = {
 	.probe = mmc_pwrseq_simple_probe,
-	.remove = mmc_pwrseq_simple_remove,
+	.remove_new = mmc_pwrseq_simple_remove,
 	.driver = {
 		.name = "pwrseq_simple",
 		.of_match_table = mmc_pwrseq_simple_of_match,
-- 
2.39.0

