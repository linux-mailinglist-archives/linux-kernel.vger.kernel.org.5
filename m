Return-Path: <linux-kernel+bounces-72142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBBD85AFE6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 00:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91BC31F21FDF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 23:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8B95677F;
	Mon, 19 Feb 2024 23:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mCm8Sa/w";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PyozkvVG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mCm8Sa/w";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PyozkvVG"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E622C5644E
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 23:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708386634; cv=none; b=B5M9A/QcPWJWiuVNiUiD5nBNRFA+tQYhCyStvY3AtnrDrGcMhGL5/Qcsi2MFBw3ICYq06cDsubruFDbJWOGEzGQvU/wV3PByfekp10Eyjohair5+DbGBlWOLTFTWGH2TCemoDDlV8uaaJCDazgf+b76+DqKhAxgIzdyagc7s5q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708386634; c=relaxed/simple;
	bh=t1Q/ExsdH5KZlffpDm2mtkaWjUzmPWwTi/YNsGSKF7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MM7NLfuEz1pZU3f7TA2LzpYNtmkwy0B45FMvZIAMvEE4/KQF5X+1lGNGSOTIpNAV97DGhlW8S2/j5l+0LHi36Uej9644ZxFDJkc8RgFSrgwLnA+GyjlmOdpxOHtSczIhEYXHPQV2k+VaxY2piLsYSFu59hCGJjqO3ulrpZiE1WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mCm8Sa/w; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PyozkvVG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mCm8Sa/w; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PyozkvVG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5918821FD2;
	Mon, 19 Feb 2024 23:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708386630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xdc5X6/5GGwU4BxQQI32gcL1J486hJF1mILZ+mYNYfE=;
	b=mCm8Sa/wftvlFDrbkfvdTadwSWrLxMuhTXMhGHgC8byTdtF8w1tiAiH+FDr6Jf5nxwH+oW
	tuMqbNz2it8eY8Q4WNk+qADo5j2tiayESsWsE2LiIHhBXfaTXle2eu4DeAmOaCQ9RY9tKT
	4pTnpMc9w/a64SKyNbyMmUsqKrXqjiU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708386630;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xdc5X6/5GGwU4BxQQI32gcL1J486hJF1mILZ+mYNYfE=;
	b=PyozkvVGeWy4FpEDUzEh3vvu1E+DHVjiY/cZL5IekdrEtAIjmD5/epjKaxgBzv4bw/xbFC
	zHIcndKfdmAz5vBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708386630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xdc5X6/5GGwU4BxQQI32gcL1J486hJF1mILZ+mYNYfE=;
	b=mCm8Sa/wftvlFDrbkfvdTadwSWrLxMuhTXMhGHgC8byTdtF8w1tiAiH+FDr6Jf5nxwH+oW
	tuMqbNz2it8eY8Q4WNk+qADo5j2tiayESsWsE2LiIHhBXfaTXle2eu4DeAmOaCQ9RY9tKT
	4pTnpMc9w/a64SKyNbyMmUsqKrXqjiU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708386630;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xdc5X6/5GGwU4BxQQI32gcL1J486hJF1mILZ+mYNYfE=;
	b=PyozkvVGeWy4FpEDUzEh3vvu1E+DHVjiY/cZL5IekdrEtAIjmD5/epjKaxgBzv4bw/xbFC
	zHIcndKfdmAz5vBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3634813647;
	Mon, 19 Feb 2024 23:50:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id srCIDEbp02X6YgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 19 Feb 2024 23:50:30 +0000
Message-ID: <7e31accb-db01-486f-afb8-18a3f5402d00@suse.cz>
Date: Tue, 20 Feb 2024 00:50:55 +0100
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Marco Elver <elver@google.com>,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, glider@google.com,
 dvyukov@google.com, eugenis@google.com, Oscar Salvador <osalvador@suse.de>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 Linux Memory Management List <linux-mm@kvack.org>
References: <CABXGCsOzpRPZGg23QqJAzKnqkZPKzvieeg=W7sgjgi3q0pBo0g@mail.gmail.com>
 <CABXGCsM+9TxxY-bOUw6MyRV7CSZsyQpfDgvwgaBBKk9UONJkBw@mail.gmail.com>
 <CABXGCsOp3Djn5uQYb3f=4k1m9rY9y3Ext9SMavWAFRTcKwtNMA@mail.gmail.com>
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
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240219152836.11d36709c594e66fe3037f2d@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="mCm8Sa/w";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=PyozkvVG
X-Spamd-Result: default: False [-1.80 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BAYES_HAM(-3.00)[100.00%];
	 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	 MID_RHS_MATCH_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 MX_GOOD(-0.01)[];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[google.com,gmail.com,suse.de,vger.kernel.org,kvack.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5918821FD2
X-Spam-Level: 
X-Spam-Score: -1.80
X-Spam-Flag: NO



On 2/20/24 00:28, Andrew Morton wrote:
> On Mon, 19 Feb 2024 11:09:23 +0100 Vlastimil Babka <vbabka@suse.cz> wrote:
> 
>> On 2/19/24 10:52, Marco Elver wrote:
>>> On Mon, 19 Feb 2024 at 10:48, Mikhail Gavrilov
>>> <mikhail.v.gavrilov@gmail.com> wrote:
>>>>
>>>> On Sat, Feb 3, 2024 at 1:14 AM Mikhail Gavrilov
>>>> <mikhail.v.gavrilov@gmail.com> wrote:
>>>>>
>>>>> You are right.
>>>>> Thanks for digging into it!
>>>>>
>>>>
>>>> This [2] revert is still not merged at least I checked on 4f5e5092fdbf.
>>>> Is there any plan to merge it or find another approach?
>>>>
>>>> [2] https://lore.kernel.org/all/20240118110216.2539519-2-elver@google.com/
>>>
>>> I think it's already in -mm and -next. It just takes time, which is a
>>> good thing, after all we want to let -next testing confirm nothing is
>>> wrong with it.
>>>
>>> Andrew, is this planned for the next merge window or as a "hot fix"
>>> for the current rc? Given it has the right "Fixes" tags it will make
>>> it to stable kernels eventually, but I also think that the previous
>>> "slow" version is almost unusable on big systems, so it may be
>>> worthwhile considering the current rc.
>>
>> Yeah it would be best to fix in 6.8 to prevent regressions.
>>
> 
> I'm all confused.
> 
> 4434a56ec209 ("stackdepot: make fast paths lock-less again") was
> mainlined for v6.8-rc3.

Uh sorry, I just trusted the info that it's not merged and didn't verify
it myself. Yeah, I can see it is there.

> That patch Fixed: 108be8def46e ("lib/stackdepot: allow users to evict
> stack traces") which was mainlined for v6.8-rc1, so 4434a56ec209 did
> not need a cc:stable?

That's right.

