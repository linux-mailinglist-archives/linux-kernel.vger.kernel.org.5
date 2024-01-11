Return-Path: <linux-kernel+bounces-23707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABF782B084
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA30328965F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 14:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7C03C6A4;
	Thu, 11 Jan 2024 14:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPrOWCXO"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CD63C097;
	Thu, 11 Jan 2024 14:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2cd1aeb1bf3so50054481fa.1;
        Thu, 11 Jan 2024 06:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704982873; x=1705587673; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RwaiGVnOJ4Du9HqZqbeixpFvs9VfyRazD4DEKYzZ3xs=;
        b=GPrOWCXOOFiNNjB7fIXRrMFTsMzDyCk66/Jw3pxNetsV6FKjhrXVQQEp7JukWZh0Xc
         synTBokOPNYYd7hnsVkCdcl85+TjIhV9hfe60vDXjT7GrKS40+C4mEhHnuRIOChTZaFR
         bKC63FTPViXKw63fPi0C84AetInXSo/ysFh8g36Hyl7gZomg7u9eoz+VwDpbAc5n7AHt
         GZCoNlpswEFC9952mjCdDl6S+XgQAG/gDksrY6lORpTuIVM4W5mob4S1r6GNQhgvq1BD
         L7+pteHA7IkqkBfLNf3cXQ8UzT9j+M05G4VXneUd1mYfejXPtwXtr22ktOnfmicb2Lok
         YlTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704982873; x=1705587673;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RwaiGVnOJ4Du9HqZqbeixpFvs9VfyRazD4DEKYzZ3xs=;
        b=WiJdFxAZbQX8rBtKPVXdJFrEw+4ApHIruRGGgiHLLV4ZNrfO3xpGq109JepRejx5Ba
         3BEEcxlOy+0enKARF4sFvdCuL7Bjhz+OfOFp0ljy2dFJKCp9Zeyc2WT7HYZVmatMC1AJ
         cLBvZcHQCPMohvP2hXiPTwmQJc5F6UdYI7ORwG7lCcFcnU3xKiAUMojxC3j6ODlhs9NJ
         yRSw0tn6qEqNnUMeniJ7/c3ziA/sT/KZqRwPTBL0/sh8KXzjjp4fMtjBl5WbO9QG1K+a
         rGeuvEM0a+cmKVyT8O4+w5ZHYdFZuEZZipvh5tO9wzfFaUSLqVCA4Fx6QEfJRm69lOJ+
         KzQA==
X-Gm-Message-State: AOJu0Yy7aqRLnwEObDcVnDerbJcZi39q/l2vDT9Ag6zoxZWLq9gmYrUf
	5OtDXUTZbubrk0ZFGEN40likGXqtT78gaB29mBs=
X-Google-Smtp-Source: AGHT+IGASPuQqXfakyAKXe5VY1bHxQL6IYqanbxagT73RkRxA5RqV6D1bl0yQv8fT94XiGX8zMneuUjWQoT9/ZpENCM=
X-Received: by 2002:a2e:96c7:0:b0:2cd:1aa5:db82 with SMTP id
 d7-20020a2e96c7000000b002cd1aa5db82mr537079ljj.21.1704982872565; Thu, 11 Jan
 2024 06:21:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Thu, 11 Jan 2024 08:20:59 -0600
Message-ID: <CAH2r5mvajaHtTgnfMYd2BQ+w9XoBvN7tcjaG17W-Zb9r0KDG_w@mail.gmail.com>
Subject: [GIT PULL] ksmbd server fixes
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: CIFS <linux-cifs@vger.kernel.org>, Namjae Jeon <linkinjeon@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Please pull the following changes since commit
0dd3ee31125508cd67f7e7172247f05b7fd1753a:

  Linux 6.7 (2024-01-07 12:18:38 -0800)

are available in the Git repository at:

  git://git.samba.org/ksmbd.git tags/6.8-rc-smb-server-fixes

for you to fetch changes up to 8fb7b723924cc9306bc161f45496497aec733904:

  ksmbd: Add missing set_freezable() for freezable kthread (2024-01-09
20:01:16 -0600)

----------------------------------------------------------------
11 ksmbd server fixes
- memory allocation fix
- Three lease fixes, including important rename fix
- read only share fix
- thread freeze fix
- Three cleanup fixes (two kernel doc related)
- locking fix in setting EAs
- packet header validation fix

----------------------------------------------------------------
Christophe JAILLET (1):
      ksmbd: Remove usage of the deprecated ida_simple_xx() API

Fedor Pchelkin (1):
      ksmbd: free ppace array on error in parse_dacl

Kevin Hao (1):
      ksmbd: Add missing set_freezable() for freezable kthread

Li Nan (1):
      ksmbd: validate the zero field of packet header

Namjae Jeon (5):
      ksmbd: set v2 lease version on lease upgrade
      ksmbd: fix potential circular locking issue in smb2_set_ea()
      ksmbd: don't increment epoch if current state and request state are same
      ksmbd: don't allow O_TRUNC open on read-only share
      ksmbd: send lease break notification on FILE_RENAME_INFORMATION

Randy Dunlap (2):
      ksmbd: auth: fix most kernel-doc warnings
      ksmbd: vfs: fix all kernel-doc warnings

 fs/smb/server/auth.c           | 14 ++++++++------
 fs/smb/server/connection.c     |  1 +
 fs/smb/server/mgmt/ksmbd_ida.c | 21 ++++++---------------
 fs/smb/server/oplock.c         | 16 +++++++++++-----
 fs/smb/server/smb2pdu.c        | 31 ++++++++++++++-----------------
 fs/smb/server/smb_common.c     |  6 +++++-
 fs/smb/server/smbacl.c         | 11 +++++++----
 fs/smb/server/vfs.c            | 28 ++++++++++++++++++----------
 8 files changed, 70 insertions(+), 58 deletions(-)

-- 
Thanks,

Steve

