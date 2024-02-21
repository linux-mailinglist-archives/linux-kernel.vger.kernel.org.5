Return-Path: <linux-kernel+bounces-75038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F8385E202
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84C31B21C93
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4901981AAD;
	Wed, 21 Feb 2024 15:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Y2SFviG8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/WAwWXy+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YsZ/pQyV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kHxMQ89N"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94046811E7
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708530844; cv=none; b=ci5hB9GtE8ah/MlJFSjYK5ls4uCT/Mbk3u7Nf0PGrEJMJmdMmDBNLiYc+U0Tz0/J2SoMe6PtPXJd8LOt+x87Uc074MipYd8WyhUiOH6/MVTyQaNdyDhYkzzYEcm+3W3pV5E50aNBHPpNdTogkN51d0jd18G7o0vXtnrnSg7pSI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708530844; c=relaxed/simple;
	bh=s+LZ0pvHtncUDQUa+gsEJgwQsHDI81gcr9cLw5gIcP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g/9feax+CtmGWEe3lO85O6LRU+B27AsSn/ywHte16RP5EH7WUBqYtds/s7PyD7M2E9aHQ+ZdbgMCIHb/AG2tHJ7IBeXfrqHOPkuBL50m+cv7hlcbqZltQqf2QEIZ6uUxlhq+Lg8IzSoTtGSyIhTSxcEqbxQnmN6t0Z/I+Lz1S9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Y2SFviG8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/WAwWXy+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YsZ/pQyV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kHxMQ89N; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E040C1FB65;
	Wed, 21 Feb 2024 15:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708530827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jfmran7z3EZ2MYdF79KDI1n2PQIk6M5b4/gNnUh5quE=;
	b=Y2SFviG8Kfqogu3HBU9UdX91Hd3BiFS+eLonXnuOSulcbMAjq0jCoQDu6TkyOITXDmozcI
	uhpERPSzq6zO9yL3XeFrAPGTZ7cCB53JvxelTwsYiITP9rdP716NH3EJh+eeueQDE/WoGy
	UUh9CgeTvS93HnJy+l7lM8wENZu4Mao=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708530827;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jfmran7z3EZ2MYdF79KDI1n2PQIk6M5b4/gNnUh5quE=;
	b=/WAwWXy+xxY3E3+aEZQFyatvSlgvFm24Ha73i6SOPPgjmmB1BCOKNA5nSrcDgjnoVCcnBA
	Cq7ATt+Som0MztBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708530826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jfmran7z3EZ2MYdF79KDI1n2PQIk6M5b4/gNnUh5quE=;
	b=YsZ/pQyV+LQI/nCt8zSi3cJs89SgUg5sV99TNkG/r/26Dtr8jW2oZVk/0bTilzUCWDbPr3
	IqOhxETSpcBHRu9t0NyYHSCURDYpT4thNbSpI5ReKBW0L645DOLLPPuMdC9AFzqqLX+7jx
	hIkf0RdATddprUNCqPgEQesieazwn2k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708530826;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jfmran7z3EZ2MYdF79KDI1n2PQIk6M5b4/gNnUh5quE=;
	b=kHxMQ89NIxUtOZ6rUfWb3kmUfmO69/hfuliVLpahozSGe2rOATDaUoT+vnvaMmJygU48YW
	4dxII1LMua5PjUBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D204213A69;
	Wed, 21 Feb 2024 15:53:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gCgrMYgc1mWjFgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 21 Feb 2024 15:53:44 +0000
Message-ID: <d5b3d5b2-ec27-4057-aa76-63fe17066cfc@suse.de>
Date: Wed, 21 Feb 2024 16:53:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] nvme-fc: do not retry when auth fails or
 connection is refused
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240221132404.6311-1-dwagner@suse.de>
 <20240221132404.6311-3-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240221132404.6311-3-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.80
X-Spamd-Result: default: False [-1.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-0.51)[80.15%];
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

On 2/21/24 14:24, Daniel Wagner wrote:
> There is no point in retrying to connect if the authentication fails.
> 
> Connection refused is also issued from the authentication path, thus
> also do not retry.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/host/fc.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index a5b29e9ad342..b81046c9f171 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -3312,6 +3312,8 @@ nvme_fc_reconnect_or_delete(struct nvme_fc_ctrl *ctrl, int status)
>   			ctrl->cnum, status);
>   		if (status > 0 && (status & NVME_SC_DNR))
>   			recon = false;
> +		if (status == NVME_SC_AUTH_REQUIRED || status == -ECONNREFUSED)
> +			recon = false;
>   	} else if (time_after_eq(jiffies, rport->dev_loss_end))
>   		recon = false;
>   
Is this still required after the patchset to retry authentication errors?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


