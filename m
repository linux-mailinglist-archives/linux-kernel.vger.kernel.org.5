Return-Path: <linux-kernel+bounces-28698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8CD830200
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CCDF1F26ABC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B8714014;
	Wed, 17 Jan 2024 09:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jlnEhCsX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Fm6eiwHL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jlnEhCsX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Fm6eiwHL"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CFF13FFF;
	Wed, 17 Jan 2024 09:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705482999; cv=none; b=IwLRc26yNec1qNk4xzTJ59PrVr0s6gW7I1o5zs/RkZc7n/ym4AxqPB8Luxn/umXoP5yQw2XDqkxiyMriTIBLG58V/au9s27RAY/+Ss0ulTOTyzhemaXfa5iHD2qp9xhAGsST9av0L56LIvZcyV8KpFmVkB0swyS5i+ntfpsL3lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705482999; c=relaxed/simple;
	bh=B33er8isrLTvS1m1cu3yKxMIyyaevuLSl3jEk4pc70s=;
	h=Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:Content-Language:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spam-Level:
	 X-Rspamd-Server:X-Spamd-Result:X-Spam-Score:X-Rspamd-Queue-Id:
	 X-Spam-Flag; b=OGkEoMzEOYIkMRnoRcIMleHdHS6IfqxXuXAYYhtExqlam/3hdvvCZGx6ggNQIMjtUKXWgye3LU1SBl2feRoBt55xb9rdHAUPkMD/ffrm8xsgkY7bp5EFM0tGUYej7qk9f4UBhfrWImnXJ9w0LSmjc2P/HhHANCBj70mGzWYhfx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jlnEhCsX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Fm6eiwHL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jlnEhCsX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Fm6eiwHL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3EDF321FD4;
	Wed, 17 Jan 2024 09:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705482996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mr/YPDCmjf2NmVE+gDoAP4p1NqIubYKY2s9ciMw0nxY=;
	b=jlnEhCsX9p4c/NZ1ucdIlutg7ANOSI+zT/DXF5He94MzT1PfBgSVk8ax+qLE3YkNUmYBCI
	AQ7r+Us711b5JsP9m3UkgP3brrJjuERNgees8C7Yrj6GvymEtDg/g4Ie/uXNcijDKU5oFn
	VyhC2BisTmVCHLmQdodGzsyMh7DZ4N8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705482996;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mr/YPDCmjf2NmVE+gDoAP4p1NqIubYKY2s9ciMw0nxY=;
	b=Fm6eiwHLiUFH/NmEPnpKlGR8/eH0VrJKncbzjP7WzfquX6LF91tqkP98n7afgZRaXfCnMW
	uQLkHCIWVpAhd0Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705482996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mr/YPDCmjf2NmVE+gDoAP4p1NqIubYKY2s9ciMw0nxY=;
	b=jlnEhCsX9p4c/NZ1ucdIlutg7ANOSI+zT/DXF5He94MzT1PfBgSVk8ax+qLE3YkNUmYBCI
	AQ7r+Us711b5JsP9m3UkgP3brrJjuERNgees8C7Yrj6GvymEtDg/g4Ie/uXNcijDKU5oFn
	VyhC2BisTmVCHLmQdodGzsyMh7DZ4N8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705482996;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mr/YPDCmjf2NmVE+gDoAP4p1NqIubYKY2s9ciMw0nxY=;
	b=Fm6eiwHLiUFH/NmEPnpKlGR8/eH0VrJKncbzjP7WzfquX6LF91tqkP98n7afgZRaXfCnMW
	uQLkHCIWVpAhd0Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5DDE7137EB;
	Wed, 17 Jan 2024 09:16:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kr+kE/Oap2UwFwAAD6G6ig
	(envelope-from <dkirjanov@suse.de>); Wed, 17 Jan 2024 09:16:35 +0000
Message-ID: <305989ef-6a26-4a91-bbac-d2433ebb04f4@suse.de>
Date: Wed, 17 Jan 2024 12:16:34 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipvs: Simplify the allocation of ip_vs_conn slab
 caches
Content-Language: en-US
To: Kunwu Chan <chentao@kylinos.cn>, horms@verge.net.au, ja@ssi.bg,
 pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, lvs-devel@vger.kernel.org,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 linux-kernel@vger.kernel.org
References: <20240117072045.142215-1-chentao@kylinos.cn>
From: Denis Kirjanov <dkirjanov@suse.de>
In-Reply-To: <20240117072045.142215-1-chentao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=jlnEhCsX;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Fm6eiwHL
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.98 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-2.98)[99.89%];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[15];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -5.98
X-Rspamd-Queue-Id: 3EDF321FD4
X-Spam-Flag: NO



On 1/17/24 10:20, Kunwu Chan wrote:
> Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
> to simplify the creation of SLAB caches.
> 
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>

The patch is actually for net-next 

> ---
>  net/netfilter/ipvs/ip_vs_conn.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/net/netfilter/ipvs/ip_vs_conn.c b/net/netfilter/ipvs/ip_vs_conn.c
> index a743db073887..98d7dbe3d787 100644
> --- a/net/netfilter/ipvs/ip_vs_conn.c
> +++ b/net/netfilter/ipvs/ip_vs_conn.c
> @@ -1511,9 +1511,7 @@ int __init ip_vs_conn_init(void)
>  		return -ENOMEM;
>  
>  	/* Allocate ip_vs_conn slab cache */
> -	ip_vs_conn_cachep = kmem_cache_create("ip_vs_conn",
> -					      sizeof(struct ip_vs_conn), 0,
> -					      SLAB_HWCACHE_ALIGN, NULL);
> +	ip_vs_conn_cachep = KMEM_CACHE(ip_vs_conn, SLAB_HWCACHE_ALIGN);
>  	if (!ip_vs_conn_cachep) {
>  		kvfree(ip_vs_conn_tab);
>  		return -ENOMEM;

