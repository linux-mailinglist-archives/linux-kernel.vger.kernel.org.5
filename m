Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0938678653F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 04:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239356AbjHXCTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 22:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbjHXCSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 22:18:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA34E6D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 19:18:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9AFBD63A09
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 02:18:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE4F0C433C8;
        Thu, 24 Aug 2023 02:18:29 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qYzvu-001hPX-1Y;
        Wed, 23 Aug 2023 22:18:50 -0400
Message-ID: <20230824021812.938245293@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 23 Aug 2023 22:18:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 00/14] tracing: More updates for 6.6
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/for-next

Head SHA1: 8c96b70171584f38940eb2ba65b84eee38b549ba


Eric Vaughn (1):
      tracing/user_events: Optimize safe list traversals

Sishuai Gong (1):
      tracefs: Avoid changing i_mode to a temp value

Steven Rostedt (Google) (1):
      tracefs: Remove kerneldoc from struct eventfs_file

Valentin Schneider (9):
      tracing/filters: Dynamically allocate filter_pred.regex
      tracing/filters: Enable filtering a cpumask field by another cpumask
      tracing/filters: Enable filtering a scalar field by a cpumask
      tracing/filters: Enable filtering the CPU common field by a cpumask
      tracing/filters: Optimise cpumask vs cpumask filtering when user mask is a single CPU
      tracing/filters: Optimise scalar vs cpumask filtering when the user mask is a single CPU
      tracing/filters: Optimise CPU vs cpumask filtering when the user mask is a single CPU
      tracing/filters: Further optimise scalar vs cpumask comparison
      tracing/filters: Document cpumask filtering

Yue Haibing (1):
      tracing: Remove unused function declarations

Zhang Zekun (1):
      ftrace: Remove empty declaration ftrace_enable_daemon() and ftrace_disable_daemon()

----
 Documentation/trace/events.rst     |  14 ++
 fs/tracefs/event_inode.c           |  14 +-
 fs/tracefs/inode.c                 |   6 +-
 include/linux/ftrace.h             |   5 -
 include/linux/trace_events.h       |   1 +
 kernel/trace/trace.h               |   2 -
 kernel/trace/trace_events_filter.c | 302 +++++++++++++++++++++++++++++++++----
 kernel/trace/trace_events_user.c   |  15 +-
 8 files changed, 312 insertions(+), 47 deletions(-)
