Return-Path: <linux-kernel+bounces-5127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D708186C8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31D341F24054
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FD21B268;
	Tue, 19 Dec 2023 11:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="g//PLZb+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8eF+dDUy";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zz0RHkAC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2lIkDj1Y"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75511B26C
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 11:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D55C3220F3;
	Tue, 19 Dec 2023 11:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702987140; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8LlV4EThE5QajqoIuW051/JC+1vZmLfJE/NS9mDkCdU=;
	b=g//PLZb+1NBGvOKmcYTjxbNrINWLLGuy24epM2WT06gnyc3UdEEhop/FCgOMBy2JpKUTpa
	hRDkA1UM/0lxS3hd+RD+5rTry/2EUpV8O0vyIrxGNDhJIi5RmitUWcldwrYArHvdQSluRx
	+oKIEZf9xKhB/lLsWGOyx748qWdHcAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702987140;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8LlV4EThE5QajqoIuW051/JC+1vZmLfJE/NS9mDkCdU=;
	b=8eF+dDUy4eK4pIQgEye58M4XVivv7ltAQeQ3rQ3I/USRQXv9FLpvYy4kwbU+TkF+kaCMWe
	aQ8Hn4BaB9CvhTBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702987139; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8LlV4EThE5QajqoIuW051/JC+1vZmLfJE/NS9mDkCdU=;
	b=zz0RHkACMN1QgAkT7AdW1FFYHW2orAyl0t+y3jQD+cJCffgk4wGbxBpZiKYOQmXkRXH4Av
	FFI4nriwHh+MIx93YOA+HlwL+K+6CU9DQnD5VpMwBr8aBl94A3Far1Ja+01d1bhQiXnuWX
	sJJCfhHw7qga1VhkWoh6LGooqomhw9g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702987139;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8LlV4EThE5QajqoIuW051/JC+1vZmLfJE/NS9mDkCdU=;
	b=2lIkDj1YZG8N81xJOZy6EZAxRtaZY+aVCzxQn+NwOxKw3kRnvVVjILH1P9UKDtAKCc1Khl
	y5LqKthQJix+vCAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0DEFD1375D;
	Tue, 19 Dec 2023 11:58:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YLHFAIOFgWV1OgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 19 Dec 2023 11:58:59 +0000
Message-ID: <91f57dca-99c9-464b-b605-577fdff4a948@suse.de>
Date: Tue, 19 Dec 2023 12:58:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/6] nvme: add csi, ms and nuse to sysfs
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Max Gurtovoy <mgurtovoy@nvidia.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>
References: <20231218165954.29652-1-dwagner@suse.de>
 <20231218165954.29652-6-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20231218165954.29652-6-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zz0RHkAC;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2lIkDj1Y
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.31 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-1.81)[93.85%];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[grimberg.me:email,suse.de:dkim,suse.de:email,lst.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -3.31
X-Rspamd-Queue-Id: D55C3220F3
X-Spam-Flag: NO

On 12/18/23 17:59, Daniel Wagner wrote:
> libnvme is using the sysfs for enumarating the nvme resources. Though
> there are few missing attritbutes in the sysfs. For these libnvme issues
> commands during discovering.
> 
> As the kernel already knows all these attributes and we would like to
> avoid libnvme to issue commands all the time, expose these missing
> attributes.
> 
> The nuse value is updated on request because the nuse is a volatile
> value. Since any user can read the sysfs attribute, a very simple rate
> limit is added (update once every 5 seconds). A more sophisticated
> update strategy can be added later if there is actually a need for it.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/host/core.c  |  6 ++-
>   drivers/nvme/host/nvme.h  |  6 +++
>   drivers/nvme/host/sysfs.c | 85 +++++++++++++++++++++++++++++++++++++++
>   3 files changed, 96 insertions(+), 1 deletion(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich


