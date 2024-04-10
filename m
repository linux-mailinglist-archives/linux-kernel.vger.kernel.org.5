Return-Path: <linux-kernel+bounces-138031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C2189EB49
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0461B2413D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBA74D59F;
	Wed, 10 Apr 2024 06:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IPmugtWc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="u/ME1YDt";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IPmugtWc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="u/ME1YDt"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3638F54FBD
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 06:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712731963; cv=none; b=fwUF6ByTS0EygCz8/tvkOZ7xziSaW4z9KbOl8La0/hHSb7gXFN8kDPGgop0TTJRSwG8K2TKOPc0GaQCoEhrObKIyzgoCioAthUSyy1kFzjOlOU183xl5YfaHS+7xWMmVe1R/Mq6t+gguAOIAkKedfazoHNCiFZUhY3W5XaTsjnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712731963; c=relaxed/simple;
	bh=qbJQ84Hn26xablgGAvzzoxoMwMYHEFm0nrQBidt7AGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S642hHcsI1BWbYdip5vy5BAzPzyQmajOup4Bz9t1+X6bq1c9lRF7ksgIE/azerP28IwXTWGE/Agc+Na+xYSQyTh+rkO8CkJ2bEv5JS178IKe6ZYyAZ5H15tQGDJHp/0vtVJu7fJVDgieu/TaANzPLKGLalyf2lHU2GkUDYIdhu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IPmugtWc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=u/ME1YDt; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IPmugtWc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=u/ME1YDt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5EC665C655;
	Wed, 10 Apr 2024 06:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712731960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HlDhm6YWrzg5UyEIsFpWx/PS0QCxqw3jTEwWr2WCYcY=;
	b=IPmugtWcLBSQ2LEvvl9lBEzjLpUI1gl1fsVlDykoueSi/xQLK24YVHaT0gxapJdo56R6yS
	4DUfiBCHY9w0OyPC3y5k9rsYmFdqJMuDFVJi53ev1ND52kXMIXTi/MmboBPMeFeccVt7+G
	3p0PBSKnBAHM/kuFtvFfm9bp1bodwVg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712731960;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HlDhm6YWrzg5UyEIsFpWx/PS0QCxqw3jTEwWr2WCYcY=;
	b=u/ME1YDtcj4q4bhHkXlNu6KcXolmnpzMY8hHUY7uFJYd4XW3ffVSiCUOmQAgkloSdENSr/
	80U7s9/aicnW29DA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712731960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HlDhm6YWrzg5UyEIsFpWx/PS0QCxqw3jTEwWr2WCYcY=;
	b=IPmugtWcLBSQ2LEvvl9lBEzjLpUI1gl1fsVlDykoueSi/xQLK24YVHaT0gxapJdo56R6yS
	4DUfiBCHY9w0OyPC3y5k9rsYmFdqJMuDFVJi53ev1ND52kXMIXTi/MmboBPMeFeccVt7+G
	3p0PBSKnBAHM/kuFtvFfm9bp1bodwVg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712731960;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HlDhm6YWrzg5UyEIsFpWx/PS0QCxqw3jTEwWr2WCYcY=;
	b=u/ME1YDtcj4q4bhHkXlNu6KcXolmnpzMY8hHUY7uFJYd4XW3ffVSiCUOmQAgkloSdENSr/
	80U7s9/aicnW29DA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D8601390D;
	Wed, 10 Apr 2024 06:52:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id bceDETg3FmYRPgAAn2gu4w
	(envelope-from <dwagner@suse.de>); Wed, 10 Apr 2024 06:52:40 +0000
Date: Wed, 10 Apr 2024 08:52:39 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, 
	James Smart <james.smart@broadcom.com>, Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/6] nvme: authentication error are always
 non-retryable
Message-ID: <7jqbhmskuzfvpjlavk7oqefmc72m5j2wj7525c7y2vlsfnaajx@57pfbmfvf4kt>
References: <20240409093510.12321-1-dwagner@suse.de>
 <20240409093510.12321-2-dwagner@suse.de>
 <ac48d955-8169-467d-962c-e7f55854ba06@grimberg.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac48d955-8169-467d-962c-e7f55854ba06@grimberg.me>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns,suse.de:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Tue, Apr 09, 2024 at 11:26:00PM +0300, Sagi Grimberg wrote:
> 
> 
> On 09/04/2024 12:35, Daniel Wagner wrote:
> > From: Hannes Reinecke <hare@suse.de>
> > 
> > Any authentication errors which are generated internally are always
> > non-retryable, so use negative error codes to ensure they are not
> > retried.
> 
> The patch title says that any authentication error is not retryable, and
> the patch body says "authentication errors which are generated locally
> are non-retryable" so which one is it?

Forgot to update the commit message. What about:

  All authentication errors are non-retryable, so use negative error
  codes to ensure they are not retried.

?

