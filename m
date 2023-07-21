Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0913975C075
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 09:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjGUHxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 03:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbjGUHxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 03:53:32 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9DEE0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 00:53:22 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R6hcv2v9zzBRDtV
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 15:53:19 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689925999; x=1692518000; bh=bAmuNeag8GTPKV3oigS4mEh4jV0
        Ndn4OtKI/lt6gNOY=; b=uGSR4Vz/h1CAC/xdYDxlAsPwHlCqnQshGuD1WDkky2n
        iRNUfdX7edqWVbuSesoGZpCHah2J2thEea6wC2udTvOqcI34sYHrOROfssk/jF+X
        /VaixDLk9AvSAvBEqxvWl5kV84n2ZkoajWO3AZfz4Njzl0lHhrLd7jo48uc9LxNu
        sQgHpYNpd9s2bATO0T32rJvhVA+Gz+XEnX1avCxM/32C9pu5r5avXyJu2yHFgLtY
        Mncmk5dJz26XP239yGlL4sH+iAbvWQw/MWyBHOdKIHGGwqBgw7xFONjgW6xx8ZPZ
        mrA3HQXWxN744bSMQSY+UP+mLdF7IXpYJEJlGSuLxCQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id LzPU4KuMSOFD for <linux-kernel@vger.kernel.org>;
        Fri, 21 Jul 2023 15:53:19 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R6hcv0lJHzBQslQ;
        Fri, 21 Jul 2023 15:53:19 +0800 (CST)
MIME-Version: 1.0
Date:   Fri, 21 Jul 2023 07:53:19 +0000
From:   sunran001@208suo.com
To:     geert@linux-m68k.org
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: [PATCH] m68k: q40: Fix nine occurrences of the checkpatch.pl error:
In-Reply-To: <20230721075132.5512-1-xujianghui@cdjrlc.com>
References: <20230721075132.5512-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <d58630843012d3323b0576bab81a21a7@208suo.com>
X-Sender: sunran001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix three occurrences of the checkpatch.pl error:
ERROR: space required after that ',' (ctx:VxV)
ERROR: space prohibited after that open parenthesis '('

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  arch/m68k/q40/q40ints.c | 8 ++++----
  1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/m68k/q40/q40ints.c b/arch/m68k/q40/q40ints.c
index fdd6e48f4fe3..8843144e8c28 100644
--- a/arch/m68k/q40/q40ints.c
+++ b/arch/m68k/q40/q40ints.c
@@ -159,7 +159,7 @@ void q40_sched_init (void)
  		panic("Couldn't register timer int");

  	master_outb(-1, FRAME_CLEAR_REG);
-	master_outb( 1, FRAME_RATE_REG);
+	master_outb(1, FRAME_RATE_REG);
  }


@@ -169,12 +169,12 @@ void q40_sched_init (void)
   *
  */

-struct IRQ_TABLE{ unsigned mask; int irq ;};
+struct IRQ_TABLE{ unsigned mask; int irq ; };
  #if 0
  static struct IRQ_TABLE iirqs[] = {
    {Q40_IRQ_FRAME_MASK,Q40_IRQ_FRAME},
    {Q40_IRQ_KEYB_MASK,Q40_IRQ_KEYBOARD},
-  {0,0}};
+  {0, 0}};
  #endif
  static struct IRQ_TABLE eirqs[] = {
    { .mask = Q40_IRQ3_MASK,	.irq = 3 },	/* ser 1 */
@@ -185,7 +185,7 @@ static struct IRQ_TABLE eirqs[] = {
    { .mask = Q40_IRQ7_MASK,	.irq = 7 },	/* par */
    { .mask = Q40_IRQ5_MASK,	.irq = 5 },
    { .mask = Q40_IRQ10_MASK,	.irq = 10 },
-  {0,0}
+  {0, 0}
  };

  /* complain only this many times about spurious ints : */
