Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B85867EDD3F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 10:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjKPJB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 04:01:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234879AbjKPJB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 04:01:56 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAB4D49;
        Thu, 16 Nov 2023 01:01:52 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4SWDBQ58vtz9ycMt;
        Thu, 16 Nov 2023 16:45:18 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwAnY3Nq2lVlSdzEAA--.16671S2;
        Thu, 16 Nov 2023 10:01:38 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com
Cc:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v3 0/5] Smack transmute fixes
Date:   Thu, 16 Nov 2023 10:01:20 +0100
Message-Id: <20231116090125.187209-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwAnY3Nq2lVlSdzEAA--.16671S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF1fZw4DZr45KFyxCrWktFb_yoW5Ar17pr
        saqa43Kwn5tF97Crnagw4UuF4SkayrGrWUJws3Arn7AF1DXF10qr1Iy3W5Ca48Xr9xAr9Y
        qa17Zrnxurs8X37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgCb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
        z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
        AF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
        IxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s
        0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsG
        vfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgADBF1jj5KFnwAAs8
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
applied. Tests were not executed on v3 (trivial changes).

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

The patch set applies on top of lsm/dev, commit e246777e2a03 ("MAINTAINERS:
update the LSM entry").

The ramfs patch potentially could be useful to correctly initialize the
label of new inodes in the initramfs, assuming that it will be fully
labeled with support for xattrs in the cpio image:

https://lore.kernel.org/linux-integrity/20190523121803.21638-1-roberto.sassu@huawei.com/

Ramfs inode labels will be set from xattrs with the inode_setsecurity hook.

Changelog

v2:
- Replace return with goto in the ramfs patch, for better maintainability
  (suggested by Andrew Morton)

v1:
- Rebase on top of latest lsm/next
- Remove -EOPNOTSUPP check in patch 5 (cannot happen)

Roberto Sassu (5):
  smack: Set SMACK64TRANSMUTE only for dirs in smack_inode_setxattr()
  smack: Handle SMACK64TRANSMUTE in smack_inode_setsecurity()
  smack: Always determine inode labels in smack_inode_init_security()
  smack: Initialize the in-memory inode in smack_inode_init_security()
  ramfs: Initialize security of in-memory inodes

 fs/ramfs/inode.c           | 32 ++++++++++++-
 security/smack/smack_lsm.c | 95 ++++++++++++++++++++++----------------
 2 files changed, 86 insertions(+), 41 deletions(-)

-- 
2.34.1

