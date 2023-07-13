Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20659751AE8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234084AbjGMIKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233867AbjGMIJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:09:48 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2115.outbound.protection.outlook.com [40.107.215.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340972721;
        Thu, 13 Jul 2023 01:08:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fGVuLTUn0ownsdQyHOjPsgowjkZSR1ANaHjS6+z5F+v6n0bNRSmONdWF4MXGWwtggbbsBNQStF9dNRb9LcjFgvCikHIczq+rsYJd9MPDm7FYRHI7p4JvzUDmJEuIu9isP8G7xpdJP0akwNEOy6rdNXanJFUrGJIaI9PofUHK6mhparro93efr20Cnm/71peWsqefOgoSo7JNwrtJXGK5rFkV5nnf5FYBmeJ2E/6YOru0qQNQyKZCL4FmqwCgnQOV5ZodHasAKfDzXSIQke9d3E684TIXq9ysNFUZHrVjiN+r6zPNb3jUJdT0h7x9V03LAin2sVk9DmlJmlXYVGvYVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jyTP5vRGutG7Y29doT3s+cSx+CTcgmzp1ilG+kWWrOo=;
 b=V5S6ceETPn6oS9h+VpyWXKkO/SS7ORhRkTDQlBPEKbM2yl9cjBJHiP8fRXgnBR7bTVGZRVYP6SJ6B42kd1hSBHyBycspC7DLEzbD1GW0QZh7/cQLmJ0+x/LLJEyE8W8FDw2frAgw9HVSqSjQM/KRNskxHv7P75CkUqhXHe5Bp8fpFjDxEPjCkYZn7XO4fASktVsync/1nmRsTO43VSzBfd4exrVt2SvbmIk/xnEMXdQ5u0buc9pW6ygCZNMZKvgHdSvq0eGxNTglvqSZspqkOUk/TFAQhHcyCcNJyPSy0VaZcYQHooT5ZLlf3+BMrafzkcngvOk1mjYWjQT71ef2Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jyTP5vRGutG7Y29doT3s+cSx+CTcgmzp1ilG+kWWrOo=;
 b=EkgPW18VkRj/nKeseAy0ddqzvrW6pUy61acDsfBrEFv5QVmMHleyKLLN7orL2lhDw3S3RudaElkXl7xhIySZUx6SFga8gVhqEGS+tB9/J1BM2IglmLdupEr5AyMtvGJocG75/51sE+LQ1wALnWXSiZHCeoEGxdiEJmmcE7pCBir5gljNBzwYb/E22lFVH0eaELQo7ncliHs1Z4P6h9InryuoAf2uF+RwQ70jdhO0ZTGR603e0pAGoO/x71QIuJCG8EdFwgZm3rXjKl6Y6FgOlWQElUuY7qMW7o8no0HCsFvFXcaRG9jph4GE9nJT/aJrabZRgZqI6PPDNgQUew3s4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4371.apcprd06.prod.outlook.com (2603:1096:820:74::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Thu, 13 Jul
 2023 08:08:30 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 08:08:30 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/58] mmc: cb710: Convert to platform remove callback returning void
Date:   Thu, 13 Jul 2023 16:07:15 +0800
Message-Id: <20230713080807.69999-6-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230713080807.69999-1-frank.li@vivo.com>
References: <20230713080807.69999-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0091.apcprd02.prod.outlook.com
 (2603:1096:4:90::31) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB4371:EE_
X-MS-Office365-Filtering-Correlation-Id: 0eeeb01b-b0d2-4cc3-9d6c-08db83785837
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xPBTQu8MUPAvA33G1u36yAROL5kJWpxv5sXgMLo2t/oSj6+O7WM5a4EQPgl5zIzpeWU62PmMU6wX1XJfoCeHRK53cNy6dXyLjbhez68Z+D5MuX+tNTCtQCdBtgZfw+LiFJt6pLdk3F9GdsQLijiJXS1V8llayIjPngFXgk7mEQRXytUVkb/w53ScwlSeLyXODmrDpIRD0sC34pwIAcxTYXIz74NJB5TikqIOxNGbB84Z/j7aLRPVrVWFKQIKXp6RMEwWM3DdppGlsowMQykJ5RRAcJo4+RfxjBnx5lvMgMJJA41AEAndZuZBkgyXUdVroCJDlEVn+2hUqDz3yR3AGdDPd/S9NE0qeKJ3wFghYaw8Mosien17nXmL0p8iDOZG82U6QPb5wOGYXSWHNQE6U38c4sT/5xKDXkdIKTjg/gfmNY7p/zD8sUr2axTAWsVPr0cU9DiXDRrn+AKpQSSQ+vapkTUpKm3myuRgu+0J6XRR4nEugw8W0R0Dpx1SIINQfY7q1A3VTmvvu3ebiiLmAM4ZljmZh4C28Ur1gjaudM9Sd7KNAptS5DOuCad0cOIt1mAffUhI7jlrJNfxDElmYtr3I4BpsQWQqNQP9i9v8PJp9s7v4zS+NMaUxZ/eugYTtCW0ufKoeARTRsuibS4j5vae9OmdEMsl74Dwty6zeNk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199021)(38350700002)(38100700002)(478600001)(4326008)(6666004)(86362001)(52116002)(110136005)(6486002)(54906003)(66476007)(66556008)(66946007)(316002)(6512007)(41300700001)(83380400001)(186003)(66574015)(2616005)(2906002)(36756003)(8936002)(8676002)(26005)(5660300002)(6506007)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODIxNlNkNHB3anc4Nno1Nm9YUFBoUXMxTFViWHFHZXdnN1RMN1BOVmZMeDFS?=
 =?utf-8?B?RkR4SW1SMk5EY1pIVXJqWDZBcDQ5QW4zVW4rQ0RWZ3oybElZS2YyaEx6ME91?=
 =?utf-8?B?U1dQOGZaWFFGRC83amhjZlRMcDNlVzNLTGJud1BGaXh2S3lTWDZKcERRT1Y2?=
 =?utf-8?B?V01nUy9Jdk1WQzNxcDlkSDUzN0hmME5EUE9nS09MQ3IwUnNGeDZ2OEpHWitO?=
 =?utf-8?B?MU9uNE01UU04bFJTeE1wWHMvN3dUby8xRjI2TWIrRXY3VG1HbEpzdGJGZ2NC?=
 =?utf-8?B?ZFdBcE5ZL2RyemR1QzV5UUFobjRHNDRWc0ZySFRDdUxzWENpOEdKbFVHejZB?=
 =?utf-8?B?MVk1Vm9JVW5rcG5lMHV2ZzFxWTR4RlFBWFlKRUtpRXhUa1lvMnV3aFBxaUNq?=
 =?utf-8?B?L2FDaDBPVmRWRUJhYWE0NmpJZWVzZVN2NXozZGwzWlRtQ0lha3paNE1YL2Vs?=
 =?utf-8?B?clNBdmlLRzZ0c2VXTCtXY1RRcU0vS3R2eFFaNUZGT083dTVJOHNiSEZuV3R3?=
 =?utf-8?B?V0VIVTlDSStzNnRlZjRWcUt0S0hiVUh2NlU1b0pZMFJOL3B2TmZPRFJhU2Vu?=
 =?utf-8?B?eW51NE1CSTYrem9aYTZUVHVPU3dCK3U1SElKKzRJeG9IY0tjS01XTU10Zkx6?=
 =?utf-8?B?UmZlOTNsMzdKbTR4M0kvVUVnb21BRStiK09KblZzZ1g5bkt1VEM0bzRXNXNS?=
 =?utf-8?B?ek0yY0lBdTdveWZiang5VEk0dHp0WUlYeU1YSFFGaWhpM1o4MnkwRVR3SUxW?=
 =?utf-8?B?K080Uit1NncyYUx6THg0RE4zSVd5bUt4QUZENERuc1lpemRMOXhNTkhZdmNN?=
 =?utf-8?B?Tnk0M0FwcTBzTUlYc0llcGZEK0ViZ0xXdjJNenZMRFZ4b2tuU1ZvdjhYM0x1?=
 =?utf-8?B?YmlTaWpVNmNkaUpjNy8rbjI3QXdIRlZKNGNneGZOWGxNTnhjczVhS0x5dHg2?=
 =?utf-8?B?VHhJV2pkeHA0WW1uUmxhUGt5OEJjNWFJMEQwN0R4ZnJZYVQ4Z0RIRFpvNVZz?=
 =?utf-8?B?aUpGTHlMWHRQSy85VmhneGJ0czgrV1p1U1YrZ2JPang0eitSbzllR2hkeHhk?=
 =?utf-8?B?SVk5aThiUmYvNnhva1FncVhISXhGZHpESmYxZlVtYWo1K1htUTJ6RVpBUHVU?=
 =?utf-8?B?bGQwTlJ6OCsxTDRhTTd1RUJkRDJEaGUwS001dHpaUWV5RE02d2Y2OXErbjhJ?=
 =?utf-8?B?Z3BVZVRub2U4Zzc1ODJlMHltVm5YRGtrVFU4cFZObFpYT1RQYXFySkFrd21W?=
 =?utf-8?B?cTlBNHNYcG1DRnpPdkhIWGpqay8rUURpRk5LUzdudFJVbjJOMVI3NlloZXF4?=
 =?utf-8?B?ZkZUT1BUY1JuQVZtR3ZtcEU3REJBNFR2cWk5TDlrV2RjZnBtSXZvNUI5MkNw?=
 =?utf-8?B?TWhydmJYVjd4bDUrVkhCNXc3NC82aHZuZm5VVVI0V3V5aXV0aWxTK2diOGs4?=
 =?utf-8?B?eWJMdmgwZEQ1bzk2MTBTdDFqbTFwLzQ2aGF1NEQ4QWgzYW5VbzdOa1pXYkxa?=
 =?utf-8?B?b0srN3Fjck44T2NVYVR6cmZaQzJCeFJIeDloSXlzMU5ldDQ1VlE2TXp6RTE5?=
 =?utf-8?B?L3RveW5lNi9mUzQ3Q0ZqWnNWaTFsVm01THpvZ05yMzRVUmEzMWU4THlJa2tY?=
 =?utf-8?B?eUJkRVhiREJRSkdqdlY3WEZuU05qRExISWQrdTF4TEg1aGh0VFhQaDViVkN0?=
 =?utf-8?B?VkNndmF1cGtEUUZWNjBKb3ZiejNDZmppaXRNK2tDYzk5OVdXZC9td25Hakpp?=
 =?utf-8?B?RWs5RDVDVlh1TDIxQmxLaTBvS3B3NzFXZ2VxWVpNT0F6SFFyYmYxcnFGNVI2?=
 =?utf-8?B?WnM5ei84TEI2SHVNeUZMMjQvK094M1BFTE03aUlEWHpmTDVvcEs5UUxmYWRy?=
 =?utf-8?B?SUQwcklyODBOcTB3eFN1d3EvbVNVaEk5UnRSdENJc0JCNDltQ2xrOVNlR2xi?=
 =?utf-8?B?L2ZoeGg5YW91azQ2aVUyM2MwUzFxVUhEM2FRbTlia1hTNnNnMlVYSWFFZ25k?=
 =?utf-8?B?czhzRTc4djF3MUhZZEN6dEQ4ZU4wSGlWT3M4T3pMYklOeUc3cTJWVmNiSVkr?=
 =?utf-8?B?VXV6MXpDelFtTTB5MytuRllMVVUyVWd3RjFjZ0Q3cGpvSHRGa1ExbjB6MDFB?=
 =?utf-8?Q?CkY/1HRljrGSr2q4sBpdQcFYz?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eeeb01b-b0d2-4cc3-9d6c-08db83785837
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:08:30.3846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jEDGYdG1yFxPjf8Qvz8ejMo0iGuyqu0lMwnwm81DOsDC5SpGEwbXzHeCaEJPjxKEbjfgXnO30cxVnwMdDvDspQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4371
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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
 drivers/mmc/host/cb710-mmc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/cb710-mmc.c b/drivers/mmc/host/cb710-mmc.c
index 6d623b2681c3..0aec33b88bef 100644
--- a/drivers/mmc/host/cb710-mmc.c
+++ b/drivers/mmc/host/cb710-mmc.c
@@ -745,7 +745,7 @@ static int cb710_mmc_init(struct platform_device *pdev)
 	return err;
 }
 
-static int cb710_mmc_exit(struct platform_device *pdev)
+static void cb710_mmc_exit(struct platform_device *pdev)
 {
 	struct cb710_slot *slot = cb710_pdev_to_slot(pdev);
 	struct mmc_host *mmc = cb710_slot_to_mmc(slot);
@@ -766,13 +766,12 @@ static int cb710_mmc_exit(struct platform_device *pdev)
 	tasklet_kill(&reader->finish_req_tasklet);
 
 	mmc_free_host(mmc);
-	return 0;
 }
 
 static struct platform_driver cb710_mmc_driver = {
 	.driver.name = "cb710-mmc",
 	.probe = cb710_mmc_init,
-	.remove = cb710_mmc_exit,
+	.remove_new = cb710_mmc_exit,
 #ifdef CONFIG_PM
 	.suspend = cb710_mmc_suspend,
 	.resume = cb710_mmc_resume,
-- 
2.39.0

