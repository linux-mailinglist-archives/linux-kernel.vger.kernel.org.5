Return-Path: <linux-kernel+bounces-10625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7278D81D792
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 03:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2884928297D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 02:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93DC1383;
	Sun, 24 Dec 2023 02:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oNxIhwB0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0OJilSPP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HIVCbM5s";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JUXrEnna"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A911410E1;
	Sun, 24 Dec 2023 02:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9B37F1F74B;
	Sun, 24 Dec 2023 02:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703383886; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vtd/L5UCOnZiAydpj5PblS3egJ85sJyph8sMxPz5LX0=;
	b=oNxIhwB0F5IBTyog7s7djctqya2X1aHdJhSW5yTfia91r4kHSZ7cYfLgnFiloy0NIraHEx
	pK4VCu1+OJudUjoDe27KKCZBy0dDyaQH5UuWh++1ASkF+QxN21y540PG4HlGzatyUrYfbi
	+HxmwKZGdDdjaSPsXOfbZZajk6TpskU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703383886;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vtd/L5UCOnZiAydpj5PblS3egJ85sJyph8sMxPz5LX0=;
	b=0OJilSPPuuE6nSFW5wAGVnPa9QVa31AWatDBrad2SLRfFJ8pdRDtkA9HF9asko1NkMFAGP
	u9CbGWfTxvANs/Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703383885; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vtd/L5UCOnZiAydpj5PblS3egJ85sJyph8sMxPz5LX0=;
	b=HIVCbM5s9V/vwH+nEAJiFNYn1K1i6VLeXFwU203pD4HcjCCLNIb74EcMFEIIM9O0smvVU6
	1qgeS3+ZY/mJKmPrutu0Ax4+1uM8jE+f9LgNhXdDQzGld9PHE/hMOyGAE0cYac2RlBl91l
	1esr7faLFCaobDBFEZtb0yHaIndKMB4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703383885;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vtd/L5UCOnZiAydpj5PblS3egJ85sJyph8sMxPz5LX0=;
	b=JUXrEnnaV6EveXdm7C+OhsHrlvlopnyEhBA3QmUdf1b3xkRYDdF8I6rkF8wEBXEK8tTbiD
	QFUl3r/aZe79erDg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 87C2913902;
	Sun, 24 Dec 2023 02:11:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id ZTKxDEmTh2XQBAAAn2gu4w
	(envelope-from <colyli@suse.de>); Sun, 24 Dec 2023 02:11:21 +0000
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
In-Reply-To: <0eef6feb-4775-4249-af74-9fccb093b6bc@kernel.dk>
Date: Sun, 24 Dec 2023 10:11:03 +0800
Cc: nvdimm@lists.linux.dev,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Block Devices <linux-block@vger.kernel.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Geliang Tang <geliang.tang@suse.com>,
 Hannes Reinecke <hare@suse.de>,
 NeilBrown <neilb@suse.de>,
 Vishal L Verma <vishal.l.verma@intel.com>,
 Xiao Ni <xni@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <98F03B8B-5A3E-463F-AB27-0AE00DC27CB9@suse.de>
References: <20231224002820.20234-1-colyli@suse.de>
 <A110805F-3448-4A87-AE70-F94A394EA826@suse.de>
 <0eef6feb-4775-4249-af74-9fccb093b6bc@kernel.dk>
To: Jens Axboe <axboe@kernel.dk>,
 Ira Weiny <ira.weiny@intel.com>
X-Mailer: Apple Mail (2.3774.300.61.1.2)
X-Spam-Level: *****
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=HIVCbM5s;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=JUXrEnna
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.87 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 BAYES_HAM(-0.91)[86.19%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 MV_CASE(0.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.com:email,intel.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.14)[-0.707];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -1.87
X-Rspamd-Queue-Id: 9B37F1F74B
X-Spam-Flag: NO



> 2023=E5=B9=B412=E6=9C=8824=E6=97=A5 09:38=EF=BC=8CJens Axboe =
<axboe@kernel.dk> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On 12/23/23 5:32 PM, Coly Li wrote:
>>> 2023?12?24? 08:28?Coly Li <colyli@suse.de> ???
>>>=20
>>> If prev_badblocks() returns '-1', it means no valid badblocks record
>>> before the checking range. It doesn't make sense to check whether
>>> the input checking range is overlapped with the non-existed invalid
>>> front range.
>>>=20
>>> This patch checkes whether 'prev >=3D 0' is true before calling
>>> overlap_front(), to void such invalid operations.
>>>=20
>>> Fixes: 3ea3354cb9f0 ("badblocks: improve badblocks_check() for =
multiple ranges handling")
>>> Reported-and-tested-by: Ira Weiny <ira.weiny@intel.com>
>>> Signed-off-by: Coly Li <colyli@suse.de>
>>> Link: =
https://lore.kernel.org/nvdimm/3035e75a-9be0-4bc3-8d4a-6e52c207f277@leemhu=
is.info/
>>> Cc: Dan Williams <dan.j.williams@intel.com>
>>> Cc: Geliang Tang <geliang.tang@suse.com>
>>> Cc: Hannes Reinecke <hare@suse.de>
>>> Cc: Jens Axboe <axboe@kernel.dk>
>>> Cc: NeilBrown <neilb@suse.de>
>>> Cc: Vishal L Verma <vishal.l.verma@intel.com>
>>> Cc: Xiao Ni <xni@redhat.com>
>>> ---
>>> block/badblocks.c | 6 ++++--
>>> 1 file changed, 4 insertions(+), 2 deletions(-)
>>=20
>> Hi Jens,
>>=20
>> Is it possible to take this fix into 6.7 still? Thanks in advance.
>=20
> Yep, we're still a few weeks out, so not a problem.

Jes and Ira,

Thank you all for fast response during holidays.

Happy holidays and merry Christmas!

Coly Li


