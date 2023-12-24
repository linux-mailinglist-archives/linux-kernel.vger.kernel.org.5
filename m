Return-Path: <linux-kernel+bounces-10611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4253681D761
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 01:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3B72282DE6
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 00:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB9D7EA;
	Sun, 24 Dec 2023 00:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GZSdotJQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qjIbud0t";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GZSdotJQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qjIbud0t"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C6D190;
	Sun, 24 Dec 2023 00:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 17AC02214A;
	Sun, 24 Dec 2023 00:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703377116; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qZRdtQc1hCmbIZ4cIMntznAv+M4OO52Vo8xtzR9fNzE=;
	b=GZSdotJQTKwWbvzjLP3v0RwuFZVIsRMgmAjGu2PMdOqINjbLLZhuVEcjm+Dri56V9Uqe42
	IIyhiGb/eU79THPLtvgUfDJtrobvZTX9hmf7EA2DDq5z3+Qtl4u7mAMoYFU+d50/x0ml/S
	xryOKpRE5c5PfDxH5ey5qTvPgJoFCg4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703377116;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qZRdtQc1hCmbIZ4cIMntznAv+M4OO52Vo8xtzR9fNzE=;
	b=qjIbud0tP1/C9Y6pzQ8R3EPU/wSezLCZapjJfOl2iXURi3DTmhQj9kk81MMai3LgIG+OWl
	zha55cauo8y/3pCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703377116; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qZRdtQc1hCmbIZ4cIMntznAv+M4OO52Vo8xtzR9fNzE=;
	b=GZSdotJQTKwWbvzjLP3v0RwuFZVIsRMgmAjGu2PMdOqINjbLLZhuVEcjm+Dri56V9Uqe42
	IIyhiGb/eU79THPLtvgUfDJtrobvZTX9hmf7EA2DDq5z3+Qtl4u7mAMoYFU+d50/x0ml/S
	xryOKpRE5c5PfDxH5ey5qTvPgJoFCg4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703377116;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qZRdtQc1hCmbIZ4cIMntznAv+M4OO52Vo8xtzR9fNzE=;
	b=qjIbud0tP1/C9Y6pzQ8R3EPU/wSezLCZapjJfOl2iXURi3DTmhQj9kk81MMai3LgIG+OWl
	zha55cauo8y/3pCw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E82AA13902;
	Sun, 24 Dec 2023 00:18:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id L5OWJdd4h2VxfgAAn2gu4w
	(envelope-from <colyli@suse.de>); Sun, 24 Dec 2023 00:18:31 +0000
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
In-Reply-To: <6587152b64d9f_c579e29437@iweiny-mobl.notmuch>
Date: Sun, 24 Dec 2023 08:18:18 +0800
Cc: Li Nan <linan666@huaweicloud.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jens Axboe <axboe@kernel.dk>,
 Xiao Ni <xni@redhat.com>,
 Geliang Tang <geliang.tang@suse.com>,
 Hannes Reinecke <hare@suse.de>,
 NeilBrown <neilb@suse.de>,
 Vishal L Verma <vishal.l.verma@intel.com>,
 Linux Block Devices <linux-block@vger.kernel.org>,
 nvdimm@lists.linux.dev,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5422004A-84A8-4E9E-B1E2-98503BCC80BC@suse.de>
References: <6585d5fda5183_9f731294b9@iweiny-mobl.notmuch>
 <6585dc32bebce_ab80829462@iweiny-mobl.notmuch>
 <658628b098aeb_b31b42945b@iweiny-mobl.notmuch>
 <nhza4xsnbmcmka7463jxgmdvb27pqvbvcuzs7xp4vzpqlo262d@dp7laevqtaka>
 <6587152b64d9f_c579e29437@iweiny-mobl.notmuch>
