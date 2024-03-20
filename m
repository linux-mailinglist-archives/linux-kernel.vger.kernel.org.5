Return-Path: <linux-kernel+bounces-109101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC28388149F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69C57284236
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED2052F7D;
	Wed, 20 Mar 2024 15:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CJ/KMaim";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CJ/KMaim"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF9C52F82
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 15:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710948658; cv=none; b=AbQ9sNZRUsQKSG23LOAShNkpUnJnBRLmRcI+7a1RyVjia7O2tcj4g08EwIydgkeQLy7/Ftike9HgysOcbuaTTW9cB4T8hav6D+3V6JvX3VSb6dU9uwWA5B+CaMkThZhiHgmN82bWoK5nU+18O42GJEWylCE5OQvCllXVB/AOarw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710948658; c=relaxed/simple;
	bh=CE0+cw1FIhJpKrBjQnRg/E5QwxAVJx0+GnE4yEncZ1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=phcVFxvx+ZvwF8sSkqV8+Krtvo1MmXxVSw7NVxJYJE5HiNTIdklOaK62bdTfjmNv+ibnzE7urWyUaP2h+/3yXM+yKig9dQpqRjvOthEpnjfcz9l6Hpu4K+c3p5+uwK9Nh5svBaQC+gbGWQIsXZmBeDqxDa++378r8vJZl9Aajq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=CJ/KMaim; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=CJ/KMaim; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8D0AC346EB;
	Wed, 20 Mar 2024 15:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710948654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vx4vIYbp5FUkm4Hh6B+X/3hIxivA+FTJjonwOxghsnA=;
	b=CJ/KMaimqLpfTO3dQ59K2hxayFVAy8VksgyyaBkFIPttVvu9/QHTSY8l+VSW2riue2ZcD7
	Y39DvCuQ+vfrW+esOUGHXPt5bJ7uwaIvt0Kxu5dHqB6beTksQE56gMp90CUzCdfLW3QrAG
	VSSKq3etVksujekkMHwhmsD+9bvVRbA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710948654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vx4vIYbp5FUkm4Hh6B+X/3hIxivA+FTJjonwOxghsnA=;
	b=CJ/KMaimqLpfTO3dQ59K2hxayFVAy8VksgyyaBkFIPttVvu9/QHTSY8l+VSW2riue2ZcD7
	Y39DvCuQ+vfrW+esOUGHXPt5bJ7uwaIvt0Kxu5dHqB6beTksQE56gMp90CUzCdfLW3QrAG
	VSSKq3etVksujekkMHwhmsD+9bvVRbA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 63345136CD;
	Wed, 20 Mar 2024 15:30:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JLcwFS4B+2UYVQAAD6G6ig
	(envelope-from <mhocko@suse.com>); Wed, 20 Mar 2024 15:30:54 +0000
Date: Wed, 20 Mar 2024 16:30:53 +0100
From: Michal Hocko <mhocko@suse.com>
To: Kees Cook <keescook@chromium.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Lee Jones <lee@kernel.org>,
	cve@kernel.org, linux-kernel@vger.kernel.org,
	Joel Granados <j.granados@samsung.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: CVE-2023-52596: sysctl: Fix out of bounds access for empty
 sysctl registers
Message-ID: <ZfsBLfou-xpxNrmh@tiehlicka>
References: <2024030645-CVE-2023-52596-b98e@gregkh>
 <Ze68r7_aTn6Vjbpj@tiehlicka>
 <Ze9-Xmn8v4P_wppv@bombadil.infradead.org>
 <20240312091730.GU86322@google.com>
 <ZfAkOFAV15BDMU7F@tiehlicka>
 <ZfBwuDyzLl5M0mhC@bombadil.infradead.org>
 <20240312154910.GC1522089@google.com>
 <ZfCZGevmDe149QeX@bombadil.infradead.org>
 <202403121431.55E67E201@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202403121431.55E67E201@keescook>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Tue 12-03-24 14:47:59, Kees Cook wrote:
