Return-Path: <linux-kernel+bounces-63516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE608530A7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CF34282192
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC87482CA;
	Tue, 13 Feb 2024 12:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="m68folJe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IlwrjTqj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="m68folJe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IlwrjTqj"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF4B45BF1
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 12:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707827956; cv=none; b=bChssiBX4/46FHyZleQNV4zUWx4x6PuEvYdaufZNW0cVQ+jGwaA8/tpqpyWsRfB/pyP67zFA6LuOhNOaOITYzGN2HDFDe/40/Bc0BdfURevbB1ycgjxB7VLxZPraewy7drItV/Fj8VkCVFpDFgKMaKpTJCWiyCgzTCshjAskdtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707827956; c=relaxed/simple;
	bh=rwSA92KX87luSNNWjkBVYK299PueHIWqFuGDWLzlQMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V6fE3vvX109UgG1QC8mqu7d0tshWe+H0nSv6hOJDeL6LJFhAiUsbY7tqxuuP4VDKudw1Kv+lMJwMltOUemzGso5e8/czSzYprhvqciM2CcqSz57OktUEWRUaDt4e1lZDLKk4tR2WsnzAjZmXCE9QAcVIVnArbF2+M3KYBQFlUnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=m68folJe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IlwrjTqj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=m68folJe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IlwrjTqj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 337AD1F79C;
	Tue, 13 Feb 2024 12:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707827953; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=unsCwvhy3hos4hRTOHPJFcc0LouOpI2E7yhqv0G6kRk=;
	b=m68folJevTPvYOJh0BkqGgtbihRPtYlHAeCtxxEZ6ZTNSEhh/SU92XWYU07CoJqfcsLVvv
	WKo+FqYbfcD0PfDSkyl27H87k8GnMkssh06Arn9iadqcATVEZKmpscYKUY8Tpxf0GS/9oF
	vB8aYNdQVtaDq13LPDQQedW8BFw6XUQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707827953;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=unsCwvhy3hos4hRTOHPJFcc0LouOpI2E7yhqv0G6kRk=;
	b=IlwrjTqjDE3CES/wBjTJIRbGfq3Qaq7tnCoOBCStZ8Hjpq0yG7ykJzxFepEtyy4BS+jct2
	aBPu7hJLVWeNrBDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707827953; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=unsCwvhy3hos4hRTOHPJFcc0LouOpI2E7yhqv0G6kRk=;
	b=m68folJevTPvYOJh0BkqGgtbihRPtYlHAeCtxxEZ6ZTNSEhh/SU92XWYU07CoJqfcsLVvv
	WKo+FqYbfcD0PfDSkyl27H87k8GnMkssh06Arn9iadqcATVEZKmpscYKUY8Tpxf0GS/9oF
	vB8aYNdQVtaDq13LPDQQedW8BFw6XUQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707827953;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=unsCwvhy3hos4hRTOHPJFcc0LouOpI2E7yhqv0G6kRk=;
	b=IlwrjTqjDE3CES/wBjTJIRbGfq3Qaq7tnCoOBCStZ8Hjpq0yG7ykJzxFepEtyy4BS+jct2
	aBPu7hJLVWeNrBDg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B02841329E;
	Tue, 13 Feb 2024 12:39:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id dr1CKPBiy2UoVAAAn2gu4w
	(envelope-from <osalvador@suse.de>); Tue, 13 Feb 2024 12:39:12 +0000
Date: Tue, 13 Feb 2024 13:40:22 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Marco Elver <elver@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Michal Hocko <mhocko@suse.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH v8 2/5] mm,page_owner: Implement the tracking of the
 stacks count
Message-ID: <ZctjNn7i3atRPccE@localhost.localdomain>
References: <20240212223029.30769-1-osalvador@suse.de>
 <20240212223029.30769-3-osalvador@suse.de>
 <fc4f498b-fc35-4ba8-abf0-7664d6f1decb@suse.cz>
 <CANpmjNO8CHC6gSFVEOSzYsTAP-j5YvfbfzZMUwnGqSAC1Y4A8g@mail.gmail.com>
 <11cb2ac2-102f-4acd-aded-bbfd29f7269a@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11cb2ac2-102f-4acd-aded-bbfd29f7269a@suse.cz>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-0.48 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[google.com,linux-foundation.org,vger.kernel.org,kvack.org,suse.com,gmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.38)[77.26%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -0.48

On Tue, Feb 13, 2024 at 12:34:55PM +0100, Vlastimil Babka wrote:
> On 2/13/24 10:21, Marco Elver wrote:
> > On Tue, 13 Feb 2024 at 10:16, Vlastimil Babka <vbabka@suse.cz> wrote:
> >> Isn't this racy? Shouldn't we use some atomic cmpxchg operation to change
> >> from REFCOUNT_SATURATED to 1?
> > 
> > If 2 threads race here, both will want to add it to the list as well
> > and take the lock. So this could just be solved with double-checked
> > locking:
> > 
> > if (count == REFCOUNT_SATURATED) {
> >   spin_lock(...);
> 
> Yeah probably stack_list_lock could be taken here already. But then the
> kmalloc() of struct stack must happen also here, before taking the lock.

I am thinking what would be a less expensive and safer option here.
Of course, taking the spinlock is easier, but having the allocation
inside is tricky, and having it outside could mean that we might free
the struct once we checked __within__ the lock that the refcount
is no longer REFCOUNT_SATURATED. No big deal, but a bit sub-optimal.

On the other hand, IIUC, cmpxchg has some memory ordering, like
store_and_release/load_acquire do, so would it be safe to use it
instead of taking the lock?
 

-- 
Oscar Salvador
SUSE Labs

