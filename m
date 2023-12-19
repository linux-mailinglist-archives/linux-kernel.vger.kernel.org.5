Return-Path: <linux-kernel+bounces-5122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C30008186C1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78B0E1F23E8D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C5B18641;
	Tue, 19 Dec 2023 11:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LiZCWRsP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GahS37pg";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SHWlNkvl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vAE5dI/y"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC811805C
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 11:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 88129220FA;
	Tue, 19 Dec 2023 11:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702987029; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U+yNINAh8nZs2xuU3b1iHseGI4bE6aNia+UrvQr6PII=;
	b=LiZCWRsPrnaxDNyBpHc9sUYct6c2z2u3/Ci2k3lr3D7fiIpOxyUki8DV5Xhm/dyPvCd4vK
	QuHj23xU+E4NFUDZ11/Pi7ewEmVgwdwA4c9aI2YVG2vhiIBU0rLWsaq5Y/b+d2sXb/5Snp
	PLsRsn3ptvJV3KpuuHGhRHJzbqbRqi8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702987029;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U+yNINAh8nZs2xuU3b1iHseGI4bE6aNia+UrvQr6PII=;
	b=GahS37pgNIEWzubnsPql3p2P2rW8+ZCk7L4DiOCqH3jNIKphDUG4l/lApDrn2m/VmSGcum
	MQrxRklNOqZ2P5Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702987027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U+yNINAh8nZs2xuU3b1iHseGI4bE6aNia+UrvQr6PII=;
	b=SHWlNkvlI9aEqu+vJc/nhbr3tyJSatGXP7Xtw4wDs7876dowEonbhgeekLjH7wLrwd7sgJ
	zNOOxLPHiYPEsSiY9A7BUedJGwm6rzvJwqx+qwkQl2LoEu8sf3JcjByWTVOkz5ST1N4Y5y
	VCr9FH/ZrhcBFM7hZ3toN9PqQ9gBJkY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702987027;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U+yNINAh8nZs2xuU3b1iHseGI4bE6aNia+UrvQr6PII=;
	b=vAE5dI/yDSdz2SI2v3UEBG2hccpI+Bt0HrOQ0n5/eT4pY90LQhUxThsy3td9DlgX7rto8O
	LLdLK6GACEVakqDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 145751375D;
	Tue, 19 Dec 2023 11:57:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WHOMAhOFgWV1OgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 19 Dec 2023 11:57:07 +0000
Message-ID: <863fd40b-c702-4450-a136-d47567080bd7@suse.de>
Date: Tue, 19 Dec 2023 12:57:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/6] nvme: refactor ns info helpers
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Max Gurtovoy <mgurtovoy@nvidia.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>
References: <20231218165954.29652-1-dwagner@suse.de>
 <20231218165954.29652-3-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20231218165954.29652-3-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Level: 
X-Spamd-Result: default: False [-5.12 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-1.03)[87.49%];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -5.12
X-Spam-Flag: NO

On 12/18/23 17:59, Daniel Wagner wrote:
> Pass in the nvme_ns_head pointer directly. This reduces the necessity on
> the caller side have the nvme_ns data structure present. Thus we can
> refactor the caller side in the next step as well.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/host/core.c | 36 +++++++++++++++++++++---------------
>   drivers/nvme/host/nvme.h | 12 ++++++------
>   drivers/nvme/host/rdma.c |  2 +-
>   drivers/nvme/host/zns.c  | 12 ++++++------
>   4 files changed, 34 insertions(+), 28 deletions(-)
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


