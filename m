Return-Path: <linux-kernel+bounces-101164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC72087A34D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 08:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CFC72830BD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 07:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75E62134F;
	Wed, 13 Mar 2024 07:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nj8Bne9h";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nj8Bne9h"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8596420DC5
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 07:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710314062; cv=none; b=Jyp/LQAPh5ZnPWHnsyXD6ELswTF6xWn/kY8t+pcWpifffsAZT38+ZSRO0X+NJ5zCGQSrJ9bxCdfoDOe2QDpalfhGz1porX5BNTDxWJhCH/9pV9ZIaMAehXKK5mZ4rlko567gvG0RM8WRP/DnI+9Ar6ECcPztM1HqgAA//MQMajk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710314062; c=relaxed/simple;
	bh=Qqm+mNyOMNGhWGPazj/rebH3gZ12O8vArW5ISueyxxo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DjF1adlP6gMuUsLwZkveP9vTy/yEU6l1YrmNyhdIj6Q1PVIuX8LVWolCoyTyuXPq2mAE8802bnCHtA2nRb5GBQZTXGWnjh85Awvh0837NPmvNNiDVkZEusnJu/+dEe0B6xpnYcVNIJQe6ohUVPH8W30EvKBNC83iRFhxDxyQ1EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nj8Bne9h; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nj8Bne9h; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0A64F21B98;
	Wed, 13 Mar 2024 07:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710314053; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=kxMz5wRYRts6SEKGqAGBVkV0rkhnV3B7oQVvSfAgUd8=;
	b=nj8Bne9hJ+j5/yvQm/rexgklUlFOuMukRu3zd6VSc+1L5d3a/L4osnKJ3W0+g8SaTHiXNH
	Rs7oux9FA9GDxamk3jtETc2hlMzVyZ6gZY31Hs0C/csnKfO5xrkmYdU7vbrVDljMiogmiu
	TPzwDSOY9Q5oJO4d+VI2AVn8pBh6lIw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710314053; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=kxMz5wRYRts6SEKGqAGBVkV0rkhnV3B7oQVvSfAgUd8=;
	b=nj8Bne9hJ+j5/yvQm/rexgklUlFOuMukRu3zd6VSc+1L5d3a/L4osnKJ3W0+g8SaTHiXNH
	Rs7oux9FA9GDxamk3jtETc2hlMzVyZ6gZY31Hs0C/csnKfO5xrkmYdU7vbrVDljMiogmiu
	TPzwDSOY9Q5oJO4d+VI2AVn8pBh6lIw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BAFCB13977;
	Wed, 13 Mar 2024 07:14:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kyWaK0RS8WWlSAAAD6G6ig
	(envelope-from <jgross@suse.com>); Wed, 13 Mar 2024 07:14:12 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	xen-devel@lists.xenproject.org
Subject: [PATCH 0/2] xen: two fixes related to event channels
Date: Wed, 13 Mar 2024 08:14:07 +0100
Message-Id: <20240313071409.25913-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=nj8Bne9h
X-Spamd-Result: default: False [4.66 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.03)[56.12%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 URIBL_BLOCKED(0.00)[suse.com:dkim];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Score: 4.66
X-Spam-Level: ****
X-Rspamd-Queue-Id: 0A64F21B98
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Two patches fixing one seen problem and another potential one. Both
have been introduced in the 6.7 kernel.

Juergen Gross (2):
  xen/evtchn: avoid WARN() when unbinding an event channel
  xen/events: increment refcnt only if event channel is refcounted

 drivers/xen/events/events_base.c | 22 +++++++++++++---------
 drivers/xen/evtchn.c             |  6 ++++++
 2 files changed, 19 insertions(+), 9 deletions(-)

-- 
2.35.3


