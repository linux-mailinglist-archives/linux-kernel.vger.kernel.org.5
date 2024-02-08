Return-Path: <linux-kernel+bounces-57856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DEA384DE40
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B28D11C2722B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678F46EB70;
	Thu,  8 Feb 2024 10:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YmAP94Zg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vYGXMgZZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YmAP94Zg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vYGXMgZZ"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1CA6DCFE;
	Thu,  8 Feb 2024 10:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707387975; cv=none; b=uaJ/aMZfkN2MXXro3y/G7E61c3ldhm8fWABiSJwzMhMVqYNrntOihWnk16DGNkx6XH9SL/SCg+5oM4woO60XpO0irPAoAovwvo9aHKh9oRo6cDoqVc8J/bqhceWeRn/hBthQS4uFjcKtqIks/Mb44iCNNu+/mUerGiCeGNrGu2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707387975; c=relaxed/simple;
	bh=k9/QmS/ylPFheQDtEbsOTzpU8sUoCUqGH8YOPR3OWvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Alx3FOXTgOd49h/X/SRj1vAKK71tIVpVx0PBslIJjenxrEOCxUm3xWYoxZeai5dmCJw0T5b+ArLBi3iYtUQJ2D5nSBGUY3BmcfjJTVz4islFA3iq/BpoqoB0SOJN2rIe/LoEx64J1OM9RZnLFfeYiVaaAIcT176OnR+M6XotZGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YmAP94Zg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vYGXMgZZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YmAP94Zg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vYGXMgZZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 954A61FCDA;
	Thu,  8 Feb 2024 10:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707387971; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LZzZ9jLIvRqAb77M6zja7IcHKFPoI8mCipcHtHdDUmA=;
	b=YmAP94ZgNzOuL5wWhPGJjHIoTA5de5g9eIboAI6viu6kay5cQIrnpFCMYWS477J9yLHw6d
	BDyKEoAHN0mYGCKVf/3dMmEWkqdzpJ3xFqPq4O0GaSNfUxXG+VdqdXmOQkNG1cVhC4SIj6
	We5ewc/jBMQoqwm9g7EwW8v9K7wcfC4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707387971;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LZzZ9jLIvRqAb77M6zja7IcHKFPoI8mCipcHtHdDUmA=;
	b=vYGXMgZZsMsfnFTr49UoTz5Wo9gJf4Dwj2yDMi/jn5rX1zpgkMsSr7tzPOFzICvWvhwxBO
	lwW5Bj3AkcozGsBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707387971; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LZzZ9jLIvRqAb77M6zja7IcHKFPoI8mCipcHtHdDUmA=;
	b=YmAP94ZgNzOuL5wWhPGJjHIoTA5de5g9eIboAI6viu6kay5cQIrnpFCMYWS477J9yLHw6d
	BDyKEoAHN0mYGCKVf/3dMmEWkqdzpJ3xFqPq4O0GaSNfUxXG+VdqdXmOQkNG1cVhC4SIj6
	We5ewc/jBMQoqwm9g7EwW8v9K7wcfC4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707387971;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LZzZ9jLIvRqAb77M6zja7IcHKFPoI8mCipcHtHdDUmA=;
	b=vYGXMgZZsMsfnFTr49UoTz5Wo9gJf4Dwj2yDMi/jn5rX1zpgkMsSr7tzPOFzICvWvhwxBO
	lwW5Bj3AkcozGsBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B84621326D;
	Thu,  8 Feb 2024 10:26:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BDLUKUKsxGUJKAAAD6G6ig
	(envelope-from <dkirjanov@suse.de>); Thu, 08 Feb 2024 10:26:10 +0000
Message-ID: <0e129417-53c8-4931-af76-a37762472fb0@suse.de>
Date: Thu, 8 Feb 2024 13:26:05 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] net: make driver settling time configurable
Content-Language: en-US
To: David Ventura <david@davidv.dev>
Cc: Jonathan Corbet <corbet@lwn.net>, "David S. Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Randy Dunlap
 <rdunlap@infradead.org>, Xiongwei Song <xiongwei.song@windriver.com>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:NETWORKING [IPv4/IPv6]" <netdev@vger.kernel.org>
References: <20240208093722.246930-1-david@davidv.dev>
 <20240208095358.251381-1-david@davidv.dev>
