Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F396876A0C9
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 21:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjGaTE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 15:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjGaTE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 15:04:56 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F882170A;
        Mon, 31 Jul 2023 12:04:55 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 32ce0183077fd9b9; Mon, 31 Jul 2023 21:04:52 +0200
Authentication-Results: v370.home.net.pl; spf=softfail (domain owner 
   discourages use of this host) smtp.mailfrom=rjwysocki.net 
   (client-ip=195.136.19.94; helo=[195.136.19.94]; 
   envelope-from=rjw@rjwysocki.net; receiver=<UNKNOWN>)
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 314E16620E2;
        Mon, 31 Jul 2023 21:04:52 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Kajetan Puchalski <kajetan.puchalski@arm.com>
Subject: [PATCH v3 3/3] cpuidle: teo: Drop utilized from struct teo_cpu
Date:   Mon, 31 Jul 2023 21:04:41 +0200
Message-ID: <1953519.PYKUYFuaPT@kreacher>
In-Reply-To: <4515817.LvFx2qVVIh@kreacher>
References: <4515817.LvFx2qVVIh@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrjeeggddutdelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopegrnhhnrgdqmhgrrhhirgeslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehfrhgv
 uggvrhhitgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrjhgvthgrnhdrphhutghhrghlshhkihesrghrmhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Because the utilized field in struct teo_cpu is only used locally in
teo_select(), replace it with a local variable in that function.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v2 -> v3: No changes

v1 -> v2: New patch

---
 drivers/cpuidle/governors/teo.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

Index: linux-pm/drivers/cpuidle/governors/teo.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/teo.c
+++ linux-pm/drivers/cpuidle/governors/teo.c
@@ -187,7 +187,6 @@ struct teo_bin {
  * @next_recent_idx: Index of the next @recent_idx entry to update.
  * @recent_idx: Indices of bins corresponding to recent "intercepts".
  * @util_threshold: Threshold above which the CPU is considered utilized
- * @utilized: Whether the last sleep on the CPU happened while utilized
  */
 struct teo_cpu {
 	s64 time_span_ns;
@@ -197,7 +196,6 @@ struct teo_cpu {
 	int next_recent_idx;
 	int recent_idx[NR_RECENT];
 	unsigned long util_threshold;
-	bool utilized;
 };
 
 static DEFINE_PER_CPU(struct teo_cpu, teo_cpus);
@@ -366,6 +364,7 @@ static int teo_select(struct cpuidle_dri
 	int idx0 = 0, idx = -1;
 	bool alt_intercepts, alt_recent;
 	ktime_t delta_tick;
+	bool cpu_utilized;
 	s64 duration_ns;
 	int i;
 
@@ -391,13 +390,13 @@ static int teo_select(struct cpuidle_dri
 			goto out_tick;
 	}
 
-	cpu_data->utilized = teo_cpu_is_utilized(dev->cpu, cpu_data);
+	cpu_utilized = teo_cpu_is_utilized(dev->cpu, cpu_data);
 	/*
 	 * If the CPU is being utilized over the threshold and there are only 2
 	 * states to choose from, the metrics need not be considered, so choose
 	 * the shallowest non-polling state and exit.
 	 */
-	if (drv->state_count < 3 && cpu_data->utilized) {
+	if (drv->state_count < 3 && cpu_utilized) {
 		/* The CPU is utilized, so assume a short idle duration. */
 		duration_ns = teo_middle_of_bin(0, drv);
 		/*
@@ -562,7 +561,7 @@ static int teo_select(struct cpuidle_dri
 	 * been stopped already and the shallower state's target residency is
 	 * not sufficiently large.
 	 */
-	if (cpu_data->utilized) {
+	if (cpu_utilized) {
 		s64 span_ns;
 
 		i = teo_find_shallower_state(drv, dev, idx, duration_ns, true);



