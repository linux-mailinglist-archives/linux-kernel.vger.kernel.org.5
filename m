Return-Path: <linux-kernel+bounces-163966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CEA8B76A8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCA3EB23803
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCE1171E61;
	Tue, 30 Apr 2024 13:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="14nBSeG5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3ONCv356";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="14nBSeG5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3ONCv356"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EB3171E57;
	Tue, 30 Apr 2024 13:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714482775; cv=none; b=oNygy73Xsvub3/9JRghfbkbJsVGG/sntaOcJA4TBQZJjlWOEigXl5hnksU4bE/7KxrxEs/xelNBw5DXC9QzUNqs2A35YNtzdGsWbDIl8PvQU9vZVgEHmGlgFmz/jAP8YhlGzleWq3fdRaEnyZ7NcprDiF/l+o8BT0FbC/W8H3zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714482775; c=relaxed/simple;
	bh=DjAuchipRrBO+D+fVsQFGjFAt3qeMLJr0QMI/x+fKPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EWlaG9y5/5eaGzXc7vLAUGzaOeHi5gPDWHyp94TA/Yol0T9KEr6TxXMUkl6GSlmXE4plwhJV/tdKdO6pr0yRImLmpc52KS8E3/UN7bs5w+5iKjQl3GZpowkmCqGZPjp/fHSSUcZROg6mq/hGx5aABv1UhXR0PUVzs7Pqu87YZc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=14nBSeG5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3ONCv356; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=14nBSeG5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3ONCv356; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3A2F61F7C0;
	Tue, 30 Apr 2024 13:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714482771; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hFTBRuIved2b+Od5QLZ+OhWUlamRYbfwR5OHiuz3yl0=;
	b=14nBSeG5d5F0ASV60hFKmo7jMo+aKLYDzfyEglThmw55gk7ZvMIS0NFjwQpPBNgRb6Ct7/
	gN0NG0LMutlXnbmI41HjXLiH5ef6Fj9p1ZajSA++Zch783bOcs4/DaqnEjQO+o7/DO6p20
	mdvBA34G+obsK7h8gDvN4En8ROwFqsE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714482771;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hFTBRuIved2b+Od5QLZ+OhWUlamRYbfwR5OHiuz3yl0=;
	b=3ONCv356ZGFuWu/fGKSFMkuPnInay3BwV+vAWkV8fgtoeDTm3x3T3StOpi7bjbzrIJ98vR
	EFoTU+hmEfh8s8Cg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=14nBSeG5;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=3ONCv356
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714482771; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hFTBRuIved2b+Od5QLZ+OhWUlamRYbfwR5OHiuz3yl0=;
	b=14nBSeG5d5F0ASV60hFKmo7jMo+aKLYDzfyEglThmw55gk7ZvMIS0NFjwQpPBNgRb6Ct7/
	gN0NG0LMutlXnbmI41HjXLiH5ef6Fj9p1ZajSA++Zch783bOcs4/DaqnEjQO+o7/DO6p20
	mdvBA34G+obsK7h8gDvN4En8ROwFqsE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714482771;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hFTBRuIved2b+Od5QLZ+OhWUlamRYbfwR5OHiuz3yl0=;
	b=3ONCv356ZGFuWu/fGKSFMkuPnInay3BwV+vAWkV8fgtoeDTm3x3T3StOpi7bjbzrIJ98vR
	EFoTU+hmEfh8s8Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 197D2133A7;
	Tue, 30 Apr 2024 13:12:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2JzfBVPuMGYVLgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 30 Apr 2024 13:12:51 +0000
Message-ID: <4e4b7b45-8c3f-4d1f-9507-4f0a9d82835a@suse.cz>
Date: Tue, 30 Apr 2024 15:12:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/slab: make __free(kfree) accept error pointers
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Matthew Wilcox <willy@infradead.org>, Christoph Lameter <cl@linux.com>,
 Peter Zijlstra <peterz@infradead.org>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 "Lameter, Christopher" <cl@os.amperecomputing.com>
