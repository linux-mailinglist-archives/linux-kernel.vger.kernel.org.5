Return-Path: <linux-kernel+bounces-48144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 611238457F1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 151BE28CF1B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB0886638;
	Thu,  1 Feb 2024 12:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TBsQMI8V";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SCM3kbqr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Oj6fHY44";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Kt+M9LIW"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801DD53362
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 12:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706791304; cv=none; b=ZpzVjSL5eZBUNUHPhaaQF1qttVzjDzM1WjwzhbXi6CFi4P6EMAqNo6ybhZR6PaPma7JnjOblaLJPO+4UMvh1FEGNPkwUVxI5x1Q71qcKpdrJ/plQG6EpUgda4VqgnZZfEEcyCuME3Lq7ssOYcieBGCfu5wCtjd7iK2ja/WZFf7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706791304; c=relaxed/simple;
	bh=vzOwURaJGFGngjzlTNi14jTCw9s2QcCg9bsA4XtIG2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OL/x1a/MCOYOohlVUJwoPN9M4IRNs7EBUmJIhULtAr/B3ErBgbYi4poQvw7E2Gbtyccz2y2gqgm/KItcxTXbjNb57GsPbVgiNql/er7zFGRguMqkuo7HapzMwE7C3WlQAicpKTQYlOJ9fHSOEv3pT5dcJWEfYL04Jnbb9RQlA3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TBsQMI8V; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SCM3kbqr; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Oj6fHY44; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Kt+M9LIW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9E4582213F;
	Thu,  1 Feb 2024 12:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706791300; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mZAhmoimqX/LFqyFMVuwwM2dsHNWcXM1TVKD5f+E3iQ=;
	b=TBsQMI8V4yJ3FugvLlIWA4PWW77HxgUrYNypS1PgR+7ESl2drUJHP/vZlgopDhVdIEkXBb
	CkXHZZFbwTEMOB6cZfQpkDSMuHaq6H9NukwC6+x9BiL+Y6kNhBkbYjsHB1Jqgk07NLTSu8
	h+PMo7XQZ4FYNhZ4w2mcpwvn99BHI6E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706791300;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mZAhmoimqX/LFqyFMVuwwM2dsHNWcXM1TVKD5f+E3iQ=;
	b=SCM3kbqr+J/ToX9ZTq6Hz/1GABTHlV3HR+EGhCvbq/EddrRYpPEZrqWIyAbJo6XD6izwOS
	ACrlnIj0zrml2EDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706791299; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mZAhmoimqX/LFqyFMVuwwM2dsHNWcXM1TVKD5f+E3iQ=;
	b=Oj6fHY44xm8f+RcRl402bUNPfwSKVGPi0J9AvH+6ey7OMm9eSgnpdyrerV4v2GYdgtHHZg
	2quewS7HBGMq4vXtzGOws/UMBkREf+pdHNLDiZN+lStJZpJfPI+EEi2Shm6FPqYp45nafW
	GEHPeGGONUPLV7t5MdLLChuAHjqI9+I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706791299;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mZAhmoimqX/LFqyFMVuwwM2dsHNWcXM1TVKD5f+E3iQ=;
	b=Kt+M9LIW0v54SADgTAPOmLy0uhSjVCTxGaCWPNZAW8lGzdlY8/+sPAjF3L5VVGRJABPhuh
	ByKsBt6UBs5MRGAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E94B5139B1;
	Thu,  1 Feb 2024 12:41:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lqUqLIGRu2XNOAAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 01 Feb 2024 12:41:37 +0000
Message-ID: <3da93cc3-80a9-4dbf-b6af-aa5fc6b35b33@suse.de>
Date: Thu, 1 Feb 2024 13:41:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/12] nvme-fc: do not wait in vain when unloading
 module
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240131085112.21668-1-dwagner@suse.de>
 <20240131085112.21668-2-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240131085112.21668-2-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -4.29
X-Spamd-Result: default: False [-4.29 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Flag: NO

On 1/31/24 09:51, Daniel Wagner wrote:
> The module exit path has race between deleting all controllers and
> freeing 'left over IDs'. To prevent double free a synchronization
> between nvme_delete_ctrl and ida_destroy has been added by the initial
> commit.
> 
> There is some logic around trying to prevent from hanging forever in
> wait_for_completion, though it does not handling all cases. E.g.
> blktests is able to reproduce the situation where the module unload
> hangs forever.
> 
> If we completely rely on the cleanup code executed from the
> nvme_delete_ctrl path, all IDs will be freed eventually. This makes
> calling ida_destroy unnecessary. We only have to ensure that all
> nvme_delete_ctrl code has been executed before we leave
> nvme_fc_exit_module. This is done by flushing the nvme_delete_wq
> workqueue.
> 
> While at it, remove the unused nvme_fc_wq workqueue too.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/host/fc.c | 47 ++++++------------------------------------
>   1 file changed, 6 insertions(+), 41 deletions(-)
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


