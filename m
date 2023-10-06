Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1C47BC2D6
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 01:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233941AbjJFXMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 19:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233921AbjJFXMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 19:12:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452B39F
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 16:12:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DACB2C433C9;
        Fri,  6 Oct 2023 23:12:38 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qou11-005rNb-19;
        Fri, 06 Oct 2023 19:13:51 -0400
Message-ID: <20231006231324.646666118@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 06 Oct 2023 19:13:24 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/2] tracing: Updates for v6.7
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

Head SHA1: 5ddd8baa4857709b4e5d84b376d735152851955b


Steven Rostedt (Google) (2):
      eventfs: Use eventfs_remove_events_dir()
      tracing: Make system_callback() function static

----
 fs/tracefs/event_inode.c    | 19 +++++++------------
 include/linux/tracefs.h     |  1 +
 kernel/trace/trace_events.c |  4 ++--
 3 files changed, 10 insertions(+), 14 deletions(-)
