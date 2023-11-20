Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727547F09FB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 01:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbjKTAQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 19:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjKTAQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 19:16:36 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03olkn2091.outbound.protection.outlook.com [40.92.58.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9455AE0;
        Sun, 19 Nov 2023 16:16:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bRLFzLf5WtbW6QEVvhwP/sKWVuNaVNPTa9PWPDaPR5xxM49wrjbQ7kbwKJczyCwibTy9aBm/32CFHidIG07clbbiEZn7oc9cc9MyDnWq0hZKrJ8X6+QvX32apOvqgOiWpV2jIedOC6iYorjxDdPetGmUYSdrym3aFU6CmxjJALp5/jISbsI5M3AA5zH7A3sKThtag5FGn2J2384MWBngSYpPm20y/s7WJpGYxHjrY3UP+uWHPe1EABk7a6JS7ObHteu04E5YVG9+F1W80lhToERY5/Oh3IeoOjNRDvgsW1rtdftAXmNDc4MMGi+HITDYn6zh/WdbmF6KVOdzvTWpSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vKyGSTBshSrHVqtfP2b0GRbfEL/kphFRDy62xCa35Lo=;
 b=Ogy8N2E6LOLKRnX+gE81Hp8Ko18RmfB475M5lHlZEmYO8p0puRVJrNuu1er0QF4OyZD6lUCYHsfuGX482WmU+r72v7/XMr1Km1PIg1qHkA6EivHIFt4Yhha674BKrjpqCpBWhHWhAEsL8tDWNHFqIVuFyDkZrthrXv/QHNk2vU1o5Kselse6cWIzNqpT4Zx57AvbCE2KchJ+nWU9JAXgKaUdjCFuPxvc0XKdHnMvmPD8u0Nzz/SJ70+AfHnuA9kEgW9BetNEybrrQO8HydraXdiZgCIqG774Bl5BWSZFFYaBHqg5G5Trgkwptj9In1/JfR6csCivgkSq/NfZfIZdCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKyGSTBshSrHVqtfP2b0GRbfEL/kphFRDy62xCa35Lo=;
 b=JW9AihYvgbBIAKWf4TjxvUtjOwzX1WAPX94u+v6nbjGxDcCkd2WdTNJsZTvud0pd16NioDDeqaQtZmoGSROyyoV7ZYe/VtGVSs9b8wb+CZlxJPjiKgQZ92f1xm4vjfR823fMhMU4R+Q30Ljt0/OJ6hNmQ5RF+kCtBAUiouUw0gWB2jHyUlmedi7uFfrQTIg9Lgwl2PsT4Q0IpuSgQp3QKwpVx3+UblSpBoc4DJiACaso0yVGNs8OWe3bc+6eMd0EmnbSBQkOwqzL29OcLRhCKH2dvAgjbNrrd/O3yKWkBRI6mrBquv30CuxxlIReCiCE9yOduOkJ3hIlph2Jvb62Xw==
Received: from GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:83::20)
 by AS2PR10MB7297.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:607::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 00:16:30 +0000
Received: from GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6c45:bfdf:a384:5450]) by GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6c45:bfdf:a384:5450%7]) with mapi id 15.20.7002.026; Mon, 20 Nov 2023
 00:16:30 +0000
From:   Yuran Pereira <yuran.pereira@hotmail.com>
To:     linux-trace-kernel@vger.kernel.org
Cc:     Yuran Pereira <yuran.pereira@hotmail.com>, mark.rutland@arm.com,
        rostedt@goodmis.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] ftrace: Replaces simple_strtoul in ftrace
Date:   Mon, 20 Nov 2023 05:46:13 +0530
Message-ID: <GV1PR10MB656333529A8D7B8AFB28D238E8B4A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [+IK25jmwXmVxrmBUqUF9m5jPMVeT1u8/]
X-ClientProxiedBy: JNAP275CA0027.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::17)
 To GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:83::20)
