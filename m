Return-Path: <linux-kernel+bounces-132484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 806E48995BA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFCC6B23774
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 06:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C8022F03;
	Fri,  5 Apr 2024 06:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mQHmbUDN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ugDJCovi";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mQHmbUDN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ugDJCovi"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7234E250F8
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 06:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712299516; cv=none; b=SsHoUF+L+dA306Arrd7q18B+3jaii7pwJODiKEs8aaGVSiBK1SUBcEanNGypPqfXumwDSV356jSIugtgeYLZ6mSuOfTiXhbXhEoCLYGEM3z3Qs++VgZ4rMDZVwDV9+xBJQ798YVh8eBBNfV5RFocUq+U9BZBe8JNi1dnVSHXSNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712299516; c=relaxed/simple;
	bh=yIgObGgbSme5cS1WDByvqppod/Jayqu/rWB/JIbuSv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fkAZB7KxofBLmK+P1FpTGsF/nhtIvoI8R5hETBgK6eVBE6YU1ZD6Xnpxy94jzVW6GGMKZDfjeI2AmAPqSt7vlHi47oI+n9vvAJn9FoggnRGKyyttXer05rRdslOoI8EJfEJiFd1boeavZ9iLSisrwQtkh4g0U4UWAZx6ALL0sSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mQHmbUDN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ugDJCovi; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mQHmbUDN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ugDJCovi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 700791F770;
	Fri,  5 Apr 2024 06:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712299512; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=huP0MdNq2/qxlE6Y5h6Dudv0RfoY9kd5EhXZLo2os34=;
	b=mQHmbUDNQmnsHL6VPclu3G7dj3z77GJGRcyeTCNMy3WLSiusogps0VWjzWuBVDaereqrrF
	UJs2zUFH5xbEf19dF80o1UlvJQnDnx2oNujE3iBf7TNF2r9BEOjKBGw6H72uthGZvX7rqo
	sGFLJeHR2Gal2AYD1pUu7R6ObS1BzxY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712299512;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=huP0MdNq2/qxlE6Y5h6Dudv0RfoY9kd5EhXZLo2os34=;
	b=ugDJCoviWUBQWFZsukwjOOknAhKXpg5mStCXbQ/fRAhatwsXA6CNUo1rd3yNl72aQr2H/b
	5/1HaHeKfisB3mDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mQHmbUDN;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ugDJCovi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712299512; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=huP0MdNq2/qxlE6Y5h6Dudv0RfoY9kd5EhXZLo2os34=;
	b=mQHmbUDNQmnsHL6VPclu3G7dj3z77GJGRcyeTCNMy3WLSiusogps0VWjzWuBVDaereqrrF
	UJs2zUFH5xbEf19dF80o1UlvJQnDnx2oNujE3iBf7TNF2r9BEOjKBGw6H72uthGZvX7rqo
	sGFLJeHR2Gal2AYD1pUu7R6ObS1BzxY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712299512;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=huP0MdNq2/qxlE6Y5h6Dudv0RfoY9kd5EhXZLo2os34=;
	b=ugDJCoviWUBQWFZsukwjOOknAhKXpg5mStCXbQ/fRAhatwsXA6CNUo1rd3yNl72aQr2H/b
	5/1HaHeKfisB3mDw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 58C53139E8;
	Fri,  5 Apr 2024 06:45:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id OLOqFPidD2aJIAAAn2gu4w
	(envelope-from <dwagner@suse.de>); Fri, 05 Apr 2024 06:45:12 +0000
Date: Fri, 5 Apr 2024 08:45:11 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: James Smart <james.smart@broadcom.com>, 
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/5] nvme: authentication error are always
 non-retryable
Message-ID: <woyigt522zjki3zqudphkxmnzqmerrbk4qdammefuuxww3n3a2@ahfxqfztkmvp>
References: <20240404154500.2101-1-dwagner@suse.de>
 <20240404154500.2101-2-dwagner@suse.de>
 <20240405061624.GA3107@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405061624.GA3107@lst.de>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 700791F770
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Fri, Apr 05, 2024 at 08:16:24AM +0200, Christoph Hellwig wrote:
> > --- a/drivers/nvme/host/fabrics.c
> > +++ b/drivers/nvme/host/fabrics.c
> > @@ -467,7 +467,7 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
> >  		if (result & NVME_CONNECT_AUTHREQ_ASCR) {
> >  			dev_warn(ctrl->device,
> >  				 "qid 0: secure concatenation is not supported\n");
> > -			ret = NVME_SC_AUTH_REQUIRED;
> > +			ret = NVME_SC_AUTH_REQUIRED | NVME_SC_DNR;
> 
> This is still abusing on the wire status code for in-kernel return
> codes.  Can we please sort this out properly?

Okay, though I am not really sure how to do it correctly.

So the current mapping is

  ret < 0: kernel errors
  ret = 0: all good
  ret > 0: wire status incl DNR

In order to split the internal DNR away, we could attach it to the cmd.
Is this what you had in mind? Or do you mean we should not return
NVME_SC_AUTH_REQUIRED at all. Instead just a negative value and update
the error handling on the callers?

