Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4463768103
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 20:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjG2See (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 14:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjG2SeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 14:34:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4703585
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 11:34:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74BBD60A0A
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 18:34:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2959C433C7;
        Sat, 29 Jul 2023 18:34:22 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qPolh-0035K7-2l;
        Sat, 29 Jul 2023 14:34:21 -0400
Message-ID: <20230729183421.670475369@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 29 Jul 2023 14:33:37 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gaosheng Cui <cuigaosheng1@huawei.com>
Subject: [for-linus][PATCH 4/7] tracing: Fix kernel-doc warnings in trace_events_trigger.c
References: <20230729183333.357029101@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gaosheng Cui <cuigaosheng1@huawei.com>

Fix kernel-doc warnings:

kernel/trace/trace_events_trigger.c:59: warning: Function parameter
or member 'buffer' not described in 'event_triggers_call'
kernel/trace/trace_events_trigger.c:59: warning: Function parameter
or member 'event' not described in 'event_triggers_call'

Link: https://lkml.kernel.org/r/20230724140827.1023266-4-cuigaosheng1@huawei.com

Cc: <mhiramat@kernel.org>
Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_trigger.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index e535959939d3..46439e3bcec4 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -31,7 +31,9 @@ void trigger_data_free(struct event_trigger_data *data)
 /**
  * event_triggers_call - Call triggers associated with a trace event
  * @file: The trace_event_file associated with the event
+ * @buffer: The ring buffer that the event is being written to
  * @rec: The trace entry for the event, NULL for unconditional invocation
+ * @event: The event meta data in the ring buffer
  *
  * For each trigger associated with an event, invoke the trigger
  * function registered with the associated trigger command.  If rec is
-- 
2.40.1
