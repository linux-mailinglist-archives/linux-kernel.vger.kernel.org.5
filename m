Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391A67E07E8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 19:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbjKCSEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 14:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbjKCSEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 14:04:46 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E081B9
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 11:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1699034677;
        bh=Tsur74u9o1zq0A+Iyqn7Ggc+7HPlh9cHB7EQ+wrOyQI=;
        h=From:To:Cc:Subject:Date:From;
        b=e9F/4Ma5bgCPzBCGV2pEii7QV32OoONx3dwdsrszZWiBZd0iJQfUJrwxivbqFUKkP
         xBTvxjPm1EZwcJdzeSYHxS146Z46j6DzucBwt6YjHjTGpApSM3/xlgBrcvtqO7BS4p
         FYiN9yWlBcOEr7oR1frc99PQMQ7fsfa1yywLoGlG98W9cPLqSyfDC0OU75aXDZuWBO
         kIuMUZL7n6b9/DD+HVhmOyMRrycL4vhgqSa8tf5IEKIIbTanfTIGAz13dzcd4AbB/v
         QWuiGV9u+Pz2QRhyEMUdWBK+VYO36S0VymdZWiKsG74eiIdWzFFR9TPQIyXM3KDokZ
         jvoa8+1gIvF2Q==
Received: from thinkos.internal.efficios.com (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4SMTCn2mF4z1b5n;
        Fri,  3 Nov 2023 14:04:37 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Rik van Riel <riel@surriel.com>
Subject: [PATCH] rseq uapi: Remove unused header <asm/byteorder.h>
Date:   Fri,  3 Nov 2023 14:04:53 -0400
Message-Id: <20231103180453.81188-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit bfdf4e620805 ("rseq: Remove broken uapi field layout on 32-bit little endian")
removed use of asm/byteorder.h without removing the include.

Remove the now unneeded asm/byteorder.h include.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Reported-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
---
 include/uapi/linux/rseq.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/uapi/linux/rseq.h b/include/uapi/linux/rseq.h
index c233aae5eac9..2c89d421d9f4 100644
--- a/include/uapi/linux/rseq.h
+++ b/include/uapi/linux/rseq.h
@@ -11,7 +11,6 @@
  */
 
 #include <linux/types.h>
-#include <asm/byteorder.h>
 
 enum rseq_cpu_id_state {
 	RSEQ_CPU_ID_UNINITIALIZED		= -1,
-- 
2.39.2

