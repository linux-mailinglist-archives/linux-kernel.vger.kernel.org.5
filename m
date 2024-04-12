Return-Path: <linux-kernel+bounces-142130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD708A27E5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 759031F227B9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB754D9F4;
	Fri, 12 Apr 2024 07:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MH7J2liT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PomDPhVM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Rpwv4I1a";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kmMdfvf9"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645A84D59E
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 07:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712906654; cv=none; b=JSouPQEzMXOF2gx1IS6kadc2Bt43t5rQHYZqxYMxPLm0uWN1KIfSb17mOvYNZbLNtCPMR0S2xldtD/DSStfZn43SMsk0r/f1wnwW8tQB0wJZrD3vGB6h9tCpmCd4TwTgIriSjA/XmK8zVXDvz/lVeAu/AGn0FOKYetzv7jqkzfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712906654; c=relaxed/simple;
	bh=1WYsXBFhC9qT65v2C2+m5TmQIhaESOsNf/ipkoOinxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ztp5xMijk12E94efkIjiEhL/JvU5qb6MUWFbGKaimyn5D/jkgzkfL/DlDTcqP9Hw6QNeD2LFgXNOPu2ac/YcFcUlgazFZoababA4d+CoWGIiEEI2yHPU10W5fKjtiaDsAlLh1EngRdcpUyZhD7YUUFf8GMCmskt+NJKOi61QX+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MH7J2liT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PomDPhVM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Rpwv4I1a; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kmMdfvf9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 345FF37FB1;
	Fri, 12 Apr 2024 07:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712906646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oV106H3TaEF2NxM6uz7Oj8X/Nd+Js+KHgrq9m6ZedyU=;
	b=MH7J2liTMNcQpoFlIsaZ+bbKnCSA3/vfWfTGinG/nRZ3ANQT1AfXxdbeLAjiJYbp1jSxNQ
	bOKh29hF5FypOkqVRjBsy2zGHNbZOHvoOfUvFnSimXA1oxpBi688/fOgIwqbDn3KwKMpph
	ZpOXRgxoiMCtBG3kFKIvxk+Y4/aeGgU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712906646;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oV106H3TaEF2NxM6uz7Oj8X/Nd+Js+KHgrq9m6ZedyU=;
	b=PomDPhVMMnnQjfNnwOgNrHBPMSCIJG3KjpzZYh+0YLdwdjxsJjW1+ovntgLntUpEzx68VK
	iXo61lQ5EhGA7JDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712906645; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oV106H3TaEF2NxM6uz7Oj8X/Nd+Js+KHgrq9m6ZedyU=;
	b=Rpwv4I1aqeJwXRm4GNUwLWzv7ff3hpmBDtBIdmuKmzp4IBALrjRcgEj3+tRnWfjRpFObbp
	kBpkaOH/qjERO+QidNvgOpFojC1DVHOeSWjR3+etsXPEuX+6CbERtvGVae9oXzQVAauXM7
	b/u4Hm09c6ayjed/KW30sFGiacJN78Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712906645;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oV106H3TaEF2NxM6uz7Oj8X/Nd+Js+KHgrq9m6ZedyU=;
	b=kmMdfvf9kymr7kxyi7uysQV7iktsmkBhMWYetdQjp5Js+TBVL5a+MOUW7PFFoU0mADP5Ad
	25PC+35f+rvEhWAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2224113942;
	Fri, 12 Apr 2024 07:24:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dBjZA5XhGGaaaAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 12 Apr 2024 07:24:05 +0000
Date: Fri, 12 Apr 2024 09:24:04 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	James Smart <james.smart@broadcom.com>, Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/6]  nvme-fabrics: short-circuit connect retries
Message-ID: <vbptto5zefkdadnpyhcjelfrsgadb2stjh3sole6n6mdd4h7dq@lrdxk5p5qh6w>
References: <20240409093510.12321-1-dwagner@suse.de>
 <ZhiBzXBvjTeDuHbS@kbusch-mbp.dhcp.thefacebook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhiBzXBvjTeDuHbS@kbusch-mbp.dhcp.thefacebook.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Thu, Apr 11, 2024 at 06:35:25PM -0600, Keith Busch wrote:
> On Tue, Apr 09, 2024 at 11:35:04AM +0200, Daniel Wagner wrote:
> > The first patch returns only kernel error codes now and avoids overwriting error
> > codes later. Thje newly introduced helper for deciding if a reconnect should be
> > attempted is the only place where we have the logic (and documentation).
> > 
> > On the target side I've separate the nvme status from the dhchap status handling
> > which made it a bit clearer. I was tempted to refactor the code in
> > nvmet_execute_auth_send to avoid hitting the 80 chars limit but didn't came up
> > with something nice yet. So let's keep this change at a minimum before any
> > refactoring attempts.
> > 
> > I've tested with blktests and also an real hardware for nvme-fc.
> 
> Thanks, series applied to nvme-6.9.

Thanks! I have an updated version here which addresses some of Sagi's
feedback, e.g. using only one helper function. Sorry I didn't send out
it earlier, I got a bit side tracked in testing because of the 'funky'
results with RDMA.

Do you want me to send a complete fresh series or patches on top of this
series? I'm fine either way.

