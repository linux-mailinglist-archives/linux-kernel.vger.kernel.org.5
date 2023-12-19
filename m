Return-Path: <linux-kernel+bounces-4799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DE2818235
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 369FF28671B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 07:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BECBF9E7;
	Tue, 19 Dec 2023 07:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jvA4euUa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TT6K+BOy";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jvA4euUa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TT6K+BOy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3C6C2D5
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 07:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0A5241F7A7;
	Tue, 19 Dec 2023 07:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702970699; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yxH80z026qnk4/BFmJ/oRlZKA7vzjGyyDCfGbkbjlmE=;
	b=jvA4euUalc+VZIxFtDNwUwPzAzURPq5Gq5NNtxEicquSGgZJ23TfCzbkORSFQ2onm9Xvcq
	xfUOAOo0wbTkXQ4Ox0sz3WEtBrUtcyJ5bf3sx79pDToOvuB3F5WvMBHoiR/YZRGZ9gvK84
	lMmPY4nvApTlv3mIidVoGw8sAUOTUNo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702970699;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yxH80z026qnk4/BFmJ/oRlZKA7vzjGyyDCfGbkbjlmE=;
	b=TT6K+BOyD7ur/R68rUCEv1/VQGjhi3X7i/gTX9F1WBUwtiC5SWpCwbHdz/XD+2YbNt3/k5
	vmF92+SGQn1WnbCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702970699; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yxH80z026qnk4/BFmJ/oRlZKA7vzjGyyDCfGbkbjlmE=;
	b=jvA4euUalc+VZIxFtDNwUwPzAzURPq5Gq5NNtxEicquSGgZJ23TfCzbkORSFQ2onm9Xvcq
	xfUOAOo0wbTkXQ4Ox0sz3WEtBrUtcyJ5bf3sx79pDToOvuB3F5WvMBHoiR/YZRGZ9gvK84
	lMmPY4nvApTlv3mIidVoGw8sAUOTUNo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702970699;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yxH80z026qnk4/BFmJ/oRlZKA7vzjGyyDCfGbkbjlmE=;
	b=TT6K+BOyD7ur/R68rUCEv1/VQGjhi3X7i/gTX9F1WBUwtiC5SWpCwbHdz/XD+2YbNt3/k5
	vmF92+SGQn1WnbCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A3FBF136A5;
	Tue, 19 Dec 2023 07:24:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IP7RJUpFgWVmcgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 19 Dec 2023 07:24:58 +0000
Message-ID: <e0eb22cd-9959-44cb-b913-4c1be9a2a2f6@suse.de>
Date: Tue, 19 Dec 2023 08:24:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/16] nvmet: report ioccsz and iorcsz for disc ctrl
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 James Smart <james.smart@broadcom.com>
References: <20231218153105.12717-1-dwagner@suse.de>
 <20231218153105.12717-2-dwagner@suse.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20231218153105.12717-2-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.18
X-Spamd-Result: default: False [-3.18 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-1.89)[94.39%];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Flag: NO

On 12/18/23 16:30, Daniel Wagner wrote:
> The host started to verify the ioccsz and iorcsz values. I/O controllers
> return valid values but not the discovery controllers. Use the same
> values as for I/O controllers.
> 
> Fixes: 2fcd3ab39826 ("nvme-fabrics: check ioccsz and iorcsz")
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/target/discovery.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
> index 668d257fa986..e3c4d247dd23 100644
> --- a/drivers/nvme/target/discovery.c
> +++ b/drivers/nvme/target/discovery.c
> @@ -249,6 +249,7 @@ static void nvmet_execute_disc_identify(struct nvmet_req *req)
>   {
>   	struct nvmet_ctrl *ctrl = req->sq->ctrl;
>   	struct nvme_id_ctrl *id;
> +	u32 cmd_capsule_size;
>   	u16 status = 0;
>   
>   	if (!nvmet_check_transfer_len(req, NVME_IDENTIFY_DATA_SIZE))
> @@ -294,6 +295,18 @@ static void nvmet_execute_disc_identify(struct nvmet_req *req)
>   
>   	strscpy(id->subnqn, ctrl->subsys->subsysnqn, sizeof(id->subnqn));
>   
> +	/*
> +	 * Max command capsule size is sqe + in-capsule data size.

'is sqe size + in-capsule data size'

> +	 * Disable in-capsule data for Metadata capable controllers.
> +	 */
> +	cmd_capsule_size = sizeof(struct nvme_command);
> +	if (!ctrl->pi_support)
> +		cmd_capsule_size += req->port->inline_data_size;
> +	id->ioccsz = cpu_to_le32(cmd_capsule_size / 16);

Why the division by 16?

> +
> +	/* Max response capsule size is cqe */
'is cqe size'

> +	id->iorcsz = cpu_to_le32(sizeof(struct nvme_completion) / 16);
> +
>   	status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
>   
>   	kfree(id);

Otherwise looks good.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich


