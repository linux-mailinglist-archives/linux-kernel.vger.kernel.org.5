Return-Path: <linux-kernel+bounces-92837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3510A8726AC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9B141F26203
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43CD18EBB;
	Tue,  5 Mar 2024 18:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XV+ArbRJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qrJhhHxr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XV+ArbRJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qrJhhHxr"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD951B970
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 18:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709663848; cv=none; b=BQHB20nML7IYt3Aqun0HCWyNSCrCoEfUbAcZlJS+W7Nk+/4V1xU/EzCxteTh27feuXglxIeYjI+wq8MpYXOzm/kxZrx0757PVoi5ONPeqQTrl4gqP5DyzhxptdCvOwqbGO+w4r8adMuAvRtkWkRtf0R0qSeuLRBgdY4r+gGpBhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709663848; c=relaxed/simple;
	bh=9OySdeXPCzc3gRHog0GdvR7NNwErq2G2bqBBT24iHOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jAQPGmZZQ4xh8MOuLTUS5QzXPuOum1wM2qIn/q1flLmFIM3/qZwLbQ7hLXvhB1bztGoo7GFijboDfDzvSaM65on0NEl2XFk7OuenLuQJyx+svUby0kbIf+51Vf0kgpqxw6yGHPRvndbJW6c4H5zeQ2SMtBps8G+YabFolzlFc+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XV+ArbRJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qrJhhHxr; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XV+ArbRJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qrJhhHxr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6D26234223;
	Tue,  5 Mar 2024 18:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709663844; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z/AQ6pirkN4uHRKwxtCgG5gCDyF8KgCXmMPpvZw4+pU=;
	b=XV+ArbRJXUOWtR6OfvB4u7DvQNaO8+7zDKrpyetpDLG4gdk33GX6rE6QSKw2h9t6X9mGpi
	zE/cky+VLfKTfBMsZCXUix2UgwqEASGIM4/8/Lrki6hAg9gp8zTNa28wU0oX56U/vmCx13
	OXt8i9DOzixTQZ2ltUJvOEeEjUv7XP8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709663844;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z/AQ6pirkN4uHRKwxtCgG5gCDyF8KgCXmMPpvZw4+pU=;
	b=qrJhhHxrC/qmN+c+dhv29YRG3+bT9w+zX5p8issNop68XbZbStpkwKDPXptA/0yUB5U/UG
	DCpz1A4JH241bnDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709663844; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z/AQ6pirkN4uHRKwxtCgG5gCDyF8KgCXmMPpvZw4+pU=;
	b=XV+ArbRJXUOWtR6OfvB4u7DvQNaO8+7zDKrpyetpDLG4gdk33GX6rE6QSKw2h9t6X9mGpi
	zE/cky+VLfKTfBMsZCXUix2UgwqEASGIM4/8/Lrki6hAg9gp8zTNa28wU0oX56U/vmCx13
	OXt8i9DOzixTQZ2ltUJvOEeEjUv7XP8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709663844;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z/AQ6pirkN4uHRKwxtCgG5gCDyF8KgCXmMPpvZw4+pU=;
	b=qrJhhHxrC/qmN+c+dhv29YRG3+bT9w+zX5p8issNop68XbZbStpkwKDPXptA/0yUB5U/UG
	DCpz1A4JH241bnDg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id C255413A5D;
	Tue,  5 Mar 2024 18:37:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id TPZbLGNm52VDAQAAn2gu4w
	(envelope-from <osalvador@suse.de>); Tue, 05 Mar 2024 18:37:23 +0000
Date: Tue, 5 Mar 2024 19:38:42 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Marco Elver <elver@google.com>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, Linux Memory Management List <linux-mm@kvack.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [linux-next:master] [mm,page_owner] 4bedfb314b:
 BUG:KASAN:null-ptr-deref_in_init_page_owner
Message-ID: <Zedmst0pEtGuY6B6@localhost.localdomain>
References: <202403051032.e2f865a-lkp@intel.com>
 <ZeblmHyVlxl_6HGC@localhost.localdomain>
 <CANpmjNMOazCrzJr+Ckx0vM73P86dPM_0qbcv=Nu44jUtPERD+A@mail.gmail.com>
 <ZedlIv2ECH08KJcM@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZedlIv2ECH08KJcM@localhost.localdomain>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-1.88 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[intel.com,lists.linux.dev,kvack.org,linux-foundation.org,suse.cz,gmail.com,google.com,suse.com,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.78)[93.69%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -1.88

On Tue, Mar 05, 2024 at 07:32:02PM +0100, Oscar Salvador wrote:
> On Tue, Mar 05, 2024 at 02:02:35PM +0100, Marco Elver wrote:
> > On Tue, 5 Mar 2024 at 10:26, Oscar Salvador <osalvador@suse.de> wrote:
> > > Marco, could it be that stackdepot was too overloaded, that by the time
> > > page_owner gets initialized, there are no more space for its stacks, and
> > > hence return 0-handles?.
> > 
> > That's possible. But it's unclear to me what exactly happens. Are you
> > able to reproduce the issue? (I haven't been able to because the
> > config enables CFI which seems to cause other issues for me,
> > presumably toolchain related. :-/ )
> 
> I am out of luck here, I cannot reproduce the issue.
> I set up the environment just as [1] says, building the kernel with
> their config and launching bin/lkp just as [1] states, but it
> boots fine here.

But they point out to 

commit 4bedfb314bdd85c1662ecc46fa25b33b998f994d (HEAD, bisection)
Author: Oscar Salvador <osalvador@suse.de>
Date:   Thu Feb 15 22:59:03 2024 +0100

    mm,page_owner: maintain own list of stack_records structs

which the only thing it does is to retrieve the stack_record for
{dummy,failure}.handle and increment their refcount and link them.
I am pretty sure the problem comes from either dummy_handle or
failure_handle being 0 and the stack_record we get is NULL.

I will come up with a patch to guard this scenario, although I did not
think this could happen at this early stage (stack_records returning
NULL).
 

-- 
Oscar Salvador
SUSE Labs

