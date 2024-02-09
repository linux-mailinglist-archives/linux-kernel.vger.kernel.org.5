Return-Path: <linux-kernel+bounces-59205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F198584F331
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 11:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6736A1F23411
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 10:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DBF69945;
	Fri,  9 Feb 2024 10:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pLJClPrp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MHPAbcgY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pLJClPrp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MHPAbcgY"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D03A67E6E;
	Fri,  9 Feb 2024 10:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707473956; cv=none; b=LDhcWE8ubMEj4cg0Z/3lRYhGbKAn/Sl8lgDkwoqhmnsRYSvFr2YKPvLyBZO8yBXlY3ROpDNJu97fj7sZU6xibHLXH1FM66Eii822enBJGsDGQ15s32jzD+i8Ws1PvrwpFczwRl9PL5gToz5wM3VbaiXgdnYN6O7KeZ4r+7XGShc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707473956; c=relaxed/simple;
	bh=xJCBHJeU9/djlGFXXT3GUZt8nlqpjwZiLm+sMcIoOFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DatfrgTr3S5dWEdyFOGYqQlq2jslG2iyjkizvbgFx+68rV4Oz7yTMl/mQkzgop1+KPHk8Vb6bYFwY0S7vFbVcfR4z9VmtWhH0v58XblX/kdLSTz+CzjLaiM+KDyKG3DWnr3J6WyH6wuyJVKSRIdcKsiA5KCVIcXJmmF7cN89fFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pLJClPrp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MHPAbcgY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pLJClPrp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MHPAbcgY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7179B1F7F9;
	Fri,  9 Feb 2024 10:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707473952; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mgMlkkPibxaPZ13lVHWwY0Y/CuH9ry83iFmx8OiVLbI=;
	b=pLJClPrp4w7cN0ueSQ00PHBW1vOi9ufRd4VAxU9oaKeNW/DiYQ1/MiA55/34tKa6lpZDM3
	UQC1fpVx6w8S3M+T1Udo7UNvZHL2uY+2ofhYOn+TkRmV8SXrXp0zW0UOFLO9oZlHoV7DML
	wCLBRHPQinFKmGhPTTKcrJFYJfIdBwg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707473952;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mgMlkkPibxaPZ13lVHWwY0Y/CuH9ry83iFmx8OiVLbI=;
	b=MHPAbcgYa6+sCc1gmhtWpBKTfk42/AafAKvUjIfZdMJimDuJoB2E0dBR2RStyaU1Gi6JUc
	tEvsWt6PnMS8+dCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707473952; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mgMlkkPibxaPZ13lVHWwY0Y/CuH9ry83iFmx8OiVLbI=;
	b=pLJClPrp4w7cN0ueSQ00PHBW1vOi9ufRd4VAxU9oaKeNW/DiYQ1/MiA55/34tKa6lpZDM3
	UQC1fpVx6w8S3M+T1Udo7UNvZHL2uY+2ofhYOn+TkRmV8SXrXp0zW0UOFLO9oZlHoV7DML
	wCLBRHPQinFKmGhPTTKcrJFYJfIdBwg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707473952;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mgMlkkPibxaPZ13lVHWwY0Y/CuH9ry83iFmx8OiVLbI=;
	b=MHPAbcgYa6+sCc1gmhtWpBKTfk42/AafAKvUjIfZdMJimDuJoB2E0dBR2RStyaU1Gi6JUc
	tEvsWt6PnMS8+dCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 20D681326D;
	Fri,  9 Feb 2024 10:19:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /5xPBiD8xWXjIQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 09 Feb 2024 10:19:12 +0000
Message-ID: <9292aeda-b529-46cc-81e4-42b4f3051fca@suse.de>
Date: Fri, 9 Feb 2024 11:19:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] Revert "scsi: fcoe: Fix potential deadlock on
 &fip->ctlr_lock"
To: Lee Duncan <leeman.duncan@gmail.com>, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Chengfeng Ye <dg573847474@gmail.com>, Satish Kharat <satishkh@cisco.com>,
 Sesidhar Baddela <sebaddel@cisco.com>, Karan Tilak Kumar
 <kartilak@cisco.com>, Lee Duncan <lduncan@suse.com>
References: <cover.1707343839.git.lduncan@suse.com>
 <c578cdcd46b60470535c4c4a953e6a1feca0dffd.1707343839.git.lduncan@suse.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <c578cdcd46b60470535c4c4a953e6a1feca0dffd.1707343839.git.lduncan@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.30
X-Spamd-Result: default: False [-1.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 BAYES_HAM(-0.01)[49.08%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.de:email];
	 FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[gmail.com,cisco.com,suse.com];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Flag: NO

On 2/7/24 23:20, Lee Duncan wrote:
> From: Lee Duncan <lduncan@suse.com>
> 
> This reverts commit 1a1975551943f681772720f639ff42fbaa746212
> 
> This commit causes interrupts to be lost for FCoE devices,
> since it changed sping locks from "bh" to "irqsave".
> 
> Instead, a work queue should be used, and will be addressed
> in a separate patch.
> 
> Fixes: 1a1975551943f681772720f639ff42fbaa746212
Please use the correct fixes tag:

Fixes: 1a1975551943 ("scsi: fcoe: Fix potential deadlock on 
&fip->ctlr_lock")

Otherwise looks good.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich


