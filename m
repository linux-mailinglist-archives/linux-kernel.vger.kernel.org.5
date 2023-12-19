Return-Path: <linux-kernel+bounces-5092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 257D9818680
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA3C41F23E37
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8593915AD4;
	Tue, 19 Dec 2023 11:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Km4QD2vl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xHRDvGl8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OBfpG3/i";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9J8wYAmf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97F8156D9
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 11:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EB0ED1FD54;
	Tue, 19 Dec 2023 11:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702985985; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0VQTD6e34URitSXIJwAIlu72BmB/Am3gsvG0hDPNiZI=;
	b=Km4QD2vlOFG/QojQvLW9QytCV3qH3yxF7JnQBUKv8kmi3Hhj+zcTlM6SXYnaw+yrNcnPS8
	mhxrvOoFMLXfVvWbZhUEMsvyNOKuX/8Xg9M20JJF5zPco2XV6+d4wHsO6RnIGA9ybSrxI8
	IgbX8aZHyEPpyc2fRrtcoByCo6ENFZE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702985985;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0VQTD6e34URitSXIJwAIlu72BmB/Am3gsvG0hDPNiZI=;
	b=xHRDvGl8Ghij3nIEVisPgBrdELvujyoU/zNhPBS4RFjmTptDcqWLfE7TWfR2YV/2+mQ0YJ
	ISGOjYT94KVc6YBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702985984; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0VQTD6e34URitSXIJwAIlu72BmB/Am3gsvG0hDPNiZI=;
	b=OBfpG3/ixtc3kSlmAVO9AVfmIv3vlZNm1G0kixCY5GhJQD9XhPD9GwVHZF6mn4NXmYFQU6
	J87eLNTdmSblZ2/HiXcI5rng3ADl2ih55nNTPgjBtQeEl9j/og+/FmB+Pi8LrUy29HjYvF
	NlYSfIINpCG84T/RQMTFFbuyZnxK14k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702985984;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0VQTD6e34URitSXIJwAIlu72BmB/Am3gsvG0hDPNiZI=;
	b=9J8wYAmfvRsJVSMmI7eeZ94qXelBfObrpH0IaIbCkfQy+mgAuqxa+l5AIDN3jiqmg724HL
	/0o7ElC+xYngM/DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 39BE31375D;
	Tue, 19 Dec 2023 11:39:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qCXANf+AgWWGNQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 19 Dec 2023 11:39:43 +0000
Message-ID: <044a952f-7e35-4f14-8d49-1aa6e2c6e61a@suse.de>
Date: Tue, 19 Dec 2023 12:39:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/16] nvmet-fc: abort command if when there is binding
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 James Smart <james.smart@broadcom.com>
References: <20231218153105.12717-1-dwagner@suse.de>
 <20231218153105.12717-14-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20231218153105.12717-14-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="OBfpG3/i";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9J8wYAmf
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-1.10)[88.18%];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -2.60
X-Rspamd-Queue-Id: EB0ED1FD54
X-Spam-Flag: NO

On 12/18/23 16:31, Daniel Wagner wrote:
> WHen the target port has not active port binding, there is no point in
> trying to process the command as it has to fail anyway. Instead adding
> checks to all commands abort the command early.
> 
Please fix up the subject: 'abort command when there is no binding'

> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/target/fc.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> index 47cecc8c72b2..663c51c9fe53 100644
> --- a/drivers/nvme/target/fc.c
> +++ b/drivers/nvme/target/fc.c
> @@ -1101,6 +1101,9 @@ nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
>   	int idx;
>   	bool needrandom = true;
>   
> +	if (!tgtport->pe)
> +		return NULL;
> +
>   	assoc = kzalloc(sizeof(*assoc), GFP_KERNEL);
>   	if (!assoc)
>   		return NULL;
> @@ -2520,8 +2523,9 @@ nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport *tgtport,
>   
>   	fod->req.cmd = &fod->cmdiubuf.sqe;
>   	fod->req.cqe = &fod->rspiubuf.cqe;
> -	if (tgtport->pe)
> -		fod->req.port = tgtport->pe->port;
> +	if (!tgtport->pe)
> +		goto transport_error;
> +	fod->req.port = tgtport->pe->port;
>   
>   	/* clear any response payload */
>   	memset(&fod->rspiubuf, 0, sizeof(fod->rspiubuf));

Otherwise:

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich


