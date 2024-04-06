Return-Path: <linux-kernel+bounces-133804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D099389A8F4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 07:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8418D1F223F2
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 05:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85F41CAAC;
	Sat,  6 Apr 2024 05:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtjcTcBB"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765BE1FA1;
	Sat,  6 Apr 2024 05:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712380115; cv=none; b=clV63EwwiGILer28FYbE7tiWiQEhlRd+uqPBnBt1OdeeNazKOSOP4zCSfhaLxbThWcr0uAecwDFlLtYMLWqBHEQCfT1MgEmRD3M6iegrC15XlXFGoIUE00+vAezq9I8xp09h7u/2J35RlnyzFDxZOZGP1TWPjBkYRc/G6hOFUsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712380115; c=relaxed/simple;
	bh=ucGI9nf2AqWhkLS3ij0YOnhppH1t7T/usV1ct0ZegkE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=N7nIcXZRCHHxFI7VPIl54AJuowbz0SUi+bWmhsoz7De/FwtQRH3Uubk0oOQgqlcJIfaYyoR6QdokU4WTd+Mcikf3xYBlAscItpdbGm/HTmHOGVoX17lFm4d16B71YLeDSztvZ5Hz9B5mVhOPQ5iKERKqJgGNw7bEINtBAGPVjcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WtjcTcBB; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-516d0c004b1so2918846e87.2;
        Fri, 05 Apr 2024 22:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712380111; x=1712984911; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d26fRpd8+KcGmKIhiw3Xe2m8bbWMWSCQ9BpgQfJxuSg=;
        b=WtjcTcBBtYB0kXPxaC1XdhNeTsqPm9C9n8I4Prd6a+osOcXLBRnf6F8MiFLRRoQM15
         /U7Ni6WeM2fEc0GGBLpFnlOKWbqXvA8aFdMvuW9XR6n+AuFQbl5Y64d1QJ3wzZMlXhg4
         +pn4IZtXrOIU6eVJD1EACsmRoldfl8Jw5ALa4T7F8SxnX6jP2P2j6tBrAvZ8uWgqbZUW
         TXS1TMSC8D/pcA3ia038+gAoRSvg7d5YKLa8jzlRgF0m8nywuQLNR0IJ3VBqoRPK+5Cy
         CHPeo4Q9pkFu2VYl0UDLZxAl+OWrYhtaBEG7SYxsHAqP4ZiapNxAP5EjT4sxmFD7lw1S
         Bq9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712380111; x=1712984911;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d26fRpd8+KcGmKIhiw3Xe2m8bbWMWSCQ9BpgQfJxuSg=;
        b=F73JEKRSbJsHqC7bCtnn7hhiVEdeF5ul+EGSSv9MXuXMp29B9M6Nk1bXzFCgQ40jcX
         BC/Pt8P+zBreKyVhgIrtLp8nIVRp3oK+ZyIf83gxM/KJKZcSGJBYcSJj5F0xpzg7l0rI
         XAiy6nJDKlzC9BMgOO4fFPWdN4RdKKvTYhO+721AjLq4s4sZGPYi3+w3xErZddEWnqez
         fxUmUTlS6IL7azJcYNKZ06fWp3ZdCTkltpqXZqmhf5gu/ETmW+Ek7Tzr+MIYywAbrjdf
         KQjjS/jtA7qw0cDCoZOPZI9DjIZBQFxYm/kyuW6ZGnZKcTd7VKV1n8ZQSoT6ZW6AdRS4
         j3+Q==
X-Forwarded-Encrypted: i=1; AJvYcCW2kKVsLoiTdDmq98fGlFYT1ot2PWQcJI2ihzn9qWnNftTQSoet1zQXlEI8UxJTUz3DKcjWBfxZf5GW86GaarFzG3R+jdwo6ddLlxR3
X-Gm-Message-State: AOJu0Yx784UqCwQioCAuaWbFftpAcFFL/QHzjGjy4NVyFcyj+lR7NhTD
	2V1rqt+kqXy/YQzjKCFCkwVgIS9zWsNgg432bRp1I0guiP1VmScQj2Z9cLw2tWb53cFFABU79Nq
	DFc8GsljpSayhMElUiFIjgJXKgALQOmMvmaI=
