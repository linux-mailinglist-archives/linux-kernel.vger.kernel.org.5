Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11EFF7B02CD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 13:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbjI0LZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 07:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbjI0LZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 07:25:45 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2A719A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 04:25:44 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d86766bba9fso13150854276.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 04:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695813943; x=1696418743; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=U2wy+Fu981b0iBfz2jBuvwB+Vk21Fc177L9d68PfARs=;
        b=BAZ0KFt1EM8ivr1Y5hQhqP/nypHmW1fCzekhJ9EaoBpOHR1z7Fh9PfVxIQqPzqOi+f
         gybmrPQZLQkvFCPQ5iiM/TGjXJwlvoZmo38Ob5KXiz72aRBQO/xeV+PDV/bWzsBW6laA
         XnMoWA6a3q1tfrMDEziOHwE/tXq8Q2koOPTGiKfbPSz9o+FplMl1jmLkTh3Xvjbbtsc1
         8iv7gDk0+iSDDmUOfnI43a4x6TdAtZZ7h1XswwWBACabmwXqgr+69/o2ruomcuXU9zoD
         ahOKIKtFOef49E6C6v8tpJ6exYPqvuTJEZ7J+fvm/Shiu8Gaz+abvrkgfNnn7LBBBYbD
         T2wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695813943; x=1696418743;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U2wy+Fu981b0iBfz2jBuvwB+Vk21Fc177L9d68PfARs=;
        b=ECkytPrT+/Ka1vLbjXe47yL7xTM7Gec2Nylr7lBmUXflJjZoT2ahaYhRSgvVYoepAI
         qAOuuEJqeCxzUuqEtAhCPlq/AalcoGePOQ88Upt5H2p/GNd64UEb52YSfJj6+pSV32Dq
         lxxfFlBRb3ZgY2hGQsWfzgeS+Ucve6xHWh0IQA5eSDFuT2nsMPwLZSsI+2Fjhix5QAq5
         cqcY2hjUaMjqjq8dQ3ez1YkJPNehhsr3wb72OaCdOtDJgVGXLi2hCCMkS1qtyIK1wNHM
         kFRnRhOa+O8zP+SBmWsm4P+HfuZ0okzl5ATav0xEkazM3iTLQhf54ag191x0iKjo4qP0
         GZGQ==
X-Gm-Message-State: AOJu0YxOuhX2Yz4sOS0HSt9kiHfT/HbFE8dxup1DLpW95YTvo/ssMLS9
        8yYxj/5Fa7MpoE9EOz4mDYmrr8VZ0MFg5l+5x4wa9UPQRtGit4ty94KwTOiNY3Mu7Hc7gDzn5jp
        BI1f0AG1rQbmQn7p4HRzb/+wcNzFKC62XnfpoRPwhn8bvyryuTLmIFFWSVL5zw+tn+6CT4V2A5i
        ZKbqWWXN3pfw==
X-Google-Smtp-Source: AGHT+IHE1d/qx6ZK7HTNWLOEfLLo0i0A/+QUCavU/gsepqwY0D/S0f1oYVVYLxPSpQI65Os7gYFbmS4CVScRHM5mPhI=
X-Received: from seb.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:31bd])
 (user=sebastianene job=sendgmr) by 2002:a25:ac89:0:b0:d86:5500:7dba with SMTP
 id x9-20020a25ac89000000b00d8655007dbamr22642ybi.13.1695813943422; Wed, 27
 Sep 2023 04:25:43 -0700 (PDT)
Date:   Wed, 27 Sep 2023 11:25:09 +0000
In-Reply-To: <20230927112517.2631674-1-sebastianene@google.com>
Mime-Version: 1.0
References: <20230927112517.2631674-1-sebastianene@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230927112517.2631674-4-sebastianene@google.com>
Subject: [PATCH 03/11] arm64: ptdump: Add the walker function to the ptdump
 info structure
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

Stage-2 needs a dedicated walk function to be able to parse concatenated
pagetables. The ptdump info structure is used to hold different
configuration options for the walker. This structure is registered with
the debugfs entry and is stored in the argument for the debugfs file.
Hence, in preparation for parsing the stage-2 pagetables add the walk
function as an argument for the debugfs file.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 arch/arm64/include/asm/ptdump.h | 1 +
 arch/arm64/mm/ptdump.c          | 1 +
 arch/arm64/mm/ptdump_debugfs.c  | 3 ++-
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/ptdump.h b/arch/arm64/include/asm/ptdump.h
index 581caac525b0..1f6e0aabf16a 100644
--- a/arch/arm64/include/asm/ptdump.h
+++ b/arch/arm64/include/asm/ptdump.h
@@ -19,6 +19,7 @@ struct ptdump_info {
 	struct mm_struct		*mm;
 	const struct addr_marker	*markers;
 	unsigned long			base_addr;
+	void (*ptdump_walk)(struct seq_file *s, struct ptdump_info *info);
 };
 
 void ptdump_walk(struct seq_file *s, struct ptdump_info *info);
diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
index 8761a70f916f..d531e24ea0b2 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -346,6 +346,7 @@ static struct ptdump_info kernel_ptdump_info = {
 	.mm		= &init_mm,
 	.markers	= address_markers,
 	.base_addr	= PAGE_OFFSET,
+	.ptdump_walk	= &ptdump_walk,
 };
 
 void ptdump_check_wx(void)
diff --git a/arch/arm64/mm/ptdump_debugfs.c b/arch/arm64/mm/ptdump_debugfs.c
index 68bf1a125502..7564519db1e6 100644
--- a/arch/arm64/mm/ptdump_debugfs.c
+++ b/arch/arm64/mm/ptdump_debugfs.c
@@ -10,7 +10,8 @@ static int ptdump_show(struct seq_file *m, void *v)
 	struct ptdump_info *info = m->private;
 
 	get_online_mems();
-	ptdump_walk(m, info);
+	if (info->ptdump_walk)
+		info->ptdump_walk(m, info);
 	put_online_mems();
 	return 0;
 }
-- 
2.42.0.515.g380fc7ccd1-goog

