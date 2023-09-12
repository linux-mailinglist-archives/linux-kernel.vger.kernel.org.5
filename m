Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7946A79C674
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 08:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjILGIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 02:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjILGIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 02:08:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A513A10C1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 23:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=XaiFS/KJsJNXyS2rj5GjrgcA82/4PEBrNWoal8yFS20=; b=stiQpiQlSA5SU2fqVxBJKmv5mS
        qItCC/v7Xxa5EyVH0ruX+lg4KU2kapNp4MKcddwMcI615nl/ktpyTUFfK87MWOC6Wh13vl4Jwkwhh
        hddIueF5xLsvtxhuRm+UNSdfj4K/CooQb9cl6+XxGJyITEmhwmAE4xo1Pd5FOpx5hNEa9VjfhapbV
        kD2FjyYXJLVRqhK6k/oyfZ4vFOEXJXNMvIX7PYbFVBiYH2W0ddr6Rb/5QBWcrk4tLBfhGbTv2Wqzj
        x0W7BIm0/tcKMoOQLxSpHX7iLjdKAHe5ik6mfVJxGOKEu70ovfDbeI14BiKrlfc81KiYX1VTibiLP
        D+sUqCCQ==;
Received: from [2601:1c2:980:9ec0::9fed] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qfwZb-002Fk0-1Y;
        Tue, 12 Sep 2023 06:08:31 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] stacktrace: fix kernel-doc typo
Date:   Mon, 11 Sep 2023 23:08:30 -0700
Message-ID: <20230912060830.3175-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change @task to @tsk to prevent kernel-doc warnings:

kernel/stacktrace.c:138: warning: Excess function parameter 'task' description in 'stack_trace_save_tsk'
kernel/stacktrace.c:138: warning: Function parameter or member 'tsk' not described in 'stack_trace_save_tsk'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/stacktrace.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/kernel/stacktrace.c b/kernel/stacktrace.c
--- a/kernel/stacktrace.c
+++ b/kernel/stacktrace.c
@@ -126,7 +126,7 @@ EXPORT_SYMBOL_GPL(stack_trace_save);
 
 /**
  * stack_trace_save_tsk - Save a task stack trace into a storage array
- * @task:	The task to examine
+ * @tsk:	The task to examine
  * @store:	Pointer to storage array
  * @size:	Size of the storage array
  * @skipnr:	Number of entries to skip at the start of the stack trace
