Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4FA47E58FB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 15:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344700AbjKHOa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 09:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235293AbjKHOab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 09:30:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6709211C
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 06:30:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F93EC433C9;
        Wed,  8 Nov 2023 14:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699453814;
        bh=AhqKrJz5NqAxQZJTxzvS35/o9mTQRDXLSjKOCvX5P6o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AmVmAGS6UPjGDDLld618eNkaJetnI3xph8H/45Ftb7Enzj4azti9eJamMamY+PC1T
         b6F782CsT8JsxDNHZple32ZIygwqzfNshMO5bgYvw8WgAKMieg04pGC9OuOYL+AZ+P
         2Z1zV8JBPcKp8DPywUFpzmDCDh9Qsr/v/GYrTn9SKZ6+GkumlLyOwAsSPz5vrZsA8D
         izNLvGM0UJApAarCY1PabzlCJfpbDeRbmKBbVFfh90DHwvoBMOxA+0Vc7uTIrIYqeU
         aOA2P2oh6Cp+6OVG2CM83EopprXGS2+jCWNrD7Ghyr9fm26ODFHPduuKhGcgWNKpuW
         RjCE+rUuSqOwQ==
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
Subject: [RFC PATCH v2 30/31] selftests: ftrace: Remove obsolate maxactive syntax check
Date:   Wed,  8 Nov 2023 23:30:09 +0900
Message-Id: <169945380880.55307.12670793997291033248.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <169945345785.55307.5003201137843449313.stgit@devnote2>
References: <169945345785.55307.5003201137843449313.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

