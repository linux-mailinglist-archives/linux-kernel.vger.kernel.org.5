Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDE57E8BD9
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 18:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjKKRUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 12:20:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKKRUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 12:20:38 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E0A3868;
        Sat, 11 Nov 2023 09:20:35 -0800 (PST)
Received: from localhost ([173.252.127.16]) by mrelay.perfora.net (mreueus003
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MVerB-1qtMG72qyt-00Z2Iv; Sat, 11 Nov
 2023 18:20:24 +0100
From:   Jordan Rome <linux@jordanrome.com>
To:     linux-perf-users@vger.kernel.org
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH v2] perf: get_perf_callchain return NULL for crosstask
Date:   Sat, 11 Nov 2023 09:20:01 -0800
Message-Id: <20231111172001.1259065-1-linux@jordanrome.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:s2eFJhlecoDiCk+dLUOWdzHXVSfIPqWK8rQs8+oEb7pPamWVzmH
 lDJ1PtH/liy8GPSArfaTBzjd5ZsVUbtVVUKSNYm5fc3aW1gP80qShj6t26b7mWmzyzazZWr
 PFkGvcIQcI0OHDWgWhnq4UEvvP7hg2s+4s2PF3rKHr/Du+anvAe8Cb/81RGDpgSek3/VuV9
 Hj4nh3Q5nz4k4ekFNvIxg==
UI-OutboundReport: notjunk:1;M01:P0:fruvtgheXxY=;TnPHChnpK8ROngAKulxwnbR5Z1l
 CljawbclxrJeeL2qtHEE1srUXWRt0rbM44KHE9A+Ae+IpINO6FUz3Ln27mPiOqGyWbLvtkIS6
 ngM1vNHfy9NwetrVtiXfQUYGPPOmA6UwLXniqK2IqLexeBrqoXOZETwHYaaReA67OQ+gN2+/R
 /VIhlmK8DT3rWp2341Kh1iWxk6vy99Z4HOc0zJW9BepHCwfuGrgjSiRYd4nDlWuwdpRGeCLkH
 cTXPNsFOLROg2EfCpZgTuowISWKgJ/cKKdMp+YcYD2dmmRelXvNsnpjRMYGECQhqw9gm4Dq8w
 K5YgVcWpks3RSIYIrZBzcfPC5WIR8e7YpZS4b4KFYKwp0ADRJdPmOzltHD4BIGCUNPGE+xio+
 ACkKzmtaay17r4HHi97nOQQSsZwKlLEoYWLtJ5PlrBpLmmW8x3nksxknQ2ap4DgN+I7iiDc67
 Ux5jX3rNwQ08qgHRzI1r4eZEBv+prxrCvuUgyc1EWl/ZDDeBLzwsMtAE5E6EKlwB6b5eYBBXL
 0ypKNT4AueQc9ZCmlmEJPo97RSkVXFlU26L5CwFUS5ffKAybpc2/Y67GSnJr/6ppBWezHoPAn
 Utmkqa3IZ1R3AX6ikRMOUbPK6fx/kfHnLO4k8btge0BHPBXa6uIO+Tj0ehkv+EkZT9LbYnJlg
 qYTN7la4fpkLBZc79gTJQaNA31B3UUikQ4ndUhnfzV2eetHAIBO9jGCQdWLLxBNkwT5htoN1Y
 GEVzz1dv1VrYm0hWtAGj4AUQgPfrOaouSFDDCz6jzU5h26vFIF+7AtCg8D9QSppiOQnSnwI8G
 Zo6YmkD4faN4x2LPBxFazOb/sOhcDT3VdhiKXlq+cm9bPJVPsVoSGBwSrQZOF1Juh8VJTjYzN
 HgvdQJ2L/4GBM5g==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

Changes in v2:
* move user and crosstask check before get_callchain_entry

v1:
https://lore.kernel.org/linux-perf-users/CAEf4BzaWtOeTBb_+b7Td3NHaKjZU+OohuBJje_nvw9kd6xPA3g@mail.gmail.com/T/#t

 kernel/events/callchain.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index 1273be84392c..104ea2975a57 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -184,6 +184,9 @@ get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
 	struct perf_callchain_entry_ctx ctx;
 	int rctx;
 
+	if (user && crosstask)
+		return NULL;
+
 	entry = get_callchain_entry(&rctx);
 	if (!entry)
 		return NULL;
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

