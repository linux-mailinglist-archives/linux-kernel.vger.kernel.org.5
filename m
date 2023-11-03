Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993407E01F1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 12:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345220AbjKCLOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 07:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346142AbjKCLN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 07:13:56 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420B218B;
        Fri,  3 Nov 2023 04:13:50 -0700 (PDT)
Received: from [10.8.192.2] (unknown [50.39.103.33])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 80D934354F;
        Fri,  3 Nov 2023 11:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1699010027;
        bh=kv09A4g6nezeo8oelDC/CMBuWkrHQKwHC3idMyrd2Q0=;
        h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type;
        b=JYfy2UgylO43bC5OUkY+p9aHeuMIjrxyd5cjyvbElZeMonXvMoQ7TgFhJsE/1Itqp
         fMTonkG8MXWo31kr4NIlWkt8NHk3TKyLlqlsNAytQLRadqzd/dkYUHU2GJghiK3q+1
         JlXcYd0rIyOnDoui/oORYtOHhpKYTQAzsKgw7gx+KR9P4IElqVE8+AzM9U/06jjrnu
         o1sEvJXLAwly8qDGmZbP/Up7IqUnCVCTaiU6oPZbUL5qtrF253vvEY7uGTULH5ZhH8
         4GrGDfEgrMXpVtSxUlos1wcdDhFmaCbaV8dpFPJxUwYv00YenGpU+YLr0dNkNQ4DDn
         wjChd8CnlKo1A==
Message-ID: <bf45d4d9-5a15-4ba3-9f55-b8c7e300dc54@canonical.com>
Date:   Fri, 3 Nov 2023 04:13:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   John Johansen <john.johansen@canonical.com>
Subject: [GIT PULL] AppArmor updates for 6.7
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKLM <linux-kernel@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>
Content-Language: en-US
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the following apparmor for patches for the 6.7 merge
window.

This PR adds initial support for mediating io_uring and userns
creation.  Adds a new restriction that tightens the use of
change_profile, and a couple of optimizations to reduce performance
bottle necks that have been found when retrieving the current task's
secid and allocating work buffers.

The majority of the patch set continues cleaning up and simplifying
the code (fixing comments, removing now dead functions, and macros
etc). Finally there are 4 bug fixes, with the regression fix having
had a couple months of testing.

These patches have been in linux-next and been tested while in there,
and have also had a merge and regression test against your current
tree as of a day ago.

thanks
- john


The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

   Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor tags/apparmor-pr-2023-11-03

for you to fetch changes up to 6cede10161be00d129a24e8b84c2674785a32cf8:

   apparmor: Fix some kernel-doc comments (2023-10-23 00:26:27 -0700)

----------------------------------------------------------------
+ Features
   - optimize retrieving current task secid
   - add base io_uring mediation
   - add base userns mediation
   - improve buffer allocation
   - allow restricting unprivilege change_profile

+ Cleanups
   - Fix kernel doc comments
   - remove unused declarations
   - remove unused functions
   - remove unneeded #ifdef
   - remove unused macros
   - mark fns static
   - cleanup fn with unused return values
   - cleanup audit data
   - pass cred through to audit data
   - refcount the pdb instead of using duplicates
   - make SK_CTX macro an inline fn
   - some comment cleanups

+ Bug fixes
   - fix regression in mount mediation
   - fix invalid refenece
   - use passed in gfp flags
   - advertise avaiability of extended perms and disconnected.path

----------------------------------------------------------------
Arnd Bergmann (1):
       apparmor: mark new functions static

Dan Carpenter (1):
       apparmor: use passed in gfp flags in aa_alloc_null()

GONG, Ruiqi (2):
       apparmor: remove unused macro
       apparmor: remove unused PROF_* macros

