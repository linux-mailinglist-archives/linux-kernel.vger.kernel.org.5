Return-Path: <linux-kernel+bounces-137955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 634A589EA44
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 863111C22A0F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283A1200CD;
	Wed, 10 Apr 2024 06:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DrnA2H3g";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="x59rp1/Z";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DrnA2H3g";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="x59rp1/Z"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC2D17745
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 06:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712728914; cv=none; b=Fdc7Jipj5rHu6/WAcyQokSk30VHp4qz1UmOluOUB0PRwliLHkvmNH/eS7oaAFHDmRkbyW60pJd1/7k/6oeg+iVgj8RTA29+cF42EfiSyJb1MQsf64PcWWawYUWW5ctazgwj7032eDewCJJJnftJY/2ESLE/Bgzm7Vf21ZgeTxi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712728914; c=relaxed/simple;
	bh=ZaYlA2FxEECAx2ZAnSZ+wzX32SObTTpNIzT6AyS6Ik8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=swk4R4Ng3BXmXECcwtHAjp87oa0wV9cPyGnIm4MihlJIMwaJpfbdIZEOL90QcuVezGTxszeLaxhxGKPsUytIHZQ0MeZaz8h48+a9BC4mq8OqrJEGoLooRXDwQ3yww5WOe715YdvsaFv+jHl2iSTs3j7RyXyttwJB4vPf1CtCSBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DrnA2H3g; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=x59rp1/Z; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DrnA2H3g; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=x59rp1/Z; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D0EE15C556;
	Wed, 10 Apr 2024 06:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712728910; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d0M7jKhmdMOsWzkxHcH3wZyl/PZBBuzlnSutY/U1M5s=;
	b=DrnA2H3ghV+heTuVaOtxI73/hJf8WSaFu97lNbJLTH0t97GQlwfbT0YmlFfXs3wldzpp8y
	zLDI68+iNlaQPggs2yt0ze31CBhbjKAfNnHEC289RyDQ3DRqqFBo2Pjd1HMB/mqATVBiWV
	WZsUKofuu+GJ4wfzxyRcj+cz/mQ5ixc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712728910;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d0M7jKhmdMOsWzkxHcH3wZyl/PZBBuzlnSutY/U1M5s=;
	b=x59rp1/Zq4R3FFovqSee2qBOr4y9xzyLtOuM/4eBWHigwhjL/At1aVhcTYkBba7RoO4KCM
	GSKE7w/kQGNRFhAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712728910; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d0M7jKhmdMOsWzkxHcH3wZyl/PZBBuzlnSutY/U1M5s=;
	b=DrnA2H3ghV+heTuVaOtxI73/hJf8WSaFu97lNbJLTH0t97GQlwfbT0YmlFfXs3wldzpp8y
	zLDI68+iNlaQPggs2yt0ze31CBhbjKAfNnHEC289RyDQ3DRqqFBo2Pjd1HMB/mqATVBiWV
	WZsUKofuu+GJ4wfzxyRcj+cz/mQ5ixc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712728910;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d0M7jKhmdMOsWzkxHcH3wZyl/PZBBuzlnSutY/U1M5s=;
	b=x59rp1/Zq4R3FFovqSee2qBOr4y9xzyLtOuM/4eBWHigwhjL/At1aVhcTYkBba7RoO4KCM
	GSKE7w/kQGNRFhAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1965513691;
	Wed, 10 Apr 2024 06:01:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8/i3Ok0rFmYZFQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 10 Apr 2024 06:01:49 +0000
Message-ID: <dfb41081-bf2a-4e57-9414-1cb7e678dd3f@suse.de>
Date: Wed, 10 Apr 2024 08:01:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/6] nvme-tcp: short-circuit reconnect retries
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240409093510.12321-1-dwagner@suse.de>
 <20240409093510.12321-4-dwagner@suse.de>
 <e73b73af-a8c6-49f2-b47a-126fab4836b2@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <e73b73af-a8c6-49f2-b47a-126fab4836b2@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Score: -4.29
X-Spam-Flag: NO

On 4/9/24 22:20, Sagi Grimberg wrote:
> 
> 
> On 09/04/2024 12:35, Daniel Wagner wrote:
>> From: Hannes Reinecke <hare@suse.de>
>>
>> Returning an nvme status from nvme_tcp_setup_ctrl() indicates that the
>> association was established and we have received a status from the
>> controller; consequently we should honour the DNR bit. If not any future
>> reconnect attempts will just return the same error, so we can
>> short-circuit the reconnect attempts and fail the connection directly.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> [dwagner: add helper to decide to reconnect]
>> Signed-off-by: Daniel Wagner <dwagner@suse.de>
>> ---
>>   drivers/nvme/host/nvme.h | 24 ++++++++++++++++++++++++
>>   drivers/nvme/host/tcp.c  | 23 +++++++++++++++--------
>>   2 files changed, 39 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
>> index 9b8904a476b8..dfe103283a3d 100644
>> --- a/drivers/nvme/host/nvme.h
>> +++ b/drivers/nvme/host/nvme.h
>> @@ -701,6 +701,30 @@ static inline bool nvme_is_path_error(u16 status)
>>       return (status & 0x700) == 0x300;
>>   }
>> +/*
>> + * Evaluate the status information returned by the LLDD in order to
>> + * decided if a reconnect attempt should be scheduled.
>> + *
>> + * There are two cases where no reconnect attempt should be attempted:
>> + *
>> + * 1) The LLDD reports an negative status. There was an error (e.g. no
>> + *    memory) on the host side and thus abort the operation.
>> + *    Note, there are exception such as ENOTCONN which is
>> + *    not an internal driver error, thus we filter these errors
>> + *    out and retry later.
>> + * 2) The DNR bit is set and the specification states no further
>> + *    connect attempts with the same set of paramenters should be
>> + *    attempted.
>> + */
>> +static inline bool nvme_ctrl_reconnect(int status)
>> +{
>> +    if (status < 0 && status != -ENOTCONN)
>> +        return false;
> 
> So if the host failed to allocate a buffer it will never attempt
> another reconnect? doesn't sound right to me..,

Memory allocation errors are always tricky. If a system is under memory
pressure yours won't be the only process which will exhibit issues,
so it's questionable whether you should retry, or whether it wouldn't
be safer to just abort the operation, and retry manually once the
system has recovered.
Also we just have the interesting case where RDMA goes haywire and
reports a log buffer size of several TB. No amount of retries will
be fixing that.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