X-Google-Smtp-Source: AGHT+IFzx1NsO1QkSJZ5DgySohoYd7iBR253TDhiO77dyZKULKuwpx5DUKzF2UVo6vUpZclXmER21KpgsbtpVnaMH+c=
X-Received: by 2002:a19:f711:0:b0:516:d1af:adc1 with SMTP id
 z17-20020a19f711000000b00516d1afadc1mr2408303lfe.9.1712380111170; Fri, 05 Apr
 2024 22:08:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Sat, 6 Apr 2024 00:08:19 -0500
Message-ID: <CAH2r5ms=TTjN5yoGsnEhrvqioM3pG6ANcTwsC8L1q833EPmMtQ@mail.gmail.com>
Subject: [GIT PULL] smb3 client fixes
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: CIFS <linux-cifs@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Please pull the following changes since commit
39cd87c4eb2b893354f3b850f916353f2658ae6f:

  Linux 6.9-rc2 (2024-03-31 14:32:39 -0700)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/6.9-rc2-smb3-client-fixes

for you to fetch changes up to e0e50401cc3921c9eaf1b0e667db174519ea939f:

  smb: client: fix potential UAF in cifs_signal_cifsd_for_reconnect()
(2024-04-03 14:45:15 -0500)

----------------------------------------------------------------
17 cifs.ko changesets, most also for stable
- fix to retry close to avoid potential handle leaks when server returns EBUSY
- Three DFS fixes including a fix for potential use after free
- fscache fix
- minor strncpy cleanup
- reconnect race fix
- series of patches to deal with various possible race conditions
(UAFs) tearing sessions down

The important fix to support password rotation is not included in this P/R (am
giving that patch more time for any additional review feedback) but should be
ready to send next week.

----------------------------------------------------------------
David Howells (1):
      cifs: Fix caching to try to do open O_WRONLY as rdwr on server

Justin Stitt (1):
      smb: client: replace deprecated strncpy with strscpy

Paulo Alcantara (14):
      smb: client: fix UAF in smb2_reconnect_server()
      smb: client: guarantee refcounted children from parent session
      smb: client: refresh referral without acquiring refpath_lock
      smb: client: handle DFS tcons in cifs_construct_tcon()
      smb: client: serialise cifs_construct_tcon() with cifs_mount_mutex
      smb: client: fix potential UAF in cifs_debug_files_proc_show()
      smb: client: fix potential UAF in cifs_dump_full_key()
      smb: client: fix potential UAF in cifs_stats_proc_write()
      smb: client: fix potential UAF in cifs_stats_proc_show()
      smb: client: fix potential UAF in smb2_is_valid_lease_break()
      smb: client: fix potential UAF in smb2_is_valid_oplock_break()
      smb: client: fix potential UAF in is_valid_oplock_break()
      smb: client: fix potential UAF in smb2_is_network_name_deleted()
      smb: client: fix potential UAF in cifs_signal_cifsd_for_reconnect()

Ritvik Budhiraja (1):
      smb3: retrying on failed server close

 fs/smb/client/cached_dir.c    |   6 +-
 fs/smb/client/cifs_debug.c    |   6 ++
 fs/smb/client/cifsfs.c        |  11 +++
 fs/smb/client/cifsglob.h      |  19 ++++--
 fs/smb/client/cifsproto.h     |  20 +++---
 fs/smb/client/cifssmb.c       |   6 +-
 fs/smb/client/connect.c       | 153 +++++++++++++++++++++++++++---------------
 fs/smb/client/dfs.c           |  51 +++++++-------
 fs/smb/client/dfs.h           |  33 +++++----
 fs/smb/client/dfs_cache.c     |  53 +++++++--------
 fs/smb/client/dir.c           |  15 +++++
 fs/smb/client/file.c          | 111 +++++++++++++++++++++++++-----
 fs/smb/client/fs_context.c    |   6 +-
 fs/smb/client/fs_context.h    |  12 ++++
 fs/smb/client/fscache.h       |   6 ++
 fs/smb/client/ioctl.c         |   6 +-
 fs/smb/client/misc.c          |   8 +--
 fs/smb/client/smb1ops.c       |   4 +-
 fs/smb/client/smb2misc.c      |   4 ++
 fs/smb/client/smb2ops.c       |  13 ++--
 fs/smb/client/smb2pdu.c       |   2 +-
 fs/smb/client/smb2transport.c |   2 +-
 22 files changed, 369 insertions(+), 178 deletions(-)


-- 
Thanks,

Steve

