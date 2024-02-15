Return-Path: <linux-kernel+bounces-67523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 081E6856CD0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D3091C208C8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD7C1386BE;
	Thu, 15 Feb 2024 18:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="E1MXLBzZ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="E1MXLBzZ"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7A179958;
	Thu, 15 Feb 2024 18:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708022185; cv=none; b=NvmaK2cjYums5f/yCE72L6Q6/CxUuJVDa2NUCuOKwUFF65tI3rsHkbAF/ur2Nag9+no2cnzXBnvHQhsANE0IxbiKyClR7uqMyDuwjYwKigl0ftpexX15JRUP7fjZdxXW/ppC3MxYe3MIdmpE3GQi+cc3k+fkYnodFZAoRIE9+FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708022185; c=relaxed/simple;
	bh=cqkZb2AW52urfGkdn7ilr6fwR5inqx8htNbTKkmCQTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOc6HKjoDHEtabZbfJY4zk4gUhvYao/lR4ttO/7KEWRQnG2bh/pVXNHLn4klTwI2A/sXRWdCEU/VTJu/egTLl1rOv4ZXVIzpbL8FHJsqCEiMmll6ul7G1iXRHob5s9kRG12fJS99XyCX4bDnk8HRh+TtSGSt1HvK4SDQLd15el8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=E1MXLBzZ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=E1MXLBzZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 53E091F8D9;
	Thu, 15 Feb 2024 18:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708022181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vLhyLE2nQAAth2l/4rRuG/vsRIUDmsoRm+VuUP3aA/8=;
	b=E1MXLBzZa1mHvBu6hH+35Vt0Rp05+HnxxpmIRQhix9DT04oKDblToaOh0pha++UKKBv8dI
	VMOA1ethmBKKludCeWoTe0nGPWiQSxIWJ1020RCTqi8Os+2k3cgyGE+SXxC9isPEN0fTr7
	NRbG+pjhhjdavn3GmjXpP8pbKY1O3Ds=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708022181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vLhyLE2nQAAth2l/4rRuG/vsRIUDmsoRm+VuUP3aA/8=;
	b=E1MXLBzZa1mHvBu6hH+35Vt0Rp05+HnxxpmIRQhix9DT04oKDblToaOh0pha++UKKBv8dI
	VMOA1ethmBKKludCeWoTe0nGPWiQSxIWJ1020RCTqi8Os+2k3cgyGE+SXxC9isPEN0fTr7
	NRbG+pjhhjdavn3GmjXpP8pbKY1O3Ds=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 28E3213A82;
	Thu, 15 Feb 2024 18:36:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id R3lXB6VZzmWeIwAAD6G6ig
	(envelope-from <mhocko@suse.com>); Thu, 15 Feb 2024 18:36:21 +0000
Date: Thu, 15 Feb 2024 19:36:20 +0100
From: Michal Hocko <mhocko@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: corbet@lwn.net, workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, security@kernel.org,
	Kees Cook <keescook@chromium.org>, Sasha Levin <sashal@kernel.org>,
	Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v3] Documentation: Document the Linux Kernel CVE process
Message-ID: <Zc5ZpB6jsuTKmhv5@tiehlicka>
References: <2024021430-blanching-spotter-c7c8@gregkh>
 <Zc5PycMenLBYECAn@tiehlicka>
 <2024021518-stature-frightful-e7fc@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024021518-stature-frightful-e7fc@gregkh>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=E1MXLBzZ
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.01 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_LOW(-1.00)[suse.com:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Score: -5.01
X-Rspamd-Queue-Id: 53E091F8D9
X-Spam-Flag: NO

On Thu 15-02-24 19:20:09, Greg KH wrote:
> On Thu, Feb 15, 2024 at 06:54:17PM +0100, Michal Hocko wrote:
> > On Wed 14-02-24 09:00:30, Greg KH wrote:
> > [...]
> > > +Process
> > > +-------
> > > +
> > > +As part of the normal stable release process, kernel changes that are
> > > +potentially security issues are identified by the developers responsible
> > > +for CVE number assignments and have CVE numbers automatically assigned
> > > +to them.  These assignments are published on the linux-cve-announce
> > > +mailing list as announcements on a frequent basis.
> > > +
> > > +Note, due to the layer at which the Linux kernel is in a system, almost
> > > +any bug might be exploitable to compromise the security of the kernel,
> > > +but the possibility of exploitation is often not evident when the bug is
> > > +fixed.  Because of this, the CVE assignment team is overly cautious and
> > > +assign CVE numbers to any bugfix that they identify.  This
> > > +explains the seemingly large number of CVEs that are issued by the Linux
> > > +kernel team.
> > 
> > Does the process focus only on assigning CVE numbers to a given upstream
> > commit(s) withou any specifics of the actual security threat covered by
> > the said CVE?
> 
> Outside of the git commit text, no, we are not going to be adding
> anything additional to the report, UNLESS someone wants to add
> additional text to it, and then we will be glad to update a CVE entry
> with the additional information.

OK, so what is the point of having CVE assigned to such a commit without
any addional information which is already referenced by the kernel sha?
What is the actual added value of that CVE?

> Here's an example of what the CVE announcement is going to look like for
> a "test" that we have been doing for our scripts
> 	https://lore.kernel.org/linux-cve-announce/2024021353-drainage-unstuffed-a7c0@gregkh/T/#u

Thanks this gave me some idea. One worrying part is
: Please note that only supported kernel versions have fixes applied to
: them.  For a full list of currently supported kernel versions, please
: see https://www.kernel.org/

From the above it is not really clear "supported by _whom_". Because I
am pretty sure there are _fully_ supported kernels outside of that list
which are actively maintained.
-- 
Michal Hocko
SUSE Labs

