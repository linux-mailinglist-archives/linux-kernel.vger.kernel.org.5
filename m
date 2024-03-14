Return-Path: <linux-kernel+bounces-103080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9AD87BACA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6743B1F236F4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1636D1BB;
	Thu, 14 Mar 2024 09:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="18pT8Y6p";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zPZuaCVY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="18pT8Y6p";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zPZuaCVY"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D716CDD7;
	Thu, 14 Mar 2024 09:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710410068; cv=none; b=SUK2u3+Dar+o7eGWnNOyoF4VJXvDgB07GGdbvRBJWQirsKUgeQnFHE7NDPxmKXvQe8RlI/RlBuURz1utTd3ORYPCWOaQGcZiCjLdiunJYoyc9L/K6PZi3/oSeabTYKTZm9i4+A/LFaWlG04guSQxn7UJeo+KEzcDZmjNvJhLsSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710410068; c=relaxed/simple;
	bh=SEFuptdzMKtuxipMRpSUXMpbMNYnhlcKDHORqyWDp9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pAu7YmQZIzm1Zy2kAbXFR414ratKpPptF3pYhn67vjGuDJIGYL6BHotltYPH0i+VK+PMXmXbvUYtY+yUJgTik1q9kXl0epeUp0XHw1y+OKgm6dehqjtCvSzdhABDMPmWnlpG54zuRFWcnvve3nRGVQBcSPYmCHwrWSBbj/eJTfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=18pT8Y6p; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zPZuaCVY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=18pT8Y6p; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zPZuaCVY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4A34C1F842;
	Thu, 14 Mar 2024 09:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710410063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3xFvxCVNzRZwt8Rr7SRuookoZf9qzc0Nvz78vAIQ+g8=;
	b=18pT8Y6p/4ZFKF2NJHyfNXb/dpZtMNMezeZrxJ+SvIG9fPqy64JXIQydl/C9gM3w59e57A
	5VDY5F8bHAIP5cywoqBhd9i2FUJjhVSMxpPoOhka+FTLGobBTtLhmgpn4KNUgjPQCQMus1
	UtOIHVKfY2NA0Eho6gUu9pC/weOZgNY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710410063;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3xFvxCVNzRZwt8Rr7SRuookoZf9qzc0Nvz78vAIQ+g8=;
	b=zPZuaCVYrdz1QVYTFru79FTkayolDL+7iIdivm5BX3SPdbb1lfxPWWbFfCwc7lWJYkyM80
	r+nADRzq+stKo0CA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710410063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3xFvxCVNzRZwt8Rr7SRuookoZf9qzc0Nvz78vAIQ+g8=;
	b=18pT8Y6p/4ZFKF2NJHyfNXb/dpZtMNMezeZrxJ+SvIG9fPqy64JXIQydl/C9gM3w59e57A
	5VDY5F8bHAIP5cywoqBhd9i2FUJjhVSMxpPoOhka+FTLGobBTtLhmgpn4KNUgjPQCQMus1
	UtOIHVKfY2NA0Eho6gUu9pC/weOZgNY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710410063;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3xFvxCVNzRZwt8Rr7SRuookoZf9qzc0Nvz78vAIQ+g8=;
	b=zPZuaCVYrdz1QVYTFru79FTkayolDL+7iIdivm5BX3SPdbb1lfxPWWbFfCwc7lWJYkyM80
	r+nADRzq+stKo0CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DA9721386D;
	Thu, 14 Mar 2024 09:54:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ThjxMU7J8mX2QgAAD6G6ig
	(envelope-from <dkirjanov@suse.de>); Thu, 14 Mar 2024 09:54:22 +0000
Message-ID: <8cf6fdc9-caa9-43dc-b392-575b4e596dfa@suse.de>
Date: Thu, 14 Mar 2024 12:54:22 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] atm: Convert sprintf/snprintf to sysfs_emit
Content-Language: en-US
To: Li Zhijian <lizhijian@fujitsu.com>, linux-kernel@vger.kernel.org
Cc: Chas Williams <3chas3@gmail.com>,
 linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org
References: <20240314084417.1321811-1-lizhijian@fujitsu.com>
From: Denis Kirjanov <dkirjanov@suse.de>
In-Reply-To: <20240314084417.1321811-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.09 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 BAYES_HAM(-3.00)[100.00%];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[fujitsu.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[gmail.com,lists.sourceforge.net,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -3.09
X-Spam-Flag: NO



On 3/14/24 11:44, Li Zhijian wrote:
> Per filesystems/sysfs.rst, show() should only use sysfs_emit()
> or sysfs_emit_at() when formatting the value to be returned to user space.
> 
> coccinelle complains that there are still a couple of functions that use
> snprintf(). Convert them to sysfs_emit().
> 
> sprintf() will be converted as weel if they have.
> 
> Generally, this patch is generated by
> make coccicheck M=<path/to/file> MODE=patch \
> COCCI=scripts/coccinelle/api/device_attr_show.cocci
> 
> No functional change intended

The patch should be targeted to net-next which is closed now.

> 
> CC: Chas Williams <3chas3@gmail.com>
> CC: linux-atm-general@lists.sourceforge.net
> CC: netdev@vger.kernel.org
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
> This is a part of the work "Fix coccicheck device_attr_show warnings"[1]
> Split them per subsystem so that the maintainer can review it easily
> [1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
> ---
>  drivers/atm/solos-pci.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/atm/solos-pci.c b/drivers/atm/solos-pci.c
> index d3c30a28c410..369a7f414f05 100644
> --- a/drivers/atm/solos-pci.c
> +++ b/drivers/atm/solos-pci.c
> @@ -198,8 +198,8 @@ static ssize_t solos_param_show(struct device *dev, struct device_attribute *att
>  
>  	header = skb_put(skb, sizeof(*header));
>  
> -	buflen = snprintf((void *)&header[1], buflen - 1,
> -			  "L%05d\n%s\n", current->pid, attr->attr.name);
> +	buflen = sysfs_emit((void *)&header[1], "L%05d\n%s\n", current->pid,
> +			    attr->attr.name);
>  	skb_put(skb, buflen);
>  
>  	header->size = cpu_to_le16(buflen);
> @@ -453,7 +453,7 @@ static ssize_t console_show(struct device *dev, struct device_attribute *attr,
>  	skb = skb_dequeue(&card->cli_queue[SOLOS_CHAN(atmdev)]);
>  	spin_unlock_bh(&card->cli_queue_lock);
>  	if(skb == NULL)
> -		return sprintf(buf, "No data.\n");
> +		return sysfs_emit(buf, "No data.\n");
>  
>  	len = skb->len;
>  	memcpy(buf, skb->data, len);
> @@ -548,7 +548,7 @@ static ssize_t geos_gpio_show(struct device *dev, struct device_attribute *attr,
>  	data32 = ioread32(card->config_regs + GPIO_STATUS);
>  	data32 = (data32 >> gattr->offset) & 1;
>  
> -	return sprintf(buf, "%d\n", data32);
> +	return sysfs_emit(buf, "%d\n", data32);
>  }
>  
>  static ssize_t hardware_show(struct device *dev, struct device_attribute *attr,
> @@ -569,7 +569,7 @@ static ssize_t hardware_show(struct device *dev, struct device_attribute *attr,
>  		data32 = (data32 >> 5) & 0x0F;
>  		break;
>  	}
> -	return sprintf(buf, "%d\n", data32);
> +	return sysfs_emit(buf, "%d\n", data32);
>  }
>  
>  static DEVICE_ATTR_RW(console);

