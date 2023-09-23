Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACEC17AC3F1
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 19:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjIWR20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 13:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjIWR2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 13:28:25 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DE2AF;
        Sat, 23 Sep 2023 10:28:18 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50437f39c9dso3941808e87.3;
        Sat, 23 Sep 2023 10:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695490097; x=1696094897; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tAJqcoiRIbP3+YidYPizOIU9nGOIZqp53grJQHhvEMk=;
        b=mHyNkOfBp1OkgMmUWWxp3SdrnXVAPxKoR7Kq95iNCYG8RMiPZ/8Ama1yd8O0hj/zXt
         hTQ+Dh5gljxoBumsr13do2+OzD6TcjZW7Lt+T0X3jyc0iIH2XBqyDdBJxmdTkJPc/8fH
         0I/MT7WLsIiUKdMdlT3b/G0o7CYO0KYSRLnnwaPYY399Hvx8QhJH4DLXFxBLVHLlXgQn
         AHUpROA5glX3lbJKxH1/GYV74xpT2D8Hk7L6nGLXkNzIbs4oO46OBciPj8xO8QqMYp6Z
         dkDOwfObI/2cQ3/atYtlADxdg7qOp3oYEjUIcqcvcztE5GH+AQjdgQcWJO3XTp+BaqqT
         6nLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695490097; x=1696094897;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tAJqcoiRIbP3+YidYPizOIU9nGOIZqp53grJQHhvEMk=;
        b=eUcOY7JehDC8YBXddJSNzNLPKLuRclmwRReZTeAx0ua1EFBWnwmTXMUj9PADixMLPW
         6wtN048CUbyxh/V2Suc9fDwL3IJO0bVTTv2BDSHVssoxrnb0FqlpFwW5tNmKG53Eun9k
         1J3UAkIaf52Nwmzs6jdB8yxa/NZEaEOw8rlf0csKTIkJqrbBVaKf1HFB1xfnlU4E4hnv
         CyQ983H+XuU6kVtX68iMloUC6eZDAMR0FjG8lU1r2a+xkbuFhCwhjK3/nX65vgF52HRg
         S1zB/3Hjtpc358E6qqAFJi6qi611eNWVJuJDcGG2ZkXYOYS0VP+FiATNm+Up9j2VOFvR
         2Gpg==
X-Gm-Message-State: AOJu0YwJ49NX/sFrclkRSV+KMM1uMEu4OyTrHhT4tVJv1Cm5Sb0LxA9r
        ekwR8VS+wcVWg00bJPbsdKqORi4rQUzy/DQ4kneDaf5cd90=
X-Google-Smtp-Source: AGHT+IHNBdnTigY92wOqORHWahSMmbVERL7rr/FvKY9wQ7tTbo6HGfSg4cxYWrR4okRxbSISs1Slx+5Z6+31z3iKhno=
X-Received: by 2002:a05:6512:3a95:b0:502:a549:8fa4 with SMTP id
 q21-20020a0565123a9500b00502a5498fa4mr2354858lfu.13.1695490096515; Sat, 23
 Sep 2023 10:28:16 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 23 Sep 2023 12:28:05 -0500
Message-ID: <CAH2r5muY+WP7WKfzpPxaGM53fdEEwCQnRgkwOFWFuh2y3Odb9A@mail.gmail.com>
Subject: [GIT PULL] smb3 client fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
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
ce9ecca0238b140b88f43859b211c9fdfd8e5b70:

  Linux 6.6-rc2 (2023-09-17 14:40:24 -0700)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/6.6-rc2-smb3-client-fixes

for you to fetch changes up to c8ebf077fbebda3a24335660ded7cff4b90331b8:

  smb3: fix confusing debug message (2023-09-20 19:50:05 -0500)

----------------------------------------------------------------
Six smb3 client fixes, including three for stable, from the SMB plugfest
(testing event) this week

- Reparse point handling fix (found when investigating dir enumeration
when fifo in dir)
- Fix excessive thread creation for dir lease cleanup
- UAF fix in negotiate path
- remove duplicate error message mapping and fix confusing warning message
- add dynamic trace point to improve debugging RDMA connection attempts

----------------------------------------------------------------
Paulo Alcantara (1):
      smb: client: handle STATUS_IO_REPARSE_TAG_NOT_HANDLED

Steve French (4):
      smb3: Add dynamic trace points for RDMA (smbdirect) reconnect
      smb3: do not start laundromat thread when dir leases  disabled
      smb3: remove duplicate error mapping
      smb3: fix confusing debug message

Zhang Xiaoxu (1):
      cifs: Fix UAF in cifs_demultiplex_thread()

 fs/smb/client/cached_dir.c   |  6 ++++++
 fs/smb/client/cifsglob.h     |  3 ++-
 fs/smb/client/cifsproto.h    |  2 +-
 fs/smb/client/connect.c      |  8 ++++++--
 fs/smb/client/misc.c         | 14 +++++++++-----
 fs/smb/client/smb2inode.c    |  3 +++
 fs/smb/client/smb2maperror.c |  2 --
 fs/smb/client/smb2pdu.c      |  4 ++--
 fs/smb/client/smbdirect.c    |  9 ++++++---
 fs/smb/client/trace.h        |  2 ++
 fs/smb/client/transport.c    | 34 +++++++++++++++++++++++-----------
 11 files changed, 60 insertions(+), 27 deletions(-)


-- 
Thanks,

Steve
