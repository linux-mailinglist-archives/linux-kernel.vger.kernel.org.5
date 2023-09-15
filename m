Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D2E7A179A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 09:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbjIOHlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 03:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbjIOHlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 03:41:04 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2083.outbound.protection.outlook.com [40.92.53.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C539C98;
        Fri, 15 Sep 2023 00:40:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jdArXd6q6lw8Qhrm5H2bLT/n9pwOZXubftGY/PWpzZX7m8rdNqGIx2txxUVGDbXf/Clb+/+kgJyHHuolfkZhWroJBamJyan4PeePL9r0PSpI4PYrb/6FKFeb7SvmBNsJy27FkK1YfnQCoOqHBV0LgC3JUDGODTCcAMJaegpHuHoBeL6MzHh+ZzI6Hb2yZYAG1E+7WB0f1hkfRUl/wphCuz3NHnTaAKFekyHj30sFqa3ku8StzV0ooELyh0RzRIAo6NGOcXdofA9JRCKAELiba7UCeReMxoobCz1yHdq5NC09HwX3rPTX02VqXWLJteihJlwnFUVm/w4hiw4PAXQN5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VfUwaEPrH5bv/vcfV52/7kv7I2WRMV0wP15R/xEDdfk=;
 b=B0AzouaZ7ekYnMTJ7wSk1M4ywbgkd/f5tSEaJVeu3gJR8X/Vk1woDChJPq6loWIxNtEgkJPglfsG79fdALsqWZuEeVlQwmrrfEsrGXAb3QpiXtX4vD/SBsJIB5IF7gsI4UVQsTlqIYfixpEANOghItE3hp7RTqzEzOg/vVxdLR36iNYofmfQDu9N4IhKlwNGXTWS111QYxaFKA7kdf4uqd5iZI0PhYmQx2kM65iTA4HdDQVnk9JIPc/48QYhaD74gA+sgnON1JbLVAcHHmDsKw+Jcf47SYlg0Eiw2If8byA0GRcsDJhuWvch5MBchTh+N+AfUdGHBmdTugVXa3NWrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VfUwaEPrH5bv/vcfV52/7kv7I2WRMV0wP15R/xEDdfk=;
 b=WYSLQbuZ/6BVTnMnR8bEyQ5tBLuusJUvZ8kFVRCbCOug3qXvpnRfOxJcTAE9cp+9jMAwjVtlwqakP7opyz2B06W+vY0WLVTtmsfdIgcUcxYeQYtIuKcQc7WnkZrp7OtX4nHMbnJXVTPnBuUOnVce2KqBPAnv93lorczmf3lw1MyQiv0axzw9yAbySX3LjGy9UNp2gN3tnsjYd1x+ba4aw2ZpF0F2cWwRjGLid0LkEXN6Ss8BpfVcp3ODxhJUJwC/JSXMt8KAPh+EyPYvkjELtjxZGdlQmNcXbwc4DvITZ4wxcP++EoMYv5J/Q2KYoIX+s/tPWhBOiDBtF0MVjx+6PQ==
Received: from TYSPR04MB7084.apcprd04.prod.outlook.com (2603:1096:400:47a::10)
 by SI2PR04MB4171.apcprd04.prod.outlook.com (2603:1096:4:f7::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.21; Fri, 15 Sep 2023 07:40:54 +0000
Received: from TYSPR04MB7084.apcprd04.prod.outlook.com
 ([fe80::9861:12f5:718f:8050]) by TYSPR04MB7084.apcprd04.prod.outlook.com
 ([fe80::9861:12f5:718f:8050%4]) with mapi id 15.20.6792.020; Fri, 15 Sep 2023
 07:40:54 +0000
From:   Enlin Mu <enlin.mu@outlook.com>
To:     pmladek@suse.com, rostedt@goodmis.org, john.ogness@linutronix.de,
        senozhatsky@chromium.org, keescook@chromium.org,
        tony.luck@intel.com, gpiccoli@igalia.com, enlin.mu@unisoc.com,
        enlinmu@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] printk: add cpu id information to printk() output
Date:   Fri, 15 Sep 2023 15:40:34 +0800
Message-ID: <JH0PR04MB7072A4B6946EAEEB1EB8B0BE8AF6A@JH0PR04MB7072.apcprd04.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [JUkuZs/DKQQDF6SYSSXldYPcPlMJle0B]
X-ClientProxiedBy: TYAPR01CA0200.jpnprd01.prod.outlook.com
 (2603:1096:404:29::20) To JH0PR04MB7072.apcprd04.prod.outlook.com
 (2603:1096:990:3b::7)
X-Microsoft-Original-Message-ID: <20230915074034.49278-1-enlin.mu@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYSPR04MB7084:EE_|SI2PR04MB4171:EE_
X-MS-Office365-Filtering-Correlation-Id: c29f1828-eeb5-43f6-bb2b-08dbb5bf15bd
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fmoNVx7l5tMMaVssptSp2PdUaEBqZC9hRZnMdVGpamZWv3GbHxLWmBD1C6cM246aHFWDWtogYKhCBBNpg4E397XCdj9+oQdjlniPrVcQl92z2HB0VMCgB3iqtaoO1bY2nMYebePdWKFDNHxg34izlqQmTa7qZfrX+VGg+yAIxcWSiLA3bD3xX4uom4LAGcpZziVUka9zpy/rEuUnstzSuqFgqft+8HQE0FOAXXwZI6S/wp0WVEbHb1LuzWMOrZfafcIaQ/tFUj3mdFr2QxiS3SYdVr8PF//q4B3y4Kh/EsPExYtMwkceIiqp2n95cdNxsT1jZubxPexqHsCM2aAI9KIA4/cbg0+aYcBQciVb2AnkBGRv73vOtTjJ4VJ6tK9mC7wj4DUHKZqyoYRVop+qfnEyW18hhu9Yo44B/5eF4amyXBi9PmRVf3/vh4jJ1FhaejooVHjrbLq5iCrj4ccGjYbp5nxEAS12gdqv6f4VwRxnnZkGIxNPcJO7C9UTnQi9BiTxw3iepsSzF4FLQ8KhMRcXMU56fBD68gudEF+WsdVy3CyNEsC3lVvfOFEOqJ3H
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4Nr0tEkFS2ER86IVf/0Nd2ZRy1AKgc2BjWUPuJB8e9a1SKo4jtgwpz7ihKvA?=
 =?us-ascii?Q?osurCKK22jej88p8leM1drgrDh+SSWapfeEXcYdhV66AMye2oqM2SJStns4H?=
 =?us-ascii?Q?JCYpTH2IVI3vb1YHqqas+0Tlz3bYvd1yEfM3riZ3xPdEg0VFaC3C4ZGyR0qS?=
 =?us-ascii?Q?Fo9BqFcPcYx86mvXCfJ8YZ+TfkJHk7izVvKpFVHTJorB0gjAxPf7yLl8tSvq?=
 =?us-ascii?Q?6khELTuiq2HNxMJKiWlNq0ADEBV2OTLkx+enFQKISV+ygaiuSW4bFHKvjgNC?=
 =?us-ascii?Q?AsMfqlQtKIY7Aau+HNLqDddilkZXNWjT65l2jOnIiW0bjkn249WYBJkJcia1?=
 =?us-ascii?Q?O/UCBsWWeXigWUCC/m5W4XcnIND/YegI5ATFmaxGZfuSFDIiPGkcFlix/Rub?=
 =?us-ascii?Q?sI2cKi/B/UvA2Hr8YTueN2KuKsRO7a12U1Sp76xbdo8fC72PPYmlNzBOlHuK?=
 =?us-ascii?Q?cAkFv+Zpz1Wspa4hP73seThPpRCgapOIVEeHL4wz1gmS9QdQnUNnRGsYCS63?=
 =?us-ascii?Q?qCQjoWyvtithyzKO7KFl2JLb+X8ykCNZ3oPIK1ecOSoqdYo4pbFN38r0Lf47?=
 =?us-ascii?Q?VPU4fZpZcn+dixU3WxeaObMF+UsKZdqgbZ07x35SNH3nPNFYPTNQfVCgyBeo?=
 =?us-ascii?Q?HYR+XncTDGTM83vrdLFCVXKSM7BDJDq34UM97/q16YH66tqI+0L/3Gex34ZS?=
 =?us-ascii?Q?UIUsG0zPmFH2YoZy9RgmMJ9x4f7PaPanCt3Yzo70gtYjUAA6l8kYhXcUsde9?=
 =?us-ascii?Q?lyLWOnEcI8Xlhtu4UOb0t3sKXQAh5ScLWsaYZTpw9wvQ4jxOe3/3O5PnOiYN?=
 =?us-ascii?Q?e/wro5X8IwDwqha65JwMKSzaDrXO+hhocHTvuY24k+PezE8JGgVBkC4Wuv28?=
 =?us-ascii?Q?PrRv9buiQOjhVdJT+ALnbEeutCMaQwhBI25qKb5yMRieQeAanLGM825/KOHY?=
 =?us-ascii?Q?re7kwBxH82ArZwFOO1Sojx7Td1L06bMq0pmxt+1MwNt2RivZGxUY02MrpDVF?=
 =?us-ascii?Q?FRXf3dU+I5WXOCrXbDm2FUplCjvNdI4rBZKYiBOUYQDYx9l3xt66WHY5IlOV?=
 =?us-ascii?Q?fwSM3v2YdZyEVSCtia3aYfzzcmn+lFVzqZB2O6nNSFIYqJnlgu5q18636Ve3?=
 =?us-ascii?Q?dRweCoxechy4YVuG05uNjRN7CauRGXo/latV3MqllvBCRPShX3hiIcPGpQ+m?=
 =?us-ascii?Q?66wu3ikD3FZgnCzflWvrKMRnxkIJhACx5BZXrUXRj2HW80b0qckYSnMaABSJ?=
 =?us-ascii?Q?nCEFfJbzBmRSte6ttt1O?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c29f1828-eeb5-43f6-bb2b-08dbb5bf15bd
X-MS-Exchange-CrossTenant-AuthSource: JH0PR04MB7072.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 07:40:54.2983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR04MB4171
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Enlin Mu <enlin.mu@unisoc.com>

Sometimes we want to print cpu id of printk() messages to consoles

Signed-off-by: Enlin Mu <enlin.mu@unisoc.com>
---
 include/linux/threads.h |  3 +++
 kernel/printk/printk.c  | 18 +++++++++++++-----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/include/linux/threads.h b/include/linux/threads.h
index c34173e6c5f1..6700bd9a174f 100644
--- a/include/linux/threads.h
+++ b/include/linux/threads.h
@@ -34,6 +34,9 @@
 #define PID_MAX_LIMIT (CONFIG_BASE_SMALL ? PAGE_SIZE * 8 : \
 	(sizeof(long) > 4 ? 4 * 1024 * 1024 : PID_MAX_DEFAULT))
 
