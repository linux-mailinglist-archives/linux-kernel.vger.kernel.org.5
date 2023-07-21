Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6565E75C3AA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbjGUJvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbjGUJu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:50:26 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2103.outbound.protection.outlook.com [40.107.215.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C92D422F;
        Fri, 21 Jul 2023 02:49:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YxRsoKYW3nNSXUTcM/j5I+PG5P+DRLcNK411qzLRjqo0Y+dsN/ko7uAZenqFhPZrHvfgYXNOaQesqvl7Zjv+4hb0gKSsyNG4OJ2MJOggGXwBkC+PqXVmUovUc5YMKOS1gNjlhhhbsz6TZmOEurScHULpGNGvBXB0ABsv7Xe+Rnc35dy0L9qE7xkR0mya7H3G+ARZudLex69TYLgNfTpo6QLgFsCpHYBrdZz//IN04iuMeb4hDVxxyii4+FGL0GGSq1gll7NWAp4mUcogCgRWekGACUncPpsif0OcnMQCFi7/JEx+W0gCs98i4WxcvloRRMggVwh9v3vxqyPljP49zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eHS28mIWTpLDBdxBKQHMC8i2TLY/+VTjWtqoEmhSPRU=;
 b=jCSG6QiL9blOnMDXr5v2mdl8tFsHfWVov+vl3KEkUdZRPzuJ4rvmZvSDrvb8yyjp/x7epiGKE6ZnWEyxtCIWZUvSFONEvz9JQCHQhuYWkgdKXHAF4eU4U7mGp6hmUDIVHFvRZ8XCXgFznQ+IACrytpZTIrJry0rkEtWIVv3RMXoqfX57Y+OEAFdCkhmir7c1Rs61iX47XMlXKkKewIkxIpkhmnPLEwuonXESJszCjcI1SB4xaXViE51zc4/nROqF85o4j/7t68ntPyOUFwnweA88CzKruOCTqLXWGT/ce5gEu6tsvxsmybkj8SONIPEHArdOSblqvTmdi/uZ8Ie9KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eHS28mIWTpLDBdxBKQHMC8i2TLY/+VTjWtqoEmhSPRU=;
 b=IbkHq7BfobddcTlHXGVM/i+yMmYSr+nP+td3bEIQh4g0LsSFetF5m+R5X0sL4uuxgAc1LYHz9RG5/MHZHmUILDVeUD3rH4Vh45/PfV4L1r+BUNDrxl8JPxJSva9pDd/4EbJbkdHbam40O6cSChny2GF9wzab6QG4g7c03QUwztBcxmTSOuth86hT11rIXlPWbi1ihoZqTgOl+jAX4H7D9naxWHqXd9uHpR2PrMjKAsyjfDA6Uir3kiLooFa0qvlxfwzZYJK/hLHjp5riG00Irf9eUTsIHISZZTSTCuFV2vZ4t/D+AhRo0pe1I+rDwni72tR/PbxPlsv564h3XdyeHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB6311.apcprd06.prod.outlook.com (2603:1096:101:13a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Fri, 21 Jul
 2023 09:47:48 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6588.031; Fri, 21 Jul 2023
 09:47:48 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 21/22] thermal/drivers/uniphier: convert to use devm_request*_irq_probe()
Date:   Fri, 21 Jul 2023 17:46:40 +0800
Message-Id: <20230721094641.77189-21-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230721094641.77189-1-frank.li@vivo.com>
References: <20230721094641.77189-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0031.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::11) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB6311:EE_
X-MS-Office365-Filtering-Correlation-Id: dbaeeaca-81d0-4696-f6ba-08db89cf8ab0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b9hKown3F6RSZNmgshSHLy5Z0ABtWj82TsNLfB+Coyz/d5NzSDIEAUlXJs1bIYPhustjlkrVPlWPOSAwUW5gnjxjaIIotLASkhCbV7HetWmLo66Fx/nf/OBtm5BTGNiwL9t2MwDoj8j3Pfab4ZhabL36Rt3BAIn35S0lMY/rjIHZdIEz1OCAs2OZX/ctL+Tdno0IJK8tPv7DclYYqlLCpSgyZT/6QZJ+lBJ1mpF7sTP1DPolerGpvYSs0O78ps9X0eQUlYrfKxHu2EnuakHZvA9SWYfU4EdMElCeMqP46x3OUFdX1OMAvKOsQl5iud+rifiqxIFR07fgjn8oWvrFwJba6agVQuQOtx+J2+n1Y913kBVkQdwb07zzipLIR7/0s3ueOrvH6ghRtLuIunQOtAdX3kQpxbOY72JBaM3F3/H6z3QdSmziqYnhjB5kIGGnY7C4pqqng0RMZPGqZvVcbzMPvlQj2/1bNl1DhNWeYdBuV3ErPOlu+HACWlGvVwxBjxCWRvstpaFfOAIubssl+PBX2tEnWWT15POOjD1nVqFl6G3pwmUiSg8NKqpMCfM7u37i6uoZ84MydNnKXYPLvvj3VXcUsHJdkfnZr5xYMNKvdEoOBIJZsdi2AEYZBFPm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(451199021)(54906003)(52116002)(6486002)(6666004)(478600001)(110136005)(6512007)(186003)(6506007)(1076003)(26005)(2906002)(41300700001)(316002)(4326008)(7416002)(5660300002)(66476007)(8676002)(2616005)(66946007)(8936002)(66556008)(38100700002)(38350700002)(36756003)(86362001)(66574015)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1hmaGczNWcvb1N0OUpyeXduNHEvcE1DRmdwN0tjdlBOYnl4YzByUVVDS1Y1?=
 =?utf-8?B?UEJjS013UTVXb09Vb3dRVXFKcjdpRHVQV2lTSkJPVWNUM0E0bkQwVXQza2ZG?=
 =?utf-8?B?ZUpsSHVldzltdjJBTlBWT2diWmxZWjg2OFdZcW5BWUY2c3VBWkl1M3c4Y3lV?=
 =?utf-8?B?NE9VRXhCb1padEZZbWlIdmM0UE1qOFhBcFBKdEZBQjdyenhlTkVFeERrM2VE?=
 =?utf-8?B?dkxFUkQxeG9zNnpveWZQMFBzUUx0UEFlOFNENUdRVFhmc2IxaEJDZGdKNUEz?=
 =?utf-8?B?ZTN3N0F2R3ZWcVBMUFpGYXFrZFpDYWNLUDdPbXA3MS9aQmlqTTdNdmhvZ1ZD?=
 =?utf-8?B?dzJYTjhUNld1TmU2Smh0eHZWcitFSElZWjBTWld5SEtBTW56OW8xNyt3SEQr?=
 =?utf-8?B?RUdmU3RMSUpUQXFDc3pNVEFteFlGS2w4czh4NlBndGU0WG1mSHVkc3c3TytU?=
 =?utf-8?B?bEJQdUdvUHFjSlVBdmJOVFA0SHRHWGw0NkxPWktiQzRBeXZSUzNMUUd2M1RT?=
 =?utf-8?B?WDVPQjRrYXNCekI1Z2JyZkhUd2RuT3I3MUdrSG1yeEZIUVRuZ1VYbU5BRm56?=
 =?utf-8?B?a2VpTXB6WUlGdWZ3SUZhOGw1N1JJc29NeEluTFV5UzlJM2xONm1ibGpOZ2xH?=
 =?utf-8?B?VUtSZFhROXZiaE9aTFVLRlFyR0w1bzJYSFJFTmFkSmgvcU05ZVlyWUNBdjRa?=
 =?utf-8?B?SXltU3dsSjUvWUwyQ3MwelFheURGNHd6MFRvTFFLLzFNSFF2MUJKajQxTVQ0?=
 =?utf-8?B?aGdQUUJTNUVmYlk4NDliaEY0ZFpoVXBJTm92TVV2MkhIOXhaRlJJbm84djF3?=
 =?utf-8?B?QUEycW52dWJCbEdYUFgyZ1RiV3FpWkdCTVgvNVJWemdhOXZHMllieE9MVzQ4?=
 =?utf-8?B?Y3ExRUo3dk1nNVRINCsxdnFaOEFXdVR3ZG5yTkt2WHRmNHJBTFBTVFlDY2Zx?=
 =?utf-8?B?RWMrV1orQjRvWDcrZ0dBTDNMbUp4OXMzUlRwK3hxTW0wL1hFdkdoZEpDY0pp?=
 =?utf-8?B?ZDZ1ZkhScm5YbGJqbWh2c3NmMTVvSzl1aXlqeUxzY1pNRFpGaEY5NVZMMlNW?=
 =?utf-8?B?dGxrWTJualhnOGZDaEgwcVhJNmoyTHhaNlY0bGlpcW9jNFIwcHN6Y2RSRE9n?=
 =?utf-8?B?WjJJRnlqQ2dXUTBENmRYbm1JOGs0bVdtUkpiNEpsWjl4TTU4WTdCU0RKbk9M?=
 =?utf-8?B?bnAvc09iVzlYekt5a2pueGRaQVNseUFpaFJqTjUwaE1JekgwWG9oU1ZleWZZ?=
 =?utf-8?B?WW9CbHgvTXlJdUZDNTdRRk81YXlGMytjK0xhNW1xK3NENHNsZ1lmOFNxUkVj?=
 =?utf-8?B?QWlGRFE2Q1BJbTRiMjhpeTV3SWd5YndoQlQvd0hsMTJlWTk5T3FmTjQ3Zzc5?=
 =?utf-8?B?Rnd1bG12VE1ENkRlZGxOQ2EzQ05UbU1ST1NTV0FCNXFVSWdBVWpkSlluSU1Y?=
 =?utf-8?B?emRVRVFwVUpFNnpsNkc2YmtIZVo3ZWpYMEZIbzR2Wi8wMFkwNDNiUzlzSnlW?=
 =?utf-8?B?MTZkaEtvWmR1em5ENkg3ZndIQ2cybGE5ZUxRMEpxOTBTSVZIWGh0OFVCWG1m?=
 =?utf-8?B?Snh2UXdFYk0xUldDNHVPL1ZENVE3YmFRMlJZQWs2eFloQXE3ckxqYjNMWWxJ?=
 =?utf-8?B?TlAvQWZNSW9hdTZJNU10UWhLUnNnM3hOYkFpOEVFR1VrYjlYbURib3lUQmNR?=
 =?utf-8?B?dmZySE1saGY1bzNROUtJeFNTdkJPaHA1cE9RVkJ1byt3Z29OdkE3VmYwMlp3?=
 =?utf-8?B?U0I4MzFRTVR4eUNTSzJUTzVCbkNWVm9ReWRmMy9MNXVmYlRVRThaajFWYXRs?=
 =?utf-8?B?dThhdHp2blJqNkhmL1RSUnA3M09sQTlOTk5HZlczNVhPU0VoU2JWeHRTM1lm?=
 =?utf-8?B?dnZMQzR5c3ZZVjR3YkZBZTRHWDZwT1hKN2FadU1lME9xcHlNb0l4ajd0RmFJ?=
 =?utf-8?B?OUpNYmFKYnlhMTg4aWwxNHZNU0ZTYk9zNjNlTWpObUtOSkhPb3RqYmNiMjF2?=
 =?utf-8?B?dDF6UDRoZzlQdFB1THJib0h6Zy9IY0RFK0p0TVNxbHpiTkNPMmpORlpyTDQv?=
 =?utf-8?B?Zk81SzVnYVdHb3hvbWMwaTFLanE4QStSalpVWE9HOFlDOVh3ZkFVbHpHVEUw?=
 =?utf-8?Q?xYlvN6nNfJpNMy5a5nwN48TYE?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbaeeaca-81d0-4696-f6ba-08db89cf8ab0
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 09:47:48.2912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bh0wLh0RJiWX4xyqZblVpaFfaJMAYdj7hRaUOEBc/6amhXXzRY1vE5rhyDct3LmUaTNDQz7J0bT+8Kn1D2Ro/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6311
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are more than 700 calls to devm_request_threaded_irq method and
more than 1000 calls to devm_request_irq method. Most drivers only
request one interrupt resource, and these error messages are basically
the same. If error messages are printed everywhere, more than 2000 lines
of code can be saved by removing the msg in the driver.

