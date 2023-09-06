Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE9F79416F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 18:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243054AbjIFQ0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 12:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234200AbjIFQ0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 12:26:02 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDE81997;
        Wed,  6 Sep 2023 09:25:58 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-986d8332f50so608410566b.0;
        Wed, 06 Sep 2023 09:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694017557; x=1694622357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DFyKS9LYAizDpxwKTDY8cdfFYyXTR0pnYEoYXD7nBV8=;
        b=rX6+klGbgV0BlcHJO7inqJXQ7W+ZUdRxdKim5BoW9fwV8k7JrLH/0mL25JoscaRJbi
         JklcFWRipqIaqd0a7Oc79lEEpsZrzocvZWk1EsbS+vpUgOOCBO2zpepx+lzEkqljsiEA
         Ts7xQC4/rYZTJEmVIRre5FFIwyo0M8GlHitx0AbE0xk6ETP3O7SaxHpqEta0Ck954amT
         2sUIkwHrIGWVmVhCUHTZ2f0p37X6tfwAvFXtsHlL478hw4S++tPa1By56aq0rs2TGX8h
         sZaa7ePNyJPVIBpXntSvZkTP3/aELC29dwr6cml5K6ewl381eSRdCieBLrKMC3+Kt8cn
         cOyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694017557; x=1694622357;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DFyKS9LYAizDpxwKTDY8cdfFYyXTR0pnYEoYXD7nBV8=;
        b=B/6bIKWdbKqSdwpynLSDm+BOLLb4c3kNSgNq1GraJM3p7krPJsb7rI8ptAzo04HSnE
         uCd75P7G4afHNnTIbWaunYAWAqttpE9wi99pxdHeHrAs0kjMvimlXmizkVjMroc2/LGX
         gqadHULCYfPDwC8Uqa8Z3udUG6vMhwl6JrlVVXKOIVaLz2+NmpgRbyVrR1RlKXIWKDvD
         BmXrfLKARf7gUE6LtpcY4s/jEcZA50y6Kg9cN8cGdWp6zIUIXDmuS7YnSPwyqHSZHFEx
         xxjEQ7HnFD6kGpDkeTStEhA3xilWYGwIDq1YqzoMVItHWX54Uvhsb/3frO7qUetz/Btt
         ziMg==
X-Gm-Message-State: AOJu0Yxy2dmCKVnrPlGd7R7+La8wzn3VR66uBGf6U3715bKCBGUk2dBD
        1im0q071h1JfTfxl0G1wSM4VFSxDyAo=
X-Google-Smtp-Source: AGHT+IGVGA1xIXFD+/zj3LeL6+IJHOfpIyOJ0FInGOp89y+edICQ4cXWGrzaozLpJOvx9IDWNkFh8Q==
X-Received: by 2002:a17:907:a046:b0:9a2:256a:65cd with SMTP id gz6-20020a170907a04600b009a2256a65cdmr2453844ejc.4.1694017556520;
        Wed, 06 Sep 2023 09:25:56 -0700 (PDT)
Received: from localhost.localdomain (ip-94-112-167-15.bb.vodafone.cz. [94.112.167.15])
        by smtp.gmail.com with ESMTPSA id i7-20020a170906444700b0099297c99314sm9222520ejp.113.2023.09.06.09.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 09:25:55 -0700 (PDT)
From:   Ilya Dryomov <idryomov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Ceph updates for 6.6-rc1
Date:   Wed,  6 Sep 2023 18:24:56 +0200
Message-ID: <20230906162538.1234699-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 706a741595047797872e669b3101429ab8d378ef:

  Linux 6.5-rc7 (2023-08-20 15:02:52 +0200)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-6.6-rc1

for you to fetch changes up to ce0d5bd3a6c176f9a3bf867624a07119dd4d0878:

  ceph: make num_fwd and num_retry to __u32 (2023-08-31 14:56:27 +0200)

----------------------------------------------------------------
Mixed with some fixes and cleanups, this brings in reasonably complete
fscrypt support to CephFS!  The list of things which don't work with
encryption should be fairly short, mostly around the edges: fallocate
(not supported well in CephFS to begin with), copy_file_range (requires
re-encryption), non-default striping patterns.

This was a multi-year effort principally by Jeff Layton with assistance
from Xiubo Li, Luís Henriques and others, including several dependant
changes in the MDS, netfs helper library and fscrypt framework itself.

----------------------------------------------------------------
Herbert Xu (1):
      libceph: do not include crypto/algapi.h

