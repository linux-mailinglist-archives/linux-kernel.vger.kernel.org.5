Return-Path: <linux-kernel+bounces-10327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8628E81D2C8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 07:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A89C71C220CA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 06:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0207484;
	Sat, 23 Dec 2023 06:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dH9CZyN0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZTCk+Bi9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dH9CZyN0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZTCk+Bi9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC7663A0;
	Sat, 23 Dec 2023 06:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6DC751F385;
	Sat, 23 Dec 2023 06:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703314344; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IcADzLsu4UG9h7eTRNClgqYQhedNX7PtYm9QClv1mDI=;
	b=dH9CZyN06WYxbgOoDak8TeuI26yWDtVD9KuyNVFU6Hesc/P+I6zw2XKWMQ2BtnD4PtEm/p
	8U/QQkAku7ZTz8XAczMwIzxxJAG0+5kZBFQHoSuV2Utqwjl023r5VfeZzPpMyZoRp2Dmph
	Hsb2aKaHNDWZBC0avB+B352s3uPylVE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703314344;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IcADzLsu4UG9h7eTRNClgqYQhedNX7PtYm9QClv1mDI=;
	b=ZTCk+Bi9OLhZbthwCWcA53e/dPVfYLQ9Eh3UOzRVTJPVtcql9uBb4IufM0zqBR333//uKY
	LocEerPpiZuCd5Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703314344; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IcADzLsu4UG9h7eTRNClgqYQhedNX7PtYm9QClv1mDI=;
	b=dH9CZyN06WYxbgOoDak8TeuI26yWDtVD9KuyNVFU6Hesc/P+I6zw2XKWMQ2BtnD4PtEm/p
	8U/QQkAku7ZTz8XAczMwIzxxJAG0+5kZBFQHoSuV2Utqwjl023r5VfeZzPpMyZoRp2Dmph
	Hsb2aKaHNDWZBC0avB+B352s3uPylVE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703314344;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IcADzLsu4UG9h7eTRNClgqYQhedNX7PtYm9QClv1mDI=;
	b=ZTCk+Bi9OLhZbthwCWcA53e/dPVfYLQ9Eh3UOzRVTJPVtcql9uBb4IufM0zqBR333//uKY
	LocEerPpiZuCd5Cg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A47AE139C4;
	Sat, 23 Dec 2023 06:52:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id YuolFaSDhmXjOwAAn2gu4w
	(envelope-from <colyli@suse.de>); Sat, 23 Dec 2023 06:52:20 +0000
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: Bug in commit aa511ff8218b ("badblocks: switch to the improved
 badblock handling
From: Coly Li <colyli@suse.de>
In-Reply-To: <6585d5fda5183_9f731294b9@iweiny-mobl.notmuch>
Date: Sat, 23 Dec 2023 14:52:07 +0800
Cc: Dan Williams <dan.j.williams@intel.com>,
 Jens Axboe <axboe@kernel.dk>,
 Xiao Ni <xni@redhat.com>,
 Geliang Tang <geliang.tang@suse.com>,
 Hannes Reinecke <hare@suse.de>,
 NeilBrown <neilb@suse.de>,
 Vishal L Verma <vishal.l.verma@intel.com>,
 linux-block@vger.kernel.org,
 nvdimm@lists.linux.dev,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <270BD884-EF31-491C-9339-5D9ADF3BC694@suse.de>
References: <6585d5fda5183_9f731294b9@iweiny-mobl.notmuch>
To: Ira Weiny <ira.weiny@intel.com>
X-Mailer: Apple Mail (2.3774.300.61.1.2)
X-Spam-Level: 
X-Spam-Level: 
X-Spamd-Result: default: False [0.37 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.03)[55.02%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 MV_CASE(0.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: 0.37
X-Spam-Flag: NO



> 2023=E5=B9=B412=E6=9C=8823=E6=97=A5 02:31=EF=BC=8CIra Weiny =
<ira.weiny@intel.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Coly,
>=20
> Yesterday I noticed that a few of our nvdimm tests were failing.  I =
bisected
> the problem to the following commit.
>=20
> aa511ff8218b ("badblocks: switch to the improved badblock handling =
code")=20
>=20
> Reverting this patch fixed our tests.
>=20
> I've also dug into the code a bit and I believe the algorithm for
> badblocks_check() is broken (not yet sure about the other calls).  At =
the
> very least I see the bb->p pointer being indexed with '-1'.  :-(
>=20
> I did notice that this work was due to a bug report in badblock_set().
> Therefore, I'm not sure of that severity of that fix is vs a revert.  =
But
> at this point I'm not seeing an easy fix so I'm in favor of a revert.

Hi Ira,

Thanks for the information reported. Let me look into the situation now.

Coly Li


