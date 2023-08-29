Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C98E78D0AB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 01:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241162AbjH2Xhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 19:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241172AbjH2Xhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 19:37:41 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0226C2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 16:37:37 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-592976e5b6dso52327197b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 16:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1693352257; x=1693957057; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gK3e7lXauP8VIW7K+GW/2SXWNrpVfVSrfihDaOjJxf0=;
        b=I9koYwWQzF3i9ThQXbkpf/NvWf9hOG2Fr02FaWIqQtqGZ2CUCUYqj7EZXznajZLXsO
         Lx8rkRLXtoEV16icY8iTp+fx57ghhKw2EuiWKpTp2Hr7e3QuqbPZw6gdbnCYQOBrjONT
         4EihF7/KQ5RIMmlemSvJ7xZjagCb0vf/6BUL23wyx/IzRKnDVclPWw8rVs8uGTO0I/Yq
         4FrUy5Z0ewB5Scu6+LUQf9K3CzY0GTWsuBQ6DGwRphDEoDkoi7Vg77O3qrSJe2DVe2yV
         zC44wbXSJ/LaNVwV0QqEj+4hv1H4do3TkLyqtgW8e7yVypV3YSbRxiSO74wvg1rxT2g9
         zMKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693352257; x=1693957057;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gK3e7lXauP8VIW7K+GW/2SXWNrpVfVSrfihDaOjJxf0=;
        b=OxTB/NWJTDONxpM77bg9zfjnW6pGccm0G+bd321GuPILgPfxrBYiYbYS1rDg9QV88M
         tJllaJpRGcCoFpXNSMQByXBpUw02+yraf4vjDrQFeTSMre7IAsTy26z0xiTYIymEDKAO
         /iYZ748eoZogAdnea5jvuItfzkXJ8SVz/tIESH7P6TIO8rlp/Bl+dzAVwp2ibO1y3whD
         fzpUCHnXc8vBZC7Pz/qGDzQOYEMYkzXXRjzDezDed+/vuOP9m23EAurJt3dP+IB9XAvl
         fb3jUnEC4wJeZQFHRbKU4ray/Uc9qm9H7Xwk89LvVUDZnHvitM4A0Tk7Hw3+xhYjQm/n
         7oVQ==
X-Gm-Message-State: AOJu0YwimOSMBECleCmCDy7XVFCwRG5ELMrmjyxDMaho9ELkGrz7l7pk
        VPw0rFn1BxNhB2T9TedeIinzLWm0qLHVdPbnlOJvQS0+yeCI1eHVww==
X-Google-Smtp-Source: AGHT+IHRMRMQKa5kta7mCj2xj/QNB/wy2Nuwv4Af2cqnrGMMOUzjcpYmpyXaVI6aeYp1ODm0+SJSnrf1l6gbZNn8Kco=
X-Received: by 2002:a81:5c83:0:b0:592:2237:ea94 with SMTP id
 q125-20020a815c83000000b005922237ea94mr507104ywb.29.1693352256812; Tue, 29
 Aug 2023 16:37:36 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 29 Aug 2023 19:37:26 -0400
Message-ID: <CAHC9VhQQqQCdcSdb7G8v1ZHU8zn0XJZ6hS0rbGufAuZyPSCDCA@mail.gmail.com>
Subject: [GIT PULL] LSM patches for v6.6
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Ten LSM patches for the Linux v6.6 merge window, and while most of
them are fairly minor, there is at least one merge conflict involving
security_sk_classify_flow() in security/security.c; it looks like a
netdev constification patch collided with a LSM documentation patch,
thankfully the solution is relatively simple but if for some odd
reason you need a respin let me know.

On to the highlights ...

- Add proper multi-LSM support for xattrs in the
security_inode_init_security() hook

Historically the LSM layer has only allowed a single LSM to add an
xattr to an inode, with IMA/EVM measuring that and adding its own as
well.  As we work towards promoting IMA/EVM to a "proper LSM" instead
of the special case that it is now, we need to better support the case
of multiple LSMs each adding xattrs to an inode and after several
attempts we now appear to have something that is working well.  It is
worth noting that in the process of making this change we uncovered a
problem with Smack's SMACK64TRANSMUTE xattr which is also fixed in
this pull request.

- Additional LSM hook constification

Two patches to constify parameters to security_capget() and
security_binder_transfer_file().  While I generally don't make a
special note of who submitted these patches, these were the work of an
Outreachy intern, Khadija Kamran, and that makes me happy; hopefully
it does the same for all of you reading this.

- LSM hook comment header fixes

One patch to add a missing hook comment header, one to fix a minor typo.

- Remove an old, unused credential function declaration

It wasn't clear to me who should pick this up, but it was trivial,
obviously correct, and arguably the LSM layer has a vested interest in
credentials so I merged it.  Sadly I'm now noticing that despite my
subject line cleanup I didn't cleanup the "unsued" misspelling, sigh.

Please merge,
-Paul

--
The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

 Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

 https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
   tags/lsm-pr-20230829

for you to fetch changes up to 8e4672d6f902d5c4db1e87e8aa9f530149d85bc6:

 lsm: constify the 'file' parameter in security_binder_transfer_file()
   (2023-08-15 16:04:34 -0400)

----------------------------------------------------------------
lsm/stable-6.6 PR 20230829

----------------------------------------------------------------
Khadija Kamran (3):
     lsm: add comment block for security_sk_classify_flow LSM hook
     lsm: constify the 'target' parameter in security_capget()
     lsm: constify the 'file' parameter in security_binder_transfer_file()

Pairman Guo (1):
     lsm: fix typo in security_file_lock() comment header

Roberto Sassu (5):
     security: Allow all LSMs to provide xattrs for inode_init_security hook
     smack: Set the SMACK64TRANSMUTE xattr in smack_inode_init_security()
     evm: Align evm_inode_init_security() definition with LSM infrastructure
     evm: Support multiple LSMs providing an xattr
     security: Fix ret values doc for security_inode_init_security()

YueHaibing (1):
     cred: remove unsued extern declaration change_create_files_as()

include/linux/cred.h                |  1 -
include/linux/evm.h                 | 14 +++---
include/linux/lsm_hook_defs.h       | 10 ++---
include/linux/lsm_hooks.h           | 20 +++++++++
include/linux/security.h            | 11 ++---
kernel/capability.c                 |  2 +-
security/apparmor/lsm.c             |  2 +-
security/commoncap.c                |  2 +-
security/integrity/evm/evm.h        |  4 +-
security/integrity/evm/evm_crypto.c | 11 ++++-
security/integrity/evm/evm_main.c   | 39 +++++++++++++---
security/security.c                 | 90 +++++++++++++++++++++++----------
security/selinux/hooks.c            | 27 +++++------
security/smack/smack.h              |  2 +-
security/smack/smack_lsm.c          | 68 ++++++++++++++++------------
15 files changed, 202 insertions(+), 101 deletions(-)

-- 
paul-moore.com
