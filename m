Return-Path: <linux-kernel+bounces-166058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 034BE8B955A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2C5B28330B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 07:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75157249EB;
	Thu,  2 May 2024 07:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Lef8wLqU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sC7nwuaY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1nMOIelM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Bd7sPqdS"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4E5225A2;
	Thu,  2 May 2024 07:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714635265; cv=none; b=I3CC64ye+IVRPDqkUWAmL7U0BJcfla3bTvuzngHAKiyuDgg3hLof6hZJrK29oqk7Mks19SwoXZm+GjHyZinBamkoxvQKCTT5eUMQ4hMpS9QdIWgPUrLhmUSxy951ASToS2HhPxhn6KJP7ffcMY5fV+Ecdg16MSa1mODOWbrBxk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714635265; c=relaxed/simple;
	bh=6GK2X1Dyf3LwTW41qhx6/gq+NhiNlqtW7+Mhdg+svsw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UNklZRLjuhtSsZqOHTZfoXIZC05CrB1iZcgIbJH8sJjwSR7FPz7zvJgU70JN+4JN9VGO0CaoskzdZljT1OZIT1TAtQ9HHpzqn/VmrDUWe6QIpzkk7xcOY7WJXYYIK0XaxdLJO6T4pIoUxXHhAkepREPlNgAnuw2N5So0f1TtvAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Lef8wLqU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sC7nwuaY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1nMOIelM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Bd7sPqdS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 78F8835099;
	Thu,  2 May 2024 07:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714635262; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rq3Mt3aYkbi1OHfrZIjoH8On8OcteoDXqBU4IUII44Q=;
	b=Lef8wLqUZ+QzTty6aZcdo4u8MaydPvVLbPnQV7LhpQMe0Zc/fAlycuiFmCrSKFMVN7tKI1
	9LNsdZqsSUDvr8czXB/4b1aNnM+kjqP1TxeVH3gWTKs6IW4I1XFK9df7r+LOoumdA1jHGk
	nGcpD2BodRWCDu4KE4VE+MZmQarqj1c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714635262;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rq3Mt3aYkbi1OHfrZIjoH8On8OcteoDXqBU4IUII44Q=;
	b=sC7nwuaYsAWRc+i6kSK213F0VTBpHXK9j9c1DNJxk/e1+wcMHxQ7wQXSgLoHZjZs9uxo93
	YY6WkZdGTIRiQECw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=1nMOIelM;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Bd7sPqdS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714635261; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rq3Mt3aYkbi1OHfrZIjoH8On8OcteoDXqBU4IUII44Q=;
	b=1nMOIelMFnI8yPweIRs+VSIChkgZh5HEn1HcMaE+haYO36Th/DsuljqalEcOZG2viLrcyu
	6ikprl4qTc+jS5Jpjt6uks1NnSXP+Adj1yHDtO8EawvFhB5YxTwEq58MB5P/6UEm3d/swp
	s+X14YkvO5gFDxi+ZJS2ORrE5fBkM2s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714635261;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rq3Mt3aYkbi1OHfrZIjoH8On8OcteoDXqBU4IUII44Q=;
	b=Bd7sPqdSl3vSCT8v6crKpdBoEL8zahH/ZrR7w+sOKFXMNnLHm+XlVjLvl0xmZVqrt17eeZ
	6Zryg8L9evmqfMBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3E34413957;
	Thu,  2 May 2024 07:34:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WNpZDf1BM2YCUAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 02 May 2024 07:34:21 +0000
Date: Thu, 02 May 2024 09:34:34 +0200
Message-ID: <87ttjgk6ph.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Simon Trimmer <simont@opensource.cirrus.com>
Cc: <tiwai@suse.com>,
	<linux-sound@vger.kernel.org>,
	<alsa-devel@alsa-project.org>,
	<linux-kernel@vger.kernel.org>,
	<patches@opensource.cirrus.com>
Subject: Re: [PATCH] ALSA: hda: cs35l56: Perform firmware download in the background
In-Reply-To: <20240501111755.21231-1-simont@opensource.cirrus.com>
References: <20240501111755.21231-1-simont@opensource.cirrus.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-3.40 / 50.00];
	BAYES_HAM(-2.89)[99.52%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 78F8835099
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.40

On Wed, 01 May 2024 13:17:55 +0200,
Simon Trimmer wrote:
> @@ -964,6 +1011,14 @@ int cs35l56_hda_common_probe(struct cs35l56_hda *cs35l56, int hid, int id)
>  	mutex_init(&cs35l56->base.irq_lock);
>  	dev_set_drvdata(cs35l56->base.dev, cs35l56);
>  
> +	cs35l56->dsp_wq = create_singlethread_workqueue("cs35l56-dsp");
> +	if (!cs35l56->dsp_wq) {
> +		ret = -ENOMEM;
> +		goto err;
> +	}

Do we really need a dedicated workqueue?  In most usages, simple
schedule_work*() works fine and is recommended.


thanks,

Takashi

