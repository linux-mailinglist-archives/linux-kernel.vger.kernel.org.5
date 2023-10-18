Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0877CE813
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 21:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbjJRTsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 15:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjJRTsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 15:48:39 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC4095;
        Wed, 18 Oct 2023 12:48:37 -0700 (PDT)
Received: from smtp.gmail.com (1.general.jsalisbury.us.vpn [10.172.66.188])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 4D8E43F185;
        Wed, 18 Oct 2023 19:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1697658515;
        bh=11L/ScOdnUvWDhLiM6pokiRacmPDLdBYdrVJjNOkqF8=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=Meqpq2feKA9lh2BuVlvuE0NSYt8ktmvA7/a6/wToNgdhPfkUgP8OujWj4lrbKz7Q6
         izjcu2WQEIo9F5Sam1R3TRaTebNpXn3X6scMDzfSWg7Gs64yvoKx1WPgLcurDf4O5K
         Heo7WFqF0V0Pko82uMsG1feyMwvquvrmtbjJ0CUS3R/NGrOESQrDUSg0p1F98Io/+9
         +DtFZiqLJ8WBNaCVnAitO8d1NooJhuGUVRBpIdUgE9DRi7AFjmxyU0Cj4pA3ldMUj2
         xMcoO8idjvk4+lWee23oL6Nn+yyJIjIFjhIv76nmw4l61t1SA/cZSDi2dOe3OhDBcb
         Hmdl3oDd/Ounw==
From:   Joseph Salisbury <joseph.salisbury@canonical.com>
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
Subject: [PATCH RT 00/12] Linux v5.15.133-rt70-rc1
Date:   Wed, 18 Oct 2023 15:48:21 -0400
Message-Id: <20231018194833.651674-1-joseph.salisbury@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joseph Salisbury <joseph.salisbury@canonical.com>
Subject: [ANNOUNCE] 5.15.133-rt70-rc1
Date: 2023-10-25
Message-ID: <169765850976.651330.6742701415094844687@jupiter.home.arpa>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@canonical.com>

Dear RT Folks,

This is the RT stable review cycle of patch 5.15.133-rt70-rc1.

Please scream at me if I messed something up. Please test the patches
too.

The -rc release will be uploaded to kernel.org and will be deleted
when the final release is out. This is just a review release (or
release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main
release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  on the v5.15-rt-next branch.

Or to build 5.15.133-rt70-rc1 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.15.133.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.133-rt70-rc1.patch.xz

Signing key fingerprint:

  AD85 102A 6BE1 CDFE 9BCA  84F3 6CEF 3D27 CA5B 141E

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Joseph Salisbury

Changes from v5.15.133-rt69:
---


Joseph Salisbury (1):
  Linux 5.15.133-rt70

Paolo Abeni (1):
  Revert "softirq: Let ksoftirqd do its job"

Peter Zijlstra (1):
  debugobjects,locking: Annotate debug_object_fill_pool() wait type
    violation

Sebastian Andrzej Siewior (5):
  io-mapping: don't disable preempt on RT in io_mapping_map_atomic_wc().
  locking/rwbase: Mitigate indefinite writer starvation
  locking/seqlock: Do the lockdep annotation before locking in
    do_write_seqcount_begin_nested()
  mm/page_alloc: Use write_seqlock_irqsave() instead write_seqlock() +
    local_irq_save().
  bpf: Remove in_atomic() from bpf_link_put().

Thomas Gleixner (2):
  debugobject: Ensure pool refill (again)
  posix-timers: Ensure timer ID search-loop limit is valid

Tvrtko Ursulin (1):
  drm/i915: Do not disable preemption for resets

Wander Lairson Costa (1):
  sched: avoid false lockdep splat in put_task_struct()

 drivers/gpu/drm/i915/gt/intel_reset.c | 12 +++++-----
 include/linux/io-mapping.h            | 20 +++++++++++++----
 include/linux/lockdep.h               | 14 ++++++++++++
 include/linux/lockdep_types.h         |  1 +
 include/linux/sched/signal.h          |  2 +-
 include/linux/sched/task.h            | 18 +++++++++++----
 include/linux/seqlock.h               |  2 +-
 kernel/bpf/syscall.c                  | 29 +++++++++++++-----------
 kernel/locking/lockdep.c              | 28 +++++++++++++++++------
 kernel/locking/rwbase_rt.c            |  9 --------
 kernel/softirq.c                      | 22 ++----------------
 kernel/time/posix-timers.c            | 31 +++++++++++++++-----------
 lib/debugobjects.c                    | 32 ++++++++++++++++++++++-----
 localversion-rt                       |  2 +-
 mm/page_alloc.c                       | 15 +++++--------
 15 files changed, 142 insertions(+), 95 deletions(-)

-- 
2.34.1

