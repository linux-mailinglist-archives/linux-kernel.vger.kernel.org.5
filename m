Return-Path: <linux-kernel+bounces-150300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 682888A9D02
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E77B283C71
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4DF16C848;
	Thu, 18 Apr 2024 14:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IXVU/xSu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sMNUrgxx";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tNY4FVYd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZAQ5t7EA"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1B11635C8;
	Thu, 18 Apr 2024 14:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713450378; cv=none; b=tl6cvGyoIHdJjL5oNVKT86rKIIXo473FsADZvtbf43PN972tYebSljFOqJNmVmQ76uFmRhCkazqRiKVTCGWY32WXTNrIBufbTyv8txrrLUjeqVKDCV0GVgaYevLEjrPKCJAWI6jEivUxyRJ2Jtxw2u1NcUW4yXscBkdwye9svhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713450378; c=relaxed/simple;
	bh=rcRUkZ/y0khJhYr/AkkjZ27Nay/hu8KD3KL3PrlpfQ8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gnhfOC2oCs3NYIhV3k5CGm4UKJDDbng0x6wztwEmvWJkesPP/ICkYK8BuRogKiBqq0gwrXKaLupCcskIgwkUtffLYXppCKAvLvnBr4IT2s73Fo+MT8K9ephHFMb6c62Vy63HPcCoO+bS1FMo+FvLe190cSIZ0ZA9LLalwNVe4hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IXVU/xSu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sMNUrgxx; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tNY4FVYd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZAQ5t7EA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 107A02081D;
	Thu, 18 Apr 2024 14:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713450375; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f7YVjJr+W3wk5uH+Tl4rlF4cuoUA+Yq43EM2JvCzVts=;
	b=IXVU/xSup5fCS+dLaf7wlCHZjBRgfMCDRZLeBvRstnCUxsgUBTbj//VyiIdWyULbfOMiwR
	vvr0KyKSOsRZLXpI7nNxgfAzfH2Wqv1eWiW2WC398rj+bGL578O3tpqaXgAbezfKsBNIRg
	4djpy1nPvGA8RV6c/KzY2oiL+qEkTLk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713450375;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f7YVjJr+W3wk5uH+Tl4rlF4cuoUA+Yq43EM2JvCzVts=;
	b=sMNUrgxxeyE5i0gG2T2EZnfcoiXLrhthug86NEAUFxbBEJAUvo6O/pfeI16nrsZ++KPFdk
	IirTgAlMZ8f+D3Aw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713450374; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f7YVjJr+W3wk5uH+Tl4rlF4cuoUA+Yq43EM2JvCzVts=;
	b=tNY4FVYdQG/CBJKeWtWSRM2IaW3t9DnG7//VoZyuaaT6ZnonCEWJpXctyo2Ez80BEehYxf
	5v4B7JLDAY9pC5NBNn4AMT/jM01mx5bQ8ORbvL/Yt+2sqATxlnJ7qI7W6bo0pqirGzcSYU
	WLOmzzPndlvga03+QZYrE0uzuNgx0mk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713450374;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f7YVjJr+W3wk5uH+Tl4rlF4cuoUA+Yq43EM2JvCzVts=;
	b=ZAQ5t7EAsFA5Xeu/aleZ7itWOzNV81up3+9GXkvariYnqYkotnFBXLIzWNtIAWag2t0J+O
	3GzzToQ4LNo4D/AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A0A7B13687;
	Thu, 18 Apr 2024 14:26:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NqMFJoUtIWY0JAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 18 Apr 2024 14:26:13 +0000
Date: Thu, 18 Apr 2024 16:26:22 +0200
Message-ID: <87ttjywxv5.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Nam Cao <namcao@linutronix.de>
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	jayalk@intworks.biz,
	Daniel Vetter <daniel@ffwll.ch>,
	deller@gmx.de,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	tiwai@suse.de,
	bigeasy@linutronix.de,
	patrik.r.jakobsson@gmail.com,
	LKML
 <linux-kernel@vger.kernel.org>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	George Kennedy <george.kennedy@oracle.com>,
	Darren Kenny
 <darren.kenny@oracle.com>,
	chuansheng.liu@intel.com
Subject: Re: [bug-report] task info hung problem in fb_deferred_io_work()
In-Reply-To: <20240418160652.68df1a86@namcao>
References: <271372d6-e665-4e7f-b088-dee5f4ab341a@oracle.com>
	<20240418160652.68df1a86@namcao>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -1.48
X-Spam-Level: 
X-Spamd-Result: default: False [-1.48 / 50.00];
	BAYES_HAM(-2.68)[98.61%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	FREEMAIL_CC(0.00)[oracle.com,intworks.biz,ffwll.ch,gmx.de,vger.kernel.org,lists.freedesktop.org,suse.de,linutronix.de,gmail.com,intel.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

On Thu, 18 Apr 2024 16:06:52 +0200,
Nam Cao wrote:
> 
> On 2024-04-18 Harshit Mogalapalli wrote:
> > While fuzzing 5.15.y kernel with Syzkaller, we noticed a INFO: task hung 
> > bug in fb_deferred_io_work()
> 
> Which framebuffer device are you using exactly? It is possible that
> the problem is with the device driver, not core framebuffer.

Note that it was already known that using flush_delayed_work() caused
a problem.  See the thread of the fix patch:
  https://lore.kernel.org/all/20230129082856.22113-1-tiwai@suse.de/

BTW, the problem is seen with bochs drm.


Takashi

