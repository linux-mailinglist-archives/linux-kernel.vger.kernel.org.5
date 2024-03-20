Return-Path: <linux-kernel+bounces-109105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BF38814A8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E2A11F22934
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1AD5337F;
	Wed, 20 Mar 2024 15:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Y69+HU/K";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jIIRKzYB"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9AB52F72
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 15:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710948780; cv=none; b=Un78vpKER1I7rZeFiqi3KXdZcE5+A8gX1CQoe9fwXzxRlavMmKNzI985FGrcdQa3l0XU5gCYUBwBO9q9KlrwsiXpZ6NKLaSCtmQjWQfFe7p5H+plB2bndTH6zP1ATPCEx700hP7OLL/O2XTK+5y1nnKK+tOGeQcNCyvpRP4A4hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710948780; c=relaxed/simple;
	bh=9DKwmJA6NEyAQK3sV5H39Vsofb3sShz1AX12hxALOoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nNyY7Fus0QCqn69DHFdMOGPysbP0WlEhSiCNvfD14xgEbcUgT4YDuo6S195+YrfvNCF03rnrblXAJ2NXJVb1QgmZcQ6mpCTTER2yNevZ6+DHICWErMWYApd3p5wV6vCKDk7OaPeEZpPQ5R3VMujONjlvB1IqtOx16pjLr53g1vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Y69+HU/K; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jIIRKzYB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D8B075BE3C;
	Wed, 20 Mar 2024 15:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710948774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fcgA/LAaTzB6OivxiOGHwrjOxlKpwBP2Iv+D1ySwstg=;
	b=Y69+HU/KVa9uliJeKs9vRcxXmL26v+L1H+2L46QjXankBLqUBDex1nX4V1FBi1X5sR4L0/
	KZpMR2xrHRdxXGUy/HjB32bmV5I/aEi+1pWab5ZYR8/eq9jDhf9oYjP3BkP78EbjgKbXgx
	wEK3Uqf9HA+RKtKIsBw2/HK/O6LPG8g=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710948773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fcgA/LAaTzB6OivxiOGHwrjOxlKpwBP2Iv+D1ySwstg=;
	b=jIIRKzYBzefja39B8cCIVsTnWgoC0lg953Oet6vBEgq5oDkL9TGw/YAhNWL24oeqUucCMR
	j7nk8xCyQbWWfhE+rk4vqvPYyvl6YAYp2Hg1Og145zlWuKWLkixeHA4Luhdr9f6ky/3khZ
	j2z+SBz3Ds2q/oLJ5rS84VI5iEabK1E=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BFF6E136CD;
	Wed, 20 Mar 2024 15:32:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QlPhK6UB+2W2VQAAD6G6ig
	(envelope-from <mhocko@suse.com>); Wed, 20 Mar 2024 15:32:53 +0000
Date: Wed, 20 Mar 2024 16:32:53 +0100
From: Michal Hocko <mhocko@suse.com>
To: Lee Jones <lee@kernel.org>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Felix Kuehling <felix.kuehling@amd.com>
Subject: Re: CVE-2024-26628: drm/amdkfd: Fix lock dependency warning
Message-ID: <ZfsBpal_29lihveI@tiehlicka>
References: <2024030649-CVE-2024-26628-f6ce@gregkh>
 <Zerheyn-4rB5kySt@tiehlicka>
 <20240314110938.GM1522089@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314110938.GM1522089@google.com>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=jIIRKzYB
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.57 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 RCPT_COUNT_FIVE(0.00)[5];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.56)[92.15%]
X-Spam-Score: -2.57
X-Rspamd-Queue-Id: D8B075BE3C
X-Spam-Flag: NO

On Thu 14-03-24 11:09:38, Lee Jones wrote:
> On Fri, 08 Mar 2024, Michal Hocko wrote:
> 
> > On Wed 06-03-24 06:46:11, Greg KH wrote:
> > [...]
> > >  Possible unsafe locking scenario:
> > > 
> > >        CPU0                    CPU1
> > >        ----                    ----
> > >   lock(&svms->lock);
> > >                                lock(&mm->mmap_lock);
> > >                                lock(&svms->lock);
> > >   lock((work_completion)(&svm_bo->eviction_work));
> > > 
> > > I believe this cannot really lead to a deadlock in practice, because
> > > svm_range_evict_svm_bo_worker only takes the mmap_read_lock if the BO
> > > refcount is non-0. That means it's impossible that svm_range_bo_release
> > > is running concurrently. However, there is no good way to annotate this.
> > 
> > OK, so is this even a bug (not to mention a security/weakness)?
> 
> Looks like the patch fixes a warning which can crash some kernels.  So
> the CVE appears to be fixing that, rather than the impossible deadlock.

Are you talking about lockdep warning or anything else?
-- 
Michal Hocko
SUSE Labs

