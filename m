Return-Path: <linux-kernel+bounces-31939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BCB833713
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 00:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7EEB1F21AD5
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 23:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC4D14AB9;
	Sat, 20 Jan 2024 23:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qw3L5mLr"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA1914A98;
	Sat, 20 Jan 2024 23:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705793422; cv=none; b=L6p8aLJ6eAQha2aKKMVzFjhTIU2tt0gt2ZSmxB7RWmk3nxcXHJbr8ZuvImE56tPSIQZuFQ6eWEtgiKccAqcAX8dkWyrZTcTjI8PtSIlpZNFvhMooeT9phXpeGEOR8Zv3qSPnUgUE/BbENRiyZgnuWSGmou0IcpQk5D9Nm7mAdGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705793422; c=relaxed/simple;
	bh=DcUKLRgwiZFkhp9wcEX5tI2dHgq/f7IwRqfnpbZJHL8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=fWzqczJTW4mjYMsRo5CJ3YN9AAdjqYeMA677zmGVkjH6m3yA4Igqk8shOFN8gitVjUGCSxPQg9mIH13TVxgsPdBPoAaKEozh2CH7V5BHixlNRUe2h/B5wuwWx6babYKIyxo6EzFOUMlmRnBRHDzZ8Y0lQ6aO3VCpTWrYpTEAiT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qw3L5mLr; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2cceb5f0918so20345821fa.2;
        Sat, 20 Jan 2024 15:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705793418; x=1706398218; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y75KzhxgwrfADHFUMefA15RKQwEcCqjvVgfnaM5gFUY=;
        b=Qw3L5mLrAiXqbMp7p7/UC73aHnXAwEAPQOvhkJ9WYuCzqPLAYPpFZZLbWS9pRVm4Ik
         AA+IrA9uAHh1Ho6VGePvro3TdXLYoZw1S8RmwAlvZ7sqcuMjLv4CqglP2YsttWW2Ku1u
         OfxDkQfEoxGQsD6/Z2fZq+GrZkq+q9R3qbt6f7F45G18MiOumGe+gSRT6ZzA+OTOz7Y+
         uc2tyIfjMQmcwoiNM3VuBV73wqscXJdLizMtpflELMyu6TptvT5VIHSDaIChiMvYtih8
         9vb2MYeS8pobg02tSE/pM5/ABpOpubMJRV6kyrD619Yz+fZyEDuO0T66/AAu3hhFPv05
         gbnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705793418; x=1706398218;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y75KzhxgwrfADHFUMefA15RKQwEcCqjvVgfnaM5gFUY=;
        b=MmkmpTtNnsuU4IrYOP3QBcUvGIUw2VGNM7s4UvNGu7NJN2P1ZhLaccdZy05p9tgnbP
         IbnEqOQQgMH7JSZCqqaa09VYp6XCnRCpbc7oCkScTM+p2t88CV6iBKJeL6K0mRKBs/h5
         PX0pIm/6bIAC1ymb6gbc/ptoEVN3erxv9qT2GAe1ZEcYyoOiMA/JNvEt6KHmn8Zh6wK9
         Pm2t/ey/YhtFsfQuLTqi29S/rM3XRyzYK5I3gU6MT3AlGuZ2VKZvrfb+Cb7dCjI/KMSU
         WLesLwqCrlolwnEZZkm7G1khQuSSaHZbkVAevlgQz/0c0OqvRcrEhwOANMVhyOnspo8E
         M9jg==
X-Gm-Message-State: AOJu0YwWWIWm4NRykrqt3siUWvSvYpeGbjcQbBQTtK/Nc4Jbz4sHH594
	EF8Q7mxcXhBlkTC8VfQZZ1mwsi+Wn3dvrRPBHQzY96tUs45rS9VnXCjujXBt1s7s5JkpMwJjOJO
	FkxIeAOGYnABk9DGJa63fiBnNoOx58OIejqFpdQ==
X-Google-Smtp-Source: AGHT+IGTJGPM/uDEtCj925EfBiukOC+KlL13tXB6Mp9uyXrBf82ooqxxvezflaxWITHwZvnqvTZezDX7tSMt98MG0XA=
X-Received: by 2002:a05:6512:3f15:b0:50e:7dcc:ef51 with SMTP id
 y21-20020a0565123f1500b0050e7dccef51mr601510lfa.120.1705793418192; Sat, 20
 Jan 2024 15:30:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Sat, 20 Jan 2024 17:30:06 -0600
Message-ID: <CAH2r5mvR+MhHoeJiULtRQ2=D8doE31i9nmH0Jr5rLTf1K3KFiA@mail.gmail.com>
Subject: [GIT PULL] smb3 client fixes
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Please pull the following changes since commit
84e9a2d5517bf62edda74f382757aa173b8e45fd:

  Merge tag 'v6.8-rc-part1-smb-client' of
git://git.samba.org/sfrench/cifs-2.6 (2024-01-10 16:23:30 -0800)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/v6.8-rc-part2-smb-client

for you to fetch changes up to 78e727e58e54efca4c23863fbd9e16e9d2d83f81:

  cifs: update iface_last_update on each query-and-update (2024-01-19
10:33:21 -0600)

----------------------------------------------------------------
Various smb client fixes, including multichannel and for SMB3.1.1
POSIX extensions
- debugging improvement (display start time for stats)
- two reparse point handling fixes
- various multichannel improvements and fixes
- SMB3.1.1 POSIX extensions open/create parsing fix
- retry (reconnect) improvement including new retrans mount parm, and
handling of
  two additional return codes that need to be retried on
- two minor cleanup patches and another to remove duplicate query info code
- two documentation cleanup, and one reviewer email correction

This P/R does not include the netfs integration patch series for cifs.ko from
David Howells (but will start testing that now that the prereq VFS changes
are in mainline).  It also does not include some additional important
patches for
improving reconnect/retry handling that are still being tested, and there are
two additional important lease key reuse related patches being tested as well,
and a patch to handle password expiration and key rotation that are not
included in this P/R.
----------------------------------------------------------------
Colin Ian King (1):
      cifs: remove redundant variable tcon_exist

Paulo Alcantara (4):
      smb: client: fix parsing of SMB3.1.1 POSIX create context
      smb: client: parse owner/group when creating reparse points
      smb: client: get rid of smb311_posix_query_path_info()
      smb: client: don't clobber ->i_rdev from cached reparse points

Shyam Prasad N (7):
      cifs: open_cached_dir should not rely on primary channel
      cifs: pick channel for tcon and tdis
      cifs: new nt status codes from MS-SMB2
      cifs: reschedule periodic query for server interfaces
      cifs: new mount option called retrans
      cifs: handle servers that still advertise multichannel after disabling
      cifs: update iface_last_update on each query-and-update

Steve French (5):
      smb3: show beginning time for per share stats
      cifs: minor comment cleanup
      Update MAINTAINERS email address
      smb3: minor documentation updates
      cifs: update known bugs mentioned in kernel docs for cifs

 Documentation/admin-guide/cifs/todo.rst  |  44 +++---
 Documentation/admin-guide/cifs/usage.rst |   8 +-
 MAINTAINERS                              |   2 +-
 fs/smb/client/cached_dir.c               |   2 +-
 fs/smb/client/cifs_debug.c               |   6 +-
 fs/smb/client/cifsfs.c                   |   2 +
 fs/smb/client/cifsglob.h                 |   4 +
 fs/smb/client/connect.c                  |   4 +
 fs/smb/client/fs_context.c               |   6 +
 fs/smb/client/fs_context.h               |   2 +
 fs/smb/client/inode.c                    |  29 ++--
 fs/smb/client/misc.c                     |   1 +
 fs/smb/client/readdir.c                  |  12 +-
 fs/smb/client/smb2inode.c                | 234 ++++++++++++--------------------
 fs/smb/client/smb2maperror.c             |   2 +
 fs/smb/client/smb2ops.c                  |  10 +-
 fs/smb/client/smb2pdu.c                  | 127 ++++++++++-------
 fs/smb/client/smb2proto.h                |   4 +-
 fs/smb/client/smb2status.h               |   2 +
 19 files changed, 244 insertions(+), 257 deletions(-)

-- 
Thanks,

Steve

