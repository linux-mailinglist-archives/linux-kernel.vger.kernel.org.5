Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D98C7A3DBC
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 23:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236759AbjIQVGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 17:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239729AbjIQVGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 17:06:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93E6B6;
        Sun, 17 Sep 2023 14:06:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 650ACC433C8;
        Sun, 17 Sep 2023 21:06:38 +0000 (UTC)
From:   Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.1.46-rt14
Date:   Sun, 17 Sep 2023 21:01:53 -0000
Message-ID: <169498451329.185247.13540432080486970560@demetrius>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>,
        Joseph Salisbury <joseph.salisbury@canonical.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,HEXHASH_WORD,HK_RANDOM_ENVFROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 6.1.46-rt14 stable release.

Note that this is strictly changes to PREEMPT_RT behavior with the following
commits:

7929a9185c2f drm/i915: Do not disable preemption for resets
2363ffd65d1b posix-timers: Ensure timer ID search-loop limit is valid
c3c53a6d672c bpf: Remove in_atomic() from bpf_link_put().
72ec563d9da5 mm/page_alloc: Use write_seqlock_irqsave() instead write_seqlock() + local_irq_save().
61974a5bf1e6 seqlock: Do the lockdep annotation before locking in do_write_seqcount_begin_nested()
7b941399a8c6 sched: avoid false lockdep splat in put_task_struct()
be37e65220e2 debugobjects,locking: Annotate debug_object_fill_pool() wait type violation
e5914bbc08e8 kernel/fork: beware of __put_task_struct calling context
54aba8b15687 revert: "softirq: Let ksoftirqd do its job"
c5c286db3c5a locking/rwbase: Mitigate indefinite writer starvation
423c54970a75 io-mapping: don't disable preempt on RT in io_mapping_map_atomic_wc().

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.1-rt
  Head SHA1: 73daa37b7cb8a876b209fcc744fca7da07f2ce1b

Or to build 6.1.46-rt14 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.1.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.1.46.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.1/patch-6.1.46-rt14.patch.xz


Enjoy!
Clark
