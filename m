Return-Path: <linux-kernel+bounces-131766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 524B1898B92
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4C131F21746
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B9E12C53F;
	Thu,  4 Apr 2024 15:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="axyLZBFS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fni6zS40";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zvJxnq5h";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ubp8xBGp"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39711129A7E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 15:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712245851; cv=none; b=M6L7/CCtmxT83GtGm+BtfFo8wLXKPjda8dzpjebwC9jLbiMfmUvzVSZ1dNM9bS1Awadu9U+6NgbIkHqWqmFFfWEC59TccR1NSL0TYQOJdnevpDSLWY0n/utwQNvGS8xvUj1magBv+J4qCrASVVWbl6FmPGgrO2rYXdaachCoQkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712245851; c=relaxed/simple;
	bh=ntkEadILylOo1NfrUsz4O1zCx5wupmDS43xJCpc2wWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g1Z7nkO4dXnkeFSanHEQm1o1jY7E1HSeE9EZgoueizc5A1BaeuDXT7hgtw7ARnZjBcVAhyx77kVaVyjXlf0v86kKjE+dDVtUyt2qqca6B6Bg3WMl8uihXF0KmsHOn5ictS/Zgd0nxY5xj5ODLwv1x0y2ft7m+k7Foe1YsldLoL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=axyLZBFS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fni6zS40; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zvJxnq5h; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ubp8xBGp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 40FBD37D06;
	Thu,  4 Apr 2024 15:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712245848; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ELeYmpZSqSBqztt4rYwLki4oPTWM6rd/sK49O5iGwsk=;
	b=axyLZBFS2JIHKKcD4c/MGuJb+N0h9T8iAfdrzuxUrF5fn84pP1IdinZDyVZeOexr312G0E
	0vemBLyROQsAf7h1SO8R1NZGZ1oWloNUHlMeAnCvJwGIrIw8zw7llfqhHZwFY2YGGl10UV
	sO6Qj9hntbllR/6pBugr4/sX3czGRIs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712245848;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ELeYmpZSqSBqztt4rYwLki4oPTWM6rd/sK49O5iGwsk=;
	b=fni6zS40K6AsJYihBWp8sga7YHBUgRYNavy/pHbWc8vXmMdgXlrALBExej33pm67HkfIW3
	kLjao9og39I9DoBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zvJxnq5h;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ubp8xBGp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712245847; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ELeYmpZSqSBqztt4rYwLki4oPTWM6rd/sK49O5iGwsk=;
	b=zvJxnq5hSZaXmyXD5esjgGgogBjAQ4SHsaG6Pgo3suV66dB/YilFj+4OCoePp3W2t0uUWP
	Xkc5kBZobJW+vVDBp5NJLEYnXgbfq8TVfJeE5sckQNUEynrJD3FDnDx0z23IyvNGtheAYP
	3zgSuZEY5XBZ2cuTwGJlXanBD1DUOy0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712245847;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ELeYmpZSqSBqztt4rYwLki4oPTWM6rd/sK49O5iGwsk=;
	b=ubp8xBGpeAZVgP02pfo1ISowLOzkJn8VJ+Ko4bOtxo56CRdyXbbOYwDFKUfigCbKCh2qdv
	xBuYmF51dAI0xMAQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F84513298;
	Thu,  4 Apr 2024 15:50:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id /4cTC1fMDmbEIwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Thu, 04 Apr 2024 15:50:47 +0000
Date: Thu, 4 Apr 2024 17:50:46 +0200
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/5] nvme-fabrics: short-circuit connect retries
Message-ID: <vqywie3ud6pxvfjtvks2smhy37qvtexikh56syu63c33gxw5pc@myqmkna3fhq2>
References: <20240404154500.2101-1-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404154500.2101-1-dwagner@suse.de>
X-Spam-Flag: NO
X-Spam-Score: -5.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 40FBD37D06
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]

On Thu, Apr 04, 2024 at 05:44:55PM +0200, Daniel Wagner wrote:
> changes:
> v4:
>   - rebased
>   - added 'nvme: fixes for authentication errors' series
>     https://lore.kernel.org/linux-nvme/20240301112823.132570-1-hare@kernel.org/

Please ignore v4 for now. I've forgot to update 'nvme: fixes for
authentication errors' series.

