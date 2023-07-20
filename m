Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D6B75A4A2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 05:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjGTDJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 23:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjGTDJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 23:09:39 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530E71985
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 20:09:38 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R5yMy4cWwzBRDs8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 11:09:34 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689822574; x=1692414575; bh=HCUV4GoR4/df9NKdNW/l630GYdT
        WAAJtUZnwSHjVmdg=; b=zr6IhIeXVUdo8am1HsOB0WUXZil2PseExXxnomQ0ZNy
        FZpUxtYIvq+kmZNuz2f4uvRKEWu5evFZszMBT2rmiFcxrZnaVlFl0EX1N4FE6cH9
        PMsd4tuxllK7JSKPchE7NfJkHskERHjlBpnQsw2/GGy07pFayzA9TducszTB637a
        5UImUQlPsWHcCtEHbBQmf1cdLUtNBGo/znCxIyt/zvrGnZC3XG8gtTel2VyOkG0k
        y6YKkD9spwRrY02p+7yrLUQNxn8sLK47u+RWSp0Scqb2q8+2NguYj1IVGvuKsyzD
        XbX1LB20dz+pIT890q7VcNp2vldbFhQazRxo8t/Ig0A==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Hy71c31QSMVf for <linux-kernel@vger.kernel.org>;
        Thu, 20 Jul 2023 11:09:34 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R5yMy2VjCzBRDrC;
        Thu, 20 Jul 2023 11:09:34 +0800 (CST)
MIME-Version: 1.0
Date:   Thu, 20 Jul 2023 11:09:34 +0800
From:   sunran001@208suo.com
To:     mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] elfcore: open brace '{' following struct go on the same line
 and Add missing spaces after '*'
In-Reply-To: <20230720030824.1505-1-xujianghui@cdjrlc.com>
References: <20230720030824.1505-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <e7038a35f30f746365c4fcf839854168@208suo.com>
X-Sender: sunran001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ERROR: open brace '{' following struct go on the same line

ERROR: "foo* bar" should be "foo *bar"

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  include/linux/elfcore.h | 14 +++++---------
  1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/include/linux/elfcore.h b/include/linux/elfcore.h
index bd5560542c79..88dea6c5091a 100644
--- a/include/linux/elfcore.h
+++ b/include/linux/elfcore.h
@@ -14,8 +14,7 @@

  struct coredump_params;

-struct elf_siginfo
-{
+struct elf_siginfo {
  	int	si_signo;			/* signal number */
  	int	si_code;			/* extra code */
  	int	si_errno;			/* errno */
@@ -29,8 +28,7 @@ struct elf_siginfo
   * the SVR4 structure, but more Linuxy, with things that Linux does
   * not support and which gdb doesn't really use excluded.
   */
-struct elf_prstatus_common
-{
+struct elf_prstatus_common {
  	struct elf_siginfo pr_info;	/* Info associated with signal */
  	short	pr_cursig;		/* Current signal */
  	unsigned long pr_sigpend;	/* Set of pending signals */
@@ -45,8 +43,7 @@ struct elf_prstatus_common
  	struct __kernel_old_timeval pr_cstime;	/* Cumulative system time */
  };

-struct elf_prstatus
-{
+struct elf_prstatus {
  	struct elf_prstatus_common common;
  	elf_gregset_t pr_reg;	/* GP registers */
  	int pr_fpvalid;		/* True if math co-processor being used.  */
@@ -54,8 +51,7 @@ struct elf_prstatus

  #define ELF_PRARGSZ	(80)	/* Number of chars for args */

-struct elf_prpsinfo
-{
+struct elf_prpsinfo {
  	char	pr_state;	/* numeric process state */
  	char	pr_sname;	/* char for pr_state */
  	char	pr_zomb;	/* zombie */
@@ -84,7 +80,7 @@ static inline void elf_core_copy_regs(elf_gregset_t 
*elfregs, struct pt_regs *re
  #endif
  }

-static inline int elf_core_copy_task_regs(struct task_struct *t, 
elf_gregset_t* elfregs)
+static inline int elf_core_copy_task_regs(struct task_struct *t, 
elf_gregset_t *elfregs)
  {
  #if defined (ELF_CORE_COPY_TASK_REGS)
  	return ELF_CORE_COPY_TASK_REGS(t, elfregs);
