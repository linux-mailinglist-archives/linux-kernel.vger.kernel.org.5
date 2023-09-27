Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110237B02CE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 13:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbjI0LZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 07:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbjI0LZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 07:25:44 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65A3196
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 04:25:42 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id ffacd0b85a97d-321726b0238so7932156f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 04:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695813941; x=1696418741; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yFhKKi5b0kZOlGKtkzEc+xU7GiAAYZeYNUbkjyCvZbk=;
        b=eddof2vAUlqPkEr0fgFU+VyV/kH9YKQrI6vugFkq2P7bvCTTgESwfHGFil4bzhtMl0
         KrH9kuV8IY3X2d80TCPVBiKOK+tYv/+lqKeXfiTyefIppllUELvK6FvVZNimyg31Olic
         jdlqZ7ewidZClJDrDt3nJb/zs+CMd38QsKccdiqiKIRkmyqybZsF3Uy1zj2pQ+jfnvdk
         t8uCZQhTgzzC2CljsWnD0F8UgT7xmiRRXJqVg97d4XWY3LEivnBYGP3UEIjtYgUBUA29
         tHTwe3KFfmT/7jHelg5PKKdU13b4rLKSw+AWsK1nJlw96JUAGsSJkMqiv+Ic+SLMza5y
         LDGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695813941; x=1696418741;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yFhKKi5b0kZOlGKtkzEc+xU7GiAAYZeYNUbkjyCvZbk=;
        b=e1OAHmETGbhjyjcgq/kXPq4DI2Mbnzex/n2U76u4uSVONzax9Cpnf3z3GKua/KiUk0
         DMxifo5NV8RLHbzNZr+QkZFRM7rf2jxXM6zMfbh3K+nqpdZDWy9lVFemkDFHrFaNi01o
         Cw5Cc3hoNAUqSj7C99oO/ZMFBN9/cpLxzla7kL6bMgtAW0US1/W3aVx3VAQxe8GTDVAD
         UxgEPGqTl0eLJeTjZARN0apN2L3zv72U6ArRnabMruIUxurS2TrXysWq/uwZ3ArwdePb
         djB07UrlpwSE5HaxJJYqEcpFxFOilygpHG792lRe+2vF2/f/XuFDZhE69eQpqLgSWSqP
         bfpQ==
X-Gm-Message-State: AOJu0YzfrDlwopyu03AdTjsGvXTO9TZvshseCIIVzvk+AAv+an2e3WB/
        fEwVaWVoOBx6OsqhA6GS8E1k3SQX7SDl0yB8QBPdBsV749lufbE0x3YZTr5oz/Wy0ViU6HVrhj9
        ce/2McXpeNtzF6tkpVRPy1mebj7Tl8ijUb8OkGF2UzV6xgzuUbj/Ak1tqSLv08MONayviwNtjlq
        tV96y6o343Pw==
X-Google-Smtp-Source: AGHT+IHKEuDH0i7W6abd6m/FA4iJtttRR1PidF3gfTdPTEDxnvXufwWZGsvQ4Ffnqs7I/iIQQHd0V68WBHfehyLrPFc=
X-Received: from seb.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:31bd])
 (user=sebastianene job=sendgmr) by 2002:a5d:6142:0:b0:321:6a06:8d1c with SMTP
 id y2-20020a5d6142000000b003216a068d1cmr7122wrt.1.1695813941137; Wed, 27 Sep
 2023 04:25:41 -0700 (PDT)
Date:   Wed, 27 Sep 2023 11:25:08 +0000
In-Reply-To: <20230927112517.2631674-1-sebastianene@google.com>
Mime-Version: 1.0
References: <20230927112517.2631674-1-sebastianene@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230927112517.2631674-3-sebastianene@google.com>
Subject: [PATCH 02/11] arm64: ptdump: Use the mask from the state structure
From:   Sebastian Ene <sebastianene@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, will@kernel.org, ryan.roberts@arm.com,
        mark.rutland@arm.com, maz@kernel.org, vdonnefort@google.com,
        Sebastian Ene <sebastianene@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Printing the descriptor attributes requires accessing a mask which has a
different set of attributes for stage-2. In preparation for adding support
for the stage-2 pagetables dumping, use the mask from the local context
and not from the globally defined pg_level array. Store a pointer to
the pg_level array in the ptdump state structure. This will allow us to
extract the mask which is wrapped in the pg_level array and use it for
descriptor parsing in the note_page.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 arch/arm64/mm/ptdump.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
index e305b6593c4e..8761a70f916f 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -75,6 +75,7 @@ static struct addr_marker address_markers[] = {
 struct pg_state {
 	struct ptdump_state ptdump;
 	struct seq_file *seq;
+	struct pg_level *pg_level;
 	const struct addr_marker *marker;
 	unsigned long start_address;
 	int level;
@@ -252,11 +253,12 @@ static void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
 		      u64 val)
 {
 	struct pg_state *st = container_of(pt_st, struct pg_state, ptdump);
+	struct pg_level *pg_info = st->pg_level;
 	static const char units[] = "KMGTPE";
 	u64 prot = 0;
 
 	if (level >= 0)
-		prot = val & pg_level[level].mask;
+		prot = val & pg_info[level].mask;
 
 	if (st->level == -1) {
 		st->level = level;
@@ -282,10 +284,10 @@ static void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
 			unit++;
 		}
 		pt_dump_seq_printf(st->seq, "%9lu%c %s", delta, *unit,
-				   pg_level[st->level].name);
-		if (st->current_prot && pg_level[st->level].bits)
-			dump_prot(st, pg_level[st->level].bits,
-				  pg_level[st->level].num);
+				   pg_info[st->level].name);
+		if (st->current_prot && pg_info[st->level].bits)
+			dump_prot(st, pg_info[st->level].bits,
+				  pg_info[st->level].num);
 		pt_dump_seq_puts(st->seq, "\n");
 
 		if (addr >= st->marker[1].start_address) {
@@ -316,6 +318,7 @@ void ptdump_walk(struct seq_file *s, struct ptdump_info *info)
 	st = (struct pg_state){
 		.seq = s,
 		.marker = info->markers,
+		.pg_level = &pg_level[0],
 		.level = -1,
 		.ptdump = {
 			.note_page = note_page,
@@ -353,6 +356,7 @@ void ptdump_check_wx(void)
 			{ 0, NULL},
 			{ -1, NULL},
 		},
+		.pg_level = &pg_level[0],
 		.level = -1,
 		.check_wx = true,
 		.ptdump = {
-- 
2.42.0.515.g380fc7ccd1-goog

