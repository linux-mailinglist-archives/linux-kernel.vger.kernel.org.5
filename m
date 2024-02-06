Return-Path: <linux-kernel+bounces-54359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F146184AE2B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 06:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24CD31C23D00
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 05:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9B87F46F;
	Tue,  6 Feb 2024 05:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FigCCNTf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9lMbQusC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FigCCNTf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9lMbQusC"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF96777F00
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 05:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707198694; cv=none; b=FzhCI2r8xXXNzATgs8dTOQQbQDAAl2znQOH4k38isNb0gDpy5RvhU9Q9CR1fkjgbNuXf/AEdoihQwl2HL0gHYBySygXZyb1tR3QBtTcKVBuQoTa2msUgP4SmklPsBXC5PqMqtWDjgviAi+Q8DEPqCak86CtnKar4Xl/CwrJ/I+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707198694; c=relaxed/simple;
	bh=uuSmtJ2gn7uGhnDypGX1gXSi2B4n95awpVrdTWswRw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cLXebeZYLY4fEKZTEm1w1/oUrfgy6v3a0YurKvlhFRqWlPHEKdO3qO1VoBoqW8jznaw0JJShGBekUB/Wt6zP8GBjSYqHgiVygNkxmp+uO9Q+yQn2ckVVwjCJ/lX6+K9kPwLE820aGszU3wu6cDDPrdScPnJet0MqChiP9uxHibU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FigCCNTf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9lMbQusC; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FigCCNTf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9lMbQusC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AA8281F896;
	Tue,  6 Feb 2024 05:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707198690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6S6OaTQ90hrwvH+v/ItjXZMzr6AaGm6+jITopHlp8XY=;
	b=FigCCNTfoUkjysf0OLwgDlQ0LR+eXaH2WuOxWJRfhTxZNYm1LAST1bQhaeFpnjPni2x6WW
	PmG9LlZximPRIitvRU0RR3HIxrwK6jy4yKiSwF/1jckkw4ssaN3zkjPhHxRGMMrn/8dcwe
	o79+fNN6E9Kggh/L0T54asrmnqVrtvo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707198690;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6S6OaTQ90hrwvH+v/ItjXZMzr6AaGm6+jITopHlp8XY=;
	b=9lMbQusCAO+2V0qa5SBdltKQmDBJOy+PRsYz1kybIUKhBCbjsj93QsGTvql0t5Qc6U0rxw
	sKuUlbfQhS29GRCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707198690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6S6OaTQ90hrwvH+v/ItjXZMzr6AaGm6+jITopHlp8XY=;
	b=FigCCNTfoUkjysf0OLwgDlQ0LR+eXaH2WuOxWJRfhTxZNYm1LAST1bQhaeFpnjPni2x6WW
	PmG9LlZximPRIitvRU0RR3HIxrwK6jy4yKiSwF/1jckkw4ssaN3zkjPhHxRGMMrn/8dcwe
	o79+fNN6E9Kggh/L0T54asrmnqVrtvo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707198690;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6S6OaTQ90hrwvH+v/ItjXZMzr6AaGm6+jITopHlp8XY=;
	b=9lMbQusCAO+2V0qa5SBdltKQmDBJOy+PRsYz1kybIUKhBCbjsj93QsGTvql0t5Qc6U0rxw
	sKuUlbfQhS29GRCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1EC3213A25;
	Tue,  6 Feb 2024 05:51:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cFk3Kt/IwWXiOAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 06 Feb 2024 05:51:27 +0000
Message-ID: <b19e0b0f-6b1c-4126-931b-d7b0d01fb3da@suse.de>
Date: Tue, 6 Feb 2024 14:51:24 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/12] nvmet-fc: use RCU list iterator for assoc_list
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240131085112.21668-1-dwagner@suse.de>
 <20240131085112.21668-13-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240131085112.21668-13-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=FigCCNTf;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9lMbQusC
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.46 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.16)[-0.789];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -4.46
X-Rspamd-Queue-Id: AA8281F896
X-Spam-Flag: NO

On 1/31/24 16:51, Daniel Wagner wrote:
> The assoc_list is a RCU protected list, thus use the RCU flavor of list
> functions.
> 
> Let's use this opportunity and refactor this code and move the lookup
> into a helper and give it a descriptive name.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/target/fc.c | 34 ++++++++++++++++++++++------------
>   1 file changed, 22 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> index 671d096745a5..fd229f310c93 100644
> --- a/drivers/nvme/target/fc.c
> +++ b/drivers/nvme/target/fc.c
> @@ -1114,14 +1114,27 @@ nvmet_fc_schedule_delete_assoc(struct nvmet_fc_tgt_assoc *assoc)
>   	queue_work(nvmet_wq, &assoc->del_work);
>   }
>   
> +static bool
> +nvmet_fc_assoc_exits(struct nvmet_fc_tgtport *tgtport, u64 association_id)
> +{
> +	struct nvmet_fc_tgt_assoc *a;
> +
> +	list_for_each_entry_rcu(a, &tgtport->assoc_list, a_list) {
> +		if (association_id == a->association_id)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>   static struct nvmet_fc_tgt_assoc *
>   nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
>   {
> -	struct nvmet_fc_tgt_assoc *assoc, *tmpassoc;
> +	struct nvmet_fc_tgt_assoc *assoc;
>   	unsigned long flags;
> +	bool done;
>   	u64 ran;
>   	int idx;
> -	bool needrandom = true;
>   
>   	if (!tgtport->pe)
>   		return NULL;
> @@ -1145,24 +1158,21 @@ nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
>   	INIT_WORK(&assoc->del_work, nvmet_fc_delete_assoc_work);
>   	atomic_set(&assoc->terminating, 0);
>   
> -	while (needrandom) {
> +	done = false;
> +	do {
>   		get_random_bytes(&ran, sizeof(ran) - BYTES_FOR_QID);
>   		ran = ran << BYTES_FOR_QID_SHIFT;
>   
>   		spin_lock_irqsave(&tgtport->lock, flags);
> -		needrandom = false;
> -		list_for_each_entry(tmpassoc, &tgtport->assoc_list, a_list) {
> -			if (ran == tmpassoc->association_id) {
> -				needrandom = true;
> -				break;
> -			}
> -		}
> -		if (!needrandom) {
> +		rcu_read_lock();
> +		if (!nvmet_fc_assoc_exits(tgtport, ran)) {
>   			assoc->association_id = ran;
>   			list_add_tail_rcu(&assoc->a_list, &tgtport->assoc_list);
> +			done = true;
>   		}
> +		rcu_read_unlock();
>   		spin_unlock_irqrestore(&tgtport->lock, flags);

Odd. You already take the tgtport lock, so there really is no point in 
using rcu_read_lock() here.
Or does the tgtport lock not protect the assoc_list?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich


