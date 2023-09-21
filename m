Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4BC67A9887
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjIURtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjIURs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:48:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C87A2DEB7;
        Thu, 21 Sep 2023 10:25:10 -0700 (PDT)
Date:   Thu, 21 Sep 2023 06:49:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695278964;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9F0spGRPHXeTOxcSn6yRhRnx9hV6elwlzOuk+huTzII=;
        b=olFseMA6x0YTdVgUnhzm0IinaAVEn5Ws7+ciwzOobGpplL+3kuf7OWzFgiijDONrjL+LsH
        SyjQDCRxbYAIGj6ss6mT4dxk3rhm5CgcZ2BdAiVdXoLQG8L2kkTQ5/0HwGow0t8mjoMbXp
        e/1ZU9EXuZQz8kSP4DrRYaPPRZtBRYMN0++mLqrV+SQgFncT4sx0g0g+YEl42QWtji7pHD
        5KojP/gN8VWcO0hcNSqQIvUZnwA18vgYQ4+1hvnC8sy30suIVKENoT/fHnSl9vp8iIRk/E
        99tZOjpDXx+gQ91GlfOqwJuP40YbslIkWrORC6s4hvTfxAqCTrxVaequZyfe8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695278964;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9F0spGRPHXeTOxcSn6yRhRnx9hV6elwlzOuk+huTzII=;
        b=w/Td7f0L/wsrN0rqirurJggSYSzW7au0VZeD16dq/iyVXDljTsVfmF8oPce4wDpSUFsYYf
        9yAYyIF/PwvwLtDw==
From:   "tip-bot2 for Colin Ian King" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86/unwind/orc: Remove redundant initialization
 of 'mid' pointer in __orc_find()
Cc:     Colin Ian King <colin.i.king@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230920114141.118919-1-colin.i.king@gmail.com>
References: <20230920114141.118919-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Message-ID: <169527896379.27769.3655940245811968387.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     fef44ebaf61b57a71ab818058926a3f9a0ac81e6
Gitweb:        https://git.kernel.org/tip/fef44ebaf61b57a71ab818058926a3f9a0ac81e6
Author:        Colin Ian King <colin.i.king@gmail.com>
AuthorDate:    Wed, 20 Sep 2023 12:41:41 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 21 Sep 2023 08:41:23 +02:00

x86/unwind/orc: Remove redundant initialization of 'mid' pointer in __orc_find()

The 'mid' pointer is being initialized with a value that is never read,
it is being re-assigned and used inside a for-loop. Remove the
redundant initialization.

Cleans up clang scan build warning:

  arch/x86/kernel/unwind_orc.c:88:7: warning: Value stored to 'mid' during its initialization is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20230920114141.118919-1-colin.i.king@gmail.com
---
 arch/x86/kernel/unwind_orc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 7e574cf..d00c28a 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -85,7 +85,7 @@ static struct orc_entry *__orc_find(int *ip_table, struct orc_entry *u_table,
 {
 	int *first = ip_table;
 	int *last = ip_table + num_entries - 1;
-	int *mid = first, *found = first;
+	int *mid, *found = first;
 
 	if (!num_entries)
 		return NULL;
