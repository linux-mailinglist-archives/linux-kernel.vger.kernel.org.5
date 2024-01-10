Return-Path: <linux-kernel+bounces-22848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB1D82A3EF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 23:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69C75B21949
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 22:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E414F897;
	Wed, 10 Jan 2024 22:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLE5pm4N"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90554F88D;
	Wed, 10 Jan 2024 22:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2cd1ca52f31so53795021fa.3;
        Wed, 10 Jan 2024 14:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704925605; x=1705530405; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V29kBokrHx3n8oCh6ytVABM8/fIDeu9CR++lJ6/5YjY=;
        b=YLE5pm4NEXhi8YDAr+a+ggpTpYQGFYehbDaSKgQfh1+KYrYPBoCO06l0crS70YB8sn
         eWw6T/h9Rr177TG9RnMT0jZDAeJWsHv8Qsa8uSl+/HkAbjYZlxg7uclXB8fqISweimNY
         73VfOYyix+RvYyao/iMYlU0840uteWIFtygkPTB8NlsTky0FNwYDk8ccrYYZL04Yn6EA
         lzeTUdYiuiFehAGf31jEOkaAdftcrszEAknZxbgsw92C4rpw45ZACjwXAqeSk8wZ+jdp
         7Et1syqG2A4sKJxK8enwZ1uBCnrWo56ZD0u2FIqnP+/fxvI2zVpp/W1lBGrLxrC89Q8u
         cLpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704925605; x=1705530405;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V29kBokrHx3n8oCh6ytVABM8/fIDeu9CR++lJ6/5YjY=;
        b=SQ9JDv6BsdpHU0LQ0fWr/kgfT1pFdQgi6JQyte6so05KT9EFEOBgth1JLiNz/Ft9Gi
         jPJs1/wnryS7HZ6O9X/W35YePDFs60ytzaJ5wVCDUbSaL5n5bjLh3FTUhRSEPyrUv0ha
         tkG/nMVtN5+7zjHKSZXefA1gyXVAuZoNzDJSd0+N86MyMsFzq6S+cTAmf6Irv/DwqBdG
         v5n2RXtOF8pkPsvJG51QJqJQYP0aMF3XqoUNg3gKy+888GNy+n+m0PDB9qD5xbRqkHPP
         ZN8UoGnAHH/fE5lXJ50TSFvWZrIqZZehlq7G8E5pW8SBxrFZwslp9fzGY6ZTc6hT5BAO
         rvbw==
X-Gm-Message-State: AOJu0YxRQyWLUyyUZQ+mTdQjoNwbYRSR4ncjbFQueqq9ysZVzBOvB9tL
	SIxjeaMUwbFyzRlIuqZcGVeutWfhBxHO8YhUr/YtgxfaF50Wiw==
X-Google-Smtp-Source: AGHT+IHU11L8GyLuc37Sc8+wJ2JZraOEVuqmNjj76cMLvlLSJJRLB2C41dOgVFdkgbEiX9KTCUnILe7jV06SEKapcKo=
X-Received: by 2002:a2e:a201:0:b0:2cd:122a:7edd with SMTP id
 h1-20020a2ea201000000b002cd122a7eddmr98410ljm.44.1704925604519; Wed, 10 Jan
 2024 14:26:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Wed, 10 Jan 2024 16:26:33 -0600
Message-ID: <CAH2r5muCHfBddtoXwKmFZFnQ8+H+PA_gAf8htYEGhN0az6vV8g@mail.gmail.com>
Subject: [GIT PULL] smb3 client fixes
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: CIFS <linux-cifs@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Please phe following changes since commit
0dd3ee31125508cd67f7e7172247f05b7fd1753a:

  Linux 6.7 (2024-01-07 12:18:38 -0800)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/v6.8-rc-part1-smb-client

for you to fetch changes up to 26ba1bf310f0ed43f249a93d0cf8a93675cd8ae8:

  cifs: update internal module version number for cifs.ko (2024-01-09
23:42:51 -0600)

----------------------------------------------------------------
Various smb client fixes, most related to better handling special file
types including:
- Six minor cleanups
- Multichannel logging improvement
- Exception handling fix
- Ten relating to improving handling of special file types including
   performance improvement (better compounding and better caching of
readdir entries that are reparse points)
   extend support for creating special files (sockets, fifos,
block/char devices)
   fix renaming and hardlinking of reparse points
   extend support for creating symlinks with IO_REPARSE_TAG_SYMLINK

Still testing additional patches to send next week
----------------------------------------------------------------
Dan Carpenter (2):
      cifs: delete unnecessary NULL checks in cifs_chan_update_iface()
      cifs: make cifs_chan_update_iface() a void function

David Howells (1):
      cifs: Pass unbyteswapped eof value into SMB2_set_eof()

Markus Elfring (1):
      smb3: Improve exception handling in allocate_mr_list()

Paulo Alcantara (10):
      smb: client: extend smb2_compound_op() to accept more commands
      smb: client: allow creating special files via reparse points
      smb: client: optimise reparse point querying
      smb: client: fix renaming of reparse points
      smb: client: fix hardlinking of reparse points
      smb: client: allow creating symlinks via reparse points
      smb: client: cleanup smb2_query_reparse_point()
      smb: client: handle special files and symlinks in SMB3 POSIX
      smb: client: stop revalidating reparse points unnecessarily
      cifs: get rid of dup length check in parse_reparse_point()

Pierre Mariani (1):
      smb: client: Fix minor whitespace errors and warnings

Shyam Prasad N (1):
      cifs: fix in logging in cifs_chan_update_iface

Steve French (2):
      cifs: remove unneeded return statement
      cifs: update internal module version number for cifs.ko

 fs/smb/client/cifsfs.h    |    4 +-
 fs/smb/client/cifsglob.h  |   47 ++-
 fs/smb/client/cifsproto.h |   32 +-
 fs/smb/client/cifssmb.c   |   31 +-
 fs/smb/client/connect.c   |   25 +-
 fs/smb/client/dir.c       |    7 +-
 fs/smb/client/file.c      |   10 +-
 fs/smb/client/inode.c     |  138 +++++---
 fs/smb/client/link.c      |   29 +-
 fs/smb/client/readdir.c   |  133 +++-----
 fs/smb/client/sess.c      |   53 ++-
 fs/smb/client/smb2glob.h  |   26 +-
 fs/smb/client/smb2inode.c | 1025
++++++++++++++++++++++++++++++++++----------------------
 fs/smb/client/smb2ops.c   |  352 ++++++++++---------
 fs/smb/client/smb2pdu.c   |    6 +-
 fs/smb/client/smb2proto.h |   31 +-
 fs/smb/client/smbdirect.c |    4 +-
 fs/smb/client/trace.h     |    7 +-
 18 files changed, 1131 insertions(+), 829 deletions(-)

-- 
Thanks,

Steve

