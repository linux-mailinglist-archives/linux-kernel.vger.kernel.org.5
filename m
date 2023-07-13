Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB34752AAC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 21:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjGMTBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 15:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjGMTB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 15:01:29 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2047.outbound.protection.outlook.com [40.107.7.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126062D57;
        Thu, 13 Jul 2023 12:01:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a1t3dlcly8kaqNNfdCEM9zt8QUgtD43JKguFyD0jjt9SBj11yP4dOG4PjYbV0BSEUJLsXNcUfqguLI2z9jVBiyUIo/N+enNYp1miY0YrhN7QVa0oI3FeX5MeYZk/TUhv6RXthXhdgzaVbe4ZvmCQXsilVi2Tst6+/0lW9enHzfQfo2/OF49tx8MBrWsT8wWlhuuBAjmnKe5IQIAJH77vuEIzEL9OdkJTaA8srQL4vfIKAGWcLN0dFEZFugYXPM0hHA+z8jCFN7LbjXMRhyxwMbgWWZtyJ6bjTNQ2XVVgwBZWG1F0m/KQpWI8SLcnecah8+mhz8L7hTk5jXmPgAA/SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PLbBhGQ7XQST2BkZU7eX/+ZZ4ZPOscFyubd3rVtKgkc=;
 b=g2tKWn438G8ciT/fdVWYKkskOq+5PAQ8LEi4+R8Yd6e/C05qG6vJC6BpxUQe37+bw0a2Pso82LiMzVOC/1VYzWzHlo8VLSCixqnz8XaSg1cyysaFysz4Zaz7a+UzFCaHrZu7gDoA5kWa8vespJLpEcQTd5pw4Y2mLGL8JhXYod4H/yOawSnkptz+aIFuH30Go3j3uCs9Fk9ja+2u1ZwFaHHDiwPjnE7c1lOuDj656mui2teG11lc0kufILd3RoqbNeP+cIYCuNK4ezHYnZKgTcsUI+56b7ZpmdBNuKk7l4B85m6dSQGfAcyd9XzSMEFZ1hNXe4BD+dKfEF1MR9ybRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PLbBhGQ7XQST2BkZU7eX/+ZZ4ZPOscFyubd3rVtKgkc=;
 b=GOELfHLxOFKU1zwvVAqUimoDewu/aLZn4n/UvvZgUJDEfFDUHiZwp5ZVUfqvH6zg6k2eP+6QJW8ZmHW6PI7LIePx+h48xuNAxudMGQWcUR3FHdz51bYrlABY+gmsSSzRms810rwFHdoIWcooSuiT589RZKZLI7AZ6aQ5TGKPhRk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by AM9P193MB1956.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:302::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.26; Thu, 13 Jul
 2023 19:01:20 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::33e5:1608:50a0:38a7]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::33e5:1608:50a0:38a7%3]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 19:01:20 +0000
Message-ID: <144f1c66-499e-2da9-c4c1-b5f26cb8841f@kunbus.com>
Date:   Thu, 13 Jul 2023 21:01:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
From:   Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: [PATCH v4 RESEND] tpm,tpm_tis: Disable interrupts after 1000
 unhandled IRQs
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     jsnitsel@redhat.com, hdegoede@redhat.com, oe-lkp@lists.linux.dev,
        lkp@intel.com,
        =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        peterz@infradead.org,
        =?UTF-8?Q?Michael_Niew=c3=b6hner?= <linux@mniewoehner.de>,
        Linux Kernel Integrity <linux-integrity@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Lukas Wunner <lukas@wunner.de>,
        Philipp Rosenberger <p.rosenberger@kunbus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1P15301CA0063.APCP153.PROD.OUTLOOK.COM
 (2603:1096:820:3d::21) To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:803:4e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|AM9P193MB1956:EE_