To: Ira Weiny <ira.weiny@intel.com>
X-Mailer: Apple Mail (2.3774.300.61.1.2)
X-Spam-Level: 
X-Spam-Level: 
X-Spamd-Result: default: False [0.40 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.00)[21.99%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 MV_CASE(0.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: 0.40
X-Spam-Flag: NO



> 2023=E5=B9=B412=E6=9C=8824=E6=97=A5 01:13=EF=BC=8CIra Weiny =
<ira.weiny@intel.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Coly Li wrote:
>=20
> [snip]
>=20
>>=20
>> Hi Ira,
>>=20
>> The above information is accurate and very helpful, thank you!
>>=20
>> =46rom __badblocks_check(), the problematic code block is,
>> 1303 re_check:
>> 1304         bad.start =3D s;
>> 1305         bad.len =3D sectors;
>> 1306
>> 1307         if (badblocks_empty(bb)) {
>> 1308                 len =3D sectors;
>> 1309                 goto update_sectors;
>> 1310         }
>> 1311
>> 1312         prev =3D prev_badblocks(bb, &bad, hint);
>> 1313
>> 1314         /* start after all badblocks */
>> 1315         if ((prev + 1) >=3D bb->count && !overlap_front(bb, =
prev, &bad)) {
>> 1316                 len =3D sectors;
>> 1317                 goto update_sectors;
>> 1318         }
>> 1319
>> 1320         if (overlap_front(bb, prev, &bad)) {
>> 1321                 if (BB_ACK(p[prev]))
>> 1322                         acked_badblocks++;
>> 1323                 else
>> 1324                         unacked_badblocks++;
>> 1325
>> 1326                 if (BB_END(p[prev]) >=3D (s + sectors))
>> 1327                         len =3D sectors;
>> 1328                 else
>> 1329                         len =3D BB_END(p[prev]) - s;
>> 1330
>> 1331                 if (set =3D=3D 0) {
>> 1332                         *first_bad =3D BB_OFFSET(p[prev]);
>> 1333                         *bad_sectors =3D BB_LEN(p[prev]);
>> 1334                         set =3D 1;
>> 1335                 }
>> 1336                 goto update_sectors;
>> 1337         }
>> 1338
>> 1339         /* Not front overlap, but behind overlap */
>> 1340         if ((prev + 1) < bb->count && overlap_behind(bb, &bad, =
prev + 1)) {
>> 1341                 len =3D BB_OFFSET(p[prev + 1]) - bad.start;
>> 1342                 hint =3D prev + 1;
>> 1343                 goto update_sectors;
>> 1344         }
>> 1345
>> 1346         /* not cover any badblocks range in the table */
>> 1347         len =3D sectors;
>> 1348
>> 1349 update_sectors:
>>=20
>> If the checking range is before all badblocks records in the =
badblocks table,
>> value -1 is returned from prev_badblock(). Code blocks between line =
1314 and
>> line 1337 doesn't hanle the implicit '-1' value properly. Then =
counter
>> unacked_badblocks is increased at line 1324 mistakenly.
>>=20
>> So the value prev should be checked and make sure '>=3D 0' before =
comparing
>> the checking range with a badblock record returned by =
prev_badblocks(). Other
>> wise it dones't make sense.
>>=20
>> For badblocks_set() and badblocks_clear(), 'prev < 0' is explicitly =
checked,
>> value '-1' doesn't go though into following code.
>>=20
>> Could you please apply and try the attached patch? Hope it may help a =
bit.
>>=20
>> And now it is weekend time, you may be out of office and not able to =
access
>> the testing hardware. I will do more testing from myside and update =
more info
>> if necessary.
>>=20
>> Thanks for the report and debug!
>>=20
>> Coly Li
>>=20
>> [debug patch snipped]
>=20
> This debug patch does fix our tests.  Thanks!
>=20
> But Nan has submitted a series to fix this as well.[1]
>=20
> I'm going to test his series as well.

Hi Ira,

Thanks for the very quick response, and the positive result. Now I =
compose a official patch and submit to Jens.

Coly Li=

