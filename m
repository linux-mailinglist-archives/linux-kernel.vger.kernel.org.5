Return-Path: <linux-kernel+bounces-102650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB9987B555
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 00:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8244E1F2126F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 23:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D92A5D73A;
	Wed, 13 Mar 2024 23:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="G7+kmqZa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="URhlWJEy";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="T8GhfltE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3tYwZoGn"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DC92260B
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 23:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710373525; cv=none; b=p0kc/ABkD/Ui0yWl3NkHMcLok8lt4K84JrMXkfl5K8TmyExMKgZOHxb8r9cvAX+YDKijhqwAcfh3ZjBht67InLDO5nMhc5iDKrLGgv8MB1+AomdWDyvIxxFMP9vx9lDKWkAAOFc+GN01DAVaUyDkY0IBX+w6gNLYSr8lxUFkPXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710373525; c=relaxed/simple;
	bh=LsBwd6LQWz93e63sSeME9mO0lntlFCjjQ3p83jw3hdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qp+vO29SAsqkTQ0w0h+FC7HxwSNSExe2ALfnXJri2sAMnOKrdKsPTg+u1+7ZI2ntN7k+HQlrsyoYiYSykyLeIgJTpyjMbAz1MTc3kvVuOG/PqV7jJhzP8tHLX616SXw4kGy0gEw4BxT4KshaOVaI8ptQSC8IxY8XgjHjhjugm78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=G7+kmqZa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=URhlWJEy; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=T8GhfltE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3tYwZoGn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EE24D21C6C;
	Wed, 13 Mar 2024 23:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710373522; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3cJKNEamgKE8o2ZSAXqef3Ys0r2vec9y0IJ3iOWK2PI=;
	b=G7+kmqZafck5XeVCeJlM2N7kdU0pP37YsQ1UVuNdtk6uuht5pwScJPPdy5K3OTbcKLxzKu
	RXw04d0kZ3a50tnTNILDsp7LHLRqtLsZCGV+VGK6EZaTknDlgjMwFo5lq8IbCqQwkxkf2t
	KcCa6+txLjxaV/mqv7ELcaWxbV7BNqw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710373522;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3cJKNEamgKE8o2ZSAXqef3Ys0r2vec9y0IJ3iOWK2PI=;
	b=URhlWJEyQpyqs/lpXtMams/H/5e0i3ivOeFm3jJz/MM+ttLVJZEf6LgunVS/ijOVEYzAcT
	BWckFA3qYyw6lyCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710373521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3cJKNEamgKE8o2ZSAXqef3Ys0r2vec9y0IJ3iOWK2PI=;
	b=T8GhfltExy8NnQnVGfwEoE2EtvqBrpbun/Y11DYzwF1SGzDb+pgmDlMeCGDNaB8HH3lqo9
	WRhtbLEO8s7EWsCtWRM2tbU4a1HNGjUIQSRtNw2MEOXcIBIa9zJB6c00Sr4GaMsW18xvNy
	ZI3Wc5QXRw8XNPUT8vHATT9Nn7/I52s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710373521;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3cJKNEamgKE8o2ZSAXqef3Ys0r2vec9y0IJ3iOWK2PI=;
	b=3tYwZoGnKoQzbR04xM+ISna2+YqNiqPlbJ3eaAUy8+Hxy0+4bYLpzkFFaDETo13MIRqC8L
	/foxCg//xfeyPXBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 751181397F;
	Wed, 13 Mar 2024 23:45:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 69AyGZE68mWtDQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 13 Mar 2024 23:45:21 +0000
Date: Thu, 14 Mar 2024 00:46:40 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH] mm,page_owner: Fix recursion
Message-ID: <ZfI64Orls0Y6SWHF@localhost.localdomain>
References: <20240313234245.18824-1-osalvador@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313234245.18824-1-osalvador@suse.de>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.29
X-Spamd-Result: default: False [-3.29 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,suse.com,suse.cz,google.com,gmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.99)[95.02%]
X-Spam-Flag: NO

On Thu, Mar 14, 2024 at 12:42:45AM +0100, Oscar Salvador wrote:
> @@ -232,6 +241,7 @@ void __reset_page_owner(struct page *page, unsigned short order)
>  	alloc_handle = page_owner->handle;
>  
>  	handle = save_stack(GFP_NOWAIT | __GFP_NOWARN);
> +
>  	for (i = 0; i < (1 << order); i++) {

Sigh, a last-minute unnoticed change.

@Andrew: Do you want me to send v2 fixing that up?


-- 
Oscar Salvador
SUSE Labs

