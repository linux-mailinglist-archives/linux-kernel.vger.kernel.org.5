Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D937B99CE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 03:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244307AbjJEBwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 21:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233837AbjJEBwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 21:52:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A389E
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 18:52:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA4ECC433C7;
        Thu,  5 Oct 2023 01:52:41 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qoDYk-005FHp-1o;
        Wed, 04 Oct 2023 21:53:50 -0400
Message-ID: <20231005015310.859143353@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 04 Oct 2023 21:53:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/7] tracing: Updates for 6.7
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Beau Belgrave (3):
      tracing/user_events: Allow events to persist for perfmon_capable users
      selftests/user_events: Test persist flag cases
      tracing/user_events: Document persist event flags

Steven Rostedt (Google) (2):
      eventfs: Remove eventfs_file and just use eventfs_inode
      tracing/selftests: Update kprobe args char/string to match new functions

Uros Bizjak (1):
      ring_buffer: Use try_cmpxchg instead of cmpxchg in rb_insert_pages

Zheng Yejian (1):
      tracing: Expand all ring buffers individually

----
 Documentation/trace/user_events.rst                |  21 +-
 fs/tracefs/event_inode.c                           | 847 +++++++++++----------
 fs/tracefs/inode.c                                 |   2 +-
 fs/tracefs/internal.h                              |  37 +-
 include/linux/trace_events.h                       |   2 +-
 include/linux/tracefs.h                            |  29 +-
 include/uapi/linux/user_events.h                   |  11 +-
 kernel/trace/ring_buffer.c                         |   8 +-
 kernel/trace/trace.c                               |  54 +-
 kernel/trace/trace.h                               |  13 +-
 kernel/trace/trace_events.c                        | 335 +++++---
 kernel/trace/trace_events_user.c                   |  36 +-
 .../ftrace/test.d/kprobe/kprobe_args_char.tc       |   4 +-
 .../ftrace/test.d/kprobe/kprobe_args_string.tc     |   4 +-
 tools/testing/selftests/user_events/abi_test.c     |  55 +-
 tools/testing/selftests/user_events/dyn_test.c     |  54 +-
 16 files changed, 917 insertions(+), 595 deletions(-)