Jeff Layton (33):
      libceph: add spinlock around osd->o_requests
      libceph: define struct ceph_sparse_extent and add some helpers
      libceph: new sparse_read op, support sparse reads on msgr2 crc codepath
      libceph: support sparse reads on msgr2 secure codepath
      libceph: add sparse read support to msgr1
      libceph: add sparse read support to OSD client
      ceph: add new mount option to enable sparse reads
      ceph: preallocate inode for ops that may create one
      ceph: make ceph_msdc_build_path use ref-walk
      libceph: add new iov_iter-based ceph_msg_data_type and ceph_osd_data_type
      ceph: use osd_req_op_extent_osd_iter for netfs reads
      ceph: fscrypt_auth handling for ceph
      ceph: implement -o test_dummy_encryption mount option
      ceph: add fscrypt ioctls and ceph.fscrypt.auth vxattr
      ceph: encode encrypted name in ceph_mdsc_build_path and dentry release
      ceph: send alternate_name in MClientRequest
      ceph: decode alternate_name in lease info
      ceph: set DCACHE_NOKEY_NAME flag in ceph_lookup/atomic_open()
      ceph: make d_revalidate call fscrypt revalidator for encrypted dentries
      ceph: add helpers for converting names for userland presentation
      ceph: make ceph_fill_trace and ceph_get_name decrypt names
      ceph: create symlinks with encrypted and base64-encoded targets
      ceph: add some fscrypt guardrails
      ceph: size handling in MClientRequest, cap updates and inode traces
      ceph: handle fscrypt fields in cap messages from MDS
      ceph: add infrastructure for file encryption and decryption
      libceph: add CEPH_OSD_OP_ASSERT_VER support
      libceph: allow ceph_osdc_new_request to accept a multi-op read
      ceph: don't use special DIO path for encrypted inodes
      ceph: align data in pages in ceph_sync_write
      ceph: add read/modify/write to ceph_sync_write
      ceph: add encryption support to writepage and writepages
      ceph: plumb in decryption during reads

Jinjie Ruan (1):
      rbd: use list_for_each_entry() helper

Luís Henriques (8):
      ceph: add base64 endcoding routines for encrypted names
      ceph: allow encrypting a directory while not having Ax caps
      ceph: mark directory as non-complete after loading key
      ceph: invalidate pages when doing direct/sync writes
      ceph: add support for encrypted snapshot names
      ceph: prevent snapshot creation in encrypted locked directories
      ceph: update documentation regarding snapshot naming limitations
      ceph: switch ceph_lookup/atomic_open() to use new fscrypt helper

Xiubo Li (10):
      ceph: make ioctl cmds more readable in debug log
      ceph: pass the request to parse_reply_info_readdir()
      ceph: add support to readdir for encrypted names
      ceph: add object version support for sync read
      ceph: add truncate size handling support for fscrypt
      ceph: drop messages from MDS when unmounting
      ceph: wait for OSD requests' callbacks to finish when unmounting
      ceph: fix updating i_truncate_pagecache_size for fscrypt
      ceph: make members in struct ceph_mds_request_args_ext a union
      ceph: make num_fwd and num_retry to __u32

 Documentation/filesystems/ceph.rst |  10 +
 drivers/block/rbd.c                |   4 +-
 fs/ceph/Makefile                   |   1 +
 fs/ceph/acl.c                      |   4 +-
 fs/ceph/addr.c                     | 196 ++++++++---
 fs/ceph/caps.c                     | 235 +++++++++++--
 fs/ceph/crypto.c                   | 673 ++++++++++++++++++++++++++++++++++++
 fs/ceph/crypto.h                   | 288 ++++++++++++++++
 fs/ceph/dir.c                      | 194 ++++++++---
 fs/ceph/export.c                   |  44 ++-
 fs/ceph/file.c                     | 602 +++++++++++++++++++++++++++------
 fs/ceph/inode.c                    | 625 +++++++++++++++++++++++++++++++---
 fs/ceph/ioctl.c                    | 127 ++++++-
 fs/ceph/mds_client.c               | 676 ++++++++++++++++++++++++++++---------
 fs/ceph/mds_client.h               |  35 +-
 fs/ceph/quota.c                    |  14 +-
 fs/ceph/snap.c                     |  10 +-
 fs/ceph/super.c                    | 191 ++++++++++-
 fs/ceph/super.h                    |  49 ++-
 fs/ceph/xattr.c                    |  30 ++
 include/linux/ceph/ceph_fs.h       |  68 ++--
 include/linux/ceph/messenger.h     |  40 +++
 include/linux/ceph/osd_client.h    |  93 ++++-
 include/linux/ceph/rados.h         |   4 +
 net/ceph/messenger.c               |  78 +++++
 net/ceph/messenger_v1.c            |  98 +++++-
 net/ceph/messenger_v2.c            | 289 ++++++++++++++--
 net/ceph/osd_client.c              | 334 +++++++++++++++++-
 28 files changed, 4484 insertions(+), 528 deletions(-)
 create mode 100644 fs/ceph/crypto.c
 create mode 100644 fs/ceph/crypto.h
