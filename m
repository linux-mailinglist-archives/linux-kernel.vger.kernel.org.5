Return-Path: <linux-kernel+bounces-67172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC0985677C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D8A21C2343E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02330133283;
	Thu, 15 Feb 2024 15:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qfSo7lpG";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qfSo7lpG"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62409133280
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 15:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708010671; cv=none; b=p3hHs8VyOwji73fgi77qlNNk006eAhd2pJqC0U7Q7hWw80BL2FcMxNP8ogh9RY/zS/vP65AU5gxtL2TbKQcLKTU5V2qede4sVfPJRdavGOy2iXObMrAfm/lV0ttfwG8pdBJEPh6m2xHzg2Gb6uNEqf8UriHjvXhytCuNRLIbYjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708010671; c=relaxed/simple;
	bh=HbIg5ZTn+FRNT2DkRe9Jp3wUHIb0n/9B+eMtrACRCus=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MKRmztfLQ9DgKOsLHKsCQLDJLt8+pW8n3d+HWr/dUQD31JcfXHehx5QT+am93sE7lQJxc+YS+nkl/BuHxP+mHncj7je7ykziNGrGyLO2XiHqNcamM3JAmFs/dhqiHKBGRfZBlFMP8q5vRvzzr89IvOHBiKtugCJouAA9qsW1Txk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qfSo7lpG; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qfSo7lpG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9212B1F37C;
	Thu, 15 Feb 2024 15:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708010667; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=w8YrKr7y5fp/hYmK3TluFyGEjlZFNDerawHnk8q2R7I=;
	b=qfSo7lpGs27P15YkSHy28TPxqlVfMSXrbcvQ13hP4+iy+cCdzDuRRqf7lvV7F0jwTqw9Zf
	xdtXWAlxi0OQJI6Z0+chJSu3xiI1SVCNSVoJO0nBKmKDJGb2WQT1SK/Vacst1weY4UanNQ
	U9ALm1BQr7d9uuGGdwT0F+Ys7p6tdF0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708010667; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=w8YrKr7y5fp/hYmK3TluFyGEjlZFNDerawHnk8q2R7I=;
	b=qfSo7lpGs27P15YkSHy28TPxqlVfMSXrbcvQ13hP4+iy+cCdzDuRRqf7lvV7F0jwTqw9Zf
	xdtXWAlxi0OQJI6Z0+chJSu3xiI1SVCNSVoJO0nBKmKDJGb2WQT1SK/Vacst1weY4UanNQ
	U9ALm1BQr7d9uuGGdwT0F+Ys7p6tdF0=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 65666139D0;
	Thu, 15 Feb 2024 15:24:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id SvsjF6sszmUKNAAAn2gu4w
	(envelope-from <jgross@suse.com>); Thu, 15 Feb 2024 15:24:27 +0000
From: Juergen Gross <jgross@suse.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	sstabellini@kernel.org
Subject: [GIT PULL] xen: branch for v6.8-rc5
Date: Thu, 15 Feb 2024 16:24:26 +0100
Message-Id: <20240215152426.1114-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.70
X-Spamd-Result: default: False [0.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_DN_NONE(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.8a-rc5-tag

xen: branch for v6.8-rc5

It contains the following fixes and simple cleanups:

- A fix using a proper flexible array instead of a one-element array in order to
  avoid array-bounds sanitizer errors.

- A fix adding NULL pointer checks after allocating memory.

- A cleanup using memdup_array_user() instead of open-coding it.

- A fix for a rare race condition in Xen event channel allocation code.

- A small series making struct bus_type instances const.

- A fix of kerneldoc inline comments to match reality.


Thanks.

Juergen

 arch/x86/xen/smp.c                 | 12 ++++++++++++
 drivers/xen/events/events_base.c   |  8 ++++++--
 drivers/xen/gntalloc.c             |  2 +-
 drivers/xen/pcpu.c                 |  2 +-
 drivers/xen/privcmd.c              | 15 +++++----------
 drivers/xen/xen-balloon.c          |  2 +-
 drivers/xen/xenbus/xenbus_client.c | 15 +++++++++------
 include/uapi/xen/gntalloc.h        |  5 ++++-
 8 files changed, 39 insertions(+), 22 deletions(-)

Kees Cook (1):
      xen/gntalloc: Replace UAPI 1-element array

Kunwu Chan (1):
      x86/xen: Add some null pointer checking to smp.c

Markus Elfring (1):
      xen/privcmd: Use memdup_array_user() in alloc_ioreq()

Maximilian Heyne (1):
      xen/events: close evtchn after mapping cleanup

Ricardo B. Marliere (2):
      xen: pcpu: make xen_pcpu_subsys const
      xen: balloon: make balloon_subsys const

SeongJae Park (1):
      xen/xenbus: document will_handle argument for xenbus_watch_path()

