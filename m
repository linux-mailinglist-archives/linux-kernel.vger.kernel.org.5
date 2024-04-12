Return-Path: <linux-kernel+bounces-142902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0968A31DB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C75FA1F21472
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81F6147C7D;
	Fri, 12 Apr 2024 15:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lcUEwq41";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lcUEwq41"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBFF13CFB7
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 15:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712934787; cv=none; b=OsT7czQKBjUCaxup5/lF4zPz+pV40P2CA9NgoSE4dw/aQFwOuUfR4PpRVy6anp9HFenBayMOgD84QzQoRQdbgAxxFibwtwCJn6acA9i0YyninHZ8202eJAh5OoYx5hLE3LHoII9lEHE9YVxNDjpZ1z2TPIg0Th7EN+zYEs3V4+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712934787; c=relaxed/simple;
	bh=ySAB3km1TxG4xulcUuc2jfgIAWhWYY69TDvjrLBNEBM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pErEIKcwiekD5AmryEemprwYwFx/B9GjgzhhKNnkOvnMXmDJ7VKeqsVYz1UDPcgULNojmSkzMFSoen6S8TmXgIFlaswGsnmGwKY5a34tsF5gxvRh6sZSQLSrO8CWnn4jXLgjynNV51ZCva9um6mGcCNZeHbnkxTTtYDR024U4Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lcUEwq41; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lcUEwq41; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 73927383EA;
	Fri, 12 Apr 2024 15:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712934783; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ucDB1ckO4elt768cHBdZSn7izJ4VBv6RB34AFX4fxL8=;
	b=lcUEwq41HXQ+4g3fH5pmXcpxp5yCeEJyZQELcj5ojDJdajE2waXmB0tZhdtvytt7PXimS7
	9M5l5wMhLsxhL47bGEvRtK4oFJPgeHAWZGdH696NV4yY/exhn97DYB652slQBRpWl7fZBx
	tzMK59GtBDJeGJJhrCADz5Zf3iCHh3E=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=lcUEwq41
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712934783; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ucDB1ckO4elt768cHBdZSn7izJ4VBv6RB34AFX4fxL8=;
	b=lcUEwq41HXQ+4g3fH5pmXcpxp5yCeEJyZQELcj5ojDJdajE2waXmB0tZhdtvytt7PXimS7
	9M5l5wMhLsxhL47bGEvRtK4oFJPgeHAWZGdH696NV4yY/exhn97DYB652slQBRpWl7fZBx
	tzMK59GtBDJeGJJhrCADz5Zf3iCHh3E=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D0FEE1368B;
	Fri, 12 Apr 2024 15:13:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /uJHLn1PGWaWAQAAD6G6ig
	(envelope-from <jgross@suse.com>); Fri, 12 Apr 2024 15:13:01 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 0/4] x86: correctly handle NX and RW bit testing
Date: Fri, 12 Apr 2024 17:12:54 +0200
Message-Id: <20240412151258.9171-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -1.65
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 73927383EA
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.65 / 50.00];
	BAYES_HAM(-1.64)[92.69%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]

When the processor is detecting a set NX bit on any page table level
when doing a page table walk, the resulting page will not be suitable
for code execution.

A similar approach is taken for the RW bit: all page table levels need
to have the RW bit set in order to result in a writable page.

Unfortunately the kernel is only looking at the leaf page table entry
for deciding whether e.g. a writable page is executable or not.

Fix that by calculating the effective NX and RW bits over all page
table levels when doing a software address lookup, mimicking the
hardware behavior.

Changes in V2:
- split the patch into multiple patches

Juergen Gross (4):
  x86/pat: introduce lookup_address_in_pgd_attr()
  x86/mm: use lookup_address_in_pgd_attr() in show_fault_oops()
  x86/pat: restructure _lookup_address_cpa()
  x86/pat: fix W^X violation false-positives when running as Xen PV
    guest

 arch/x86/include/asm/pgtable_types.h |  2 +
 arch/x86/mm/fault.c                  |  7 +--
 arch/x86/mm/pat/set_memory.c         | 68 ++++++++++++++++++++++------
 3 files changed, 60 insertions(+), 17 deletions(-)

-- 
2.35.3


