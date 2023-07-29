Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24BA7680FF
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 20:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjG2Se3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 14:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjG2SeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 14:34:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706CF3580
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 11:34:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0F556092A
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 18:34:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 648C4C433CA;
        Sat, 29 Jul 2023 18:34:22 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qPolh-0035J1-1Q;
        Sat, 29 Jul 2023 14:34:21 -0400
Message-ID: <20230729183421.257956360@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 29 Jul 2023 14:33:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gaosheng Cui <cuigaosheng1@huawei.com>
Subject: [for-linus][PATCH 2/7] ring-buffer: Fix kernel-doc warnings in ring_buffer.c
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

kernel/trace/ring_buffer.c:954: warning: Function parameter or
member 'cpu' not described in 'ring_buffer_wake_waiters'
kernel/trace/ring_buffer.c:3383: warning: Excess function parameter
'event' description in 'ring_buffer_unlock_commit'
kernel/trace/ring_buffer.c:5359: warning: Excess function parameter
'cpu' description in 'ring_buffer_reset_online_cpus'

Link: https://lkml.kernel.org/r/20230724140827.1023266-2-cuigaosheng1@huawei.com

Cc: <mhiramat@kernel.org>
Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 46b4a3c7c3bf..52dea5dd5362 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -950,6 +950,7 @@ static void rb_wake_up_waiters(struct irq_work *work)
 /**
  * ring_buffer_wake_waiters - wake up any waiters on this ring buffer
  * @buffer: The ring buffer to wake waiters on
+ * @cpu: The CPU buffer to wake waiters on
  *
  * In the case of a file that represents a ring buffer is closing,
  * it is prudent to wake up any waiters that are on this.
@@ -3375,7 +3376,6 @@ void ring_buffer_nest_end(struct trace_buffer *buffer)
 /**
  * ring_buffer_unlock_commit - commit a reserved
  * @buffer: The buffer to commit to
- * @event: The event pointer to commit.
  *
  * This commits the data to the ring buffer, and releases any locks held.
  *
@@ -5358,7 +5358,6 @@ EXPORT_SYMBOL_GPL(ring_buffer_reset_cpu);
 /**
  * ring_buffer_reset_online_cpus - reset a ring buffer per CPU buffer
  * @buffer: The ring buffer to reset a per cpu buffer of
- * @cpu: The CPU buffer to be reset
  */
 void ring_buffer_reset_online_cpus(struct trace_buffer *buffer)
 {
-- 
2.40.1
