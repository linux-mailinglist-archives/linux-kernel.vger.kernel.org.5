Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04AE47D1914
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 00:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbjJTW15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 18:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjJTW1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 18:27:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57C8D69
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 15:27:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 013B3C4339A;
        Fri, 20 Oct 2023 22:27:42 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qtxy1-00AQb0-07;
        Fri, 20 Oct 2023 18:27:41 -0400
Message-ID: <20231020222740.846078267@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 20 Oct 2023 18:27:19 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [for-next][PATCH 6/6] seq_buf: fix a misleading comment
References: <20231020222713.074741220@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Corbet <corbet@lwn.net>

The comment for seq_buf_has_overflowed() says that an overflow condition is
marked by len == size, but that's not what the code is testing.  Make the
comment match reality.

Link: https://lkml.kernel.org/r/87pm19kp0m.fsf@meer.lwn.net

Fixes: 8cd709ae7658a ("tracing: Have seq_buf use full buffer")
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/seq_buf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
index a0fb013cebdf..8483e4b2d0d2 100644
--- a/include/linux/seq_buf.h
+++ b/include/linux/seq_buf.h
@@ -36,7 +36,7 @@ seq_buf_init(struct seq_buf *s, char *buf, unsigned int size)
 
 /*
  * seq_buf have a buffer that might overflow. When this happens
- * the len and size are set to be equal.
+ * len is set to be greater than size.
  */
 static inline bool
 seq_buf_has_overflowed(struct seq_buf *s)
-- 
2.42.0
