Return-Path: <linux-kernel+bounces-68633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2B9857D8E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CED411C24A2C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0380F12A179;
	Fri, 16 Feb 2024 13:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="G3FFUq3M";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="G3FFUq3M"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6259C129A83;
	Fri, 16 Feb 2024 13:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708089628; cv=none; b=PD5WEpoGpjb3A6zfvAwhjuLfCzQWaEFDGF+4oB220NqRHF0zq1HvFoZ5OjLz92GR/smwTgeSJZIELSzfSChaBggMSUIJcVW6rKarI0PXOARyb+A7VcxABjLz91JMPWgCeqbZ+cvx2Irfa5DZHZ/mt5KWQlSwx74AzI57Isb6v+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708089628; c=relaxed/simple;
	bh=bJxg4Z7FZbLOZZEzBBNCpqMXlISUCHT2PafwJQHPV2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h8pPMV1zEZ/QSckvheNSt1cTnLTmHBuvflyYnkMo8u54Xnok4I+7xzLkJByQgkfqmVHJ94DM5mxo/aGspTBYZe/2fndX5lk4C32k1MAwStxoxAV331MsqfQla61VRvqeh0ijyOQNeoL5Gz4fGmArkvYaETS/Cb4IjU7wnbCMdWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=G3FFUq3M; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=G3FFUq3M; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1C99121D75;
	Fri, 16 Feb 2024 13:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708089605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=36yloTmQWTT4NjPbsklvFkRb4a1ADP6dUkZlqZAF7HA=;
	b=G3FFUq3MzI5thvxz6QmPZtj4k34Gk8Fh0LPitbrt6vA8S6P4N7reW9EKEhHoFL0iHIJwiC
	j4pj82wNjB5pzCtNeUojXupLrs16udIbvWNQS8Ta7usebQPUv4BtdWQ0zFjat2AwTt0wDZ
	Fj7A3Ao4gDLqKY/42UbTJwEz6+yYBTc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708089605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=36yloTmQWTT4NjPbsklvFkRb4a1ADP6dUkZlqZAF7HA=;
	b=G3FFUq3MzI5thvxz6QmPZtj4k34Gk8Fh0LPitbrt6vA8S6P4N7reW9EKEhHoFL0iHIJwiC
	j4pj82wNjB5pzCtNeUojXupLrs16udIbvWNQS8Ta7usebQPUv4BtdWQ0zFjat2AwTt0wDZ
	Fj7A3Ao4gDLqKY/42UbTJwEz6+yYBTc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 02B6B13A39;
	Fri, 16 Feb 2024 13:20:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bUnmOQRhz2X5IwAAD6G6ig
	(envelope-from <mhocko@suse.com>); Fri, 16 Feb 2024 13:20:04 +0000
Date: Fri, 16 Feb 2024 14:20:04 +0100
From: Michal Hocko <mhocko@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: corbet@lwn.net, workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, security@kernel.org,
	Kees Cook <keescook@chromium.org>, Sasha Levin <sashal@kernel.org>,
	Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v3] Documentation: Document the Linux Kernel CVE process
Message-ID: <Zc9hBJuca3f_5KHx@tiehlicka>
References: <2024021430-blanching-spotter-c7c8@gregkh>
 <Zc5PycMenLBYECAn@tiehlicka>
 <2024021518-stature-frightful-e7fc@gregkh>
 <Zc5ZpB6jsuTKmhv5@tiehlicka>
 <2024021646-procedure-faceted-ea87@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024021646-procedure-faceted-ea87@gregkh>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=G3FFUq3M
