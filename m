Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 319567D1C55
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 12:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjJUKBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 06:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjJUKBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 06:01:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2451BF
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 03:01:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01568C433C8;
        Sat, 21 Oct 2023 10:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697882488;
        bh=y4/cpAnHySNFgx1PcAG6cu9e1YfbwXyUXMwH1NcZ8zA=;
        h=Date:From:To:Cc:Subject:From;
        b=Gxrr0p3+2vUawKzBoPiZTcARYkVdXMkYOCGMoIUgWNwNKcrrI7vdlHYm6C8IZB6ID
         OuBxpTTQfSyziggwXlnQu2WzIu/sL2xSfLSwE/XFi4Q+xMdddhfpzVJpLrFsXKUWT4
         aVaz1htxCEaAdqIACyIlvxB70CIVjR11sq8iCOPO++aZJSWT/BAUL+2AsFZGf4F9bz
         pgSle6E8/uikygAGxzK/6tE7tTXjWX6KJMFmNff0bwgWvPZzhQq4pDQX5wR3i3WaZJ
         zN0iKJ6ehzzM9jwbXyD9N+172nHDuLV0QIEdE7QHcHInT4XMq4gCgCrRUl0/3OAzuU
         4bahDmZmwM36g==
Date:   Sat, 21 Oct 2023 19:01:24 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Francis Laniel <flaniel@linux.microsoft.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [GIT PULL] probes: fixes for v6.6-rc6.2
Message-Id: <20231021190124.9e591c603d227379453d3307@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Probes fixes for v6.6-rc6.2:

- kprobe-events: Fix kprobe events to reject if the attached symbol
  is not unique name because it may not the function which the user
  want to attach to. (User can attach a probe to such symbol using
  the nearest unique symbol + offset.)

- selftest: Add a testcase to ensure the kprobe event rejects non
  unique symbol correctly.


Please pull the latest probes-fixes-v6.6-rc6.2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
probes-fixes-v6.6-rc6.2

Tag SHA1: d6e0322d9de05369d84aa0e8acc0c03978b50a40
Head SHA1: 03b80ff8023adae6780e491f66e932df8165e3a0


Francis Laniel (2):
      tracing/kprobes: Return EADDRNOTAVAIL when func matches several symbols
      selftests/ftrace: Add new test case which checks non unique symbol

----
 kernel/trace/trace_kprobe.c                        | 63 ++++++++++++++++++++++
 kernel/trace/trace_probe.h                         |  1 +
 .../ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc | 13 +++++
 3 files changed, 77 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
