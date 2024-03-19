Return-Path: <linux-kernel+bounces-108017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF8C8804D9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1A76B210BE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14C637708;
	Tue, 19 Mar 2024 18:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="caaEPWcP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iJtQjLGu";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="caaEPWcP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iJtQjLGu"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D52816
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 18:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710873057; cv=none; b=DYRM7WrLp7ckADLSxcYe0fW5rke4jl5MQ0dFHKsuFeJvg9fcNrk3ZwfwOPK2FfGtnHrmJE5bGNyhQn1octUlVR1xqfNKLN4VSGWrd9vqVOupo5ldu20zLp4rSMK4LrQia4VH0NADqOUjiSBUs8dk0RO7ChIbfmataoKWS46ixeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710873057; c=relaxed/simple;
	bh=OFc3Ox3ona3FpnPw9rQ0qg8ayScMwGveBKX3M9QwClk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FCx60XGjumnU0ZdKq6FU2K6SdNFh6xavddlvRY6HeC9ktwOfPbMJzFoc9HuvVPanSASZLTC5TlA/UvVupbKUi/34ACfGj7pjysoZoMjYrPP7Y5V5ULcnw4NVQSNaqoJh35GDqTttsH/ajRZNDPrlaAqt8uC72QEix0IG4ZGT1hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=caaEPWcP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iJtQjLGu; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=caaEPWcP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iJtQjLGu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4B54E21E7A;
	Tue, 19 Mar 2024 18:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710873053; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0Rw2uEgVepVXkvdzA8HFqFNjKTu2AlQBuAZXsdS6Koc=;
	b=caaEPWcPP1oryvPK0V0xBCqMnpJzIGO0JeZT6ATEWoaz+MOCNStaGHtvuOR3w6lw3dcEDn
	/HHDGhZZyVR5GU4YjQ8WHo11Q6CRMrDeIKV5S0hNJ2DaRRDHHgcAaaAFcIqR7zvBbCB6ih
	I6pajdlP5X62XsGduozbhEjmn2GuMqc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710873053;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0Rw2uEgVepVXkvdzA8HFqFNjKTu2AlQBuAZXsdS6Koc=;
	b=iJtQjLGuKQjcC3jWZ5ixi8Gi4+sHrQfMzZVrejrwK/aiqPRMPv5zGGMAWVn4MKq++A7Z/R
	b7ijVR0yLoR8UIBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710873053; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0Rw2uEgVepVXkvdzA8HFqFNjKTu2AlQBuAZXsdS6Koc=;
	b=caaEPWcPP1oryvPK0V0xBCqMnpJzIGO0JeZT6ATEWoaz+MOCNStaGHtvuOR3w6lw3dcEDn
	/HHDGhZZyVR5GU4YjQ8WHo11Q6CRMrDeIKV5S0hNJ2DaRRDHHgcAaaAFcIqR7zvBbCB6ih
	I6pajdlP5X62XsGduozbhEjmn2GuMqc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710873053;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0Rw2uEgVepVXkvdzA8HFqFNjKTu2AlQBuAZXsdS6Koc=;
	b=iJtQjLGuKQjcC3jWZ5ixi8Gi4+sHrQfMzZVrejrwK/aiqPRMPv5zGGMAWVn4MKq++A7Z/R
	b7ijVR0yLoR8UIBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A2FC6136D6;
	Tue, 19 Mar 2024 18:30:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CI/7JNzZ+WUcTwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 19 Mar 2024 18:30:52 +0000
From: Oscar Salvador <osalvador@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Michal Hocko <mhocko@suse.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2 0/2] page_owner: Refcount fixups
Date: Tue, 19 Mar 2024 19:32:10 +0100
Message-ID: <20240319183212.17156-1-osalvador@suse.de>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: 2.18
X-Spam-Flag: NO
X-Spamd-Bar: ++
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=caaEPWcP;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=iJtQjLGu
X-Spamd-Result: default: False [2.18 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 DKIM_TRACE(0.00)[suse.de:+];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 MX_GOOD(-0.01)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-1.31)[90.13%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,suse.com,suse.cz,google.com,gmail.com,i-love.sakura.ne.jp,suse.de];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Level: **
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4B54E21E7A

A couple of fixups for the refcounting part.
From this series on, instead of counting the stacks, we count the outstanding
nr_base_pages each stack has, which gives a much better memory overview.

The other fixup is for the migration part.
A more detailed explanation can be found in the changelog of respective patches.

Oscar Salvador (2):
  mm,page_owner: Fix refcount imbalance
  mm,page_owner: Fix accounting of pages when migrating

 Documentation/mm/page_owner.rst | 73 +++++++++++++++++----------------
 mm/page_owner.c                 | 51 +++++++++++++----------
 2 files changed, 68 insertions(+), 56 deletions(-)

-- 
2.44.0


