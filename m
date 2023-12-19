Return-Path: <linux-kernel+bounces-4803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1FE81823C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AEFD1C231D2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 07:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C836313FFD;
	Tue, 19 Dec 2023 07:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Du0gm8oo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="N1IMFSch";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Du0gm8oo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="N1IMFSch"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF2513FE3
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 07:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F3BFD1F7A7;
	Tue, 19 Dec 2023 07:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702970797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TjL3rK5mqJOGP1HV7taqDEMc4rfDP37oIi42/AtoI7U=;
	b=Du0gm8ooRodAnWordwCkHDQjLwiCZhH5VL7G1miM/NDP5tfOoKEZSM0RwXQLgXSGBK+ejk
	SuGq2fd4hlwqcviJ1wqBFLdoIlpWsqkuM+TsOynbVwiWK5NDyYdUuVKYDIY7lotUjc3ekJ
	CUquw5xxw+lDmuSBzKsKt1H5Wa+eNVw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702970797;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TjL3rK5mqJOGP1HV7taqDEMc4rfDP37oIi42/AtoI7U=;
	b=N1IMFSchUUXb9hPTVpcEUdhmnOh0g5Q221q3cKK1aKvgM7K/HvTK8fMepIIMaJLoRL6iBY
	8pdQy2GKOqhhmvDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702970797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TjL3rK5mqJOGP1HV7taqDEMc4rfDP37oIi42/AtoI7U=;
	b=Du0gm8ooRodAnWordwCkHDQjLwiCZhH5VL7G1miM/NDP5tfOoKEZSM0RwXQLgXSGBK+ejk
	SuGq2fd4hlwqcviJ1wqBFLdoIlpWsqkuM+TsOynbVwiWK5NDyYdUuVKYDIY7lotUjc3ekJ
	CUquw5xxw+lDmuSBzKsKt1H5Wa+eNVw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702970797;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TjL3rK5mqJOGP1HV7taqDEMc4rfDP37oIi42/AtoI7U=;
	b=N1IMFSchUUXb9hPTVpcEUdhmnOh0g5Q221q3cKK1aKvgM7K/HvTK8fMepIIMaJLoRL6iBY
	8pdQy2GKOqhhmvDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2319013AA6;
	Tue, 19 Dec 2023 07:26:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8KlXBKxFgWVmcgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 19 Dec 2023 07:26:36 +0000
Message-ID: <8fdbfb01-d50e-4198-b673-2a4c51417a81@suse.de>
Date: Tue, 19 Dec 2023 08:26:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/16] nvmet-fcloop: Remove remote port from list when
 unlinking
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 James Smart <james.smart@broadcom.com>
References: <20231218153105.12717-1-dwagner@suse.de>
 <20231218153105.12717-6-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20231218153105.12717-6-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -6.89
X-Spamd-Result: default: False [-6.89 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-1.63)[92.64%];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.17)[-0.874];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Flag: NO

On 12/18/23 16:30, Daniel Wagner wrote:
> The remote port is removed too late from fcloop_nports list. Remove it
> when port is unregistered.
> 
> This prevents a busy loop in fcloop_exit, because it is possible the
> remote port is found in the list and thus we will never progress.
> 
> The kernel log will be spammed with
> 
>    nvme_fcloop: fcloop_exit: Failed deleting remote port
>    nvme_fcloop: fcloop_exit: Failed deleting target port
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/target/fcloop.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
> index c65a73433c05..ead349af30f1 100644
> --- a/drivers/nvme/target/fcloop.c
> +++ b/drivers/nvme/target/fcloop.c
> @@ -995,11 +995,6 @@ fcloop_nport_free(struct kref *ref)
>   {
>   	struct fcloop_nport *nport =
>   		container_of(ref, struct fcloop_nport, ref);
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&fcloop_lock, flags);
> -	list_del(&nport->nport_list);
> -	spin_unlock_irqrestore(&fcloop_lock, flags);
>   
>   	kfree(nport);
>   }
> @@ -1357,6 +1352,8 @@ __unlink_remote_port(struct fcloop_nport *nport)
>   		nport->tport->remoteport = NULL;
>   	nport->rport = NULL;
>   
> +	list_del(&nport->nport_list);
> +
>   	return rport;
>   }
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


