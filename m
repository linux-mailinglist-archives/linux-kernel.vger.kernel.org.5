Return-Path: <linux-kernel+bounces-104302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD4A87CBE2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEA871C22160
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFECE1A5BA;
	Fri, 15 Mar 2024 11:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Z/cIie2T";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jg0DSH4p";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Z/cIie2T";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jg0DSH4p"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505E2199B0
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 11:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710500973; cv=none; b=ZkdiNotDRLQ5IORpEjRza+rsTBLqrBWNR1ikEBo+osM04AlA/CbIYl6Qn01J4SIiIklaEna0Xp3TwsaSiKokC7VrlWGmyXlLq7PqoVs9ydunh0XwMPoH5VEqCa266+R7zpGjAPSDOEV7ESxvQl6IeFLOxES5+oTUmbBjnbHwewQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710500973; c=relaxed/simple;
	bh=5pGU8fWLEFyy/ybIMUL44XKUEoTRbIy7hzmwVkBq0og=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MxTYyHAVKKE8nI5JM7IO7Z0BY+9Bw49DxGHg3jX14KE28O7euMJvWTkUBeAYvD91WpuAL20YWDnRDHU8PqVquazMS80EBoEUEuHCYSICcJt2sLenQ2F6g/woiwCormCflV+VR/mr/5kmk5SHh9Yk90YYAQYz4tOfT4yfAnVcVPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Z/cIie2T; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jg0DSH4p; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Z/cIie2T; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jg0DSH4p; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8359921DD2;
	Fri, 15 Mar 2024 11:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710500969; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OjoX9b3TBaI+zz4wUVXKNc/j5Lf3cTQPsLzjI7O3xWY=;
	b=Z/cIie2Te5X9Kp4fXdLx9VJljlR+FUnG++OqIR6d8s/A+i8r5oP8Pbgym0Gf5vG6eo3Mxi
	92xwybZ3Oo/JZTqjnBMYlZfEMCxN4+f5BayjBHoC0Z6LSyl8+/+wmWQfu829g5Hfgs98zu
	W3MKFWSGcYRGdvAhZwOhOkgO2RINnAg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710500969;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OjoX9b3TBaI+zz4wUVXKNc/j5Lf3cTQPsLzjI7O3xWY=;
	b=jg0DSH4p1kvYN4EkpifnfW4VfdHHRC19/uKsoMtx/3YVmbF3u5jFuZx/E23t7/XcZkkDs1
	4Hfw30ax9+BavJDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710500969; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OjoX9b3TBaI+zz4wUVXKNc/j5Lf3cTQPsLzjI7O3xWY=;
	b=Z/cIie2Te5X9Kp4fXdLx9VJljlR+FUnG++OqIR6d8s/A+i8r5oP8Pbgym0Gf5vG6eo3Mxi
	92xwybZ3Oo/JZTqjnBMYlZfEMCxN4+f5BayjBHoC0Z6LSyl8+/+wmWQfu829g5Hfgs98zu
	W3MKFWSGcYRGdvAhZwOhOkgO2RINnAg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710500969;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OjoX9b3TBaI+zz4wUVXKNc/j5Lf3cTQPsLzjI7O3xWY=;
	b=jg0DSH4p1kvYN4EkpifnfW4VfdHHRC19/uKsoMtx/3YVmbF3u5jFuZx/E23t7/XcZkkDs1
	4Hfw30ax9+BavJDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6AB75137E8;
	Fri, 15 Mar 2024 11:09:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5ya9GWks9GW+egAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 15 Mar 2024 11:09:29 +0000
Message-ID: <532c9e93-e8cc-4f6f-bf08-b5625022dd4f@suse.cz>
Date: Fri, 15 Mar 2024 12:09:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] mm/compaction: add and use
 for_each_populated_zone_pgdat() helper
Content-Language: en-US
To: Luis Chamberlain <mcgrof@kernel.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, jhubbard@nvidia.com, mgorman@suse.de,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, dave@stgolabs.net,
 p.raghav@samsung.com, da.gomez@samsung.com
References: <20240314005436.2962962-1-mcgrof@kernel.org>
 <20240314005436.2962962-3-mcgrof@kernel.org>
 <ea5d5bb6-32a5-4161-95cd-3dc916576bf7@linux.alibaba.com>
 <ZfPe22p9U8PiRB0W@bombadil.infradead.org>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <ZfPe22p9U8PiRB0W@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -4.29
