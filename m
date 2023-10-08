Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD187BCC02
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 06:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344342AbjJHE1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 00:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344326AbjJHE1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 00:27:34 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106CBB9;
        Sat,  7 Oct 2023 21:27:31 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-5068dab8c00so1614704e87.0;
        Sat, 07 Oct 2023 21:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696739249; x=1697344049; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ltx5ybDBqORsfBzKBZDc0jiKiRVubCB+DjHy81LX9gA=;
        b=WS0EofqPsju4npx6cGoEHHntyPRdvkbE4Ehc4QT1zcy+tlN6RaDF2cShP7DZis540i
         07xbpWN1suVS4o8xwnCQE/zJuC9fr+P0F4aD7rR8WfY9oAibDNj1neB335XCyu5KF/KL
         xQrVnl0N3KWtpP1UXNQB3+1M34Uro4BWNYroPzVUYEx+YkJETHaB0e9nfj9TJPIfVeC3
         BznLR4XNUfiyaZXo18iCYtxpP6BXd84qeO3kMkYB+wcByYd2QU9JpRhM1XPIv5jq0w83
         HqP7LCnM5CXg+ij1Z6Oy1lgvp0/5zoHl2bRoujVy+HsLNZ9CFxYathC9lRxQpJ8i2Pih
         or4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696739249; x=1697344049;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ltx5ybDBqORsfBzKBZDc0jiKiRVubCB+DjHy81LX9gA=;
        b=JThMrQMuet2MN2ArIhXZgNWv3BSqMNKMzH7/b11+fBpZJdq46yjD3qqyN9I9VdeHI4
         uUE3knHNPEPTGsUbrceuLx2p81k+byqLfG+NvCZCQFnnqh1Pys8jf54tC/OaKtw3VUAc
         a06AQxkNPqNiT01FOXpj7smGXKkjmo2cZLFKkr8Ywokl03RDOaICVKAzNMtiyvHEIRlP
         NCu+UdIMFS+++dDnn9xK+WMyHabF+WQf+9iFJG0O6MIGQoejBI7/UFDS//gYmgqFJECF
         acbj5ktkYuyZENHkd62BwOswCcKFWdj0i6L/FwiD3dZhcAhmy/D49FpxgmzFfqky6jf/
         zoiQ==
X-Gm-Message-State: AOJu0Ywx+dpTisUylD7y0eJV5TceT6doZdBuxCedPxGsMYjdbpjKYTUZ
        T2GB5//gjeXFfKhf64bPTz+M+1jPEAM06jzavbEpO5Hkz/E=
X-Google-Smtp-Source: AGHT+IGtgm9s30ZBGEh6BH/eOLrTHjgiCvELlv9Mz9zVPgGMe4z17+O1e8Qtlq9eA/+9En3mdzrxHO2yY/GaN8GBV2M=
X-Received: by 2002:a19:f015:0:b0:500:d970:6541 with SMTP id
 p21-20020a19f015000000b00500d9706541mr9799292lfc.39.1696739248750; Sat, 07
 Oct 2023 21:27:28 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 7 Oct 2023 23:27:16 -0500
Message-ID: <CAH2r5mvzuQBU4UKEHMKjSDQHiHsGAx_VPRuwkr2BVcmT81wuCw@mail.gmail.com>
Subject: [GIT PULL] ksmbd server fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
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
8a749fd1a8720d4619c91c8b6e7528c0a355c0aa:

  Linux 6.6-rc4 (2023-10-01 14:15:13 -0700)

are available in the Git repository at:

  git://git.samba.org/ksmbd.git tags/6.6-rc4-ksmbd-server-fixes

for you to fetch changes up to 33b235a6e6ebe0f05f3586a71e8d281d00f71e2e:

  ksmbd: fix race condition between tree conn lookup and disconnect
(2023-10-04 21:56:28 -0500)

----------------------------------------------------------------
Six SMB3 server fixes for various races found by RO0T Lab of Huawei:
- Fix oops when race between oplock break ack and freeing file
- Simultaneous request fixes:for parallel logoffs, and for parallel
lock requests
- Fixes for tree disconnect race, session expire race, and close/open race

----------------------------------------------------------------
Namjae Jeon (5):
      ksmbd: fix race condition between session lookup and expire
      ksmbd: fix race condition with fp
      ksmbd: fix race condition from parallel smb2 logoff requests
      ksmbd: fix race condition from parallel smb2 lock requests
      ksmbd: fix race condition between tree conn lookup and disconnect

luosili (1):
      ksmbd: fix uaf in smb20_oplock_break_ack

 fs/smb/server/connection.c        |  2 +
 fs/smb/server/connection.h        |  1 +
 fs/smb/server/mgmt/tree_connect.c | 42 +++++++++++++++--
 fs/smb/server/mgmt/tree_connect.h | 11 ++++-
 fs/smb/server/mgmt/user_session.c | 11 +++--
 fs/smb/server/mgmt/user_session.h |  1 +
 fs/smb/server/server.c            |  2 +
 fs/smb/server/smb2pdu.c           | 94 +++++++++++++++++++++++++--------------
 fs/smb/server/vfs_cache.c         | 23 ++++++++--
 fs/smb/server/vfs_cache.h         |  9 ++++
 10 files changed, 151 insertions(+), 45 deletions(-)

-- 
Thanks,

Steve
