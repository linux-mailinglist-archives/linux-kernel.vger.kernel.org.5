Return-Path: <linux-kernel+bounces-19521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FD1826E3F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 468321C2258D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E75C4C3A9;
	Mon,  8 Jan 2024 12:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="W9564FuO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aCa/Vwit";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Hlit9hJE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IVE0QRmk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AF84C3AE;
	Mon,  8 Jan 2024 12:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DF48F1F79A;
	Mon,  8 Jan 2024 12:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704717082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1twQEx1dg6gbGHsQjEqD5/fYFL160JMeqSwzbn1AABE=;
	b=W9564FuOADlN9CzkUXh+78NK/0JIGnrLeDYn9LpKm8qegzKfQ4E+zouIlOFCa3Hq2e8T6g
	eM+7qSFQabL+1W3gB6un6JVNV4hxTYDOth+yXim6DqSLQB7xk4kdpaLDaHWH907N6AYIdD
	FmIJzJiL3L4Uu5h0lqi18hYykKfge2g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704717082;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1twQEx1dg6gbGHsQjEqD5/fYFL160JMeqSwzbn1AABE=;
	b=aCa/VwitMHQT/anjckx/chIBXE7199MsE6Ne28UHUoLc8t5dZq7bYwfVmJte+UV9vTB0L2
	pHsvL7i5PEMlnODg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704717080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1twQEx1dg6gbGHsQjEqD5/fYFL160JMeqSwzbn1AABE=;
	b=Hlit9hJE2ByVmL0dvuTY81X8IH8j1Ko7EZG+etguDMBmzkfzTMXarCx7fnidM1mbJfyfNC
	IcG4hBEA1JLOGTPxaQJWRRWoAuQiqEiCs+EUhdZjw8uiU0Gls2iSHXaLpacV+LF19iWP8E
	oRfUBEwa++h8c5IV6EO6Btt5ck6jWr8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704717080;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1twQEx1dg6gbGHsQjEqD5/fYFL160JMeqSwzbn1AABE=;
	b=IVE0QRmkdA/TKhPdnYQmM5LAmwldU+M1i7AtdktXJie2+JOOnUVpikhw5lZj6DHBx5bXGI
	o4rRASmLOrmqbtDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B55A41392C;
	Mon,  8 Jan 2024 12:31:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SuOzKxjrm2V8YQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 08 Jan 2024 12:31:20 +0000
Message-ID: <565e1f78-b46d-4b22-8f9a-5a4bc7d23424@suse.de>
Date: Mon, 8 Jan 2024 13:31:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: fcoe: Fix unsigned comparison with zero in
 store_ctlr_mode()
Content-Language: en-US
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Justin Stitt <justinstitt@google.com>, Kees Cook <keescook@chromium.org>,
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
 error27@gmail.com
References: <20240102085245.600570-1-harshit.m.mogalapalli@oracle.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240102085245.600570-1-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Hlit9hJE;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=IVE0QRmk
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.50 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_MATCH_FROM(0.00)[];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,oracle.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[linaro.org,vger.kernel.org,gmail.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -3.50
X-Rspamd-Queue-Id: DF48F1F79A
X-Spam-Flag: NO

On 1/2/24 09:52, Harshit Mogalapalli wrote:
> ctlr->mode is of unsigned type, it is never less than zero.
> 
> Fix this by using an extra varibale called 'res', to store return value
> from sysfs_match_string() and assign that to ctlr->mode on the success
> path.
> 
> Fixes: edc22a7c8688 ("scsi: fcoe: Use sysfs_match_string() over fcoe_parse_mode()")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
> This is based on static analysis with smatch and only compile tested.
> ---
>   drivers/scsi/fcoe/fcoe_sysfs.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/fcoe/fcoe_sysfs.c b/drivers/scsi/fcoe/fcoe_sysfs.c
> index 408a806bf4c2..c64a085a7ee2 100644
> --- a/drivers/scsi/fcoe/fcoe_sysfs.c
> +++ b/drivers/scsi/fcoe/fcoe_sysfs.c
> @@ -263,6 +263,7 @@ static ssize_t store_ctlr_mode(struct device *dev,
>   			       const char *buf, size_t count)
>   {
>   	struct fcoe_ctlr_device *ctlr = dev_to_ctlr(dev);
> +	int res;
>   
>   	if (count > FCOE_MAX_MODENAME_LEN)
>   		return -EINVAL;
> @@ -279,12 +280,13 @@ static ssize_t store_ctlr_mode(struct device *dev,
>   			return -ENOTSUPP;
>   		}
>   
> -		ctlr->mode = sysfs_match_string(fip_conn_type_names, buf);
> -		if (ctlr->mode < 0 || ctlr->mode == FIP_CONN_TYPE_UNKNOWN) {
> +		res = sysfs_match_string(fip_conn_type_names, buf);
> +		if (res < 0 || res == FIP_CONN_TYPE_UNKNOWN) {
>   			LIBFCOE_SYSFS_DBG(ctlr, "Unknown mode %s provided.\n",
>   					  buf);
>   			return -EINVAL;
>   		}
> +		ctlr->mode = res;
>   
>   		ctlr->f->set_fcoe_ctlr_mode(ctlr);
>   		LIBFCOE_SYSFS_DBG(ctlr, "Mode changed to %s.\n", buf);
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes


