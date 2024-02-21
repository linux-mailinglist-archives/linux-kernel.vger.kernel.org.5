Return-Path: <linux-kernel+bounces-74780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF5485D9F0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA549B20DA7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E157993D;
	Wed, 21 Feb 2024 13:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BKHjPqQF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kGD9s/1G";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BKHjPqQF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kGD9s/1G"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1D869953
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 13:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708521855; cv=none; b=txbbbYXA2lghn0HqRq/AEXouMC2eDseSf4YgfKYTKMnrzp/HOzlMiwy4BJToJHVviMz8HleUgmXvfE9ixIbgVzXntZ4jg4HSuALvvIBRylyZ6CT2orHxfXAEvsQwB7XLimx53BPb7i4KPhxNdUNpRdbRY5sEs18qF7d+QitEDFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708521855; c=relaxed/simple;
	bh=Ivhi8q5qp94KjlHMXzjBdPXYtgmawriGFdIv6i5Xt2I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pwxcVe9L81sfFMsEiOQG/cC/m/nIGowJHMTZ8rsHzjZ9PjsITzQIujn5WWW/mRZUTdK6cLNb7D7AiD4f8Y1BOmuV6vX9pcbnoq40ci1aCNDzILCLw0KlBjTGXvtHUhMNJdES0+e8oufONN/riiPC0ZPVDmgIAV2SlnZFTKWGo1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BKHjPqQF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kGD9s/1G; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BKHjPqQF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kGD9s/1G; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7A3A71FB5A;
	Wed, 21 Feb 2024 13:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708521852; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=FXYeO62jt9+Uvzxj4QWHRpl/i6uARaBpK/5WbPWR/5A=;
	b=BKHjPqQFR2lMS9ieo/ImpwT1ocXaX64aj3z+DNnsCRElZXJJ91+lJmLaBFA5l9IZRx7af6
	nPmUDp0+fFC4gKLUrbD1aW4qMa6yobFNCCRnh0jw4lhVx0NGpAepbs7qjOQnE1jj4zoVAK
	cGnHBFxhcq31rhWsHn+FQiXI94Vab2M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708521852;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=FXYeO62jt9+Uvzxj4QWHRpl/i6uARaBpK/5WbPWR/5A=;
	b=kGD9s/1GY1rVNGYQa0q+inpgvp1K+HEm4NkXsju9dn1UsLhQ60dsqGYOl9yJHQRAH8AgXs
	NbZZaHIjPnHil8BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708521852; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=FXYeO62jt9+Uvzxj4QWHRpl/i6uARaBpK/5WbPWR/5A=;
	b=BKHjPqQFR2lMS9ieo/ImpwT1ocXaX64aj3z+DNnsCRElZXJJ91+lJmLaBFA5l9IZRx7af6
	nPmUDp0+fFC4gKLUrbD1aW4qMa6yobFNCCRnh0jw4lhVx0NGpAepbs7qjOQnE1jj4zoVAK
	cGnHBFxhcq31rhWsHn+FQiXI94Vab2M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708521852;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=FXYeO62jt9+Uvzxj4QWHRpl/i6uARaBpK/5WbPWR/5A=;
	b=kGD9s/1GY1rVNGYQa0q+inpgvp1K+HEm4NkXsju9dn1UsLhQ60dsqGYOl9yJHQRAH8AgXs
	NbZZaHIjPnHil8BA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 67D7A13A25;
	Wed, 21 Feb 2024 13:24:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id WgHsF3z51WUSPQAAn2gu4w
	(envelope-from <dwagner@suse.de>); Wed, 21 Feb 2024 13:24:12 +0000
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v2 0/5] nvme-fc: fix blktests nvme/041
Date: Wed, 21 Feb 2024 14:23:59 +0100
Message-ID: <20240221132404.6311-1-dwagner@suse.de>
X-Mailer: git-send-email 2.43.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=BKHjPqQF;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="kGD9s/1G"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.49 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: 0.49
X-Rspamd-Queue-Id: 7A3A71FB5A
X-Spam-Flag: NO

As suggested by Keith I've merged the new flag for nvme-fabrics with the last
patch. I also added some information why nvme-fc is handling the initial connect
attempt differently as requested by Christoph.

The new flag is called connect_async and the default is false/0. I've tested
with a patched nvme-cli/libnvme version and all looks good. When this series is
accepted I'll update nvme-cli/libnvme accordingly. Note, that even with an older
nvme-cli the blktests (especially nvme/041) will pass with a newer kernel.

(nvme/048 is still fails but this is a different problem. On my TODO list)

changes:
v2:
 - renamed flag to connect_async, default false
 - add info to commit message why nvme-fc is different
 - merged connect_async with 'nvme-fc: wait for
   initial connect attempt to finish'

v1:
 - renamed 'nvme-fc: redesign locking and refcounting'
   to 'nvme-fc: reorder ctrl ref counting and cleanup code path'
 - testing with scsi/nvme dev_loss_tmo on real hw
 - removed rport ref counting part
 - collected RB tags
 - https://lore.kernel.org/linux-nvme/20240219131531.15134-1-dwagner@suse.de/
 
v0:
 - initial version
 - https://lore.kernel.org/linux-nvme/20240216084526.14133-1-dwagner@suse.de/

Daniel Wagner (5):
  nvme-fc: rename free_ctrl callback to match name pattern
  nvme-fc: do not retry when auth fails or connection is refused
  nvme-fabrics: introduce ref counting for nvmf_ctrl_options
  nvme-fc: reorder ctrl ref counting and cleanup code path
  nvme-fc: wait for initial connect attempt to finish

 drivers/nvme/host/fabrics.c |  39 +++++++++-
 drivers/nvme/host/fabrics.h |   9 ++-
 drivers/nvme/host/fc.c      | 145 +++++++++++++++++-------------------
 drivers/nvme/host/rdma.c    |  18 +++--
 drivers/nvme/host/tcp.c     |  21 ++++--
 drivers/nvme/target/loop.c  |  19 +++--
 6 files changed, 152 insertions(+), 99 deletions(-)

-- 
2.43.1