X-Microsoft-Original-Message-ID: <20231120001613.361195-1-yuran.pereira@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR10MB6563:EE_|AS2PR10MB7297:EE_
X-MS-Office365-Filtering-Correlation-Id: 77ec996e-9167-48e5-8c98-08dbe95df1fe
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ch/IfEWQnwsgKP8DjruYs4aHnC5wPv4FkYEYxmw450OO67ME62J7q78RoZVQdWc7HpsbijPUbDPsj5IaFHBIZxRcVFz75Ivhf2LqA5Ylbnj7Pjhaw04+AoAqaGtvSsFzMepDYTi867M1FAB2N0nYi6wrzQSqXjTrGqX+Bqpg6irRfMcHRvRtsaUD30FmVWyytvaxCebgxUnRwPhxej+7qcikQUH6D9o8amrU3n+FBFGeOK/6GYn+DJTHuO+IZrRNqV0Wqwg2bBvXdspV2dVEzGHwkYIvFr6wZSYLoAdxPLCp5svGK8ePjb4NvUjeFaN0pIaHPt/J8NQ6FxxrWUtLo20ezxqt46jtUvfvMhhPKgFBtnXvxo0RaQMUlyc3CEQgMAU2WIYMlK7tTdOynmmba4cyD9nePLgXaBsILVEsO+6gIbTNUzgnuL1A0w/MnsnHWtPma2u9/HUQBJZe3HailPdh3Fz1Mhz4BEGJ+yNiymKj7Uw4Q4+aexgHsu6DPLAtuxU0u2EfL/iYDX5/Z00HPcfBLKtNg/UACtNEX/mf53ziAvwpfq1/ISD28NhWIFvDL91oZSwlJr+OL0O1gIz/Jz3zA3m1+IRvl4a5/oDIJz1qFmT9rqVpBIKQ4rxA3jXo
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FK6KoqjmWwpBlwPopRXKff3zTG6SdhNky7JGmy5as8vix4URFK5yHJm4nPok?=
 =?us-ascii?Q?dkUNkxCtXuk/RPzP7SiNqRCs289NjZ0PPwihvmqBqF+giPeMPgf9l7l+hh22?=
 =?us-ascii?Q?o81EPt+cXZ+mlZmp+53rSJZ1OacsNIGtNglqvsGEEgmwtc5znB4Oe+DhrLr1?=
 =?us-ascii?Q?qE+Xmjx9gDnDSWbG4v2TdqyZ/IgZs48PPLfH60eLtrYgvbN3dmPMiP/d069P?=
 =?us-ascii?Q?d1YnLJTHJaY8EIwETbtib3L5wFgjPtjEmsUpT9ULHrfS/eSLlONa+erNUm+k?=
 =?us-ascii?Q?aH9B1GlhAQpoYSU1Zv+9VsMWNJ0j0ba2ONwoX7pboNM5tlTErxCEyEv416Az?=
 =?us-ascii?Q?QtIoFoNc4/opmV+cyVwO/pkYwCfuHfmp+HsUsCStVD3FBN81XJ2LvIlLOV74?=
 =?us-ascii?Q?RLaSQtm17RaJqwOfUU5aX5suwQypUCBN7Z0iORcbHcj8c1QIMgqGywNiSRCU?=
 =?us-ascii?Q?DOH7V7jU1UjL8ueozI0AI5TZyD/WCKU24hMLt5vS6xgpqux+VhIEyJRa8gc2?=
 =?us-ascii?Q?dGkH0p01DNM1RQVUqLIfMEKsd2QjxtKis86NaqF34MfMHtOYrOWOhZKcxplv?=
 =?us-ascii?Q?rgIAJ/8AOrm3mJEGVtIC5NFCvVAJcRRIfg3bIJIlCs/GwcrRg5azmWvCtq26?=
 =?us-ascii?Q?Pa9VbHuXykzJMxM+zAe+zMMz7YYgUR1bJDF2hOwcfFbcO9bt38JpEsHJ/lza?=
 =?us-ascii?Q?MLnGvqJ2M9ChuCljsxWlALa+HYOWr2xH/7HmP9vajCwOXKAFUSqKPMa9fd//?=
 =?us-ascii?Q?tbD1dh+dYj2A5UQPICxkQtu/a5XLqcTvkHz4ZA79VFThQGAjOHGYm4U6LQHW?=
 =?us-ascii?Q?MbiBbXx6Mz8Kn+Xa5tUgG3o+sKyrw39y4y+ar0lOCVypSlKhGA3xMheqlxST?=
 =?us-ascii?Q?B+dxYANYiP+AEY383d6ay9gfczX3w0IUKp+/nDTsQX4p7D9QGogkCyMgQMb4?=
 =?us-ascii?Q?jGjXCj61OFsn8Vtjpx9z1Nb3w75fS/XQbH2YZuJqLM7Jc925JFinfAiJl1LU?=
 =?us-ascii?Q?SjOGRlxMNswZ3i+XSVN8G1IO5z2k0m2hdRFJx3mK4jCpJe+sPc1E3VYZjkwn?=
 =?us-ascii?Q?a3AMI9BDUSb0dHnSpT4oaDc8o+MieFHKIxTbMooWtugN4gbhJSlQ1j6uyXc4?=
 =?us-ascii?Q?iBNfTBbmsQEdn8neslyftBzJKgGQuLluk4VwJP3XhTTdg7OAPysM97B3tWLW?=
 =?us-ascii?Q?WyEOfaosz5OINhlIWMG1o5Lv2782k2H+7m1EXIauOfhsX4hpXyRk/jfQdxg?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 77ec996e-9167-48e5-8c98-08dbe95df1fe
