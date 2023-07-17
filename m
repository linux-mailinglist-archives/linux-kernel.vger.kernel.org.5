Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07CB75639E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 14:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbjGQM6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 08:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbjGQM6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 08:58:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488CF10FB;
        Mon, 17 Jul 2023 05:57:42 -0700 (PDT)
Date:   Mon, 17 Jul 2023 12:56:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689598574;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4YPXrSDRAI1Wvsk54evbV6+et0hDPpMbEgKCLV0r/JA=;
        b=EHatAVshL7cC1A4+CVBBmyfc4zBk8+QCvcXZrKpphpedbdXQNu/Jy32Er0e0B+744Paj+4
        SR9tQAVIFStlakRU42dasKFhVnZrs5F83+ESynjHeWm/t5sNbR1RUmivRbCd8YrcnDAA+N
        USG+tyvbTzYwicK4G4d2DEy3M6Kj34DY46IMeOt6crPcg4N+i8L3AFMPQkw9FIxZA31rik
        EmBtvD2feOxSM9eMn637l+64Ih4ROgF+0zUpHznkgbTceV9XDGDlK79jIZwhdYEt8HafCg
        c2VABfnXEoW7qhdA4LIk0qiV3XFGmIh7+rGxcg19lZWGVL9Of8+N3rxapbFhlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689598574;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4YPXrSDRAI1Wvsk54evbV6+et0hDPpMbEgKCLV0r/JA=;
        b=3y0wKKFdYP0oFqJcbUvdZ5E0gzKr/jM2K6scUhsCxCOYrUR4UGN8ayeKT4IvJMRdEbVVJ2
        UiOH+B4JoAPSlcDA==
From:   "tip-bot2 for Miaohe Lin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/psi: make psi_cgroups_enabled static
Cc:     Miaohe Lin <linmiaohe@huawei.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230525103428.49712-1-linmiaohe@huawei.com>
References: <20230525103428.49712-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Message-ID: <168959857356.28540.9279418825754491164.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     35cd21f6292c6656aaab6066a1fa13cd11ca27f5
Gitweb:        https://git.kernel.org/tip/35cd21f6292c6656aaab6066a1fa13cd11ca27f5
Author:        Miaohe Lin <linmiaohe@huawei.com>
AuthorDate:    Thu, 25 May 2023 18:34:28 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 13 Jul 2023 15:21:50 +02:00

sched/psi: make psi_cgroups_enabled static

The static key psi_cgroups_enabled is only used inside file psi.c.
Make it static.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Link: https://lore.kernel.org/r/20230525103428.49712-1-linmiaohe@huawei.com
---
 kernel/sched/psi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 81fca77..2ccb0b2 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -140,7 +140,7 @@
 static int psi_bug __read_mostly;
 
 DEFINE_STATIC_KEY_FALSE(psi_disabled);
-DEFINE_STATIC_KEY_TRUE(psi_cgroups_enabled);
+static DEFINE_STATIC_KEY_TRUE(psi_cgroups_enabled);
 
 #ifdef CONFIG_PSI_DEFAULT_DISABLED
 static bool psi_enable;