> On Tue, Mar 12, 2024 at 11:04:09AM -0700, Luis Chamberlain wrote:
> > + Kees,
> > 
> > On Tue, Mar 12, 2024 at 03:49:10PM +0000, Lee Jones wrote:
> > > On Tue, 12 Mar 2024, Luis Chamberlain wrote:
> > > 
> > > > On Tue, Mar 12, 2024 at 10:45:28AM +0100, Michal Hocko wrote:
> > > > > On Tue 12-03-24 09:17:30, Lee Jones wrote:
> > > > > [...]
> > > > > > > Backporting this is fine, but wouldn't fix an issue unless an external
> > > > > > > module had empty sysctls. And exploiting this is not possible unless
> > > > > > > you purposely build an external module which could end up with empty
> > > > > > > sysctls.
> > > > > 
> > > > > Thanks for the clarification Luis!
> > > > > 
> > > > > > Thanks for the amazing explanation Luis.
> > > > > > 
> > > > > > If I'm reading this correctly, an issue does exist, but an attacker
> > > > > > would have to lay some foundations before it could be triggered.  Sounds
> > > > > > like loading of a malicious or naive module would be enough.
> > > > > 
> > > > > If the bar is set as high as a kernel module to create and empty sysctl
> > > > > directory then I think it is safe to say that the security aspect is
> > > > > mostly moot. There are much simpler ways to attack the system if you are
> > > > > able to load a kernel module.
> > > > 
> > > > Indeed, a simple BUG_ON(1) on external modules cannot possible be a
> > > > source of a CVE. And so this becomes BUG_ON(when_sysctl_empty()) where
> > > 
> > > Issues that are capable of crashing the kernel in any way, including
> > > with WARN() or BUG() are being considered weaknesses and presently get
> > > CVEs.
> > 
> > Its not possible to crash any released kernel with the out of bounds issue
> > today, the commit is just a fix for a future world with empty sysctls
> > which just don't exist today.
> > 
> > Yes you can crash an external module with an empty sysctl on kernels
> > without that commit, but an empty sysctl is not common practice for
> > external modules, they'd have to have custom #ifdefs embedded as noted
> > earlier with the example crash. So your average external module should
> > not be able to crash existing kernels. The scope of a crash then would
> > be external modules that used older kernels without the fix starting after
> > v6.6. Since the fix is already meged on v6.6+ the scope of possible
> > kernels is small, and you'd need a specially crafted sysctl empty array
> > to do so.
> > 
> > > > when_sysctl_empty() is hypotethical and I think the source of this
> > > > question for CVE. Today's that not at boot time or dynamically with
> > > > any linux kernel sources released, and so its only possible if:
> > > > 
> > > >   a) As Joel indicated if you backported an empty sysctl array (which
> > > >   would be unless you carried all the infrastructure to support it).
> > > > 
> > > >   b) an external module has an empty sysctl
> > > 
> > > So what we're discussing here is weather this situation is
> > > _possible_, however unlikely.
> > 
> > I tried my best to summarize that world as we see it above.
> > 
> > > You are the maintainer here, so the final decision is yours.  If you say
> > > this situation is impossible and the CVE should be revoked, I'll go
> > > ahead and do just that.
> > 
> > To the best of our ability, from our perspective, upon our review, the
> > only way to trigger a crash would be with sysctls on external modules
> > loaded on these kernels:
> > 
> >  * v6.6 up to v6.6.15 (v6.6.16 has the fix backported) so 16 releases
> >  * v6.7 up to v6.7.3  (v6.7.4 has the fix backported) so 4 releases
> > 
> > External modules having empty sysctls should be rare, however possible.
> > So these 20 release would be affected by a crash with specially crafted
> > external modules. I suppose one way to exploit this, might be for a
> > vendor providing an external safe-looking module with #ifdefs which make
> > a sysctl seem non-empty but in reality it would be. That issue would
> > exist for 20 kernel releases. Could someone craft something with the out
> > of bounds access given the context to do something evil? Your domain of
> > expertise, your call, not ours.
> 
> I'm not a member of the CNA, but I would lean "yes, the absolute weakest
> of CVE" after spending some time reading the code, reading this thread,
> to dig in and look at this. If it's a malicious module, it doesn't matter:
> the module can do anything. If it's a published module that an attacker
> could use due to the resulting logic of processing the 0th sysctl table
> entry, okay, yes, CVE. Likely insanely rare, but not impossible. But,
> if, as Luis says, there are no upstream modules like this, then it's
> not a CVE.
> 
> So for real-world impact, we'd have to either say "there might be an
> out-of-tree module that could be used as a stepping stone here, and we
> want to protect our users, so let's assign a CVE" or we take a hard line
> and say that's up to downstreams to assign CVEs for their modules.
> 
> I have tried to argue before that it's up to the core kernel code to Do
> The Right Thing, even in the face of crappy out-of-tree code, so to me,
> since this is a (very very very limited) weakness in the core kernel
> code, give it a CVE.

To be really honest I find this reasoning very weak. Our internal APIs
consumable by kernel modules are by large not defending against invalid
or unsupported inputs. This is just yet another of those that have been
fixed which is good for future kernel robustnes but I do not really get
why should we as a kernel community care about out-of-tree modules as
kernels with those loaded are unsupported anyway.

> My attempt at a CVSS for it yields a 3.4 overall:
> AV:L/AC:H/PR:H/UI:N/S:U/C:L/I:L/A:L/E:U/RL:O/RC:X
> https://nvd.nist.gov/vuln-metrics/cvss/v3-calculator?vector=AV:L/AC:H/PR:H/UI:N/S:U/C:L/I:L/A:L/E:U/RL:O/RC:X&version=3.1
-- 
Michal Hocko
SUSE Labs

