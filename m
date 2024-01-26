Return-Path: <linux-kernel+bounces-40754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7BA83E55E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 514D11C22754
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CABC2555E;
	Fri, 26 Jan 2024 22:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AhknPGZv"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC40D24B22;
	Fri, 26 Jan 2024 22:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706307968; cv=none; b=pClLm6PIvGK7MIklKk9rY71klg8VZ7j2lWEUWC1QXSoZ5ilasyyOHOpdyAiC8oYPX+bNgV0CIL0BX8SMDJar6+NmbZm+sTYwHUGcKb6TMhlh4G3RgCRAcEw4IvKs76By+hbJABDHgJdvVYHQepaUW+xubDUm9vmS1N91MtobGSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706307968; c=relaxed/simple;
	bh=lvmKKc3zy8mnK4ihRFVki7fAKUnQ1Dnz17ZQA8APQKk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=LUbu08KBB5QcwbhQFdeJKuL8wwU9xOIi+zB3fuXnMOks9PnqGHdI+wi9KYXH6Ar8TrU25mZtQorpP18wB7pC9VZ/cI1iIWjgIkHRkRSVYNLbqGYdZgHZOHpyDL8Zg9INxj73aeT1dnX8CRIMIvGQZsq1oNWGORHGWwPevxy5oMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AhknPGZv; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5100c4aa08cso903844e87.2;
        Fri, 26 Jan 2024 14:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706307965; x=1706912765; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3Cs8TgDbvpR+RBLV3Vi3dZnmq4J6KYhvh4YHbH68AzE=;
        b=AhknPGZvN8+7mACTtXxbbbfuVMsJsaNUwjnX4X+sBBa+SbfpY6uZPlCa6bBdwUampL
         T3ulkZapgYIVLpE9FGXEN5ozL5e34LdE68SORFCHVekFe8RRkp5csSxwGjc1oLCJhfvl
         i5O6VN4Tn9xvWaasJIJPqHDMvh7c0Bvv71X+lBveqyp4f5YZOqaLb4OP89EQEAWRBOyS
         Tq0n/IMCgaQOSGEGO/s7jNucGcEEMU29C627rLKDJ73is7qpb5OHMoWz6VueZNcSMihw
         3n6BvkyQ15KjqUiOvcaNu9qktLlFewDcO4LDrZf7MSgOxAU3RAkK+HZ4f8O7XEYco/6d
         lh3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706307965; x=1706912765;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Cs8TgDbvpR+RBLV3Vi3dZnmq4J6KYhvh4YHbH68AzE=;
        b=ugyUETax2M/nRA9KWXWDWxhx0l9SVcgeBfmgD3bMaVlxwDDkeiYK/rTQIqegC/nvAX
         FpfjW8dGeNaXpopUjnoMVnG2LyFi5jckkckc4psoz8hz6WKHlLx0vkiZJddIVyCyN6+4
         R2MFe6RF0KHqbNxiwakeJgYwlvwK6WurZZdynfia9Ze4GT6o9LnW0Mf90ncKdyU4qhRt
         dE+/SKR+C+3lQrMd+ng6qpQrmeGPyT+eHWQLk56A5DGT7omO486QfsWwqmOdsXxzJqIw
         3lOjgAQN/kS8PVqho74sVwMzUClywAIcGW2mpZWcYCVd3cQSaW7MLx8ySmrBuWPSoElq
         XrjQ==
X-Gm-Message-State: AOJu0Yye/cQ3+PZzbFC/rYH6TaXEt/42T60edkHW6CEuinjVNpByGegw
	L3fgh8EAzoAGYAXWw3mgij741EI9sCXCl0unEnxwnzE+RWNIARNtvKrnSpGV1WXB5Dp3mosOPF4
	8Lq1s302INoMmiM0BubXev0t7xHxgzMqq51I=
X-Google-Smtp-Source: AGHT+IEW8KmxfJ4sPjWZ6DQPcu6vjCduP1akYU+k5L+P9ldFfpcF5OBoPDJOdM2XH3Mrrp/fHV+xdusUxLRXz4H+GCc=
X-Received: by 2002:ac2:44d9:0:b0:50e:76b0:7374 with SMTP id
 d25-20020ac244d9000000b0050e76b07374mr241988lfm.32.1706307964420; Fri, 26 Jan
 2024 14:26:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Fri, 26 Jan 2024 16:25:53 -0600
Message-ID: <CAH2r5muRNnOw_2Qs8C=7MC8f8xLHwLGDo4wVOd5q6kG_Wg-CgQ@mail.gmail.com>
Subject: [GIT PULL] smb3 client fixes
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Please pull the following changes since commit
6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/6.8-rc1-smb3-client-fixes

for you to fetch changes up to 993d1c346b1a51ac41b2193609a0d4e51e9748f4:

  cifs: fix stray unlock in cifs_chan_skip_or_disable (2024-01-23
20:23:29 -0600)

----------------------------------------------------------------
Nine cifs/smb client fixes
- Four network error fixes (three relating to replays of requests that
need to be retried,
    and one fixing some places where we were returning the wrong rc up the stack
    on network errors)
- Two multichannel fixes including locking fix and case where subset
of channels need reconnect
- netfs integration fixup: share remote i_size with netfslib
- Two small cleanups (one for addressing a clang warning)

An additional multichannel fix dealing with a problem found in pick channel
in a case when server had crashed, and some fixes for reset of expired
passwords and key rotation are not included in this P/R as they are
still being tested.
----------------------------------------------------------------
Alexey Dobriyan (1):
      smb: client: delete "true", "false" defines

David Howells (1):
      cifs: Share server EOF pos with netfslib

Kees Cook (1):
      smb: Work around Clang __bdos() type confusion

Shyam Prasad N (6):
      cifs: cifs_pick_channel should try selecting active channels
      cifs: translate network errors on send to -ECONNABORTED
      cifs: helper function to check replayable error codes
      cifs: commands that are retried should have replay flag set
      cifs: set replay flag for retries of write command
      cifs: fix stray unlock in cifs_chan_skip_or_disable

 fs/smb/client/cached_dir.c  |  24 ++++-
 fs/smb/client/cifsencrypt.c |   2 +-
 fs/smb/client/cifsfs.c      |  17 ++-
 fs/smb/client/cifsglob.h    |  14 ++-
 fs/smb/client/file.c        |   9 +-
 fs/smb/client/inode.c       |   8 +-
 fs/smb/client/readdir.c     |   2 +-
 fs/smb/client/smb2inode.c   |  33 ++++--
 fs/smb/client/smb2ops.c     | 141 +++++++++++++++++++++---
 fs/smb/client/smb2pdu.c     | 265
+++++++++++++++++++++++++++++++++++++++++-----
 fs/smb/client/smb2proto.h   |   5 +
 fs/smb/client/smbencrypt.c  |   7 --
 fs/smb/client/transport.c   |  14 ++-
 13 files changed, 467 insertions(+), 74 deletions(-)

-- 
Thanks,

Steve

