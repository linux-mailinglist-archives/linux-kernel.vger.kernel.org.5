Return-Path: <linux-kernel+bounces-140655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5318A173B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09AB01C20CBD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DC014EC4C;
	Thu, 11 Apr 2024 14:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xqJXLK0h";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OTu3pZtP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xqJXLK0h";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OTu3pZtP"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9609A14B06E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712845833; cv=none; b=ZJ7t5uxaOvbN2qTcyPQf4zPwxgBAjDlxXjoIX+qkVko5JV9NjXHYIAUvBRYBZPqjss1UCjrfZC+pQ/gRmMRdMKK85YPPjRYJyE7VW2p6b8cxbVfOKhOPgmYlHdE/Wk2XMrN8WHJ1xy7WXBGtTqQ9LOilTYQe6uuzjBdHfwx/HXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712845833; c=relaxed/simple;
	bh=FJyp4WU2hH6nPRi1pokIoxtjaKftmIbp7V4ABDTaRw8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cTFRGBkIowZj0kzT4RoHqM7D34JC+QL9UZVvgGbEYVmw7r4iCzViTnlEHjVgIsr7eFOwp2c3uZPPxoAQTPo/Ob+ArXv04tKreLdFwb1CJtzWPhBF/koPetsnktCfmEaZ6JRFpHv4doC25lSFHZP7eaJGvJhn31BXKBOsKPl2MUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xqJXLK0h; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OTu3pZtP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xqJXLK0h; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OTu3pZtP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 85B33375A5;
	Thu, 11 Apr 2024 14:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712845829; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NAXaqetwF6hL//fq6oUVl72TleUxiMl/rSaKBMe3bRA=;
	b=xqJXLK0hQ1HkTDjblR5d8Vb4kNPvi7QWAk4OmOi86e7qz4TBLYaolNCXZaMvB6xcbCICNc
	Pyj4VAUyO4KWsjX0uo3x3VwzdNidVZbyBUOYOmTm1A36yHE4Id2ZpWkDS2b2JXl6kKba+1
	IH6hRk4O45/qCl2RhCiTyYWnezw2eDc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712845829;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NAXaqetwF6hL//fq6oUVl72TleUxiMl/rSaKBMe3bRA=;
	b=OTu3pZtPU5Dgspbl5ckCmEb1k3EbRZOdn3fqCBHPR9WvBHuNME1MzTzAwjd+fy8tXWDdON
	Ksle32+jUcNywtBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=xqJXLK0h;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=OTu3pZtP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712845829; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NAXaqetwF6hL//fq6oUVl72TleUxiMl/rSaKBMe3bRA=;
	b=xqJXLK0hQ1HkTDjblR5d8Vb4kNPvi7QWAk4OmOi86e7qz4TBLYaolNCXZaMvB6xcbCICNc
	Pyj4VAUyO4KWsjX0uo3x3VwzdNidVZbyBUOYOmTm1A36yHE4Id2ZpWkDS2b2JXl6kKba+1
	IH6hRk4O45/qCl2RhCiTyYWnezw2eDc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712845829;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NAXaqetwF6hL//fq6oUVl72TleUxiMl/rSaKBMe3bRA=;
	b=OTu3pZtPU5Dgspbl5ckCmEb1k3EbRZOdn3fqCBHPR9WvBHuNME1MzTzAwjd+fy8tXWDdON
	Ksle32+jUcNywtBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3DBAF1386D;
	Thu, 11 Apr 2024 14:30:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id H8lCDQX0F2ZZRgAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Thu, 11 Apr 2024 14:30:29 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
	Cyril Hrubis <chrubis@suse.cz>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Giovanni Lostumbo <giovanni.lostumbo@gmail.com>,
	Rob Landley <rob@landley.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 00/31] Remove UCLINUX (nommu support) from LTP legacy C API
Date: Thu, 11 Apr 2024 16:29:54 +0200
Message-ID: <20240411143025.352507-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -1.51
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 85B33375A5
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,linux-m68k.org,gmail.com,landley.net,physik.fu-berlin.de,lists.linux-m68k.org,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]

Hi all,

this is a patchset I announced 3 months ago [1]. I'm Cc you only in
cover letter (I don't want to fill your mailbox, the code itself is in
LTP ML [2], lore archive [3], patchwork [4]).

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/20240103015240.1065284-1-pvorel@suse.cz/
[2] https://lists.linux.it/pipermail/ltp/2024-April/thread.html
[3] https://lore.kernel.org/ltp/
[4] https://patchwork.ozlabs.org/project/ltp/list/

Petr Vorel (31):
  m4: Remove UCLINUX (nommu detection)
  make: Remove WITH_POWER_MANAGEMENT_TESTSUITE
  make: Remove UCLINUX (nommu detection)
  test.h: Remove MAP_PRIVATE_EXCEPT_UCLINUX
  tree: Remove FORK_OR_VFORK and tst_vfork()
  lib/parse_opts.c: Remove UCLINUX
  tlibio.c: Remove UCLINUX
  clone02: Remove UCLINUX
  connect01: Remove UCLINUX
  creat06: Remove UCLINUX
  fcntl: Remove UCLINUX
  semctl06: Remove UCLINUX
  kill: Remove UCLINUX
  madvise02: Remove UCLINUX
  mlockall: Remove UCLINUX
  munmap: Remove UCLINUX
  writev05: Remove UCLINUX
  pipe: Remove UCLINUX
  pause: Remove UCLINUX
  recv*: Remove UCLINUX
  send*: Remove UCLINUX
  sock*: Remove UCLINUX
  read02: Remove UCLINUX
  setgroups04: Remove UCLINUX
  setsid01: Remove UCLINUX
  sigrelse01: Remove UCLINUX
  sysinfo02: Remove UCLINUX
  ustat02: Remove UCLINUX
  lib: Remove -C option and self_exec.c
  Remove doc/old/nommu-notes.txt
  doc: UCLINUX has been removed

 Makefile                                      |   7 -
 configure.ac                                  |   1 -
 doc/maintainers/patch_review.rst              |   4 -
 ...Maintainer-Patch-Review-Checklist.asciidoc |   3 -
 doc/old/nommu-notes.txt                       | 171 -------------
 include/mk/env_post.mk                        |   4 -
 include/mk/features.mk.in                     |  11 -
 include/old/test.h                            |  21 --
 lib/parse_opts.c                              |  23 +-
 lib/self_exec.c                               | 225 ------------------
 lib/tlibio.c                                  |   2 +-
 lib/tst_res.c                                 |   8 -
 lib/tst_test.c                                |  15 --
 m4/ltp-nommu-linux.m4                         |  14 --
 runtest/Makefile                              |   4 -
 testcases/kernel/Makefile                     |   7 +-
 testcases/kernel/syscalls/Makefile            |   5 -
 testcases/kernel/syscalls/access/Makefile     |   4 -
 testcases/kernel/syscalls/clone/clone02.c     |   5 -
 testcases/kernel/syscalls/connect/connect01.c |  17 +-
 testcases/kernel/syscalls/creat/creat06.c     |   6 -
 testcases/kernel/syscalls/epoll/epoll-ltp.c   |   4 +-
 testcases/kernel/syscalls/exit/exit01.c       |   2 +-
 testcases/kernel/syscalls/fcntl/fcntl07.c     |   2 +-
 testcases/kernel/syscalls/fcntl/fcntl11.c     |  16 +-
 testcases/kernel/syscalls/fcntl/fcntl14.c     |  52 +---
 testcases/kernel/syscalls/fcntl/fcntl16.c     |  29 +--
 testcases/kernel/syscalls/fcntl/fcntl17.c     |  59 +----
 testcases/kernel/syscalls/fcntl/fcntl18.c     |  12 +-
 testcases/kernel/syscalls/fcntl/fcntl19.c     |  15 +-
 testcases/kernel/syscalls/fcntl/fcntl20.c     |  16 +-
 testcases/kernel/syscalls/fcntl/fcntl21.c     |  18 +-
 testcases/kernel/syscalls/fcntl/fcntl22.c     |   2 +-
 testcases/kernel/syscalls/ipc/msgsnd/Makefile |   4 -
 .../syscalls/ipc/msgstress/msgstress01.c      |   4 +-
 .../syscalls/ipc/msgstress/msgstress02.c      |   6 +-
 .../syscalls/ipc/msgstress/msgstress03.c      |   4 +-
 .../syscalls/ipc/msgstress/msgstress04.c      |   6 +-
 .../kernel/syscalls/ipc/semctl/semctl06.c     |   9 +-
 testcases/kernel/syscalls/kill/kill02.c       | 101 +-------
 testcases/kernel/syscalls/kill/kill07.c       |  12 +-
 testcases/kernel/syscalls/kill/kill08.c       |  15 +-
 testcases/kernel/syscalls/kill/kill09.c       |  13 +-
 testcases/kernel/syscalls/kill/kill12.c       |   2 +-
 testcases/kernel/syscalls/madvise/madvise02.c |  25 +-
 .../kernel/syscalls/mlockall/mlockall01.c     |  12 -
 .../kernel/syscalls/mlockall/mlockall02.c     |  12 -
 .../kernel/syscalls/mlockall/mlockall03.c     |  12 -
 .../kernel/syscalls/modify_ldt/modify_ldt02.c |   2 +-
 .../kernel/syscalls/mprotect/mprotect02.c     |   4 +-
 .../kernel/syscalls/mprotect/mprotect03.c     |   2 +-
 testcases/kernel/syscalls/munmap/munmap01.c   |  18 +-
 testcases/kernel/syscalls/munmap/munmap02.c   |  18 --
 testcases/kernel/syscalls/munmap/munmap03.c   |   3 +-
 testcases/kernel/syscalls/pause/pause02.c     |  11 +-
 testcases/kernel/syscalls/pause/pause03.c     |  13 +-
 testcases/kernel/syscalls/pipe/pipe02.c       |   9 -
 testcases/kernel/syscalls/pipe/pipe04.c       |  23 +-
 testcases/kernel/syscalls/pipe/pipe09.c       |   4 +-
 testcases/kernel/syscalls/read/read02.c       |   4 -
 testcases/kernel/syscalls/recv/recv01.c       |  19 +-
 .../kernel/syscalls/recvfrom/recvfrom01.c     |  17 +-
 testcases/kernel/syscalls/rename/rename14.c   |   4 +-
 testcases/kernel/syscalls/send/send01.c       |  23 +-
 testcases/kernel/syscalls/sendmsg/sendmsg01.c |  16 +-
 testcases/kernel/syscalls/sendto/sendto01.c   |  23 +-
 .../kernel/syscalls/setfsuid/setfsuid04.c     |   4 +-
 .../kernel/syscalls/setgroups/setgroups04.c   |  12 -
 testcases/kernel/syscalls/setpgid/setpgid01.c |   2 +-
 testcases/kernel/syscalls/setpgrp/setpgrp01.c |   2 +-
 .../kernel/syscalls/setrlimit/setrlimit01.c   |   6 +-
 testcases/kernel/syscalls/setsid/setsid01.c   |  29 +--
 .../kernel/syscalls/sigrelse/sigrelse01.c     |  20 +-
 .../kernel/syscalls/socketpair/socketpair01.c |   2 -
 .../kernel/syscalls/sockioctl/sockioctl01.c   |   2 -
 testcases/kernel/syscalls/sysinfo/sysinfo02.c |  12 -
 testcases/kernel/syscalls/ustat/ustat02.c     |   2 -
 testcases/kernel/syscalls/writev/Makefile     |   4 -
 testcases/kernel/syscalls/writev/writev02.c   |   3 +-
 testcases/kernel/syscalls/writev/writev05.c   |  15 +-
 testcases/kernel/syscalls/writev/writev06.c   |   8 +-
 81 files changed, 100 insertions(+), 1257 deletions(-)
 delete mode 100644 doc/old/nommu-notes.txt
 delete mode 100644 lib/self_exec.c
 delete mode 100644 m4/ltp-nommu-linux.m4

-- 
2.43.0


