Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB3980A0FD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 11:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573628AbjLHKbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 05:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573601AbjLHKaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 05:30:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB301BF5
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 02:30:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D7A8C433C8;
        Fri,  8 Dec 2023 10:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702031451;
        bh=AhqKrJz5NqAxQZJTxzvS35/o9mTQRDXLSjKOCvX5P6o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RqLPmJs6TkupePJ2oGnCaudjklWh6g++k1H9atKQBrD8KabE4wb6g0uuD33T+1eFK
         0nemWBH76Y3LbfpdXMkgjEygZaAidOYJe1SG1a/7EOCNl+y+48+w86GAexcyZIyGFz
         matj65644y6tNsVQrLQxs4AuK4aFqBZzCjf0OB8eBE4FyKh8sogPrXEC9BZbI4StB3
         9rswzhCItDzN+9rv07YxsBeZEfUNbwI4lsklJC5H2CPgwS6WdIn999nP6mdqC9Ernt
         yo9M+vquknu2/xp+j0C4IKIgZSePQQmHEoShiXF1pHg/oShog2UZq3BVxVq3SWz1qK
         LfpQzJ1P2/BLA==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Florent Revest <revest@chromium.org>
Cc:     linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alan Maguire <alan.maguire@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Guo Ren <guoren@kernel.org>
Subject: [PATCH v4 32/33] selftests: ftrace: Remove obsolate maxactive syntax check
Date:   Fri,  8 Dec 2023 19:30:44 +0900
Message-Id: <170203144437.579004.4423247283109714307.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <170203105427.579004.8033550792660734570.stgit@devnote2>
References: <170203105427.579004.8033550792660734570.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Since the fprobe event does not support maxactive anymore, stop
testing the maxactive syntax error checking.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
index 20e42c030095..66516073ff27 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
@@ -16,9 +16,7 @@ aarch64)
   REG=%r0 ;;
 esac
 
-check_error 'f^100 vfs_read'		# MAXACT_NO_KPROBE
-check_error 'f^1a111 vfs_read'		# BAD_MAXACT
-check_error 'f^100000 vfs_read'		# MAXACT_TOO_BIG
+check_error 'f^100 vfs_read'		# BAD_MAXACT
 
 check_error 'f ^non_exist_func'		# BAD_PROBE_ADDR (enoent)
 check_error 'f ^vfs_read+10'		# BAD_PROBE_ADDR

