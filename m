Return-Path: <linux-kernel+bounces-23576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D29BA82AE93
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED8AC1C23DF4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C09B15AE3;
	Thu, 11 Jan 2024 12:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lrEmUO3u";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lrEmUO3u"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD48615ADE
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 12:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 90A221FBA7;
	Thu, 11 Jan 2024 12:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704975584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=zAsSdZzhpnvzBzTmhbdd6Q4oWrx5BMkN+qXi6QhRV1I=;
	b=lrEmUO3uA25sEQr2plez6YkkiaG1pzvp5Pb67rNR/2UCNEtCbrmDydOj0rttzXXWHWdm2r
	jOpfVXCEJG7yOwUcBhHVOiYgclbv+GbBwWIpp0TI6tQwHjVDKysgnIcUbmJay7g9GvFAmN
	z36h2dp92uko9OlElUJd8JJeFpvrw8U=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704975584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=zAsSdZzhpnvzBzTmhbdd6Q4oWrx5BMkN+qXi6QhRV1I=;
	b=lrEmUO3uA25sEQr2plez6YkkiaG1pzvp5Pb67rNR/2UCNEtCbrmDydOj0rttzXXWHWdm2r
	jOpfVXCEJG7yOwUcBhHVOiYgclbv+GbBwWIpp0TI6tQwHjVDKysgnIcUbmJay7g9GvFAmN
	z36h2dp92uko9OlElUJd8JJeFpvrw8U=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B8DA13635;
	Thu, 11 Jan 2024 12:19:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OowEGeDcn2UCIQAAD6G6ig
	(envelope-from <jgross@suse.com>); Thu, 11 Jan 2024 12:19:44 +0000
From: Juergen Gross <jgross@suse.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	sstabellini@kernel.org
Subject: [GIT PULL] xen: branch for v6.8-rc1
Date: Thu, 11 Jan 2024 13:19:43 +0100
Message-Id: <20240111121943.3342-1-jgross@suse.com>
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
X-Spam-Level: ***
X-Spam-Score: 3.70
X-Spamd-Result: default: False [3.70 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_DN_NONE(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[43.69%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-0.99)[-0.994];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.8-rc1-tag

xen: branch for v6.8-rc1

It contains:

- a patch updating some Xen PV interface related headers
- a patch fixing some kernel-doc comments in the xenbus driver
- a patch fixing the Xen gntdev driver to not access the struct page
  of pages imported from a DMA-buf


Thanks.

Juergen

 drivers/xen/gntdev-dmabuf.c        | 50 ++++++++++++++++----------------
 drivers/xen/xenbus/xenbus_client.c | 59 ++++++++++++++++++++++----------------
 include/xen/interface/io/displif.h |  2 +-
 include/xen/interface/io/ring.h    |  2 +-
 include/xen/interface/io/sndif.h   |  2 +-
 5 files changed, 62 insertions(+), 53 deletions(-)

Juergen Gross (1):
      xen: update PV-device interface headers

Oleksandr Tyshchenko (1):
      xen/gntdev: Fix the abuse of underlying struct page in DMA-buf import

Randy Dunlap (1):
      xen/xenbus: client: fix kernel-doc comments

