Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F757B72D1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 22:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241111AbjJCUw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 16:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241092AbjJCUwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 16:52:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1397B0;
        Tue,  3 Oct 2023 13:52:50 -0700 (PDT)
Date:   Tue, 03 Oct 2023 20:52:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696366369;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=L7pOdetM+P4pc6mRhfoVmVzqpr/+i+2U4MnNXjzbcKM=;
        b=vjO6qtFSRqkw5AbjQCWpl+QyLCXzSTSwuYU9izgeoo8FIrsShRXHSBXX9dyXlqosOvkKoL
        jH7SF/0Jq5bd1pZOiObJefVuzUlW2ytRtAotw4+eXerfqXeB5A5jjtf0fVsaUX7kbOUt8w
        /Tu1O2wS/OuePRYvWL5WKgh+Mhtda5EohJUHqKSflj7UG4nMfECqiFoVLt9r97ZFrR9GS6
        b7K/4Qobw6gwDsXuOjmnvWH0CvyrHpZNf3HFDEX4JlJd9iCRcYUNxxo+RkI3x/msuG5RpY
        38gL6vlAnTlz7cA7G97Os2WIoAVAgyUVA5Qa1Rj4DjfMetTdKxG8ykaTPn8KWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696366369;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=L7pOdetM+P4pc6mRhfoVmVzqpr/+i+2U4MnNXjzbcKM=;
        b=SFgc1I7OcQrvfL8+X0ahdw5JgvXc+5VTxgyGT5zGOWTL+BqzZkiNHlnCDgi6dqMdb0oq9n
        l/aB3XK7YIk2jHCA==
From:   "tip-bot2 for Zhu Wang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu/xstate: Address kernel-doc warning
Cc:     Zhu Wang <wangzhu9@huawei.com>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
MIME-Version: 1.0
Message-ID: <169636636857.3135.274434390730403690.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     90879f5dfcf6cf1d56f4d1b696a25c44e1f5ba14
Gitweb:        https://git.kernel.org/tip/90879f5dfcf6cf1d56f4d1b696a25c44e1f5ba14
Author:        Zhu Wang <wangzhu9@huawei.com>
AuthorDate:    Mon, 31 Jul 2023 19:34:57 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 03 Oct 2023 22:46:12 +02:00

x86/fpu/xstate: Address kernel-doc warning

Fix kernel-doc warning:

  arch/x86/kernel/fpu/xstate.c:1753: warning: Excess function parameter 'tsk' description in 'fpu_xstate_prctl'

Signed-off-by: Zhu Wang <wangzhu9@huawei.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/kernel/fpu/xstate.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index cadf687..50d7bde 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1736,7 +1736,6 @@ EXPORT_SYMBOL_GPL(xstate_get_guest_group_perm);
 
 /**
  * fpu_xstate_prctl - xstate permission operations
- * @tsk:	Redundant pointer to current
  * @option:	A subfunction of arch_prctl()
  * @arg2:	option argument
  * Return:	0 if successful; otherwise, an error code
