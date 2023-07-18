Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42ACD758221
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 18:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbjGRQbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 12:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbjGRQbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 12:31:47 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98A61711
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 09:31:41 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R54GJ1TgZzBR9tP
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 00:31:36 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689697896; x=1692289897; bh=FIFlVqBhmCq9E3QVENVGPbdMQ8n
        GefuVBitwjAh8/D8=; b=dPtvkG50HOlhY7WYzZqV9emFcAATFWgePc9H/svl4vX
        EI9bEln1iQHP5eda+LZS490bt7A8MSGYy+01ZCqzeLd3nsocvGlK848RXG98ylRi
        KTc/qWoFKHVbtMC+cITy0qQbJ9QO4Eur/nDKF5TxN1CkDWNw+vUtmhqp0U5oNVsO
        ilcnegsqNd5ugOmixK6zXGNYFsKNWQJkU6tdJISwTaU9rxQHxO5FUC1XSsalUR4K
        B0nm1nGOxa1juG1FYXuuZQVnOBePkYNvBXKVh4ID9hLhieN7WQkER6M4i8SP3YxX
        jeV3Vf/lgzB1FX0I2oLR1bJrGgaT5rNNcX0ugx/IEYw==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id c_FhPpp_waKg for <linux-kernel@vger.kernel.org>;
        Wed, 19 Jul 2023 00:31:36 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R54GH66f9zBR1PQ;
        Wed, 19 Jul 2023 00:31:35 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 19 Jul 2023 00:31:35 +0800
From:   pangzizhen001@208suo.com
To:     mpe@ellerman.id.au, Jason@zx2c4.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/kernel: Fix comment typo
In-Reply-To: <070e7321ca11e0cd57e46fe240812c0e@208suo.com>
References: <20230712081541.29077-1-wangjianli@cdjrlc.com>
 <070e7321ca11e0cd57e46fe240812c0e@208suo.com>
User-Agent: Roundcube Webmail
Message-ID: <2c2e24984308a4f0ed4790fef1dfef48@208suo.com>
X-Sender: pangzizhen001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete duplicate word "the"

Signed-off-by: Zizhen Pang <pangzizhen001@208suo.com>
---
  arch/powerpc/kernel/process.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/process.c 
b/arch/powerpc/kernel/process.c
index b68898ac07e1..6e35037282b6 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -173,7 +173,7 @@ void giveup_fpu(struct task_struct *tsk)
  EXPORT_SYMBOL(giveup_fpu);

  /*
- * Make sure the floating-point register state in the
+ * Make sure the floating-point register state in
   * the thread_struct is up to date for task tsk.
   */
  void flush_fp_to_thread(struct task_struct *tsk)
