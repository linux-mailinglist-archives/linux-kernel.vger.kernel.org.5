Return-Path: <linux-kernel+bounces-59206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC8884F333
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 11:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 605361C21964
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 10:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7ED669952;
	Fri,  9 Feb 2024 10:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JtsNZCep";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0SHNLWaY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JtsNZCep";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0SHNLWaY"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787DE69940;
	Fri,  9 Feb 2024 10:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707473998; cv=none; b=LgPQJaw/2OWLfZm876aVWvFOAz4eD14iomwcWKWZD6ZjFcoMz3Ixr/vNFjBeF+8+5z1UCqiwu1tuyBGzSSVE/H1ZEBbFzeAPNdaU1lsRn1OfW8wCf33g3gI7oOEVVHHYG0BK2xQdeNkAR6yZgX+pDFA+2ciFdjgsnuoXkivhNpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707473998; c=relaxed/simple;
	bh=nkyWjlvdw4kQ+MJbdGV188FAXLYtQuZr+wcrFOckkWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k6n2Q5rwEMYtdeDsbU5UR7nEOfbLX+DpRS6dsamiK0t7OUoHKAPfHj/XdlMLUhyduLdqcIW/9NcIuDg5/194renIAN+/WtG1Qz4EOvq84rrTEvbOTK4XBq8qkua6PtXGSgfmc85mWUPbA4VQfC+E1QwWEWBCjyOWUo7QkMSRsxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JtsNZCep; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0SHNLWaY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JtsNZCep; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0SHNLWaY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B690F2207D;
	Fri,  9 Feb 2024 10:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707473988; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TUpM7naFLqFrE8RdUAo4giKWP0dmePiuMe6T9/qylpg=;
	b=JtsNZCepnHgIIr/E9E0mkgq7OTnGZixaEDzN0jKv0gW0SAkAdnn7vTxaltHFKOjrENt4Ej
	kUB0abSP4Gv4SopMsk7hLGTuKVQY7sHnz7oLM4Ou19D6obHduHy7Prp4A+h/tjWgzR9B1d
	EbpyyfcroSz0skZpTctEHUXXOFH0d9Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707473988;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TUpM7naFLqFrE8RdUAo4giKWP0dmePiuMe6T9/qylpg=;
	b=0SHNLWaYL39u2RHUzMP5I/B5yKmyITJcJZ4h5zpixZonn9x+5uvGzHXuV0dbrjsJna/yni
	vwoVZiKojNZEeTBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707473988; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TUpM7naFLqFrE8RdUAo4giKWP0dmePiuMe6T9/qylpg=;
	b=JtsNZCepnHgIIr/E9E0mkgq7OTnGZixaEDzN0jKv0gW0SAkAdnn7vTxaltHFKOjrENt4Ej
	kUB0abSP4Gv4SopMsk7hLGTuKVQY7sHnz7oLM4Ou19D6obHduHy7Prp4A+h/tjWgzR9B1d
	EbpyyfcroSz0skZpTctEHUXXOFH0d9Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707473988;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TUpM7naFLqFrE8RdUAo4giKWP0dmePiuMe6T9/qylpg=;
	b=0SHNLWaYL39u2RHUzMP5I/B5yKmyITJcJZ4h5zpixZonn9x+5uvGzHXuV0dbrjsJna/yni
	vwoVZiKojNZEeTBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3F7571326D;
	Fri,  9 Feb 2024 10:19:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mGb+DET8xWXjIQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 09 Feb 2024 10:19:48 +0000
Message-ID: <a602e869-1fb9-40e4-8aba-728d13c22dcb@suse.de>
Date: Fri, 9 Feb 2024 11:19:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] fnic: move fnic_fnic_flush_tx() to a work queue
Content-Language: en-US
To: Lee Duncan <leeman.duncan@gmail.com>, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Chengfeng Ye <dg573847474@gmail.com>, Satish Kharat <satishkh@cisco.com>,
 Sesidhar Baddela <sebaddel@cisco.com>, Karan Tilak Kumar
 <kartilak@cisco.com>, Lee Duncan <lduncan@suse.com>
References: <cover.1707343839.git.lduncan@suse.com>
 <ce5ffa5d0ff82c2b2e283b3b4bff23291d49b05c.1707343839.git.lduncan@suse.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ce5ffa5d0ff82c2b2e283b3b4bff23291d49b05c.1707343839.git.lduncan@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.10 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BAYES_HAM(-2.01)[95.11%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.de:email];
	 FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[gmail.com,cisco.com,suse.com];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.10

On 2/7/24 23:20, Lee Duncan wrote:
> From: Lee Duncan <lduncan@suse.com>
> 
> Rather than call 'fnic_flush_tx()' from interrupt context we should
> be moving it onto a work queue to avoid any locking issues.
> 
> Fixes: 1a1975551943f681772720f639ff42fbaa746212

Same here, please use the correct fixes tag.

> Signed-off-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Lee Duncan <lduncan@suse.com>
> ---
>   drivers/scsi/fnic/fnic.h      | 3 ++-
>   drivers/scsi/fnic/fnic_fcs.c  | 5 +++--
>   drivers/scsi/fnic/fnic_main.c | 1 +
>   drivers/scsi/fnic/fnic_scsi.c | 4 ++--
>   4 files changed, 8 insertions(+), 5 deletions(-)
> 
Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich


