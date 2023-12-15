Return-Path: <linux-kernel+bounces-504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D90E8814212
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 169931C2124C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 07:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05DAD2F0;
	Fri, 15 Dec 2023 07:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mXgES5PW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="E9YJRKtt";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mXgES5PW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="E9YJRKtt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B6C612B;
	Fri, 15 Dec 2023 07:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 62DD822401;
	Fri, 15 Dec 2023 07:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702623876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L/6BSd1NLl5EEuhnVeIHA4NzpmcxnW07fBnNckFKN0U=;
	b=mXgES5PWWhKbrN3wGfznwDE0fKOtN3jLfFJ0FxByc+n8hzN8mWDvh+YYjoo2SyU92mLK9R
	aMwXnvjfilSJprayWhLadmdRd/pGla5nh0w9xcqdUCqKVWtVU9RUrGxhbQr047XYTzeSvQ
	CrFEa8zUuqkz9FRzETF77/PxBGgRYPs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702623876;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L/6BSd1NLl5EEuhnVeIHA4NzpmcxnW07fBnNckFKN0U=;
	b=E9YJRKttSA4GokZvI8yESOcNDqBuibEcAOQw1Mer0I/sVPixHvla6Du7FRspHfxzSBokie
	mJ6ju1J6dtebFSCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702623876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L/6BSd1NLl5EEuhnVeIHA4NzpmcxnW07fBnNckFKN0U=;
	b=mXgES5PWWhKbrN3wGfznwDE0fKOtN3jLfFJ0FxByc+n8hzN8mWDvh+YYjoo2SyU92mLK9R
	aMwXnvjfilSJprayWhLadmdRd/pGla5nh0w9xcqdUCqKVWtVU9RUrGxhbQr047XYTzeSvQ
	CrFEa8zUuqkz9FRzETF77/PxBGgRYPs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702623876;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L/6BSd1NLl5EEuhnVeIHA4NzpmcxnW07fBnNckFKN0U=;
	b=E9YJRKttSA4GokZvI8yESOcNDqBuibEcAOQw1Mer0I/sVPixHvla6Du7FRspHfxzSBokie
	mJ6ju1J6dtebFSCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C6E8913726;
	Fri, 15 Dec 2023 07:04:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +TCCLYP6e2UPJwAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 15 Dec 2023 07:04:35 +0000
Message-ID: <8a79d0f0-8def-40f2-9333-9afad355fb3a@suse.de>
Date: Fri, 15 Dec 2023 08:04:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] md: Remove deprecated CONFIG_MD_LINEAR
Content-Language: en-US
To: Song Liu <song@kernel.org>, linux-raid@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Neil Brown <neilb@suse.de>, Guoqing Jiang <guoqing.jiang@linux.dev>,
 Mateusz Grzonka <mateusz.grzonka@intel.com>,
 Jes Sorensen <jes@trained-monkey.org>
References: <20231214222107.2016042-1-song@kernel.org>
 <20231214222107.2016042-2-song@kernel.org>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20231214222107.2016042-2-song@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Score: 0.27
X-Spam-Flag: NO
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.36
X-Spamd-Result: default: False [0.36 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-2.80)[99.14%];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 NEURAL_SPAM_LONG(3.45)[0.985];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linux.dev:email,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Flag: NO

On 12/14/23 23:21, Song Liu wrote:
> md-linear has been marked as deprecated for 2.5 years. Remove it.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Neil Brown <neilb@suse.de>
> Cc: Guoqing Jiang <guoqing.jiang@linux.dev>
> Cc: Mateusz Grzonka <mateusz.grzonka@intel.com>
> Cc: Jes Sorensen <jes@trained-monkey.org>
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>   drivers/md/Kconfig             |  13 --
>   drivers/md/Makefile            |   6 +-
>   drivers/md/md-autodetect.c     |   8 +-
>   drivers/md/md-linear.c         | 318 ---------------------------------
>   drivers/md/md.c                |   2 +-
>   include/uapi/linux/raid/md_p.h |   8 +-
>   include/uapi/linux/raid/md_u.h |   7 +-
>   7 files changed, 8 insertions(+), 354 deletions(-)
>   delete mode 100644 drivers/md/md-linear.c
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich


