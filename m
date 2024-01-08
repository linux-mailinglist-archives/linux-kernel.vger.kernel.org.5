Return-Path: <linux-kernel+bounces-19600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE6C826F6E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29393283DDE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B124438E;
	Mon,  8 Jan 2024 13:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tuQX+QVd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zMuqHbkg";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tuQX+QVd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zMuqHbkg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F27541743;
	Mon,  8 Jan 2024 13:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 190A921F6A;
	Mon,  8 Jan 2024 13:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704719623; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eYHi3j8aE6cn/bC8ETd9FyL64aOVkoUdh0pTfHniGqk=;
	b=tuQX+QVdZ/EnNwKqS0KpTwijtUmBSS0fiIOqbp7DSSEzdjwpPcAncubVKvhqff67j8H4xH
	whj21CAFvQ7bmdrjG8rZp3bWoMzPhASqYRKCaAocgU+oF3SF2HfJ6TIV4RhEz+RIDfd/Vv
	OFCJK8fkumK0M6BO4RANfqHp0vtyEf0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704719623;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eYHi3j8aE6cn/bC8ETd9FyL64aOVkoUdh0pTfHniGqk=;
	b=zMuqHbkg1JHidOFSYTnWA2zthem9PgIXUUTAGlDf2FBZRcKQjcUau5Dp0163mUw0U+Zbk4
	30NvYaKGbg4uD0Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704719623; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eYHi3j8aE6cn/bC8ETd9FyL64aOVkoUdh0pTfHniGqk=;
	b=tuQX+QVdZ/EnNwKqS0KpTwijtUmBSS0fiIOqbp7DSSEzdjwpPcAncubVKvhqff67j8H4xH
	whj21CAFvQ7bmdrjG8rZp3bWoMzPhASqYRKCaAocgU+oF3SF2HfJ6TIV4RhEz+RIDfd/Vv
	OFCJK8fkumK0M6BO4RANfqHp0vtyEf0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704719623;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eYHi3j8aE6cn/bC8ETd9FyL64aOVkoUdh0pTfHniGqk=;
	b=zMuqHbkg1JHidOFSYTnWA2zthem9PgIXUUTAGlDf2FBZRcKQjcUau5Dp0163mUw0U+Zbk4
	30NvYaKGbg4uD0Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BA92B13686;
	Mon,  8 Jan 2024 13:13:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eWU2LAb1m2UKbgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 08 Jan 2024 13:13:42 +0000
Date: Mon, 08 Jan 2024 14:13:42 +0100
Message-ID: <87a5pgt1bt.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Huayu Zhang <932367230@qq.com>
Cc: tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	james.schulman@cirrus.com,
	david.rhodes@cirrus.com,
	rf@opensource.cirrus.com,
	perex@perex.cz,
	sbinding@opensource.cirrus.com,
	kailang@realtek.com,
	zhanghuayu.dev@gmail.com
Subject: Re: add DSD for ThinkBook 16p G4 IRH with Subsystem Id of :
In-Reply-To: <tencent_0ED010E11594001F62B9EF66C41B0FABCC05@qq.com>
References: <tencent_0ED010E11594001F62B9EF66C41B0FABCC05@qq.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: *
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 190A921F6A
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=tuQX+QVd;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=zMuqHbkg
X-Spam-Score: -5.45
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-5.45 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_TO(0.00)[qq.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-2.94)[99.75%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,qq.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DWL_DNSWL_HI(-3.50)[suse.de:dkim];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[suse.com,vger.kernel.org,cirrus.com,opensource.cirrus.com,perex.cz,realtek.com,gmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]

On Mon, 08 Jan 2024 13:51:36 +0100,
Huayu Zhang wrote:
> 
> Sorry for missing the info within patch and not familiar with the
> mailing system using git. As mentioned in the subject,
> the patch is using to fix the sound issue of ThinkBook 16p G4 IRH with
> Subsystem Id of : 0x17aa38a9. But this just enable the downside (bass)
> speakers. When I tried to adjust the volumn, it atually mapped to the
> frequency division (the lower volumn actually set the bass speakers,
> and higher volumn map to the louder sound of up facing speakers).
> Wondering if this related to ALSA?

The amp behavior is a question to Cirrus people, I suppose.

In anyway, the patch can't be taken as is.  You need to submit the
patch in a more formal way.

- Correct the subject line with a proper prefix, e.g.
    [PATCH] ALSA: hda: Add DSD for ....
  When resubmitting with some changes, put the revision number, too,
    [PATCH v2] ALSA: hda: Add DSD for ....

- Give the proper patch description in the patch itself.

- Put your Signed-off-by line after the patch description.
  It's a legal requirement.

Please refer to Documentation/process/submitting-patches.rst for
details.


thanks,

Takashi

