Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036397D11C9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 16:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377556AbjJTOrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 10:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377239AbjJTOrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 10:47:49 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2078.outbound.protection.outlook.com [40.107.7.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079E0D46
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 07:47:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WCPkh85UJrkyVGGJHxz/A+EGb7gzUIBfTE11/RPB4FTwt2LVLj+nH/JNXP49Z2l9lTpfFTSpxOaJQSOomnxSWK5zkxSCfJux6qLwNiR+w4pmNoqi3QAWQ7BBG9odBjyRo8ZONQj85rO61hTeYYGSAXFybOVSk7kcrhZX5VtRUjIZocrpJXS8W3TkdBz/2OnwIblASxXoggKSLfuqLJpBUgsEmZF0CWC6GUOTDvgSVoyDg1KY+D4bB+ekIzD2AM9FGElIFNySfYLnHwo8iGzfZ0XFgPWSe17YslURDiPg8szuneFzV3KPZxa2vs3+syqFT091IjtC9AsGgjaZmIArZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=na5O4Qh8Ep60/F+xKOlkyWt1PratIgl4fxUa+ypbRuI=;
 b=RFMtt3ry4vMXviz/tIs/teDbMCqnvQJNpnk1tURzQvGQRwYkbTePQuDajA2L6zXpVbWuXbJ8NQPGgCCNAfofx5GJGRjz8Wx0+fo2UarFooXPKDHvw3yL2Pq4gy2HfwiPOP0POSeeKbISLr7qiamU52QqOeezixMqk55rwHf8S1CeNskZcF6apssjI5p7Bymvrsy8Ry4/0mcZe9EggS01TfYKsa3MK1voMj+ocxnDfWCG7vuh1cMf/sBg1AoAv2ev4Y+wf1MvD/TMy8tZ1X9U4W12Yw6GrB7A4lgo9My3hOV/3YkXb7eB0fgy2NS/UQrL53pCshRgxjR/g3sNIIxDbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=cambridgegreys.com smtp.mailfrom=axis.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=na5O4Qh8Ep60/F+xKOlkyWt1PratIgl4fxUa+ypbRuI=;
 b=EOnhz2oqV6Hs03LwSqgTywPT5q1eZleBAp+dmxCjdjuZeQflbS2aIQ0hwdR1+9s8gC8cbGnOSLTn2oPqXTQJSpB7wKYdJHLFzPMSZcLLTSq+Iw6H+TcwAt5jQ8gUT8aBsMVCWJu6NlE2haFyA6xQDsqedBcZG/qRBaGXG0WTXYQ=
Received: from AS9PR06CA0337.eurprd06.prod.outlook.com (2603:10a6:20b:466::13)
 by AS2PR02MB9692.eurprd02.prod.outlook.com (2603:10a6:20b:5e8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Fri, 20 Oct
 2023 14:47:43 +0000
Received: from AM1PEPF000252DC.eurprd07.prod.outlook.com
 (2603:10a6:20b:466:cafe::9e) by AS9PR06CA0337.outlook.office365.com
 (2603:10a6:20b:466::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26 via Frontend
 Transport; Fri, 20 Oct 2023 14:47:43 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of axis.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 AM1PEPF000252DC.mail.protection.outlook.com (10.167.16.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Fri, 20 Oct 2023 14:47:43 +0000
Received: from SE-MAIL21W.axis.com (10.20.40.16) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 20 Oct
 2023 16:47:42 +0200
Received: from se-mail01w.axis.com (10.20.40.7) by SE-MAIL21W.axis.com
 (10.20.40.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 20 Oct
 2023 16:47:42 +0200
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 20 Oct 2023 16:47:42 +0200
Received: from pc45945-2140.se.axis.com (pc45945-2140.se.axis.com [10.88.125.80])
        by se-intmail01x.se.axis.com (Postfix) with ESMTP id 919CD367C;
        Fri, 20 Oct 2023 16:47:42 +0200 (CEST)
Received: by pc45945-2140.se.axis.com (Postfix, from userid 10564)
        id 9F55E746BD68; Fri, 20 Oct 2023 16:47:42 +0200 (CEST)
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
Date:   Fri, 20 Oct 2023 16:47:39 +0200
Subject: [PATCH] um: time-travel: fix time going backwards
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231020-uml-time-backwards-v1-1-90b776fc6dfd@axis.com>
X-B4-Tracking: v=1; b=H4sIAAqTMmUC/x3MSQqAMAxA0atI1gbaiCBeRVzUNmpwpHUC6d0tL
 t/i/xcCe+EAdfaC50uCbGuCzjOwo1kHRnHJQIoKrUjhucx4yMLYGTvdxruAZUm20oadowJSuHv
 u5fmnTRvjB9BuoQZkAAAA
To:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>
CC:     <linux-um@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>
X-Mailer: b4 0.12.3
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM1PEPF000252DC:EE_|AS2PR02MB9692:EE_
X-MS-Office365-Filtering-Correlation-Id: b48aaed4-dcfe-49a5-3103-08dbd17b8444
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W4VPyGoxDOT2UoW2xdLxLl19Bw2pBO2fYEXcKYqQljbgjqyUIvr8pLJ+RFCVI0DLqK36uuSMlB9z88e96pKqnS/G7YymzBPNU3gf6cBD4J69FXvFZdQIQu+svft0kjn27o0i4pOVIxe9JbY+SJbmVwtbxrr/QrR5pS8huPjOe2GEo3HQjU2GhVrle0/uWnhyllTrXu2JxeF+je7swKrYF0sdv4kRRGaOne/kQrapJScSyoAV9kmgjmRlbcWCTVRnqinU2yX33CWQX4L8bFksg7GyalQhzBpR2HIfQU30pFFGsrPBpBkUcVrD6sBFjnNSfKVi5BNvuHm2EDM0K8yL+UoXw5aAeiZmOb32mL85pn4BJ3b9rlLnfZoz4huLFeP8cSwHpFF/Fa4MB9SXtWvyOw1GCcyKHCmNgqVLmd9PVKK2O1aOob62H//waWv+PcVgPFbDYcgcxcoADU+TSTylDDfev7DCUchUH6h9fLMRmUaPfrO16lH7IE4GNHa6WAqAUmZscpNjPvM5tm0+pLHyrPTchWvWCQIm9yi2vVzg/f0rbfdm0sN38092CCVQHZl3TFyRjzDKovlG6nK9SGO6vsliEtVHFV2M0LwGLgB8LdfDHpzVkM0dV23L7fXzOwzoI/JQuGrzGSfh35Vxqf/rdP2nQOJ0II8+CtCdohrjD7RXwjYt3IrOTjO1MtEQpSzmsvZ9NOQMdBOUvPbpTwY32tWClDClW3Y7t3EWOKwE3WvBfoep9xQC2bNrg5ICARQSDNA3pq4JhaZxf55ZjWbe+w==
X-Forefront-Antispam-Report: CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(136003)(39860400002)(396003)(230922051799003)(451199024)(82310400011)(1800799009)(64100799003)(186009)(36840700001)(46966006)(40470700004)(2906002)(110136005)(40480700001)(86362001)(41300700001)(66899024)(4326008)(8676002)(70206006)(70586007)(40460700003)(5660300002)(44832011)(36756003)(316002)(54906003)(8936002)(42186006)(82740400003)(2616005)(356005)(107886003)(26005)(81166007)(83380400001)(336012)(6266002)(6666004)(36860700001)(47076005)(426003)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 14:47:43.2988
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b48aaed4-dcfe-49a5-3103-08dbd17b8444
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: AM1PEPF000252DC.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR02MB9692
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In basic time travel mode, I sometimes see "time goes backwards" panics
like the one below:

 Kernel panic: time-travel: time goes backwards 161689340000492 -> 161689339869814
 Call Trace:
  panic+0x1a1/0x3d7
  time_travel_update_time.cold+0xe9/0x133
  timer_read+0xc1/0x100
  ktime_get+0x10c/0x200
  copy_process+0x1899/0x2230
  kernel_clone+0x57/0x7a0
  kernel_thread+0x4a/0x50
  kthreadd+0x116/0x190

The problem is a race between time_travel_handle_real_alarm() and
timer_read().  time_travel_handle_real_alarm() changes the time after
time_read() reads the current time but before time_travel_update_time()
has had a chance to add the end event.

Fix this by doing the time read and event add atomically with respect to
time_travel_handle_real_alarm().

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 arch/um/kernel/time.c | 48 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 34 insertions(+), 14 deletions(-)

diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
index fddd1dec27e6..38a94dd41b8f 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -392,17 +392,11 @@ bool time_travel_del_event(struct time_travel_event *e)
 	return true;
 }
 
-static void time_travel_update_time(unsigned long long next, bool idle)
+static void time_travel_update_to_event(struct time_travel_event *ne, bool idle)
 {
-	struct time_travel_event ne = {
-		.onstack = true,
-	};
 	struct time_travel_event *e;
 	bool finished = idle;
 
-	/* add it without a handler - we deal with that specifically below */
-	__time_travel_add_event(&ne, next);
-
 	do {
 		e = time_travel_first_event();
 
@@ -414,7 +408,7 @@ static void time_travel_update_time(unsigned long long next, bool idle)
 			BUG_ON(!time_travel_del_event(e));
 			BUG_ON(time_travel_time != e->time);
 
-			if (e == &ne) {
+			if (e == ne) {
 				finished = true;
 			} else {
 				if (e->onstack)
@@ -427,14 +421,38 @@ static void time_travel_update_time(unsigned long long next, bool idle)
 		e = time_travel_first_event();
 		if (e)
 			time_travel_ext_update_request(e->time);
-	} while (ne.pending && !finished);
+	} while (ne->pending && !finished);
+
+	time_travel_del_event(ne);
+}
 
-	time_travel_del_event(&ne);
+static void time_travel_update_time(unsigned long long next, bool idle)
+{
+	struct time_travel_event ne = {
+		.onstack = true,
+	};
+
+	__time_travel_add_event(&ne, next);
+	time_travel_update_to_event(&ne, idle);
+}
+
+static void time_travel_forward_time(unsigned long nsec, bool idle)
+{
+	struct time_travel_event ne = {
+		.onstack = true,
+	};
+	unsigned long flags;
+
+	local_irq_save(flags);
+	__time_travel_add_event(&ne, time_travel_time + nsec);
+	local_irq_restore(flags);
+
+	time_travel_update_to_event(&ne, idle);
 }
 
 void time_travel_ndelay(unsigned long nsec)
 {
-	time_travel_update_time(time_travel_time + nsec, false);
+	time_travel_forward_time(nsec, false);
 }
 EXPORT_SYMBOL(time_travel_ndelay);
 
@@ -572,6 +590,10 @@ static inline void time_travel_update_time(unsigned long long ns, bool retearly)
 {
 }
 
+static void time_travel_forward_time(unsigned long nsec, bool idle)
+{
+}
+
 static inline void time_travel_handle_real_alarm(void)
 {
 }
@@ -720,9 +742,7 @@ static u64 timer_read(struct clocksource *cs)
 		 */
 		if (!irqs_disabled() && !in_interrupt() && !in_softirq() &&
 		    !time_travel_ext_waiting)
-			time_travel_update_time(time_travel_time +
-						TIMER_MULTIPLIER,
-						false);
+			time_travel_forward_time(TIMER_MULTIPLIER, false);
 		return time_travel_time / TIMER_MULTIPLIER;
 	}
 

---
base-commit: 58720809f52779dc0f08e53e54b014209d13eebb
change-id: 20231020-uml-time-backwards-552c81aedd23

Best regards,
-- 
Vincent Whitchurch <vincent.whitchurch@axis.com>

