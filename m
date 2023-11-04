Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6797E0D86
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 04:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbjKDDgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 23:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjKDDgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 23:36:40 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24B5BF;
        Fri,  3 Nov 2023 20:36:37 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50949b7d7ffso3454247e87.0;
        Fri, 03 Nov 2023 20:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699068996; x=1699673796; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P3LMWlZteBZ8e9t+RweWv1ZPxiNQ6enL1kC4d/f3OJw=;
        b=g5zQpig2PbK1b3Yo9lNOqmgNbwhX8Zui2+2r3UZ33C+ClxdkgjFI1hhYQ/L+F5DKUP
         Y/9vYkFwfEvegHfUAHX1j/NLYCNR71sFgCWW+GRympvFdstNLUaFLRh98b5ZUaqV+G9w
         dM50iBtJMKXewLOs15YJxIJfyKSi+VePwaz1e21f4CFdRZFQQ9v9R+Gsyi5SncOGXWvZ
         w+ac1Qrzk2cl0YuAf33Ky5CosiDAkPE2ss6yTDSAIxhHZ7BCTwh00BTTOreXHSyzZydT
         wubZ8ftxIEvhX7OK5jL4B0D8eS6QGfK4duJBYdbNl0YS2EDsFAjeaxI+nqHiK5JWoNr/
         2PPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699068996; x=1699673796;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P3LMWlZteBZ8e9t+RweWv1ZPxiNQ6enL1kC4d/f3OJw=;
        b=kpYBCHE8J4Dpf7ohgyxLRlR+cOfreCQeQ5vH/N/YGtPjR7q9lHXBKr4pP+aotOxi06
         qkKjb7jEFwfhae6DJVzDyetvqBulLg5eabT6CZrRxD9Bp11YFV1kwQqY+MMXXcLcknQO
         IXNd9aQkGmGrRcB2nlIIlLgxCgts4p4DO1P0+I0qvZoZ+VEfKCj/Zfg1eQhC+dUaSprP
         A8fw9zSxyqRmCyob/Yv2n2igG8TZSv+kdTnrB/Ok4CyTsa1pD7XuO2MTNQMDNkw5DfDg
         rz7PqkIdau1mhf2S+Nymjg7glP5/xDJe7tV9r6fO76sGGoKBQoek/V3/2yYlPTdg0DfG
         mwxw==
X-Gm-Message-State: AOJu0YyM5Y5/Cso8grsDchitYkToYUFhbcTqsbzBJSbzru5AxEDqj7SF
        QGl96gFd1/5rjRDD1TXvjBNG9xywvO43eEMibrA82ISPlGmAow==
X-Google-Smtp-Source: AGHT+IFt9+t3rJcPRpHLSnX1yYaoNV0KrNBpNrYFUUwZFHMEDt6uj45d0vAuyZRMjfx5xHt8mUK4EcF3GLEA/QT2siU=
X-Received: by 2002:ac2:4c82:0:b0:507:9a33:f105 with SMTP id
 d2-20020ac24c82000000b005079a33f105mr15431898lfl.69.1699068995629; Fri, 03
 Nov 2023 20:36:35 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Fri, 3 Nov 2023 22:36:24 -0500
Message-ID: <CAH2r5mvutKF1meVmfiRu46tpYRckRuNf5j-gY02b0P=KTV2mpQ@mail.gmail.com>
Subject: [GIT PULL] smb client fixes part 1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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

Please pull the following changes since commit
05d3ef8bba77c1b5f98d941d8b2d4aeab8118ef1:

  Linux 6.6-rc7 (2023-10-22 12:11:21 -1000)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/6.7-rc-smb3-client-fixes-part1

for you to fetch changes up to d9a6d78096056a3cb5c5f07a730ab92f2f9ac4e6:

  cifs: force interface update before a fresh session setup
(2023-11-02 08:06:06 -0500)

----------------------------------------------------------------
15 cifs client fixes (eight also for stable)
- two use after free fixes and deadlock fix
- symlink timestamp fix
- hashing perf improvement
- four multichannel fixes
- two minor debugging improvements
- fix creating fifos when using "sfu" mounts
- NTLMSSP authentication improvement
- Minor fixes to include some missing create flags and structures from
recently updated protocol documentation

This does not include some additional multichannel and remount and
perf improvements still being tested
----------------------------------------------------------------
Eric Biggers (1):
      smb: use crypto_shash_digest() in symlink_hash()

Meetakshi Setiya (1):
      cifs: Add client version details to NTLM authenticate message

Paulo Alcantara (4):
      smb: client: fix potential deadlock when releasing mids
      smb: client: fix use-after-free bug in cifs_debug_data_proc_show()
      smb: client: remove extra @chan_count check in __cifs_put_smb_ses()
      smb: client: fix use-after-free in smb2_query_info_compound()

Shyam Prasad N (5):
      cifs: print server capabilities in DebugData
      cifs: add xid to query server interface call
      cifs: reconnect helper should set reconnect for the right channel
      cifs: do not reset chan_max if multichannel is not supported at mount
      cifs: force interface update before a fresh session setup

Steve French (4):
      smb3: fix touch -h of symlink
      SMB3: clarify some of the unused CreateOption flags
      Add definition for new smb3.1.1 command type
      smb3: fix creating FIFOs when mounting with "sfu" mount option

 fs/smb/client/cached_dir.c | 84 +++++++++++++++++++++++++++-------------------
 fs/smb/client/cifs_debug.c |  8 +++++
 fs/smb/client/cifsfs.c     |  1 +
 fs/smb/client/cifspdu.h    |  2 +-
 fs/smb/client/cifsproto.h  |  7 +++-
 fs/smb/client/connect.c    | 44 +++++++++++++-----------
 fs/smb/client/inode.c      |  4 +++
 fs/smb/client/link.c       | 16 ++-------
 fs/smb/client/ntlmssp.h    |  4 +--
 fs/smb/client/sess.c       | 13 ++++---
 fs/smb/client/smb2misc.c   |  2 +-
 fs/smb/client/smb2ops.c    |  8 ++++-
 fs/smb/client/transport.c  | 11 +-----
 fs/smb/common/smb2pdu.h    | 24 ++++++++++++-
 14 files changed, 138 insertions(+), 90 deletions(-)


-- 
Thanks,

Steve