X-Spamd-Result: default: False [-4.29 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Flag: NO

On 3/15/24 06:38, Luis Chamberlain wrote:
> On Thu, Mar 14, 2024 at 03:19:45PM +0800, Baolin Wang wrote:
>> 
>> 
>> On 2024/3/14 08:54, Luis Chamberlain wrote:
>> > We can just wrap most of the work done on fragmentation_score_node()
>> > into a pgdat helper for populated zones. Add the helper and use it.
>> > 
>> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
>> > ---
>> >   include/linux/mmzone.h | 8 ++++++++
>> >   mm/compaction.c        | 9 ++-------
>> >   2 files changed, 10 insertions(+), 7 deletions(-)
>> > 
>> > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>> > index a497f189d988..1fd74c7100ec 100644
>> > --- a/include/linux/mmzone.h
>> > +++ b/include/linux/mmzone.h
>> > @@ -1597,6 +1597,14 @@ extern struct zone *next_zone(struct zone *zone);
>> >   			; /* do nothing */		\
>> >   		else
>> > +#define for_each_populated_zone_pgdat(zone, pgdat)	\
>> > +	for (zone = pgdat->node_zones;			\
>> > +	     zone;					\
>> > +	     zone = next_zone(zone))			\
>> > +		if (!populated_zone(zone))		\
>> > +			; /* do nothing */		\
>> > +		else
>> 
>> I think this will break the original logics, since the next_zone() will
>> iterate over all memory zones, instead of only the memory zones of the
>> specified node.
> 
> Definitely, thanks, so we'd need something like this in addition:

IMHO that's unnecessarily complex, why not just do the iteration all inline
without this next_zone_pgdat() helper?

Also maybe you could find more users if you created just a
for_each_zone_pgdat() and left the populated_zone() in the user? Otherwise
it's quite a specific helper with just one user.

> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 34b729fc751b..bd11d33ea14d 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1568,6 +1568,7 @@ static inline struct pglist_data *NODE_DATA(int nid)
>  extern struct pglist_data *first_online_pgdat(void);
>  extern struct pglist_data *next_online_pgdat(struct pglist_data *pgdat);
>  extern struct zone *next_zone(struct zone *zone);
> +extern struct zone *next_zone_pgdat(struct zone *zone, struct pglist_data *pgdat);
>  
>  /**
>   * for_each_online_pgdat - helper macro to iterate over all online nodes
> @@ -1600,7 +1601,7 @@ extern struct zone *next_zone(struct zone *zone);
>  #define for_each_populated_zone_pgdat(zone, pgdat)	\
>  	for (zone = pgdat->node_zones;			\
>  	     zone;					\
> -	     zone = next_zone(zone))			\
> +	     zone = next_zone_pgdat(zone, pgdat))	\
>  		if (!populated_zone(zone))		\
>  			; /* do nothing */		\
>  		else
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 015126803017..96434f6fc1ad 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -2152,7 +2152,6 @@ static unsigned int fragmentation_score_node(pg_data_t *pgdat)
>  {
>  	unsigned int score = 0;
>  	struct zone *zone;
> -	int zoneid;
>  
>  	for_each_populated_zone_pgdat(zone, pgdat)
>  		score += fragmentation_score_zone_weighted(zone);
> diff --git a/mm/mmzone.c b/mm/mmzone.c
> index c01896eca736..043a6dc16c05 100644
> --- a/mm/mmzone.c
> +++ b/mm/mmzone.c
> @@ -43,6 +43,18 @@ struct zone *next_zone(struct zone *zone)
>  	return zone;
>  }
>  
> +/*
> + * next_zone_pgdat - helper magic for for_each_zone() per node
> + */
> +struct zone *next_zone_pgdat(struct zone *zone, struct pglist_data *pgdat)
> +{
> +	if (!zone || !pgdat)
> +		return NULL;
> +	if (zone < pgdat->node_zones + MAX_NR_ZONES - 1)
> +		return ++zone;
> +	return NULL;
> +}
> +
>  static inline int zref_in_nodemask(struct zoneref *zref, nodemask_t *nodes)
>  {
>  #ifdef CONFIG_NUMA


