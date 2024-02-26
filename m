Return-Path: <linux-kernel+bounces-81137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C76E0867137
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71EC3B2771B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878B15A7BB;
	Mon, 26 Feb 2024 10:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XC5rhn9S";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0wq0BxON";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XC5rhn9S";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0wq0BxON"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0DA63B
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 10:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708942368; cv=none; b=b1irkkIBOr28EW7WrZIiai1hOeyb0bkT3JSa9raiia0wAfLuFhZaq7CLjYbrzVXI9+vfshx0AULgFAE7vLL7qDXLOk/XrjxjCogoJMRatotERDw5F7tl4gYjpOjl0vKF04It1734/oESOoTJvtWO/mkX0lHS9SsewymB83A2dMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708942368; c=relaxed/simple;
	bh=cwChX84IQ36TCIcgwTT+CoRqwjdP8BrUdBUljrP22XE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dROqg28aRh1nwfGAns3kDcfJjeqjrElm7ljXx90QnipvgQUhS5hTI6lq7OAURmk56I5HmTpISEhfASwvoEaC9AF/fQssQk5POSV5zUJ4GZ/OPwIzMKH2/dXLakvVfq/txPXS26ybf0+ZUl1vXhFlpiG85RasfgJTBOlEWnD/+uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XC5rhn9S; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0wq0BxON; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XC5rhn9S; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0wq0BxON; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 141C822238;
	Mon, 26 Feb 2024 10:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708942364; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E1udk04wUSNMB8OocFJIbZ/Oh34hvdBxWE/amAhSt5A=;
	b=XC5rhn9StsnbsfAdIsAQqFGHp3lEuo/hhgy7ZMnwgZn7Cb36tz4MwSRVIwSwLRiV4tHQfy
	M766tdZp6UVp4HG9jpx0PGLzG9i7gSeONX21M3toULaaul/zXfUBlF0pARywzm2QihXvvi
	xBEMmzsM3GkfOvtJTkBZAC9KD02Q0Yo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708942364;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E1udk04wUSNMB8OocFJIbZ/Oh34hvdBxWE/amAhSt5A=;
	b=0wq0BxONCCbTlgFjJ/XNxl1yJaqV7jlvPKfB+SGXwzrmHKrFdVTjgwf8PDYjQ9C0OUHlk7
	RX9acuU72aJBgLCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708942364; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E1udk04wUSNMB8OocFJIbZ/Oh34hvdBxWE/amAhSt5A=;
	b=XC5rhn9StsnbsfAdIsAQqFGHp3lEuo/hhgy7ZMnwgZn7Cb36tz4MwSRVIwSwLRiV4tHQfy
	M766tdZp6UVp4HG9jpx0PGLzG9i7gSeONX21M3toULaaul/zXfUBlF0pARywzm2QihXvvi
	xBEMmzsM3GkfOvtJTkBZAC9KD02Q0Yo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708942364;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E1udk04wUSNMB8OocFJIbZ/Oh34hvdBxWE/amAhSt5A=;
	b=0wq0BxONCCbTlgFjJ/XNxl1yJaqV7jlvPKfB+SGXwzrmHKrFdVTjgwf8PDYjQ9C0OUHlk7
	RX9acuU72aJBgLCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EFB1413A3A;
	Mon, 26 Feb 2024 10:12:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UoM0Ohtk3GX4LAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 26 Feb 2024 10:12:43 +0000
Message-ID: <7670235f-60b8-46b4-a30f-606f798eeda4@suse.cz>
Date: Mon, 26 Feb 2024 11:12:43 +0100
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
To: Marco Elver <elver@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, glider@google.com,
 dvyukov@google.com, eugenis@google.com, Oscar Salvador <osalvador@suse.de>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 Linux Memory Management List <linux-mm@kvack.org>
References: <CABXGCsOzpRPZGg23QqJAzKnqkZPKzvieeg=W7sgjgi3q0pBo0g@mail.gmail.com>
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
 <96c51d35-15ce-42d0-b81b-7e76044e1f2b@suse.cz>
 <CANpmjNMObiX5X721DERccn16aMW+WMPz+wvLKv=UdaQi3XOMwA@mail.gmail.com>
 <CANpmjNPP=c4ZfJmWFexR=03Lk4gGMr7yPW=j81WAnM_vCSCwCQ@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CANpmjNPP=c4ZfJmWFexR=03Lk4gGMr7yPW=j81WAnM_vCSCwCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [1.25 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 MID_RHS_MATCH_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 BAYES_HAM(-0.16)[69.49%];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,google.com,suse.de,vger.kernel.org,kvack.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Level: *
X-Spam-Score: 1.25
X-Spam-Flag: NO

On 2/26/24 10:25, Marco Elver wrote:
> On Tue, 20 Feb 2024 at 19:51, Marco Elver <elver@google.com> wrote:
>>
>> While it would be nice if 6.8 would not regress over 6.7 (performance
>> is mostly fixed, memory usage is not), waiting for confirmation what
>> the rcutorture issue from the bot is about might be good.
>>
>> Mikhail: since you are testing mainline, in about 4 weeks the fixes
>> should then reach 6.9-rc in the next merge window. Until then, if it's
>> not too difficult for you, you can apply those 2 patches in your own
>> tree.
> 
> There are more issues that are fixed by "[PATCH v2 1/2] stackdepot:
> use variable size records for non-evictable entries". See
> https://lore.kernel.org/all/ZdxYXQdZDuuhcqiv@elver.google.com/
> 
> This will eventually reach stable, but it might be good to reconsider
> mainlining it earlier.

I believe I can see that patch, together with "kasan: revert eviction of
stack traces in generic mode" in mm-hotfixes-stable so it should be on track
for 6.8.

> Thanks,
> -- Marco


