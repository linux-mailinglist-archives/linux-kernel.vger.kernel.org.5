Return-Path: <linux-kernel+bounces-28954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D6283051F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 13:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A234B212F1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896441DFE8;
	Wed, 17 Jan 2024 12:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cxeRzz1p";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jVUZ15yk";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cxeRzz1p";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jVUZ15yk"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E6F1E89D;
	Wed, 17 Jan 2024 12:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705494211; cv=none; b=U88HFfRm8vwLcYQAH/tIcGQkgRiHiW02T5On+bC0kKcb5fVKHjytfnGClycr5f0Eg9j29OEuyCz+5udEKei9PHccVW+sQq+lCQuPaD4Rer3kOPXHfYQaPcCZH8EYsw6Fw/naErc179CrHeV2zk9PjcNE+mKrQ75iA3E6H3aHzmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705494211; c=relaxed/simple;
	bh=Uihxw91v6Hf2KMjiixiJuIJGsDzSTmIKEICPHaC3EO4=;
	h=Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Spam-Level:X-Spamd-Bar:X-Rspamd-Server:X-Spamd-Result:
	 X-Spam-Score:X-Rspamd-Queue-Id:X-Spam-Flag; b=S3nY02hLrCVPrLrKVbvMC0teMYSof4vnB9gRGcf4q6Ryf5wQjg338lK1n4lz+9RI9dxBLqZx+IA8IiI4wsoox1EgHk1MxP63u1Ohie9I8iLsoe0LZ2FYEuLWMeKgm+eHKQDMHNdbyIVwVrB/N2/YJ67o5ELY5ENdy15mFC3LX8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cxeRzz1p; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jVUZ15yk; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cxeRzz1p; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jVUZ15yk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 42DF91FC0B;
	Wed, 17 Jan 2024 12:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705494208; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wBFi5EOSqhi2GZ/s3YhGCxOR9Jei6qFUO/vhKFfgYy8=;
	b=cxeRzz1p6DSQWW+0tfZehSvcSaRcEU2JsJGYthlX6CCD3b85jIF5LotbFWoToykvZEwP0M
	9T1RnyL9nh0C7hd3kDwbQL+5Rte5/1wY1LDsvAVICCsJd6dIN1yz39ltmJFMNuocCNxv7t
	RTaX+o10YFoaclDiQ+dVM1tgMSic/vg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705494208;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wBFi5EOSqhi2GZ/s3YhGCxOR9Jei6qFUO/vhKFfgYy8=;
	b=jVUZ15ykWc7NZTMTzU8bmrbtzdqqm7X/T5NsPA2IzZ+OvR8JWqwZG1Q0st815seu9lczPy
	zu9GBLYBRyQ0faBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705494208; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wBFi5EOSqhi2GZ/s3YhGCxOR9Jei6qFUO/vhKFfgYy8=;
	b=cxeRzz1p6DSQWW+0tfZehSvcSaRcEU2JsJGYthlX6CCD3b85jIF5LotbFWoToykvZEwP0M
	9T1RnyL9nh0C7hd3kDwbQL+5Rte5/1wY1LDsvAVICCsJd6dIN1yz39ltmJFMNuocCNxv7t
	RTaX+o10YFoaclDiQ+dVM1tgMSic/vg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705494208;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wBFi5EOSqhi2GZ/s3YhGCxOR9Jei6qFUO/vhKFfgYy8=;
	b=jVUZ15ykWc7NZTMTzU8bmrbtzdqqm7X/T5NsPA2IzZ+OvR8JWqwZG1Q0st815seu9lczPy
	zu9GBLYBRyQ0faBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 07DB513800;
	Wed, 17 Jan 2024 12:23:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KDxkAMDGp2WSVwAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Wed, 17 Jan 2024 12:23:28 +0000
From: Petr Vorel <pvorel@suse.cz>
To: linux-man@vger.kernel.org
Cc: Petr Vorel <pvorel@suse.cz>,
	Alejandro Colomar <alx@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] MAINTAINERS: Add man-pages git trees
Date: Wed, 17 Jan 2024 13:22:57 +0100
Message-ID: <20240117122257.2707637-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: ***
X-Spamd-Bar: +++
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=cxeRzz1p;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=jVUZ15yk
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [3.49 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[24.71%]
X-Spam-Score: 3.49
X-Rspamd-Queue-Id: 42DF91FC0B
X-Spam-Flag: NO

The maintainer uses both.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v1->v2:
* Add a second tree

 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 391bbb855cbe..3f6a19f3e5e0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12833,6 +12833,8 @@ M:	Alejandro Colomar <alx@kernel.org>
 L:	linux-man@vger.kernel.org
 S:	Maintained
 W:	http://www.kernel.org/doc/man-pages
+T:	git git://git.kernel.org/pub/scm/docs/man-pages/man-pages.git
+T:	git git://www.alejandro-colomar.es/src/alx/linux/man-pages/man-pages.git
 
 MANAGEMENT COMPONENT TRANSPORT PROTOCOL (MCTP)
 M:	Jeremy Kerr <jk@codeconstruct.com.au>
-- 
2.43.0


