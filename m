Return-Path: <linux-kernel+bounces-28708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F394683021C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 866FFB24C87
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6915E156C2;
	Wed, 17 Jan 2024 09:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2VBgIJEX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="u9Mdj/ca";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2VBgIJEX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="u9Mdj/ca"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA2C14AA8;
	Wed, 17 Jan 2024 09:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705483163; cv=none; b=SOLFMVqCNx7UvW9JhK97TmOC5+egmC+ESsEDD4Nhet3aZTE76BOkTer27vqNIDUk3eWa+ms4Ob+ykEWRiEHuPM3TptGQ/5d7lj9zFa0P5Hl44RGrDP8S0RrRDD4u5OyYojq52NbVX+Vg0rDCGaNcFShkSok0RZzBiXLX8HmPW78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705483163; c=relaxed/simple;
	bh=/a8d5veHen93j06zrGpx2Q/1hcho+kujtGmSOukuzO0=;
	h=Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Spamd-Result:X-Spam-Level:X-Spam-Score:X-Spam-Flag; b=ptCHO37CgNylvveAjqoVJtiYfofPZM2Jm5+46vuXoYfg0eHARzY+k6Q4a0YAfJaHOYW4ArpKXOsatRDU3qRSjyhtCvBeSNGXDMoRcWUrKJZcHaDWTwEpOwGgFBfFR9x6vOiz9jXwulhvbbytnavl0KJn3DEmhprfIieX4X/9kSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2VBgIJEX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=u9Mdj/ca; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2VBgIJEX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=u9Mdj/ca; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 53B051FBF2;
	Wed, 17 Jan 2024 09:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705483159; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=mnj/Pdp8IYPJF9+R0id9z6QYVCNsmTtfyZHzeTEz3FI=;
	b=2VBgIJEXI3BCBQbJR61VtKOV3Gnv6moq7fL24Mpchynl/l5Rx89Hr/fAYn/2UA0NWv3RHK
	ZlPt+mKk5ksFx4TnElvD/pNZgMOgnzU3SjoBYiXC7jRsL7OsZzIS9dHqfKwhE9C3gBlZbA
	uGv//m82AD8b0sl/vWpxo/MtjbDnsC0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705483159;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=mnj/Pdp8IYPJF9+R0id9z6QYVCNsmTtfyZHzeTEz3FI=;
	b=u9Mdj/caZIc/aB8879kxaMO9TST5FOtB9iYx5ogM9xwWBtZDUIIPONi7HfecLdalB9oB0Y
	e9tSIx7gr0HfjcBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705483159; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=mnj/Pdp8IYPJF9+R0id9z6QYVCNsmTtfyZHzeTEz3FI=;
	b=2VBgIJEXI3BCBQbJR61VtKOV3Gnv6moq7fL24Mpchynl/l5Rx89Hr/fAYn/2UA0NWv3RHK
	ZlPt+mKk5ksFx4TnElvD/pNZgMOgnzU3SjoBYiXC7jRsL7OsZzIS9dHqfKwhE9C3gBlZbA
	uGv//m82AD8b0sl/vWpxo/MtjbDnsC0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705483159;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=mnj/Pdp8IYPJF9+R0id9z6QYVCNsmTtfyZHzeTEz3FI=;
	b=u9Mdj/caZIc/aB8879kxaMO9TST5FOtB9iYx5ogM9xwWBtZDUIIPONi7HfecLdalB9oB0Y
	e9tSIx7gr0HfjcBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E588A137EB;
	Wed, 17 Jan 2024 09:19:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lfWzNZabp2VaGAAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Wed, 17 Jan 2024 09:19:18 +0000
From: Petr Vorel <pvorel@suse.cz>
To: linux-man@vger.kernel.org
Cc: Petr Vorel <pvorel@suse.cz>,
	Alejandro Colomar <alx@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] MAINTAINERS: Add man-pages git tree
Date: Wed, 17 Jan 2024 10:19:03 +0100
Message-ID: <20240117091903.2668916-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [4.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[38.40%]
X-Spam-Level: ****
X-Spam-Score: 4.90
X-Spam-Flag: NO

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 391bbb855cbe..571749fe9e38 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12833,6 +12833,7 @@ M:	Alejandro Colomar <alx@kernel.org>
 L:	linux-man@vger.kernel.org
 S:	Maintained
 W:	http://www.kernel.org/doc/man-pages
+T:	git git://git.kernel.org/pub/scm/docs/man-pages/man-pages.git
 
 MANAGEMENT COMPONENT TRANSPORT PROTOCOL (MCTP)
 M:	Jeremy Kerr <jk@codeconstruct.com.au>
-- 
2.43.0