X-MS-Exchange-CrossTenant-AuthSource: GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 00:16:30.7419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7297
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function simple_strtoul performs no error checking in scenarios
where the input value overflows the intended output variable.
This results in this function successfully returning, even when the
output does not match the input string (aka the function returns
successfully even when the result is wrong).

Or as it was mentioned [1], "...simple_strtol(), simple_strtoll(),
simple_strtoul(), and simple_strtoull() functions explicitly ignore
overflows, which may lead to unexpected results in callers."
Hence, the use of those functions is discouraged.

This patch replaces all uses of the simple_strtoul with the safer
alternatives kstrtoul and kstruint.

Callers affected:
- add_rec_by_index
- set_graph_max_depth_function

Side effects of this patch:
- Since `fgraph_max_depth` is an `unsigned int`, this patch uses
  kstrtouint instead of kstrtoul to avoid any compiler warnings
  that could originate from calling the latter.
- This patch ensures that the callers of kstrtou* return accordingly
  when kstrtoul and kstruint fail for some reason.
  In this case, both callers this patch is addressing return 0 on error.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#simple-strtol-simple-strtoll-simple-strtoul-simple-strtoull

Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>
---
 kernel/trace/ftrace.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 8de8bec5f366..70217ee97322 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -4233,12 +4233,12 @@ static int
 add_rec_by_index(struct ftrace_hash *hash, struct ftrace_glob *func_g,
 		 int clear_filter)
 {
-	long index = simple_strtoul(func_g->search, NULL, 0);
+	long index;
 	struct ftrace_page *pg;
 	struct dyn_ftrace *rec;
 
 	/* The index starts at 1 */
-	if (--index < 0)
+	if (kstrtoul(func_g->search, 0, &index) || --index < 0)
 		return 0;
 
 	do_for_each_ftrace_rec(pg, rec) {
@@ -5810,9 +5810,8 @@ __setup("ftrace_graph_notrace=", set_graph_notrace_function);
 
 static int __init set_graph_max_depth_function(char *str)
 {
-	if (!str)
+	if (!str || kstrtouint(str, 0, &fgraph_max_depth))
 		return 0;
-	fgraph_max_depth = simple_strtoul(str, NULL, 0);
 	return 1;
 }
 __setup("ftrace_graph_max_depth=", set_graph_max_depth_function);
-- 
2.25.1