Gaosheng Cui (11):
       apparmor: Fix kernel-doc warnings in apparmor/audit.c
       apparmor: Fix kernel-doc warnings in apparmor/capability.c
       apparmor: Fix kernel-doc warnings in apparmor/domain.c
       apparmor: Fix kernel-doc warnings in apparmor/file.c
       apparmor: Fix kernel-doc warnings in apparmor/label.c
       apparmor: Fix kernel-doc warnings in apparmor/lib.c
       apparmor: Fix kernel-doc warnings in apparmor/match.c
       apparmor: Fix kernel-doc warnings in apparmor/resource.c
       apparmor: Fix kernel-doc warnings in apparmor/policy_unpack.c
       apparmor: Fix kernel-doc warnings in apparmor/policy_compat.c
       apparmor: Fix kernel-doc warnings in apparmor/policy.c

Georgia Garcia (2):
       apparmor: fix invalid reference on profile->disconnected
       apparmor: add io_uring mediation

John Johansen (13):
       apparmor: advertise availability of exended perms
       apparmor: fixup return comments for kernel doc cleanups by Gaosheng Cui
       apparmor: rename SK_CTX() to aa_sock and make it an inline fn
       apparmor: combine common_audit_data and apparmor_audit_data
       apparmor: rename audit_data->label to audit_data->subj_label
       apparmor: pass cred through to audit info.
       apparmor: provide separate audit messages for file and policy checks
       apparmor: refcount the pdb
       apparmor: advertise disconnected.path is available
       apparmor: allow restricting unprivileged change_profile
       apparmor: add user namespace creation mediation
       apparmor: cache buffers on percpu list if there is lock contention
       apparmor: Fix regression in mount mediation

Quanfa Fu (1):
       apparmor: make aa_set_current_onexec return void

Vinicius Costa Gomes (1):
       apparmor: Optimize retrieving current task secid

Xiu Jianfeng (4):
       apparmor: cleanup unused declarations in policy.h
       apparmor: cleanup unused functions in file.h
       apparmor: remove unneeded #ifdef in decompress_zstd()
       apparmor: remove unused functions in policy_ns.c/.h

Yang Li (3):
       apparmor: Fix some kernel-doc comments
       apparmor: Fix one kernel-doc comment
       apparmor: Fix some kernel-doc comments

  security/apparmor/apparmorfs.c         |  49 ++--
  security/apparmor/audit.c              |  75 +++---
  security/apparmor/capability.c         |  33 +--
  security/apparmor/domain.c             | 193 +++++++++------
  security/apparmor/file.c               | 217 ++++++++++-------
  security/apparmor/include/apparmor.h   |   3 +-
  security/apparmor/include/audit.h      |  44 ++--
  security/apparmor/include/capability.h |   3 +-
  security/apparmor/include/file.h       |  54 +----
  security/apparmor/include/ipc.h        |   4 +-
  security/apparmor/include/lib.h        |   2 +
  security/apparmor/include/match.h      |   6 -
  security/apparmor/include/mount.h      |  26 ++-
  security/apparmor/include/net.h        |  25 +-
  security/apparmor/include/perms.h      |   7 +-
  security/apparmor/include/policy.h     |  68 ++++--
  security/apparmor/include/policy_ns.h  |  14 --
  security/apparmor/include/resource.h   |   3 +-
  security/apparmor/include/task.h       |  11 +-
  security/apparmor/ipc.c                |  53 +++--
  security/apparmor/label.c              |  46 ++--
  security/apparmor/lib.c                |  54 ++---
  security/apparmor/lsm.c                | 414 ++++++++++++++++++++++++++++-----
  security/apparmor/match.c              |  48 +---
  security/apparmor/mount.c              | 186 +++++++++------
  security/apparmor/net.c                |  65 +++---
  security/apparmor/policy.c             | 133 +++++++----
  security/apparmor/policy_compat.c      |   1 +
  security/apparmor/policy_ns.c          |  37 ---
  security/apparmor/policy_unpack.c      | 152 ++++++------
  security/apparmor/resource.c           |  54 +++--
  security/apparmor/task.c               | 104 ++++++---
  32 files changed, 1336 insertions(+), 848 deletions(-)