From: Denis Kirjanov <dkirjanov@suse.de>
In-Reply-To: <20240208095358.251381-1-david@davidv.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=YmAP94Zg;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=vYGXMgZZ
X-Spamd-Result: default: False [-0.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[davidv.dev:email,suse.de:dkim];
	 TO_DN_ALL(0.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -0.30
X-Rspamd-Queue-Id: 954A61FCDA
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /



On 2/8/24 12:52, David Ventura wrote:
> During IP auto configuration, some drivers apparently need to wait a
> certain length of time to settle; as this is not true for all drivers,
> make this length of time configurable.
> 
> Signed-off-by: David Ventura <david@davidv.dev>
> ---
>  .../admin-guide/kernel-parameters.txt         |  4 ++++
>  Documentation/admin-guide/nfs/nfsroot.rst     |  3 +++
>  net/ipv4/ipconfig.c                           | 23 ++++++++++++++++---
>  3 files changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index b47940577c10..b07a035642fa 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2291,6 +2291,10 @@
>  
>  	ip=		[IP_PNP]
>  			See Documentation/admin-guide/nfs/nfsroot.rst.
> +	ip.dev_wait_ms=
> +			[IP_PNP]
> +			See Documentation/admin-guide/nfs/nfsroot.rst.
> +
>  
>  	ipcmni_extend	[KNL,EARLY] Extend the maximum number of unique System V
>  			IPC identifiers from 32,768 to 16,777,216.
> diff --git a/Documentation/admin-guide/nfs/nfsroot.rst b/Documentation/admin-guide/nfs/nfsroot.rst
> index 135218f33394..f26f7a342af6 100644
> --- a/Documentation/admin-guide/nfs/nfsroot.rst
> +++ b/Documentation/admin-guide/nfs/nfsroot.rst
> @@ -223,6 +223,9 @@ ip=<client-ip>:<server-ip>:<gw-ip>:<netmask>:<hostname>:<device>:<autoconf>:<dns
>    /proc/net/ipconfig/ntp_servers to an NTP client before mounting the real
>    root filesystem if it is on NFS).
>  
> +ip.dev_wait_ms=<value>
> +  Set the number of milliseconds to delay after opening the network device
> +  which will be autoconfigured. Defaults to 10 milliseconds.
>  
>  nfsrootdebug
>    This parameter enables debugging messages to appear in the kernel
> diff --git a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
> index c56b6fe6f0d7..cbf35163b973 100644
> --- a/net/ipv4/ipconfig.c
> +++ b/net/ipv4/ipconfig.c
> @@ -82,8 +82,6 @@
>  #define IPCONFIG_DYNAMIC
>  #endif
>  
> -/* Define the friendly delay before and after opening net devices */
> -#define CONF_POST_OPEN		10	/* After opening: 10 msecs */
>  
>  /* Define the timeout for waiting for a DHCP/BOOTP/RARP reply */
>  #define CONF_OPEN_RETRIES 	2	/* (Re)open devices twice */
> @@ -101,6 +99,7 @@
>  
>  /* Wait for carrier timeout default in seconds */
>  static unsigned int carrier_timeout = 120;
> +static unsigned int dev_wait_ms = 10;
>  
>  /*
>   * Public IP configuration
> @@ -1516,7 +1515,8 @@ static int __init ip_auto_config(void)
>  		return err;
>  
>  	/* Give drivers a chance to settle */
> -	msleep(CONF_POST_OPEN);
> +	if(dev_wait_ms > 0)
> +		msleep(dev_wait_ms);

What's the point to wait more than CONF_POST_OPEN with the change?

>  
>  	/*
>  	 * If the config information is insufficient (e.g., our IP address or
> @@ -1849,3 +1849,20 @@ static int __init set_carrier_timeout(char *str)
>  	return 1;
>  }
>  __setup("carrier_timeout=", set_carrier_timeout);
> +
> +
> +static int __init set_dev_wait_ms(char *str)
> +{
> +	ssize_t ret;
> +
> +	if (!str)
> +		return 0;
> +
> +	ret = kstrtouint(str, 0, &dev_wait_ms);
> +	if (ret)
> +		return 0;
> +
> +	return 1;
> +}
> +
> +__setup("ip.dev_wait_ms=", set_dev_wait_ms);

