Return-Path: <linux-kernel+bounces-118409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 555A688BA68
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 07:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A031B2243D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 06:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760DC130499;
	Tue, 26 Mar 2024 06:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fqJ8EWqW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="A5M3s/dW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fqJ8EWqW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="A5M3s/dW"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A3074BEB
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 06:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711434555; cv=none; b=ZC/0jP0BBYULzChNOCjCUw/7f1G4FjBQQ1HIGXTdonNY6nqiP1DgO9CQhWjJbGXE9PEDxVKFSv6lFFeySIfRXCXqPevlGYOxyEEo+duJ/fIP5HN5tJf7u2guffCOSr12P8x+qpSvCky4U8JrjFN33GoB1He0DHlrWKjODmfBqHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711434555; c=relaxed/simple;
	bh=X3DtID22MHLiOSEgufzjJEVz5dkjcxPNV3/gFfp+uKU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tl4US4xNDd+D3T7WXSUjA1Uqqk6jqnmLt46GZ/gAbhe0tvjLcKYdQ84JRf0TL1yglFJ8FjlM0hsKVWrg6VcDX6fIFQwmd/OOhznrPP6GUR33d3DNuG5RaHjfTU1ORkBDHhpYEkkHF3ts06sMdXMazlzq+/xKqzDTWwsmHxbLFLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fqJ8EWqW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=A5M3s/dW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fqJ8EWqW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=A5M3s/dW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A30205D1CE;
	Tue, 26 Mar 2024 06:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711434551; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=7DbD7neTBtkVj5P37sm9WRAjkZnH4d5JwCZylV5kafQ=;
	b=fqJ8EWqWij0dR5Wai3crdsBjXjDkUlSvf/c679i04CZp/QAwqlVh5r8tFNvHKBdPeVwfwx
	GlO7sC5UybTaclhIfQPvQS7qWngZ63tBGM+VgeYikPi5H4B46b2tx45QlcJih/gm6Us8EX
	hj+8HS2enVIrOcCDJI0B1yTp7au/aD8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711434551;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=7DbD7neTBtkVj5P37sm9WRAjkZnH4d5JwCZylV5kafQ=;
	b=A5M3s/dWcBp4glOZoqnQnmLFq5EbYBMBUYOc/vbRsyzfdx0guUDHVdAC1tPSPiZP2AroAu
	sRw0KxghenkiDNCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711434551; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=7DbD7neTBtkVj5P37sm9WRAjkZnH4d5JwCZylV5kafQ=;
	b=fqJ8EWqWij0dR5Wai3crdsBjXjDkUlSvf/c679i04CZp/QAwqlVh5r8tFNvHKBdPeVwfwx
	GlO7sC5UybTaclhIfQPvQS7qWngZ63tBGM+VgeYikPi5H4B46b2tx45QlcJih/gm6Us8EX
	hj+8HS2enVIrOcCDJI0B1yTp7au/aD8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711434551;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=7DbD7neTBtkVj5P37sm9WRAjkZnH4d5JwCZylV5kafQ=;
	b=A5M3s/dWcBp4glOZoqnQnmLFq5EbYBMBUYOc/vbRsyzfdx0guUDHVdAC1tPSPiZP2AroAu
	sRw0KxghenkiDNCA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 19C7113215;
	Tue, 26 Mar 2024 06:29:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id CiV8AzdrAmY2YQAAn2gu4w
	(envelope-from <osalvador@suse.de>); Tue, 26 Mar 2024 06:29:11 +0000
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
Subject: [PATCH v3 0/3] page_owner: Fix refcount imbalance
Date: Tue, 26 Mar 2024 07:30:33 +0100
Message-ID: <20240326063036.6242-1-osalvador@suse.de>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: 3.61
X-Spamd-Result: default: False [3.61 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,suse.com,suse.cz,google.com,gmail.com,suse.de];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.09)[64.13%]
X-Spam-Level: ***
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Flag: NO

This series consists of a refactoring/correctness of updating the metadata
of tail pages and a couple of fixups for the refcounting part.

From this series on, instead of counting the stacks, we count the outstanding
nr_base_pages each stack has, which gives us a much better memory overview.
The other fixup is for the migration part.

A more detailed explanation can be found in the changelog of the respective
patches.

Oscar Salvador (3):
  mm,page_owner: Update metada for tail pages
  mm,page_owner: Fix refcount imbalance
  mm,page_owner: Fix accounting of pages when migrating

 Documentation/mm/page_owner.rst |  73 +++++++------
 mm/page_owner.c                 | 184 +++++++++++++++++++-------------
 2 files changed, 146 insertions(+), 111 deletions(-)

-- 
2.44.0


