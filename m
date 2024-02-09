Return-Path: <linux-kernel+bounces-60042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F97E84FF04
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 731E61C2214E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541B718053;
	Fri,  9 Feb 2024 21:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BHiJ/fyF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0WV/mw3F";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BHiJ/fyF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0WV/mw3F"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27F817BD3
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 21:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707514681; cv=none; b=LPzLdYuIzKpDX9lwap7HAf7uAt0T8wmO8WqvWTc1unxPq9xR8FjAQfrDOI+34MIDb+PwBSLUQ2ge8EFgzRDXLf66R3JU14ocf5vxxVS8lumZ3SjfPIJ0zvBYHNzmrhaLLMWZnC8UCyi1WJS3Zn60vLrbWTufn0T4+q8fc3fQ0Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707514681; c=relaxed/simple;
	bh=+GgpccG8mjME7BsBHRrZXJOBqjr6B4Vicj5O/aTc2n8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QvjQ+ea7IKEZA25PDC0YhnmU5UZ5rCgSAzH1OLkkYjZb2lBLOcttX4uvIFVWrDh9JezLLp+E18JhI8U68uTFl40VoDnjJbm6LsUIhrF2uw1EsmfFOC+3WK94IA7TEMsPpUWahn5p7zrmoK/Nw9iXwkiwacKp52MfIcLoooJ5MkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BHiJ/fyF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0WV/mw3F; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BHiJ/fyF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0WV/mw3F; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2A46F21CDF;
	Fri,  9 Feb 2024 21:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707514678; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=skJOimG74wL0Kt4yAu7/GY9/doYdDYoQCHINdOb8LWE=;
	b=BHiJ/fyFlRf3shpL0JD0JPWEHo5RPM8nPQ/2Xbinq4YYaFPCXEK4Zj0BuTQUYRGrHeZ49s
	UBTwS2oOaYCKBxXMo1Z7k+8Edv8D2EczFtkZqR7l/6SesTs9ytQHmQyMF7iX/sJ4UTU0YY
	1iepgLiPGsA1zjTe1e9keK+Xcz4jaV0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707514678;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=skJOimG74wL0Kt4yAu7/GY9/doYdDYoQCHINdOb8LWE=;
	b=0WV/mw3FDwlT4P7xVuo9jiWH0bXF7nkIkcjMeY2iEqaNcwipP5jLhFmo4Jbs38ee+MwLfo
	bk75/3H/nP+GkADQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707514678; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=skJOimG74wL0Kt4yAu7/GY9/doYdDYoQCHINdOb8LWE=;
	b=BHiJ/fyFlRf3shpL0JD0JPWEHo5RPM8nPQ/2Xbinq4YYaFPCXEK4Zj0BuTQUYRGrHeZ49s
	UBTwS2oOaYCKBxXMo1Z7k+8Edv8D2EczFtkZqR7l/6SesTs9ytQHmQyMF7iX/sJ4UTU0YY
	1iepgLiPGsA1zjTe1e9keK+Xcz4jaV0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707514678;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=skJOimG74wL0Kt4yAu7/GY9/doYdDYoQCHINdOb8LWE=;
	b=0WV/mw3FDwlT4P7xVuo9jiWH0bXF7nkIkcjMeY2iEqaNcwipP5jLhFmo4Jbs38ee+MwLfo
	bk75/3H/nP+GkADQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9E5AA139E7;
	Fri,  9 Feb 2024 21:37:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id myfxIzWbxmWqaQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Fri, 09 Feb 2024 21:37:57 +0000
Date: Fri, 9 Feb 2024 22:39:04 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Marco Elver <elver@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH v7 2/4] mm,page_owner: Implement the tracking of the
 stacks count
Message-ID: <ZcabeMCHCkl3Bf6q@localhost.localdomain>
References: <20240208234539.19113-1-osalvador@suse.de>
 <20240208234539.19113-3-osalvador@suse.de>
 <CANpmjNOoYC93dt5hNmWsC2N8-7GuSp2L6Lb7mNOKxTGhreceUg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNOoYC93dt5hNmWsC2N8-7GuSp2L6Lb7mNOKxTGhreceUg@mail.gmail.com>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="BHiJ/fyF";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="0WV/mw3F"
X-Spamd-Result: default: False [-1.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linux-foundation.org,vger.kernel.org,kvack.org,suse.com,suse.cz,gmail.com,google.com];
	 RCVD_TLS_ALL(0.00)[];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 2A46F21CDF
X-Spam-Level: 
X-Spam-Score: -1.81
X-Spam-Flag: NO

On Fri, Feb 09, 2024 at 08:45:00AM +0100, Marco Elver wrote:
> > +/**
> > + * stack_depo_get_stack - Get a pointer to a stack struct
> 
> Typo: "depo" -> depot
> 
> I would also write "stack_record struct", because "stack struct" does not exist.

Fixed.

> > + * @handle: Stack depot handle
> > + *
> > + * Return: Returns a pointer to a stack struct
> > + */
> > +struct stack_record *stack_depot_get_stack(depot_stack_handle_t handle);
> 
> I don't know what other usecases there are for this, but I'd want to
> make make sure we give users a big hint to avoid unnecessary uses of
> this function.
> 
> Perhaps we also want to mark it as somewhat internal, e.g. by
> prefixing it with __. So I'd call it __stack_depot_get_stack_record().

Yes, I went with __stack_depot_get_stack_record(), and I updated its doc
in stackdepot.h, mentioning that is only for internal purposes.

> > +static void inc_stack_record_count(depot_stack_handle_t handle)
> > +{
> > +       struct stack_record *stack = stack_depot_get_stack(handle);
> > +
> > +       if (stack)
> > +               refcount_inc(&stack->count);
> > +}
> 
> In the latest stackdepot version in -next, the count is initialized to
> REFCOUNT_SATURATED to warn if a non-refcounted entry is suddenly used
> as a refcounted one. In your case this is intentional and there is no
> risk that the entry will be evicted, so that's ok. But you need to set
> the refcount to 1 somewhere here on the initial stack_depot_save().

Well, I went with something like:

 static void inc_stack_record_count(depot_stack_handle_t handle)
 {
         struct stack_record *stack = __stack_depot_get_stack_record(handle);
 
         if (stack) {
                 /*
                  * New stack_records that do not use STACK_DEPOT_FLAG_GET start
                  * with REFCOUNT_SATURATED to catch spurious increments of their
                  * refcount.
                  * Since we do not use STACK_DEPOT_FLAG_{GET,PUT} API, let us
                  * set a refcount of 1 ourselves.
                  */
                 if (refcount_read(&stack->count) == REFCOUNT_SATURATED)
                         refcount_set(&stack->count, 1);
                 refcount_inc(&stack->count);
         }
 }


-- 
Oscar Salvador
SUSE Labs

