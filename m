Return-Path: <linux-kernel+bounces-84990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 040E386AEB0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 976021F28D90
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4EC73527;
	Wed, 28 Feb 2024 12:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="msGnkbfw";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="UDTgWxQH"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D672F73501
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 12:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709121860; cv=none; b=JZb99jtRJyWWdCWG4eTQCbgb22wZ+mQG5mjt/KADK0XuxQWgjA1rRbhHvlCVvMIDiXoPTEMCP4V9oqLSD3vjLMmKAbCDL4L3oXeprYeFBPtxp5KfC+Qaiejz3+mY2HblmyhInr/YuXwBxHEPprzonVdcdOmsfeQpi4Z1MOFYXYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709121860; c=relaxed/simple;
	bh=jov2Pibp8j5fYySB7FhWN7chymr34ARm/zfn03U14jY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VctcKILFmW9qd/FRCxiWKYPP1jcnKv9AlJOHCr61rOyH2+e3p9nesH5cshwXtyxOWsQi7nLAipASUE5dpZIQo09ydoCY8UJVeoNDJPVqt7N4y/xHNQ5s3HgTDX2nAyEwpixCjzcBYN3ga1ORQcKtLEzf4IoBWdAXT7iIMXAYoKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=msGnkbfw; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=UDTgWxQH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D1814223DF;
	Wed, 28 Feb 2024 12:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709121855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4pjkTaxzkgu+DE54ztxTNhryxVp6opyUnmdJ9nk8fyY=;
	b=msGnkbfw8KUUnldAYtKLQAp1eR+taag/zkMPk8su5Q5HmrDJ1j9KPiP6y8ALvStlw8nQXN
	s+bghodKCOmo7sJx2Xwt8YYUVPaOewBPeFnY6cUADR2y0jcDAAXyCnCiYZ6WFTTisyBdhI
	bZrNN1ZjZKejkGK7DlGIuk9O6iKjjKg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709121854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4pjkTaxzkgu+DE54ztxTNhryxVp6opyUnmdJ9nk8fyY=;
	b=UDTgWxQH8bJe0NuObwxRDEmE4UWd8aiHTnv2rAkqsDsEB/W44klpuDL+Sp5uEjVVfaYCZC
	1HwwRfqZsB2TxqrtBTAXY9ywuu6jCZnwSjjRQl9iO1YbpQs06t4T0t0Sryl/YmZM6shjHt
	UHur+rl1dF2/sXRKZnteuYaubmRSKPQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B666813A5D;
	Wed, 28 Feb 2024 12:04:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3EjwKD4h32X9UAAAD6G6ig
	(envelope-from <mhocko@suse.com>); Wed, 28 Feb 2024 12:04:14 +0000
Date: Wed, 28 Feb 2024 13:04:14 +0100
From: Michal Hocko <mhocko@suse.com>
To: Kees Cook <keescook@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, cve@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: CVE-2023-52451: powerpc/pseries/memhp: Fix access beyond end of
 drmem array
Message-ID: <Zd8hPpP_6q_o8uQW@tiehlicka>
References: <2024022257-CVE-2023-52451-7bdb@gregkh>
 <Zdylmz28rZ-mCeiN@tiehlicka>
 <2024022639-wronged-grafted-6777@gregkh>
 <ZdytVTOgfvKBBvtn@tiehlicka>
 <202402271029.FD67395@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202402271029.FD67395@keescook>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=UDTgWxQH
X-Spamd-Result: default: False [-3.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_LOW(-1.00)[suse.com:dkim];
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
X-Rspamd-Queue-Id: D1814223DF
X-Spam-Level: 
X-Spam-Score: -3.81
X-Spam-Flag: NO

On Tue 27-02-24 10:35:40, Kees Cook wrote:
> On Mon, Feb 26, 2024 at 04:25:09PM +0100, Michal Hocko wrote:
[...]
> > Does that mean that any potentially incorrect input provided by an admin is
> > considered CVE now?
> 
> Yes. Have you seen what USER_NS does? There isn't a way to know how
> deployments are using Linux, and this is clearly a "weakness" as defined
> by CVE. It is better to be over zealous than miss things.

If we are over zealous to the point when almost any fix is marked CVE
then the special marking simply stops making any sense IMHO.

> > I guess we would need to ban interfaces like /dev/mem and many others.
> 
> Yes. Absolutely. :) Have you seen CONFIG_STRICT_DEVMEM,
> CONFIG_IO_STRICT_DEVMEM, etc? Many deployments keep a bright line
> between root and kernel. There is a whole subsystem (lockdown) for
> working to enforce this.

Are you confusing hardening with security relevant fixes here? It makes
a lot of sense to reduce the attack space by sacrificing functionality
for some usecases but in general a large part of the kernel is built
around a "root can do anything" philosophy. Whether we like it or not.
And that means that we do not even pretend to protect dubious
configurations by root/CAP_SYSADMIN which could effectivelly DoS the
system (just consider hotplug/hotremove as an example - try to run your
workload when most CPUs or memory is offlined). Some operations are
simply not suited for untrusted entity.

[...]

> There's no harm in marking fixes for weaknesses as CVEs, so why the
> push back?

Because assigning CVEs nilly willy was the main downside of the prior
process and I was hoping that the new one, in hands of kernel people,
could be better and we could be getting more relevant CVEs.
-- 
Michal Hocko
SUSE Labs

