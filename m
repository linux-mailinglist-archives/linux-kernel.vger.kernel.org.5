Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E30768101
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 20:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjG2Seb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 14:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjG2SeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 14:34:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83CC3582
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 11:34:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D42860766
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 18:34:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E2ACC433CD;
        Sat, 29 Jul 2023 18:34:22 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qPolh-0035JZ-25;
        Sat, 29 Jul 2023 14:34:21 -0400
Message-ID: <20230729183421.462537802@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 29 Jul 2023 14:33:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gaosheng Cui <cuigaosheng1@huawei.com>
Subject: [for-linus][PATCH 3/7] tracing/synthetic: Fix kernel-doc warnings in trace_events_synth.c
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

Fix kernel-doc warning:

kernel/trace/trace_events_synth.c:1257: warning: Function parameter
or member 'mod' not described in 'synth_event_gen_cmd_array_start'

Link: https://lkml.kernel.org/r/20230724140827.1023266-3-cuigaosheng1@huawei.com

Cc: <mhiramat@kernel.org>
Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_synth.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index d6a70aff2410..dd398afc8e25 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -1230,6 +1230,7 @@ EXPORT_SYMBOL_GPL(__synth_event_gen_cmd_start);
  * synth_event_gen_cmd_array_start - Start synthetic event command from an array
  * @cmd: A pointer to the dynevent_cmd struct representing the new event
  * @name: The name of the synthetic event
+ * @mod: The module creating the event, NULL if not created from a module
  * @fields: An array of type/name field descriptions
  * @n_fields: The number of field descriptions contained in the fields array
  *
-- 
2.40.1
