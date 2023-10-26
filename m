Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B7A7D7A28
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 03:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbjJZB15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 21:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjJZB14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 21:27:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0319BD
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 18:27:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A0AC433D9;
        Thu, 26 Oct 2023 01:27:54 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qvpA9-00CqSO-1F;
        Wed, 25 Oct 2023 21:27:53 -0400
Message-ID: <20231026012734.358814002@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 25 Oct 2023 21:27:34 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/4] tracing: Updates for 6.7
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

Head SHA1: 29e06c10702e81a7d0b75020ca514d2f2962704a


Christophe JAILLET (1):
      tracing/histograms: Simplify last_cmd_set()

Matthew Wilcox (Oracle) (1):
      powerpc: Remove initialisation of readpos

Steven Rostedt (Google) (2):
      eventfs: Fix WARN_ON() in create_file_dentry()
      eventfs: Fix typo in eventfs_inode union comment

----
 arch/powerpc/kernel/setup-common.c |  1 -
 fs/tracefs/event_inode.c           |  3 ++-
 fs/tracefs/internal.h              |  2 +-
 kernel/trace/trace_events_hist.c   | 11 ++---------
 4 files changed, 5 insertions(+), 12 deletions(-)
