Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44EE37FAC26
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 22:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbjK0VBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 16:01:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbjK0VBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 16:01:08 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B0F10D8;
        Mon, 27 Nov 2023 13:01:12 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-507bd19eac8so6477536e87.0;
        Mon, 27 Nov 2023 13:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701118871; x=1701723671; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Nwhpajf0OTYZOCtT7VS2Ib1jn+AshrWzHdr8DFfcT/U=;
        b=g1sUUPUGENtJjH7aHW92TtblshEZMoRHrhsfgI1UI5vVPwpOOjkyMgF6p1Mrs4oH9z
         6PggfcimSEEPjE5ZgFUVnxtATocrZt+ge2iUF8CU/UxHT3GItrLg1Sznr4lnbzePodQV
         Xu+nA5wpolaM+d5enxdEXKNNy8PDZdl1Eh02vjeG6H3rMtTZog7rC6u6fML5nR4XOI0a
         AGL2/SDxmgtKOGIQM7Mon96ALV8DM4I23gGTDDL8qpd/QLPkzYOgCyR+ekSby50zXkxJ
         Xecz2MiV4xARIUrLWxdyIuaXMieNhsMUG2PUmhcXg9wobqK6n6Q9EI5yL7yWsT/c+00V
         kVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701118871; x=1701723671;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nwhpajf0OTYZOCtT7VS2Ib1jn+AshrWzHdr8DFfcT/U=;
        b=FTE+iNh89rSv5Vi5vxNqjvqQzIMvi1ack3rXnr/kfbzmk+QSdAvcU/Cdmqe3ZwCgRC
         T0lVZ1uQO0EoNtVZsRyKy+58ACBxIGIPtk79B8q+4W50gEr0PBbHNaYGC0sD8My61Fw9
         gzuE9LLS2C450+MbupMPhUXusIVtXCCyzDnFEoaYKkzDI7mMspUM5RkzS2DuUtFau73F
         8qI+y14poNTsRivEdWkp4rzzlZlT8KREEY7fxHjkRDal1Vt/+bhw/bpnd9dmTwD52DMF
         Bu8iJ4sgIU+6w/P4OTkplS2G3Q39GVhPSU0ZVKxk0IkgzgLe5scinwdgJpoDzZjU9cau
         wI9w==
X-Gm-Message-State: AOJu0Yzen91r4oeouOVAT03YMs+PFC0V2Ih6becf4dvwjLLrsbDfLWTp
        LHDS2qyvsKVdekxMM+wRnPy+Q19hH9W7DEfV3Mc=
X-Google-Smtp-Source: AGHT+IEkOykOObNFVjgWoWcwhsdG79ucIYhfmguQcxr8wiaiKRp1zLnjdFpkKpT8jp1xaxpchZuzZty1DeKuZr35EUo=
X-Received: by 2002:a05:6512:21c2:b0:50a:5df2:f30f with SMTP id
 d2-20020a05651221c200b0050a5df2f30fmr7067202lft.43.1701118870755; Mon, 27 Nov
 2023 13:01:10 -0800 (PST)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Mon, 27 Nov 2023 15:00:59 -0600
Message-ID: <CAH2r5mvMv=F2JpZNW=t03TY+1H7W+6eJtNDE+f838wsS+r8BfA@mail.gmail.com>
Subject: [GIT PULL] ksmbd server fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[resending due to email bounce]

Please pull the following changes since commit
98b1cc82c4affc16f5598d4fa14b1858671b2263:

  Linux 6.7-rc2 (2023-11-19 15:02:14 -0800)

are available in the Git repository at:

  git://git.samba.org/ksmbd.git tags/6.7-rc3-smb3-server-fixes

for you to fetch changes up to cd80ce7e68f1624ac29cd0a6b057789d1236641e:

  ksmbd: don't update ->op_state as OPLOCK_STATE_NONE on error
(2023-11-23 20:50:45 -0600)

----------------------------------------------------------------
Seven ksmbd server fixes:
- Memory leak fix
- Fix possible deadlock in open
- Multiple SMB3 leasing (caching) fixes including:
     incorrect open count (found via xfstest generic/002 with leases)
     lease breaking incorrect serialization
     lease break error handling fix
     fix sending async response when lease pending
- Async command fix

----------------------------------------------------------------
Namjae Jeon (6):
      ksmbd: fix possible deadlock in smb2_open
      ksmbd: separately allocate ci per dentry
      ksmbd: move oplock handling after unlock parent dir
      ksmbd: release interim response after sending status pending response
      ksmbd: move setting SMB2_FLAGS_ASYNC_COMMAND and AsyncId
      ksmbd: don't update ->op_state as OPLOCK_STATE_NONE on error

Zongmin Zhou (1):
      ksmbd: prevent memory leak on error return

 fs/smb/server/ksmbd_work.c |  10 ++-
 fs/smb/server/oplock.c     |   3 +-
 fs/smb/server/smb2pdu.c    | 162 +++++++++++++++++++++++----------------------
 fs/smb/server/smbacl.c     |   7 +-
 fs/smb/server/smbacl.h     |   2 +-
 fs/smb/server/vfs.c        |  70 ++++++++++++--------
 fs/smb/server/vfs.h        |  10 ++-
 fs/smb/server/vfs_cache.c  |  33 ++++-----
 fs/smb/server/vfs_cache.h  |   6 +-
 9 files changed, 162 insertions(+), 141 deletions(-)

-- 
Thanks,

Steve
