Return-Path: <linux-kernel+bounces-505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B98814216
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 355242836A8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 07:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DF8D2F0;
	Fri, 15 Dec 2023 07:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iq4sR1m6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nNl82QMx";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iq4sR1m6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nNl82QMx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950C910782;
	Fri, 15 Dec 2023 07:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6E7251F81D;
	Fri, 15 Dec 2023 07:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702623918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b0Bf+dFbbORs/JanlMCloofyBsHJKjiLKmSWfYrp1+8=;
	b=iq4sR1m66CGlo2R2yYLgAQ4+CA+md054nhUDY4ZuAqTwVMyv7OkXj4BTHz0dNxlxwdjByE
	iW+xC5V88hWWM19MS7mSujHVy3mmJyzlI+liWrlwc0tnOApMtzjfghO8EWprvc8IXnAU9B
	1Ko5GXKBqbSDXLC0FTlqPuxt2ZtmDjU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702623918;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b0Bf+dFbbORs/JanlMCloofyBsHJKjiLKmSWfYrp1+8=;
	b=nNl82QMxZTw5RgXfcTY1qMQOJzIoZkJSMkrQLcxzkyzBDd7fLonb29mOqQ3G5KNZgIp1HU
	nzeIl9Qi7CqjzjBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702623918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b0Bf+dFbbORs/JanlMCloofyBsHJKjiLKmSWfYrp1+8=;
	b=iq4sR1m66CGlo2R2yYLgAQ4+CA+md054nhUDY4ZuAqTwVMyv7OkXj4BTHz0dNxlxwdjByE
	iW+xC5V88hWWM19MS7mSujHVy3mmJyzlI+liWrlwc0tnOApMtzjfghO8EWprvc8IXnAU9B
	1Ko5GXKBqbSDXLC0FTlqPuxt2ZtmDjU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702623918;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b0Bf+dFbbORs/JanlMCloofyBsHJKjiLKmSWfYrp1+8=;
	b=nNl82QMxZTw5RgXfcTY1qMQOJzIoZkJSMkrQLcxzkyzBDd7fLonb29mOqQ3G5KNZgIp1HU
	nzeIl9Qi7CqjzjBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E392C13726;
	Fri, 15 Dec 2023 07:05:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0HZOJK36e2UPJwAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 15 Dec 2023 07:05:17 +0000
Message-ID: <0ac26221-0205-4db8-b1b7-a0714f1b9cfa@suse.de>
Date: Fri, 15 Dec 2023 08:05:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] md: Remove deprecated CONFIG_MD_MULTIPATH
Content-Language: en-US
To: Song Liu <song@kernel.org>, linux-raid@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Neil Brown <neilb@suse.de>, Guoqing Jiang <guoqing.jiang@linux.dev>,
 Mateusz Grzonka <mateusz.grzonka@intel.com>,
 Jes Sorensen <jes@trained-monkey.org>
References: <20231214222107.2016042-1-song@kernel.org>
 <20231214222107.2016042-3-song@kernel.org>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20231214222107.2016042-3-song@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.44
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.67 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-2.58)[98.11%];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,intel.com:email,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -2.67

On 12/14/23 23:21, Song Liu wrote:
> md-multipath has been marked as deprecated for 2.5 years. Remove it.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Neil Brown <neilb@suse.de>
> Cc: Guoqing Jiang <guoqing.jiang@linux.dev>
> Cc: Mateusz Grzonka <mateusz.grzonka@intel.com>
> Cc: Jes Sorensen <jes@trained-monkey.org>
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>   drivers/md/Kconfig             |  11 -
>   drivers/md/Makefile            |   2 -
>   drivers/md/md-multipath.c      | 463 ---------------------------------
>   drivers/md/md.c                | 185 ++++++-------
>   include/uapi/linux/raid/md_p.h |   2 +-
>   include/uapi/linux/raid/md_u.h |   1 -
>   6 files changed, 81 insertions(+), 583 deletions(-)
>   delete mode 100644 drivers/md/md-multipath.c
> 
About time :-)

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich


