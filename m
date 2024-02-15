Return-Path: <linux-kernel+bounces-66835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA556856229
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C37A1F21F97
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB4212B15C;
	Thu, 15 Feb 2024 11:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1jNKYzkL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4616469DFE;
	Thu, 15 Feb 2024 11:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707997845; cv=none; b=aEmVJVjEZ+O27p/Lgrnr4K2FRiRBj2QiQRKK78m9qDCmpmi9Wt3LM2nPIBTiGjGHixULTPpqfkRssNUcvDkl84ai4OHmPnWD3B103EldhbRKF9zAHecmhJ2pmB1wh59VV6ytZb2DR009MKPZbuW+HW4pKKfxEJOX/0+xI5Zvuts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707997845; c=relaxed/simple;
	bh=VOnAZGdJlyPOJMTv09bm7xiQrXM7tmo6hqbCLdeAUN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SPu8N69JCppDRV8dXSSH5ZkqLLwkEK6+jERZwSB5yO2qpX42FptADsJcJL3w51RdsPq6XMs1jOe8x2g0U5TuskAVHeyhp7Sc2wma1AjFtx15M9Lgsely9v+eEN3Dag6O6SiXvRqDE/Y6trt6lKL4CHGznvcAJS5HoboafW5Xigg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1jNKYzkL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E104C433F1;
	Thu, 15 Feb 2024 11:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707997844;
	bh=VOnAZGdJlyPOJMTv09bm7xiQrXM7tmo6hqbCLdeAUN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1jNKYzkLMaUu5FD+ms8xdddv1Cv3NlTOrDf0Z4mRCtbz0g4zKjxKgBDgXBahkjeqn
	 6qMKdffB28cI95vG5M94vrXSlWVDrgVnRZPqxm1h7qXpbAQrYoa33gq9DRVQZ2Htnd
	 gHtC4c1C4zjQtKAH1jQU29Kyacooc55H4FXQWjgI=
Date: Thu, 15 Feb 2024 12:50:41 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: corbet@lwn.net, workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, security@kernel.org,
	Kees Cook <keescook@chromium.org>, Sasha Levin <sashal@kernel.org>,
	Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v3] Documentation: Document the Linux Kernel CVE process
Message-ID: <2024021530-plank-cornmeal-90eb@gregkh>
References: <2024021430-blanching-spotter-c7c8@gregkh>
 <00057b93-b5fc-4536-b13d-cd3b6cead5b1@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00057b93-b5fc-4536-b13d-cd3b6cead5b1@oracle.com>

On Wed, Feb 14, 2024 at 09:37:31AM +0100, Vegard Nossum wrote:
> 
> On 14/02/2024 09:00, Greg Kroah-Hartman wrote:
> > diff --git a/Documentation/process/cve.rst b/Documentation/process/cve.rst
> > new file mode 100644
> > index 000000000000..6465e6a79c18
> > --- /dev/null
> > +++ b/Documentation/process/cve.rst
> > @@ -0,0 +1,120 @@
> > +CVEs
> > +====
> 
> Document titles should have ==== above them as well, and then you would
> need to shift all the other headings in this document (i.e. all the ---
> should become ===).
> 
> Info here: https://docs.kernel.org/doc-guide/sphinx.html#specific-guidelines-for-the-kernel-documentation

Really?  I copied this directly from
Documentation/process/security-bugs.rst which is in the format that I
used here.  Which one is incorrect, I'm confused.

> > +The Linux kernel developer team does have the ability to assign CVEs for
> > +potential Linux kernel security issues.  This assignment is independent
> > +of the :doc:`normal Linux kernel security bug reporting
> > +process<../process/security_bugs>`.
> 
> These documents are both under process/ so it should be enough to say:
> 
> :doc:`[...] <security-bugs>`
> 
> In fact, when building the docs with your patch applied, I see:
> 
> Documentation/process/cve.rst:15: WARNING: unknown document:
> ./process/security_bugs
> Documentation/process/cve.rst:42: WARNING: unknown document:
> ./process/security_bugs


