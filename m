Return-Path: <linux-kernel+bounces-54232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F01C84AC9A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 04:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E18EB2263D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 03:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A8C67C41;
	Tue,  6 Feb 2024 03:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aRu7T3pQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8rrEetDg";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aRu7T3pQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8rrEetDg"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63836E2B0
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 03:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707188652; cv=none; b=FngidlQ+a+E5IS3pFVcF/yo2MnK62sWluJQAOkXONOTXOLF1J+M+1n1H4mD5+ogsf3TI6EVKm4Pe7QFDqL4AeCKPSbEcJllEV7mLb6c0/TAWTixQoysn/abODf8OHw4YnAENcK8yL18yXyai1VXyPbEvlLqQNmTkPKN7t9fU7Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707188652; c=relaxed/simple;
	bh=ww46tD2Od0nYH5J4gwEy8wBZVzCwJinYr6xWvnQIAak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jposxYoI+tVE3zUPekjYdc9Sy/MoMT3q1rMRenwnpKUcaLX8mt0BPEHRsOdYBFpyM7xJPeFBwF7otQbTGuIbbStoJc++iB7tlC0X66GsgvSGw2PTXrofdooMepv3eXKUGtGnnYw4wW6EM0miEjM4x6UOxhgUmzFK1n2IAyH/ngw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aRu7T3pQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8rrEetDg; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aRu7T3pQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8rrEetDg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 80E37221A0;
	Tue,  6 Feb 2024 03:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707188648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PMJ17O1CmqNUVr9CqnSAoYW18iVFOklGqfFbXcdL5RQ=;
	b=aRu7T3pQG6tTCRTJTiS1mIQsc8jAB5BLHZuqWknkOAoBJsDjEm/msx5XEAKgOMyoxpTYde
	b7gua5F7B3Rd1c796/UmIHGif7MR3NzUmXen200XdpvdcY9Keg/T7xXx31GrppifP9WgNt
	/bzte79pyZzQ6bUUE9SJWHaDVx0CVbk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707188648;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PMJ17O1CmqNUVr9CqnSAoYW18iVFOklGqfFbXcdL5RQ=;
	b=8rrEetDgjr9nA6tQE19WnulbyHkTuwtID7tiyqiWfecIztXvF6vTDQNqDqhVkajdDUNace
	M51pM2PYDm3ILPBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707188648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PMJ17O1CmqNUVr9CqnSAoYW18iVFOklGqfFbXcdL5RQ=;
	b=aRu7T3pQG6tTCRTJTiS1mIQsc8jAB5BLHZuqWknkOAoBJsDjEm/msx5XEAKgOMyoxpTYde
	b7gua5F7B3Rd1c796/UmIHGif7MR3NzUmXen200XdpvdcY9Keg/T7xXx31GrppifP9WgNt
	/bzte79pyZzQ6bUUE9SJWHaDVx0CVbk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707188648;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PMJ17O1CmqNUVr9CqnSAoYW18iVFOklGqfFbXcdL5RQ=;
	b=8rrEetDgjr9nA6tQE19WnulbyHkTuwtID7tiyqiWfecIztXvF6vTDQNqDqhVkajdDUNace
	M51pM2PYDm3ILPBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3B851132DD;
	Tue,  6 Feb 2024 03:04:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id USo/OKWhwWW4GgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 06 Feb 2024 03:04:05 +0000
Message-ID: <68049531-3114-4afc-b6ba-e226b14b7806@suse.de>
Date: Tue, 6 Feb 2024 12:03:59 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/12] nvmet-fc: avoid deadlock on delete association
 path
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240131085112.21668-1-dwagner@suse.de>
 <20240131085112.21668-11-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240131085112.21668-11-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=aRu7T3pQ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=8rrEetDg
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.48 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-2.98)[99.91%];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -4.48
X-Rspamd-Queue-Id: 80E37221A0
X-Spam-Flag: NO

On 1/31/24 16:51, Daniel Wagner wrote:
> When deleting an association the shutdown path is deadlocking because we
> try to flush the nvmet_wq nested. Avoid this by deadlock by deferring
> the put work into its own work item.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/target/fc.c | 16 +++++++++++++---
>   1 file changed, 13 insertions(+), 3 deletions(-)
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


