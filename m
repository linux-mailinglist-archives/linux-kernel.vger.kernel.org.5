Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40117B72D2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 22:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241102AbjJCUwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 16:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbjJCUwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 16:52:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03C3AF;
        Tue,  3 Oct 2023 13:52:48 -0700 (PDT)
Date:   Tue, 03 Oct 2023 20:52:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696366366;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=PT02vf4qpONgCCHR+P2R8irQpHEFafTAc6KzSUkg5Y0=;
        b=hCW01UBFWnE+o4p8ls7y6ILPrSRM+f9NTa1E39P9+Lf5n1UGkthey5BIhAloOE4khu7Wiu
        iCIIlOp2mw7KhdpZmBwxQHHzpIpl7aqkTeTFD4v5pYW5hsepNHntcwBj9H1PpuEGtnIFq/
        un+TPFlweYmrvt0GcMOO4DC1k7zO50xlgetDxWVt5raGYN5vfeUVbbeDQaQ5awoEyaeGg5
        c+arTv0Z3jB3Qsv3CTKPn47aBn36nmDwf6MMbUaFI0nmPfof3XKofa3lj3yAf62VWaGDod
        C2BdhVBJqs/5cX7Eqg3cnLQSlGpfqb5TglUKGxRUe28t6nzyurciUE81e0MOAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696366366;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=PT02vf4qpONgCCHR+P2R8irQpHEFafTAc6KzSUkg5Y0=;
        b=l9wGx9F3RFi3WeXNylPHfqQRwXTIurM+dpOtijG/sb5VtuYWsXDaRk3YrAcVrJCiCcZsBg
        WVcSbNr1YVlHtYDQ==
From:   "tip-bot2 for Zhu Wang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/lib: Address kernel-doc warnings
Cc:     Zhu Wang <wangzhu9@huawei.com>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
MIME-Version: 1.0
Message-ID: <169636636607.3135.9489854360051016582.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     8ae292c66dcb160b3e1e16b66c3076d5a2c63873
Gitweb:        https://git.kernel.org/tip/8ae292c66dcb160b3e1e16b66c3076d5a2c63873
Author:        Zhu Wang <wangzhu9@huawei.com>
AuthorDate:    Mon, 31 Jul 2023 19:36:22 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 03 Oct 2023 22:46:47 +02:00

x86/lib: Address kernel-doc warnings

Fix all kernel-doc warnings in csum-wrappers_64.c:

  arch/x86/lib/csum-wrappers_64.c:25: warning: Excess function parameter 'isum' description in 'csum_and_copy_from_user'
  arch/x86/lib/csum-wrappers_64.c:25: warning: Excess function parameter 'errp' description in 'csum_and_copy_from_user'
  arch/x86/lib/csum-wrappers_64.c:49: warning: Excess function parameter 'isum' description in 'csum_and_copy_to_user'
  arch/x86/lib/csum-wrappers_64.c:49: warning: Excess function parameter 'errp' description in 'csum_and_copy_to_user'
  arch/x86/lib/csum-wrappers_64.c:71: warning: Excess function parameter 'sum' description in 'csum_partial_copy_nocheck'

Signed-off-by: Zhu Wang <wangzhu9@huawei.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/lib/csum-wrappers_64.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/x86/lib/csum-wrappers_64.c b/arch/x86/lib/csum-wrappers_64.c
index 145f9a0..f4df4d2 100644
--- a/arch/x86/lib/csum-wrappers_64.c
+++ b/arch/x86/lib/csum-wrappers_64.c
@@ -14,8 +14,6 @@
  * @src: source address (user space)
  * @dst: destination address
  * @len: number of bytes to be copied.
- * @isum: initial sum that is added into the result (32bit unfolded)
- * @errp: set to -EFAULT for an bad source address.
  *
  * Returns an 32bit unfolded checksum of the buffer.
  * src and dst are best aligned to 64bits.
@@ -38,8 +36,6 @@ csum_and_copy_from_user(const void __user *src, void *dst, int len)
  * @src: source address
  * @dst: destination address (user space)
  * @len: number of bytes to be copied.
- * @isum: initial sum that is added into the result (32bit unfolded)
- * @errp: set to -EFAULT for an bad destination address.
  *
  * Returns an 32bit unfolded checksum of the buffer.
  * src and dst are best aligned to 64bits.
@@ -62,7 +58,6 @@ csum_and_copy_to_user(const void *src, void __user *dst, int len)
  * @src: source address
  * @dst: destination address
  * @len: number of bytes to be copied.
- * @sum: initial sum that is added into the result (32bit unfolded)
  *
  * Returns an 32bit unfolded checksum of the buffer.
  */