References: <285fee25-b447-47a1-9e00-3deb8f9af53e@moroto.mountain>
 <Zi8N66yehahl6D59@casper.infradead.org>
 <6a10be7d-b556-42a9-852c-b6ed821ec41e@suse.cz>
 <49e072da-3d2c-4246-8b7e-7f25513afde3@moroto.mountain>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <49e072da-3d2c-4246-8b7e-7f25513afde3@moroto.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,linux.com,kernel.org,google.com,lge.com,linux-foundation.org,linux.dev,gmail.com,kvack.org,vger.kernel.org,linaro.org,os.amperecomputing.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 3A2F61F7C0
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.00

On 4/30/24 2:50 PM, Dan Carpenter wrote:
> On Tue, Apr 30, 2024 at 02:09:10PM +0200, Vlastimil Babka wrote:
>> On 4/29/24 5:03 AM, Matthew Wilcox wrote:
>> > On Sun, Apr 28, 2024 at 05:26:44PM +0300, Dan Carpenter wrote:
>> >> Currently, if an automatically freed allocation is an error pointer that
>> >> will lead to a crash.  An example of this is in wm831x_gpio_dbg_show().
>> >> 
>> >>    171	char *label __free(kfree) = gpiochip_dup_line_label(chip, i);
>> >>    172	if (IS_ERR(label)) {
>> >>    173		dev_err(wm831x->dev, "Failed to duplicate label\n");
>> >>    174		continue;
>> >>    175  }
>> >> 
>> >> The auto clean up function should check for error pointers as well,
>> >> otherwise we're going to keep hitting issues like this.
>> >> 
>> >> Fixes: 54da6a092431 ("locking: Introduce __cleanup() based infrastructure")
>> >> Cc: <stable@vger.kernel.org>
>> >> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
>> >> ---
>> >> Obviously, the fixes tag isn't very fair but it will tell the -stable
>> >> tools how far to backport this.
>> >> 
>> >>  include/linux/slab.h  | 4 ++--
>> >>  1 files changed, 2 insertions(+), 2 deletions(-)
>> >> 
>> >> diff --git a/include/linux/slab.h b/include/linux/slab.h
>> >> index 4cc37ef22aae..5f5766219375 100644
>> >> --- a/include/linux/slab.h
>> >> +++ b/include/linux/slab.h
>> >> @@ -279,7 +279,7 @@ void kfree(const void *objp);
>> >>  void kfree_sensitive(const void *objp);
>> >>  size_t __ksize(const void *objp);
>> >>  
>> >> -DEFINE_FREE(kfree, void *, if (_T) kfree(_T))
>> >> +DEFINE_FREE(kfree, void *, if (!IS_ERR_OR_NULL(_T)) kfree(_T))
>> > 
>> > Wait, why do we check 'if (_T)' at all?  kfree() already handles NULL
>> > pointers just fine.  I wouldn't be averse to making it handle error
>> > pointers either.
>> 
>> Making kfree() handle IS_ERR() is perhaps a discussion for something else
>> than a stable fix. But Christoph has a point that kfree() checks
>> ZERO_OR_NULL_PTR. Here we check IS_ERR_OR_NULL. How about we checked only
>> IS_ERR here so it makes some sense?
>> 
> 
> I wondered why Peter Z wrote it like this as well...  I think he did
> it so the compiler can figure out which calls to kfree() are unnecessary
> and remove them.  These functions are inline and kfree() is not.  I
> haven't measured to see if it actually results in a space savings but
> the theory is sound.

Hmm that makes sense. There seem to be places that initialize the
__free(kfree) variable to NULL and only at some point actually allocate, and
between those there are possible returns, i.e. ice_init_hw().

OK, patch applied as-is to slab/for-6.9-rc7/fixes, thanks.

> regards,
> dan carpenter
> 


