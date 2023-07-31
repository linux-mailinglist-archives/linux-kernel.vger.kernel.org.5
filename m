Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63265769AE0
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 17:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbjGaPfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 11:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjGaPfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 11:35:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7765A10E;
        Mon, 31 Jul 2023 08:35:08 -0700 (PDT)
Date:   Mon, 31 Jul 2023 15:35:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690817706;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ldM+3pgXUgWaZNvBwYXJS/HNOl5JkYqfSYkyogKmt9A=;
        b=dOzLRz9deMwbcEmDkqG1t8PJCYnGF+mdYbtZy/JvvE7KdFPxob+8Wke8HeJWBRMvTKhvLA
        cg19zFP9HPzC/qy+RN2419lxuwIDUb0LMDH+V24EawHvtSUIiIJ1V2dR5/9bzH6/Z3NiEL
        mCF/lYWhXJovSYmD2d2P8h/+tWPOmIHFW+5Yb9OaH0vVEjzBmJU4H9BW7pl1FYUvqtIXqE
        tvyK6lKCDZYSgf/xoKrhVeu8Llv5jAdpC273FJT6Nmt8TWw4ifVOP5oILZNZ4bEQnLdxxr
        WdkEpseJyCtHntPQQFaSvQL2I95pbdEF1UxRjZSPAhEhi1+CL2+oJKfup05JLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690817706;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ldM+3pgXUgWaZNvBwYXJS/HNOl5JkYqfSYkyogKmt9A=;
        b=ffgNOlzVacdN9ubeGT/hfRf2yfaR4XqKZrw4URs9GTpP8p8EocFmfMaD1yHGMTFAhzHx/X
        TA/xsQAOOWKxP7BQ==
From:   "tip-bot2 for YueHaibing" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Remove unused extern declaration
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20230720143625.29176-1-yuehaibing@huawei.com>
References: <20230720143625.29176-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Message-ID: <169081770575.28540.2012624944313442879.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     51a5acce7162185a9b9d695b314a12fc067562b4
Gitweb:        https://git.kernel.org/tip/51a5acce7162185a9b9d695b314a12fc067562b4
Author:        YueHaibing <yuehaibing@huawei.com>
AuthorDate:    Thu, 20 Jul 2023 22:36:25 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 31 Jul 2023 17:27:16 +02:00

genirq: Remove unused extern declaration

commit 3795de236d67 ("genirq: Distangle kernel/irq/handle.c")
left behind this.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230720143625.29176-1-yuehaibing@huawei.com

---
 kernel/irq/internals.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 831f383..bcc7f21 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -108,8 +108,6 @@ extern int __irq_get_irqchip_state(struct irq_data *data,
 				   enum irqchip_irq_state which,
 				   bool *state);
 
-extern void init_kstat_irqs(struct irq_desc *desc, int node, int nr);
-
 irqreturn_t __handle_irq_event_percpu(struct irq_desc *desc);
 irqreturn_t handle_irq_event_percpu(struct irq_desc *desc);
 irqreturn_t handle_irq_event(struct irq_desc *desc);
