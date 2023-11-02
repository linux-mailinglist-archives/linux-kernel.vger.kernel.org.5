Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B127DEBD0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 05:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348473AbjKBEWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 00:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348448AbjKBEWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 00:22:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4E6E4
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 21:22:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6642C433CC;
        Thu,  2 Nov 2023 04:22:12 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qyPDf-00EgoV-2c;
        Thu, 02 Nov 2023 00:22:11 -0400
Message-ID: <20231102042211.622636406@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 02 Nov 2023 00:21:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [for-next][PATCH 2/2] seq_buf: Export seq_buf_puts()
References: <20231102042107.733372008@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Mark seq_buf_puts() which is part of the seq_buf API to be exported to
kernel loadable GPL modules.

Link: https://lkml.kernel.org/r/b9e3737f66ec2450221b492048ce0d9c65c84953.1698861216.git.christophe.jaillet@wanadoo.fr

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 lib/seq_buf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/seq_buf.c b/lib/seq_buf.c
index fb99168c3309..010c730ca7fc 100644
--- a/lib/seq_buf.c
+++ b/lib/seq_buf.c
@@ -187,6 +187,7 @@ int seq_buf_puts(struct seq_buf *s, const char *str)
 	seq_buf_set_overflow(s);
 	return -1;
 }
+EXPORT_SYMBOL_GPL(seq_buf_puts);
 
 /**
  * seq_buf_putc - sequence printing of simple character
-- 
2.42.0
