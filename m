Return-Path: <linux-kernel+bounces-61313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AD98510E2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20C5DB23F51
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20201BC47;
	Mon, 12 Feb 2024 10:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pOhO/3Jd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NeUOnyoA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pOhO/3Jd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NeUOnyoA"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93284182AF
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 10:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707733872; cv=none; b=HWzWl14ts4a6K1FwHeMwbrPTNPCsYkSVsQg+9CyB9eMqZmYZcrKRgLaGi4rX7ewe+pnbLCvi2Uqok/8RSqYWNsrJqFf0lVr1LXXPNu/Wg5UeeVCBWeNLeTbDcSRxYrVbXEAFFhnFwGZbB/Hx+hN4Y2Y6bsn1gqRj4MfA7arDPwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707733872; c=relaxed/simple;
	bh=0KQsUMRuvZ9A1LtHxdaXPH5EiJdnjk1zjtv1t86DCpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CBu2voL5+0LLHHrd0ibR1HWkabgF5OPOVjJB+u8fZZHI260Ro0/wj9HAc+bwO4mhB+MhBlafHKIzUByGIgcQz2qYdJ1RUCaSPkrDB4IAE6NMSkN2taQJEdw2HvaIzS2YOMEvhRIgGShprwhCwR99HYGz0DvRXFXwGCMa1TcI3+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pOhO/3Jd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NeUOnyoA; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pOhO/3Jd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NeUOnyoA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BE93922150;
	Mon, 12 Feb 2024 10:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707733868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0KQsUMRuvZ9A1LtHxdaXPH5EiJdnjk1zjtv1t86DCpQ=;
	b=pOhO/3JdQaXLpYApqTZSH8xxg2XOuI9uLnL6Htd2aZVny8ClVeaJT8STJeCK/R6Z0EuwIf
	6Z2/hFB3sOEwyNxOn5SRGiXMVut6/IsTb0Pig1o3rbpBPa5OIlSBaTgPd3OR5R9ltOCGHX
	VQ8jhAC64ORNcW+70T7hMublScVcOcg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707733868;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0KQsUMRuvZ9A1LtHxdaXPH5EiJdnjk1zjtv1t86DCpQ=;
	b=NeUOnyoAlr116GKVt4Qmx/2tGtja7xZ5TOeZ9xTAceoEA9B/Tl5duJAvWJvv/N02BtYe3K
	/uQTc9H4xTmfUdCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707733868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0KQsUMRuvZ9A1LtHxdaXPH5EiJdnjk1zjtv1t86DCpQ=;
	b=pOhO/3JdQaXLpYApqTZSH8xxg2XOuI9uLnL6Htd2aZVny8ClVeaJT8STJeCK/R6Z0EuwIf
	6Z2/hFB3sOEwyNxOn5SRGiXMVut6/IsTb0Pig1o3rbpBPa5OIlSBaTgPd3OR5R9ltOCGHX
	VQ8jhAC64ORNcW+70T7hMublScVcOcg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707733868;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0KQsUMRuvZ9A1LtHxdaXPH5EiJdnjk1zjtv1t86DCpQ=;
	b=NeUOnyoAlr116GKVt4Qmx/2tGtja7xZ5TOeZ9xTAceoEA9B/Tl5duJAvWJvv/N02BtYe3K
	/uQTc9H4xTmfUdCA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id AE1C913A0E;
	Mon, 12 Feb 2024 10:31:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id paoQKWzzyWWqCQAAn2gu4w
	(envelope-from <dwagner@suse.de>); Mon, 12 Feb 2024 10:31:08 +0000
Date: Mon, 12 Feb 2024 11:31:08 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>, James Smart <james.smart@broadcom.com>, 
	Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH v5 12/12] nvmet-fc: use RCU list iterator for
 assoc_list
Message-ID: <hpcmiagru7r2uuajov6a6fuakitx77na4susy7qrzofts7atyd@rcu4dmxqnfih>
References: <20240131085112.21668-1-dwagner@suse.de>
 <20240131085112.21668-13-dwagner@suse.de>
 <b19e0b0f-6b1c-4126-931b-d7b0d01fb3da@suse.de>
 <ZcKHCXtXWVCdi9Ae@kbusch-mbp.mynextlight.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcKHCXtXWVCdi9Ae@kbusch-mbp.mynextlight.net>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.78
X-Spamd-Result: default: False [-3.78 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.98)[99.92%]
X-Spam-Flag: NO

On Tue, Feb 06, 2024 at 11:22:49AM -0800, Keith Busch wrote:
> That said, the rcu_read_lock() seems like it should be moved to
> nvmet_fc_assoc_exits() since that's the only part reading rcu protected
> structures.

FTR, here is a fix:

https://lore.kernel.org/linux-nvme/20240212102940.11137-1-dwagner@suse.de/

