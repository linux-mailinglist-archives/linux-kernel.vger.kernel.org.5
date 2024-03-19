Return-Path: <linux-kernel+bounces-107152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F22B87F82E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 307391C21A6E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D065103F;
	Tue, 19 Mar 2024 07:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TZfk+EKd";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kZtefftj"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E533051005
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 07:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710832226; cv=none; b=CcRV9um52gSAtAvlrCrOBymEsHLuadROH1W2iTXOtip2XF1Do9cZMr6QC0/8qn1nta31MbvZFdjvsH2/Ho3cCHFil9oas9Cn4LnJO6PIUhJObacm+qyAmpe+gW2lzoOe0zaBaCYxLBRSI/v4ltOkBIMeTJAG32NrUXq4mRuAG3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710832226; c=relaxed/simple;
	bh=DMTB90vhgk5IoJmWBx0a9yIVu6qZQfI4yucgHT70e1M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=LTg1UKZ0SlxqtwkFQZgzCA/yCY/O60E/cn4A0s50elu5aElL5NeU+UQEvLKdbWIBhSVx4632B0G4L9oNVdiSTVwaZOCxI29S85plETT9/59hSZ1Wrwyg+OR6dB7vVxwzpIQzB2sUimYV4SLyl5sMU+iSbBtnEgs7eFKcMa0ygpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TZfk+EKd; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kZtefftj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DC69B5D25C;
	Tue, 19 Mar 2024 07:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710832223; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=60bEIDwx+NXczuoY7AFrsSbeXmm714yJjf0EPnqnQ6o=;
	b=TZfk+EKd+rpUzJAX7/cgQaDnSlrl68A0hnx/FbOIrgbzVPuemZlRN07Up0duvO+pTt0O6j
	K0yWbLG/fJKaJuBQY8mmiLU4cSYusYP1y74CIKCkFWru0KJXiTgZmeJhUN1E4oNA63utdD
	j1SJ0FmvH+XZXkP1xN/LXeCuiwzbA/U=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710832222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=60bEIDwx+NXczuoY7AFrsSbeXmm714yJjf0EPnqnQ6o=;
	b=kZtefftjM/Ld8PYQi5P+W736PuwztLTtFlY5/tF8FF/lwZUu/WRQ7NOzClDHOKOP1mecFC
	EsvdgpEzpgofq4DqqAkvoS0lHkVG5nuJv+TMbxwRlu2nZSS9eX7qt0dxVlQP2C7HCb3KXz
	LFZefv0pH38RoMN2DQ0hdy8kVzN51VE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B21B8136A5;
	Tue, 19 Mar 2024 07:10:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Gsr2KV46+WVJYwAAD6G6ig
	(envelope-from <jgross@suse.com>); Tue, 19 Mar 2024 07:10:22 +0000
From: Juergen Gross <jgross@suse.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	sstabellini@kernel.org
Subject: [GIT PULL] xen: branch for v6.9-rc1
Date: Tue, 19 Mar 2024 08:10:22 +0100
Message-Id: <20240319071022.7513-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: -5.01
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spamd-Result: default: False [-5.01 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_DN_NONE(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DWL_DNSWL_HI(-3.50)[suse.com:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.00)[87.14%]
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=kZtefftj
X-Rspamd-Queue-Id: DC69B5D25C

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.9-rc1-tag

xen: branch for v6.9-rc1

It contains the following patches:

- 2 patches for Xen event channel handling fixing a regression wit a
  rare kernel config and adding some hardening.

- A patch for better support of running Xen dom0 in PVH mode.

- A cleanup patch for the xen grant-dma-iommu driver.


Thanks.

Juergen

 arch/x86/include/asm/xen/hypervisor.h |  5 +++
 arch/x86/platform/pvh/enlighten.c     |  3 ++
 arch/x86/xen/enlighten.c              | 32 +++++++++++++++++
 arch/x86/xen/enlighten_pvh.c          | 68 +++++++++++++++++++++++++++++++++++
 arch/x86/xen/setup.c                  | 44 -----------------------
 arch/x86/xen/xen-ops.h                | 14 ++++++++
 drivers/xen/balloon.c                 |  2 --
 drivers/xen/events/events_base.c      | 22 +++++++-----
 drivers/xen/evtchn.c                  |  6 ++++
 drivers/xen/grant-dma-iommu.c         |  6 ++--
 10 files changed, 143 insertions(+), 59 deletions(-)

Juergen Gross (2):
      xen/evtchn: avoid WARN() when unbinding an event channel
      xen/events: increment refcnt only if event channel is refcounted

Roger Pau Monne (1):
      x86/xen: attempt to inflate the memory balloon on PVH

Uwe Kleine-König (1):
      xen/grant-dma-iommu: Convert to platform remove callback returning void

