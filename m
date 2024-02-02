Return-Path: <linux-kernel+bounces-49839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7867C84704D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73FED1C245FD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FAC144612;
	Fri,  2 Feb 2024 12:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ddKPEoG0";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ddKPEoG0"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E6022067
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 12:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706876872; cv=none; b=LEEJgvrZeycNg3byI0i++GXPmigOTPlooXbP419kT/OsqanZa5l7xUP3VFPuKigTTk9j9AwzbZn3ncHtdGxm79ky156FTyiCDPus55OaB1hUIyqVgmvIbywzO/o5lMRqhSfxvz7HL+oVtZXZWcrgRSpKLCHJjvsq0CTu0j+GgoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706876872; c=relaxed/simple;
	bh=jZ2d+pd+Qi5YXcTwc4TjuggpVcRHIzgEYlE/YnBTpU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ISzDWfgxSI799J1f3+8tl+Xm6RTseUglcWF43eEaa7I8Ko+TtsdmwABgC60HrfTYxSsZVMBGwdBgoMEp8nPvsUF/dWM3nAvtOnCbShL1G7CprlHRHj17ieb9ynbFxRZUBp6woqz0174Vie+Z7ZgC02GRZSICOJTwSpB4qP+AfGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ddKPEoG0; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ddKPEoG0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0FEF01F786;
	Fri,  2 Feb 2024 12:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706876869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jdRAjeAw3jx5pOabS57BpicnOOq2A4PFxJ8UIU6HAFs=;
	b=ddKPEoG0taDZU7hjv0j2UxKDTnNxCmA5n1RAQVN1Ae6M9huh9krrNJBopQIIDNpqcY0zOc
	tWsG9FqC0AYAEbWGafHfFGYUCgj51PscUJY1jSJhjuEszJ8jYPldpcpelAW2bNIFkv+AQW
	cmxS3yvzhdwJVO79cN7qwfJM34wv1XM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706876869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jdRAjeAw3jx5pOabS57BpicnOOq2A4PFxJ8UIU6HAFs=;
	b=ddKPEoG0taDZU7hjv0j2UxKDTnNxCmA5n1RAQVN1Ae6M9huh9krrNJBopQIIDNpqcY0zOc
	tWsG9FqC0AYAEbWGafHfFGYUCgj51PscUJY1jSJhjuEszJ8jYPldpcpelAW2bNIFkv+AQW
	cmxS3yvzhdwJVO79cN7qwfJM34wv1XM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E834413A58;
	Fri,  2 Feb 2024 12:27:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QBroNsTfvGXUfwAAD6G6ig
	(envelope-from <mhocko@suse.com>); Fri, 02 Feb 2024 12:27:48 +0000
Date: Fri, 2 Feb 2024 13:27:48 +0100
From: Michal Hocko <mhocko@suse.com>
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, zokeefe@google.com, david@redhat.com,
	songmuchun@bytedance.com, shy828301@gmail.com, peterx@redhat.com,
	minchan@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] mm/khugepaged: skip copying lazyfree pages on
 collapse
Message-ID: <ZbzfxNn4AYnTVFLh@tiehlicka>
References: <20240201125226.28372-1-ioworker0@gmail.com>
 <Zby-sHLDlmTRaUcd@tiehlicka>
 <CAK1f24=7sy_Bczpt5YeDbkhfriYUc1=zreSFdGCxfF3R0D6sRQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK1f24=7sy_Bczpt5YeDbkhfriYUc1=zreSFdGCxfF3R0D6sRQ@mail.gmail.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.16 / 50.00];
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
	 BAYES_HAM(-2.56)[98.01%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.16

On Fri 02-02-24 19:18:31, Lance Yang wrote:
> IMO, since it's treated the same as pte_none,
> perhaps lazyfree pages shouldn't be copied to
> the new huge page.

Why? The content of MADV_FREE page is valid until it is reclaimed.
-- 
Michal Hocko
SUSE Labs

