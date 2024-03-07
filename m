Return-Path: <linux-kernel+bounces-95327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39AD8874C43
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E91F72831E7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A5885277;
	Thu,  7 Mar 2024 10:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="YzJRhUBi"
Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch [45.157.188.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F297D8289C
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 10:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709806940; cv=none; b=VyDH3Q/Yi08GI1Se0hS62nuv+pucRRUHxBcXJT17U2C0ZnqBWgC94Z3E4ZHd4vo4DnOeGeZaxEkIx5v5ugwjD7NXXJg2m5edFCwxV2ATN012qgG1tKxS4IRs16jL7m/POltZHiiln8TecfXBdk7la49XvQRaAUZkh6sY8s2nRsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709806940; c=relaxed/simple;
	bh=3wfPwwhLAgLaMHVJF2tSLdLHhhmhu0GsZ2XZGA/5oOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jX9GZIJLBDOLQ7NoUvdruSxuwd+h4eaPBdHtjaGEq1tN6cthRgtLucIIsiM/xnCTRLDuYrnmFP0P2u/duBbDF33X9t2XNKph0M0qkrWs/v2oNy3ZoSVI8Vpy4MJ82KFb7sEmVyW0I/q7RhYgtCCDrn1VUtyelLR8GQUDeW8FtPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=YzJRhUBi; arc=none smtp.client-ip=45.157.188.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [10.7.10.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Tr52S3kpTzMqbGB;
	Thu,  7 Mar 2024 11:22:08 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Tr52R5XlPzQVF;
	Thu,  7 Mar 2024 11:22:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1709806928;
	bh=3wfPwwhLAgLaMHVJF2tSLdLHhhmhu0GsZ2XZGA/5oOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YzJRhUBimplUlxe27u0ZbbJbY4lpfXMY1nQe/nGbp3tgjFOR5655B0YKGa7vOT0Wc
	 gyA5oSBrGE6GXO3unN2umndpix5LMhBR6qM9azMdzivkq3+JRDPBCXZ/WjYEOxbosR
	 2r3kTFP7LpReBITwCp5p+x6KAnaEEnSB/b5Jmums=
Date: Thu, 7 Mar 2024 11:21:57 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Alejandro Colomar <alx@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Shervin Oloumi <enlightened@chromium.org>, linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2 1/2] landlock: Extend documentation for kernel support
Message-ID: <20240307.oxQuab5tho0u@digikod.net>
References: <20240227110550.3702236-1-mic@digikod.net>
 <Zd4OlL1G3t1D3TgC@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zd4OlL1G3t1D3TgC@google.com>
X-Infomaniak-Routing: alpha

CCing Alejandro

On Tue, Feb 27, 2024 at 05:32:20PM +0100, Günther Noack wrote:
> On Tue, Feb 27, 2024 at 12:05:49PM +0100, Mickaël Salaün wrote:
> > Extend the kernel support section with one subsection for build time
> > configuration and another for boot time configuration.
> > 
> > Extend the boot time subsection with a concrete example.
> > 
> > Update the journalctl command to include the boot option.
> > 
> > Cc: Günther Noack <gnoack@google.com>
> > Cc: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > ---
> > 
> > Changes since v1:
> > * New patch, suggested by Kees Cook.
> > ---
> >  Documentation/userspace-api/landlock.rst | 57 +++++++++++++++++++++---
> >  1 file changed, 51 insertions(+), 6 deletions(-)
> > 
> > diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
> > index 2e3822677061..838cc27db232 100644
> > --- a/Documentation/userspace-api/landlock.rst
> > +++ b/Documentation/userspace-api/landlock.rst
> > +Boot time configuration
> > +-----------------------
> > +
> >  If the running kernel does not have ``landlock`` in ``CONFIG_LSM``, then we can
> > -still enable it by adding ``lsm=landlock,[...]`` to
> > +enable Landlock by adding ``lsm=landlock,[...]`` to
> >  Documentation/admin-guide/kernel-parameters.rst thanks to the bootloader
> >  configuration.
> 
> I would suggest: s/thanks to/in/

OK

> 
> > +For example, if the current built-in configuration is:
> > +
> > +.. code-block:: console
> > +
> > +    $ zgrep -h "^CONFIG_LSM=" "/boot/config-$(uname -r)" /proc/config.gz 2>/dev/null
> > +    CONFIG_LSM="lockdown,yama,integrity,apparmor"
> > +
> > +...and if the cmdline doesn't contain ``landlock`` either:
> > +
> > +.. code-block:: console
> > +
> > +    $ sed -n 's/.*\(\<lsm=\S\+\).*/\1/p' /proc/cmdline
> > +    lsm=lockdown,yama,integrity,apparmor
> > +
> > +...we should configure the bootloader to set a cmdline extending the ``lsm``
> > +list with the ``landlock,`` prefix::
> 
> Nit: Is the double colon at the end of this line accidental?
> (It does not appear before the previous code block.)

The "::" creates an implicit text block with the following text.  For the
other block I used an explicit code-block, which then doesn't require
this "::".

> 
> > +
> > +  lsm=landlock,lockdown,yama,integrity,apparmor
> > +
> > +After a reboot, we can check that Landlock is up and running by looking at
> > +kernel logs:
> > +
> > +.. code-block:: console
> > +
> > +    # dmesg | grep landlock || journalctl -kb -g landlock
> > +    [    0.000000] Command line: [...] lsm=landlock,lockdown,yama,integrity,apparmor
> > +    [    0.000000] Kernel command line: [...] lsm=landlock,lockdown,yama,integrity,apparmor
> > +    [    0.000000] LSM: initializing lsm=lockdown,capability,landlock,yama,integrity,apparmor
> > +    [    0.000000] landlock: Up and running.
> > +
> > +Note that according to the built time kernel configuration,
> 
> s/built time/build time/
>                  ^

OK

> 
> It feels like the phrase "according to" could be slightly more specific here.
> 
> To paraphrase Alejandro Colomar, "Note that" is usually redundant.
> https://lore.kernel.org/all/0aafcdd6-4ac7-8501-c607-9a24a98597d7@gmail.com/
> 
> I'd suggest:
> 
>   The kernel may be configured at build time to always load the ``lockdown`` and
>   ``capability`` LSMs.  In that case, these LSMs will appear at the beginning of
>   the ``LSM: initializing`` log line as well, even if they are not configured in
>   the boot loader.

OK, I integrated your suggestion.  I guess `capability` is not really
considered an LSM but it would be too confusing and out of scope for an
user documentation to explain that.

> 
> > +``lockdown,capability,`` may always stay at the beginning of the ``LSM:
> > +initializing lsm=`` list even if they are not configured with the bootloader,
> 
> Nit: The man pages spell this in two words as "boot loader".

OK, I'll use "boot loader" too.

> 
> 
> > +which is OK.
> > +
> > +Network support
> > +---------------
> > +
> >  To be able to explicitly allow TCP operations (e.g., adding a network rule with
> >  ``LANDLOCK_ACCESS_NET_BIND_TCP``), the kernel must support TCP
> >  (``CONFIG_INET=y``).  Otherwise, sys_landlock_add_rule() returns an
> > 
> > base-commit: b4007fd27206c478a4b76e299bddf4a71787f520
> > -- 
> > 2.44.0
> > 
> 
> Reviewed-by: Günther Noack <gnoack@google.com>

Thanks!

