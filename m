Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED0476476E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbjG0HBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbjG0HBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:01:12 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2093.outbound.protection.outlook.com [40.107.117.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1B3272D;
        Thu, 27 Jul 2023 00:01:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SeBCEBloFsZoNS+5J1sO5KnjP56xeRnO3/XX4lEYgNV7foyxuX6xYd1cEY0kua82Vyi1zjBpdCKvsQUTbbDltxauR4mdiihDPGTYa2x1TK+l1xQW5dgVykwhvpvcL6GYVkZXwFvSnjNyilZwXriLPICeJaUKctotx/kO/11KE+g1YxLXYo4vydrZipys3dOxArVMQW21R4wx6ASz92Fp3w1naHo9/QlWPKhewFgBQvhJejN4y9Woli3zZySQ5n9yzpY7+1ncKv4xfTryPdAQce6dmYNXD1CXbWgIgJwTHvPUd8VRGPPcOlmgAuLvZ5oPIRnMUyCr5Qm9WixfPWK/Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3BDV2gitE9ZgnfS93zzj6+ruXHPsGkYOE2qo/yJJ5Ek=;
 b=APvguC5UvVDVSiIVz5eyTxR+aAZ1p8xqrBcuppT4ocqq95GW+J3SwEpRofbjBjVrQPQvM+GT/Wk4TKOnq6SmemyrzjYUjt7FO/ou1gORpq6od8mojZRcal6jeio+yJQZjVB5QE6ep6hsHzUIGWkxmOfo32FAULqcNDJPKeoQgEaMNBt6PNeGbvYEL7tH9c8qsc2PgyO8NHchLvtHD0S8hxb5SX46ELWE004/FA6Z/gkm3WUnZ9UV3UuZiCfMdv9h3kVX9PEBel3udNyGwjauWZV0oe7P3XwyLPhzeJ+/y2wHFd0xGFfKf3XlU/U2WTWTayrjAoH8VrE7/8eLrXTpXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BDV2gitE9ZgnfS93zzj6+ruXHPsGkYOE2qo/yJJ5Ek=;
 b=Vy3j+10+n2IeLbIykOj5ObhTpgPSlbR5var1iqWV2gsCdxETsXiSXeZTMB/9HRUd9XrARXeStiVxbbxlupkdNV2F26C/NPriwUiyimdn4t9/wU/QPdQ7OwQOjy0b8AFYLA+vFx9MBWK2RKOcIXJ9TzeGTQVnnclwb5Ngduc6vVQQeUelr2YfbVUndfSEGM47Sv2vRvO1016ixd/hcq+9C0oBiBt7K1bVbSwJb7KgJqKAuCCyuMmj+ShuTsuz2rKWLEUnISPNKYS/YkzP0ACGEyaDm7q7WMJjQ0tKIzJNtt4pbFlNP47T6Opvo2Ab9qbzY8Kp5xeVJh4o/DBeFTi6pQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYUPR06MB6027.apcprd06.prod.outlook.com (2603:1096:400:351::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 07:01:04 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 07:01:03 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/62] mmc: sunxi: Convert to platform remove callback returning void
Date:   Thu, 27 Jul 2023 14:59:50 +0800
Message-Id: <20230727070051.17778-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0017.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::10) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYUPR06MB6027:EE_
X-MS-Office365-Filtering-Correlation-Id: 447573a4-1197-46fc-4553-08db8e6f3de2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5x5QEOI3W1Mtsz7E+kTSWli66UZKWJarrbbcYCYIC5sDLUstFY+23H4a5CDZWjplFJv1LNMFIMRK2jREZ8wz+cTXcRdTsI8/1lYUIkkDsm64+CTTOo0A5L2IFvfV+pcs0e9M5SUgHA061bmK0pknLkF7mbYfAQp3/dy/z1eRK5Bn4EiovffEmXTh3mZeGzh05GoXzs+QqCJo+QUJmZFsm9CtsVp3zH5w0l0itjOO6QsS1gNXXqqytenNE98R7mXhjKY98cwyeDGVOZ+Ms0h0txXXI1rH4XHVmD97Z1kROK76PXLm9UAa6JDFQiUkxIeDlE/o5qrtBcT93Kt20WHNZ4vnzRwH4+ocDdWQeH5Ay+JLMVNgsxKWzCliaEAqtvuvQrNiHjNADGYUQcvF95WNa7QkikzFyg0KVoGlXYIHl2uxLQkjyB491npV1VjM3La9YWhebxtLCABjLZfxq3ThNufQtfxg51HVELJtFgXvaHW5hBozGFzTFe2DguM7SK55mcjI5bV0T0m2N+zI2Hx7kHbcaO7mXNDpeqMoFdqfdXBaMDFhSeMfjgjTsmN4EY30H+muoQiIwGwyH7is7EEa5tm6fKItXhJ4fkshTfijsXalqOEig+Cb73LV5sF9GpNa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(451199021)(2906002)(1076003)(6506007)(26005)(186003)(86362001)(316002)(38350700002)(38100700002)(2616005)(83380400001)(5660300002)(66946007)(41300700001)(66556008)(66476007)(8676002)(36756003)(8936002)(52116002)(110136005)(6512007)(6666004)(4326008)(6486002)(478600001)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDIvd09TNVpyUkU1VHF5bUh0WS9adnZVRzVLZmN4ZUYwYS9Ha09GL05SU0tE?=
 =?utf-8?B?UXhnQjQxYisvRUdabVUyYzQzNHhTTVExbkJwM2R3djV1OEthUUxGb0hrdGF5?=
 =?utf-8?B?VmQ5Mm5TTW1BQWpGTG43OENmT0FBOUE2b1grVjJ0UHBsRFRjQ1BLSlF1eld2?=
 =?utf-8?B?blNxVzRtY09GbWtPK3U4VHlhK3pjcDJ1SU5rUFFRTmV4WUJ6SVk4Q2VBVjlG?=
 =?utf-8?B?MngzeU5OcllZTmhwdENxSTR6d0hmT1FWR29XL1pPdFROWXl4MXRvWXVybTBZ?=
 =?utf-8?B?TVRaUnlDa214RnNveDdCTkRMaHRJRWkvemI1VGtxK3NVa2Z5WGtFOFJ5dmR0?=
 =?utf-8?B?eGs5aTZNTWRqbU1pRW01K1hJNVJrK1BIZzFmTFNNVlZ5ZGNSRjJiVDRYcWVX?=
 =?utf-8?B?WFBmWHRMODg2ME9YaFpTZlFrd1BBWlFhd0gxMjZQS3JmZG9aYkN3SkwyZEpu?=
 =?utf-8?B?Y0ZGRTNYaWxBOUFJUUh2U3RhZmZlSjNZMElYSVRYbU56V2FQYkRVRXRPRFpZ?=
 =?utf-8?B?dm4vZktOYnd4V0FUbjBYeURCRWlNRjRNNmt3d1pCNUppRTNjako0N0hWK0My?=
 =?utf-8?B?eGtlRnhKWXB6Q20vdkNJMHZIWXRwVXZ3elhIaU1oRFYzaFB0ZS83bXpyTFls?=
 =?utf-8?B?enRkdmo5Ny9vM2ZnTlQ0TnVhQ01GQWdPaGVwMHZaMVJCS2sxRVlzZkNSa3hn?=
 =?utf-8?B?bG1PRHJxVjBEdHpsWWI2MmwzMGVZOXU4dThFM0pwSVQ3cmpmNWI3ZUhWa2Ir?=
 =?utf-8?B?cXFzbTIwOWoxY0FZa2pTeHJaZmVTVnRxaThYVUxkYVBuMnFVeStDTmdHVEZa?=
 =?utf-8?B?QTcwSUhoSFExRDB6ZGVMdENVZlVkL2RvNElGd0lmN1gxQTFtVFBKY1N2b1c0?=
 =?utf-8?B?cnA2L2tGNGpJdDdtUFRQUGJpM0E3Q0tGOEVJaW9GaU1TKzROWGtDbzFKdUl2?=
 =?utf-8?B?T0Z6YUNPbnRMQk1yeTNRSTlkRW1VRnhtUGpHbVhMejF4azBET0ZZRkhwTTlB?=
 =?utf-8?B?YnY5YXdYc3dGZFJSMW5VZlpaTGdJek1tQjkwM2grSzM2NHZBV2VYRWZHY21X?=
 =?utf-8?B?K3FDY3RpTURaRGhrVHlDWGN3YnQxdHRpa0FSWWdCeGdEdlJFOGdzb28wVlR3?=
 =?utf-8?B?NFZCTlRXeGVMYW9yc3NHM0dYZWkzOVVMU1l0UEp6R1c4UE5BS2ZmUCtya01B?=
 =?utf-8?B?QnRzUUtVZzNFcjYzRFIxRUM3d0JvZ0doajRXQUFFVWpmK0g1aGJYNDg3dVZQ?=
 =?utf-8?B?L291OGY2L1BsNnRpcGpNcVpzeXN2R3F6Nk9JL3RCMVRhVGZicE1URzVkN1py?=
 =?utf-8?B?VUladEhaaXplNVFIRjZENlpDRWNZYmJPRmhEaTZvSGs5RkFNd1NnNkw0WXph?=
 =?utf-8?B?MjNaWmFrNVU4WDhzM3AzZGZWblVpK0xVSC9rSVVkUkY0aHFybWpxQ2NXYmVB?=
 =?utf-8?B?YUZMK3lENTYwVXVVc28za1FCUGx3blhrN3J5RkZpT0lUdlNETlJ2aUUwU2cv?=
 =?utf-8?B?TnZucTVJR1J6L29reDAzbjlPTzBac2UrSms0TnhJeW5pazF5MmYrZXIvclc4?=
 =?utf-8?B?MkU4RUxkTC9FSW5EY29lNnpYR3dVZjBsanBnZE1qR1M5MUQzOUZpa2ZOK2ts?=
 =?utf-8?B?YU4yd2NJQUVoS3M5clp0VVBleTI3ZnhsYUtEMW1KUDhXTWtLN201c2UyQWln?=
 =?utf-8?B?bVRsWEo3VXNmTzVWbXUxVUxVeEZER1JYN3dDaTd3SWkvWjd0cHNYRU9rb25H?=
 =?utf-8?B?K1lWOW5ZK1NCUzFvVXhuODZzTEF4SkdoUUloaXZOM3NueE9Wa1psVTlLZW85?=
 =?utf-8?B?SXZWTGcyQzBVeW85eDZGT0tmemhRVlh2WlRkelNkRkNCbjJuS0l1UVp4d0Y4?=
 =?utf-8?B?eHpVNzZMQjBIY2dpUHJuTEJpVGhBWWg0RkNEdzM4MFdyaDR6SmlSQ0NGUk84?=
 =?utf-8?B?cVptNStXYWg2ZkFBRCtoN2R3MFRjbERwU0RDaWJhTDBHOWZ5VUFJL0Z6ajVJ?=
 =?utf-8?B?dExXQjFlS3pGT3BlRU1IZFQ5b2RaVkk0dW4xSHg3bEU4N2FONm5YWXZoQ2tx?=
 =?utf-8?B?V3Bnd1U4WFBESWlFY1pzRjZtR0E0Q0pldE1LM2hOZjErQmx0Sk0vSko3M0gx?=
 =?utf-8?Q?r3FT7iCh1EGmhDDEOk0Ok8o2E?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 447573a4-1197-46fc-4553-08db8e6f3de2
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:01:03.6262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ez8EhYmmXmBQLB79mjaF/JzcIaO+mmCOYAH4sxOYAzOrgNSh9+iv0xQC0JuY6rSAkqFi9zv7OCmJd5OPtL/dkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6027
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/mmc/host/sunxi-mmc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 69dcb8805e05..d3bd0ac99ec4 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1486,7 +1486,7 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int sunxi_mmc_remove(struct platform_device *pdev)
+static void sunxi_mmc_remove(struct platform_device *pdev)
 {
 	struct mmc_host	*mmc = platform_get_drvdata(pdev);
 	struct sunxi_mmc_host *host = mmc_priv(mmc);
@@ -1499,8 +1499,6 @@ static int sunxi_mmc_remove(struct platform_device *pdev)
 	}
 	dma_free_coherent(&pdev->dev, PAGE_SIZE, host->sg_cpu, host->sg_dma);
 	mmc_free_host(mmc);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM
@@ -1556,7 +1554,7 @@ static struct platform_driver sunxi_mmc_driver = {
 		.pm = &sunxi_mmc_pm_ops,
 	},
 	.probe		= sunxi_mmc_probe,
-	.remove		= sunxi_mmc_remove,
+	.remove_new	= sunxi_mmc_remove,
 };
 module_platform_driver(sunxi_mmc_driver);
 
-- 
2.39.0