X-MS-Office365-Filtering-Correlation-Id: 42f15737-6c76-4525-f16a-08db83d38b2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C9T+3ngRczgmdEBUyZYwspRb2zGfV9PYcuCpCqBkvAUMLL4NNvEu6Ey0Oth+NwyLJl4AuRCuu6Eg/FiT8SfmUudJncjnw8AHKAycc+s/eNEoCpPrmLatVFzL29DZbbT8nY/29RmPR5OUzo8H+CUufJzMKQO5KoXe3B5Tj/Ty6rg+ZBYkrPVTWvCvW75zDinll4/EkI0kx40nz58B6y1xAo9r9rxLkkdoDeaZr0IWfyp+v6nG4W5vMarDfmR7aCDVZAHpc9GE42ZbMWk7aUxpfMfFIkD3GsPtHVi4575gjjEh6Of7inmP7iLF3IP4R/fm56D0B9aRbPFxbf4CzYE0+gJJq8VicNxS645OWerc4gUcdDSoKT0HI7ds+eRRHKiUJ2oFoh/suprbWyO9V1KQLj1JZPRoXBpeWNLCElUKTovuWu6FmYB2q8PuxZFM2h1BDbRZJvZ1G0G7AylmKJPclicTBmu2ZaaSJ2AG4rCPzE+d/vyQb4b5xe2Uehi3mMGk+nPj0EnhSRevDu6sOWcqkMP7stNJOCCa1WXLmRDnqsYWsoeXPWQ7yF5PSfiAzelhjaiD0YrGEJNGabWyXuWI7iGpX7hor2fyaKqOB+ooazMfq0S6q6BbHr2hEdTWKeuSmh2jTaTO8pqRE3VbwLQikeTHPfSWUM6d6Ovc8geTvS1oM4k0gouHWBy1c5v90Iz3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39840400004)(346002)(376002)(136003)(451199021)(83380400001)(2906002)(2616005)(66476007)(6486002)(4326008)(66556008)(66946007)(316002)(966005)(6512007)(52116002)(478600001)(6666004)(110136005)(54906003)(5660300002)(26005)(6506007)(107886003)(186003)(7416002)(8676002)(41300700001)(8936002)(38100700002)(38350700002)(31696002)(86362001)(36756003)(31686004)(221023011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejVRRS94QzdvSUI0dnJZTitVZmVWS2t6M0dXKzlQQzBTZG0zUXY2VlJDNlJX?=
 =?utf-8?B?NmwyTWh2WWFBRXZmTE9MaWlBRlRKZGNXejZJY3VkS29HQjV2S0lod0JTRUpp?=
 =?utf-8?B?ZVIxeU5PZmc5eTQ5M0VDKzg3SEQ0R2F3U0kvUVRVNUhsVk85T0o4ZnhZMHcz?=
 =?utf-8?B?dVlaSHVMWW0zeklLK0o4amRqQUJmZ2tuNVJxdlI1UDZvUGJFTHYyZHpsTTJD?=
 =?utf-8?B?NlJXSHRUT2pSOFhjLzZja3UrMjhOM0xzc1pHc1AzTkIyRGJhWkhwWEZ2S3RL?=
 =?utf-8?B?UStmZFdVQmE4OWpQbGxNK3FwelhsdE43aUNXdTk4c1FnUGhiLzhlQ3hERnhW?=
 =?utf-8?B?bnB2NE9sNms3SE10a1U3RWFVRmFJaGpHQ210M0l0LzVOVXhYZmtuRFJNR1or?=
 =?utf-8?B?MXZoWm1GaXNESlpiNVNrRG9KMXYrNVRqdWVtSWZUUjNpejY1V1NSanlDWjFS?=
 =?utf-8?B?TERJbHY5SGRESGJ0S3hqR2VXSmN0bWNnMit2bnNsaEtaRDg3eitZcHRHbzdl?=
 =?utf-8?B?eHJYZjlWSDU0eXpha2NJS1lBVVdVL3MzTENvRWNJR3V0M1ZlVjZYWWdpeFdM?=
 =?utf-8?B?cHg3ZnU2ekpOUlhGNHZvaWVtclhwT3cyVjlheUJEcXRDVjB2QXNwR1JnSko1?=
 =?utf-8?B?amxOMmtGSzlTbG9ycnh4dWZ5TjdZZ3BxN3E4MGhGL2lSS3dWSFVMeUhzUUFW?=
 =?utf-8?B?YW9kYUl4Y0hGbEYvUUdjMGJ4QUU2MzBwcjlGQlkzcWdrQzhQaTl4bHpoV05V?=
 =?utf-8?B?aEVOck4rMU5BeXRqVFRuNTZJeGYxa1RDN3FSNmNuSEFhN2pONzBGMkVtVGhP?=
 =?utf-8?B?bEV0VjNsVUlFUWpUZ2pBZnp4aksrWU16THdTdVVHaktxNmJHSmRXVVkvVk94?=
 =?utf-8?B?aGUyYVZZd1lzS3Z0eFluTFcrTFExKzdDSEFKRWhxVk1ncXBOdWY4L0l6bGFJ?=
 =?utf-8?B?T0xYK1RmNDJuNGpUaE1NSkFtSDlmTnlYdzNFT3hVY252dDdIVmYyajVZeVFr?=
 =?utf-8?B?bjRPd3lzbmJSRWJIdnl3amt5dXpINmoyZFcvYWk1N0YyTVR4b2c4dG1nNVpO?=
 =?utf-8?B?NVlGZVRKaGwrRllkL0k0eXFiamthN0JnQ3VzQVRJM1BYZFJGN0JKYURubFds?=
 =?utf-8?B?M1d0OWNZNDNDMG5Wa1ArcG4rQmMwUGMveGtuK3hZWlZyeWdZRSsrQWxvZ1B2?=
 =?utf-8?B?djU0OUtVSWZrVnA0MlBJN28zRnFWTnBIakNCNTVQSVhqVXB6ZElld2tNVXRn?=
 =?utf-8?B?OU0reFJrOTNLYlhTMDc1M1hnT0pYUGg0OFZkQ0srMytVbUZZMGNndWIvVTEr?=
 =?utf-8?B?WlRzNEk3dmxpTnhpaTlweG9udWJTY3VhNnNkTlk0OU81bGdSeFhKdU1kMWp6?=
 =?utf-8?B?a1ZtSno5TmN5WVlKNk40aWYwU3Z4YkUrZ1lvOGQ3MDh4cThxWDltSlNjRTVh?=
 =?utf-8?B?aHFuVm5lbld4WGNBNDF4cXREeDU3K3AzdVlhSkVVQzhnQjN6bFFldHVqVmtT?=
 =?utf-8?B?NTlTQ3J4SEVaQlEwT0lxcEJOT2EvRE1GMGlQKzdEQzlPTFZPTGdlUVl6Nnhz?=
 =?utf-8?B?OHQzb1BqYWNWR1pBWERyRUorVVFHMUx6eE5PeEFxc1hrSDNsSW1wTUcyQUFh?=
 =?utf-8?B?azhLTlhNdG1vSWtXdjFMMFFKa3paSWlsOThmaXVsVzJ4L3NRY3RCNlVCV01y?=
 =?utf-8?B?L0kzNXlKYVNTOEFzbE1sc1NQemJSMzFxdC8ydFBzdldEQ0lMc1gvMjc0OVpm?=
 =?utf-8?B?ZkdmSVJ1dWNFNFRoZWZtbDlsZE1KZ2RpM1dkaXhYN0ZUNFVVTkNPaEpUNlph?=
 =?utf-8?B?Yy9FMHY1OGM1cElnd1JDSk81dHo2YmR0RnkwLytxSkU5UUphcG9uaHQ1UWhl?=
 =?utf-8?B?M3Z5eFV0WVREb1VlQXJKZFBZaFRva2xaS3JKRVNmOTVWeXY2WTRiZmhFRnNx?=
 =?utf-8?B?azI1YjhDb1hpM1JiQW1RUjRrcUF5M2dVVXhETHJIdkhFcWI4RDliVFVEWEVp?=
 =?utf-8?B?Qzd6RVllWWViNDZ2N01ubVBTVkc1Q1JnZ29hd3BDaWZXTFc2QVNPWW1rVmU1?=
 =?utf-8?B?WldDSWlhTlZad0IvRW1IOUdMeDBLcEJZMWVBWU5ITFBDQ1MyQjRoT0d4cTZI?=
 =?utf-8?B?VnEyV2YwR3lMdGVMQW1DbXZUMXVxYzc3MW9hWkc4OUdqUWtXTE9WWnNRWCtV?=
 =?utf-8?B?aFE9PQ==?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42f15737-6c76-4525-f16a-08db83d38b2f
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 19:01:20.1808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5s4YgOTV/tdeH3/4xGSxDjlLEcxj4lAy+KkhIiYcoZG6qk0Y5hwvr8DtYwmHpcJT3eSXVLvKZzR1DsTo4v0kjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P193MB1956
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After activation of interrupts for TPM TIS drivers 0-day reports an
interrupt storm on an Inspur NF5180M6 server.

Fix this by detecting the storm and falling back to polling:
Count the number of unhandled interrupts within a 10 ms time interval. In
case that more than 1000 were unhandled deactivate interrupts entirely,
deregister the handler and use polling instead.

Also print a note to point to the tpm_tis_dmi_table.

Since the interrupt deregistration function devm_free_irq() waits for all
interrupt handlers to finish, only trigger a worker in the interrupt
handler and do the unregistration in the worker to avoid a deadlock.

Note: the storm detection logic equals the implementation in
note_interrupt() which uses timestamps and counters stored in struct
irq_desc. Since this structure is private to the generic interrupt core
the TPM TIS core uses its own timestamps and counters. Furthermore the TPM
interrupt handler always returns IRQ_HANDLED to prevent the generic
interrupt core from processing the interrupt storm.

Fixes: e644b2f498d2 ("tpm, tpm_tis: Enable interrupt test")
Reported-by: kernel test robot <yujie.liu@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202305041325.ae8b0c43-yujie.liu@intel.com/
Suggested-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
---
 drivers/char/tpm/tpm_tis_core.c | 103 +++++++++++++++++++++++++++-----
 drivers/char/tpm/tpm_tis_core.h |   4 ++
 2 files changed, 92 insertions(+), 15 deletions(-)

Resending the patch due to several bounce messages for the first attempt.

Changes to v3 (all requested by Jarko):
- remove all inline comments 
- rename tpm_tis_reenable_polling() to tpm_tis_revert_interrupts()
- rename tpm_tis_check_for_interrupt_storm() to tpm_tis_update_unhandled_irqs()
- rename label "unhandled" to "err"
- add Fixes: tag

Changes to v2:
- use define for max number of unhandles irqs(requested by Jarko)
- rename intmask to int_mask (requested by Jarko)
- rephrased short summary (requested by Jarko)
- rename disable_interrupts to tpm_tis_disable_interrupts (requested by Jarko)
- print info message concerning adding an entry to tpm_tis_dmi_table
  (suggested by Jerry)
- amended commit message
- handle failure of locality request by returning IRQ_NONE
- dont take and release locality in __tpm_tis_disable_interrupts but in its
caller

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 558144fa707a..88a5384c09c0 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -24,9 +24,12 @@
 #include <linux/wait.h>
 #include <linux/acpi.h>
 #include <linux/freezer.h>
+#include <linux/dmi.h>
 #include "tpm.h"
 #include "tpm_tis_core.h"
 
+#define TPM_TIS_MAX_UNHANDLED_IRQS	1000
+
 static void tpm_tis_clkrun_enable(struct tpm_chip *chip, bool value);
 
 static bool wait_for_tpm_stat_cond(struct tpm_chip *chip, u8 mask,
@@ -468,25 +471,29 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
 	return rc;
 }
 
-static void disable_interrupts(struct tpm_chip *chip)
+static void __tpm_tis_disable_interrupts(struct tpm_chip *chip)
+{
+	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
+	u32 int_mask = 0;
+
+	tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &int_mask);
+	int_mask &= ~TPM_GLOBAL_INT_ENABLE;
+	tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), int_mask);
+
+	chip->flags &= ~TPM_CHIP_FLAG_IRQ;
+}
+
+static void tpm_tis_disable_interrupts(struct tpm_chip *chip)
 {
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
-	u32 intmask;
-	int rc;
 
 	if (priv->irq == 0)
 		return;
 
-	rc = tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
-	if (rc < 0)
-		intmask = 0;
-
-	intmask &= ~TPM_GLOBAL_INT_ENABLE;
-	rc = tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask);
+	__tpm_tis_disable_interrupts(chip);
 
 	devm_free_irq(chip->dev.parent, priv->irq, chip);
 	priv->irq = 0;
