Return-Path: <linux-kernel+bounces-163483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B3C8B6BED
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D526E1F21989
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 07:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4D845026;
	Tue, 30 Apr 2024 07:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZswrpLQ+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JVxkGGSI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZswrpLQ+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JVxkGGSI"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A084338DFC;
	Tue, 30 Apr 2024 07:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714462474; cv=none; b=MkpNJAg0w/uK86HKolLowmQQyXznlhrSVOlgEzbUMQ5arO0+F0Oz0TVsuwVFVw5E8I1th0gEo6fISeAiN9nauXH8sYJ9N0Z3ZhbA3bv6h8AVf2ej20Z0og4bCevdxSpoRIxW+FosjRgM/dG+6Jz3GmZu7j0vMOcy+TolfuQqB2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714462474; c=relaxed/simple;
	bh=9BdL5rz1siwVikdm61Qcl+hhIn7YQCw3RRQ5IFAXeD4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MyChhcAx0e1YHWpNdDMMX+uU/S2yLxJl7cPIFqjr6EOQ25n9ssOSukLItkavmQvPNR5a9QkLGPXrxM0YiNRmvlrexPYXqWL4uwbvCdxjI5LLyn2qtg/vW5ciFyAxJCekrmPd4yhoJkKiIvykMTPV9ypzZObx8TgeWlcrNVPCsOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZswrpLQ+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JVxkGGSI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZswrpLQ+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JVxkGGSI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CA30C1F7C6;
	Tue, 30 Apr 2024 07:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714462470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=71/GVDgdlfEFcv6CwQsH1RgBK1dMGCf8k3QOq5VUuuA=;
	b=ZswrpLQ+ieWPRt1Eok+gO8PidsBh1j9m32vFqBj0b+9U1Y9tyf0FotzPgxdEfZbyk5lh9Z
	CislQ5L3mWZd5ZIr1yGIRX5aUlWY+9Dx6PdeVYJVnE4zeTUW0lA/m/3cEzBcwCD042x64m
	KXMV0J3u7xgRlT91U9W016pMe2MtmT0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714462470;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=71/GVDgdlfEFcv6CwQsH1RgBK1dMGCf8k3QOq5VUuuA=;
	b=JVxkGGSI4nJShR/JrRSMO3a3J7TH71N+5Jf8K1arv4T62Vrz8V4GHn/+sEGvFADa25JNeR
	tnfmHp9juR+cGmBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ZswrpLQ+;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=JVxkGGSI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714462470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=71/GVDgdlfEFcv6CwQsH1RgBK1dMGCf8k3QOq5VUuuA=;
	b=ZswrpLQ+ieWPRt1Eok+gO8PidsBh1j9m32vFqBj0b+9U1Y9tyf0FotzPgxdEfZbyk5lh9Z
	CislQ5L3mWZd5ZIr1yGIRX5aUlWY+9Dx6PdeVYJVnE4zeTUW0lA/m/3cEzBcwCD042x64m
	KXMV0J3u7xgRlT91U9W016pMe2MtmT0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714462470;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=71/GVDgdlfEFcv6CwQsH1RgBK1dMGCf8k3QOq5VUuuA=;
	b=JVxkGGSI4nJShR/JrRSMO3a3J7TH71N+5Jf8K1arv4T62Vrz8V4GHn/+sEGvFADa25JNeR
	tnfmHp9juR+cGmBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A64D133A7;
	Tue, 30 Apr 2024 07:34:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4i4kGAafMGbyNQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 30 Apr 2024 07:34:30 +0000
Date: Tue, 30 Apr 2024 09:34:42 +0200
Message-ID: <87cyq7nw19.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Manuel Barrio Linares <mbarriolinares@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Geraldo Nascimento <geraldogabriel@gmail.com>,
	dengxiang <dengxiang@nfschina.com>,
	Jussi Laako <jussi@sonarnerd.net>,
	Christos Skevis <xristos.thes@gmail.com>,
	Alexander Tsoy <alexander@tsoy.me>,
	Jeremie Knuesel <knuesel@gmail.com>,
	WhaleChang <whalechang@google.com>,
	Sean Young <sean@mess.org>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ALSA: usb-audio: Add sampling rates support for Mbox3
In-Reply-To: <20240429193522.10380-1-mbarriolinares@gmail.com>
References: <87il00pdsz.wl-tiwai@suse.de>
	<20240429193522.10380-1-mbarriolinares@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -3.98
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: CA30C1F7C6
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.98 / 50.00];
	BAYES_HAM(-2.97)[99.88%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[perex.cz,suse.com,gmail.com,nfschina.com,sonarnerd.net,tsoy.me,google.com,mess.org,vger.kernel.org];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

On Mon, 29 Apr 2024 21:35:00 +0200,
Manuel Barrio Linares wrote:
> 
> +	set_rate = le32_to_cpu(buff4);
> +	if (new_rate != set_rate)

Those two lines cause sparse warnings, unfortunately.
You can't assign int to __le32 type directly, and you can't compare
between those types directly, either.

That said, it should be rather like

	if (new_rate != le32_to_cpu(buff4))
		dev_warn(...);


You can check the sparse warning by yourself by passing C=1 argument
to make, too.


thanks,

Takashi

