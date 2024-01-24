Return-Path: <linux-kernel+bounces-37331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5EC283AE56
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46E2F28F761
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C247CF30;
	Wed, 24 Jan 2024 16:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lQ9tgBBW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oE8dTMc/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lQ9tgBBW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oE8dTMc/"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC687C09F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 16:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706113624; cv=none; b=JABriikj2JpUpbD3TZMHJB4h/Zf5U4P/J5QIPnZoMx1SpFFHXBZa9Tr6wvfYh8r6KHtsQVLxX8bxc20hOlv0/MyizdNDuysHfVBSQYeRmzXKypE1TdfFv4bkyxQrMqtvvl/L9kXWrLmTtuPweYTuJcGwQaH2OtSzaJt1RWMzkJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706113624; c=relaxed/simple;
	bh=waBFxmJupUTBTaPp1HXvC5yAn86vKXcb4A0xPu8gN84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a8tduf40m2PoFcSdRCOnhgnRrPLQcQzAP+zph9LDVgYhWfAQiA9KZKsZ5V9565IxUiZaG91oQazaVqVS8I9MGGfD/T9qYS9Q2cNCNKdEFNAclC09c9L/Hzd/eFNR34PY7mXaxx1PpSJBiHbkX/wx9GqaZswePekJ7ud7MAv8oqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lQ9tgBBW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oE8dTMc/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lQ9tgBBW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oE8dTMc/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BE6B01F7FB;
	Wed, 24 Jan 2024 16:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706113619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=symhIeQH+xFWWu7ZkOKh67eF07PcSm6nFW937Q3F2fE=;
	b=lQ9tgBBWiCAYqZ9mf1n59omqAWxrXnqo/eL8Hw7Xya/3iKO6iKDWcOMoGSCGkoy6hGlWjE
	EWDSIEU8zsiL9ZQ6GOeTuLVJp96KhHPG5dsNk8KMPvlt3HZJQ8BY8wMhZ6rxSQnjuBNsYB
	Vl9cUcdmX0Uz9K8djynrRG7lp9SgYrQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706113619;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=symhIeQH+xFWWu7ZkOKh67eF07PcSm6nFW937Q3F2fE=;
	b=oE8dTMc/hcssgtim+YYGpNPM7dkYgeDUHTeGwm6Iqi1wBQvReA/gdltDK5A8IIfSovxVRp
	QfA9m/vVVlUCXqBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706113619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=symhIeQH+xFWWu7ZkOKh67eF07PcSm6nFW937Q3F2fE=;
	b=lQ9tgBBWiCAYqZ9mf1n59omqAWxrXnqo/eL8Hw7Xya/3iKO6iKDWcOMoGSCGkoy6hGlWjE
	EWDSIEU8zsiL9ZQ6GOeTuLVJp96KhHPG5dsNk8KMPvlt3HZJQ8BY8wMhZ6rxSQnjuBNsYB
	Vl9cUcdmX0Uz9K8djynrRG7lp9SgYrQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706113619;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=symhIeQH+xFWWu7ZkOKh67eF07PcSm6nFW937Q3F2fE=;
	b=oE8dTMc/hcssgtim+YYGpNPM7dkYgeDUHTeGwm6Iqi1wBQvReA/gdltDK5A8IIfSovxVRp
	QfA9m/vVVlUCXqBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A48911333E;
	Wed, 24 Jan 2024 16:26:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UYzJJ1M6sWVnIwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 24 Jan 2024 16:26:59 +0000
Message-ID: <c2995f42-7b35-4d3f-8882-433354b2513a@suse.cz>
Date: Wed, 24 Jan 2024 17:26:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Revert "drm/sched: Split free_job into own work item"
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>,
 Luben Tuikov <ltuikov89@gmail.com>, Matthew Brost <matthew.brost@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "open list:DRM GPU SCHEDULER" <dri-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240123021155.2775-1-mario.limonciello@amd.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240123021155.2775-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-0.09 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BAYES_HAM(-0.00)[27.73%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 TO_DN_ALL(0.00)[];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 FREEMAIL_TO(0.00)[amd.com,gmail.com,intel.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,amd.com,lists.freedesktop.org,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -0.09

On 1/23/24 03:11, Mario Limonciello wrote:
> commit f7fe64ad0f22 ("drm/sched: Split free_job into own work item")
> causes graphics hangs at GDM or right after logging in on a
> Framework 13 AMD laptop (containing a Phoenix APU).
> 
> This reverts commit f7fe64ad0f22ff034f8ebcfbd7299ee9cc9b57d7.
> 
> Fixes: f7fe64ad0f22 ("drm/sched: Split free_job into own work item")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> This is a regression introduced in 6.8-rc1, bisected from 6.7.
> This revert done on top of 6.8-rc1 fixes the issue.

Applying this revert on 6.8-rc1 fixed my issues reported here:
https://lore.kernel.org/all/2faccc1a-7fdd-499b-aa0a-bd54f4068f3e@suse.cz/

Let me know if there's another fix instead of revert so I can test.

Thanks,
Vlastimil

> 
> I'm happy to gather any data to use to properly debug if that is
> preferable to a revert.
> ---
>  drivers/gpu/drm/scheduler/sched_main.c | 133 +++++++++----------------
>  include/drm/gpu_scheduler.h            |   4 +-
>  2 files changed, 48 insertions(+), 89 deletions(-)
> 


