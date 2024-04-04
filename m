Return-Path: <linux-kernel+bounces-131447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 624728987F9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 168D028E60C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360B2127B7E;
	Thu,  4 Apr 2024 12:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GJRM475F";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="78LyZlUu";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GJRM475F";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="78LyZlUu"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB633126F2A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 12:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712234172; cv=none; b=KgN1El285pAbqwtBzmB9XjivXKY08D+27/NnnVcfkyY3qCsXuf1FAe3bHDR1KSU7up8/GB8sVDpJ7hvvYQtI6O6t/MMmdaXD3AzMlewBk+o6rfVJIXoa1mBQfbYD/LKYr1j4ntU/ZsQtXrpqiCep7mSOiKhmzFagW/wXVUY5DWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712234172; c=relaxed/simple;
	bh=24ocDmNm/37tN5V5qKT9aMp88zFL2QHbk1Qfe5eKGNY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FDB+5cAdIMkUpvnH0Q+cJ9wwxQRW2/Y7RA4syvrcVmfccdRUsfyR7EmLvnKX1ypfh/Re30IWHa4VMCcaPz96OiQF0CFsSd2Q39x1x9RCuKye1CwQr+mLjiCFQD6GymMTGY+CRz0NfgQL3rMQtahTvauw/0SECT10exp5uqpm86Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GJRM475F; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=78LyZlUu; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GJRM475F; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=78LyZlUu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C0A7A5D955;
	Thu,  4 Apr 2024 12:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712234168; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eXTV3MVLoZysUZqfH/s0T0+YlgQbu+yNiEzbDPdDIJU=;
	b=GJRM475F5D/jXMH7aU5JMXbR9neBUEzRguV6anCQw9T4b5208ramDvQU/UZ358R3AU0aWa
	+XestpDTdkVGBbGh1LLWcfBYV1HgDGjT6B20JIoSlJLvthDgk437G04fa4j8r3zZ+BYG5n
	ie9y2k92R7yllm39F9yq1vsZIg39eJ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712234168;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eXTV3MVLoZysUZqfH/s0T0+YlgQbu+yNiEzbDPdDIJU=;
	b=78LyZlUulFjm8D/ulI2C7vLkRYSjKXdYjxH9iB90FdwJOyy+jGkJZqGxdI68sdBQInS2gf
	vAxcm1zjILviFBDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=GJRM475F;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=78LyZlUu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712234168; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eXTV3MVLoZysUZqfH/s0T0+YlgQbu+yNiEzbDPdDIJU=;
	b=GJRM475F5D/jXMH7aU5JMXbR9neBUEzRguV6anCQw9T4b5208ramDvQU/UZ358R3AU0aWa
	+XestpDTdkVGBbGh1LLWcfBYV1HgDGjT6B20JIoSlJLvthDgk437G04fa4j8r3zZ+BYG5n
	ie9y2k92R7yllm39F9yq1vsZIg39eJ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712234168;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eXTV3MVLoZysUZqfH/s0T0+YlgQbu+yNiEzbDPdDIJU=;
	b=78LyZlUulFjm8D/ulI2C7vLkRYSjKXdYjxH9iB90FdwJOyy+jGkJZqGxdI68sdBQInS2gf
	vAxcm1zjILviFBDA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 464D913298;
	Thu,  4 Apr 2024 12:36:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id WPe0D7ieDmbNYgAAn2gu4w
	(envelope-from <tiwai@suse.de>); Thu, 04 Apr 2024 12:36:08 +0000
Date: Thu, 04 Apr 2024 14:36:13 +0200
Message-ID: <87zfu9nw3m.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: <broonie@kernel.org>,
	<andriy.shevchenko@linux.intel.com>,
	<lgirdwood@gmail.com>,
	<perex@perex.cz>,
	<pierre-louis.bossart@linux.intel.com>,
	<13916275206@139.com>,
	<alsa-devel@alsa-project.org>,
	<linux-kernel@vger.kernel.org>,
	<liam.r.girdwood@intel.com>,
	<bard.liao@intel.com>,
	<yung-chuan.liao@linux.intel.com>,
	<kevin-lu@ti.com>,
	<baojun.xu@ti.com>,
	<soyer@irl.hu>,
	<Baojun.Xu@fpt.com>,
	<navada@ti.com>,
	<v-po@ti.com>
Subject: Re: [PATCH v2] ALSA: hda/tas2781: correct the register for pow calibrated data
In-Reply-To: <20240404122530.1049-1-shenghao-ding@ti.com>
References: <20240404122530.1049-1-shenghao-ding@ti.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-1.09 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	BAYES_HAM(-0.58)[81.34%];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[139.com,gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,gmail.com,perex.cz,139.com,alsa-project.org,vger.kernel.org,intel.com,ti.com,irl.hu,fpt.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C0A7A5D955
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -1.09

On Thu, 04 Apr 2024 14:25:30 +0200,
Shenghao Ding wrote:
> 
> Fixes: 5be27f1e3ec9 ("ALSA: hda/tas2781: Add tas2781 HDA driver")
> 
> Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

It's always a bad sign when a patch is provided without a proper
description.  Please give a bit more info.

Also, you need no blank line between Fixes and Singed-off-by tags.


thanks,

Takashi

