Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1262E7D5B09
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 21:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344165AbjJXTDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 15:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234846AbjJXTD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 15:03:28 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696F110C3;
        Tue, 24 Oct 2023 12:03:26 -0700 (PDT)
Received: from canonical.com (1.general.jsalisbury.us.vpn [10.172.66.188])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id D308E3FB9C;
        Tue, 24 Oct 2023 19:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1698174204;
        bh=cbPoRubtoHbBGltcYS5RKLVYKlncvYyNUHrVbuFLjXc=;
        h=From:Subject:Date:Message-ID:To;
        b=TBQxF8R9VNYFWJclidnAq513PlEDTRmLfTFgRwANNckcVKjHJG+dCqIF6Yvm7fCJt
         qMXNwWqWBjKD7x2JF5SQKV8cxJ75s072OO0LcUcUbwnNeG6mbP5sEH7xhGkCov8tJd
         MZP9C6gi47hrVoEYk7AAMPED88mp4Ip8cl6LY5c6YmE3z8lGmH4/7ANnIhvMYAC7dt
         YyJ/qGB/d8C+5pCdSP5TNuJ+IMgi4cZ89UflhEkhuBAwt0x82VE9clxNtTBse3uKHI
         j3wAf0TElvIz2Sng8umZpr4khveVbqK42h9Zm6eWrHTN+hIveBSFESKSkswtZsCGUi
         Z/Xw4DzZmEFBQ==
From:   Joseph Salisbury <joseph.salisbury@canonical.com>
Subject: [ANNOUNCE] 5.15.133-rt70
Date:   Tue, 24 Oct 2023 18:56:13 -0000
Message-ID: <169817377329.1028379.7397120764831029877@jupiter.home.arpa>
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
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 5.15.133-rt70 stable release.

Note that this is strictly changes to PREEMPT_RT behavior with the following
commits:

ea14d5391ab6 drm/i915: Do not disable preemption for resets
23b43390beed posix-timers: Ensure timer ID search-loop limit is valid
33390dbc8270 bpf: Remove in_atomic() from bpf_link_put().
83098c4ddc86 mm/page_alloc: Use write_seqlock_irqsave() instead write_seqlock() + local_irq_save().
08d5582b4fad locking/seqlock: Do the lockdep annotation before locking in do_write_seqcount_begin_nested()
2f43c8cdd66e sched: avoid false lockdep splat in put_task_struct()
087228e58a7f debugobjects,locking: Annotate debug_object_fill_pool() wait type violation
2139bd98f2d2 debugobject: Ensure pool refill (again)
953acf822668 Revert "softirq: Let ksoftirqd do its job"
108971fa0a8e locking/rwbase: Mitigate indefinite writer starvation
f2a15c7f3231 io-mapping: don't disable preempt on RT in io_mapping_map_atomic_wc().

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.15-rt
  Head SHA1: 2c1b5deb5b48082f07576d177ebf458e3798e85e

Or to build 5.15.133-rt70 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.15.133.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.133-rt70.patch.xz


Enjoy!
Joseph Salisbury
