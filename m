Return-Path: <linux-kernel+bounces-36247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A47A6839DDE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31C951F2AB74
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62352187F;
	Wed, 24 Jan 2024 00:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="f3R2Qc0I"
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01957D2F5;
	Wed, 24 Jan 2024 00:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706057936; cv=none; b=kGYJ+CmGIyYMIuyzi/ztZqEGZpmBuT6gbZw/6/4ZFcHEufB9q4S0KaeunjvmveZPYSYvh9BFEUFMZV2/FSnYlhIu1RVvV8Pljdma3+a3Elq3QM/+143EepOKVxajkbxOg4g/9wyA1fE4/D48Ufo6u7j0SgAfzL/LBEqKTLvLSWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706057936; c=relaxed/simple;
	bh=sW+Y20MU/VFGCQimHbrm3O/+hpPKzSdsKRsTMf/sjRE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YQ/wAt6lWByRMW32tuayoBV9ITwKgoGp2vc1yYJi/tt8nocwfH0I1csU05T1cvGnR17JO2hLlFErOLz9/zGhhiy5qtQ1z5Ep9KUibqldSJonWZp6m6s4h+ZjgQHcgqc8lg/qG86mcR8Jyxj2+OW9ZC38dWe6venbYH5IQuIfqv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=f3R2Qc0I; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=2U6pZsqi4Oh7oXdwVx3LuWdFgEkqnlIZZ9lJn+kGE2Y=; b=f3R2Qc0IL5/w8V5fs02yhEAH11
	7NKCu9HrRy/JjvXftKCdhmbgNzlyzpNZPRxcoN5UQGHle5Tn6gWIA3ShcRb6dgyTV9IZPZa5fMtH8
	xr2SsXf0mgXy4LpU3fPTTo6+XSCZTbPKAFckYmuparF28ZWbBw5fOANJD2nqn9oYnXutrtsGyeM/e
	dC+ejB+p0/NbC0IeD7rzUd54/VL/PPRRCKumZgTMDaCgJr0cbj+SOyq1S1CPfrg+aA+Dm1fHnmPBZ
	wiXg31gOPj7y9gibtHB+WVGYqoY8UOWcLgjlSwmFozkWrX0QdQUdZvuBvyJ50b5NZq+pFPiEHotXl
	aDXf6kmw==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rSRLA-00DVeW-2Q;
	Tue, 23 Jan 2024 18:42:05 -0600
From: Elizabeth Figura <zfigura@codeweavers.com>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org
Cc: wine-devel@winehq.org,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Wolfram Sang <wsa@kernel.org>,
	Arkadiusz Hiler <ahiler@codeweavers.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Elizabeth Figura <zfigura@codeweavers.com>
Subject: [RFC PATCH 0/9] NT synchronization primitive driver
Date: Tue, 23 Jan 2024 18:40:19 -0600
Message-ID: <20240124004028.16826-1-zfigura@codeweavers.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series introduces a new char misc driver, /dev/ntsync, which is used
to implement Windows NT synchronization primitives.

== Background ==

The Wine project emulates the Windows API in user space. One particular part of
that API, namely the NT synchronization primitives, have historically been
implemented via RPC to a dedicated "kernel" process. However, more recent
applications use these APIs more strenuously, and the overhead of RPC has become
a bottleneck.

The NT synchronization APIs are too complex to implement on top of existing
primitives without sacrificing correctness. Certain operations, such as
NtPulseEvent() or the "wait-for-all" mode of NtWaitForMultipleObjects(), require
direct control over the underlying wait queue, and implementing a wait queue
sufficiently robust for Wine in user space is not possible. This proposed
driver, therefore, implements the problematic interfaces directly in the Linux
kernel.

This driver was presented at Linux Plumbers Conference 2023. For those further
interested in the history of synchronization in Wine and past attempts to solve
this problem in user space, a recording of the presentation can be viewed here:

    https://www.youtube.com/watch?v=NjU4nyWyhU8


== Performance ==

The gain in performance varies wildly depending on the application in question
and the user's hardware. For some games NT synchronization is not a bottleneck
and no change can be observed, but for others frame rate improvements of 50 to
150 percent are not atypical. The following table lists frame rate measurements
from a variety of games on a variety of hardware, taken by users Dmitry
Skvortsov, FuzzyQuills, OnMars, and myself:

Game				Upstream	ntsync		improvement
===========================================================================
Anger Foot			 69		 99		 43%
Call of Juarez			 99.8		224.1		125%
Dirt 3				110.6		860.7		678%
Forza Horizon 5			108		160		 48%
Lara Croft: Temple of Osiris	141		326		131%
Metro 2033			164.4		199.2		 21%
Resident Evil 2			 26		 77		196%
The Crew			 26		 51		 96%
Tiny Tina's Wonderlands		130		360		177%
Total War Saga: Troy		109		146		 34%
===========================================================================


