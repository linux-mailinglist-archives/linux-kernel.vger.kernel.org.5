Return-Path: <linux-kernel+bounces-70906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F06E5859DD1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A654228191F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B3D20DCC;
	Mon, 19 Feb 2024 08:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cg/H7Xpu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xmYboKy/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LOIXDR6z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Jn/+HkCr"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D49208B9
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 08:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708330165; cv=none; b=gTTT5QG5vN+53pwdbLKea1e6DB4duyKRsj5eQBNH8XmWJbg9P9TVLOB5KbN4b88X7dWE1j+T/wsIxf15HEwpBdez2K/sJ+rzQsw+N4WmDEtrWh+htsCUSyqKoAdXamvrP/d12L+2GLxEUnczjsRW4NVTkzGzsaaBTl6rqVzMW80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708330165; c=relaxed/simple;
	bh=7piy8qyiVNpQwftpfWF9GmrBAl11sXKfYWaxpU3VX/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CY7GH1CAswNsVxiTaUX4+u7GXwIx0psKW8IHAD4bKGqEQ8MApTdCkAooPNa67ofYr+t1b6C7WKaONIc6u0+K61qdMs4stVpmUGTY2Co+egUPbQDEv8gX9PwfnIrseU8qZdsoGxR7J9g+Z7/VJmrwBVYNAwrCQBYNPwTEK2gtO5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cg/H7Xpu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xmYboKy/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LOIXDR6z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Jn/+HkCr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3C3A421E93;
	Mon, 19 Feb 2024 08:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708330156; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7piy8qyiVNpQwftpfWF9GmrBAl11sXKfYWaxpU3VX/w=;
	b=cg/H7Xpuhbd8wlkrfk/sq5VwYJDVKZGkuuHWnBBl2pnkDPkZLoRx/UySh6kGFmt+ZkqKA4
	8QmU0C8sq/InK5XCIZQO8L0N6AO5ayMUEUePE3x2LIicfRlWsPLha3yRGGNJCwAbkbuorX
	DHGf99+ANr4GRT/7oCdvFqTaU6hM7Do=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708330156;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7piy8qyiVNpQwftpfWF9GmrBAl11sXKfYWaxpU3VX/w=;
	b=xmYboKy/DRJ6mPA/l/Mpx397Fy7dI1DfN9mWuCcx/MPnVqV/5UZ35JxdXAk927N4sTAAc3
	NbbUSnQzkUTuB0AQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708330154; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7piy8qyiVNpQwftpfWF9GmrBAl11sXKfYWaxpU3VX/w=;
	b=LOIXDR6zmW9DUBjlgHCuTeWH3EW00+RwIHiUf5sysOTGqnNoVnTW1H8qOzZPGROU6IuXQ9
	2HDaTbeNAPMY0+YKDkrjd848Y0qQzh7Qdg63wetaoKohF4sfqG9EaCP6ofqkdU8RF4zLIi
	c4u7wN2F8LE86m78ACoO450x/0W77Qg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708330154;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7piy8qyiVNpQwftpfWF9GmrBAl11sXKfYWaxpU3VX/w=;
	b=Jn/+HkCrRmhFolAJoid3jzQeFsj9u8rKHCUeFttkQ7zBM469clEpuu3/c6hgKovHXzkSkb
	KVSODeF/RFUvBNBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A37F139D0;
	Mon, 19 Feb 2024 08:09:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OT8SBqoM02X9fwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 19 Feb 2024 08:09:14 +0000
Message-ID: <4591b2b3-398f-402e-b21d-55b244f05a2e@suse.cz>
Date: Mon, 19 Feb 2024 09:09:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/2] Documentation: filesystems: introduce
 proc/slabinfo to users
To: zhang fangzheng <fangzheng.zhang1003@gmail.com>,
 Matthew Wilcox <willy@infradead.org>
Cc: Fangzheng Zhang <fangzheng.zhang@unisoc.com>,
 Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Greg KH <gregkh@linuxfoundation.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, tkjos@google.com,
 Yuming Han <yuming.han@unisoc.com>, Chunyan Zhang <zhang.lyra@gmail.com>
References: <20240219031911.10372-1-fangzheng.zhang@unisoc.com>
 <20240219031911.10372-3-fangzheng.zhang@unisoc.com>
 <ZdLX51r1mOEZKUje@casper.infradead.org>
 <CA+kNDJ+C2b520afauSWbfNK=S1XiNHR_zF32_K-3Rf7R6m3n5Q@mail.gmail.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CA+kNDJ+C2b520afauSWbfNK=S1XiNHR_zF32_K-3Rf7R6m3n5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-1.59 / 50.00];
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
	 R_RATELIMIT(0.00)[to_ip_from(RLtz7ce9b89hw8xzamye9qeynd)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 BAYES_HAM(-3.00)[100.00%];
	 RCPT_COUNT_TWELVE(0.00)[16];
	 FREEMAIL_TO(0.00)[gmail.com,infradead.org];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[unisoc.com,linux.com,kernel.org,google.com,lge.com,linux-foundation.org,linux.dev,gmail.com,linuxfoundation.org,kvack.org,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -1.59

On 2/19/24 07:23, zhang fangzheng wrote:
> On Mon, Feb 19, 2024 at 12:24 PM Matthew Wilcox <willy@infradead.org> wrote:
>>
>> On Mon, Feb 19, 2024 at 11:19:11AM +0800, Fangzheng Zhang wrote:
>> > +Note, <slabreclaim> comes from the collected results in the file
>> > +/sys/kernel/slab/$cache/reclaim_account. Next, we will mark /proc/slabinfo
>> > +as deprecated and recommend the use of either sysfs directly or
>> > +use of the "slabinfo" tool that we have been providing in linux/tools/mm.
>>
>> Wait, so you're going to all of the trouble of changing the format of
>> slabinfo (with the associated costs of updating every tool that currently
>> parses it), only to recommend that we stop using it and start using
>> tools/mm/slabinfo instead?
>>

Hi,

> The initial purpose was to obtain the type of each slab through
> a simple command 'cat proc/slabinfo'. So here, my intention is not to
> update all slabinfo-related tools for the time being, but to modify
> the version number of proc/slabinfo and further display the results
> of using the command.

I'm not sure you understand the concern. There are existing consumers of
/proc/slabinfo, that might become broken by patch 1/2. We don't even know
them all, they might not be all opensource etc. So we can't even make sure
all of them are updated. What can happen after patch 1/2:
- they keep working and ignore the new column (good)
- they include a version check and notice a new unsupported version and
refuse to work
- confused by the new column they start throwing error, or report wrong
stats (that's worse)

>> How about we simply do nothing?

Agreed wrt modifying /proc/slabinfo

> The note here means what changes will occur after
> we modify the version number of proc/slabinfo to 2.2.
> As for the replacement of tools/mm/slabinfo (that inspired
> by Christoph’s suggestions), it will be implemented in the next version
> or even the later version.

So what is your motivation for all this in the first place? You have some
monitoring tool that relies on /proc/slabinfo and want to distinguish
reclaimable caches? So you can change it to parse the /sys directories. Is
it more work? Yes, but you only have to do that once per boot, because
unlike the object/memory stats in /proc/slabinfo, the reclaimable flag will
not change for a cache.

Would tools/mm/slabinfo almost work for you, but you're missing something?
Then send patches for that in the first place. Changing /proc/slabinfo (and
breaking other consumers) for a quick and easy fix with a different solution
planned for the future is simply not feasible.

HTH,
Vlastimil

> Thanks!


