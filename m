Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3721762A01
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbjGZEI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbjGZEIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:08:10 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on20718.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::718])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1D04219;
        Tue, 25 Jul 2023 21:04:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iy0uv38j/t+RYn35nWERXNx/ZulHz7F9vn8gnuP1/LwfFqwrNAWgbUzQ2/4+7jRthu94vP23+Vof7d5sCx4D35oQiZcRjRUeL3ZG9bEiystFYPC/CwYNv9T0P2E7VAsVq6kVgJgq+rmnGJpLgtcw+n25iy3pH1dhKlhcOnbX65WxgUP9UzUxfQScxzHyu2SJrW4eYXtt5NeKCNEVwDBzB4mad+JUec694TmABVPo7EhvYLWzjRkPGr3Dd9IS+chkml50q/fNZ7wg+L72XWM9K5EPejsXorcXZb1sg1GRYR+fBjl/pECm01YyHz4OmP7dYpOWK8PWc3wmkIPfHRESkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZwO81R7bbiuI82gPcvzCcJYy8CKX1m7kW4A8ZR89No=;
 b=R7I2sn9fv0smlMaqr6OIcAn7iVfRQ8b5qPfgyod8krxtfMsD9HIi9S0lul0FiAdcsPJDHToKrAmjk7oGrV4ifjansrPNSTZEyI4io85yz8g6M8237eqVpTWbvtg1MgZFwPLfoszIjBqT139RKnoP78RO5jfPAlTlqabEtaRVLGs8F/KfMYO/zqBtq99Zgf62yyTWQc6O8q2OdyPbsZgXkWh//qtLkhkp4xgY+vAChu/AigpDwmqWIy1qrYa4R1TUwZpByHSDhRMcB9XolYb+9moMM1kTJnLIckdbn6yFZiH+/vHMcXUpyjtgRXYvteT6mDin8UWIAedoX6pyLcTzlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZwO81R7bbiuI82gPcvzCcJYy8CKX1m7kW4A8ZR89No=;
 b=ZrXVzItHmDLj7sZLOSzCtOcNFwb8paxIKhFVLnPsqyP7pUGbjH6apScpwhCSh94HbVDh5xWl6P6uaSJpc5GJaDgPdXGpr9hXAopDr20BFHw7aGRfvDarVagaxTKLIr2tNLIRzHSAYSQmzBfJEfDqd9p0LjNDMW5jlRPjVxgobDgg7nEeTWBby952D1+Je3UntJfF4WP6HJ0xAOv4b4nFb4NaAglHDUrgXvTsDf4Zoke9tqidfyUl9QzDSe8xSQbw/vQZnQjy7zvkoBE5dRvXmDxrudA138g0aRov6Bom1Q2F0nMTn9fUT4wjzzGaaMkQP3aWt0GHNdF87f6qcSKzEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB5139.apcprd06.prod.outlook.com (2603:1096:4:1ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 04:02:30 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 04:02:30 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Jesper Nilsson <jesper.nilsson@axis.com>,
        Lars Persson <lars.persson@axis.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-arm-kernel@axis.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 45/61] mmc: usdhi60rol0: Convert to platform remove callback returning void
