Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07AA775FA8F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 17:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjGXPSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 11:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjGXPSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 11:18:43 -0400
Received: from frasgout11.his.huawei.com (unknown [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1BD1B3;
        Mon, 24 Jul 2023 08:18:41 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4R8k6H75YYz9yGhL;
        Mon, 24 Jul 2023 23:07:19 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwCHTlU3lr5kJcTzBA--.28220S2;
        Mon, 24 Jul 2023 16:18:26 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com
Cc:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v2 0/5] Smack transmute fixes
Date:   Mon, 24 Jul 2023 17:13:36 +0200
Message-Id: <20230724151341.538889-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwCHTlU3lr5kJcTzBA--.28220S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF1fZw4DZr45KFyxCrWktFb_yoW5WrW7pr
        saqa43Kwn5tF97Crnagw4UuF4fKayrGrWUJwsxAr1kAF1DZF10qryIva15Ca48JrZxAr9a
        qa17ZrnxWrs8X37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
        z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
        AF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
        IxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WF
        yUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIY
        CTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAIBF1jj4zfVAADs7
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

The first two patches are obvious fixes, the first restricts setting the
SMACK64TRANSMUTE xattr only for directories, and the second makes it
possible to set SMACK64TRANSMUTE if the filesystem does not support xattrs
(e.g. ramfs).

The remaining fixes are optional, and only required if we want filesystems
without xattr support behave like those with xattr support. Since we have
the inode_setsecurity and inode_getsecurity hooks to make the first group
work, it seems useful to fix inode creation too (SELinux should be fine).

The third patch is merely a code move out of the 'if (xattr)' condition.
The fourth updates the security field of the in-memory inode directly in
smack_inode_init_security() and marks the inode as instantiated, and the
fifth adds a security_inode_init_security() call in ramfs to initialize the
security field of the in-memory inodes (needed to test transmuting
directories).

Both the Smack (on xfs) and IMA test suite succeed with all patches
applied.

By executing the tests in a ramfs, the results are:

Without the patches:
86 Passed, 9 Failed, 90% Success rate

With the patches:
93 Passed, 2 Failed, 97% Success rate

The remaining two failures are:
2151  ioctl(4, BTRFS_IOC_CLONE or FICLONE, 3) = -1 EOPNOTSUPP (Operation not supported)
2152  lsetxattr("./targets/proc-attr-Snap", "security.SMACK64EXEC", "Pop", 3, 0) = -1 EOPNOTSUPP (Operation not supported)

The first one is likely due ramfs lack of support for ioctl() while the
second could be fixed by handling SMACK64EXEC in smack_inode_setsecurity().

The patch set applies on top of:

https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git/commit/?h=next&id=ca22eca6e2ad7eaed1c791628ef7cb4c739e3da6


The ramfs patch potentially could be useful to correctly initialize the
label of new inodes in the initramfs, assuming that it will be fully
labeled with support for xattrs in the cpio image:

https://lore.kernel.org/linux-integrity/20190523121803.21638-1-roberto.sassu@huawei.com/

Ramfs inode labels will be set from xattrs with the inode_setsecurity hook.

Changelog

v1:
- Rebase on top of latest lsm/next
- Remove -EOPNOTSUPP check in patch 5 (cannot happen)

Roberto Sassu (5):
  smack: Set SMACK64TRANSMUTE only for dirs in smack_inode_setxattr()
  smack: Handle SMACK64TRANSMUTE in smack_inode_setsecurity()
  smack: Always determine inode labels in smack_inode_init_security()
  smack: Initialize the in-memory inode in smack_inode_init_security()
  ramfs: Initialize security of in-memory inodes

 fs/ramfs/inode.c           | 27 +++++++++++
 security/smack/smack_lsm.c | 97 ++++++++++++++++++++++----------------
 2 files changed, 83 insertions(+), 41 deletions(-)

-- 
2.34.1

