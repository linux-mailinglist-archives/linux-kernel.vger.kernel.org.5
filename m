Return-Path: <linux-kernel+bounces-154187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5904C8AD8F9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E69B21F21353
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F8E44393;
	Mon, 22 Apr 2024 23:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RejDHZEP"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBF93D556;
	Mon, 22 Apr 2024 23:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713828046; cv=none; b=nK+2re1JKjBzKXcSK7HYb/iSnOpUdUdZf9F/HgU9UbNQbPaad4sy2vkYZB55kHix0bLtNDrinqeCi7BBq3VN6ytg3m8j94dUm7YJtN0Qjhd5ga7yruVrJK6ie0/enu4INIeNSMMOtKw1rjjB4RxIUDEhpfcpAvJIA64yZUiJ38E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713828046; c=relaxed/simple;
	bh=oj/jDjK3V5yRVW0Ym1lVsrvMUhzgj+h+qucbTcRuJMU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=t+tV202BQWgHjTbUPcGtSh357mvLFL9RX4fEE2J1FMYqx/VysfGfgpAXeJ5gzYbiw9J7Z1sbzd53T/PEjLIZfFmQnB4KSiP9r/p1/WxDeJ3fo2Gv/rLKv0gNUwRkswrloSr0Uo9upI3aU+DaTVi+nZSglX0TLCXMlq7dp0N4ycA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RejDHZEP; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2dd6a7ae2dcso29338141fa.1;
        Mon, 22 Apr 2024 16:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713828043; x=1714432843; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/C4ZKdvHLh97H7STf6xCInhQe9bGeawo6BaxTH4MasM=;
        b=RejDHZEPhM+fEan6LyKWXAv5GavI5NR8O4Wu2eBUvjG78jSj1kWF3JhSocVKrgXt/i
         DZAF1rDdkvMPVoID5O84B7NLc8PAn6Av9lf/ERVaAzmkh7ckG9ICBUDZzzY3jP0jsBqC
         eCDzeQD0Y74Sgc9ybJCpBn4gw2T0nzPTerwQAnBhX612YxCRQtqjOV7V4uxejZZf/8+p
         eCXtg8qarcbStiG3PCGGGMvXe1Mhs/HEl8Z4SYNvJkxJ7/lOaciCCnEMUjFUfEKClUnY
         k3S77AzpF/iERlWiGVPS/b3mR9j5fcvuOBVTjZ5WelRIbPZG5D5uzeJHSqDTIJyRRZOn
         vj7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713828043; x=1714432843;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/C4ZKdvHLh97H7STf6xCInhQe9bGeawo6BaxTH4MasM=;
        b=ZKC8zcvWSj7RSYV2P60xYIy48yRiL4+6fIp6P5mnMAljF3RXe5k9XqP2lJmba46T2j
         jOFPohHLbp7184EW71Iu9UDcDfPfRRPvKa0c21DPFr6R0aeIeDU2ZdbMwmgTNLId5iKZ
         N7nkpD5zfi4HoE7QIxj9tGnjs1VkMdHWs4OxHb0nA6dPC9aDqiLpISA1Finb/sRuOI88
         kGf1RQ+YZrTv+ZfjiIVhiHPlUl8SiHYkZbZ7sc6HicVDQAQWOLguzqeCNs3k9YLljHO4
         +HyfK4csu7D2uMfTx0woVCYh5uuhn34YaYekoLyGaXKCiInazAZn1cVnQ7Ob31mDL9Ht
         iIuA==
X-Forwarded-Encrypted: i=1; AJvYcCXK5HA2pkjPuVsPfW/4Ve7KpeLuJ0vlik8KD/wVrFPRnNZjKTDyKWxzORJskMu1tWr2HhoLE+J3Cr7/UzsEY7vJ+2zYimZ/FPNGxg==
X-Gm-Message-State: AOJu0YzP5Rd73xV2xJ5b8v/taUgVlmYWvayU3iChoEA6YFNFoSlwLy9k
	Z+Ov1ZLV/kfhh31S+9EVGpK1Ze4/os/0oOfNQ+slpnQem710s+nJ/J7sfs+JX/ahOgZtGU8d3Ng
	a3hpbJXoX3ECQ2X97+ZegPbG2fGGjfGYl
X-Google-Smtp-Source: AGHT+IGaATWXxm54U52r2l7bs7whal15Jl96TdQJ+uO4Ct9/JAw5VwRxdhOHm+JbWX96oWX+haITAEbREAZIwagvcHs=
X-Received: by 2002:a2e:a988:0:b0:2d6:c749:17bc with SMTP id
 x8-20020a2ea988000000b002d6c74917bcmr10136033ljq.31.1713828042866; Mon, 22
 Apr 2024 16:20:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Mon, 22 Apr 2024 18:20:31 -0500
Message-ID: <CAH2r5mt+jm0-X-zx18QgJ+Q2DX9pCkf+TQH=Cb809xTjVJVGQQ@mail.gmail.com>
Subject: [GIT PULL] ksmbd server fixes
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Namjae Jeon <linkinjeon@kernel.org>, 
	CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Please pull the following changes since commit
0bbac3facb5d6cc0171c45c9873a2dc96bea9680:

  Linux 6.9-rc4 (2024-04-14 13:38:39 -0700)

are available in the Git repository at:

  git://git.samba.org/ksmbd.git tags/6.9-rc5-ksmbd-fixes

for you to fetch changes up to e9d8c2f95ab8acaf3f4d4a53682a4afa3c263692:

  ksmbd: add continuous availability share parameter (2024-04-19 20:48:47 -0500)

----------------------------------------------------------------
Five ksmbd server fixes, most also for stable
- rename fix
- fix for two potential out of bounds
- fix for connections from MacOS (padding in close response)
- fix for when to enable persistent handles
----------------------------------------------------------------
Marios Makassikis (1):
      ksmbd: clear RENAME_NOREPLACE before calling vfs_rename

Namjae Jeon (4):
      ksmbd: fix slab-out-of-bounds in smb2_allocate_rsp_buf
      ksmbd: validate request buffer size in smb2_allocate_rsp_buf()
      ksmbd: common: use struct_group_attr instead of struct_group for
network_open_info
      ksmbd: add continuous availability share parameter

 fs/smb/common/smb2pdu.h       |  2 +-
 fs/smb/server/ksmbd_netlink.h | 35 ++++++++++++++++++-----------------
 fs/smb/server/server.c        | 13 +++++--------
 fs/smb/server/smb2pdu.c       | 15 +++++++++++++--
 fs/smb/server/vfs.c           |  5 +++++
 5 files changed, 42 insertions(+), 28 deletions(-)

-- 
Thanks,

Steve

