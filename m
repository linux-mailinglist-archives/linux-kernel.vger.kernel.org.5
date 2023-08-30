Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B8D78E0F6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240118AbjH3Uue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 16:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240241AbjH3Uuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 16:50:32 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4217EC0;
        Wed, 30 Aug 2023 13:49:51 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b9c907bc68so4106841fa.2;
        Wed, 30 Aug 2023 13:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693428524; x=1694033324; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vU5QboVHVf3d9+7NH4BpUdZfH+akLsAHcB2wO5q79hM=;
        b=HntmbxtVRILQW3IYklCiUs9KTJulj1V9BRwRrWPjUiKzrz0a1xO3CxrAgNBnMb9url
         +1rnGPMxVhl8SnVPS4QuVWTulJEXqa/WTqZBnlHIJ8DFMoFr0JxkgyHVTNpEXEuS/tFx
         fgkJsKUJV9zBonZOR6hDe+njgP4xwUHjYzxN7bms1iPDrU5Kg5NbWS/Mqs3diX6HIsFn
         opitdqJ3X47xdCY9uCr/L5enZT150W+oNpnGWmvzt+AvlZtEEXpWZ1AC48VqKVEueDqb
         c10gcnsjgQn3GXPXc3dAJqVFUktBEBSRDuIuYFRLG+H0DG1CNWP7uGtufzkVv+qCbmuF
         LT2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693428524; x=1694033324;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vU5QboVHVf3d9+7NH4BpUdZfH+akLsAHcB2wO5q79hM=;
        b=ltU+mqQPEILV6AwCNHWLEVwqaQ9LY03/Ap+uXxdgW1L3uIZ9TZo/vx+G92rmVgy3uk
         y6mhtpwEl0R3/8sYPj4/QZoz7K6CGyY/cudcrjsJraVPOs0W52zvI8ZL/y5d4I0weaq6
         BZICBV4MtVJcFearKHn9L+jAP4ENq0bVX95gqp460q2v9cOsaPA6y4qn33ZKwddXbh1X
         nqi1JDSSAbElMb2eYFXclngWBDTa86WaxoombT5/bvBeEtmUGIIAO5QX7yWEQhz12MDa
         uP8cznlXOgKD9NxD9EP15TDwYM69I4l4//7r45vXNb6stvkdfW3t3C7+H4cehE0tXSGY
         p1fA==
X-Gm-Message-State: AOJu0Yw2AvkmTXg8JWe3FRnfjU9Cn6iWTsCDgZlU2/KMYLSwZ4az92JE
        N6Nf629S/dUnvco36HBYfOWvHIPJ0ahQb1utHTxf0ketHr1NftqZ
X-Google-Smtp-Source: AGHT+IEiJElM6g/gvAJSVWZEdmn0tPeEphMbBxEm9I+yTO8q7sAr7YaiCI+TMTXU0irpQr4Ju6BPVkEaehtIdB2Nmss=
X-Received: by 2002:a2e:9959:0:b0:2b9:e230:25ce with SMTP id
 r25-20020a2e9959000000b002b9e23025cemr2972943ljj.12.1693428523493; Wed, 30
 Aug 2023 13:48:43 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 30 Aug 2023 15:48:32 -0500
Message-ID: <CAH2r5mtpOtiP3Hk6FJPav8tYDhKJTQmELP31zYzVxf4DPNKbiQ@mail.gmail.com>
Subject: [GIT PULL] smb3 client fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dave Kleikamp <shaggy@kernel.org>,
        "Dr. David Alan Gilbert" <linux@treblig.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull the following changes since commit
706a741595047797872e669b3101429ab8d378ef:

  Linux 6.5-rc7 (2023-08-20 15:02:52 +0200)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/6.6-rc-smb3-client-fixes-part1

for you to fetch changes up to f3a9b3758e0b6d40183929aba599a7da52313a3e:

  fs/jfs: Use common ucs2 upper case table (2023-08-30 08:55:52 -0500)

----------------------------------------------------------------
22 smb3/cifs client fixes and two related changes (cleaning up some
common code for unicode mapping)
- six fixes for excessive stack usage
- multichannel reconnect improvements
- DFS fix and four DFS cleanup patches
- move UCS-2 conversion code to fs/nls and update cifs.ko and jfs.ko to use them
- Cleanup patch for compounding, one to fix confusing function name
- inode number collision fix
- three reparse point fixes (including avoiding an extra unneeded
query on symlinks) and one minor cleanup
- directory lease (caching) improvement

----------------------------------------------------------------
Bharath SM (1):
      cifs: update desired access while requesting for directory lease

Dr. David Alan Gilbert (4):
      fs/smb: Remove unicode 'lower' tables
      fs/smb: Swing unicode common code from smb->NLS
      fs/smb/client: Use common code in client
      fs/jfs: Use common ucs2 upper case table