== Patches ==

This is the first part of a 32-patch series. The series comprises 17 patches
which contain the actual implementation, 13 which provide self-tests, 1 to
update the MAINTAINERS file, and 1 to add API documentation.

The intended semantics of the patches are broadly intended to match those of the
corresponding Windows functions. Since I do not expect familiarity with Windows
syscalls, however, and especially not with some of the more subtle or
unspecified behaviour that they provide, the documentation patch included in the
series also describes the intended behaviour in detail, and can be used as a
specification for the rest of the series.

The entire series can be retrieved or browsed here:

    https://repo.or.cz/linux/zf.git/shortlog/refs/heads/ntsync4

The patches making use of this driver in Wine can be retrieved or browsed here:

    https://repo.or.cz/wine/zf.git/shortlog/refs/heads/ntsync4


== Implementation ==

Some aspects of the implementation may deserve particular comment:

* In the interest of performance, each object is governed only by a single
  spinlock. However, NTSYNC_IOC_WAIT_ALL requires that the state of multiple
  objects be changed as a single atomic operation. In order to achieve this, we
  first take a device-wide lock ("wait_all_lock") any time we are going to lock
  more than one object at a time.

  The maximum number of objects that can be used in a vectored wait, and
  therefore the maximum that can be locked simultaneously, is 64. This number is
  NT's own limit.

  The acquisition of multiple spinlocks will degrade performance. This is a
  conscious choice, however. Wait-for-all is known to be a very rare operation
  in practice, especially with counts that approach the maximum, and it is the
  intent of the ntsync driver to optimize the wait-for-any pattern at the
  expense of the wait-for-all pattern as much as possible.

* NT mutexes are tied to their threads on an OS level, and the kernel includes
  builtin support for "robust" mutexes. In order to keep the ntsync driver
  self-contained and avoid touching more code than necessary, it does not hook
  into task exit nor use pids.

  Instead, the user space emulator is expected to manage thread IDs and pass
  them as an argument to any relevant functions; this is the "owner" field of
  ntsync_wait_args and ntsync_mutex_args.

  When the emulator detects that a thread dies, it should therefore call
  NTSYNC_IOC_KILL_OWNER, which will mark mutexes owned by that thread (if any)
  as abandoned.

* This implementation uses a misc device mostly because it seemed like the
  simplest and least obtrusive option.

  Besides simplicitly of implementation, the only particularly interesting
  advantage is the ability to create an arbitrary number of "contexts"
  (corresponding to Windows virtual machines) which are self-contained and
  shareable across multiple processes; this maps nicely to file descriptions
  (i.e. struct file). This is not impossible with syscalls of course but would
  require an extra argument.

  On the other hand, there is no reason to forbid using ntsync by default from
  user-mode processes, and (as far as I understand) to do so with a char device
  requires explicit configuration by e.g. udev or init. Since this is done with
  e.g. fuse, I assume this is the model to follow, but I may have chosen
  something deprecated.

* ntsync is module-capable mostly because there was nothing preventing it, and
  because it aided development. I am not aware of any reason why being a module
  is required, though.

* The misc minor number has not been reserved with LANANA. I am not sure at what
  point in the process this makes the most sense, but since this is still only
  an RFC I've abstained from doing so yet.


Elizabeth Figura (9):
  ntsync: Introduce the ntsync driver and character device.
  ntsync: Reserve a minor device number and ioctl range.
  ntsync: Introduce NTSYNC_IOC_CREATE_SEM and NTSYNC_IOC_DELETE.
  ntsync: Introduce NTSYNC_IOC_PUT_SEM.
  ntsync: Introduce NTSYNC_IOC_WAIT_ANY.
  ntsync: Introduce NTSYNC_IOC_WAIT_ALL.
  ntsync: Introduce NTSYNC_IOC_CREATE_MUTEX.
  ntsync: Introduce NTSYNC_IOC_PUT_MUTEX.
  ntsync: Introduce NTSYNC_IOC_KILL_OWNER.

 Documentation/admin-guide/devices.txt         |   3 +-
 .../userspace-api/ioctl/ioctl-number.rst      |   2 +
 drivers/misc/Kconfig                          |   9 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/ntsync.c                         | 916 ++++++++++++++++++
 include/linux/miscdevice.h                    |   1 +
 include/uapi/linux/ntsync.h                   |  53 +
 7 files changed, 984 insertions(+), 1 deletion(-)
 create mode 100644 drivers/misc/ntsync.c
 create mode 100644 include/uapi/linux/ntsync.h


base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
-- 
2.43.0


