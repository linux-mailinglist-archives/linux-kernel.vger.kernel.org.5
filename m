Return-Path: <linux-kernel+bounces-93896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C4087367A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02B28284E83
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFBF84FC9;
	Wed,  6 Mar 2024 12:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aKwnTMXN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sWi4DkF+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aKwnTMXN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sWi4DkF+"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A09784A50
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 12:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709728269; cv=none; b=Qbv6z/XtjWueTqyB5KLbh3rkpKNHAkBEPY1nRBys3qTVSCqpW1l2W3Ue1sY21C/5bQHAzfftIy7b8ZJ8QSkECTktaPKhYc9PB/0nu8R0LdBp9IXJy367Wih2KSXNpbkaD/zLg2/6mJ7jTxdXiyoYNkwX19twRVkcHhjquZMPII8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709728269; c=relaxed/simple;
	bh=OJ5OQ/uhP1l4U1hoKnI8+v2ylqMuH5ZlTJlyOjBm2VQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eSVikoSMhjy98xsJLvkn7NmPKjwnR+JCuKyhXgT53CBJldWtc6UC1gNtlcRqWQk2Y+oYLz+oo0ywhOgAReLCf4xEtD+7+m1zTJ5Deb890J7G3DxuX3y435il64Po6Rv/MSe1CEABo/97iWkd7ih2aL0YKdBW7zVIwyiasxLUfX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aKwnTMXN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sWi4DkF+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aKwnTMXN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sWi4DkF+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 888F73F175;
	Wed,  6 Mar 2024 12:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709728265; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=7k1zCH7rJUyjn+pQMiSRznsRTbRsX0fOvgjrgBeV6A4=;
	b=aKwnTMXNgc9REm9yqZG4yA7xSay4ad6HAcMCKrWtKwCYNleez1FK92Qz6clVUOUpy9Jt0C
	Zs0r+XGUCLu1vS9vILHj+BsdBtKPlihx12HQXqiQbTBtupSQXh2BPvmI1Sa+SQDRMIVol/
	Yz5zqIWS/PWrDmwY5y+OAI5WNSZ3UZ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709728265;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=7k1zCH7rJUyjn+pQMiSRznsRTbRsX0fOvgjrgBeV6A4=;
	b=sWi4DkF+w0Aacvtstg/Auv+UtdStARm08STTABEHlxz3u3VQnQD+OtCKqbYfjhYR1VRioB
	UmkzZO5c1JDPpMCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709728265; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=7k1zCH7rJUyjn+pQMiSRznsRTbRsX0fOvgjrgBeV6A4=;
	b=aKwnTMXNgc9REm9yqZG4yA7xSay4ad6HAcMCKrWtKwCYNleez1FK92Qz6clVUOUpy9Jt0C
	Zs0r+XGUCLu1vS9vILHj+BsdBtKPlihx12HQXqiQbTBtupSQXh2BPvmI1Sa+SQDRMIVol/
	Yz5zqIWS/PWrDmwY5y+OAI5WNSZ3UZ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709728265;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=7k1zCH7rJUyjn+pQMiSRznsRTbRsX0fOvgjrgBeV6A4=;
	b=sWi4DkF+w0Aacvtstg/Auv+UtdStARm08STTABEHlxz3u3VQnQD+OtCKqbYfjhYR1VRioB
	UmkzZO5c1JDPpMCA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id EFD411377D;
	Wed,  6 Mar 2024 12:31:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id PbCJNwhi6GUaTwAAn2gu4w
	(envelope-from <osalvador@suse.de>); Wed, 06 Mar 2024 12:31:04 +0000
From: Oscar Salvador <osalvador@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Michal Hocko <mhocko@suse.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Oscar Salvador <osalvador@suse.de>
Subject: [PATCH 0/2] page_owner: Fixup and cleanup
Date: Wed,  6 Mar 2024 13:32:15 +0100
Message-ID: <20240306123217.29774-1-osalvador@suse.de>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=aKwnTMXN;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=sWi4DkF+
X-Spamd-Result: default: False [1.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,suse.com,suse.cz,google.com,gmail.com,suse.de];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.88)[85.73%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 1.81
X-Rspamd-Queue-Id: 888F73F175
X-Spam-Level: *
X-Spam-Flag: NO
X-Spamd-Bar: +

Hi,

this patchset consists of a fixup by an error that was reported by intel
robot, where it seems to be that by the time page_owner gets
initialized, stackdepot has already depleted its allocation space and
returns 0-handles, turning that into null stack_records when trying
to retrieve the stack_record.
I was not able to reproduce that from the config because it booted fine
for me, but when setting e.g: dummy_handle to 0 artificially,
I could see the same error that was reported.

The second patch is a cleanup that can also lead to a compilation
warning.

Oscar Salvador (2):
  mm,page_owner: Check for null stack_record before bumping its refcount
  mm,page_owner: Drop unnecesary check

 mm/page_owner.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

-- 
2.44.0


