Return-Path: <linux-kernel+bounces-44266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C00841FA5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 059551C26715
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D254604C5;
	Tue, 30 Jan 2024 09:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fCMZrZ2D";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fCMZrZ2D"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A2B18E25
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 09:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706607350; cv=none; b=DdC9GJ697WRzFnhyBqc/1fZnjliNvmGL1jGXavfUpp/sS1q6fsuC9va4KAHs/MyshXU11Rete/jGr9jXNJOJdP+5UVfKL15ruC+6WpqTr0slmKNmc1Q9RV7qLaYUf07llLZsJdj/lJhGYl+O6te6oz2LK0/WLL4olwZ5Z9B1rmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706607350; c=relaxed/simple;
	bh=1QV+rYj9+mAOul+iX5Lkt6vwyTL5vO4DQanHTMrWgi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YHbpD6aoBWF+mD6yByJ8X8V6bMufO6M6tHFVpSrOvEoklhh+86c7p3dif2clJmGnUmn7TgQUhCgH8eU0rwIfJzRnsU3R8TMpT1kfyL8F4sFk4yTlBGyD4oJG7XSeTS3YXZmcoxZvO+s5pPGSisnmTCPmgrRoQ1AkqpB5Dd9lfZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fCMZrZ2D; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fCMZrZ2D; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A0CB221DF4;
	Tue, 30 Jan 2024 09:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706607345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PHkeiCNSJCal3HVcuXxyv9aH6tYkcVNIKrc28/mzGBo=;
	b=fCMZrZ2DVjQXelsv6h/YB/zS3aF3KiW7Pzr5RQqS4xBmenCplxkOIS9gYvrpqVxIqIPm2y
	dAVdfqLKRFHNjhFWMW5d+LibMsUmtO0pabX0RfLHeAQWJjyBIFnwC5t0C6Q3Zh1glDLswm
	khKMGgZufmuuqZQGjkrt6eud1p402NU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706607345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PHkeiCNSJCal3HVcuXxyv9aH6tYkcVNIKrc28/mzGBo=;
	b=fCMZrZ2DVjQXelsv6h/YB/zS3aF3KiW7Pzr5RQqS4xBmenCplxkOIS9gYvrpqVxIqIPm2y
	dAVdfqLKRFHNjhFWMW5d+LibMsUmtO0pabX0RfLHeAQWJjyBIFnwC5t0C6Q3Zh1glDLswm
	khKMGgZufmuuqZQGjkrt6eud1p402NU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7602913A6A;
	Tue, 30 Jan 2024 09:35:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MxG9GfHCuGXlIwAAD6G6ig
	(envelope-from <mhocko@suse.com>); Tue, 30 Jan 2024 09:35:45 +0000
Date: Tue, 30 Jan 2024 10:35:40 +0100
From: Michal Hocko <mhocko@suse.com>
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, zokeefe@google.com, david@redhat.com,
	songmuchun@bytedance.com, shy828301@gmail.com, peterx@redhat.com,
	minchan@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] mm/khugepaged: bypassing unnecessary scans with
 MMF_DISABLE_THP check
Message-ID: <ZbjC7KyI21ik1xpK@tiehlicka>
References: <20240129054551.57728-1-ioworker0@gmail.com>
 <ZbfSP6xt6JAE2NrH@tiehlicka>
 <CAK1f24miiADZCpugOa4QUmerG70kOsMT97Zvmy=5ifOG4mW=+g@mail.gmail.com>
 <CAK1f24=2YE+BCYiizkqc8rmN8NaFv_Q6ZtE+4DiFK0PpcefOrQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK1f24=2YE+BCYiizkqc8rmN8NaFv_Q6ZtE+4DiFK0PpcefOrQ@mail.gmail.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.24 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[linux-foundation.org,google.com,redhat.com,bytedance.com,gmail.com,kernel.org,kvack.org,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.16)[69.28%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.24

On Tue 30-01-24 11:08:10, Lance Yang wrote:
> On Tue, Jan 30, 2024 at 10:12 AM Lance Yang <ioworker0@gmail.com> wrote:
> >
> > Hey Michal,
> >
> > Thanks for taking time to review!
> >
> > On some servers within our company, we deploy a
> > daemon responsible for monitoring and updating
> > local applications. Some applications prefer not to
> > use THP, so the daemon calls prctl to disable THP
> > before fork/exec. Conversely, for other applications,
> > the daemon calls prctl to enable THP before fork/exec.
> >
> > Ideally, the daemon should invoke prctl after the fork,
> > but its current implementation follows the described
> > approach.
> 
> In the Go standard library, there is no direct encapsulation
> of the fork system call. Instead, fork and execve are
> combined into one through syscall.ForkExec.

OK, this is an important detail. Something that should be a part
of the chnagelog. It is also important to note that this is not
a correctness issue but rather an optimization to save expensive
checks on each VMA when userspace cannot prctl itself before spawning
into the new process.
-- 
Michal Hocko
SUSE Labs

