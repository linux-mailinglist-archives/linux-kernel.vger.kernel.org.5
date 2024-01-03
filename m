Return-Path: <linux-kernel+bounces-15051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 151DC8226AE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 02:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 754C9B20D04
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 01:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB39139F;
	Wed,  3 Jan 2024 01:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2yEOpGSx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fz33p47i";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2yEOpGSx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fz33p47i"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F8B136B
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 01:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5947A1FD0A;
	Wed,  3 Jan 2024 01:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704246765; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=GetBIm1wa9nRNagvT5RwK+UeNRdHdjV0U/uEPFnwK5A=;
	b=2yEOpGSxUR3su7K2QJDXCq3vrCXEIAcd76b4bnoSyGMNM5bM8Rm/aJCCm/YCAvBpHtCuy+
	9GxdD7DdAgqAS4a/2QU/AyjBqQsu6+GwB8AKJzZpPVQnI1ZGI/Tyd8Yu5mpJ4hKiAKfJIb
	bXcvd+rVWZhcnz61KPyP1Kznr4Qsxsw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704246765;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=GetBIm1wa9nRNagvT5RwK+UeNRdHdjV0U/uEPFnwK5A=;
	b=fz33p47idiN+ydd3queRFK9jw1easOTOiZ/qfIo/1s4W/7ojbEJ/zOTD5EbUSWJgrFpPeA
	2Sy360w6EdSz6xBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704246765; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=GetBIm1wa9nRNagvT5RwK+UeNRdHdjV0U/uEPFnwK5A=;
	b=2yEOpGSxUR3su7K2QJDXCq3vrCXEIAcd76b4bnoSyGMNM5bM8Rm/aJCCm/YCAvBpHtCuy+
	9GxdD7DdAgqAS4a/2QU/AyjBqQsu6+GwB8AKJzZpPVQnI1ZGI/Tyd8Yu5mpJ4hKiAKfJIb
	bXcvd+rVWZhcnz61KPyP1Kznr4Qsxsw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704246765;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=GetBIm1wa9nRNagvT5RwK+UeNRdHdjV0U/uEPFnwK5A=;
	b=fz33p47idiN+ydd3queRFK9jw1easOTOiZ/qfIo/1s4W/7ojbEJ/zOTD5EbUSWJgrFpPeA
	2Sy360w6EdSz6xBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1E74813418;
	Wed,  3 Jan 2024 01:52:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UftiBu29lGXxBgAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Wed, 03 Jan 2024 01:52:45 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
	Cyril Hrubis <chrubis@suse.cz>,
	Li Wang <liwang@redhat.com>,
	Andrea Cervesato <andrea.cervesato@suse.com>,
	Greg Ungerer <gerg@linux-m68k.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Christophe Lyon <christophe.lyon@linaro.org>,
	linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 00/36] Remove UCLINUX from LTP
Date: Wed,  3 Jan 2024 02:52:40 +0100
Message-ID: <20240103015240.1065284-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: *
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=2yEOpGSx;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=fz33p47i
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.49 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: 0.49
X-Rspamd-Queue-Id: 5947A1FD0A
X-Spam-Flag: NO

Hi all,

UCLINUX is broken in LTP and nobody really cares. Actually I dare to
say UCLINUX is dead. Therefore I prepared patchset to remove UCLINUX
from LTP. We have been actively removing UCLINUX from LTP during rewrite
tests to new LTP API. This removes the rest from the old tests (which
will be sooner or later rewritten to new API).

Because the patchset is quite big, I did not want to send it to mailing
lists (but I can do it if you want).

Can you please have look at my fork on gitlab, branch: remove-UCLINUX
https://gitlab.com/pevik/ltp/-/commits/remove-UCLINUX?ref_type=heads

Build test:
https://github.com/pevik/ltp/actions/runs/7392470215

Kind regards,
Petr

Petr Vorel (36):
  m4: Remove UCLINUX detection
  make: Remove WITH_POWER_MANAGEMENT_TESTSUITE
  make: Remove UCLINUX
  test.h: Remove MAP_PRIVATE_EXCEPT_UCLINUX
  tree: Remove FORK_OR_VFORK and tst_vfork()
  lib/parse_opts.c: Remove UCLINUX
  tlibio.c: Remove UCLINUX
  clone02: Remove UCLINUX
  connect01: Remove UCLINUX
  creat06: Remove UCLINUX
  fcntl: Remove UCLINUX
  getpeername01: Remove UCLINUX
  getsockname01: Remove UCLINUX
  getsockopt01: Remove UCLINUX
  semctl06: Remove UCLINUX
  kill: Remove UCLINUX
  madvise02: Remove UCLINUX
  mlockall: Remove UCLINUX
  waitpid: Remove UCLINUX
  munmap: Remove UCLINUX
  writev05: Remove UCLINUX
  pipe: Remove UCLINUX
  pause: Remove UCLINUX
  recv*: Remove UCLINUX
  send*: Remove UCLINUX
  sock*: Remove UCLINUX
  munlockall01: Remove UCLINUX
  read02: Remove UCLINUX
  setgroups04: Remove UCLINUX
  setsid01: Remove UCLINUX
  sigrelse01: Remove UCLINUX
  sysinfo02: Remove UCLINUX
  ustat02: Remove UCLINUX
  lib: Remove -C option and self_exec.c
  Remove doc/nommu-notes.txt
  doc: UCLINUX has been removed

 Makefile                                      |   7 -
 configure.ac                                  |   1 -
 ...Maintainer-Patch-Review-Checklist.asciidoc |   3 -
 doc/nommu-notes.txt                           | 171 -------------
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
 .../syscalls/getpeername/getpeername01.c      |   2 -
 .../syscalls/getsockname/getsockname01.c      |   3 -
 .../kernel/syscalls/getsockopt/getsockopt01.c |   2 -
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
 .../kernel/syscalls/munlockall/munlockall01.c |  12 -
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
 testcases/kernel/syscalls/setpgrp/setpgrp02.c |   2 +-
 .../kernel/syscalls/setrlimit/setrlimit01.c   |   6 +-
 testcases/kernel/syscalls/setsid/setsid01.c   |  29 +--
 .../kernel/syscalls/sigrelse/sigrelse01.c     |  20 +-
 .../kernel/syscalls/socketpair/socketpair01.c |   2 -
 .../kernel/syscalls/sockioctl/sockioctl01.c   |   2 -
 testcases/kernel/syscalls/sysinfo/sysinfo02.c |  12 -
 testcases/kernel/syscalls/ustat/ustat02.c     |   2 -
 testcases/kernel/syscalls/waitpid/waitpid02.c |  10 +-
 testcases/kernel/syscalls/waitpid/waitpid03.c |  28 +--
 testcases/kernel/syscalls/waitpid/waitpid04.c |   2 +-
 testcases/kernel/syscalls/waitpid/waitpid05.c |  28 +--
 testcases/kernel/syscalls/writev/Makefile     |   4 -
 testcases/kernel/syscalls/writev/writev02.c   |   3 +-
 testcases/kernel/syscalls/writev/writev05.c   |  15 +-
 testcases/kernel/syscalls/writev/writev06.c   |   8 +-
 89 files changed, 105 insertions(+), 1337 deletions(-)
 delete mode 100644 doc/nommu-notes.txt
 delete mode 100644 lib/self_exec.c
 delete mode 100644 m4/ltp-nommu-linux.m4

-- 
2.43.0