Paulo Alcantara (17):
      smb: client: introduce DFS_CACHE_TGT_LIST()
      smb: client: ensure to try all targets when finding nested links
      smb: client: move some params to cifs_open_info_data
      smb: client: make smb2_compound_op() return resp buffer on success
      smb: client: rename cifs_dfs_ref.c to namespace.c
      smb: client: get rid of dfs naming in automount code
      smb: client: get rid of dfs code dep in namespace.c
      smb: client: parse reparse point flag in create response
      smb: client: do not query reparse points twice on symlinks
      smb: client: query reparse points in older dialects
      smb: cilent: set reparse mount points as automounts
      smb: client: reduce stack usage in cifs_try_adding_channels()
      smb: client: reduce stack usage in cifs_demultiplex_thread()
      smb: client: reduce stack usage in smb_send_rqst()
      smb: client: reduce stack usage in smb2_set_ea()
      smb: client: reduce stack usage in smb2_query_info_compound()
      smb: client: reduce stack usage in smb2_query_reparse_point()

Steve French (2):
      [SMB3] send channel sequence number in SMB3 requests after reconnects
      SMB3: rename macro CIFS_SERVER_IS_CHAN to avoid confusion

 fs/jfs/Kconfig                                   |   1 +
 fs/jfs/Makefile                                  |   2 +-
 fs/jfs/jfs_unicode.h                             |  17 ++---
 fs/jfs/jfs_uniupr.c                              | 121
---------------------------------
 fs/nls/Kconfig                                   |   8 +++
 fs/nls/Makefile                                  |   1 +
 fs/nls/nls_ucs2_data.h                           |  15 ++++
 fs/{smb/server/uniupr.h => nls/nls_ucs2_utils.c} | 156
+++++-------------------------------------
 fs/nls/nls_ucs2_utils.h                          | 285
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/smb/client/Kconfig                            |   1 +
 fs/smb/client/Makefile                           |   5 +-
 fs/smb/client/cached_dir.c                       |   2 +-
 fs/smb/client/cifs_debug.c                       |   2 +-
 fs/smb/client/cifs_unicode.c                     |   1 -
 fs/smb/client/cifs_unicode.h                     | 330
+---------------------------------------------------------------------------------------
 fs/smb/client/cifs_uniupr.h                      | 239
----------------------------------------------------------------
 fs/smb/client/cifsfs.c                           |   2 +-
 fs/smb/client/cifsfs.h                           |  11 +--
 fs/smb/client/cifsglob.h                         |  72 ++++++++++++++++----
 fs/smb/client/cifsproto.h                        |   9 ++-
 fs/smb/client/connect.c                          |  21 +++---
 fs/smb/client/dfs.c                              | 271
+++++++++++++++++++++++++++++++++++++++---------------------------------
 fs/smb/client/dfs.h                              | 141
++++++++++++++++++++++++++++----------
 fs/smb/client/dfs_cache.c                        |  10 ++-
 fs/smb/client/dfs_cache.h                        |  12 ++--
 fs/smb/client/dir.c                              |   4 +-
 fs/smb/client/inode.c                            | 498
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------------------------------------
 fs/smb/client/misc.c                             |   2 +-
 fs/smb/client/{cifs_dfs_ref.c => namespace.c}    | 113
++++++++++++++++--------------
 fs/smb/client/readdir.c                          |  23 ++-----
 fs/smb/client/sess.c                             |  72 ++++++++++++--------
 fs/smb/client/smb1ops.c                          |  26 ++++---
 fs/smb/client/smb2inode.c                        | 203
++++++++++++++++++++++++++++++------------------------
 fs/smb/client/smb2misc.c                         |   6 +-
 fs/smb/client/smb2ops.c                          | 298
+++++++++++++++++++++++++------------------------------------------------------
 fs/smb/client/smb2pdu.c                          |  19 ++++--
 fs/smb/client/smb2proto.h                        |  17 +++--
 fs/smb/client/smb2transport.c                    |   4 +-
 fs/smb/client/transport.c                        |  29 ++++----
 fs/smb/common/smb2pdu.h                          |  22 ++++++
 fs/smb/server/Kconfig                            |   1 +
 fs/smb/server/unicode.c                          |   1 -
 fs/smb/server/unicode.h                          | 325
++-------------------------------------------------------------------------------------
 43 files changed, 1377 insertions(+), 2021 deletions(-)
 delete mode 100644 fs/jfs/jfs_uniupr.c
 create mode 100644 fs/nls/nls_ucs2_data.h
 rename fs/{smb/server/uniupr.h => nls/nls_ucs2_utils.c} (50%)
 create mode 100644 fs/nls/nls_ucs2_utils.h
 delete mode 100644 fs/smb/client/cifs_uniupr.h
 rename fs/smb/client/{cifs_dfs_ref.c => namespace.c} (62%)

-- 
Thanks,

Steve
