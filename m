Return-Path: <linux-kernel+bounces-68260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A07248577EE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FA721F22F92
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D861B948;
	Fri, 16 Feb 2024 08:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pnZF/Ej1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NhqBmSZ5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pnZF/Ej1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NhqBmSZ5"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8FE1426F
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 08:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708073143; cv=none; b=Ex+TEEvPMwLyOUeMkbMKecSnsQXhuPhN0IDP6ynGAlWy4DNRIes2ZhBiCx1GhaFvjMh0U+htDnB4fklw0eHBxxbfcRQRwvLrI0e2iwA6oMuO7KOFWuyWweX+gR3LEe9DZfdh6n2V35zydT9fm4kHbnGNL5PzgTnzgMjsCnAGBG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708073143; c=relaxed/simple;
	bh=nvyCXaci7deXldpvtrJ91tdBjlxrfebO/ogS7nn5C60=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o+TmHTua43sZpCgESFLj+8qKlcpa5nZqWAC4FwmGzXOIMfHkz1AxA7nYpUCBN7qhL6PkN8i6376iS3wzmwqicxc2i6Cfsn1V6gLD5DsbKFyNM1OIe4pWNqADQMpuvz04i01PR/+RhjbyuCg4aGREoWdKby8n9N8o/E67yYIZC9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pnZF/Ej1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NhqBmSZ5; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pnZF/Ej1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NhqBmSZ5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C72D621FBE;
	Fri, 16 Feb 2024 08:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708073138; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=403rjhUhkgmIPcGE1ndabC2ltuIaZcgjrlVJxlVXY2M=;
	b=pnZF/Ej1irKm/Pjj1LY3waGtoPw9vua/7wmYPSY1EAB/35/fwhCTXdX0w5u3bX8v0WV7aL
	1YBXxEmVxkgLSRuDBAHJaLxgSiLZLaJnVkpGu5dQhtjyf6p1qNDPILhjQSheS5NKrzzx7l
	dDyRGbowj2IC4o4HToknnJTHAE3gvN4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708073138;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=403rjhUhkgmIPcGE1ndabC2ltuIaZcgjrlVJxlVXY2M=;
	b=NhqBmSZ55PzV4PerbMnRZut8OC5BKdjB4w4Kow6P54+lTElllCb3qrCJWuhF8ImXwKs+QY
	3KagPhxIwNWjOgDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708073138; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=403rjhUhkgmIPcGE1ndabC2ltuIaZcgjrlVJxlVXY2M=;
	b=pnZF/Ej1irKm/Pjj1LY3waGtoPw9vua/7wmYPSY1EAB/35/fwhCTXdX0w5u3bX8v0WV7aL
	1YBXxEmVxkgLSRuDBAHJaLxgSiLZLaJnVkpGu5dQhtjyf6p1qNDPILhjQSheS5NKrzzx7l
	dDyRGbowj2IC4o4HToknnJTHAE3gvN4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708073138;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=403rjhUhkgmIPcGE1ndabC2ltuIaZcgjrlVJxlVXY2M=;
	b=NhqBmSZ55PzV4PerbMnRZut8OC5BKdjB4w4Kow6P54+lTElllCb3qrCJWuhF8ImXwKs+QY
	3KagPhxIwNWjOgDg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B326013343;
	Fri, 16 Feb 2024 08:45:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 8htVKrIgz2WVcwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Fri, 16 Feb 2024 08:45:38 +0000
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v0 0/6] nvme-fc: fix blktests nvme/041
Date: Fri, 16 Feb 2024 09:45:20 +0100
Message-ID: <20240216084526.14133-1-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="pnZF/Ej1";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NhqBmSZ5
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.51 / 50.00];
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
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -1.51
X-Rspamd-Queue-Id: C72D621FBE
X-Spam-Flag: NO

After the target side is working with blktests and blktest is also able
to deal with the FC transport, it's time to address the fallouts on the host
side. As first step, let's fix the failing nvme/041 tests.

As we arleady discussed, the main issue here is that FC transport is deferring
the connect attempt to a workqueue. The other fabric transport don't do this.
And all blktests expect that the 'nvme connect' call is synchronous.

Initially, I just added the completion and waited on connect to succeed or fail.
But this triggered a lot of UAFs. After banging my head on this problem for a
while I decided to replace the complete ref counting strategy.

With this new approach all execept nvme/048 are passing and no UAFs or other
troubles observed. I also tested with real hardware (lpfc, qla2xxx), though I
don't have a way to trigger all sorts of transport errors which would be
interesting to see if my patches are breaking anything. 

I think there is still on problem left in the module exit code path. The cleanup
function iterates over the ctrl list storred in the rport object. The delete
code path is not atomic and removes the controller from the list somewhere in
the delete path. Thus this races with the module unload, IMO. we could just
maintain a list of controllers which is protected a lock as we have in tcp/rdma.

Daniel Wagner (6):
  nvme-fabrics: introduce connect_sync option
  nvme-fc: rename free_ctrl callback to match name pattern
  nvme-fc: do not retry when auth fails or connection is refused
  nvme-fabrics: introduce ref counting for nvmf_ctrl_options
  nvme-fc: redesign locking and refcounting
  nvme-fc: wait for connect attempt to finish

 drivers/nvme/host/fabrics.c |  28 +++++-
 drivers/nvme/host/fabrics.h |   9 +-
 drivers/nvme/host/fc.c      | 180 ++++++++++++++++--------------------
 drivers/nvme/host/rdma.c    |  18 +++-
 drivers/nvme/host/tcp.c     |  21 +++--
 drivers/nvme/target/loop.c  |  19 ++--
 6 files changed, 150 insertions(+), 125 deletions(-)

-- 
2.43.0


