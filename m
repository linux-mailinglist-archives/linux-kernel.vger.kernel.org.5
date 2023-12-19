Return-Path: <linux-kernel+bounces-5096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B43818689
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CACCB238D3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC453179B5;
	Tue, 19 Dec 2023 11:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EutZX/Pk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SQQj8EhP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EutZX/Pk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SQQj8EhP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1250717725
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 11:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 62D522209F;
	Tue, 19 Dec 2023 11:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702986111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vC1tfMzAhjCnD74T2n6aB7HNv/A1nc9tsb7j5i5sPC8=;
	b=EutZX/Pkal2rAtYpb+nTO7t68KpNHhVki0rd4wqH3VtVSHR+UWOIPjb4BS9G94E0uJICSK
	znHWnip2jS20HlHPJ48mb2JxReco524wUJsKpt1Ukc6/wkmQ7GxHDZMzOGrWblF1+XY8BW
	K3OedsWk/VmyHjXXaCTdMw/xGbACVt4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702986111;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vC1tfMzAhjCnD74T2n6aB7HNv/A1nc9tsb7j5i5sPC8=;
	b=SQQj8EhP1UJypNjCbbc/HIr+F3ka9ubY7UaSkG7PdMxgtplGPkhQbIcKvezKEBSt4ZBblM
	MIcVrdot802c6pBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702986111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vC1tfMzAhjCnD74T2n6aB7HNv/A1nc9tsb7j5i5sPC8=;
	b=EutZX/Pkal2rAtYpb+nTO7t68KpNHhVki0rd4wqH3VtVSHR+UWOIPjb4BS9G94E0uJICSK
	znHWnip2jS20HlHPJ48mb2JxReco524wUJsKpt1Ukc6/wkmQ7GxHDZMzOGrWblF1+XY8BW
	K3OedsWk/VmyHjXXaCTdMw/xGbACVt4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702986111;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vC1tfMzAhjCnD74T2n6aB7HNv/A1nc9tsb7j5i5sPC8=;
	b=SQQj8EhP1UJypNjCbbc/HIr+F3ka9ubY7UaSkG7PdMxgtplGPkhQbIcKvezKEBSt4ZBblM
	MIcVrdot802c6pBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EAFF51375D;
	Tue, 19 Dec 2023 11:41:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id G+tINn6BgWVuNgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 19 Dec 2023 11:41:50 +0000
Message-ID: <ac062d49-05bd-4615-ac38-4a463d533917@suse.de>
Date: Tue, 19 Dec 2023 12:41:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/16] nvmet-fc: free hostport after release reference
 to tgtport
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 James Smart <james.smart@broadcom.com>
References: <20231218153105.12717-1-dwagner@suse.de>
 <20231218153105.12717-15-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20231218153105.12717-15-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.74
X-Spamd-Result: default: False [-2.74 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-1.45)[91.32%];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Flag: NO

On 12/18/23 16:31, Daniel Wagner wrote:
> Give the ref back before destroying the hostport object to prevent a
> potential UAF.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/target/fc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> index 663c51c9fe53..23d8779dc221 100644
> --- a/drivers/nvme/target/fc.c
> +++ b/drivers/nvme/target/fc.c
> @@ -986,8 +986,8 @@ nvmet_fc_hostport_free(struct kref *ref)
>   	spin_unlock_irqrestore(&tgtport->lock, flags);
>   	if (tgtport->ops->host_release && hostport->invalid)
>   		tgtport->ops->host_release(hostport->hosthandle);
> -	kfree(hostport);
>   	nvmet_fc_tgtport_put(tgtport);
> +	kfree(hostport);
>   }
>   
>   static void

That, I guess, needs some more explanation.
It's not immediately obvious why a 'put' on the targetport would
have implications on the hostport. But when it does wouldn't it
be more sensible to free up the reference to the hostport when the
final 'put' on the target port happens?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich


