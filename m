Return-Path: <linux-kernel+bounces-73497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E4385C382
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B67DD283601
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E939877A05;
	Tue, 20 Feb 2024 18:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CQ4vC3jS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9EFXHLFe";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CQ4vC3jS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9EFXHLFe"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BF57640E
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 18:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708453023; cv=none; b=WIsJ3h8Bk5FrKyY6z53JjXyFELmQmTlU8Uofkf7Xn4vAbNCfKCiucK0zBb+QDrFQ7zr9XsloThldWI1pyTL8YxWxGvCWqRDbXHj3KOkJOZsvHz9jWZjXhxFM06g9ftYuxfhCGXvFt1TOXD0XiPc3+1qbtIn7XAtd8mrf55fbU+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708453023; c=relaxed/simple;
	bh=De8XhOT6JE+J1dk1b3PfAlxQq7YbyGSJdtW+HDsxCQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QXZd+fZkSKoibdKJiRqFf/QDWd/o7iadGRCEmOBiFcuadsv2UncYVA1v4kNBd1Mrn4N6JxevuNehLoG/KLYcb9fId6hnDseWyjuNNKLARSKG23q5MA8ErzrzJva0wllQPZCXSvFCb4Y+vwEb29qrZo2pSFB/cCvViJ8XrCh+Hl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CQ4vC3jS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9EFXHLFe; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CQ4vC3jS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9EFXHLFe; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0462922236;
	Tue, 20 Feb 2024 18:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708453019; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ldf/9ISUMpTDeTHva/yfqcl2YRFhqz4gM9hfsaHHd+4=;
	b=CQ4vC3jS3S4Gt1ltrN6mKk4GEnmlHpYf+Rh23fXTvdM9TqtN5zT5zlCuFk4D57h0J1Ol5t
	NlokKbDm+tyxNuw5C/Cg3hWFku5lh/qvjfV8HQceZeh6duWNzq3IEn8m0Z2MD6Qmh7DWlf
	1IYsJ4CaQJs73jfGZiPXUBW8zgl487c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708453019;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ldf/9ISUMpTDeTHva/yfqcl2YRFhqz4gM9hfsaHHd+4=;
	b=9EFXHLFe3kidwGPd/bGAKckTTLCKZbzK2ZLaeVvqP7eTCFRIY5woZBtQq/S6U0MkuUJl98
	SqEU49RKnltVrGDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708453019; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ldf/9ISUMpTDeTHva/yfqcl2YRFhqz4gM9hfsaHHd+4=;
	b=CQ4vC3jS3S4Gt1ltrN6mKk4GEnmlHpYf+Rh23fXTvdM9TqtN5zT5zlCuFk4D57h0J1Ol5t
	NlokKbDm+tyxNuw5C/Cg3hWFku5lh/qvjfV8HQceZeh6duWNzq3IEn8m0Z2MD6Qmh7DWlf
	1IYsJ4CaQJs73jfGZiPXUBW8zgl487c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708453019;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ldf/9ISUMpTDeTHva/yfqcl2YRFhqz4gM9hfsaHHd+4=;
	b=9EFXHLFe3kidwGPd/bGAKckTTLCKZbzK2ZLaeVvqP7eTCFRIY5woZBtQq/S6U0MkuUJl98
	SqEU49RKnltVrGDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DDD97134E4;
	Tue, 20 Feb 2024 18:16:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aaHKNZrs1GXZbwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 20 Feb 2024 18:16:58 +0000
Message-ID: <96c51d35-15ce-42d0-b81b-7e76044e1f2b@suse.cz>
Date: Tue, 20 Feb 2024 19:16:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: regression/bisected commit
 773688a6cb24b0b3c2ba40354d883348a2befa38 make my system completely unusable
 under high load
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Marco Elver <elver@google.com>, Andrey Konovalov <andreyknvl@gmail.com>,
 glider@google.com, dvyukov@google.com, eugenis@google.com,
 Oscar Salvador <osalvador@suse.de>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 Linux Memory Management List <linux-mm@kvack.org>
References: <CABXGCsOzpRPZGg23QqJAzKnqkZPKzvieeg=W7sgjgi3q0pBo0g@mail.gmail.com>
 <CA+fCnZeNsUV4_92A9DMg=yqyS_y_JTABguyQyNMpm6JPKVxruw@mail.gmail.com>
 <CABXGCsPerqj=zXJ0pUCnZ29JGmZFSvH6DB22r2uKio61c1bVkw@mail.gmail.com>
 <CANpmjNMn+ULqbSGQ6uOa0JDhw=2my5TtBK4Y+xyBES_iaG_SEA@mail.gmail.com>
 <CABXGCsM9BSD+SYFkvkYxmcrZL+aUfUb_M-rjNJhzb2cYHQr5ww@mail.gmail.com>
 <CANpmjNNXKiM0j4mR-Rr2KALhgz87=QjCOomEymNMWjtos=Z3Ug@mail.gmail.com>
 <CANpmjNOnbNw2fRL3_depaAgt81p-VpHh5_O_26kyxofjECgsFQ@mail.gmail.com>
 <CABXGCsPB-KEbE+SfymVmqfiomFVngFL2Je81Qyhw1F5_aZX-TQ@mail.gmail.com>
 <CABXGCsO5dcEuorLAXR3CFzDVyAWNk4_YfqCh=UJddfzpWF7hNg@mail.gmail.com>
 <CANpmjNPsdM2HrRFgEHYxX1seT2fbOFDuO6Ci-qF3X2y=9_PD1A@mail.gmail.com>
 <91c50335-e7b6-4ae1-9dad-a0c990b52021@suse.cz>
 <20240219152836.11d36709c594e66fe3037f2d@linux-foundation.org>
 <7e31accb-db01-486f-afb8-18a3f5402d00@suse.cz>
 <CABXGCsOHswLa5rd_Q7kHDHESb=BtqB+F=LV7Wvv+qoRxrqCboA@mail.gmail.com>
 <20240220093011.bf84486d704c3814079c2aa0@linux-foundation.org>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240220093011.bf84486d704c3814079c2aa0@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.21
X-Spamd-Result: default: False [0.21 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MID_RHS_MATCH_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 BAYES_HAM(-0.00)[25.71%];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 FREEMAIL_TO(0.00)[linux-foundation.org,gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[google.com,gmail.com,suse.de,vger.kernel.org,kvack.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

On 2/20/24 18:30, Andrew Morton wrote:
> On Tue, 20 Feb 2024 10:37:03 +0500 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com> wrote:
> 
>> On Tue, Feb 20, 2024 at 4:50 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>> > >
>> > > I'm all confused.
>> > >
>> > > 4434a56ec209 ("stackdepot: make fast paths lock-less again") was
>> > > mainlined for v6.8-rc3.
>> >
>> > Uh sorry, I just trusted the info that it's not merged and didn't verify
>> > it myself. Yeah, I can see it is there.
>> >
>> 
>> Wait, I am talk about these two patches which is not merged yet:
>> [PATCH v2 1/2] stackdepot: use variable size records for non-evictable entries
>> [PATCH v2 2/2] kasan: revert eviction of stack traces in generic mode
>> https://lore.kernel.org/linux-mm/20240129100708.39460-1-elver@google.com/
> 
> A can move those into the 6.8-rc hotfixes queue, and it appears a
> cc:stable will not be required.
> 
> However I'm not seeing anything in the changelogs to indicate that
> we're fixing a dramatic performance regression, nor why that
> regressions is occurring.

We also seem have an unhappy bot with the 2/2 patch :/ although it's not yet
clear if it's a genuine issue.

https://lore.kernel.org/all/202402201506.b7e4b9b6-oliver.sang@intel.com/

