Return-Path: <linux-kernel+bounces-68501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B98857B35
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16251286389
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A4C59B5F;
	Fri, 16 Feb 2024 11:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aAHPjnUA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/tNKM1xP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aAHPjnUA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/tNKM1xP"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C7A59160
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 11:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708081767; cv=none; b=h1qUjYBo02kvU3qujHW5Xg6b122DsR2KzGDTsw96Q8U83RHQ3D3ku78Jmh8UTOJBHg747NhFdoXD42sQv+uo45/tukCAvhjR5vGwvs1tKgUw6vl+IrvjIcxe1e7yp4Yi56Vn0MoU0CVZb2t1ACGyeTN5qcIkY3neckY1z/GJoAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708081767; c=relaxed/simple;
	bh=gnlnNaO6Jwu3jGhpnG3RtcC00IxLKo7FT966b2z+Qcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TjXFvprwcJeksHPYR2WPqQ3kkNHXmIDYbcjVHCkhk40dHXq8OFe94k1DmvN3wkMn0uAUz6Zd3pxzgV5W9rMyiuLJ9DGwOuXmSS5gXnXzu98qMohD07PFVO3Wd5M7qGS4r+F/VmaBVB0t3pkuWT4tEG434wdEEiQaGah7RheuL6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aAHPjnUA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/tNKM1xP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aAHPjnUA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/tNKM1xP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5C6AE21E2A;
	Fri, 16 Feb 2024 11:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708081761; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rwwWeQK23rV3LdqRhnQ9vejxA72yppWbxf7GL0vqx8A=;
	b=aAHPjnUAKnk6MXnVrRwcdGAQ8xuMU8nT7nR1dMboqyhqTjgvrbuUHYl9b0IW02x2x7/axp
	5b6c7B6I30T8kBft6zyQvZURU8l15GeAgm0KEOdtPY+pUjtcZNdlGRPMC3wIsf5NYX63iF
	whX3xd1fs5E8morsKYFw0l8/bNReofc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708081761;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rwwWeQK23rV3LdqRhnQ9vejxA72yppWbxf7GL0vqx8A=;
	b=/tNKM1xPBYvJos8/PZ4VPGpej21OatF3QKShuR+PfhtaI+MK+A25VBr4YyfR4bVRuIPf6R
	PMnZ8nFZlagHZkDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708081761; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rwwWeQK23rV3LdqRhnQ9vejxA72yppWbxf7GL0vqx8A=;
	b=aAHPjnUAKnk6MXnVrRwcdGAQ8xuMU8nT7nR1dMboqyhqTjgvrbuUHYl9b0IW02x2x7/axp
	5b6c7B6I30T8kBft6zyQvZURU8l15GeAgm0KEOdtPY+pUjtcZNdlGRPMC3wIsf5NYX63iF
	whX3xd1fs5E8morsKYFw0l8/bNReofc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708081761;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rwwWeQK23rV3LdqRhnQ9vejxA72yppWbxf7GL0vqx8A=;
	b=/tNKM1xPBYvJos8/PZ4VPGpej21OatF3QKShuR+PfhtaI+MK+A25VBr4YyfR4bVRuIPf6R
	PMnZ8nFZlagHZkDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1998313A39;
	Fri, 16 Feb 2024 11:09:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ttPHBWFCz2WuBgAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 16 Feb 2024 11:09:21 +0000
Message-ID: <c5f27e3c-d034-4a40-bfb5-1bd5ec5f5dfc@suse.de>
Date: Fri, 16 Feb 2024 12:09:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v0 5/6] nvme-fc: redesign locking and refcounting
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240216084526.14133-1-dwagner@suse.de>
 <20240216084526.14133-6-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240216084526.14133-6-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -8.29
X-Spamd-Result: default: False [-8.29 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
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

On 2/16/24 09:45, Daniel Wagner wrote:
> The life time of the controller is managed by the upper layers.
> 
> Thus just ref counting the controller when creating it and giving the
> ref back on the cleanup path. This is how the other transport are
> managed as well. Until now, the ref count has been taken per LS request
> which is not really necessary as the core guarantees that there is no in
> flight request when shuting down (if we use the nvme APIs are used
> correctly).
> 
> In fact we don't really need the ref count for nvme_fc_ctrl at this
> point. Though, the FC transport is offloading the connect attempt to a
> workqueue and in the next patch we introduce a sync option for which the
> ref counter is necessary. So let's keep it around.
> 
> Also take a ref for lport and rport when creating the controller and
> give it back when we destroy the controller. This means these refs are
> tied to the life time of the controller and not the other way around.
> 
> We have also to reorder the cleanup code in nvme_fc_delete_ctrl and
> nvme_fc_free_ctrl so that we do not expose resources too long and run
> into use after free situations which are currently possible.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/host/fc.c | 136 +++++++++++++----------------------------
>   1 file changed, 41 insertions(+), 95 deletions(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index ddbc5b21af5b..7f9edab57550 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -229,6 +229,9 @@ static struct device *fc_udev_device;
>   
>   static void nvme_fc_complete_rq(struct request *rq);
>   
> +static void nvme_fc_ctrl_put(struct nvme_fc_ctrl *);
> +static int nvme_fc_ctrl_get(struct nvme_fc_ctrl *);
> +
>   /* *********************** FC-NVME Port Management ************************ */
>   
>   static void __nvme_fc_delete_hw_queue(struct nvme_fc_ctrl *,
> @@ -800,7 +803,7 @@ nvme_fc_ctrl_connectivity_loss(struct nvme_fc_ctrl *ctrl)
>   			dev_warn(ctrl->ctrl.device,
>   				"NVME-FC{%d}: Couldn't schedule reset.\n",
>   				ctrl->cnum);
> -			nvme_delete_ctrl(&ctrl->ctrl);
> +			nvme_fc_ctrl_put(ctrl);
>   		}
>   		break;
>   
> @@ -868,7 +871,7 @@ nvme_fc_unregister_remoteport(struct nvme_fc_remote_port *portptr)
>   			dev_warn(ctrl->ctrl.device,
>   				"NVME-FC{%d}: controller connectivity lost.\n",
>   				ctrl->cnum);
> -			nvme_delete_ctrl(&ctrl->ctrl);
> +			nvme_fc_ctrl_put(ctrl);
>   		} else
>   			nvme_fc_ctrl_connectivity_loss(ctrl);
>   	}
> @@ -1022,9 +1025,6 @@ fc_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
>   
>   /* *********************** FC-NVME LS Handling **************************** */
>   
> -static void nvme_fc_ctrl_put(struct nvme_fc_ctrl *);
> -static int nvme_fc_ctrl_get(struct nvme_fc_ctrl *);
> -
>   static void nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg);
>   
>   static void
> @@ -1050,8 +1050,6 @@ __nvme_fc_finish_ls_req(struct nvmefc_ls_req_op *lsop)
>   	fc_dma_unmap_single(rport->dev, lsreq->rqstdma,
>   				  (lsreq->rqstlen + lsreq->rsplen),
>   				  DMA_BIDIRECTIONAL);
> -
> -	nvme_fc_rport_put(rport);
>   }
>   
Hmm. I'm a bit unsure about this; essentially you change the rport 
refcounting (and not just the controller refcounting).
And the problem here is that rport refcounting is actually tied to
the driver-internal rports, which have a different lifetime
(dev_loss_tmo and all that).

Would it be possible to break this in two, with one patch changing the 
controller/options refcounting and the other one changing the rport 
refcounting?

Cheers,

Hannes


