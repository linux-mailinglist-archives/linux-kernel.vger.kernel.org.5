Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBCDB755EA1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 10:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbjGQIjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 04:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjGQIi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 04:38:58 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C290103
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 01:38:57 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R4FqL0zMzzBR9sk
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:38:54 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689583131; x=1692175132; bh=B10ONze3Ez4485BlhVM5rp5eqe5
        DThaXLzSMHECxmf8=; b=aI030ZgR5tRWs0hUo0A0zbulGwJoiK6upGGCvKIazN0
        wpNO4ASn4NZ1KB/T80Rkbpp6dGqZ1D4T+iZLiX33RvCcXuXUg1MOX3UAF7FstJAg
        Pc/MMPB29e7AZ63jyrVyMfXVhK/oRr1QS5jiGu10lUljP3PzgJqG7EAEop1yBK+v
        shyjxABNxbfv9kl01ysMpRlyIXq4Ww8SXqK2L28ddVLjfz1dGmbhs02YDySSCtDo
        9fCdxd0utaBeDESfNQH3YMH3Q7gIeCJCnawTCP2NfrwchyOcWdaKxDTscjX5WXzK
        i5/VuVte3wqOzFmcwxBw3lTQJ8vj5NRYcSPeUIaLAAA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9seLt_KkdVt6 for <linux-kernel@vger.kernel.org>;
        Mon, 17 Jul 2023 16:38:51 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R4FqH4kSZzBR5l8;
        Mon, 17 Jul 2023 16:38:51 +0800 (CST)
MIME-Version: 1.0
Date:   Mon, 17 Jul 2023 16:38:51 +0800
From:   hanyu001@208suo.com
To:     mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        onkarnath.1@samsung.com, gustavoars@kernel.org,
        nathanl@linux.ibm.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: xmon: insert space before the open parenthesis '('
In-Reply-To: <tencent_21B998805C354725D838145110ED7A2DD606@qq.com>
References: <tencent_21B998805C354725D838145110ED7A2DD606@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <643e93ea4109ca0e2e77144060d3ad73@208suo.com>
X-Sender: hanyu001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes checkpatch error:

./arch/powerpc/xmon/xmon.c:1052: ERROR: space required before the open 
parenthesis '('

Signed-off-by: ztt <1549089851@qq.com>
---
  arch/powerpc/xmon/xmon.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 70c4c59a1a8f..6a1a2f0b9084 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -1049,7 +1049,7 @@ cmds(struct pt_regs *excp)

      xmon_show_stack(excp->gpr[1], excp->link, excp->nip);

-    for(;;) {
+    for (;;) {
  #ifdef CONFIG_SMP
          printf("%x:", smp_processor_id());
  #endif /* CONFIG_SMP */
