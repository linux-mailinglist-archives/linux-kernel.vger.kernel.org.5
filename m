Return-Path: <linux-kernel+bounces-87184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6685E86D0CF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72DF6B2345A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E2470AEE;
	Thu, 29 Feb 2024 17:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gRsoWfqL";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gRsoWfqL"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B175570AE6
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 17:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709228186; cv=none; b=Caz99SxyJ6FTHmFhBhCS01kt3EWzl+YV9luNgqGGNV4HdHnOmSeD1RcoyABJSKeobAFkri8aTgsMHAA/p+sLfbu5r0YMCo7OajPhrOA2Idgifx63JXNhD0yGpJ+6UbrQo4Bx0+jx2sUe0VEdRwmQp8DkiqKL4dNT/+r4vhbfCpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709228186; c=relaxed/simple;
	bh=iR3owAjar1QBrZxphTgj8xGOl+9mw9uymkrVoayhBog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=orBv7fqBAVdWR0LhemCiUEKH8QczYCnOVg6By7A1e4hQ4UTD0QUuJh6razWYlLf4FDFWvsIj04/v2dZvlMdRpQ2IO3gOOCuOTLzwbE+abb0bhfF4jOswUWsDAIlB19e1fz5ClaeedyxhhXEhyJr5dm1uqCv8UlDmor7jdXPwGa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gRsoWfqL; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gRsoWfqL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A57431FBEF;
	Thu, 29 Feb 2024 17:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709228182; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vpBFV488mGbzEhc4yj49r8uR7a9BeE38z4pBORJHIdw=;
	b=gRsoWfqL83bYLtZZX2oTiMMF/nqN/gVAL98f+vQWPSR91OeGKOx6EbHpF//e7/n+3TRBR5
	y4LBHgIU7LzJRunqAhL7pzgEebwj4gcPJbW32kdp8Tp+dnF6nlIA0OClrVwu7ih9rc2Fj1
	biET31QXeqPYr5BKuhnEd1lh2Bm7HH4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709228182; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vpBFV488mGbzEhc4yj49r8uR7a9BeE38z4pBORJHIdw=;
	b=gRsoWfqL83bYLtZZX2oTiMMF/nqN/gVAL98f+vQWPSR91OeGKOx6EbHpF//e7/n+3TRBR5
	y4LBHgIU7LzJRunqAhL7pzgEebwj4gcPJbW32kdp8Tp+dnF6nlIA0OClrVwu7ih9rc2Fj1
	biET31QXeqPYr5BKuhnEd1lh2Bm7HH4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8B8AE13503;
	Thu, 29 Feb 2024 17:36:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4LcaH5bA4GU3TwAAD6G6ig
	(envelope-from <mhocko@suse.com>); Thu, 29 Feb 2024 17:36:22 +0000
Date: Thu, 29 Feb 2024 18:36:21 +0100
From: Michal Hocko <mhocko@suse.com>
To: Kees Cook <kees@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kees Cook <keescook@chromium.org>, cve@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: CVE-2023-52451: powerpc/pseries/memhp: Fix access beyond end of
 drmem array
Message-ID: <ZeDAlRyp9L4L7f37@tiehlicka>
References: <2024022639-wronged-grafted-6777@gregkh>
 <ZdytVTOgfvKBBvtn@tiehlicka>
 <202402271029.FD67395@keescook>
 <Zd8hPpP_6q_o8uQW@tiehlicka>
 <202402280906.D6D5590DB@keescook>
 <ZeA-281OudkWBhd_@tiehlicka>
 <2024022915-dissuade-grandson-ebd4@gregkh>
 <ZeBRZqJd5HAKaOfC@tiehlicka>
 <2024022913-borrower-resource-ecc9@gregkh>
 <D06F40E5-0DBC-4FF2-BAF5-2373BDF3815C@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D06F40E5-0DBC-4FF2-BAF5-2373BDF3815C@kernel.org>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.81
X-Spamd-Result: default: False [-0.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.01)[46.37%]
X-Spam-Flag: NO

On Thu 29-02-24 07:08:06, Kees Cook wrote:
> 
> 
> On February 29, 2024 6:18:36 AM PST, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> >As part of the requirement to be a CNA, we have to announce everything
> >that we think is a potential vulnerability, severity not be judged at
> > [...]
> >Again, none of this has anything to do with "severity", it only is an
> >identifier that says "this fixes a vulnerability".
> 
> The language here can perhaps be improved for better understanding by
> folks since "CVE" and "vulnerability" can mean different things to
> different people. I would say "this fixes a weakness".
> 
> CVEs are for anything deemed a "weakness"[1]. It doesn't need to rise
> to the level of what many people would consider a "vulnerability".
> (Modern attacks traditionally chain many weaknesses together to form
> an exploit, some of which look harmless when examined in isolation.)
> 
> I find it helps to keep in mind the "CIA" acronym of what makes up a
> security weakness: "negative impact to Confidentiality, Integrity, or
> Availability". (Not to be confused with the US Gov intelligence org
> with the name acronym, ironically.)

Yes, this makes a lot of sense to me and I believe we are on the same
page here. We have gone in several tangents here but let me just remind
that I was objecting/wondering how much sense does it make to assign CVE
to configurations which are inherently insecure. From a user POV, does
it make me safer to have that addressed when the fundamental
configuration hole (to allow untrusted user to access said resources)
still in place. See my point or do I still fail to explain myself? It is
not about assuming usecases and whatnot.
 
> -Kees
> 
> [1] https://nvd.nist.gov/vuln

-- 
Michal Hocko
SUSE Labs