X-Spamd-Result: default: False [-4.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 1C99121D75
X-Spam-Level: 
X-Spam-Score: -4.81
X-Spam-Flag: NO

On Fri 16-02-24 12:25:46, Greg KH wrote:
> On Thu, Feb 15, 2024 at 07:36:20PM +0100, Michal Hocko wrote:
> > On Thu 15-02-24 19:20:09, Greg KH wrote:
> > > On Thu, Feb 15, 2024 at 06:54:17PM +0100, Michal Hocko wrote:
> > > > On Wed 14-02-24 09:00:30, Greg KH wrote:
> > > > [...]
> > > > > +Process
> > > > > +-------
> > > > > +
> > > > > +As part of the normal stable release process, kernel changes that are
> > > > > +potentially security issues are identified by the developers responsible
> > > > > +for CVE number assignments and have CVE numbers automatically assigned
> > > > > +to them.  These assignments are published on the linux-cve-announce
> > > > > +mailing list as announcements on a frequent basis.
> > > > > +
> > > > > +Note, due to the layer at which the Linux kernel is in a system, almost
> > > > > +any bug might be exploitable to compromise the security of the kernel,
> > > > > +but the possibility of exploitation is often not evident when the bug is
> > > > > +fixed.  Because of this, the CVE assignment team is overly cautious and
> > > > > +assign CVE numbers to any bugfix that they identify.  This
> > > > > +explains the seemingly large number of CVEs that are issued by the Linux
> > > > > +kernel team.
> > > > 
> > > > Does the process focus only on assigning CVE numbers to a given upstream
> > > > commit(s) withou any specifics of the actual security threat covered by
> > > > the said CVE?
> > > 
> > > Outside of the git commit text, no, we are not going to be adding
> > > anything additional to the report, UNLESS someone wants to add
> > > additional text to it, and then we will be glad to update a CVE entry
> > > with the additional information.
> > 
> > OK, so what is the point of having CVE assigned to such a commit without
> > any addional information which is already referenced by the kernel sha?
> > What is the actual added value of that CVE?
> 
> It provides the proper signal to others that "hey, this is a
> vulnerability that you might want to take if it affects you".

OK, but stating that something is a vulnerability fix requires a proper
analysis and this is a non trivial work. The wording here indicates that
most of the fixes will gain their CVE. The existing process really sucks
because there are just too many CVEs which really do not have any
security implications but it seems that the new process is not going to
address that because it will likely generate even more CVEs.

> Right now
> we are fixing lots and lots of things and no one notices as their
> "traditional" path of only looking at CVEs for the kernel is totally
> incorrect.

Right, there are quite a lot of people who consider CVE fixes much more
important than regular fixes. Their reasoning might be completely
misleading but there might be very good reasons to stick to minimalistic
approach, e.g. to reduce risk of regressions.

I believe it is perfectly fair to say that whoever relies on stable
kernels support needs to update to the latest stable kernel version to
be covered by security and functional fixes. On the other hand I do not
think it is an improvement to the process to swamp CVE database with any
random fixes without a proper evaluation. If the kernel community
doesn't believe in the CVE process then fair enough, just do not assign
them unless you want to explicitly call out fixes with a high impact
security implications. Having fewer good quality CVEs would definitely
improve the process.

> > > Here's an example of what the CVE announcement is going to look like for
> > > a "test" that we have been doing for our scripts
> > > 	https://lore.kernel.org/linux-cve-announce/2024021353-drainage-unstuffed-a7c0@gregkh/T/#u
> > 
> > Thanks this gave me some idea. One worrying part is
> > : Please note that only supported kernel versions have fixes applied to
> > : them.  For a full list of currently supported kernel versions, please
> > : see https://www.kernel.org/
> > 
> > >From the above it is not really clear "supported by _whom_". Because I
> > am pretty sure there are _fully_ supported kernels outside of that list
> > which are actively maintained.
> 
> Very true, how about this wording change:
> 	For a full list of currently supported kernel versions by the
> 	kernel developer community, please see https://www.kernel.org/
> 
> I added "by the kernel developer community", is that ok?

That sound much better!
 
> And as you're here, I have no objection to adding the vulnerable/fixes
> info from various distros that are curently based on these same
> kernel.org versions if you wish to provide them to me.

I cannot speak for distro kernels in general. I can tell you that we at
Suse do not base our product kernels on stable trees and we
carefully evaluate backports we commit to support. 
-- 
Michal Hocko
SUSE Labs

