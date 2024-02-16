Return-Path: <linux-kernel+bounces-68974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B092A8582D7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67B55283984
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97E1130AC9;
	Fri, 16 Feb 2024 16:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oXxYf1GP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RPF5q9EE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oXxYf1GP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RPF5q9EE"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5282F43687
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 16:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708101848; cv=none; b=Jv1d1D/tDud1bonAuL+RiH66CcZ/yLheXY7GcLdkvIAJQ4msHYUV3wycE0I4r3hZU4IT30On2WcuQ5RjrQm030IayK9KWSMV+fRwYhbzc3N1I5MX9M0kq4cqWFFnGdWHHxGg8rXqYJ15X02nlgr4zsaVcUc2FnOpCiZEvSPrirk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708101848; c=relaxed/simple;
	bh=DNofHlxt60HhajpC6kgIcM2jyLwxGD85DFjpF5ALyCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GblDj2WzxA0DJPkdlgoxlCH1ffaYnTfAuyu/0VNCXe+pGSvqQyZ+Z8NOu0+CP9zwcNY0POawZXAKsBbWSrwt8QhNXeV1/HwYzWRk/zAD7fDe3wEqh/NUEeTTHbGNmtxY+dWM22DPjnwJlKAkxx6+X50VgYqDzzHp016NOt+4gPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oXxYf1GP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RPF5q9EE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oXxYf1GP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RPF5q9EE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5E9731FB73;
	Fri, 16 Feb 2024 16:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708101843; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eXJu1lti/YL9b9eLBL5o0g1fuOA+z3Z1pve6u3c4mhQ=;
	b=oXxYf1GPFWXOcgqcHA2ePzg3k8lbTe5hjXx7KDjENBXhJ9IOAOBTKxP0EQ3/bP9kiX08RB
	9FQk652sf8JXla23ZARcq32SRIXxMkEKc2OQrTBrfeWNoHeEbJAePYu7OlHMCpE4u/Xc2/
	7SoYKKFkwFfTTEovCasaVjo1CXzA3Ok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708101843;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eXJu1lti/YL9b9eLBL5o0g1fuOA+z3Z1pve6u3c4mhQ=;
	b=RPF5q9EEsaz/WG47s0EwJdUF0GQIGvUBDsYv42hxwOdVr/W2jEkFKDERCD5cUHa3ywLC7y
	lvRNIfmWHVdNxTBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708101843; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eXJu1lti/YL9b9eLBL5o0g1fuOA+z3Z1pve6u3c4mhQ=;
	b=oXxYf1GPFWXOcgqcHA2ePzg3k8lbTe5hjXx7KDjENBXhJ9IOAOBTKxP0EQ3/bP9kiX08RB
	9FQk652sf8JXla23ZARcq32SRIXxMkEKc2OQrTBrfeWNoHeEbJAePYu7OlHMCpE4u/Xc2/
	7SoYKKFkwFfTTEovCasaVjo1CXzA3Ok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708101843;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eXJu1lti/YL9b9eLBL5o0g1fuOA+z3Z1pve6u3c4mhQ=;
	b=RPF5q9EEsaz/WG47s0EwJdUF0GQIGvUBDsYv42hxwOdVr/W2jEkFKDERCD5cUHa3ywLC7y
	lvRNIfmWHVdNxTBQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B3C813343;
	Fri, 16 Feb 2024 16:44:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 4lLoENOQz2XgVgAAn2gu4w
	(envelope-from <dwagner@suse.de>); Fri, 16 Feb 2024 16:44:03 +0000
Date: Fri, 16 Feb 2024 17:44:02 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: James Smart <james.smart@broadcom.com>, 
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v0 1/6] nvme-fabrics: introduce connect_sync option
Message-ID: <jfjchxptpfcpolpy2etiigflqvfcp2nzk53iwb6rx2zsdfd6by@h6ezfayjfqai>
References: <20240216084526.14133-1-dwagner@suse.de>
 <20240216084526.14133-2-dwagner@suse.de>
 <20240216094909.GA19961@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216094909.GA19961@lst.de>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=oXxYf1GP;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=RPF5q9EE
X-Spamd-Result: default: False [-2.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5E9731FB73
X-Spam-Level: 
X-Spam-Score: -2.81
X-Spam-Flag: NO

On Fri, Feb 16, 2024 at 10:49:09AM +0100, Christoph Hellwig wrote:
> On Fri, Feb 16, 2024 at 09:45:21AM +0100, Daniel Wagner wrote:
> > The TCP and RDMA transport are doing a synchronous connect, meaning the
> > syscal returns with the final result, that is. it either failed or
> > succeeded.
> > 
> > This isn't the case for FC. This transport just setups and triggers
> > the connect and returns without waiting on the result.
> 
> That's really weird and unexpected.  James, can you explain the reason
> behind this?

James answered this point on my attempt to make this synchronous:

https://lore.kernel.org/linux-nvme/0605ac36-16d5-2026-d3c6-62d346db6dfb@gmail.com/

> > Introduce a flag
> > to allow user space to control the behavior, wait or don't wait.
> 
> I'd expect this to be the default, but I'll wait to hear more about
> the rationale.  If we keep the async default the option looks sensible.

Ideally, we could agree on behavior which is the same for all
transports.

