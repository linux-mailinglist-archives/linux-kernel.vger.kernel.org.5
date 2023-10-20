Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D15D7D1912
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 00:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjJTW1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 18:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjJTW1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 18:27:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9793319E
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 15:27:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DB4FC433C7;
        Fri, 20 Oct 2023 22:27:41 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qtxxz-00AQXf-2B;
        Fri, 20 Oct 2023 18:27:39 -0400
Message-ID: <20231020222713.074741220@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 20 Oct 2023 18:27:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/6] tracing: Updates for 6.7
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/for-next

Head SHA1: 845e31e1101fc8533be52aff42d8f1ff48636024


Dan Carpenter (1):
      tracing: Fix a NULL vs IS_ERR() bug in event_subsystem_dir()

Jiapeng Chong (1):
      tracefs/eventfs: Modify mismatched function name

Jonathan Corbet (1):
      seq_buf: fix a misleading comment

Matthew Wilcox (Oracle) (1):
      tracing: Move readpos from seq_buf to trace_seq

Nathan Chancellor (1):
      eventfs: Use ERR_CAST() in eventfs_create_events_dir()

Steven Rostedt (Google) (1):
      eventfs: Fix failure path in eventfs_create_events_dir()

----
 fs/tracefs/event_inode.c    |  7 ++++---
 include/linux/seq_buf.h     |  7 ++-----
 include/linux/trace_seq.h   |  2 ++
 kernel/trace/trace.c        | 10 +++++-----
 kernel/trace/trace_events.c |  2 +-
 kernel/trace/trace_seq.c    |  6 +++++-
 lib/seq_buf.c               | 22 ++++++++++------------
 7 files changed, 29 insertions(+), 27 deletions(-)
