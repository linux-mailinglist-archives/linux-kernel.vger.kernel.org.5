Return-Path: <linux-kernel+bounces-145087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBD78A4F5A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5F5D283EF8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036AF73503;
	Mon, 15 Apr 2024 12:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Riq6rqQ8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kBnk/nnK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Riq6rqQ8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kBnk/nnK"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA367316E
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 12:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713184952; cv=none; b=pWNx2aMizRyDIxzDgQFCd1tG4SRUelV/YFp0alXFMn980VDQP6mn25N8PfRbJIOr6G+9uf9AIJL1LFGlYFbcbAs92OB2HlcWcaiezY5dgEUOZD227VpJ22/07CwTTMzI0RXHuz9g7LkfkHmt++3YldsbDM6xgByn5ZOkSSWTsGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713184952; c=relaxed/simple;
	bh=aO5irizUfsI/C2XrlQPAikT66BIgu0ZNpp3QLqF7ozg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JB2yHlBk9GsIFutb24Bt1xyW13tWgX7WO3KnrZSUwCWIB4Dl6GtuqteADD1oPY7aUvWwEdws6IOjla918Y5BrDe2Cz2WSJjllaZ/xbI1Eam78OAq8kWQuK1uCIrcbB0nJi0jAVh07zCYNp4I65ftIPNEK0r05oZBSYU7h3DPjdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Riq6rqQ8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kBnk/nnK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Riq6rqQ8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kBnk/nnK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 97A025CF88;
	Mon, 15 Apr 2024 12:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713184942; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=xCUjHhPcLIikr2Xjthccw3uC0sbKS2tipG0r76S/jOQ=;
	b=Riq6rqQ863fIP0WTUEZ9AYHsttx6WtbFG6GhrtY0125ZA1XqBdg05Z+731h0s5j3uLtvxI
	GMgctyXGuwlBGAPH4IB8AKstPkD1AdnOlfsXzdXrru7uz0UlsBqU4bBL6KkT3/tJES4fr2
	pwyyWbUU25CwCSsOnJ2v8hZSiNWkRJ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713184942;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=xCUjHhPcLIikr2Xjthccw3uC0sbKS2tipG0r76S/jOQ=;
	b=kBnk/nnKfEiUIbOYOphI7IXXBw5HpS8tW5ggSgUAI6iPVvTMaIAPcZebgEVNlCTSi3tQbX
	zLoN/jLcDZ+NR3Dw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713184942; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=xCUjHhPcLIikr2Xjthccw3uC0sbKS2tipG0r76S/jOQ=;
	b=Riq6rqQ863fIP0WTUEZ9AYHsttx6WtbFG6GhrtY0125ZA1XqBdg05Z+731h0s5j3uLtvxI
	GMgctyXGuwlBGAPH4IB8AKstPkD1AdnOlfsXzdXrru7uz0UlsBqU4bBL6KkT3/tJES4fr2
	pwyyWbUU25CwCSsOnJ2v8hZSiNWkRJ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713184942;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=xCUjHhPcLIikr2Xjthccw3uC0sbKS2tipG0r76S/jOQ=;
	b=kBnk/nnKfEiUIbOYOphI7IXXBw5HpS8tW5ggSgUAI6iPVvTMaIAPcZebgEVNlCTSi3tQbX
	zLoN/jLcDZ+NR3Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A8B91386E;
	Mon, 15 Apr 2024 12:42:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7pyxHK4gHWYnAwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 15 Apr 2024 12:42:22 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v6 0/5] nvme-fabrics: short-circuit connect retries
Date: Mon, 15 Apr 2024 14:42:15 +0200
Message-ID: <20240415124220.5433-1-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_HAS_DN(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

I've resorted the series so that the nvmet changes come first instead as the
last patch. These changes are necessary to get the host code tested.

The second big changes is moving the logic into the existing helper
nvmf_should_reconnect, all the transports get updated in one go.

And lastely, I've added a retry auth failure patch as requested by Sagi. I
explictly decided against to count these error from the normal retry counter
(nr_reconnects) as this would make it unnecessary complex to map the two
different max limits into one counter.

changes:
v6:
  - reorder series
  - extended nvmf_should_reconnect
  - added auth retry logic
  
v5:
  - nvme: do not mix kernel error code with nvme status
  - nvmet: separate nvme status from dhchap status
  - https://lore.kernel.org/linux-nvme/20240409093510.12321-1-dwagner@suse.de/

v4:
  - rebased
  - added 'nvme: fixes for authentication errors' series
  - https://lore.kernel.org/all/20240404154500.2101-1-dwagner@suse.de/

v3:
  - added my SOB tag
  - fixed indention
  - https://lore.kernel.org/linux-nvme/20240305080005.3638-1-dwagner@suse.de/

v2:
  - refresh/rebase on current head
  - extended blktests (nvme/045) to cover this case
    (see separate post)
  - https://lore.kernel.org/linux-nvme/20240304161006.19328-1-dwagner@suse.de/
  
v1:
  - initial version
  - https://lore.kernel.org/linux-nvme/20210623143250.82445-1-hare@suse.de/

Daniel Wagner (1):
  nvme-fabrics: handle transient auth failures

Hannes Reinecke (4):
  nvmet: lock config semaphore when accessing DH-HMAC-CHAP key
  nvmet: return DHCHAP status codes from nvmet_setup_auth()
  nvme: authentication error are always non-retryable
  nvme-fabrics: short-circuit reconnect retries

 drivers/nvme/host/auth.c               |  4 +-
 drivers/nvme/host/core.c               |  6 +--
 drivers/nvme/host/fabrics.c            | 58 +++++++++++++++++---------
 drivers/nvme/host/fabrics.h            |  2 +-
 drivers/nvme/host/fc.c                 |  6 +--
 drivers/nvme/host/nvme.h               |  3 +-
 drivers/nvme/host/rdma.c               | 20 +++++----
 drivers/nvme/host/tcp.c                | 23 ++++++----
 drivers/nvme/target/auth.c             | 22 +++++-----
 drivers/nvme/target/configfs.c         | 22 +++++++---
 drivers/nvme/target/fabrics-cmd-auth.c | 49 +++++++++++-----------
 drivers/nvme/target/fabrics-cmd.c      | 11 ++---
 drivers/nvme/target/nvmet.h            |  8 ++--
 13 files changed, 140 insertions(+), 94 deletions(-)

-- 
2.44.0