Date:   Wed, 26 Jul 2023 12:00:25 +0800
Message-Id: <20230726040041.26267-45-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6b04fdc4-df79-4158-48ec-08db8d8d1a35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g/4ybTHL+30vT9xfcG3rRj4zbkPBTyp6gNOeXhSm7fkUdF3iiQJ4vfTD4ut0mLOFGjgzzq2T1q48LZdpGhOVjV7DWMuls1FqlZX3j2IIMB2pDQh0vsDYg2m81sdEGwnIzViqZl6aGWeBKDMVgo+YMuVCv3SEDV7NJZqzH8/W6PqvYq2wWyAGPgVmLBEjSXHNYtO/p0212+CLAIA0VZ1abb7NkA35bBLosMw7jtml+NHdu0UkKQFg7iNX39Q9p9qZ6WfB7B3cPjttkjJzf1cN2r1NFpbnWYSqd1M6aDn9uJSnlcn8QhLeH6C1IrKwQkkcMPZQHTgr7Fd+IWGsmxNzW9iV8zmZzAL4v+nlYgxJczA84JnThSXKrhj3T18a3pNVRlI7bgnRp1xsT3D2b1IyVenaPbwaNldV368xayuXhHQBg7eoZHZhyA8SQ1D5pn9K8wvUq+w0qPXm54D3zxfXrM9X9cBszk5v3OoPZbwYNDt7th4WN92m//j3stqCYCX1W17q9wKRMl9egyvZ2hr+qocCs1x+uoK+0OOaHc+AYR1ILp/aGamwBAEC2nNJ+gxnftode7pvojT2s1LO+Lb3APYIuewwO5hDFixfXZBTB+tV/ZrN3F34kB+frpejjvfO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199021)(110136005)(54906003)(38350700002)(6512007)(38100700002)(52116002)(6486002)(6666004)(478600001)(41300700001)(5660300002)(2616005)(8936002)(8676002)(66556008)(4326008)(66476007)(66946007)(316002)(186003)(83380400001)(6506007)(26005)(1076003)(86362001)(2906002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjJqVFQzRFN2TlozMVYrTDdteGNpNHBHKy9vbGJGUmlSUmYxcS81cFpLNHRm?=
 =?utf-8?B?eURXQnRFa2hvckJZaDZFUHI2emZOaDh3YUlQL2xXbDU4WlZjZGNIbWUvTG04?=
 =?utf-8?B?YkE5UHdQODY3Vmx0RitXVlBjSUlnb2JHaVpPTjlSZmw4NmtMY2FHeHBVN2x1?=
 =?utf-8?B?dWFWYllkR0VpNDlocVZ1N3doQUJoSkZCbko2UjI1ak5kY3R5OTdybnRsMysr?=
 =?utf-8?B?WGY2emRVSExEck1RclpKdjhJTC9mVlRFN2ZnZEE5SjRXZ0xHM0lYeEd6MTV0?=
 =?utf-8?B?MUVMeENpSW9Hc2ZnTGJWMHNNakwyNHpDeFYrb0tjQ2NmNVNOaC9ob09BV0xN?=
 =?utf-8?B?TVVmSnpDQzM5T3pjMEVoem5kT2RHM0FJKzlBR29KajkvTXhjb3l4STZVMkM1?=
 =?utf-8?B?MVhwRUN5bm91b2JMTzQxRk0zckJuUk1VY1U1QjhUNU91Zmt4THh6OUJCamNE?=
 =?utf-8?B?aEx5OGhkNzN1eHdtL2owMWtCYUs5eVlPRWtrUVdPc3daYVU2MmVMTGJ4Z3di?=
 =?utf-8?B?SUV1YmUvVlpNckdFTGQ2N2o3OTF6cUZBcEM5Z2pSN3h1SVoyQ1dlVndMVWFS?=
 =?utf-8?B?UEdEa1lsUHlxZUZIcDJsYnJPbjNsenhBdDExQnFKMXJtNXVOQm5lMVBPMDRl?=
 =?utf-8?B?SjNUTUJYQVNYNERYZGl2MVk2NzY0T0lTNHo1THoweEM4Q3l1bG9ZeSszY0JW?=
 =?utf-8?B?N1gwaFVjYnh4Wlc4aFdwNlNOTEN3VDZVZXVIaXN3b3RlMnJXZ0FZdzZodEhY?=
 =?utf-8?B?bjJYaEFWSlRWYnM1bXVrcHFMVGhYWVNrTy9HSmhJYW1BNTFPUXpKUWxKNHJo?=
 =?utf-8?B?UlB2RnhWMGZDTWMyNmlyazZDaHhkcmxNZVp2R0NEVmVQMDNkclF0OVlxTk11?=
 =?utf-8?B?VWpYOEMrNjIwTGwrSWtKaE5jMDZtb3VUUnd4Zzh0UFE5bjNRZldSZFJGaFM5?=
 =?utf-8?B?UjZhZEJxTTRzeDMxUzNiRzVKVEcwRGVVYk1yVkszdjkvRHNLWkc3YWY2Ym5P?=
 =?utf-8?B?dkFUQ2xFSnRvcFh6WWdsMXdPRkcvMWdJL0U5NzB5NEh4a1JRaVlkVGlGL2c4?=
 =?utf-8?B?VU9QR0RmVllZdjhyOU9ZSjF2WklaanFUSkdPREdzYmQ4b2Q5OW5WZ1p3ek9O?=
 =?utf-8?B?N28zUHNueGsxb3lWVkVOcUdwRWVZbGFwMUQ1SHErNVZ5eDViZEdqTXBsM3Bv?=
 =?utf-8?B?akdvcXZVN202M3gvdVBkTUpVSTNoN3dHaFdkYjNoak9remlTL1lqdTlFUXhY?=
 =?utf-8?B?aHY1cldlVVZSOVIyQ1dmVVNWUklxRUFPMHFPaTYzT0NkRzhRMWJRZktKNWFt?=
 =?utf-8?B?RE1xcmtRMGgzT0pIdUZZOXVvVThIU0Uxb2djcHR5eUFzNDdaeFA4WEhnSDhV?=
 =?utf-8?B?cUxOZU1Wc0RGakNsMmZHWEJvR2kxd2Z6WFNoM09hWU80cU5nVzhDblpQdFhJ?=
 =?utf-8?B?dXNNWXVoWXd4cUxMbW5aWVFGUGdrUlpTODNZVndrbFRReHBLU2UzOFJ3c3hz?=
 =?utf-8?B?VkpCVEhaT2UwTEJTd2s4ZXpMOUpDM20yZXNDYkVPcW11cDB2VFlFaE0vWDJO?=
 =?utf-8?B?NndyYVZQaVRRYTMyT0xLbEh5VFVBZ2d3dHhuUkJMak9EclZBTVpNdU4vU3Nv?=
 =?utf-8?B?NTVJa09MeTFkakFxWEhsd0dRQkczMTdmN0ZSaUtuSVRmZVM3cmF2dUJPN0Vn?=
 =?utf-8?B?dWFGZm5GdzlvbExNTGU5RzRhZWV3N0lMbnBGQiszUnA1aEpxRms1cUwrQmdI?=
 =?utf-8?B?MUYwQVlSY2QralppVHNPbVpJMVNzTVo5amNCNTlDOEpyM0ZUYjFPR0o2VGdW?=
 =?utf-8?B?b2ttYjBVZXdpNWxUbGE4R2ZzWkFYV01BTkpOejBzcTlCdmlnWFhNc2ZpVnps?=
 =?utf-8?B?cFh1V0w2V1JSMHBjODdrUGFqcFQzSkxBM3J2ZU9jQ3lPRUF0aGdDRTY1bHJE?=
 =?utf-8?B?RGN4TlRhQVAyT0Q0QzBKV1JhNXJtRWFXSzVBZnpFbXM0R3BIMURPWm1pd3hC?=
 =?utf-8?B?b1BtK1BKZFBuZHVuUldWaWhYdW11NXp2ejhacUQ1aUtVSWJPSjNZZ1U4bmxT?=
 =?utf-8?B?MEc2N2VmWE9BT2hZZTJKa3NLWjVqVWsyMTJuTXE1UGdHR3BaY011YUNudmFl?=
 =?utf-8?Q?ifREVJGlLEnB5xaI2D+cDJ/yl?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b04fdc4-df79-4158-48ec-08db8d8d1a35
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 04:02:17.3978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L5c3xuTJzXnGt1jV2tMg2x1YcS4xjF3jRQolXAb4zznYn+jv/I6Yj0cij43gsk996boy1Ua87qN+lpw1DrlE2A==
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
Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>
---
 drivers/mmc/host/usdhi6rol0.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.c
index 2e17903658fc..6e421445d56c 100644
--- a/drivers/mmc/host/usdhi6rol0.c
+++ b/drivers/mmc/host/usdhi6rol0.c
@@ -1884,7 +1884,7 @@ static int usdhi6_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int usdhi6_remove(struct platform_device *pdev)
+static void usdhi6_remove(struct platform_device *pdev)
 {
 	struct usdhi6_host *host = platform_get_drvdata(pdev);
 
@@ -1895,13 +1895,11 @@ static int usdhi6_remove(struct platform_device *pdev)
 	usdhi6_dma_release(host);
 	clk_disable_unprepare(host->clk);
 	mmc_free_host(host->mmc);
-
-	return 0;
 }
 
 static struct platform_driver usdhi6_driver = {
 	.probe		= usdhi6_probe,
-	.remove		= usdhi6_remove,
+	.remove_new	= usdhi6_remove,
 	.driver		= {
 		.name	= "usdhi6rol0",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-- 
2.39.0

