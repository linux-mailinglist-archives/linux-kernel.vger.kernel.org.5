Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01FA47E707D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 18:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344741AbjKIRlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 12:41:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234657AbjKIRlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 12:41:04 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27273D58;
        Thu,  9 Nov 2023 09:41:02 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-53f9af41444so1912439a12.1;
        Thu, 09 Nov 2023 09:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699551660; x=1700156460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=07kyYbTdzzvjgx9MD5sep6il5lQYPpmm+4Zz1muN1eM=;
        b=ASH1BbMHNm50aAdVE5S51mJRF1XIKsGyhuSpZ7nkfXZvC300bwbJGWlbAWAOHOGN2r
         Pp5Y1U80gaySe0wDLfGCrVpJcP4C3cHOQ+h6A/OD0FK/EB76+7rRopFQ0W88d0prHv4a
         LVIRpOeEu/CwBn+xnXcY0SYUKzVbBM7FIoX7DymPXUTcsM/vetGC+aPZR0kBErzbtAei
         zUJsNix1mQLvNrqTbBR+hnGAR0t875B+3XnU/vavv1JPzmBlp6+DKCU4TGNucMIRXz0I
         9HqLCY2zSW6r9Lp/3jOh64TRFKFF0OJCiTJuWlfNPs1a8rFrm7IUtMdk0Epvn2ITsj2c
         4Adg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699551660; x=1700156460;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=07kyYbTdzzvjgx9MD5sep6il5lQYPpmm+4Zz1muN1eM=;
        b=N1Sg7RSDNTIiorYjj9dFlWAjsNwdulM/pm5/Uo5RJte5HzYEvk1zs2BA9kC42K5LSw
         ajNpupS5fcAq0Z10R9xTrKb1S3VB756ZWIhSCK26f3qE1f9M77tTSPNYj6tJC2wqbz07
         wrBL0+2mgPDBhQWm9FdoABETzS3cb0DZ2a0xMmfOLYfNSrhZt85Za4j/dag8j+oL1R44
         Ve5xta1PVmERZH6rqozIzG01PI+pn2GDJ1cd6plbRjNJ3SUMGAiOHwsipt+pq2w0C8lc
         vMgUUK8i1syA2Fy4Nz+O1K9N7Ph8GPDtqNXERw5xgGGdcDyBTRIjFVvGdtAdmlQCmQ58
         YWDQ==
X-Gm-Message-State: AOJu0YyE3n1Rp54s9/bRdZZ1VHgjyFa0jSvtA6phr2MaJmieJlmxjPxk
        UJodeHrcbke6/Z3ojMNOBK3+vIvGQxE=
X-Google-Smtp-Source: AGHT+IF1roK4NxSaYsYXjL/5lEKfT5WDq2m+QyojtS+xlnXp6AZgkXvaeyZcL/jUoXiMWpML1xcgRw==
X-Received: by 2002:a17:907:744:b0:9de:32bb:faab with SMTP id xc4-20020a170907074400b009de32bbfaabmr4670264ejb.32.1699551660369;
        Thu, 09 Nov 2023 09:41:00 -0800 (PST)
Received: from localhost.localdomain (ip-94-112-167-15.bb.vodafone.cz. [94.112.167.15])
        by smtp.gmail.com with ESMTPSA id g24-20020a170906349800b0099bccb03eadsm2793845ejb.205.2023.11.09.09.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 09:40:59 -0800 (PST)
From:   Ilya Dryomov <idryomov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Ceph updates for 6.7-rc1
Date:   Thu,  9 Nov 2023 18:40:42 +0100
Message-ID: <20231109174044.269054-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit ffc253263a1375a65fa6c9f62a893e9767fbebfa:

  Linux 6.6 (2023-10-29 16:31:08 -1000)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-6.7-rc1

for you to fetch changes up to 56d2e2cfa21315c12945c22e141c7e7ec8b0a630:

  ceph: allow idmapped mounts (2023-11-03 23:28:34 +0100)

There are a few conflicts in fs/ceph/inode.c caused by a clash between
the conversion to new timestamp accessors in VFS and logging changes in
CephFS.  I have the resolution in for-linus-merged, it's the same as in
linux-next.

----------------------------------------------------------------
Two items:

- support for idmapped mounts in CephFS (Christian Brauner, Alexander
  Mikhalitsyn).  The series was originally developed by Christian and
  later picked up and brought over the finish line by Alexander, who
  also contributed an enabler on the MDS side (separate owner_{u,g}id
  fields on the wire).  The required exports for mnt_idmap_{get,put}()
  in VFS have been acked by Christian and received no objection from
  Christoph.

- a churny change in CephFS logging to include cluster and client
  identifiers in log and debug messages (Xiubo Li).  This would help
  in scenarios with dozens of CephFS mounts on the same node which are
  getting increasingly common, especially in the Kubernetes world.

----------------------------------------------------------------
Alexander Mikhalitsyn (3):
      fs: export mnt_idmap_get/mnt_idmap_put
      ceph: add enable_unsafe_idmap module parameter
      ceph: pass idmap to __ceph_setattr

Christian Brauner (9):
      ceph: stash idmapping in mdsc request
      ceph: handle idmapped mounts in create_request_message()
      ceph: pass an idmapping to mknod/symlink/mkdir
      ceph: allow idmapped getattr inode op
      ceph: allow idmapped permission inode op
      ceph: allow idmapped setattr inode op
      ceph: allow idmapped set_acl inode op
      ceph: allow idmapped atomic_open inode op
      ceph: allow idmapped mounts

Xiubo Li (5):
      libceph: add doutc and *_client debug macros support
      ceph: pass the mdsc to several helpers
      ceph: rename _to_client() to _to_fs_client()
      ceph: print cluster fsid and client global_id in all debug logs
      libceph, ceph: move mdsmap.h to fs/ceph

 fs/ceph/acl.c                       |  12 +-
 fs/ceph/addr.c                      | 299 +++++++-------
 fs/ceph/cache.c                     |   2 +-
 fs/ceph/caps.c                      | 763 +++++++++++++++++++++---------------
 fs/ceph/crypto.c                    |  43 +-
 fs/ceph/debugfs.c                   |  10 +-
 fs/ceph/dir.c                       | 242 +++++++-----
 fs/ceph/export.c                    |  49 +--
 fs/ceph/file.c                      | 282 +++++++------
 fs/ceph/inode.c                     | 529 ++++++++++++++-----------
 fs/ceph/ioctl.c                     |  21 +-
 fs/ceph/locks.c                     |  57 +--
 fs/ceph/mds_client.c                | 678 +++++++++++++++++++-------------
 fs/ceph/mds_client.h                |  13 +-
 fs/ceph/mdsmap.c                    |  29 +-
 {include/linux => fs}/ceph/mdsmap.h |   5 +-
 fs/ceph/metric.c                    |   5 +-
 fs/ceph/quota.c                     |  29 +-
 fs/ceph/snap.c                      | 192 +++++----
 fs/ceph/super.c                     |  99 +++--
 fs/ceph/super.h                     |  23 +-
 fs/ceph/xattr.c                     | 108 ++---
 fs/mnt_idmapping.c                  |   2 +
 include/linux/ceph/ceph_debug.h     |  38 ++
 include/linux/ceph/ceph_fs.h        |  10 +-
 include/linux/mnt_idmapping.h       |   3 +
 26 files changed, 2070 insertions(+), 1473 deletions(-)
 rename {include/linux => fs}/ceph/mdsmap.h (92%)
