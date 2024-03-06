Return-Path: <linux-kernel+bounces-93412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B739872F6A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C33DB25616
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 07:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32425C60B;
	Wed,  6 Mar 2024 07:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Xq0aH+q3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="br7dNpuy";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Xq0aH+q3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="br7dNpuy"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69793179BF;
	Wed,  6 Mar 2024 07:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709709435; cv=none; b=F5PeOW/RVfTNCBTQtU2b+aiIgjfvrJUB5+uQmP1fKumdqwqiR2I5VLDPqjWTzN11szzzdx68U6EONNWPlA8HNB4pjAVzGMY68RJC5UkswDiu6n7VAWTVai0ecSIwo3v57ZJykN1b/uTRFPNP/0fJHoYaN9lZC5iVACDE6MJgZ24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709709435; c=relaxed/simple;
	bh=e6kBCR38yOVfyRkBiLI8TJXaGGuRr/Mbl9M77fQv+YU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eZqOrqsFyD1Y++8R2JnmLBsp227WnPwg61Dt/Mg0J5xrR4j0+i5i4qlxcZAC6mwSCMQG8RjD8zUQroqPSnZM04pCfq1WunI/vvOCVRbWs4vMonEh+OvrQ0KEcfQXXJaVSxhf/UOuAs+dYB2HWFV/zAvpinsYzS84lkd4CsjGfcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Xq0aH+q3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=br7dNpuy; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Xq0aH+q3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=br7dNpuy; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9476B4D84D;
	Wed,  6 Mar 2024 07:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709709432; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dKxexSUlCbr3pxaBKng8EmhJBqv+UbMJEhUIZCBJViM=;
	b=Xq0aH+q3qFO89SWFIwx++3if5vi0uECAYL1/eka2lQkHSeVwK22OVIIELs5hyDuu1NzZZ3
	NsSU8042vP9OaK3pqzfdzg9FdOgMH5FyCn7vF7SsM1N9yY3DYiWRNmD3jJ34EBbmVEZD0y
	+5+PXm1WizxEQ+/JY/2wtlx2+jTlhZY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709709432;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dKxexSUlCbr3pxaBKng8EmhJBqv+UbMJEhUIZCBJViM=;
	b=br7dNpuy3PfCj2F4SytMevD5uAmhX/JMfCSrbDEWOmWIkP87wHAr7bYInREmXSozhyll6s
	BxlKTM0k42KFDmCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709709432; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dKxexSUlCbr3pxaBKng8EmhJBqv+UbMJEhUIZCBJViM=;
	b=Xq0aH+q3qFO89SWFIwx++3if5vi0uECAYL1/eka2lQkHSeVwK22OVIIELs5hyDuu1NzZZ3
	NsSU8042vP9OaK3pqzfdzg9FdOgMH5FyCn7vF7SsM1N9yY3DYiWRNmD3jJ34EBbmVEZD0y
	+5+PXm1WizxEQ+/JY/2wtlx2+jTlhZY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709709432;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dKxexSUlCbr3pxaBKng8EmhJBqv+UbMJEhUIZCBJViM=;
	b=br7dNpuy3PfCj2F4SytMevD5uAmhX/JMfCSrbDEWOmWIkP87wHAr7bYInREmXSozhyll6s
	BxlKTM0k42KFDmCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E5E7413A9C;
	Wed,  6 Mar 2024 07:17:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6EynMncY6GWbVgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 06 Mar 2024 07:17:11 +0000
Message-ID: <eb04c245-4d76-4d72-a92a-95e4e0a0124e@suse.de>
Date: Wed, 6 Mar 2024 08:17:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/7] scsi: aic94xx: Add libsas SATA sysfs attributes
 group
Content-Language: en-US
To: Igor Pylypiv <ipylypiv@google.com>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, John Garry <john.g.garry@oracle.com>,
 Jason Yan <yanaijie@huawei.com>, "James E.J. Bottomley"
 <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>,
 Jack Wang <jinpu.wang@cloud.ionos.com>,
 Xiang Chen <chenxiang66@hisilicon.com>,
 Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
 Bart Van Assche <bvanassche@acm.org>
Cc: TJ Adams <tadamsjr@google.com>, linux-ide@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240305235823.3308225-1-ipylypiv@google.com>
 <20240305235823.3308225-7-ipylypiv@google.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240305235823.3308225-7-ipylypiv@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-1.56 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-1.47)[91.44%];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[15];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,huawei.com:email,oracle.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -1.56

On 3/6/24 00:58, Igor Pylypiv wrote:
> The added sysfs attributes group enables the configuration of NCQ Priority
> feature for HBAs that rely on libsas to manage SATA devices.
> 
> Reviewed-by: John Garry <john.g.garry@oracle.com>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Jason Yan <yanaijie@huawei.com>
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> ---
>   drivers/scsi/aic94xx/aic94xx_init.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


