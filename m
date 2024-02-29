Return-Path: <linux-kernel+bounces-86460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B22986C5C7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E65F21F22E5F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A18612C8;
	Thu, 29 Feb 2024 09:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XdmuToZo";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XdmuToZo"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CC05C8F0
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 09:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709199723; cv=none; b=Lk6OZdSxet8sNyao9mZppDSpaCyUJIyKu8oLl3VNNrXL42ZGsBRpiHcSHS2yjKwrgraALcED31nIqi/NifC6Tkb3oug5OD2JOWu3mEbJrjfnujRgjCJu+eA2T3Zu1YLA+nBeKqzNtLOuxWhUf+pWf6vggKaYhq0+s9JUdnDWobs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709199723; c=relaxed/simple;
	bh=/mBXV53WulteDcvR8dDrevwD0s+KkDhaDS5CqNJmIYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cybIugRYBNAVMw2AhDbtYkwv4BUDojzjsNf2j7af5/iilMswXlM4A+27b5geC4lw6OGmvR2x6kBTjIEz9DP/2FlLB0R8WnV889UAzeC3Hy9UczCVS7UREFQOrF+MWHRucd80zXk+japbEjvzVM3/rvGslouiOywuihuJ+Zwl2/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XdmuToZo; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XdmuToZo; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9F8CC1F7C8;
	Thu, 29 Feb 2024 09:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709199719; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=spRx96ENNCXfL1l9e0BeMKwO+LRo9ufE1pB74CExPTU=;
	b=XdmuToZoNyd+bJan45ppVJSBo0dyDwGx2O7Yj2CA4gLOpg+nek3gqEPvcl2Mo7jGZQEPUJ
	gOzkn9ESQKegfwPFWGJY9XFh7X6cjKCx/eVM3nUdR/mIvzL00hyniYcCxQHLmopSADK0vE
	qBUMMjKL7y7jA6V7f38BtDzal600V5Y=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709199719; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=spRx96ENNCXfL1l9e0BeMKwO+LRo9ufE1pB74CExPTU=;
	b=XdmuToZoNyd+bJan45ppVJSBo0dyDwGx2O7Yj2CA4gLOpg+nek3gqEPvcl2Mo7jGZQEPUJ
	gOzkn9ESQKegfwPFWGJY9XFh7X6cjKCx/eVM3nUdR/mIvzL00hyniYcCxQHLmopSADK0vE
	qBUMMjKL7y7jA6V7f38BtDzal600V5Y=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 86F1313503;
	Thu, 29 Feb 2024 09:41:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AiV+HmdR4GXcXAAAD6G6ig
	(envelope-from <mhocko@suse.com>); Thu, 29 Feb 2024 09:41:59 +0000
Date: Thu, 29 Feb 2024 10:41:58 +0100
From: Michal Hocko <mhocko@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kees Cook <keescook@chromium.org>, cve@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: CVE-2023-52451: powerpc/pseries/memhp: Fix access beyond end of
 drmem array
Message-ID: <ZeBRZqJd5HAKaOfC@tiehlicka>
References: <2024022257-CVE-2023-52451-7bdb@gregkh>
 <Zdylmz28rZ-mCeiN@tiehlicka>
 <2024022639-wronged-grafted-6777@gregkh>
 <ZdytVTOgfvKBBvtn@tiehlicka>
 <202402271029.FD67395@keescook>
 <Zd8hPpP_6q_o8uQW@tiehlicka>
 <202402280906.D6D5590DB@keescook>
 <ZeA-281OudkWBhd_@tiehlicka>
 <2024022915-dissuade-grandson-ebd4@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024022915-dissuade-grandson-ebd4@gregkh>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=XdmuToZo
X-Spamd-Result: default: False [-2.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
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
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 9F8CC1F7C8
X-Spam-Level: 
X-Spam-Score: -2.81
X-Spam-Flag: NO

On Thu 29-02-24 09:35:28, Greg KH wrote:
[...]
> How does taking 10 patches differ from taking 200 patches?  Your
> testing/infrastructure issues should be the same, right?

You would be right if there was a test of every/most of the applied
patches. Which is not the case. The testing is merely about nothing has
broken in an obvious way. I hope we can agree that more patches that are
taken the larger the risk is.

I would have a much higher confidence in stable patches if they were
properly reviewed in the context of the tree they are applied to. This
is not done for the vast majority of them though.  I simply do not trust
"it applies so it is OK(ish)" approach.

> And really, if you have the crazy requirement of "All CVEs must be
> applied" then perhaps that needs to be revisited?  You are dictating
> your business's processes to an external entity, is that wise?

I do not think we (Suse) have any policy like that. We do evaluate CVEs
and other fixes and make risk/benefit based decisions. This is a
demanding process to say the least but it has allowed for very stable
code base.

> And if
> it is wise, why are you not able to handle it today?  Making it simpler
> for you to consume these entries seems to be a better decision.  With
> the changes we have made, you should be able to automatically determine
> if you are affected or not, which is something that you did NOT have
> before, so this might just be able to be automated, right?

Not really. The most of those fixes already do have stable or Fixes tags
so automation doesn't really require CVE number. If anybody is
interested to follow fixes in general then all the proper metadata are
already there.

> > > This has been a long standing problem with communicating this
> > > to engineering management in many organizations. They have pointed to
> > > the relatively small number of CVEs and said, "just backport those
> > > fixes", and trying to explain that it's is totally insufficient falls on
> > > deaf ears.
> > 
> > I think it is fair to say/expect that every downstream is responsibile
> > for the kernel they are distributing and that applies to vulnerabilities
> > affecting those kernels. Forcing fixes by slapping CVE over them sounds
> > just very dubious to me.
> 
> Not having CVEs assigned for things that can cause issues is dubious,
> which is why we are doing this.  We can not determine use cases of our
> code base, that is up to you as a distro to figure out, all we can do is
> our best to call out "This might be something you want to take!" which
> is what we are doing here.

You are missing my point I am afraid. Downstreams do not need CVE numbers
to fish for useful fixes. Downstreams, however, would appreciate the call
out serious security problems to treat them with higher priority because
believe me it makes a huge difference to address an exploitable problem
promptly rather than one that is affecting a misconfigured system which
is by definition vulnerable. And while I am sympathetic with your "we
cannot assume usecases" statement, I believe we can still tell a
difference that some configurations simply make no sense from the
security perspective.

> Remember, we KNOW that people have been scraping our commit logs for
> these types of things and using them in attacks for years.  At least
> this way we are giving you a machine-parsable feed that gives you the
> opportunity to make your kernels more secure than they previously were.

They are going to do that whether you stick CVE on top or not.
 
> Why is that not a good thing?

Because the more dubious or outright bogus CVEs there are the less
meaningful they will become.

Look, it seems there is a huge gap in our understanding of what the CVE
is good for. I was really hopeful that the noise/signal ratio would be
better with the new model but that doesn't seem to be the case so far. I
was also hoped that the dispute process would be improved but judging
from the discussion so far I have lost that hope as well.

Please asked yourself again who is going to benefit from this. Stable
users certainly not, because they are supposed to use the latest stable
kernels so all the fixes (no matter of CVE), downstreams based on stable
kernels will not benefit either because of the same reason. Downstreams
which are not based on stable trees will not benefit either because of
the low signal/noise ratio and will need to find a better way to find
important and safe fixes. Probably the only winner will be those fancy
CVE scanners which will have more to scan.
-- 
Michal Hocko
SUSE Labs

