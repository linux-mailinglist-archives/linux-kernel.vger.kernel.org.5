Return-Path: <linux-kernel+bounces-10614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5825B81D76B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 01:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED37EB21CCA
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 00:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1351366;
	Sun, 24 Dec 2023 00:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AilYrcRY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VQjviSH5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AilYrcRY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VQjviSH5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B37B10E8;
	Sun, 24 Dec 2023 00:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7751021CD8;
	Sun, 24 Dec 2023 00:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703377976; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M/d6jhLWIAoafyZMIbU7FyHZ5o1LeCN0mHS2QimSYDY=;
	b=AilYrcRYOHo7HnTp96YKlhRGRte5ApMzUN3rk0J07PpvmQJS6FCNQbZX5/LM4IHAluVZbN
	+aMtqA5cT9nvlc0rbiGf5yJFgFpSFUKh6N8xRx7tiXF8hL8X48H8GS+aELVzc5z0GzbA0S
	xTcdi/uxxOCZZIoG/jvENsl0qEpC11Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703377976;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M/d6jhLWIAoafyZMIbU7FyHZ5o1LeCN0mHS2QimSYDY=;
	b=VQjviSH5KURZfCachlhBP+FqWv7iT9CFthS4cjmyk4lhTliGNFrbx4SdVPqlWSWOxioGKQ
	LO57/xCdKxGfYpAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703377976; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M/d6jhLWIAoafyZMIbU7FyHZ5o1LeCN0mHS2QimSYDY=;
	b=AilYrcRYOHo7HnTp96YKlhRGRte5ApMzUN3rk0J07PpvmQJS6FCNQbZX5/LM4IHAluVZbN
	+aMtqA5cT9nvlc0rbiGf5yJFgFpSFUKh6N8xRx7tiXF8hL8X48H8GS+aELVzc5z0GzbA0S
	xTcdi/uxxOCZZIoG/jvENsl0qEpC11Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703377976;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M/d6jhLWIAoafyZMIbU7FyHZ5o1LeCN0mHS2QimSYDY=;
	b=VQjviSH5KURZfCachlhBP+FqWv7iT9CFthS4cjmyk4lhTliGNFrbx4SdVPqlWSWOxioGKQ
	LO57/xCdKxGfYpAw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id AF25D13902;
	Sun, 24 Dec 2023 00:32:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id MRmtFzR8h2X6fgAAn2gu4w
	(envelope-from <colyli@suse.de>); Sun, 24 Dec 2023 00:32:52 +0000
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH] badblocks: avoid checking invalid range in
 badblocks_check()
From: Coly Li <colyli@suse.de>
In-Reply-To: <20231224002820.20234-1-colyli@suse.de>
Date: Sun, 24 Dec 2023 08:32:35 +0800
Cc: nvdimm@lists.linux.dev,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Block Devices <linux-block@vger.kernel.org>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Geliang Tang <geliang.tang@suse.com>,
 Hannes Reinecke <hare@suse.de>,
 NeilBrown <neilb@suse.de>,
 Vishal L Verma <vishal.l.verma@intel.com>,
 Xiao Ni <xni@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A110805F-3448-4A87-AE70-F94A394EA826@suse.de>
References: <20231224002820.20234-1-colyli@suse.de>
To: Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3774.300.61.1.2)
X-Spam-Level: 
X-Spam-Level: 
X-Spamd-Result: default: False [-0.47 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.87)[85.65%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 MV_CASE(0.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,suse.com:email,kernel.dk:email,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -0.47
X-Spam-Flag: NO



> 2023=E5=B9=B412=E6=9C=8824=E6=97=A5 08:28=EF=BC=8CColy Li =
<colyli@suse.de> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> If prev_badblocks() returns '-1', it means no valid badblocks record
> before the checking range. It doesn't make sense to check whether
> the input checking range is overlapped with the non-existed invalid
> front range.
>=20
> This patch checkes whether 'prev >=3D 0' is true before calling
> overlap_front(), to void such invalid operations.
>=20
> Fixes: 3ea3354cb9f0 ("badblocks: improve badblocks_check() for =
multiple ranges handling")
> Reported-and-tested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Coly Li <colyli@suse.de>
> Link: =
https://lore.kernel.org/nvdimm/3035e75a-9be0-4bc3-8d4a-6e52c207f277@leemhu=
is.info/
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Geliang Tang <geliang.tang@suse.com>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: NeilBrown <neilb@suse.de>
> Cc: Vishal L Verma <vishal.l.verma@intel.com>
> Cc: Xiao Ni <xni@redhat.com>
> ---
> block/badblocks.c | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)

Hi Jens,

Is it possible to take this fix into 6.7 still? Thanks in advance.

Coly Li


[snipped]


