Return-Path: <linux-kernel+bounces-131635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD04898A4B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23BA31F2211A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9EC1BDC4;
	Thu,  4 Apr 2024 14:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vuS/JLAD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="75MSEi25";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vuS/JLAD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="75MSEi25"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E99018654
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 14:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712241701; cv=none; b=NgSUbH9bp4yQiijdNOk4+h2hUUDn2cLiOcmgnd+weLwnRMZh4WD4EgxSQRgtlS83kH8ODIndx1qkmczfHT8DTEORGpfSvwev+zO6GWrWUODRpoRIBOgQIih0BFQPZK3+unnvD9QRVk9BSKLlo6oGTmAOUvJkC4IpnmsJe36Kje0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712241701; c=relaxed/simple;
	bh=+/jnidH3pJiKU6Rgmwg/jUU6rOho6mvv0PbLacIL6ys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aIeP1yf+oOrbyqgAlv89v1Ms3McKM8cmtphyUIfz+R0tQiyPT7KV8EAvXkVUJ1NAjS/mBlD7ZlQVIciIkUnYRAZ36s6zCxPqSjvWXAWmjWokueuwcRvf3M790Rj6XrgjE2F3lmRobTG8dUEIxW/HKKhQgE5HOP290Nxi6KKIeVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vuS/JLAD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=75MSEi25; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vuS/JLAD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=75MSEi25; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 50AFF5F804;
	Thu,  4 Apr 2024 14:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712241697; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=jx+Z6u7CMBxXJn4u8BfxCYjEhAj4yGi0JtxFz9G1eOs=;
	b=vuS/JLAD/Nx9ZCXZizupAiRGETXWU6gNFkIZlQ+ckepX8OeN7FzysxM80h7tS1kXGjA9W7
	uPrK8kiyiMtvtgWP874f5nM5i1ffeKVRv4t4Auk207lkvAl4mQ+ocVETRq2YjmA4l+6jzT
	T0dxl3jW9Kjbjcf0nXPR/U9rtJ0AT5s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712241697;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=jx+Z6u7CMBxXJn4u8BfxCYjEhAj4yGi0JtxFz9G1eOs=;
	b=75MSEi25yJ7fQczoNtdvibhiDCX/QX9IQ+YJm5obMUoaBeLHJFjUiZ3H/R5NLgrcR0tq61
	hurafUUijdS6xHCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="vuS/JLAD";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=75MSEi25
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712241697; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=jx+Z6u7CMBxXJn4u8BfxCYjEhAj4yGi0JtxFz9G1eOs=;
	b=vuS/JLAD/Nx9ZCXZizupAiRGETXWU6gNFkIZlQ+ckepX8OeN7FzysxM80h7tS1kXGjA9W7
	uPrK8kiyiMtvtgWP874f5nM5i1ffeKVRv4t4Auk207lkvAl4mQ+ocVETRq2YjmA4l+6jzT
	T0dxl3jW9Kjbjcf0nXPR/U9rtJ0AT5s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712241697;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=jx+Z6u7CMBxXJn4u8BfxCYjEhAj4yGi0JtxFz9G1eOs=;
	b=75MSEi25yJ7fQczoNtdvibhiDCX/QX9IQ+YJm5obMUoaBeLHJFjUiZ3H/R5NLgrcR0tq61
	hurafUUijdS6xHCw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 317A613298;
	Thu,  4 Apr 2024 14:41:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id e0+QCiG8DmZmDQAAn2gu4w
	(envelope-from <dwagner@suse.de>); Thu, 04 Apr 2024 14:41:37 +0000
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v2 0/2] nvme(t)-fc: couple of fixes/cleanups
Date: Thu,  4 Apr 2024 16:41:29 +0200
Message-ID: <20240404144131.17988-1-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.02
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 50AFF5F804
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.02 / 50.00];
	BAYES_HAM(-2.01)[95.14%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns,suse.de:dkim];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]

Both patches are just a rebased to the current nvme-6.9 head.

Daniel Wagner (2):
  nvmet-fc: move RCU read lock to nvmet_fc_assoc_exists
  nvme-fc: rename free_ctrl callback to match name pattern

 drivers/nvme/host/fc.c   |  4 ++--
 drivers/nvme/target/fc.c | 17 ++++++++++-------
 2 files changed, 12 insertions(+), 9 deletions(-)

-- 
2.44.0


