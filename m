Return-Path: <linux-kernel+bounces-99476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CB38788FB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9BD91F21285
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316F754FB7;
	Mon, 11 Mar 2024 19:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MnpeOfjR";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MnpeOfjR"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A865E53E27
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 19:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710185873; cv=none; b=PZiTtv+swVr6CR1iVeDfM6pOyZF3Jr2pAiXnKBNTraMUPVY+BwtVMNLuH5aa7KfPWe9rMhBs0qh4TbLctqFr5Q5rlyxYas2ieBOJq5eLKp6q1JJuml+oEM+FmUHNwSZPy/8Oq8xroLPdcy10ayPWwEaMXIgZKwkc4eIEMgOcq3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710185873; c=relaxed/simple;
	bh=o05NxM7WZ81q6wAbtVKGEmLaegB5tbOJPwes8Lf1e94=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oM4Yv4ZBHz2dsgj+V4sE7T9PT8MW32Z9bPZPhlXuSghDVBkQJ8ZdFnpHNet/nNT07CqfIsJM552UG45WHg8FcyfAa6a0Oia6sDhT6Al18TlHGSci7/TlnQJciyzOHPgeSvWVXMiQz0LyyPxoE9IkBPOjMMobPZM6yMaZNbt5WpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MnpeOfjR; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MnpeOfjR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A25A35CACF;
	Mon, 11 Mar 2024 19:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710185868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=909brDHSnvKCvnxGbfXG4mQWSVR9gVM6+h3f/kHoAjc=;
	b=MnpeOfjRKbz6alYo3GrzstTggZToHeZ/cQfKy7xgIKBto382sVKk7BSfzMK3ZEjrpS3Ia3
	VlrSAVixDz5J6GkDqXVPM+o/VQ+D9fO98uUG520m7H1KihpHSxOWRIR/Cj4bkBuiBh9LWf
	fOHFl2ylLHjJRKqiZstafChk0VixHN8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710185868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=909brDHSnvKCvnxGbfXG4mQWSVR9gVM6+h3f/kHoAjc=;
	b=MnpeOfjRKbz6alYo3GrzstTggZToHeZ/cQfKy7xgIKBto382sVKk7BSfzMK3ZEjrpS3Ia3
	VlrSAVixDz5J6GkDqXVPM+o/VQ+D9fO98uUG520m7H1KihpHSxOWRIR/Cj4bkBuiBh9LWf
	fOHFl2ylLHjJRKqiZstafChk0VixHN8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9BA1A13695;
	Mon, 11 Mar 2024 19:37:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VbL8JYxd72VkUAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Mon, 11 Mar 2024 19:37:48 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] AFFS update for 6.9
Date: Mon, 11 Mar 2024 20:30:38 +0100
Message-ID: <cover.1710185320.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=MnpeOfjR
X-Spamd-Result: default: False [2.65 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 URIBL_BLOCKED(0.00)[suse.com:dkim];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_DN_SOME(0.00)[];
	 DWL_DNSWL_LOW(-1.00)[suse.com:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.04)[87.59%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Score: 2.65
X-Spam-Level: **
X-Rspamd-Queue-Id: A25A35CACF
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Hi,

please pull one change to AFFS that removes use of SLAB_MEM_SPREAD,
which is going to be removed from MM code. Thanks.

----------------------------------------------------------------
The following changes since commit d206a76d7d2726f3b096037f2079ce0bd3ba329b:

  Linux 6.8-rc6 (2024-02-25 15:46:06 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/affs-for-6.9

for you to fetch changes up to f7c79a40b575f2b6c156c8bee9a652401bf715b6:

  affs: remove SLAB_MEM_SPREAD flag usage (2024-02-26 11:36:28 +0100)

----------------------------------------------------------------
affs-for-6.9

----------------------------------------------------------------
Chengming Zhou (1):
      affs: remove SLAB_MEM_SPREAD flag usage

 fs/affs/super.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

