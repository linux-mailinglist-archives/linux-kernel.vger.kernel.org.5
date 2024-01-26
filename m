Return-Path: <linux-kernel+bounces-40007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17EBC83D870
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C8AF1C24ADE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F78312B87;
	Fri, 26 Jan 2024 10:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fGIOLwN4";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fGIOLwN4"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41F412B74
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 10:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706266276; cv=none; b=CrrYi0uDBbZTqDj/YuMN7+xQR+b9g8SdO/RCErC72jjRlQb1u8lqV2+gAVolMrmRye7rm39Z3pe1jKEV9gqK0aHKWpqwN69WQ2ZrorKyKx3qfgWSDyNv4BoJwDc6s7npvQm7gNSJfFYlfELkfuo9o02GPqt8/pppx/ZF6n2Aukw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706266276; c=relaxed/simple;
	bh=fTeXDksg0LwxRYza53TaQIOMzDySYxBlbYlQK7/4/II=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TqZxwCnjFrPP8qh6gJkFM6EHTHZq2Z6glslslgy0YdttrlH24ESXDZqrmgq1/HFEsul4FSG2HzLYU7CVT1N4GyGDLsEKMwC1H8nPJY4m/Ma3riYWazlQA8pGHiTHLQ2BeHUazWsVM16fp834nINUcpdOCaCiyOwGQQBgiepYo8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fGIOLwN4; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fGIOLwN4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DE5081FD38;
	Fri, 26 Jan 2024 10:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706266271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AKzIutW8hDAK4Yw6RIwXdfNOLIMvd8A1PFtLwW1HzIw=;
	b=fGIOLwN4bmCY1r4HCJArej9cCHFUJlh4hY9GoZm7zC21iLDlF1bkhZBs6U1W37WbqBj6Lq
	G/DTVFuAIFrlv5WMM0mLqXxD0HwcGCqnlIuoq4TLXpuPRqirk8pd9aynzCroiY3ktuyb+V
	JMsIkge01QsP5UHg+9+hnfp2ReGE+Go=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706266271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AKzIutW8hDAK4Yw6RIwXdfNOLIMvd8A1PFtLwW1HzIw=;
	b=fGIOLwN4bmCY1r4HCJArej9cCHFUJlh4hY9GoZm7zC21iLDlF1bkhZBs6U1W37WbqBj6Lq
	G/DTVFuAIFrlv5WMM0mLqXxD0HwcGCqnlIuoq4TLXpuPRqirk8pd9aynzCroiY3ktuyb+V
	JMsIkge01QsP5UHg+9+hnfp2ReGE+Go=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CB92F13A22;
	Fri, 26 Jan 2024 10:51:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZTivMZ+Os2XkKAAAD6G6ig
	(envelope-from <mhocko@suse.com>); Fri, 26 Jan 2024 10:51:11 +0000
Date: Fri, 26 Jan 2024 11:51:11 +0100
From: Michal Hocko <mhocko@suse.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: akpm@linux-foundation.org, surenb@google.com, riel@surriel.com,
	willy@infradead.org, cl@linux.com, yang@os.amperecomputing.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	"Bernhard M. Wiedemann" <bwiedemann@suse.de>,
	Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH] mm: huge_memory: don't force huge page alignment on 32
 bit
Message-ID: <ZbOOn0hrKQ_ojM2K@tiehlicka>
References: <20240118133504.2910955-1-shy828301@gmail.com>
 <ZbIhoj2PzD5jIdSn@tiehlicka>
 <2afa54e6-90db-4ae0-a21c-78e5051aa83c@kernel.org>
 <de249ba0-6efa-416a-a1a9-59c47d71cbc9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <de249ba0-6efa-416a-a1a9-59c47d71cbc9@kernel.org>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=fGIOLwN4
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.58 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[linux-foundation.org,google.com,surriel.com,infradead.org,linux.com,os.amperecomputing.com,kvack.org,vger.kernel.org,suse.de,gmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.57)[81.21%]
X-Spam-Score: -1.58
X-Rspamd-Queue-Id: DE5081FD38
X-Spam-Flag: NO

On Fri 26-01-24 10:41:49, Jiri Slaby wrote:
> On 26. 01. 24, 10:36, Jiri Slaby wrote:
> > > > --- a/mm/huge_memory.c
> > > > +++ b/mm/huge_memory.c
> > > > @@ -37,6 +37,7 @@
> > > >   #include <linux/page_owner.h>
> > > >   #include <linux/sched/sysctl.h>
> > > >   #include <linux/memory-tiers.h>
> > > > +#include <linux/compat.h>
> > > >   #include <asm/tlb.h>
> > > >   #include <asm/pgalloc.h>
> > > > @@ -811,6 +812,14 @@ static unsigned long
> > > > __thp_get_unmapped_area(struct file *filp,
> > > >       loff_t off_align = round_up(off, size);
> > > >       unsigned long len_pad, ret;
> > > > +    /*
> > > > +     * It doesn't make too much sense to froce huge page alignment on
> > > > +     * 32 bit system or compat userspace due to the contrained virtual
> > > > +     * address space and address entropy.
> > > > +     */
> > 
> > FWIW,
> > Bernhard noticed that "froce" and "contrained", could you fix that
> > before applying the patch?
> 
> No, you can't:
> 
> 1) it was merged to mm-stable already, and
> 2) the comment is not in that version at all [1]
> 
> [1] https://lore.kernel.org/all/20240126075612.87780C433F1@smtp.kernel.org/

Matthew has objected that the comment is not really necessary and I
think he is quite right. If anything the commend would be helpful to
explain why this doesn't make much sense (because that breaks ASLR
on default configuration and compat tasks). But that should be clear
from the changelog so I think we are good here.

-- 
Michal Hocko
SUSE Labs

