Return-Path: <linux-kernel+bounces-76393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8392785F69C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C85D1C227DA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF0B45BEF;
	Thu, 22 Feb 2024 11:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="plA23eWb";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="plA23eWb"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9B2405F4
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 11:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708600615; cv=none; b=Ea4SMQgQ6lUeWZVH72ljCijc+X53ef2BzJWiKfnXJnDFHyuZow15YZWb2zWlA+P1Bn9QO9rjsPG2WCU2xVmoHymUA1CE66tVzmNxy0zgTraQncdCzVnrsSZL27fEU+BVwDGxgmVaxBVTqNxwH1Jr3W4xsrE979yAJ5IDCRKSDZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708600615; c=relaxed/simple;
	bh=wIBGGeIaNfSeyrkvzBZ1D01uQ3bxKni4qhhnuwVG9eg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PqeYt6JkvLdS5bhYv+WUyQx0HCNBCrvx/dbiRftbQIHeGhSfY+D9QTis+QxVaG125Q7SZaWNTeX8EINYdLkthnsLUL19cJ2wtvEEOnlxTr+0+rGWkr43Y+5t4lZ59GmwQxiJBzW+2xEe8Ke9mPFQsl9Ud4jwNcznc59xZyts9xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=plA23eWb; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=plA23eWb; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9CF52222CA;
	Thu, 22 Feb 2024 11:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708600610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5/YD9GWMk8p3PrUPaDfQKLAsZ5U02sG/PlLxn+IalyI=;
	b=plA23eWbwnmO0t1WdETuN6PXwZFwUFhm6Lil7pnbcZIBhhg3g/81arlXExOwvblMn9LPFe
	g2oDp+cuiM5JyIZIn6t/jEuPj5KpAtvb/56Jc+gf3EU4KtntSEJpwf0eoHVamodKKwXZPm
	ySfutLg+dAx4U+vw4ksQlexVgwQfuNo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708600610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5/YD9GWMk8p3PrUPaDfQKLAsZ5U02sG/PlLxn+IalyI=;
	b=plA23eWbwnmO0t1WdETuN6PXwZFwUFhm6Lil7pnbcZIBhhg3g/81arlXExOwvblMn9LPFe
	g2oDp+cuiM5JyIZIn6t/jEuPj5KpAtvb/56Jc+gf3EU4KtntSEJpwf0eoHVamodKKwXZPm
	ySfutLg+dAx4U+vw4ksQlexVgwQfuNo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5178913A8C;
	Thu, 22 Feb 2024 11:16:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2PmjESIt12VrGgAAD6G6ig
	(envelope-from <nik.borisov@suse.com>); Thu, 22 Feb 2024 11:16:50 +0000
From: Nikolay Borisov <nik.borisov@suse.com>
To: bp@alien8.de
Cc: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH 2/2] x86/insn: Directly assign x86_64 state in init_ins
Date: Thu, 22 Feb 2024 13:16:36 +0200
Message-Id: <20240222111636.2214523-3-nik.borisov@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222111636.2214523-1-nik.borisov@suse.com>
References: <20240222111636.2214523-1-nik.borisov@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [5.87 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_SPAM(4.97)[99.67%];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Level: *****
X-Spam-Score: 5.87
X-Spam-Flag: NO

No point in checking again as this was already done by the caller.

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
---
 arch/x86/lib/insn.c       | 2 +-
 tools/arch/x86/lib/insn.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/lib/insn.c b/arch/x86/lib/insn.c
index 3946bdc75087..1bb155a0955b 100644
--- a/arch/x86/lib/insn.c
+++ b/arch/x86/lib/insn.c
@@ -71,7 +71,7 @@ void insn_init(struct insn *insn, const void *kaddr, int buf_len, int x86_64)
 	insn->kaddr = kaddr;
 	insn->end_kaddr = kaddr + buf_len;
 	insn->next_byte = kaddr;
-	insn->x86_64 = x86_64 ? 1 : 0;
+	insn->x86_64 = x86_64;
 	insn->opnd_bytes = 4;
 	if (x86_64)
 		insn->addr_bytes = 8;
diff --git a/tools/arch/x86/lib/insn.c b/tools/arch/x86/lib/insn.c
index 5d81924478d9..ada4b4a79dd4 100644
--- a/tools/arch/x86/lib/insn.c
+++ b/tools/arch/x86/lib/insn.c
@@ -71,7 +71,7 @@ void insn_init(struct insn *insn, const void *kaddr, int buf_len, int x86_64)
 	insn->kaddr = kaddr;
 	insn->end_kaddr = kaddr + buf_len;
 	insn->next_byte = kaddr;
-	insn->x86_64 = x86_64 ? 1 : 0;
+	insn->x86_64 = x86_64;
 	insn->opnd_bytes = 4;
 	if (x86_64)
 		insn->addr_bytes = 8;
-- 
2.34.1


