Return-Path: <linux-kernel+bounces-60791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB52885097A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 14:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FA551F24140
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 13:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE6D5B674;
	Sun, 11 Feb 2024 13:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vPN63kVJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hcmKvikc";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vPN63kVJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hcmKvikc"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6054E5B662;
	Sun, 11 Feb 2024 13:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707659553; cv=none; b=G1RBG24FHGecs/t8LU9aoiDJnu403Yljnrh2dgFcAEoNiNObmMdXkpF5vr10n3colWwOgXkAduWLuqk/sq46p0GaV804outHx4bGZd0GRoxpkSiRieUOPBShz7szDcQpM/qan+6/EGEV1UoQQ/6RvRB2INh6fouRpPbOkA+nYFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707659553; c=relaxed/simple;
	bh=3u84PDipm/FKSaO3drMxXyQk08ElyUGHkvbIrFVEmC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DBGJ2Vn82fed3ycEyoZ62WmLhEkWWP4iRoBns6W90b9IYY9n6wSJzAWPZ4bNfCa/opUOzWyr9qUymq1jiZpQ9eaK4lra+0ZBXP7HjgII4p+l+u7HLhTzNn0PZjaiQFrX04naKWAkTq51ut64A6n0rrVjM3nYEF1fndNZJ6I8XdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vPN63kVJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hcmKvikc; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vPN63kVJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hcmKvikc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 84DDE1FB78;
	Sun, 11 Feb 2024 13:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707659548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZX5IeVk4adw/eTsjQPq7HUUiE6LUdrpyGAHwKBkwmBI=;
	b=vPN63kVJByL8YMAovAYFegRn7OEibqG4r1WeD6fj80VScGQyJZq7hUETgJHsjgYYdh8mqc
	jaA9m6pj548gACmekAjNgIk7NNoBtNh7UVk/MNJlizFwZJynSrhTCxILe6cVABxAyDi3hg
	xHgHKNDJ3R3eehEKP50kCEl1oet0jLg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707659548;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZX5IeVk4adw/eTsjQPq7HUUiE6LUdrpyGAHwKBkwmBI=;
	b=hcmKvikcCfRxwiLdmFz2jRlLk/LkaU1LODE2Vc94+40Bm/uJ3JExeq/5N2SbUcefbh47XN
	5ISSH8qYtFumURBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707659548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZX5IeVk4adw/eTsjQPq7HUUiE6LUdrpyGAHwKBkwmBI=;
	b=vPN63kVJByL8YMAovAYFegRn7OEibqG4r1WeD6fj80VScGQyJZq7hUETgJHsjgYYdh8mqc
	jaA9m6pj548gACmekAjNgIk7NNoBtNh7UVk/MNJlizFwZJynSrhTCxILe6cVABxAyDi3hg
	xHgHKNDJ3R3eehEKP50kCEl1oet0jLg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707659548;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZX5IeVk4adw/eTsjQPq7HUUiE6LUdrpyGAHwKBkwmBI=;
	b=hcmKvikcCfRxwiLdmFz2jRlLk/LkaU1LODE2Vc94+40Bm/uJ3JExeq/5N2SbUcefbh47XN
	5ISSH8qYtFumURBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EBDA013A38;
	Sun, 11 Feb 2024 13:52:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kmzxNBvRyGUCeAAAD6G6ig
	(envelope-from <hare@suse.de>); Sun, 11 Feb 2024 13:52:27 +0000
Message-ID: <1e231871-0e49-446f-8a3b-d66e5cf6838b@suse.de>
Date: Sun, 11 Feb 2024 22:52:27 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] Revert "scsi: fcoe: Fix potential deadlock on
 &fip->ctlr_lock"
Content-Language: en-US
To: Lee Duncan <leeman.duncan@gmail.com>, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Chengfeng Ye <dg573847474@gmail.com>, Satish Kharat <satishkh@cisco.com>,
 Sesidhar Baddela <sebaddel@cisco.com>, Karan Tilak Kumar
 <kartilak@cisco.com>, Lee Duncan <lduncan@suse.com>
References: <cover.1707500786.git.lduncan@suse.com>
 <c578cdcd46b60470535c4c4a953e6a1feca0dffd.1707500786.git.lduncan@suse.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <c578cdcd46b60470535c4c4a953e6a1feca0dffd.1707500786.git.lduncan@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vPN63kVJ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=hcmKvikc
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.12 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.12)[66.75%];
	 MID_RHS_MATCH_FROM(0.00)[];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DWL_DNSWL_HI(-3.50)[suse.de:dkim];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[gmail.com,cisco.com,suse.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -5.12
X-Rspamd-Queue-Id: 84DDE1FB78
X-Spam-Flag: NO

On 2/10/24 02:07, Lee Duncan wrote:
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
> Fixes: 1a1975551943 ("scsi: fcoe: Fix potential deadlock on &fip->ctlr_lock")
> Signed-off-by: Lee Duncan <lduncan@suse.com>
> ---
>   drivers/scsi/fcoe/fcoe_ctlr.c | 20 ++++++++------------
>   1 file changed, 8 insertions(+), 12 deletions(-)
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


