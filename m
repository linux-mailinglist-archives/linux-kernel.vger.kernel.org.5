Return-Path: <linux-kernel+bounces-86283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E96486C361
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E41C81F227DA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6299481CE;
	Thu, 29 Feb 2024 08:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="d1ek/UX3";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="d1ek/UX3"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672644EB23
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 08:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709194976; cv=none; b=WUuV8XyicrIdnnhLHNXmJwSWJPJB9gUMEajPlxrBUpoyxihXf57QvlDvH4F8tLLXUOtA8mYtne0XVYJYf7tsXgyQLpwiOezURdUmK7Bb9qH90LsLhB3vQWXpzMEvWeNga7a90KgsWqI6yEchKoa6C74b8n2PSm4B14l9B9rAbBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709194976; c=relaxed/simple;
	bh=bPF2YbkEpmtIU2i5MPXXf9UnKzojtrmHcH22PccGBFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJBAiP5d9Q9bqgJYrmt2C6banobnaUiaVzsmBuk/eT7d6WmhNFTANmS5MgmCCTt/CJqHDxdmHNwlOOjBZpIQg7k6wjRaAy6kVWuqsRsP8lPPZb4HqRWJVYoamws943Gj4cxyiniY0qdonl5X8ZvAQoyleCcDNBLBcZ9ic8YS1r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=d1ek/UX3; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=d1ek/UX3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 83935228B9;
	Thu, 29 Feb 2024 08:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709194972; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MW2luePY0HevCcovwObd3ZjzFMxMkkEUPysfSuWg8hg=;
	b=d1ek/UX3yjtZCAK+SigLd8tpnFyU61VQOZyjBFawKz65TcQaQJTs5QeqUg9JGpLWHTBbSh
	hG6Nc9rzTdcFzIG5C0wJqtFWYpjsPzFM3jmSsMqQKZ5vOBg4vdZX8WCQhTk7J777S3aof0
	QzpsqSIvtYIRKcGZfupKqkp+4txgzS0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709194972; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MW2luePY0HevCcovwObd3ZjzFMxMkkEUPysfSuWg8hg=;
	b=d1ek/UX3yjtZCAK+SigLd8tpnFyU61VQOZyjBFawKz65TcQaQJTs5QeqUg9JGpLWHTBbSh
	hG6Nc9rzTdcFzIG5C0wJqtFWYpjsPzFM3jmSsMqQKZ5vOBg4vdZX8WCQhTk7J777S3aof0
	QzpsqSIvtYIRKcGZfupKqkp+4txgzS0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 591E913A58;
	Thu, 29 Feb 2024 08:22:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uRp4Etw+4GUqSgAAD6G6ig
	(envelope-from <mhocko@suse.com>); Thu, 29 Feb 2024 08:22:52 +0000
Date: Thu, 29 Feb 2024 09:22:51 +0100
From: Michal Hocko <mhocko@suse.com>
To: Kees Cook <keescook@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, cve@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: CVE-2023-52451: powerpc/pseries/memhp: Fix access beyond end of
 drmem array
Message-ID: <ZeA-281OudkWBhd_@tiehlicka>
References: <2024022257-CVE-2023-52451-7bdb@gregkh>
 <Zdylmz28rZ-mCeiN@tiehlicka>
 <2024022639-wronged-grafted-6777@gregkh>
 <ZdytVTOgfvKBBvtn@tiehlicka>
 <202402271029.FD67395@keescook>
 <Zd8hPpP_6q_o8uQW@tiehlicka>
 <202402280906.D6D5590DB@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202402280906.D6D5590DB@keescook>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Wed 28-02-24 09:12:15, Kees Cook wrote:
> On Wed, Feb 28, 2024 at 01:04:14PM +0100, Michal Hocko wrote:
> > On Tue 27-02-24 10:35:40, Kees Cook wrote:
> > > On Mon, Feb 26, 2024 at 04:25:09PM +0100, Michal Hocko wrote:
> > [...]
> > > > Does that mean that any potentially incorrect input provided by an admin is
> > > > considered CVE now?
> > > 
> > > Yes. Have you seen what USER_NS does? There isn't a way to know how
> > > deployments are using Linux, and this is clearly a "weakness" as defined
> > > by CVE. It is better to be over zealous than miss things.
> > 
> > If we are over zealous to the point when almost any fix is marked CVE
> > then the special marking simply stops making any sense IMHO.
> 
> Perhaps, but the volume of fixes is high, and I think it's better to
> over estimate than under estimate -- the work needed to actually
> evaluate all these changes is huge: it's better to take everything from
> -stable.

This is simply not feasible for many downstream kernels and reasons have
been discussed many times.

> This has been a long standing problem with communicating this
> to engineering management in many organizations. They have pointed to
> the relatively small number of CVEs and said, "just backport those
> fixes", and trying to explain that it's is totally insufficient falls on
> deaf ears.

I think it is fair to say/expect that every downstream is responsibile
for the kernel they are distributing and that applies to vulnerabilities
affecting those kernels. Forcing fixes by slapping CVE over them sounds
just very dubious to me.

-- 
Michal Hocko
SUSE Labs

