Return-Path: <linux-kernel+bounces-109209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD613881631
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CEBD1F22F7F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA2C6A013;
	Wed, 20 Mar 2024 17:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LbgYgQ/X";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LbgYgQ/X"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F10069E16
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 17:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710954679; cv=none; b=HXthzJxw9KoeMN6nKy2Ck7Ya2C+JEVWFl54R1WR95u3oS9JK95CdI06pcJJescmlqTB++K+HNda3GBPvmRbqegVovaRwVmdzAjpPWH5S3IQWIdgVkmO43eYRwGqI35L7lX4DK/1ChLMgO3OhxyJ7H7Hdb9twBZf8s96D/xe72ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710954679; c=relaxed/simple;
	bh=5Fd0JpduNVAXH2OjuYHeKixgGn/phPtyfNFNTG76nFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iLU1knCWlAQB0iNyMS3JPBnEGPANvy5/Z4cF82BzW3DzC5KU6F7FgC9PnnhsjwxUd7SU1MTUI4dBK/CIEmMloGIBaGFuGQHlM69bFOHosxNGHqdlrXhcqf6WrRL8HkcOQLfxI/L/HLU41FyU0AOSEdWRS7j2D8ppPzPcbQOtOB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LbgYgQ/X; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LbgYgQ/X; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0ED1921C73;
	Wed, 20 Mar 2024 17:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710954674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cH8rAqNKJqD2k5ziIYwLUbtLHDqFJCLuZIiraxq2Ho8=;
	b=LbgYgQ/Xj8WBtztnv82uiMpJvLFzrXT/ltT7v3v2UuwQ5DfjDDWClYgGkg6i3zBCVFnEGi
	LPUmPyKL0Ppb8nWTvRWIZhxu5EFR/f8cD6Sx3fMuyjxxXOGzT+q0fR1Whekn7BVOj295/Z
	qVG6vnVdyBfvGe9gi3HFgHGm2bzwQKs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710954674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cH8rAqNKJqD2k5ziIYwLUbtLHDqFJCLuZIiraxq2Ho8=;
	b=LbgYgQ/Xj8WBtztnv82uiMpJvLFzrXT/ltT7v3v2UuwQ5DfjDDWClYgGkg6i3zBCVFnEGi
	LPUmPyKL0Ppb8nWTvRWIZhxu5EFR/f8cD6Sx3fMuyjxxXOGzT+q0fR1Whekn7BVOj295/Z
	qVG6vnVdyBfvGe9gi3HFgHGm2bzwQKs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E8648136CD;
	Wed, 20 Mar 2024 17:11:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YfeyNbEY+2XNdgAAD6G6ig
	(envelope-from <mhocko@suse.com>); Wed, 20 Mar 2024 17:11:13 +0000
Date: Wed, 20 Mar 2024 18:11:13 +0100
From: Michal Hocko <mhocko@suse.com>
To: Lee Jones <lee@kernel.org>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Felix Kuehling <felix.kuehling@amd.com>
Subject: Re: CVE-2024-26628: drm/amdkfd: Fix lock dependency warning
Message-ID: <ZfsYsQUoizXAJR9N@tiehlicka>
References: <2024030649-CVE-2024-26628-f6ce@gregkh>
 <Zerheyn-4rB5kySt@tiehlicka>
 <20240314110938.GM1522089@google.com>
 <ZfsBpal_29lihveI@tiehlicka>
 <20240320154734.GU1522089@google.com>
 <20240320165127.GV1522089@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320165127.GV1522089@google.com>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="LbgYgQ/X"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
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
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: 0ED1921C73
X-Spam-Flag: NO

On Wed 20-03-24 16:51:27, Lee Jones wrote:
> On Wed, 20 Mar 2024, Lee Jones wrote:
> 
> > On Wed, 20 Mar 2024, Michal Hocko wrote:
> > 
> > > On Thu 14-03-24 11:09:38, Lee Jones wrote:
> > > > On Fri, 08 Mar 2024, Michal Hocko wrote:
> > > > 
> > > > > On Wed 06-03-24 06:46:11, Greg KH wrote:
> > > > > [...]
> > > > > >  Possible unsafe locking scenario:
> > > > > > 
> > > > > >        CPU0                    CPU1
> > > > > >        ----                    ----
> > > > > >   lock(&svms->lock);
> > > > > >                                lock(&mm->mmap_lock);
> > > > > >                                lock(&svms->lock);
> > > > > >   lock((work_completion)(&svm_bo->eviction_work));
> > > > > > 
> > > > > > I believe this cannot really lead to a deadlock in practice, because
> > > > > > svm_range_evict_svm_bo_worker only takes the mmap_read_lock if the BO
> > > > > > refcount is non-0. That means it's impossible that svm_range_bo_release
> > > > > > is running concurrently. However, there is no good way to annotate this.
> > > > > 
> > > > > OK, so is this even a bug (not to mention a security/weakness)?
> > > > 
> > > > Looks like the patch fixes a warning which can crash some kernels.  So
> > > > the CVE appears to be fixing that, rather than the impossible deadlock.
> > > 
> > > Are you talking about lockdep warning or anything else?
> > 
> > Anything that triggers a BUG() or a WARN() (as per the splat in the
> > commit message).  Many in-field kernels are configured to panic on
> > BUG()s and WARN()s, thus triggering them are presently considered local
> > DoS and attract CVE status.

yes I do agree that WARN() should be treated same as BUG() if
triggerable by an user (for reasons you have mentioned). Lockdep is a
different thing as you follow up below.

> We have discussed this internally and agree with your thinking.
> 
> The splat in the circular lockdep detection code appears to be generated
> using some stacked pr_warn() calls, rather than a WARN().
> 
> Thus, CVE-2024-26628 has now been rejected.
> 
>   https://lore.kernel.org/all/20240320164818.3778843-2-lee@kernel.org/
> 
> Thank you for your input Michal.

Thanks!
-- 
Michal Hocko
SUSE Labs

