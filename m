Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD07B76479F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjG0HEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbjG0HEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:04:06 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2116.outbound.protection.outlook.com [40.107.117.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFB53596;
        Thu, 27 Jul 2023 00:02:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L0YusM+X0ZlKkSISB+77eg1N4e+jpbdhPvlKfFGMpEusXNVvDb8QHE0jAU6fiW5HN4+Q8L51xBkvWLRCFWBjGCOPUWe7BaKyQuXOzxK+BtJDezm1xSe653NuNsBGWWwtZCR+i1cbo5U0MgBRCBgArYp3SHRngxbMBewFxq8pOBaU0P/sxlnmtkf1j35NGnrpf5FpWRoI9a2p7VmndWCJiHNk4sreHwP5VMLKImf+LmpWokDkYS/J2kVI5uTqyShafJLyhdsDKboFM4FPmtnU+eTHi9h039lwV12n8w167MS/lrE1Wrrwi6B/GVPHeqnRQR0yjnGg0D9bwZz6Uxx7KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aw4Pv13PwJyGo9i5NmSf9Iol6jil3qv/WJ4az+CnkgE=;
 b=UNdp/U06KWGz82ss8T2gCX17DsxxqLkGp1+RtKnvCKrb3QKWPSEoZh9FrBA0cpeQOxbzdjV67b5ZUWw1BvPRccY/OS19l2zhfKV/v2dNhxMcRlwVx9qrD5j3+GLd5IWGsXtwH9NiKBQyK0sPpaLGBwIrU9VS92QGIkF8bykpkPLRy3XcJTYMH9lCcnV8jnIo2iqzwD8MtJq0E/jvY7AeL/F2/DPBrgwHFDlNXomwCTCokbVeVQC5rjJT04RrXbOLsPRqLRj8petQO+UdGd/qbfzVz71mRjdEuYRvisI6PH6/MxsLpWxxEaGFBgf2wWz1iPO4bRF7pF5+kit57aua2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aw4Pv13PwJyGo9i5NmSf9Iol6jil3qv/WJ4az+CnkgE=;
 b=TRtFk93sr8BUc9QyPUpgB3yTouZh00XHqPdCKKfKHR5w+h1I+NJKzXkKEpwQj+SM/x9U3e5oXA7C8KT0NqJWIc7OeT0wjt+ahhkkt30lJSHXqL5d27Eem63PQkkh52GcoTQ2BbJ8EXgBz5hZA8O3osL0dPb8c+6BZreqoqYk1TdZ1bzsQ/XnYleTVRw4Z0kSd/+QVaHKObGqoUHgvc7eWqoebpOZnwaKXZ/0RTQyyY/hwI4cr7Z0zuFetGHu1n6asZECfd/VLQMk6ggh406F9kepxz9I0s47x/IkCAfTK5LnQrfhiHAKKmD56QLAC8n8cxFfltq0IXWVI8hGM6nRrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYUPR06MB6027.apcprd06.prod.outlook.com (2603:1096:400:351::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 07:01:48 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 07:01:48 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Robert Richter <rric@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 28/62] mmc: cavium-octeon: Convert to platform remove callback returning void
Date:   Thu, 27 Jul 2023 15:00:17 +0800
Message-Id: <20230727070051.17778-28-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230727070051.17778-1-frank.li@vivo.com>
References: <20230727070051.17778-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0017.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::10) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYUPR06MB6027:EE_
X-MS-Office365-Filtering-Correlation-Id: f5b5364a-6833-47a1-d558-08db8e6f58b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UtYvURrR1STnu4+/9sZaVcelMh7s/S1dbM2ivwJu7AnsXJOS/3caGtAsHMrmcSaoTcvVjaqO4K5UTejydt5C5lKTjqRGFgGnyu+C0PcDIiEu3UdQwjTg5Tmwhi0pkudWrZaylLNmY59AQ3HwtoFlt5wx9lryO8PRchQNbhD+GOFOvKlaSUxpgPGCFf8Esg9cYBfVtpwQc6J+fbpON8JYxXlD5HUf5+yNqAV+kLYNgkC5gcgrfL5LDO9nwLT5HwOnQD+yL0SrDOgLCQ4WrH5kDYl6IyUpuf6K3+tX732x3GIRs0TXsWaHravIYf0peHWuXiNXtqzmjv7DRUOTmddjyuuaRyoRY413/3PgHyEfkvGVfiaSmH5fL4SwR1XFYXSVUiSQlLMp1zOkGTlfBWB3s527AdXdIlx6O1nyhrnhcaeyhbVCZ2CFIQDNlON66fnJW5ELauqW+o2pLEIMldWwVvYn/HwchUNdiyQXNNE067PQuCkKaTtHrLValpZ+9UnSqfvT6OWnxtujkVW5tWE0tou82lTuWDvtGJk1AFj+1Nx5CXjCM/ZrwBkq2G85lhvnhcZ0riiwLLZCK/FTubFTDJqerkSQHQyyHiJxHE9YUsEn2AS5ws64lc78d8LW0Oxb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(451199021)(2906002)(1076003)(6506007)(26005)(186003)(86362001)(316002)(38350700002)(38100700002)(2616005)(83380400001)(5660300002)(66946007)(41300700001)(66556008)(66476007)(8676002)(36756003)(8936002)(52116002)(110136005)(6512007)(6666004)(4326008)(6486002)(478600001)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0FiaStMMGYrSWJaWmpjRThYSUh4OVBRdTcvMmFSQXFISUNaejZWb0I5NG52?=
 =?utf-8?B?RlJ2UFN5dkoyRGxsbzh3eWx4OTlGS05wcFRXSDIrZUlrampJTjkxenZVVjkx?=
 =?utf-8?B?dmFwK3Z5U29DU3JEQnZneVdRbW9vd3lLblVLVHZydlBEQ1l0UXduNHlRSlI2?=
 =?utf-8?B?a1k1eUZBQ0loRjJDUHZtWTlWbkYrWTVZNVA4OHV0SkYxdWdMdlp1VHcxNEJC?=
 =?utf-8?B?ZkJWTU9WOWh3UUlheWYzRjNEMjhOR2NKTmdzaVdXcmpydUdSeFdJUVo0Tjk5?=
 =?utf-8?B?T2Q1RzhRaFNMMk8vaWNWQjdLNUI1emszeUtoNFA3dTVwQkFHZVdERk5pcW41?=
 =?utf-8?B?cDlmSk5EbW91R2lJUXNxaEd0RE5VOENFb0Z1R2hzWkZMdzR4T3NCNjlNSW5G?=
 =?utf-8?B?RE5hY0lCM1JuVzFSZ2FFaGYyajAyMEtFcVFRQjdYc0NXajZGSlh3Nng2MjUy?=
 =?utf-8?B?UzdwbFRIeUFwZG5ma0ozYkRLWmpjQUtMZWVhanFtUWVNdzhZOCt0a1REbC9J?=
 =?utf-8?B?bTJGMVFPSFo3Y0J0R2hLbG5LZ2tyVWhHMWlJTVkrUzRzK21nRW1uWUNXMUZr?=
 =?utf-8?B?VGhFbCtRMlJZZjlydXpGd3h0T0srdWxRVnkrZWFwVHR2MTlqazcrYzlBTk9o?=
 =?utf-8?B?UURManhabWMzR2l0dGVTaEMweFdFc0xnQmtsZk9BZmZML2drdmFVQTVTQVlS?=
 =?utf-8?B?NGZyYW5zUEVES3Z4RDdEZWRXUkRwWVEyckhJU2RoVERFeFhuR0o3MjVBQTZJ?=
 =?utf-8?B?OU1pVXFBYUFGSUxNQVZnRXVMYVFZMFp5azlmLzJqUXppeityaG9kU3lwbzRn?=
 =?utf-8?B?a01GMEFuSFlVYWs2R1VWdEN0VE10TG9JeHZFNmg5VkNNdkx6THhmS2orc2pZ?=
 =?utf-8?B?ZHlvUFpybCtnU1V2UG15TmFnU2NRMTlybjZRMldjRDIxdW5WVmpRMUJ6NTdQ?=
 =?utf-8?B?RXN6blFGbXlRcVkxZnQwMTVvRXNVNjgvM0hxTzR1djdEeHRLaFhJeGk3b1g3?=
 =?utf-8?B?ZTBsanhXdkN2QmZQcXB5WGhqRk5oeDgzZDhuZ09SQ2N6YnVtd25ScnpabUh0?=
 =?utf-8?B?eEhUNWo3R1NVc3JpQVIxckQ1dytIcmxjQmxycUp5YnJFMnA3bG9jQ1hENitz?=
 =?utf-8?B?T2R6TnJtS2drdTlDQlEwaDB4N3NMcUdCcFgzOEZZdGZDekl3ZXlrNG03VUMz?=
 =?utf-8?B?YmJUMHp6UU9DVzBudlRLbmxVZWtQMGhzT01sWkJnQ2FTTTN1RG1GUDRkWk9h?=
 =?utf-8?B?NC91ZzNDMGYwSlNLdVBKbHBLelUwb01DZzBZamppa2kyKzE0RXFHY0Rpdnpw?=
 =?utf-8?B?T1kzdzB3eWNYYjB3Ri9tYnB6VEN5aG45N254Yms3R1BDaXEzaitRK1cycEZl?=
 =?utf-8?B?NFkzYTdvRjIvNWdKcnRVT0tMTHQ5M1VBTk9ORm9TaHF3RFQxSWZQdTZYc09S?=
 =?utf-8?B?SCt6dXFKYlNWbEgrMXhZVDZBNVZ2eEZnVE9WNUFiNEhmQnlJU2xPbFI1SExt?=
 =?utf-8?B?UktBTHAyTlNpSkJZdGg3YmNVRHRwejBqMmNwT1BBV1VZSjBtYXdaTmVsakc3?=
 =?utf-8?B?OFdpNVBWUmFkNHN4elF2VTBhcXBPNDhHOVFLNWd2TUsxazlseE1UaDVid3Yx?=
 =?utf-8?B?QlNjaSsrUWpIb3FOZUxrc3NEcjlTd0djSEtGVFE0NzNsRW9sVXJGUjNkSC9Y?=
 =?utf-8?B?UWZtTFQ3N2lSRE1IL3hlcG9xcEJPcUJ4eDFkZVB2a0NuYXdzMzF4dm9vU1cx?=
 =?utf-8?B?b0tXSDNTQmIrTmxFRVkxbUtMUzloWEdSTE95OENuVG9IR2k3dGMrdHFjYmFs?=
 =?utf-8?B?eUZzT2VKbHVQQ21LV0szeXdYbHhYNnh5ZVlNU3l0ZFY2Z3gvbXpuQUYvMnJ1?=
 =?utf-8?B?T2ovL2dlemFXbUhrbWo3L3A1YVpxNnJNNnJmWGJHR3o5Y0JtN0ZteHZqclNS?=
 =?utf-8?B?R3BwNXZrSzVFMEhFVkttVFpoSW1leVBRQ3doajFGWDczdXNRek9yV2RWZVdV?=
 =?utf-8?B?VVA2OHhrV2ZKTC9hWHBSOTR2REF1TjZYR3JzbkwvRFZQa0MrQXJFM1U3Vkd5?=
 =?utf-8?B?NlNLeXpIM3J2SlcrdmpWRU9ZNk9yU1lEbEFhVVEvaVBEUE1XU1JWVkRFNUIv?=
 =?utf-8?Q?0mp4pftmhIxU+aSYwZa2c7i+j?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5b5364a-6833-47a1-d558-08db8e6f58b5
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:01:48.5703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jbVJ7C09d3xje6lJP+GR2m+XsMAFlp9QX+npoXhVY8IcrPFKrMq4WK/bW7/PSyOdop9+Z7c1RoTIjNQj8v4EOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6027
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/mmc/host/cavium-octeon.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/cavium-octeon.c b/drivers/mmc/host/cavium-octeon.c
index 12dca91a8ef6..d526868b30f6 100644
--- a/drivers/mmc/host/cavium-octeon.c
+++ b/drivers/mmc/host/cavium-octeon.c
@@ -294,7 +294,7 @@ static int octeon_mmc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int octeon_mmc_remove(struct platform_device *pdev)
+static void octeon_mmc_remove(struct platform_device *pdev)
 {
 	struct cvm_mmc_host *host = platform_get_drvdata(pdev);
 	u64 dma_cfg;
@@ -309,7 +309,6 @@ static int octeon_mmc_remove(struct platform_device *pdev)
 	writeq(dma_cfg, host->dma_base + MIO_EMM_DMA_CFG(host));
 
 	octeon_mmc_set_shared_power(host, 0);
-	return 0;
 }
 
 static const struct of_device_id octeon_mmc_match[] = {
@@ -325,7 +324,7 @@ MODULE_DEVICE_TABLE(of, octeon_mmc_match);
 
 static struct platform_driver octeon_mmc_driver = {
 	.probe		= octeon_mmc_probe,
-	.remove		= octeon_mmc_remove,
+	.remove_new	= octeon_mmc_remove,
 	.driver		= {
 		.name	= KBUILD_MODNAME,
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-- 
2.39.0

