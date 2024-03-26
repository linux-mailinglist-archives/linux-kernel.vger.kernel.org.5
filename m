Return-Path: <linux-kernel+bounces-119295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD80D88C6C0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 926101F36B48
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65A813C81A;
	Tue, 26 Mar 2024 15:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hWjOzW1H";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pNMv7idU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hWjOzW1H";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pNMv7idU"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441C458220
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 15:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711466558; cv=none; b=TUIMVaLAofTfsv3n3McK1tZZZYl8DV4fOvthFoWl02Vo9i6gsTdnkH0n7PeswKvC6OStXuYwbWfWuySlD00TMeb4fULyhBMoci+X/7ej+zZlHBR0RriiQTNbmxpGQMIAZrBNd1QuCC/gyuyMwWs3mB3wix+S3cQfnkDSOdT7Ui4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711466558; c=relaxed/simple;
	bh=fBNcQUHOtvyZsysftwY23WAq61KVO16Ox520bWwmTKE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oG4uCNPmHP8/PE8hPBltfOGQsu3IJ+cHzNOVf2tOWXVoram7vZYbixZKEAVZB2mHY72IxwpyiV+ISehRO7/6au8jo43YHWoQECj10IuJcw/L2v2oQNOLfbTXUC+bV19Z1RZLpQIkdaXzqx2mIb6mf1uos0qP5PTBVe8+qOK1LPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hWjOzW1H; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pNMv7idU; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hWjOzW1H; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pNMv7idU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 73B3221E3D;
	Tue, 26 Mar 2024 15:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711466554; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KXH5uUDLtBRAB47YTVHB6bZditscTqY6M49f3hWQIm0=;
	b=hWjOzW1HqNS1ii0R8rstNDFJMG0KONLVKpbkNxwUISXQ3rq84H7y7dbv2TAc/G9D5vxGTU
	uY7/9kFo2jqr45S8FQXU8mZjC4ur4oIIdBddNeYGV0KekJFMeOoCzUTvYu36tcy1KCLiPG
	YSH1+bY0pSP7F6HFSgaKsc9lSy1i/LQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711466554;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KXH5uUDLtBRAB47YTVHB6bZditscTqY6M49f3hWQIm0=;
	b=pNMv7idUbMhs/IcgPQmJKVhGDE3oaaAPdU69K4zrkrZ8OkyivBHN1W9uDLa8fagjaOvHhx
	booslhzqaTBZz0Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711466554; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KXH5uUDLtBRAB47YTVHB6bZditscTqY6M49f3hWQIm0=;
	b=hWjOzW1HqNS1ii0R8rstNDFJMG0KONLVKpbkNxwUISXQ3rq84H7y7dbv2TAc/G9D5vxGTU
	uY7/9kFo2jqr45S8FQXU8mZjC4ur4oIIdBddNeYGV0KekJFMeOoCzUTvYu36tcy1KCLiPG
	YSH1+bY0pSP7F6HFSgaKsc9lSy1i/LQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711466554;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KXH5uUDLtBRAB47YTVHB6bZditscTqY6M49f3hWQIm0=;
	b=pNMv7idUbMhs/IcgPQmJKVhGDE3oaaAPdU69K4zrkrZ8OkyivBHN1W9uDLa8fagjaOvHhx
	booslhzqaTBZz0Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B83613306;
	Tue, 26 Mar 2024 15:22:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JwdzATroAmYETQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 26 Mar 2024 15:22:34 +0000
Date: Tue, 26 Mar 2024 16:22:35 +0100
Message-ID: <877chpuif8.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Baojun Xu <baojun.xu@ti.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	robh+dt@kernel.org,
	lgirdwood@gmail.com,
	perex@perex.cz,
	pierre-louis.bossart@linux.intel.com,
	kevin-lu@ti.com,
	13916275206@139.com,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	liam.r.girdwood@intel.com,
	yung-chuan.liao@linux.intel.com,
	broonie@kernel.org,
	soyer@irl.hu
Subject: Re: [PATCH v1 2/8] ALSA: hda/tas2781: Add tas2781 SPI-based driver
In-Reply-To: <ZgLjAz99JZQvrx_h@smile.fi.intel.com>
References: <20240326010905.2147-1-baojun.xu@ti.com>
	<20240326010905.2147-2-baojun.xu@ti.com>
	<ZgLjAz99JZQvrx_h@smile.fi.intel.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.12
X-Spamd-Result: default: False [0.12 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RL3kqsx7g8wwj8c3joodxqsamu)];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-1.08)[88.02%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[139.com,gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[dt];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[linux.intel.com,kernel.org,gmail.com,perex.cz,ti.com,139.com,alsa-project.org,vger.kernel.org,intel.com,irl.hu];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

On Tue, 26 Mar 2024 16:00:19 +0100,
Andy Shevchenko wrote:
> 
> On Tue, Mar 26, 2024 at 09:08:59AM +0800, Baojun Xu wrote:
> > Add TXNW2781 support in smi.
> 
> Same comment WRT the commit message.

Yeah, in general, all patches in this series have too short patch
descriptions.

Baojun, please give more words to explain what those patches do, and
more importantly tell why they are needed in that way.  Silence isn't
golden in the case of patches.  So, please resubmit the patch set with
the proper descriptions in each patch.


thanks,

Takashi

