Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA09D764793
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbjG0HDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbjG0HDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:03:03 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2091.outbound.protection.outlook.com [40.107.215.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F463C06;
        Thu, 27 Jul 2023 00:02:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TKbvDA/PASz7Y0dq/Ff08FRrbcLF+qh1anGe7Ase314xidFL5iqABbGjZ/slz363OocoXr+uE59t4+0JoHAogs1jeL0qQxyjDKFHs27jfNKc0mb/6eo9YSOFmMYWABvX1SejB4YING4hkl84l9A9rCWs0bzpdX5Q3SAS9ys0+PX8KHDudrk6tEaII2CFjhmfMCU80RBuDFF1qCHM9nC+i2cmQdkx/L3M1xOS2D9sewadYwscH6wNbLBcRNo8JtyUoV6G4ACJIO08hjtsgcDjf+Wsu+603y1QG4s9e98Bzpt2p94sUCCj1KZmfjGF5VMVy3UUITqsV1c93DDukLS6ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZpaS9jMDnrZmEK/1dIqDJ5lnbNq7D2TPsIcBR4aHSPU=;
 b=cv5FwLFVru0Ih7O8rvHQ41rU+ZLWcp1ekZOTLX4NHQ6IG7+jWrXxKz6OISTWiBc0y51FpQAUgtziElZBRrm6QjukB9CJEFWNl9weIrgYeG9rxrdFvu0UluA/aX8+AYpiSa5uvSdSHR7Lz75DO1PZo5Z0Z04WK8QEH4UE6JcwWDdtIjjmYmPH3vM8+BEW11XlSCUAJNpV1z1yGcvIUJFnOeAQo4sZ9USszp2Q+ptiTWTVnMo0416yg5oE3JI0FzirkbmdcIxGzwIKGuCgx7A/CZB4u2OU6XtXS6yc0Ccxwf9q9xxStEuBGlL8anoF9J4FgItn6ha1CjcUR3khMXyBEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZpaS9jMDnrZmEK/1dIqDJ5lnbNq7D2TPsIcBR4aHSPU=;
 b=FvlGX/9UQ9ApPUkfQ88e/cGqLxxQzWKrGpQMpK5SpHov4BivZ0s4xnCQKkgl/wjfgtT9TIQY+Mm3bLMs5sTdPH40jvsPXL7St17Kr+1dqQiaz8MELz7WBnurK6GHUAY1m8uuvltk5HxdwzyGCZjzmagx+twp6s/QKDUyU4ea0R140WTyfNJGRlX2vFA0N5JK1NhZgX4PlKjn7FAKThHaAc/61SmhORslKNJs1ogWthnJcotsSrgwcMvC4PFqZ7HbElLNevi/hM7HAuaEgSiupgBO1Bc9qlAuXX5UVFGdEeqNt4WEYLt52EFZBVJ4X9ipLd0JsivDF5R8wdGHtwfVpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4276.apcprd06.prod.outlook.com (2603:1096:820:78::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 07:01:28 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 07:01:28 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 16/62] mmc: rtsx_pci: Drop if block with always false condition
Date:   Thu, 27 Jul 2023 15:00:05 +0800
Message-Id: <20230727070051.17778-16-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB4276:EE_
X-MS-Office365-Filtering-Correlation-Id: c7259d54-83dd-4c10-6941-08db8e6f4ccf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bjPs/eMftmPLsFRe9b5X0riBeCsEFxa896+SCuzFu/UpzqtkEjSDBDFW0UI6yCT9+vz4KCj+VzrkbQAL0fgSeQ7MAEhI87Ukiq4oGxrVqgyCKZ/NvGG8jUsJwUHgkVxv50UTUkRf67SwuZrX+wEUrCjrqS4Ps4Lx5ikKkmj6Qt6iaI0+J/k7Lsl0qTqtrNpuTJGkKsA8+z+TdA1C+bxipWI4Ynkr3sU4LO644Yj/ukV+p1DdMSvd5dQc6DpJLa7IMiGGPLaCqIVA3F2AoNzjZNdmNbxRPElrnbKcNbL/QgQYHB8+TSFkHvMZDrDs2z2PYZexXa1GexSyV9cBXM9yt3iCYHPSPvLzGT3ukPm9N0KX4Du87mJmuUwZ8Njr9q/uZa3PDHkaAgi9/s6I6F1W1mJc73EBb0XP6pD2ARmzgcCyY0A4R62jDY1EEbREzb25N7qPvno4Ms0ftTkXm+Z6sPanaLsqGPsWI0/IAaMK3pPiv1tk0bkEWJflidozfHPL+qZoU9LerLyUPt07LsN56uDqGS4+oBfqWT5fPgy3jnJC/Nsfl0BxqjEJwj7CyGs5/uUCCM6IrMVw8LJqBinjpkri/ljdDt4jLA+WAwOWnSFJS03+ZN61v4QyqBWoFUJM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(451199021)(6512007)(6666004)(6486002)(52116002)(66946007)(66556008)(6916009)(4326008)(316002)(54906003)(66476007)(478600001)(38100700002)(83380400001)(38350700002)(26005)(186003)(6506007)(1076003)(2616005)(36756003)(2906002)(8936002)(8676002)(5660300002)(86362001)(4744005)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGRYU1dvYUR6bFlKL2dXdHI4VWwvcFBxSGNUWGxQTTNFYTA5amNpVUs2dzdo?=
 =?utf-8?B?MEljK0JtQkRhQ050Z3R4YXFKM1pzR2NMWWE2enVoY1BNaXkzZjVWRXZXUW0w?=
 =?utf-8?B?b0JlVFNZM3doWnQydEZaZ2ZFOFgvUUtUZjJ4YUVHRFd6MHZLQmR6ck1QVDh3?=
 =?utf-8?B?VEQxNjc4Yno2WDFCUUF6RW1Ma1ZYdEJEcityRWc1Y0JUaEdlTEtOaTl0Z3N5?=
 =?utf-8?B?ejU0a3E5ODE3UXBkSDZMb2ZFN3hzaVArMWJuOFg1cE5jRWQxYm5aWkd6NXdY?=
 =?utf-8?B?WEZCcmFSaVdBSXVxbTg3NzRwWFFFVG95ZGtXVUhjSEF1MzBING8ram9veEM4?=
 =?utf-8?B?VEhzSEJ0TFhKNUVvdEF5cDNWNGFTWGdLYTNFdlNtQllYNitINGRicE9hODRG?=
 =?utf-8?B?TlVRVlZHbWowV0x0dTZUSE5YaTlmTlFlRmV0ZElMRHpabld5cW9xM216MjJy?=
 =?utf-8?B?czRQeTEySXVBQkxIU0wwK2lOdmQ2eGpaYUhBcE9UeGRTN3U3bTc0eXZway9r?=
 =?utf-8?B?QkNwd1A1eHQreFZSZnVpUjhZQVpQSjZIUVZHTUh3ZzBrMmM5YjI5b1pTajcy?=
 =?utf-8?B?Qm1DQUNVMDRRNHYzY1FDcVFtV1lUR1ZBa0FpSDByNVZhTGlRTVhlaSt0RmNO?=
 =?utf-8?B?UnJ3ODM0U05hcW5vbHN2NzQrSnJUOHZjRXNMSnpXSXErVnF0dWk4M3ZLR2wz?=
 =?utf-8?B?dUw3K0VBSXQyL3VlazJTc0JjVFR0cyswckpUK1JoTXo4Si9PNmV3NlFtUFdO?=
 =?utf-8?B?Z2VGT1d3bnRycUhTNWNFNmNGaExaMFV3OXdOUWJNMFZIUG9KSUF5Yk9WYXcv?=
 =?utf-8?B?VDJSWW92dlVnekJPeUtrR0J0ZkpPbk9RT2xGQStuWkk1Q3VUdnJTajd6NWhY?=
 =?utf-8?B?anNMeDVMcFpXcWcyOXN3UGJzVEpRRy9RVlZkRGJBU2l4SEVTdEVkQ0pzYnps?=
 =?utf-8?B?aHp3MlhWVTVDbHpOOGorRS9ycmlmSmIxSmcxMlR5WklxbnlENG5La2tmVlZH?=
 =?utf-8?B?cm5rWklBdStBemVDWjVnYjVKNkMvRVVLMkdkbTBueTdReU9lTDRORU9xQlJp?=
 =?utf-8?B?Q20yRXU0VHBvYVl1ekZoc0U5NDFjSWc5OEloUmQ3aUZvb0M1VU0zeVZhTnhI?=
 =?utf-8?B?cVEzMUNRaTJqcmlvMXkyMzg1UzBvdTQ3ZlE4NW5YNUJDYy9Cd0lJN1lKazZL?=
 =?utf-8?B?WXBTTnlUNHRpNUlNaGVlQ3JWdnBWWkQ2MGFseEI5dU0xS25zY0xsYzNYcGtE?=
 =?utf-8?B?RUx6aHJDVDYrM2lUZFBsMGlCNktKNm5PbGRHSUJzcmtOTGQ1V285dThPVXBT?=
 =?utf-8?B?Ull4cDlmUGd1eUllci9URVZZa0xwVTVDRHMvZUNGcS9INHYrcE1nV29SdHc2?=
 =?utf-8?B?ZHlxL3dPamU1VnROMEpoVlVyWW04ZmxBMnlhNzcrcXY3Wm43a3JQdmhBZkZr?=
 =?utf-8?B?dlBTVzBieTRIdDJRUjQ0cUtxaVdwQlczVm5FUkNPRUhnOTdpY0hhTlowNW1W?=
 =?utf-8?B?Tm00Y3F6RDRFdmpuTjdFRE4zdG1OYWI3SkNvaTNJbGY2MXhVVytjd3lRWWVK?=
 =?utf-8?B?VFdlU1VleFBkUnlxazJkZDlxSTZyRjdGM3E4T09qMGVJYWNrK2xCMzFmVVpX?=
 =?utf-8?B?MmtDUTI0VGFpUmJvU05YNEhNQ0dMZTVzTzBEdFhzejhlU0dxK1pXdW92NHdQ?=
 =?utf-8?B?Vk1MTWRiWUZpRDl3RWpiN2hRdE1XWXloMWoxYVJpK3Bld1lQYktkWlFsN0dJ?=
 =?utf-8?B?UkE1Ykw1eHRnU1B2Z01oUmxPelpJSUtkTHJ1Rmk0OXNDL2JuUkwrT3lCeWNQ?=
 =?utf-8?B?VU1wWjgraHYyTkFiZVdhM1VzeFZYa1FZcGRZbndyTFNPd1ZLeTd4WkRpclpm?=
 =?utf-8?B?ZXMyZDBMN05RSmRyM1JCZmFqZWJkNTJYRlUrdnNMNUNkZEJGN0dXNE5GbEwz?=
 =?utf-8?B?S09mdHBCOW5wL0NaSHFnK1I1cXc5UFVPWVZqRTZmc0poUEdVR1grSXNzSXVu?=
 =?utf-8?B?Umd5cTBsOUJjVFlMenFNYTI2TmJrSmVmK3NmTll1T0pZOGY5QWRYd2s4c2gz?=
 =?utf-8?B?eHpBQWpxR2VhdHg4c2JSQkdpQ2ppZEkwYXRxdnk4L25ma2VzS1d2Y0hRV29r?=
 =?utf-8?Q?xGZ/ZAT95UKra7qxU94CP5RC5?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7259d54-83dd-4c10-6941-08db8e6f4ccf
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:01:28.6381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KKfHT+FjtTmjdswbMF4cXnEKhzoOYhaIqZdJM2OnpBjq3wTQ9e8bnEu0SDP+Pw/zVeRw4LtzQd6dBX61hhbFqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4276
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtsx_pci_sdmmc_drv_remove() is only called for a device after
rtsx_pci_sdmmc_drv_probe() returned 0. In that case platform_set_drvdata()
was called with a non-NULL value and so platform_get_drvdata()
won't return NULL.

Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/mmc/host/rtsx_pci_sdmmc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
index 8098726dcc0b..062d07c2ae5e 100644
--- a/drivers/mmc/host/rtsx_pci_sdmmc.c
+++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
@@ -1529,9 +1529,6 @@ static int rtsx_pci_sdmmc_drv_remove(struct platform_device *pdev)
 	struct rtsx_pcr *pcr;
 	struct mmc_host *mmc;
 
-	if (!host)
-		return 0;
-
 	pcr = host->pcr;
 	pcr->slots[RTSX_SD_CARD].p_dev = NULL;
 	pcr->slots[RTSX_SD_CARD].card_event = NULL;
-- 
2.39.0

