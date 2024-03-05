Return-Path: <linux-kernel+bounces-91999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC44887198C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A34782827F3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C2C52F8A;
	Tue,  5 Mar 2024 09:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZWlVZcGN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jOQ63t/G";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZWlVZcGN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jOQ63t/G"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389AC524BC
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 09:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709630798; cv=none; b=tjnt0RTCovrlw8u3XMspU07GCuFYXQuyB8Gt2eRx7f61fEmaXIOFH8XvLvQsgXOYuY9JH472srPTs7gckcqEuSvmBsTuuH9GYkp1AehyqSbjVbfH7dFz6n2MMx0sFP4xVPJFzrKXamQ+gRHAsHJvsSk8W7eAb5We6p3mkrDIE10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709630798; c=relaxed/simple;
	bh=1GJ4pLEJiBySr2ubLiSDXv0LJGp0y8MnW0BrFhpcjXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qOSxffOC+g2FlPyHih5CG4Njp9m3RmGtWTdvWSjCp+IL1wsEXCjCfwcvLhDaYGX3mCPkGFd/9OggMc8ztaz8MM89H22xfWbvG/ivvzlEBKw0yZiz/cRlD016OxpjiYoxQ16lGzUhthSG/tZljqcjG/MsOMOwyk0Bl4KwioIkwjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZWlVZcGN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jOQ63t/G; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZWlVZcGN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jOQ63t/G; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 24BDA6A9DE;
	Tue,  5 Mar 2024 09:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709630795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ykjUprM07ZrUOHmFkq+k2cT/hagJHglpYa3jkqSqAAE=;
	b=ZWlVZcGNQw6+JjdmEp1eJLTz2bNCcCtRbE9tOeN8xnxRyMX8iqeePb8m+Szsp7h6g03V1t
	oLlylabBYPbAS0ogh24jQu8RDLwBs5fQRqNETkhAIIXAt6o8mcHbwDi40EllF64Jth39FX
	YBvIuBYYtjDyG9CES7FGjsO2wxcbnLY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709630795;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ykjUprM07ZrUOHmFkq+k2cT/hagJHglpYa3jkqSqAAE=;
	b=jOQ63t/Ge+ynva2BjFrpcgVtN6N4O5S23iUgkhiJhwtLUI38w0WT3tx4wggXqloVp0GvOv
	LxFUYpgusmlv9xDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709630795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ykjUprM07ZrUOHmFkq+k2cT/hagJHglpYa3jkqSqAAE=;
	b=ZWlVZcGNQw6+JjdmEp1eJLTz2bNCcCtRbE9tOeN8xnxRyMX8iqeePb8m+Szsp7h6g03V1t
	oLlylabBYPbAS0ogh24jQu8RDLwBs5fQRqNETkhAIIXAt6o8mcHbwDi40EllF64Jth39FX
	YBvIuBYYtjDyG9CES7FGjsO2wxcbnLY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709630795;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ykjUprM07ZrUOHmFkq+k2cT/hagJHglpYa3jkqSqAAE=;
	b=jOQ63t/Ge+ynva2BjFrpcgVtN6N4O5S23iUgkhiJhwtLUI38w0WT3tx4wggXqloVp0GvOv
	LxFUYpgusmlv9xDA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 6692D13466;
	Tue,  5 Mar 2024 09:26:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id EwchFUrl5mVsZgAAn2gu4w
	(envelope-from <osalvador@suse.de>); Tue, 05 Mar 2024 09:26:34 +0000
Date: Tue, 5 Mar 2024 10:27:52 +0100
From: Oscar Salvador <osalvador@suse.de>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
	Linux Memory Management List <linux-mm@kvack.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [linux-next:master] [mm,page_owner]  4bedfb314b:
 BUG:KASAN:null-ptr-deref_in_init_page_owner
Message-ID: <ZeblmHyVlxl_6HGC@localhost.localdomain>
References: <202403051032.e2f865a-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202403051032.e2f865a-lkp@intel.com>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ZWlVZcGN;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="jOQ63t/G"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.63 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-0.984];
	 FREEMAIL_CC(0.00)[lists.linux.dev,intel.com,kvack.org,linux-foundation.org,suse.cz,google.com,gmail.com,suse.com,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.12)[67.19%]
X-Spam-Score: -1.63
X-Rspamd-Queue-Id: 24BDA6A9DE
X-Spam-Flag: NO

On Tue, Mar 05, 2024 at 02:08:23PM +0800, kernel test robot wrote:
> 
> [    6.582562][    T0] Node 0, zone    DMA32: page owner found early allocated 0 pages
> [    6.612136][    T0] Node 0, zone   Normal: page owner found early allocated 73871 pages
> [    6.612762][    T0] ==================================================================
> [ 6.613351][ T0] BUG: KASAN: null-ptr-deref in init_page_owner (arch/x86/include/asm/atomic.h:28) 
> [    6.613893][    T0] Write of size 4 at addr 000000000000001c by task swapper/0
> [    6.614434][    T0]
> [    6.614600][    T0] CPU: 0 PID: 0 Comm: swapper Tainted: G                T  6.8.0-rc5-00256-g4bedfb314bdd #1 29e70169ace75ef72d53825e983f3dcb1d5756d9
> [    6.615605][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [    6.616367][    T0] Call Trace:
> [    6.616604][    T0]  <TASK>
> [ 6.616816][ T0] ? dump_stack_lvl (lib/dump_stack.c:?) 
> [ 6.617161][ T0] ? print_report (mm/kasan/report.c:?) 
> [ 6.617499][ T0] ? init_page_owner (arch/x86/include/asm/atomic.h:28) 

So, we are crashing here:

        /* Initialize dummy and failure stacks and link them to stack_list */
        dummy_stack.stack_record = __stack_depot_get_stack_record(dummy_handle);
        failure_stack.stack_record = __stack_depot_get_stack_record(failure_handle);
        refcount_set(&dummy_stack.stack_record->count, 1);
        refcount_set(&failure_stack.stack_record->count, 1);

when trying to set the refcount. Allegedly, because dummy_handle is 0.
I thought we fixed that with 

commit 3ee34eabac2abb6b1b6fcdebffe18870719ad000
Author: Oscar Salvador <osalvador@suse.de>
Date:   Thu Feb 15 22:59:01 2024 +0100

    lib/stackdepot: fix first entry having a 0-handle


But I guess this is different.
The obvious way out is to only set the refcount and link the stacks
if their handles are not 0.

Marco, could it be that stackdepot was too overloaded, that by the time
page_owner gets initialized, there are no more space for its stacks, and
hence return 0-handles?.


-- 
Oscar Salvador
SUSE Labs

