Return-Path: <linux-kernel+bounces-108458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EE0880AC9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 06:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 788101C20D5F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 05:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE9117573;
	Wed, 20 Mar 2024 05:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gpARS/gz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cL1iP9cn";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gpARS/gz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cL1iP9cn"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3C8171A5
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 05:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710913663; cv=none; b=sjz0SQcsdYDbryru88gk3a28FTb26pf6mX0wlFl7+tARukGyW4mbQuwrrTao8r4DK4Myr+lIO5/lUN4RMqqMFwZ1eXaVtI38fkpS489yvUsmaH3+p45fKO8aaf3M12W/cw9+uTZCn/NZD1eWQdE/oC6a3CTu+Jz2K74OjY/+T8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710913663; c=relaxed/simple;
	bh=+dWcH22125yf4j/OldecbF5C+/EEbXt2IyJjBkfL2j0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mRq9Iy3TQF0VXk0FtyTNhgF95+Ek3Iy4qWb0me1BVAkEfyCvxWZtu21/tARAJsPXB1GhfKASSp3RWl8cSPLleK4X1s30ik3blIEzKHfYl+PVg1LIcPFY9knd4oXZvHTk7isGXdDTqmkaguA03I+CcagY8zXZAkojCq8WmghVBQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gpARS/gz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cL1iP9cn; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gpARS/gz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cL1iP9cn; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4BA141FB40;
	Wed, 20 Mar 2024 05:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710913659; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2j9D9MOA0fmt2lZ5TlChxkcRxVAIguq0al8zOdszFZ0=;
	b=gpARS/gzcAeSnMlOu96Afx1UQGO73+RQ+NSZrMhNiCLAwXm1MP3UEKiBHfRg10C93Y+MDS
	+bHJ2yQbWGRVohdpAp/gckbwsyGYwyBW3Xk+AQoismidsXPpbY7GURPrcMhV0SMm4nHDI8
	lQyOS/caWU+PmSP29CP6046HlC24qz0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710913659;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2j9D9MOA0fmt2lZ5TlChxkcRxVAIguq0al8zOdszFZ0=;
	b=cL1iP9cnjfH0KbLcuHmEVvRUghKW+qpOxwFA6a4vu952q6TU9dXXOy/Pmv5QYIDySGiXa8
	Jq2+spRXDi0ZJhDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710913659; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2j9D9MOA0fmt2lZ5TlChxkcRxVAIguq0al8zOdszFZ0=;
	b=gpARS/gzcAeSnMlOu96Afx1UQGO73+RQ+NSZrMhNiCLAwXm1MP3UEKiBHfRg10C93Y+MDS
	+bHJ2yQbWGRVohdpAp/gckbwsyGYwyBW3Xk+AQoismidsXPpbY7GURPrcMhV0SMm4nHDI8
	lQyOS/caWU+PmSP29CP6046HlC24qz0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710913659;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2j9D9MOA0fmt2lZ5TlChxkcRxVAIguq0al8zOdszFZ0=;
	b=cL1iP9cnjfH0KbLcuHmEVvRUghKW+qpOxwFA6a4vu952q6TU9dXXOy/Pmv5QYIDySGiXa8
	Jq2+spRXDi0ZJhDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B386B136AE;
	Wed, 20 Mar 2024 05:47:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aH0ZKXp4+mVZDgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 20 Mar 2024 05:47:38 +0000
Date: Wed, 20 Mar 2024 06:49:05 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>,
	Vlastimil Babka <vbabka@suse.cz>, Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	syzbot+41bbfdb8d41003d12c0f@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 1/2] mm,page_owner: Fix refcount imbalance
Message-ID: <Zfp40dsYSlCouvJW@localhost.localdomain>
References: <20240319183212.17156-1-osalvador@suse.de>
 <20240319183212.17156-2-osalvador@suse.de>
 <20240319162430.3e76504d06f12edc107029a4@linux-foundation.org>
 <d82aedb5-9406-4808-96b4-1d9ef63485a3@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d82aedb5-9406-4808-96b4-1d9ef63485a3@I-love.SAKURA.ne.jp>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.33
X-Spamd-Result: default: False [-1.33 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-1.53)[91.90%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[41bbfdb8d41003d12c0f];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linux-foundation.org,vger.kernel.org,kvack.org,suse.com,suse.cz,google.com,gmail.com,syzkaller.appspotmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

On Wed, Mar 20, 2024 at 01:40:05PM +0900, Tetsuo Handa wrote:
> Hmm, I guess that this is not an expected user of refcount API.
> If it is correct behavior that refcount becomes 0 here, you need to explain like
> 
> -		refcount_sub_and_test(nr_base_pages, &stack_record->count);
> +		if (refcount_sub_and_test(nr_base_pages, &stack_record->count)) {
> +			// Explain why nothing to do here, and explain where/how
> +			// refcount again becomes positive value using refcount_set().
> +		}
> 
> or replace refcount_t with atomic_t where it is legal to make refcount positive
> without using atomic_set().

No, it is not expected for the refcount to become 0.
I do know why, but I lost a chunk in the middle of a rebase.
This should have the follwing on top:

 diff --git a/mm/page_owner.c b/mm/page_owner.c
 index 2613805cb665..e477a71d6adc 100644
 --- a/mm/page_owner.c
 +++ b/mm/page_owner.c
 @@ -222,8 +222,11 @@ static void dec_stack_record_count(depot_stack_handle_t handle,
  {
         struct stack_record *stack_record = __stack_depot_get_stack_record(handle);
  
 -       if (stack_record)
 -               refcount_sub_and_test(nr_base_pages, &stack_record->count);
 +       if (!stack_record)
 +               return;
 +
 +       if (refcount_sub_and_test(nr_base_pages, &stack_record->count))
 +               WARN(1, "%s refcount went to 0 for %u handle\n", __func__, handle);
  }


-- 
Oscar Salvador
SUSE Labs