+#define CPU_ID_SHIFT 23
+#define CPU_ID_MASK  0xff800000
+
 /*
  * Define a minimum number of pids per cpu.  Heuristically based
  * on original pid max of 32k for 32 cpus.  Also, increase the
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 7e0b4dd02398..f3f3ca89b251 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -629,8 +629,12 @@ static ssize_t info_print_ext_header(char *buf, size_t size,
 #ifdef CONFIG_PRINTK_CALLER
 	u32 id = info->caller_id;
 
-	snprintf(caller, sizeof(caller), ",caller=%c%u",
-		 id & 0x80000000 ? 'C' : 'T', id & ~0x80000000);
+	if (id&0x80000000)
+		snprintf(caller, sizeof(caller), ",caller=C%u",
+			id & ~0x80000000);
+	else
+		snprintf(caller, sizeof(caller), ",caller=T%uC%u",
+			id & ~CPU_ID_MASK, id >> CPU_ID_SHIFT);
 #else
 	caller[0] = '\0';
 #endif
@@ -1333,8 +1337,12 @@ static size_t print_caller(u32 id, char *buf)
 {
 	char caller[12];
 
-	snprintf(caller, sizeof(caller), "%c%u",
-		 id & 0x80000000 ? 'C' : 'T', id & ~0x80000000);
+	if (id & 0x80000000)
+		snprintf(caller, sizeof(caller), "C%u",
+			id & ~0x80000000);
+	else
+		snprintf(caller, sizeof(caller), "T%uC%u",
+			id & ~CPU_ID_MASK, id >> CPU_ID_SHIFT);
 	return sprintf(buf, "[%6s]", caller);
 }
 #else
@@ -2069,7 +2077,7 @@ static inline void printk_delay(int level)
 
 static inline u32 printk_caller_id(void)
 {
-	return in_task() ? task_pid_nr(current) :
+	return in_task() ? task_pid_nr(current) | (smp_processor_id() << CPU_ID_SHIFT) :
 		0x80000000 + smp_processor_id();
 }
 
-- 
2.25.1

