Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75AF479032F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 23:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjIAVts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 17:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350801AbjIAVmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 17:42:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673D32101;
        Fri,  1 Sep 2023 14:39:37 -0700 (PDT)
Date:   Fri, 01 Sep 2023 21:39:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693604375;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r1rbe0+qLjSIdXob5RQEh6hDPQoTXLohm3YDfo90QS8=;
        b=hJFaRRL2vfHw+TVmYRkeQXZcsI6a5HhWTuiQOAcLAnDYHqVaq2NFeZz35gqCZcCMadZNOD
        aTrXIDOKzCyKjQqqLbu7DcO2tVLnvePEPx4SQ93tj1bI/ZNWr0cVTGbit8GfgvjYV0zceU
        LQ7o1eTEfRUXN06dXukciSOo8ynUQ3l4dYlIFh4WliAZT/uJ8zo6bX/74KioeWafG6w5kA
        q4UkA6fyK07NQN07Z1Dt9WQ6GbGHRlTahdP/ne6R/KrJRVy7GNxkt6WNbVStU7vG75MK+x
        bRGIoYd3e8D5xRSZ6FBVQCJr3twIzNyIuVTafyRd1wsqdKI+wTSJmC8KyyA2FA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693604375;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r1rbe0+qLjSIdXob5RQEh6hDPQoTXLohm3YDfo90QS8=;
        b=e8PSjHwxEbW17Hb3oBKDdzO8090MMf3IGAyVmvKsDj/nGNzCrZnBQb2eX5o9O069dE2fVm
        N/J7hSdeRVGMguCg==
From:   "tip-bot2 for Rick Edgecombe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] selftests/x86: Update map_shadow_stack syscall nr
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Sohil Mehta <sohil.mehta@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230901181652.2583861-1-rick.p.edgecombe@intel.com>
References: <20230901181652.2583861-1-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Message-ID: <169360437465.27769.16274321384160860209.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     6ea7bb00c1ba180f8bf8320b8d59b532501c5271
Gitweb:        https://git.kernel.org/tip/6ea7bb00c1ba180f8bf8320b8d59b532501c5271
Author:        Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate:    Fri, 01 Sep 2023 11:16:52 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 01 Sep 2023 23:34:13 +02:00

selftests/x86: Update map_shadow_stack syscall nr

Shadow stack's selftest utilizes the map_shadow_stack syscall. The
syscall is new with the feature, but the selftests cannot automatically
find the headers for the kernel source tree they are located in. This
resulted in the shadow stack test failing to build until the brand new
headers were installed.

To avoid this, a copy of the new uapi defines needed by the test were
included in the selftest (see link for discussion). When shadow stack was
merged the syscall number was changed, but the copy in the selftest was
not updated.

So update the copy of the syscall number define used when the required
headers are not installed, to have the final syscall number from the
merge.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/lkml/Y%2FijdXoTAATt0+Ct@zn.tnic/
Link: https://lore.kernel.org/r/20230901181652.2583861-1-rick.p.edgecombe@intel.com
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Fixes: df57721f9a63 ("Merge tag 'x86_shstk_for_6.6-rc1' of [...]")
---
 tools/testing/selftests/x86/test_shadow_stack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/x86/test_shadow_stack.c b/tools/testing/selftests/x86/test_shadow_stack.c
index 2188968..757e652 100644
--- a/tools/testing/selftests/x86/test_shadow_stack.c
+++ b/tools/testing/selftests/x86/test_shadow_stack.c
@@ -40,7 +40,7 @@
  * without building the headers.
  */
 #ifndef __NR_map_shadow_stack
-#define __NR_map_shadow_stack	452
+#define __NR_map_shadow_stack	453
 
 #define SHADOW_STACK_SET_TOKEN	(1ULL << 0)
 
