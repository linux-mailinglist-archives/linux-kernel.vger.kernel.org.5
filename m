Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92CC7E86C8
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 00:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjKJX5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 18:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235278AbjKJX5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 18:57:03 -0500
X-Greylist: delayed 313 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 10 Nov 2023 15:56:35 PST
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AEA47BA;
        Fri, 10 Nov 2023 15:56:35 -0800 (PST)
Received: from localhost ([173.252.127.6]) by mrelay.perfora.net (mreueus003
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LtYx8-1rQjKW1h12-010xXD; Sat, 11 Nov
 2023 00:51:04 +0100
From:   Jordan Rome <linux@jordanrome.com>
To:     linux-perf-users@vger.kernel.org
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH perf] perf: get_perf_callchain return NULL for crosstask
Date:   Fri, 10 Nov 2023 15:50:21 -0800
Message-Id: <20231110235021.192796-1-linux@jordanrome.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:a6BVsRL2QRpAGaOBDD1hPPv2MbJ4fjgivIhGK89IR6F1Es22JW5
 EjTfkYVl8kvZNLUGrRy5VhllM84wfApjuMhjhHU9ILgscjvmbFkwp6n0WWlEHZyEFsWuTKk
 uDb7MDVHxR7uBtqx4IfUjTkgKBWAGdgu0eYQtRMRhhoOFEGfbEtp2/Ep0Qo48svwQ0qqpN2
 g868W0KIFAKc6YEDAW6Sw==
UI-OutboundReport: notjunk:1;M01:P0:/ES/WiAn14I=;UDkRPJ6QSK0f/ugHCl3Fxb640kB
 Ko1MpqQFSQrQH+1JMsU5rD9By19oUarED4fhbpGfhRGJNp+b5F/b5KbxHVPdF4Ru2IKMVOx0+
 ayGM25/ztCbgn0YVMk7V3FqIZh1xvPUa4dF/ZrFIVUg5HhK3wTM5/gPpnICeXGdl5aHt9ka+b
 GvnZcHih62dDioJ+y3qNiI8y6/e6OnhEmUhRgJTXoUZHx18BeeVqkp90bZfmjfsIjGekvE89O
 wOhbMuKn+lZQP+MMwcZsMUd8ikjGOe1mlcLOEJEn07xKQRctaMDXkbu6WL4jA6F/3XAZakLTM
 fU/qT/mbQLXuRjPfBVRTZXWBQvx3VL6Dv6C/jLKVnLL5wy1HkC3rowE0G02pIsukaLWv+QfAk
 8eG6mWicO+vTpkjNfSyoA1y/nap20dX8R10rZ/xZkjlKKw01B5H7Ct6VRxz01/DJIX084/GVj
 VpKaxx/JKioGeCySB9MYs06+dzYfCwbqX1CgTIF50qWL3E/0vcNpAdRsZeqAFI45X5sZcPY8N
 J12poUZv6YosamRWCT1542GlyCNfdmRJAAPUgVPWEEmsnLxXV3w0pEufYYnmYQ2QF02yTio02
 SXkiyLae08ZUX1lBoQA0W0fYC9Xs3QyFczN9Fo/F2clpzmgfPsWXxNQMkmhu2axXG70+MxsTW
 G6Ae3uTt/5gAw9muWauTU9TEsRuKHdVHZS9EkN5OMgsn3uY+ra2F7oA2LH3XTHyqExwj57ZCg
 7GJNJ1WHT8wDfUqOMQrwbmg03iI9m6XntrAsNaU7Dtxzy8oZyoLjhLkkI7QGqQuEMrGkqJQ9x
 6HForIw+ibAA+EueskYQosMv6xxtCtACmyvkbqeS8Qji99dkqlCQauqF6gSU3oaL6wZbRe8mD
 4RGZmyl9MB1+zYw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return NULL instead of returning 1 incorrect frame, which
currently happens when trying to walk the user stack for
any task that isn't current. Returning NULL is a better
indicator that this behavior is not supported.

This issue was found using bpf_get_task_stack inside a BPF
iterator ("iter/task"), which iterates over all tasks. The
single address/frame in the buffer when getting user stacks
for tasks that aren't current could not be symbolized (testing
multiple symbolizers).

Signed-off-by: Jordan Rome <linux@jordanrome.com>
---
 kernel/events/callchain.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index 1273be84392c..430fa544fa80 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -201,6 +201,9 @@ get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
 	}
 
 	if (user) {
+		if (crosstask)
+			return NULL;
+
 		if (!user_mode(regs)) {
 			if  (current->mm)
 				regs = task_pt_regs(current);
@@ -209,9 +212,6 @@ get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
 		}
 
 		if (regs) {
-			if (crosstask)
-				goto exit_put;
-
 			if (add_mark)
 				perf_callchain_store_context(&ctx, PERF_CONTEXT_USER);
 
@@ -219,7 +219,6 @@ get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
 		}
 	}
 
-exit_put:
 	put_callchain_entry(rctx);
 
 	return entry;
-- 
2.39.3

