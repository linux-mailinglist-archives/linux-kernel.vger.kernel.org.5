Return-Path: <linux-kernel+bounces-49870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7278470B8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A201A1F2C001
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCCB523F;
	Fri,  2 Feb 2024 12:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SfEGVhzA";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SfEGVhzA"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F5A4402
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 12:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706878660; cv=none; b=TgysQnDCXa3GCUxrmV37p7DELsEOGIn77xsOoA4iqxVCy8j1tpboJwHGiiGBVRs/Xgs/J0xUlBNPZgdHTnnxJk3uwTzzT+2R1MP6zpNr9p9zc6i5rd5EBMvJJCpjzrboWiVGZUdRUhUlCljZ/gP4MUSYeJ+xppU2wuDfQc2sOWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706878660; c=relaxed/simple;
	bh=DogevfzWW22N8LSRvIyMD4eRCIXAec2aXHlYaoaCJl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j0aVq9ieAaK2UxZaoVKf4uxSugnW/TMM6GIu4UiZgGPTs5yJlc35CDl3ZAD1UkxQLfBQR6blGxmOyiwDGG67ink5cUillqk2DVFfuVuhFqkeqRPFFKcjZr22QNqvF80NzvE/ZWqsXjJzOmtaKct/i8eP4VvBhzDDD7qTPnxt9YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SfEGVhzA; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SfEGVhzA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B476E1F788;
	Fri,  2 Feb 2024 12:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706878656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xkocaXXNFKl7hAfPf4SUUuTnxj5Wea1E5uFH8/dmago=;
	b=SfEGVhzAZZvEuFOvB6k2vXVDbElIUgKy5N5WsGyTtSH5s+cpMf/5GwpKUOfeHhHB391gcu
	QD6nqLBZk5NlscjCrLXvUP4j0oMcAXI7SFgGRVVx6sI6sAEd04x5v6nR+HPKtE9UEHx/12
	4GO3mfh5KoGQwqDH0Njua1Nsr1ZCg98=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706878656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xkocaXXNFKl7hAfPf4SUUuTnxj5Wea1E5uFH8/dmago=;
	b=SfEGVhzAZZvEuFOvB6k2vXVDbElIUgKy5N5WsGyTtSH5s+cpMf/5GwpKUOfeHhHB391gcu
	QD6nqLBZk5NlscjCrLXvUP4j0oMcAXI7SFgGRVVx6sI6sAEd04x5v6nR+HPKtE9UEHx/12
	4GO3mfh5KoGQwqDH0Njua1Nsr1ZCg98=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8BA1C13A58;
	Fri,  2 Feb 2024 12:57:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OwcUH8DmvGX6CAAAD6G6ig
	(envelope-from <mhocko@suse.com>); Fri, 02 Feb 2024 12:57:36 +0000
Date: Fri, 2 Feb 2024 13:57:35 +0100
From: Michal Hocko <mhocko@suse.com>
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, zokeefe@google.com, david@redhat.com,
	songmuchun@bytedance.com, shy828301@gmail.com, peterx@redhat.com,
	minchan@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] mm/khugepaged: skip copying lazyfree pages on
 collapse
Message-ID: <ZbzmvwyTGeW18nJy@tiehlicka>
References: <20240201125226.28372-1-ioworker0@gmail.com>
 <Zby-sHLDlmTRaUcd@tiehlicka>
 <CAK1f24=7sy_Bczpt5YeDbkhfriYUc1=zreSFdGCxfF3R0D6sRQ@mail.gmail.com>
 <ZbzfxNn4AYnTVFLh@tiehlicka>
 <CAK1f24mvBkc2c=fHL6UxMhL2mgLHVrSwZfE5516bOR0yVdfZpQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK1f24mvBkc2c=fHL6UxMhL2mgLHVrSwZfE5516bOR0yVdfZpQ@mail.gmail.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [0.12 / 50.00];
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
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[linux-foundation.org,google.com,redhat.com,bytedance.com,gmail.com,kernel.org,kvack.org,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.28)[74.18%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.12

On Fri 02-02-24 20:52:48, Lance Yang wrote:
> On Fri, Feb 2, 2024 at 8:27 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Fri 02-02-24 19:18:31, Lance Yang wrote:
> > > IMO, since it's treated the same as pte_none,
> > > perhaps lazyfree pages shouldn't be copied to
> > > the new huge page.
> >
> > Why? The content of MADV_FREE page is valid until it is reclaimed.
> 
> IMO, if MADV_FREE pages are considered valid until
> reclaimed, treating them the same as pte_none might
> pose a conflict.

What kind of conflict?
-- 
Michal Hocko
SUSE Labs

