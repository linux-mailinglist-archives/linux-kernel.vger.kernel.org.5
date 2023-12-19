Return-Path: <linux-kernel+bounces-4802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C318481823A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E96B11C23547
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 07:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EEBC2D3;
	Tue, 19 Dec 2023 07:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yOE3WJRX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/mqU1Nj/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yOE3WJRX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/mqU1Nj/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A060C13E
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 07:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5F1A0220C5;
	Tue, 19 Dec 2023 07:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702970726; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nZkyNsXHdr4aOnSuf8AuFMNumXjRVj+fueK77OqUVok=;
	b=yOE3WJRXoMIkEDKlh89pa0Nu+oenGbV4KFYZWzWmmiCAqmgniJbasmaZA8pKt2WmjdUlJG
	9/83WQ8mbRu1fqmDaTBHG2LoNYzxOFEIAQI9/9VZazAP0fsEMNL3I281l7F/qGO8mbjior
	LrY0ZI3trrLWss3T+B1Rp+7a5u+TMQo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702970726;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nZkyNsXHdr4aOnSuf8AuFMNumXjRVj+fueK77OqUVok=;
	b=/mqU1Nj/yOhpZP3MdBaGc/dkFPs5xseMvqCuhJGZU6ECq44/ksutqUyt5y7zCxyC3I1TlA
	A+kXxJfv69Jr6GDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702970726; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nZkyNsXHdr4aOnSuf8AuFMNumXjRVj+fueK77OqUVok=;
	b=yOE3WJRXoMIkEDKlh89pa0Nu+oenGbV4KFYZWzWmmiCAqmgniJbasmaZA8pKt2WmjdUlJG
	9/83WQ8mbRu1fqmDaTBHG2LoNYzxOFEIAQI9/9VZazAP0fsEMNL3I281l7F/qGO8mbjior
	LrY0ZI3trrLWss3T+B1Rp+7a5u+TMQo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702970726;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nZkyNsXHdr4aOnSuf8AuFMNumXjRVj+fueK77OqUVok=;
	b=/mqU1Nj/yOhpZP3MdBaGc/dkFPs5xseMvqCuhJGZU6ECq44/ksutqUyt5y7zCxyC3I1TlA
	A+kXxJfv69Jr6GDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EFC98136A5;
	Tue, 19 Dec 2023 07:25:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6Dt9NmVFgWVmcgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 19 Dec 2023 07:25:25 +0000
Message-ID: <e47cf4c5-0b6c-443a-bfb9-c7bdb649816c@suse.de>
Date: Tue, 19 Dec 2023 08:25:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/16] nvmet-fc: remove unnecessary bracket
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 James Smart <james.smart@broadcom.com>
References: <20231218153105.12717-1-dwagner@suse.de>
 <20231218153105.12717-3-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20231218153105.12717-3-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Level: 
X-Spamd-Result: default: False [-5.95 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-1.86)[94.18%];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -5.95
X-Spam-Flag: NO

On 12/18/23 16:30, Daniel Wagner wrote:
> There is no need for the bracket around the identifier. Remove it.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/target/fc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> index bd59990b5250..bda7a3009e85 100644
> --- a/drivers/nvme/target/fc.c
> +++ b/drivers/nvme/target/fc.c
> @@ -1031,7 +1031,7 @@ nvmet_fc_match_hostport(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
>   	list_for_each_entry(host, &tgtport->host_list, host_list) {
>   		if (host->hosthandle == hosthandle && !host->invalid) {
>   			if (nvmet_fc_hostport_get(host))
> -				return (host);
> +				return host;
>   		}
>   	}
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


