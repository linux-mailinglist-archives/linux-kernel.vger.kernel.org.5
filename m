Return-Path: <linux-kernel+bounces-157033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DD68B0BD9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E84961F27EEA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF07E15E1F3;
	Wed, 24 Apr 2024 14:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ucJrqPYa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vf3VgEpT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ucJrqPYa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vf3VgEpT"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFE615D5A9;
	Wed, 24 Apr 2024 14:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713967358; cv=none; b=l6kWQJ/LEecDtnHnWQExgGFF+Y5WgBYOjB1e43yt2EX5Dr64XQdftyoAZCL0Gm7E9q6Em/O0xYEOZ16PNMzjbGowBjCR+Z/uhfz9NyOoLoQlDievKGT3zuqFvp3DZKR4Vc1bPsboPz0gHH8j+I40sT8p3ac1ceOaYhkMeR51i/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713967358; c=relaxed/simple;
	bh=ENlsWe5ff/JaMcQ/2YyeIfR2tu5TLKoJMJ/beA5l5p0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m+Wn5lJGY9pY8itI2536TK9OBPogJPZCmihjUL4fLvPC9WYdZn7gYBMbP95HvXfMTC0zWWmKcELNL068VIhG30oHU8fSlgpwR8ukb2IZGZwBuF3do4jhRMJNEIO/HtLe7pliXzppRMqciJhIn53HEhv9C5imAsFPgP/7j7REKIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ucJrqPYa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vf3VgEpT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ucJrqPYa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vf3VgEpT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 017C866E8C;
	Wed, 24 Apr 2024 14:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713967352; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E0YCHDcnSdKOojGsBbPJs+pSiRBVZZMM13LMM3KT/zE=;
	b=ucJrqPYaiXD28d0B9V2hjVLgvopJ6xF/jBkRxL/DzCZMV2KIXbXoYxyhTuPbNAca4Znt16
	YZ2m9Tb6SsjE69heR3LVmUSj1RBThr2jGUDVIcJZJRaS9CfnFJFqg03KQntYpHKlC5+sE8
	g0ZeddQnKXxFraILmy3BuA080Oi8J18=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713967352;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E0YCHDcnSdKOojGsBbPJs+pSiRBVZZMM13LMM3KT/zE=;
	b=vf3VgEpTfM8cXTJcYMpeIyoqh7leAW63adQLK8r0B05QYOL6BjNbYTINckHsAoS8NgRBlY
	AsadS2IfyfEocuCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713967352; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E0YCHDcnSdKOojGsBbPJs+pSiRBVZZMM13LMM3KT/zE=;
	b=ucJrqPYaiXD28d0B9V2hjVLgvopJ6xF/jBkRxL/DzCZMV2KIXbXoYxyhTuPbNAca4Znt16
	YZ2m9Tb6SsjE69heR3LVmUSj1RBThr2jGUDVIcJZJRaS9CfnFJFqg03KQntYpHKlC5+sE8
	g0ZeddQnKXxFraILmy3BuA080Oi8J18=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713967352;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E0YCHDcnSdKOojGsBbPJs+pSiRBVZZMM13LMM3KT/zE=;
	b=vf3VgEpTfM8cXTJcYMpeIyoqh7leAW63adQLK8r0B05QYOL6BjNbYTINckHsAoS8NgRBlY
	AsadS2IfyfEocuCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CFC4A1393C;
	Wed, 24 Apr 2024 14:02:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ckDMMfcQKWayDQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 24 Apr 2024 14:02:31 +0000
Date: Wed, 24 Apr 2024 16:02:37 +0200
Message-ID: <87cyqedfk2.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Manish Mandlik <mmandlik@google.com>,
	Archie Pusaka <apusaka@chromium.org>,
	Miao-chen Chou <mcchou@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	Chun-Yi Lee <jlee@suse.com>
Subject: Re: [PATCH] Bluetooth: hci_sync: Using hci_cmd_sync_submit when removing Adv Monitor
In-Reply-To: <20240424135903.24169-1-jlee@suse.com>
References: <20240424135903.24169-1-jlee@suse.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -1.60
X-Spam-Level: 
X-Spamd-Result: default: False [-1.60 / 50.00];
	BAYES_HAM(-2.80)[99.12%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,suse.com:email,chromium.org:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

On Wed, 24 Apr 2024 15:59:03 +0200,
Lee, Chun-Yi wrote:
> 
> From: Chun-Yi Lee <jlee@suse.com>
> 
> Since the d883a4669a1de be introduced in v6.4, bluetooth daemon
> got the following failed message of MGMT_OP_REMOVE_ADV_MONITOR
> command when controller is power-off:
> 
> bluetoothd[20976]:
> src/adapter.c:reset_adv_monitors_complete() Failed to reset Adv
> Monitors: Failed>
> 
> Normally this situation is happened when the bluetoothd deamon
> be started manually after system booting. Which means that
> bluetoothd received MGMT_EV_INDEX_ADDED event after kernel
> runs hci_power_off().
> 
> Base on doc/mgmt-api.txt, the MGMT_OP_REMOVE_ADV_MONITOR command
> can be used when the controller is not powered. This patch changes
> the code in remove_adv_monitor() to use hci_cmd_sync_submit()
> instead of hci_cmd_sync_queue().
> 
> Fixes: d883a4669a1de ("Bluetooth: hci_sync: Only allow hci_cmd_sync_queue if running")
> Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> Cc: Manish Mandlik <mmandlik@google.com>
> Cc: Archie Pusaka <apusaka@chromium.org>
> Cc: Miao-chen Chou <mcchou@chromium.org>
> Signed-off-by: Chun-Yi Lee <jlee@suse.com>

Is it a same issue tracked in
  https://github.com/bluez/bluez/issues/809
??


thanks,

Takashi

> ---
>  net/bluetooth/mgmt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 32ed6e9245a3..21962969411d 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -5475,7 +5475,7 @@ static int remove_adv_monitor(struct sock *sk, struct hci_dev *hdev,
>  		goto unlock;
>  	}
>  
> -	err = hci_cmd_sync_queue(hdev, mgmt_remove_adv_monitor_sync, cmd,
> +	err = hci_cmd_sync_submit(hdev, mgmt_remove_adv_monitor_sync, cmd,
>  				 mgmt_remove_adv_monitor_complete);
>  
>  	if (err) {
> -- 
> 2.35.3
> 
> 