Odd, I would have thought that going back a directory and then into it
would work, as that's how filesystems normally are handled :)

In fact, again, security-bugs.rst has this very format, which is why I
used it, is it throwing that same warning?

> Note the hyphen vs. underscore (it should have a hyphen like my line above).

Ah, ick, nevermind, my fault, I thought I built this with it added, I'll
go fix this up and use the hyphen.

> 
> > +Process
> > +-------
> > +
> > +As part of the normal stable release process, kernel changes that are
> > +potentially security issues are identified by the developers responsible
> > +for CVE number assignments and have CVE numbers automatically assigned
> > +to them.  These assignments are published on the linux-cve-announce
> > +mailing list as announcements on a frequent basis.
> > +
> > +Note, due to the layer at which the Linux kernel is in a system, almost
> > +any bug might be exploitable to compromise the security of the kernel,
> > +but the possibility of exploitation is often not evident when the bug is
> > +fixed.  Because of this, the CVE assignment team is overly cautious and
> 
> What is the composition of the CVE assignment team, or is that secret?
> Should this be a MAINTAINERS entry? (s@k.org is one.)

Yeah, it should be a MAINTAINERS entry, I'll add that as part of the
next version of this patch.

As for the composition, it's not a "secret", but I'd prefer not to list
it individually here.  As per the signed-off-by on this patch it's Lee,
Sasha, and I for now, but I anticipate it will change over time, much
like s@k.o has.

> > +If the CVE assignment team misses a specific fix that any user feels
> > +should have a CVE assigned to it, please email them at <cve@kernel.org>
> > +and the team there will work with you on it.  Note that no potential
> > +security issues should be sent to this alias, it is ONLY for assignment
> > +of CVEs for fixes that are already in released kernel trees.  If you
> > +feel you have found an unfixed security issue, please follow the
> > +:doc:`normal Linux kernel security bug reporting
> > +process<../process/security_bugs>`.
> 
> Same

Thanks, will fix.

> > +Disputes of assigned CVEs
> > +-------------------------
> > +
> > +The authority to dispute or modify an assigned CVE for a specific kernel
> > +change lies solely with the maintainers of the relevant subsystem
> > +affected.  This principle ensures a high degree of accuracy and
> > +accountability in vulnerability reporting.  Only those individuals with
> > +deep expertise and intimate knowledge of the subsystem can effectively
> > +assess the validity and scope of a reported vulnerability and determine
> > +its appropriate CVE designation.  Any attempt to modify or dispute a CVE
> > +outside of this designated authority could lead to confusion, inaccurate
> > +reporting, and ultimately, compromised systems.
> 
> Just to clarify, I think "dispute" here is used in the
> Mitre/CVE-technical meaning of the word, correct? I assume people will
> still have the right to say "hey, this doesn't look like a real issue
> [because of X/Y/Z]" on a mailing list.

Yes, mailing list discussion is always good and encouraged and is what
is covered here as well.  There is the MITRE use of "dispute" as well,
and that too is allowed if needed, so this covers both paths.

> 
> > --- a/Documentation/process/security-bugs.rst
> > +++ b/Documentation/process/security-bugs.rst
> > @@ -99,9 +99,8 @@ CVE assignment
> >   The security team does not assign CVEs, nor do we require them for
> >   reports or fixes, as this can needlessly complicate the process and may
> >   delay the bug handling.  If a reporter wishes to have a CVE identifier
> > -assigned, they should find one by themselves, for example by contacting
> > -MITRE directly.  However under no circumstances will a patch inclusion
> > -be delayed to wait for a CVE identifier to arrive.
> > +assigned for a confirmed issue, they can contact the :doc:`kernel CVE
> > +assignment team<../process/cve>` to obtain one.
> 
> Same here, this could be just <cve>.

I'll keep it to match the other references in this file :)

many thanks for the review!

greg k-h

