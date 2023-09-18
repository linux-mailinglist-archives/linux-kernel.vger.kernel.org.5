Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09227A436D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 09:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240333AbjIRHtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 03:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240446AbjIRHss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 03:48:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2E8191;
        Mon, 18 Sep 2023 00:45:47 -0700 (PDT)
Date:   Mon, 18 Sep 2023 07:45:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695023144;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zUb2/FWSHOkypAisRqXH49SPDxQ0fESsbVzSr5ZK9sY=;
        b=Uc1lrIHlM0yRMPZNphkJQsS+OxPlF9cd2TJibdgJILlHFpZhzeEgQFyjiwdV/kSh4a3Fob
        gKTFVKxpLUWpK3wWvJkEh+wQHKr4qlyaT9Vs3S79vmwyCcJDU3ltWwNBGdMI2zIGAO/wAm
        RARPdFaeRYLLzZJEbA32eyIaStsOcSR87smCJXxJzMI+gvLhdMhkwDvkEnVY5HZf2tMP5W
        u8i9idx4ShJufhGhmqR78Jxk/8dRo8a/1+jzmiSm+lrKIMaTOS5LH1GC2E93XanpBd7csD
        QIKVfiHaE2ic8CPPh5tCvwtTIChOxq/sGrDiIHy0FsaoqfpXulGL/ZCJsx3mJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695023144;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zUb2/FWSHOkypAisRqXH49SPDxQ0fESsbVzSr5ZK9sY=;
        b=mFQMZPvBsYcX+nKU0r+7SzJg8NqFtpWicztE9sxCsULXvTW5fOFxFkjcNUao+N5tpXffas
        OVke34XzWj9e45DQ==
From:   "tip-bot2 for GUO Zihua" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/headers: Remove duplicated includes in
 kernel/sched/sched.h
Cc:     GUO Zihua <guozihua@huawei.com>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230818015633.18370-1-guozihua@huawei.com>
References: <20230818015633.18370-1-guozihua@huawei.com>
MIME-Version: 1.0
Message-ID: <169502314296.27769.160204530264678474.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     7ad0354d18ae05e9c8885251e234cbcf141f8972
Gitweb:        https://git.kernel.org/tip/7ad0354d18ae05e9c8885251e234cbcf141f8972
Author:        GUO Zihua <guozihua@huawei.com>
AuthorDate:    Fri, 18 Aug 2023 09:56:33 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 18 Sep 2023 09:41:37 +02:00

sched/headers: Remove duplicated includes in kernel/sched/sched.h

Remove duplicated includes of linux/cgroup.h and linux/psi.h. Both of
these includes are included regardless of the config and they are all
protected by ifndef, so no point including them again.

Signed-off-by: GUO Zihua <guozihua@huawei.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230818015633.18370-1-guozihua@huawei.com
---
 kernel/sched/sched.h |  9 ---------
 1 file changed, 9 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 887468c..5f217b1 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -74,15 +74,6 @@
 
 #include "../workqueue_internal.h"
 
-#ifdef CONFIG_CGROUP_SCHED
-#include <linux/cgroup.h>
-#include <linux/psi.h>
-#endif
-
-#ifdef CONFIG_SCHED_DEBUG
-# include <linux/static_key.h>
-#endif
-
 #ifdef CONFIG_PARAVIRT
 # include <asm/paravirt.h>
 # include <asm/paravirt_api_clock.h>