And tglx point out that:

  If we actually look at the call sites of
  devm_request_threaded_irq() then the vast majority of them print more or
  less lousy error messages. A quick grep/sed/awk/sort/uniq revealed

     519 messages total (there are probably more)

     352 unique messages

     323 unique messages after lower casing

         Those 323 are mostly just variants of the same patterns with
         slight modifications in formatting and information provided.

     186 of these messages do not deliver any useful information,
         e.g. "no irq", "

     The most useful one of all is: "could request wakeup irq: %d"

  So there is certainly an argument to be made that this particular
  function should print a well formatted and informative error message.

  It's not a general allocator like kmalloc(). It's specialized and in the
  vast majority of cases failing to request the interrupt causes the
  device probe to fail. So having proper and consistent information why
  the device cannot be used _is_ useful.

So convert to use devm_request*_irq_probe() API, which ensure that all
error handling branches print error information.

In this way, when this function fails, the upper-layer functions can
directly return an error code without missing debugging information.
Otherwise, the error message will be printed redundantly or missing.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: AngeloGioacchino Del Regno  <angelogioacchino.delregno@collabora.com>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/thermal/uniphier_thermal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/uniphier_thermal.c b/drivers/thermal/uniphier_thermal.c
index aef6119cc004..34d8eb2138d3 100644
--- a/drivers/thermal/uniphier_thermal.c
+++ b/drivers/thermal/uniphier_thermal.c
@@ -278,9 +278,9 @@ static int uniphier_tm_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = devm_request_threaded_irq(dev, irq, uniphier_tm_alarm_irq,
-					uniphier_tm_alarm_irq_thread,
-					0, "thermal", tdev);
+	ret = devm_request_threaded_irq_probe(dev, irq, uniphier_tm_alarm_irq,
+					      uniphier_tm_alarm_irq_thread,
+					      0, "thermal", tdev, NULL);
 	if (ret)
 		return ret;
 
-- 
2.39.0

