Return-Path: <linux-kernel+bounces-10360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C2581D35C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 10:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C6A6B23078
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 09:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56009BA3A;
	Sat, 23 Dec 2023 09:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bK24MQ3h";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OQSZ2yR8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bK24MQ3h";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OQSZ2yR8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920778F75;
	Sat, 23 Dec 2023 09:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 844771FD3B;
	Sat, 23 Dec 2023 09:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703324388; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BvXFiEny+aAoKZJAN1DaF0hAE7cky7XP+yEFCFw394k=;
	b=bK24MQ3hvAKnDVLKbuqyTpxLVB+UEp5481b6xTP1uF6VmN7LRzz2n4RJb5tGUPM+KiMvEb
	1y0Df4i+j4s5SaSeT1luWiEi9+EDtTHzZgV1Mek/z1lmUTDU34eSfpHRe9TET5mpehVo4u
	G9glXmMcFJJP0NXhMBE1tFPi/+GBWwE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703324388;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BvXFiEny+aAoKZJAN1DaF0hAE7cky7XP+yEFCFw394k=;
	b=OQSZ2yR8cz5HUZQ2/2e8ohB0+liswH1Qpo0oTbcTsBjmufyvvKoGHjhppexW8RBUiSZnqp
	8aJAXDPXb0TRA+Dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703324388; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BvXFiEny+aAoKZJAN1DaF0hAE7cky7XP+yEFCFw394k=;
	b=bK24MQ3hvAKnDVLKbuqyTpxLVB+UEp5481b6xTP1uF6VmN7LRzz2n4RJb5tGUPM+KiMvEb
	1y0Df4i+j4s5SaSeT1luWiEi9+EDtTHzZgV1Mek/z1lmUTDU34eSfpHRe9TET5mpehVo4u
	G9glXmMcFJJP0NXhMBE1tFPi/+GBWwE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703324388;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BvXFiEny+aAoKZJAN1DaF0hAE7cky7XP+yEFCFw394k=;
	b=OQSZ2yR8cz5HUZQ2/2e8ohB0+liswH1Qpo0oTbcTsBjmufyvvKoGHjhppexW8RBUiSZnqp
	8aJAXDPXb0TRA+Dw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 644861341F;
	Sat, 23 Dec 2023 09:39:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id C35PBeCqhmWkRwAAn2gu4w
	(envelope-from <colyli@suse.de>); Sat, 23 Dec 2023 09:39:44 +0000
