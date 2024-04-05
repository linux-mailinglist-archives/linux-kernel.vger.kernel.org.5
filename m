Return-Path: <linux-kernel+bounces-133062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D28E9899E3A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 032731C22C9F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C6A16D4C9;
	Fri,  5 Apr 2024 13:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lFBNLNUb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fcOxNc9h";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lFBNLNUb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fcOxNc9h"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AED415FD16
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 13:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712323525; cv=none; b=TOhGR+juDFRWA3oVoFufh90oUrJundR7HA3bf88Ma0piQW3ZmH0CbagnRw2UqlAfaP6hHpw3Tu7gjMIUbw+8WPLMZ79wKH//jNJr77Hf8QfMq88LelXRxA98xTyJeDyOrELdkgVZLmTscVaT/zlGk5x2oirQWdIAO6NJhI5GDK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712323525; c=relaxed/simple;
	bh=iLdba+FCvagX1vgwBB94s5I8geWS8ZAoFqavH1fpllg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RY10a+U32MNbjE6dLzaViqitwZ3qteTg47fPJ6H95eWD0ivPf/8MBmVwsizHLSm0pnrwHzzdNrfCNjO9mwSVUsfQyWgvY40m0PA74SwaJcrFpHKDU5puXIiEAAovdzyyfJ12lmC6lAYWFLcRo6SE1Kw/8SJsjmpRfsDjhyxdkTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lFBNLNUb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fcOxNc9h; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lFBNLNUb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fcOxNc9h; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9629A21A41;
	Fri,  5 Apr 2024 13:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712323522; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PJC3Z1irT0+nnttWGlCwrHW635IJ8lN25LyXL+82QFU=;
	b=lFBNLNUbFnYkutVradXzW3rkfxETWkp10yjx4uOPAAovCfUzOSt14yLOw4yCxI5CoDIeXk
	Yv4X7qGxtc7LFCsfRJlI8RlTAE6MN55mq4GA+uYCbakhPmtEJ3dZXNs3Kku3nlflh19BWz
	AxvhCTREQ2QUi6aqJ0QU5K61ZeAB8k0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712323522;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PJC3Z1irT0+nnttWGlCwrHW635IJ8lN25LyXL+82QFU=;
	b=fcOxNc9hAkvQdUSSb/A5XSl4e8oEUWkmK31vPNqb8uhPfrNt+XntR/T1ZijH4b22MPIU/X
	80LQdXPwvXVmgwDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lFBNLNUb;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=fcOxNc9h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712323522; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PJC3Z1irT0+nnttWGlCwrHW635IJ8lN25LyXL+82QFU=;
	b=lFBNLNUbFnYkutVradXzW3rkfxETWkp10yjx4uOPAAovCfUzOSt14yLOw4yCxI5CoDIeXk
	Yv4X7qGxtc7LFCsfRJlI8RlTAE6MN55mq4GA+uYCbakhPmtEJ3dZXNs3Kku3nlflh19BWz
	AxvhCTREQ2QUi6aqJ0QU5K61ZeAB8k0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712323522;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PJC3Z1irT0+nnttWGlCwrHW635IJ8lN25LyXL+82QFU=;
	b=fcOxNc9hAkvQdUSSb/A5XSl4e8oEUWkmK31vPNqb8uhPfrNt+XntR/T1ZijH4b22MPIU/X
	80LQdXPwvXVmgwDQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 83844139F1;
	Fri,  5 Apr 2024 13:25:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id b/qrHsL7D2blLAAAn2gu4w
	(envelope-from <dwagner@suse.de>); Fri, 05 Apr 2024 13:25:22 +0000
Date: Fri, 5 Apr 2024 15:24:57 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: James Smart <james.smart@broadcom.com>, 
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, Hannes Reinecke <hare@kernel.org>
Subject: Re: [PATCH v4 3/5] nvmet: return DHCHAP status codes from
 nvmet_setup_auth()
Message-ID: <b2wntzlxa62nj7abvgsfc36tqbhuhun2e6ugqlvfs7lzfegzzm@q5mydisb7vaf>
References: <20240405062055.GC3107@lst.de>
 <3qh6d2fensgck2rodnbhreirfwkf7lloqwvk6gyfafu4fvgxss@jxb4b4kzu224>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3qh6d2fensgck2rodnbhreirfwkf7lloqwvk6gyfafu4fvgxss@jxb4b4kzu224>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 9629A21A41
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[8];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]

On Fri, Apr 05, 2024 at 12:02:52PM +0200, Daniel Wagner wrote:
> On Fri, Apr 05, 2024 at 08:20:55AM +0200, Christoph Hellwig wrote:
> > > @@ -131,7 +131,6 @@ int nvmet_setup_auth(struct nvmet_ctrl *ctrl)
> > >  	int ret = 0;
> > >  	struct nvmet_host_link *p;
> > >  	struct nvmet_host *host = NULL;
> > > -	const char *hash_name;
> > >  
> > >  	down_read(&nvmet_config_sem);
> > >  	if (nvmet_is_disc_subsys(ctrl->subsys))
> > > @@ -149,13 +148,16 @@ int nvmet_setup_auth(struct nvmet_ctrl *ctrl)
> > >  	}
> > >  	if (!host) {
> > >  		pr_debug("host %s not found\n", ctrl->hostnqn);
> > > -		ret = -EPERM;
> > > +		ret = NVME_AUTH_DHCHAP_FAILURE_FAILED;
> > >  		goto out_unlock;
> > 
> > This is now returning returning random on the wire fields that aren't
> > even the NVMe status codes from a function otherwise returning Linux
> > errno values.  I can't see how this works or is maintainable long term.
> 
> This is the target side and we generate the on wire return code here.
> Are you sure I should map this to errno codes and the back to NVME
> status codes? Sure, this is possible but don't really think it makes
> sense.

I think I start to understand your feedback. I'll try to address it.

