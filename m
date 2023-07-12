Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF9D751261
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 23:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbjGLVM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 17:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbjGLVMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 17:12:22 -0400
Received: from out-54.mta1.migadu.com (out-54.mta1.migadu.com [IPv6:2001:41d0:203:375::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A53526B6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 14:11:47 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689196305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3bOiJuZA7MMn1dUAKvZtsb+DsEd9kjQVDcRKBJgcodE=;
        b=c/TQhQifd2bG9jqyz1yUnKFrIEOakPDHeeO1oK5IBJDq1VPONAP28akM3gIsyeIR854AJG
        3qqejI0s0GzfMz4gSD2rvZX7XdPyRuqTYK2mb2P6AXLbnKkGlBkVt+j3Mw8c6BWVgjkaNr
        PUN0XpbTfIjd+ambQYaCpGpRqSu5TDs=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 16/20] closures: Add a missing include
Date:   Wed, 12 Jul 2023 17:11:11 -0400
Message-Id: <20230712211115.2174650-17-kent.overstreet@linux.dev>
In-Reply-To: <20230712211115.2174650-1-kent.overstreet@linux.dev>
References: <20230712211115.2174650-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes building in userspace.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 lib/closure.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/closure.c b/lib/closure.c
index b38ded00b9..0855e698ce 100644
--- a/lib/closure.c
+++ b/lib/closure.c
@@ -9,6 +9,7 @@
 #include <linux/closure.h>
 #include <linux/debugfs.h>
 #include <linux/export.h>
+#include <linux/rcupdate.h>
 #include <linux/seq_file.h>
 #include <linux/sched/debug.h>
 
-- 
2.40.1