-	chip->flags &= ~TPM_CHIP_FLAG_IRQ;
 }
 
 /*
@@ -552,7 +559,7 @@ static int tpm_tis_send(struct tpm_chip *chip, u8 *buf, size_t len)
 	if (!test_bit(TPM_TIS_IRQ_TESTED, &priv->flags))
 		tpm_msleep(1);
 	if (!test_bit(TPM_TIS_IRQ_TESTED, &priv->flags))
-		disable_interrupts(chip);
+		tpm_tis_disable_interrupts(chip);
 	set_bit(TPM_TIS_IRQ_TESTED, &priv->flags);
 	return rc;
 }
@@ -752,6 +759,57 @@ static bool tpm_tis_req_canceled(struct tpm_chip *chip, u8 status)
 	return status == TPM_STS_COMMAND_READY;
 }
 
+static irqreturn_t tpm_tis_revert_interrupts(struct tpm_chip *chip)
+{
+	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
+	const char *product;
+	const char *vendor;
+
+	dev_warn(&chip->dev, FW_BUG
+		 "TPM interrupt storm detected, polling instead\n");
+
+	vendor = dmi_get_system_info(DMI_SYS_VENDOR);
+	product = dmi_get_system_info(DMI_PRODUCT_VERSION);
+
+	if (vendor && product) {
+		dev_info(&chip->dev,
+			"Consider adding the following entry to tpm_tis_dmi_table:\n");
+		dev_info(&chip->dev, "\tDMI_SYS_VENDOR: %s\n", vendor);
+		dev_info(&chip->dev, "\tDMI_PRODUCT_VERSION: %s\n", product);
+	}
+
+	if (tpm_tis_request_locality(chip, 0) != 0)
+		return IRQ_NONE;
+
+	__tpm_tis_disable_interrupts(chip);
+	tpm_tis_relinquish_locality(chip, 0);
+
+	schedule_work(&priv->free_irq_work);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t tpm_tis_update_unhandled_irqs(struct tpm_chip *chip)
+{
+	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
+	irqreturn_t irqret = IRQ_HANDLED;
+
+	if (!(chip->flags & TPM_CHIP_FLAG_IRQ))
+		return IRQ_HANDLED;
+
+	if (time_after(jiffies, priv->last_unhandled_irq + HZ/10))
+		priv->unhandled_irqs = 1;
+	else
+		priv->unhandled_irqs++;
+
+	priv->last_unhandled_irq = jiffies;
+
+	if (priv->unhandled_irqs > TPM_TIS_MAX_UNHANDLED_IRQS)
+		irqret = tpm_tis_revert_interrupts(chip);
+
+	return irqret;
+}
+
 static irqreturn_t tis_int_handler(int dummy, void *dev_id)
 {
 	struct tpm_chip *chip = dev_id;
@@ -761,10 +819,10 @@ static irqreturn_t tis_int_handler(int dummy, void *dev_id)
 
 	rc = tpm_tis_read32(priv, TPM_INT_STATUS(priv->locality), &interrupt);
 	if (rc < 0)
-		return IRQ_NONE;
+		goto err;
 
 	if (interrupt == 0)
-		return IRQ_NONE;
+		goto err;
 
 	set_bit(TPM_TIS_IRQ_TESTED, &priv->flags);
 	if (interrupt & TPM_INTF_DATA_AVAIL_INT)
@@ -780,10 +838,13 @@ static irqreturn_t tis_int_handler(int dummy, void *dev_id)
 	rc = tpm_tis_write32(priv, TPM_INT_STATUS(priv->locality), interrupt);
 	tpm_tis_relinquish_locality(chip, 0);
 	if (rc < 0)
-		return IRQ_NONE;
+		goto err;
 
 	tpm_tis_read32(priv, TPM_INT_STATUS(priv->locality), &interrupt);
 	return IRQ_HANDLED;
+
+err:
+	return tpm_tis_update_unhandled_irqs(chip);
 }
 
 static void tpm_tis_gen_interrupt(struct tpm_chip *chip)
@@ -804,6 +865,15 @@ static void tpm_tis_gen_interrupt(struct tpm_chip *chip)
 		chip->flags &= ~TPM_CHIP_FLAG_IRQ;
 }
 
+static void tpm_tis_free_irq_func(struct work_struct *work)
+{
+	struct tpm_tis_data *priv = container_of(work, typeof(*priv), free_irq_work);
+	struct tpm_chip *chip = priv->chip;
+
+	devm_free_irq(chip->dev.parent, priv->irq, chip);
+	priv->irq = 0;
+}
+
 /* Register the IRQ and issue a command that will cause an interrupt. If an
  * irq is seen then leave the chip setup for IRQ operation, otherwise reverse
  * everything and leave in polling mode. Returns 0 on success.
@@ -816,6 +886,7 @@ static int tpm_tis_probe_irq_single(struct tpm_chip *chip, u32 intmask,
 	int rc;
 	u32 int_status;
 
+	INIT_WORK(&priv->free_irq_work, tpm_tis_free_irq_func);
 
 	rc = devm_request_threaded_irq(chip->dev.parent, irq, NULL,
 				       tis_int_handler, IRQF_ONESHOT | flags,
@@ -918,6 +989,7 @@ void tpm_tis_remove(struct tpm_chip *chip)
 		interrupt = 0;
 
 	tpm_tis_write32(priv, reg, ~TPM_GLOBAL_INT_ENABLE & interrupt);
+	flush_work(&priv->free_irq_work);
 
 	tpm_tis_clkrun_enable(chip, false);
 
@@ -1021,6 +1093,7 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 	chip->timeout_b = msecs_to_jiffies(TIS_TIMEOUT_B_MAX);
 	chip->timeout_c = msecs_to_jiffies(TIS_TIMEOUT_C_MAX);
 	chip->timeout_d = msecs_to_jiffies(TIS_TIMEOUT_D_MAX);
+	priv->chip = chip;
 	priv->timeout_min = TPM_TIMEOUT_USECS_MIN;
 	priv->timeout_max = TPM_TIMEOUT_USECS_MAX;
 	priv->phy_ops = phy_ops;
@@ -1179,7 +1252,7 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 			rc = tpm_tis_request_locality(chip, 0);
 			if (rc < 0)
 				goto out_err;
-			disable_interrupts(chip);
+			tpm_tis_disable_interrupts(chip);
 			tpm_tis_relinquish_locality(chip, 0);
 		}
 	}
diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
index 610bfadb6acf..b1a169d7d1ca 100644
--- a/drivers/char/tpm/tpm_tis_core.h
+++ b/drivers/char/tpm/tpm_tis_core.h
@@ -91,11 +91,15 @@ enum tpm_tis_flags {
 };
 
 struct tpm_tis_data {
+	struct tpm_chip *chip;
 	u16 manufacturer_id;
 	struct mutex locality_count_mutex;
 	unsigned int locality_count;
 	int locality;
 	int irq;
+	struct work_struct free_irq_work;
+	unsigned long last_unhandled_irq;
+	unsigned int unhandled_irqs;
 	unsigned int int_mask;
 	unsigned long flags;
 	void __iomem *ilb_base_addr;

base-commit: 6995e2de6891c724bfeb2db33d7b87775f913ad1
-- 
2.25.1

