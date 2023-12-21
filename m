Return-Path: <linux-kernel+bounces-7828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD59F81ADE4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 05:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A9891F244A3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 04:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29A06FDC;
	Thu, 21 Dec 2023 04:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iN/u13mF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772588BFA;
	Thu, 21 Dec 2023 04:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ca04b1cc37so3457261fa.1;
        Wed, 20 Dec 2023 20:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703131748; x=1703736548; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C46kmWTthThAJwVWVLgOdKWhTKLPOhQZ8tCfQwfEl1A=;
        b=iN/u13mF6U0N80eP58huATRwo5bUhrqIclK7/epGyZYoHx/1D1WDmMtO78vbhIa7tC
         X2vPsgk7T6wukdNfwrkK0eDB8pMP8GJiXINMayU5g3FzXA5X1lLwETqsfPM9hBeMNEvz
         3g8h3UZCR5P5bDjisA5N8MYY/9jhiL+X65MGaV2nT1wy8ms3w5KI21BQ6IZe4IyDdL4M
         /vpZStLRoR+Wqz+i9X9haFBk7qn6kC0ohjUPhArfu7f49LXEgW08w2V64+0/TFIa9n9U
         ckIJlmmyWY+hpkYmXHk7yHvH2G4QpBevYv/OzyOcGAnukqaRGSP4pkkhBsMD3KY/zGBD
         urCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703131748; x=1703736548;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C46kmWTthThAJwVWVLgOdKWhTKLPOhQZ8tCfQwfEl1A=;
        b=wK+R87wDJywbU9MCv5KooE47AbWUdwPnjr4fjaNcfoef6UTfqZ0hyAS34wHfHGGauT
         6WLcC/4DkOTd7OS86OPYxZxfMoqFmbNeJlfeS7FlaWoQXM1356ngXkM5dGbuYlkzp7vJ
         uvJmLLRQNAlBnfof8Qi+LZU9/HgpzDGBRDS3Hr8RqG+w740et7C9vOBpWP4qM0cWHZY/
         aWEGrWeHNf21BZFzQESjz8LuEgm6V4vQaIhG+nGGPZCghs2ybngc7J0KcvRczqDgMaaQ
         WKhoYfS88XUHIA+tzPvrCxn7p9f26ZcCNeJMLnQ9VZDVnWj6JYzSEI02aeLomlrQEWnC
         Solw==
X-Gm-Message-State: AOJu0YwIqvIjEbvWHIFxb1agd6Js/50/IJibJfCONNLVundjIuHp7Nlk
	SZixNoD9d02zedAW8jrYz7j6j2OswGYn6BNxBqfMXdAQ
X-Google-Smtp-Source: AGHT+IEPG6AL6kRIpXgvlRT1r2MGEr/O4X+6PKN5NfEDL2xQdSa7jJhQKCS963pqiq54Lk6FPKXgZaOeEX5w3h0gzHA=
X-Received: by 2002:a2e:9f0a:0:b0:2cb:27ff:d663 with SMTP id
 u10-20020a2e9f0a000000b002cb27ffd663mr38122ljk.11.1703131748074; Wed, 20 Dec
 2023 20:09:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Wed, 20 Dec 2023 22:08:56 -0600
Message-ID: <CAH2r5mvnbV3AxWeibhBaL7UtfZ7ko18-1SZg2LN0U0YNgvJ6Cg@mail.gmail.com>
Subject: [GIT PULL] smb3 client fixes
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: CIFS <linux-cifs@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Please pull the following changes since commit
ceb6a6f023fd3e8b07761ed900352ef574010bcb:

  Linux 6.7-rc6 (2023-12-17 15:19:28 -0800)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/6.7-rc6-smb3-client-fixes

for you to fetch changes up to 12d1e301bdfd1f2e2f371432dedef7cce8f01c4a:

  cifs: do not let cifs_chan_update_iface deallocate channels
(2023-12-19 11:04:04 -0600)

----------------------------------------------------------------
Eight import client fixes, most also for stable
- two multichannel reconnect fixes, one fixing an important
refcounting problem that can lead to umount problems
- atime fix
- five fixes for various potential OOB accesses, including a CVE fix,
and two additional
  fixes for problems pointed out by Robert Morris's fuzzing investigating)

----------------------------------------------------------------
Paulo Alcantara (5):
      smb: client: fix OOB in cifsd when receiving compounded resps
      smb: client: fix OOB in SMB2_query_info_init()
      smb: client: fix OOB in smbCalcSize()
      smb: client: fix potential OOB in cifs_dump_detail()
      smb: client: fix potential OOB in smb2_dump_detail()

Shyam Prasad N (2):
      cifs: fix a pending undercount of srv_count
      cifs: do not let cifs_chan_update_iface deallocate channels

Zizhi Wo (1):
      fs: cifs: Fix atime update check

 fs/smb/client/cifs_debug.c | 12 +++++++-----
 fs/smb/client/cifsglob.h   |  3 ++-
 fs/smb/client/connect.c    |  7 ++++++-
 fs/smb/client/file.c       |  2 +-
 fs/smb/client/misc.c       |  4 ++++
 fs/smb/client/sess.c       | 50
++++++++++++++++++------------------------------
 fs/smb/client/smb2misc.c   | 30 ++++++++++++++---------------
 fs/smb/client/smb2ops.c    | 25 +++++++++++++++---------
 fs/smb/client/smb2pdu.c    | 32 ++++++++++++++++++++++---------
 9 files changed, 93 insertions(+), 72 deletions(-)

--
Thanks,

Steve

