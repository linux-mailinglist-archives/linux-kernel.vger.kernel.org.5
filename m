Return-Path: <linux-kernel+bounces-69969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A858590EC
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 17:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F5F51C21000
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 16:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947BF7D3F7;
	Sat, 17 Feb 2024 16:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rRlVwqaU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kX+pPaL+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TB9IPE0w";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="n1CWji/r"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4F17D3EF
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 16:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708187282; cv=none; b=bmvaTCmqB+R71KcY2NZQNhdBri0JT+oF/7y3B9GqTwSp10R7/D84FC1wv/d64Bhvexq/1nEmoIUuidom/JcJ2otedHFgcEYDJX58lR1SV6VhbvUZJwOF8jd3lnygBWxUgdFNm5i4eUn3Fxr0+lTEi5EEg1vAjoizPvR72tekscw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708187282; c=relaxed/simple;
	bh=ZCgnn75USvBEevnEyPPzDwXktebZB9Jm32iReAByYhA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ibfEXLM0Id2jsY/yAuyO89JCwkJwqtk+eMEKMPAKWFJulFWFDTWnXVTSKk+QQHuEFV1AdhX9eXO2k8I5K1arIqv6lgiQCh70HmFITgrb29tScOm96+lwTX/LdUqWp9sggNmcgy03l+5TdYB124FCqO1YuzlYYs/a3AENjePW/OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rRlVwqaU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kX+pPaL+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TB9IPE0w; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=n1CWji/r; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DF20921D9E;
	Sat, 17 Feb 2024 16:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708187273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TJxXm93B4TylDx6ccg8wI9mx1ojU/+4+CK/noqwvyTw=;
	b=rRlVwqaUCpU+ro9h2l8ZGWIcI72iQu6hS2ZFe6EU6kXOorHlgo+1a3n9gV+shkBwkE3/oG
	D1BaSyQYDVMFaMTGKbozuI1OPqKpJRQ8EbvSTLGVIP7hW6Z8RDWS3DDNSg9O4MBiLR8r8h
	mK2O1D/BBqbDxPFrgewJCthYLPBTxsE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708187273;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TJxXm93B4TylDx6ccg8wI9mx1ojU/+4+CK/noqwvyTw=;
	b=kX+pPaL+NON4+xQUmqJhAderwQMAMvd8v8d4ZgHn46ktmS/OsXs1x4hQcowzBVw4JVO3Vw
	EpKzQxRUM8JAz+Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708187272; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TJxXm93B4TylDx6ccg8wI9mx1ojU/+4+CK/noqwvyTw=;
	b=TB9IPE0woCndtgdcaIgUMPb78NFMvXm9rCbFVWXDFIDkGjHcAFYeVlBSJnK51OLbEHgXf4
	RHUvqTLZN+zrwvqsqRgracW1TDluP9S0t8BmJHZ6B4Erq1VkwreTDr6vbNfktrffw61D+s
	1NNjGa8HZ6HZpgUIfg8/p4VUEOD0dn8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708187272;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TJxXm93B4TylDx6ccg8wI9mx1ojU/+4+CK/noqwvyTw=;
	b=n1CWji/rQ3qGCxxuz1PyppZv4vgwptF7gknFMs8RycqEz1lkyZC2pXVHRfpLxRbLtEi8p4
	pEhX5LYCKsuWaiCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E00A1370C;
	Sat, 17 Feb 2024 16:27:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id veJLHIje0GVDYwAAD6G6ig
	(envelope-from <hare@suse.de>); Sat, 17 Feb 2024 16:27:52 +0000
Message-ID: <0bd86557-c2da-42d0-9ad8-021c3f4fbd8f@suse.de>
Date: Sat, 17 Feb 2024 17:27:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v0 1/6] nvme-fabrics: introduce connect_sync option
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Daniel Wagner <dwagner@suse.de>
Cc: James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240216084526.14133-1-dwagner@suse.de>
 <20240216084526.14133-2-dwagner@suse.de> <20240216094909.GA19961@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240216094909.GA19961@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TB9IPE0w;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="n1CWji/r"
X-Spamd-Result: default: False [-3.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: DF20921D9E
X-Spam-Level: 
X-Spam-Score: -3.30
X-Spam-Flag: NO

On 2/16/24 10:49, Christoph Hellwig wrote:
> On Fri, Feb 16, 2024 at 09:45:21AM +0100, Daniel Wagner wrote:
>> The TCP and RDMA transport are doing a synchronous connect, meaning the
>> syscal returns with the final result, that is. it either failed or
>> succeeded.
>>
>> This isn't the case for FC. This transport just setups and triggers
>> the connect and returns without waiting on the result.
> 
> That's really weird and unexpected.  James, can you explain the reason
> behind this?
> 
Reason is that the initial connect attempt might fail with an temporary 
failure, and will need to be retried. And rather than implementing two 
methods for handling this (one for the initial connect, and another one
for reconnect where one _has_ to use a workqueue) as eg TCP and RDMA
has implemented it FC is using a single code path for handling both.

Temporary failure on initial connect is far more likely on FC than on
other transports due to the way how FC-NVMe is modelled; essentially
one has to log into the remote port for each protocol. So if you run
in a dual fabric (with both FCP and NVMe) you'll need to log into the
same remote port twice. Depending on the implementation the target might 
only be capable of handling one port login at the same time, so the
other one will be failed with a temporary error.
That's why it's a common issue with FC. It _might_ happen with TCP, too,
but apparently not regularly otherwise we would have seen quite some
failures here; TCP can't really handle temporary failures for the
initial connect.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


