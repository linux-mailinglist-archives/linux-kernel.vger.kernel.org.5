Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8FE7E58AB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 15:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbjKHOZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 09:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbjKHOZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 09:25:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4051FC9
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 06:25:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F3B0C433C8;
        Wed,  8 Nov 2023 14:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699453500;
        bh=EOdwMS7vJXCXxyNePs9bFMY5mRinN5nN+9oKZfWkeWA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pq/L0QIuPS6c36rUuYEpModmDqSsMnMj6rd7FfSDmMmvsR83JA+1gr4f459TTHxaE
         8jAfy8Ou3yT1rhtf+JaAXVd1xhKJdvDu0xARIIX9V7cprjH1FQF66QEbz6gWZf0HeL
         BunIb/yDaukNxi0d4pw1/V4Mw7XGlDqsTPIZlM6aAxj8UNEqUjhipg2gQT942ZmTR/
         6qiuajPQFF6fGWWjH6q6F5uTOXpkQ/V4ESTNCi40qFiYNCVHy4rrYq1WtCGvb9o0es
         6PlH5SyM6OFH8kMGz7OmJaIRQ5ceAiG4VzLCdC8GAczMG/geWRTKNfkgb2dkdmP/oW
         pvPodc8wJtmBg==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Florent Revest <revest@chromium.org>
Cc:     linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alan Maguire <alan.maguire@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Guo Ren <guoren@kernel.org>
Subject: [RFC PATCH v2 03/31] seq_buf: Export seq_buf_puts()
Date:   Wed,  8 Nov 2023 23:24:55 +0900
Message-Id: <169945349504.55307.11956579566800344063.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <169945345785.55307.5003201137843449313.stgit@devnote2>
References: <169945345785.55307.5003201137843449313.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Mark seq_buf_puts() which is part of the seq_buf API to be exported to
kernel loadable GPL modules.

Link: https://lkml.kernel.org/r/b9e3737f66ec2450221b492048ce0d9c65c84953.1698861216.git.christophe.jaillet@wanadoo.fr

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 lib/seq_buf.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/seq_buf.c b/lib/seq_buf.c
index 45c450f423fa..46a1b00c3815 100644
--- a/lib/seq_buf.c
+++ b/lib/seq_buf.c
@@ -189,6 +189,7 @@ int seq_buf_puts(struct seq_buf *s, const char *str)
 	seq_buf_set_overflow(s);
 	return -1;
 }
+EXPORT_SYMBOL_GPL(seq_buf_puts);
 
 /**
  * seq_buf_putc - sequence printing of simple character

