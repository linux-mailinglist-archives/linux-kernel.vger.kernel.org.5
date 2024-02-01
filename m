Return-Path: <linux-kernel+bounces-48146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8118457F5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70ECD1F22EF3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5570F8663E;
	Thu,  1 Feb 2024 12:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nUlZng0j";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="USQoimqp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nUlZng0j";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="USQoimqp"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6168662D
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 12:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706791336; cv=none; b=d53B650SUswEb4lyreV+4TJIM/s/KAoF8iZbBgJZbqwxBUtwSi29vf6M5vaNAxvHyXo8jn7BuSJdhQ6f6QLWArpKWpPexwDCekCe8YMXSJ5wl8NPtHosnYbIZsyZn13SliEPHhdOJIaIfCUZC44qXOVnCgtzwBFNUhnlNuT6plM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706791336; c=relaxed/simple;
	bh=V5F1/67R8Xve6cxS+r+J6PhWJS4TbDHxtjr1nFLKqMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TLWU1Zv4MQSOl0tiVn9uNvMnisPSR36dXaBKR0X5CELGGJD+k7FMFVIwsGStxFCW4uD00eeVThPw5oPVwY99H+47OtaaWeCw5JC9T+sYee4l+gmqYoLlwVldjmrrXHcr10mkXYoY5D2OCrT9V7ByDh673CuS8woPLSyaO0qszqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nUlZng0j; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=USQoimqp; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nUlZng0j; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=USQoimqp; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3BE181F385;
	Thu,  1 Feb 2024 12:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706791333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pNulsnfLW8vN7uY9MUHrP0RR2dzcocOH9POfk8gEbtA=;
	b=nUlZng0jXMmIHXrcx4p7ty+mDhAdLSSbOSeURx3mAQy4qWNNPhEIhpZlbY5JXDkuKJDAYG
	fu8arzbKUc37d1zq1tj7m99n+IFEzh4fwj4P5BBzkoSx2rmtH6OrbZKrDG6AP0LdUQcWJY
	jZy0ZpGVC6fYSien9mpDBTr+kFFY9As=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706791333;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pNulsnfLW8vN7uY9MUHrP0RR2dzcocOH9POfk8gEbtA=;
	b=USQoimqpN5kQ9u8B+gkm8NzQZvFeNY6QPWhrIULGaMAhKcijINPHBHme9EXY8Aifl/NbK6
	ov06BMMIt7P3UJAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706791333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pNulsnfLW8vN7uY9MUHrP0RR2dzcocOH9POfk8gEbtA=;
	b=nUlZng0jXMmIHXrcx4p7ty+mDhAdLSSbOSeURx3mAQy4qWNNPhEIhpZlbY5JXDkuKJDAYG
	fu8arzbKUc37d1zq1tj7m99n+IFEzh4fwj4P5BBzkoSx2rmtH6OrbZKrDG6AP0LdUQcWJY
	jZy0ZpGVC6fYSien9mpDBTr+kFFY9As=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706791333;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pNulsnfLW8vN7uY9MUHrP0RR2dzcocOH9POfk8gEbtA=;
	b=USQoimqpN5kQ9u8B+gkm8NzQZvFeNY6QPWhrIULGaMAhKcijINPHBHme9EXY8Aifl/NbK6
	ov06BMMIt7P3UJAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 89E7B139B1;
	Thu,  1 Feb 2024 12:42:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YP5zD6ORu2XNOAAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 01 Feb 2024 12:42:11 +0000
Message-ID: <6950991f-0c1b-40e0-a11d-258276ac56ad@suse.de>
Date: Thu, 1 Feb 2024 13:42:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/12] nvmet-fcloop: swap the list_add_tail arguments
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240131085112.21668-1-dwagner@suse.de>
 <20240131085112.21668-3-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240131085112.21668-3-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=nUlZng0j;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=USQoimqp
X-Spamd-Result: default: False [-3.26 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-2.96)[99.82%];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 3BE181F385
X-Spam-Level: 
X-Spam-Score: -3.26
X-Spam-Flag: NO

On 1/31/24 09:51, Daniel Wagner wrote:
> The first argument of list_add_tail function is the new element which
> should be added to the list which is the second argument. Swap the
> arguments to allow processing more than one element at a time.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/target/fcloop.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
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


