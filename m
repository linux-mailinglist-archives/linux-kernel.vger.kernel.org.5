Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4967773E0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234649AbjHJJMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234586AbjHJJMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:12:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E2B2D44;
        Thu, 10 Aug 2023 02:11:51 -0700 (PDT)
Date:   Thu, 10 Aug 2023 09:11:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691658710;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zDIrveFmuV1+qcOSp/gB8q0cQEtvljnAhgxZTXG2Qn8=;
        b=G6TXkXdMUq77rtrYd7YRFKeJGWcRENENHFiaAoqW64NxU4WsUCtXZUsDkWguCjigEiNAE+
        UInsMdwrs4H6va15Dim7+e1LiBLjqN5tShxxXVvIi+nBYZ1sal/9VW/lf9X9EXTNW4EADw
        sTtq9ZPlTPyznWKwJt1BZ6/2wtqHWN7TMS21v7POZbBdC6lWHVW4zcmhEsBb4Y0Q5cP11c
        yOwGa8RCHwiiBo7VQR7zOSWTOyUfXkMlSmkyV9NAu+3hCQST7DA09tUAfdHurQUF4tTpXQ
        6A1YzlrODltFGdCcvzDBR8fOXCCgamDio62As67mqM9G3NJjiDmrLhomsUw9kw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691658710;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zDIrveFmuV1+qcOSp/gB8q0cQEtvljnAhgxZTXG2Qn8=;
        b=gb+a+9rK2cBQ+DAK6/ojLT1Rr9q/BlTU+eZ2uXJdROqth5wlGgIVb+I6hcYLHN1JtNAbQz
        C+ffpu3nL9kW31Dg==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] Documentation/hw-vuln: Unify filename specification in index
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230809102700.29449-2-bp@alien8.de>
References: <20230809102700.29449-2-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <169165870948.27769.12413441993184468067.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     182ac87070e26d32a01445cec7ca7afa07411468
Gitweb:        https://git.kernel.org/tip/182ac87070e26d32a01445cec7ca7afa07411468
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Sat, 29 Jul 2023 16:53:02 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 10 Aug 2023 10:48:12 +02:00

Documentation/hw-vuln: Unify filename specification in index

Most of the index.rst files in Documentation/ refer to other rst files
without their file extension in the name. Do that here too.

No functional changes.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lore.kernel.org/r/20230809102700.29449-2-bp@alien8.de
---
 Documentation/admin-guide/hw-vuln/index.rst | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/hw-vuln/index.rst b/Documentation/admin-guide/hw-vuln/index.rst
index a7d37e1..de99caa 100644
--- a/Documentation/admin-guide/hw-vuln/index.rst
+++ b/Documentation/admin-guide/hw-vuln/index.rst
@@ -13,11 +13,11 @@ are configurable at compile, boot or run time.
    l1tf
    mds
    tsx_async_abort
-   multihit.rst
-   special-register-buffer-data-sampling.rst
-   core-scheduling.rst
-   l1d_flush.rst
-   processor_mmio_stale_data.rst
-   cross-thread-rsb.rst
+   multihit
+   special-register-buffer-data-sampling
+   core-scheduling
+   l1d_flush
+   processor_mmio_stale_data
+   cross-thread-rsb
    srso
-   gather_data_sampling.rst
+   gather_data_sampling