Date: Sat, 23 Dec 2023 17:39:37 +0800
From: Coly Li <colyli@suse.de>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Jens Axboe <axboe@kernel.dk>, 
	Xiao Ni <xni@redhat.com>, Geliang Tang <geliang.tang@suse.com>, 
	Hannes Reinecke <hare@suse.de>, NeilBrown <neilb@suse.de>, 
	Vishal L Verma <vishal.l.verma@intel.com>, linux-block@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: Bug in commit aa511ff8218b ("badblocks: switch to the improved
 badblock handling
Message-ID: <nhza4xsnbmcmka7463jxgmdvb27pqvbvcuzs7xp4vzpqlo262d@dp7laevqtaka>
References: <6585d5fda5183_9f731294b9@iweiny-mobl.notmuch>
 <6585dc32bebce_ab80829462@iweiny-mobl.notmuch>
 <658628b098aeb_b31b42945b@iweiny-mobl.notmuch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="mld3575deksx72gs"
Content-Disposition: inline
In-Reply-To: <658628b098aeb_b31b42945b@iweiny-mobl.notmuch>
X-Spam-Level: ***
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	 HAS_ATTACHMENT(0.00)[];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 CTYPE_MIXED_BOGUS(1.00)[];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+,1:+,2:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=bK24MQ3h;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=OQSZ2yR8
X-Spam-Score: -3.81
X-Rspamd-Queue-Id: 844771FD3B


--mld3575deksx72gs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Fri, Dec 22, 2023 at 04:24:16PM -0800, Ira Weiny wrote:
> Ira Weiny wrote:
> > Ira Weiny wrote:
> > > Coly,
> > > 
> > > Yesterday I noticed that a few of our nvdimm tests were failing.  I bisected
> > > the problem to the following commit.
> > > 
> > > aa511ff8218b ("badblocks: switch to the improved badblock handling code") 
> > > 
> > > Reverting this patch fixed our tests.
> > > 
> 
> [snip]
> 
> I added some prints[1] to try and see what is happening.  Perhaps this will
> help you.
> 
> ...
> [   99.919237] IKW set_badblock 00000000aa44c55d 8000 1
> [   99.921448] IKW set_badblock 00000000aa44c55d 8001 1
> [   99.924051] IKW set_badblock 00000000aa44c55d 8002 1
> [   99.926135] IKW set_badblock 00000000aa44c55d 8003 1
> [   99.928516] IKW set_badblock 00000000aa44c55d 8004 1
> [   99.930491] IKW set_badblock 00000000aa44c55d 8005 1
> [   99.932894] IKW set_badblock 00000000aa44c55d 8006 1
> [   99.936638] IKW set_badblock 00000000aa44c55d 8007 1
> [  100.999297] IKW _badblocks_check() 00000000aa44c55d s 8000 num 1
> [  101.000027]    IKW table count 1 shift 0
> [  101.000644]    IKW 0: off 8000 end 8008
> [  101.001271]    IKW prev 0, cnt 1
> [  101.002481]    IKW start 8000, len 1
> [  101.003464]    IKW front overlap 0
> [  101.004256] IKW rv 1
> 
> ...            ^^^^^^^^^
> <This is a valid failure as part of the test>
> ...
> 
> [  101.148783] IKW set_badblock 00000000721b4f3d 8000 1
> [  101.150629] IKW set_badblock 00000000721b4f3d 8001 1
> [  101.152315] IKW set_badblock 00000000721b4f3d 8002 1
> [  101.154544] IKW set_badblock 00000000721b4f3d 8003 1
> [  101.156238] IKW set_badblock 00000000721b4f3d 8004 1
> [  101.158310] IKW set_badblock 00000000721b4f3d 8005 1
> [  101.160196] IKW set_badblock 00000000721b4f3d 8006 1
> [  101.162158] IKW set_badblock 00000000721b4f3d 8007 1
> [  101.163543] IKW _badblocks_check() 00000000721b4f3d s 0 num 8
> [  101.164427]    IKW table count 1 shift 0
> [  101.165310]    IKW 0: off 8000 end 8008
> [  101.166398]    IKW prev -1, cnt 1
> [  101.167178]    IKW start 0, len 8
> [  101.168107] IKW rv 0
> [  101.168858] IKW _badblocks_check() 00000000721b4f3d s 8 num 8
> [  101.169814]    IKW table count 1 shift 0
> [  101.170547]    IKW 0: off 8000 end 8008
> [  101.171238]    IKW prev -1, cnt 1
> [  101.171985]    IKW start 8, len 8
> [  101.173007]    IKW front overlap -1  <== this is prev which is used to index bb->pages
> [  101.174157]    IKW prev -1, cnt 1
> [  101.175268]    IKW start 9, len 7
> [  101.176557] IKW rv -1
> 
> ...            ^^^^^^^^^
> This is where the failure occurs.
> ...
> 
> I think overlap_front() is not working correctly in this case.  And from
> my reading of the code I don't know how it would.  But overlap_front() is
> used elsewhere and I'm not confident in making the change.
> 
> Hope this helps,

Hi Ira,

The above information is accurate and very helpful, thank you!

From __badblocks_check(), the problematic code block is,
1303 re_check:
1304         bad.start = s;
1305         bad.len = sectors;
1306
1307         if (badblocks_empty(bb)) {
1308                 len = sectors;
1309                 goto update_sectors;
1310         }
1311
1312         prev = prev_badblocks(bb, &bad, hint);
1313
1314         /* start after all badblocks */
1315         if ((prev + 1) >= bb->count && !overlap_front(bb, prev, &bad)) {
1316                 len = sectors;
1317                 goto update_sectors;
1318         }
1319
1320         if (overlap_front(bb, prev, &bad)) {
1321                 if (BB_ACK(p[prev]))
1322                         acked_badblocks++;
1323                 else
1324                         unacked_badblocks++;
1325
1326                 if (BB_END(p[prev]) >= (s + sectors))
1327                         len = sectors;
1328                 else
1329                         len = BB_END(p[prev]) - s;
1330
1331                 if (set == 0) {
1332                         *first_bad = BB_OFFSET(p[prev]);
1333                         *bad_sectors = BB_LEN(p[prev]);
1334                         set = 1;
1335                 }
1336                 goto update_sectors;
1337         }
1338
1339         /* Not front overlap, but behind overlap */
1340         if ((prev + 1) < bb->count && overlap_behind(bb, &bad, prev + 1)) {
1341                 len = BB_OFFSET(p[prev + 1]) - bad.start;
1342                 hint = prev + 1;
1343                 goto update_sectors;
1344         }
1345
1346         /* not cover any badblocks range in the table */
1347         len = sectors;
1348
1349 update_sectors:

If the checking range is before all badblocks records in the badblocks table,
value -1 is returned from prev_badblock(). Code blocks between line 1314 and
line 1337 doesn't hanle the implicit '-1' value properly. Then counter
unacked_badblocks is increased at line 1324 mistakenly.

So the value prev should be checked and make sure '>= 0' before comparing
the checking range with a badblock record returned by prev_badblocks(). Other
wise it dones't make sense.

For badblocks_set() and badblocks_clear(), 'prev < 0' is explicitly checked,
value '-1' doesn't go though into following code.

Could you please apply and try the attached patch? Hope it may help a bit.

And now it is weekend time, you may be out of office and not able to access
the testing hardware. I will do more testing from myside and update more info
if necessary.

Thanks for the report and debug!

Coly Li

[debug patch snipped]

--mld3575deksx72gs
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment;
	filename="0001-badblocks-avoid-checking-invalid-range-in-badblocks_.patch"

From 0f81e197404653a4631f5d5857c63510e0534430 Mon Sep 17 00:00:00 2001
From: Coly Li <colyli@suse.de>
Date: Sat, 23 Dec 2023 17:24:51 +0800
Subject: [PATCH] badblocks: avoid checking invalid range in badblocks_check()

If prev_badblocks() returns '-1', it means no valid badblocks record
before the checking range. It doesn't make sense to check whether
the input checking range is overlapped with the non-existed invalid
front range.

This patch checkes whether 'prev >= 0' is true before calling
overlap_front(), to void such invalid operations.

Reported-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Coly Li <colyli@suse.de>
---
 block/badblocks.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/badblocks.c b/block/badblocks.c
index fc92d4e18aa3..db4ec8b9b2a8 100644
--- a/block/badblocks.c
+++ b/block/badblocks.c
@@ -1312,12 +1312,14 @@ static int _badblocks_check(struct badblocks *bb, sector_t s, int sectors,
 	prev = prev_badblocks(bb, &bad, hint);
 
 	/* start after all badblocks */
-	if ((prev + 1) >= bb->count && !overlap_front(bb, prev, &bad)) {
+	if ((prev >= 0) &&
+	    ((prev + 1) >= bb->count) && !overlap_front(bb, prev, &bad)) {
 		len = sectors;
 		goto update_sectors;
 	}
 
-	if (overlap_front(bb, prev, &bad)) {
+	/* Overlapped with front badblocks record */
+	if ((prev >= 0) && overlap_front(bb, prev, &bad)) {
 		if (BB_ACK(p[prev]))
 			acked_badblocks++;
 		else
-- 
2.35.3


--mld3575deksx72gs--

