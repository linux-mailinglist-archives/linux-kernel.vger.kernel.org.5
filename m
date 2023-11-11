Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE11C7E8D1C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 23:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjKKWVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 17:21:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjKKWVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 17:21:45 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B251B30D5;
        Sat, 11 Nov 2023 14:21:41 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50a6ff9881fso2877118e87.1;
        Sat, 11 Nov 2023 14:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699741300; x=1700346100; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vTv8KziSQNanprIcdAtBsLfUhuVbJahhzU1G4OvvbRI=;
        b=BaicL5s9MJQAx4zl5Yq39ttxc05RAhXuKsvckph0ShZM4Uav3TDOlIo2ThAb9F/cj5
         vg4rYF3f5TAdASY/+WGNenCdOngUv4YqXMnH17AlRXLxHiRHDi3aJvzKIOPu88TKCjEe
         WJ8a5i0yRSOMoGLkBck2SxekTy5Du7TLxzTsYy8XhlzUBnh9aUnUH+HuhQJhVMXyOinz
         YcTxXCgvzcfTXaXADsVtdUv/OOGd5Fsa7CLEbtJ0xAWIaXx2e7OSZuHnxlKbTgR5NpNE
         8VKc54wErR3FaqyAok81/fwv0hq/PKv5tueZJFToTNpuqkP0dNjb7MLl3c+uWrKu89nn
         gPow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699741300; x=1700346100;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vTv8KziSQNanprIcdAtBsLfUhuVbJahhzU1G4OvvbRI=;
        b=aPB2CgQ+3u23Q+nf0YgzPeYf/k7hKjrcWFvt93EIq6t1ytAFON4aVJ4c2nU9L6fc2s
         MXc3tM47LGCPjiyfTspPEthmcisrbf9PKfhukm05MzfhgufKhZj4gXCq/d7n+EuGDC/j
         UECINDX+Nt6aMzT/33yVHNvjOrZlCOVMBOZ0/Psc35PZrDwPCUdMdlG8SM/hr5uB1i6H
         sdaHFY6Qdodjez0QxX0nfukK7dEauko4BZ5AMwNfUYIh3EBjDiZZzeRN4k8K6cdxzQBi
         OtnMkY/pnf/UAN3xEN5MzStIonUbHqKr5b4iX11Eh4PFKoMkuMz3iRoAvq2G/HqvNC2y
         r3uw==
X-Gm-Message-State: AOJu0Yy1m6BlXbxJArsBMnuU4hJTBg6aRRobUkyFt9TGGCzctnsLGnWa
        iY3vvtA5f3V24H8xxf3oMFNIVqxzj3ecchTxGGPovuehWrYHEoHA
X-Google-Smtp-Source: AGHT+IFt5i4orSfmVg/MsRnAdwT9Os00tSkiaSen/rA6V+YBlMb/0tvlGU5oxxbwchVW6f+WZJ8Ls223H3ZcPCSqF+c=
X-Received: by 2002:a05:6512:3f0:b0:50a:6fc5:e95c with SMTP id
 n16-20020a05651203f000b0050a6fc5e95cmr1565177lfq.60.1699741299543; Sat, 11
 Nov 2023 14:21:39 -0800 (PST)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 11 Nov 2023 16:21:28 -0600
Message-ID: <CAH2r5muWrqOdEDUhmYHgX2Pr0yWSMrFLPms+4pqwrZaMr4i7Og@mail.gmail.com>
Subject: [GIT PULL] smb3 client fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 766e9cf3bd64c45fcace3acc6f8b3df815448ea3:

  Merge tag '6.7-rc-smb3-client-fixes-part1' of
git://git.samba.org/sfrench/cifs-2.6 (2023-11-04 09:13:50 -1000)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/6.7-rc-smb3-client-fixes-part2

for you to fetch changes up to fd2bd7c0539e28f267a84da8d68f9378511b50a7:

  cifs: update internal module version number for cifs.ko (2023-11-10
09:33:26 -0600)

----------------------------------------------------------------
Sixteen smb3/cifs client fixes
- ctime caching fix (for setxattr)
- encryption fix
- DNS resolver mount fix
- two debugging improvements
- six multichannel fixes including cases where server stops or starts
supporting multichannel after mount
- reconnect fix
- three minor cleanups

This P/R does not include the patches for perf improvement for caching
of root directory, and the one to support key rotation, and the
O_TMPFILE fix (those are still being tested).  An additional
multichannel locking fix is also being investigated.
----------------------------------------------------------------
David Howells (1):
      cifs: Fix encryption of cleared, but unset rq_iter data buffers

Paulo Alcantara (1):
      smb: client: fix mount when dns_resolver key is not available

Shyam Prasad N (7):
      cifs: handle cases where a channel is closed
      cifs: distribute channels across interfaces based on speed
      cifs: account for primary channel in the interface list
      cifs: do not pass cifs_sb when trying to add channels
      cifs: reconnect work should have reference on server struct
      cifs: handle when server starts supporting multichannel
      cifs: handle when server stops supporting multichannel

Steve French (7):
      smb3: minor RDMA cleanup
      smb3: more minor cleanups for session handling routines
      smb3: minor cleanup of session handling code
      smb3: fix caching of ctime on setxattr
      smb3: allow dumping session and tcon id to improve stats
analysis and debugging
      Missing field not being returned in ioctl CIFS_IOC_GET_MNT_INFO
      cifs: update internal module version number for cifs.ko

 fs/smb/client/cifs_debug.c    |  25 ++++++++-
 fs/smb/client/cifs_ioctl.h    |   6 +++
 fs/smb/client/cifsfs.h        |   4 +-
 fs/smb/client/cifsglob.h      |  16 ++++--
 fs/smb/client/cifsproto.h     |   7 ++-
 fs/smb/client/connect.c       |  48 ++++++++++++++---
 fs/smb/client/dfs.c           |  18 +++++--
 fs/smb/client/fs_context.h    |   1 +
 fs/smb/client/ioctl.c         |  26 ++++++++++
 fs/smb/client/namespace.c     |  17 +++++-
 fs/smb/client/sess.c          | 259
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------
 fs/smb/client/smb2ops.c       |   6 +++
 fs/smb/client/smb2pdu.c       | 131
++++++++++++++++++++++++++++++++++++++++++-----
 fs/smb/client/smb2transport.c |   8 ++-
 fs/smb/client/transport.c     |   2 +-
 fs/smb/client/xattr.c         |   5 +-
 16 files changed, 491 insertions(+), 88 deletions(-)


--
Thanks,

Steve
