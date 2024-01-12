Return-Path: <linux-kernel+bounces-24439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0856482BC8B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 09:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5629B2870AA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 08:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C655A54FB4;
	Fri, 12 Jan 2024 08:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hlVwruvH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jrx+ewXj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hlVwruvH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jrx+ewXj"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3E854BC8;
	Fri, 12 Jan 2024 08:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 551CA1FC0D;
	Fri, 12 Jan 2024 08:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705049784; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LkFGgBjC8CczIMntbkU12Hx1gXyfHUmfQ8gaFQ0MS70=;
	b=hlVwruvHF2eeUcJIqClHm4wu0Sr7OPH/Jl4rhDlQXXVvpYN0RhZOaHEAN8PduqmbSIUGR5
	whUjmhBbeXI0Bvo8nlzIRVWeJgTvZl4M6Xu1nRf2Y6kgDoe3q8P3TTC+beDYCB6yY4Uz98
	6qzf9DnnL33uoTMHCsHtyYqmV7e2i4o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705049784;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LkFGgBjC8CczIMntbkU12Hx1gXyfHUmfQ8gaFQ0MS70=;
	b=jrx+ewXjCJjxbL6cuRz+bpCe0N52FpY0X3jXRyL1rA1U2JdZoh11Ziq6KPeqzpLNC6XFBB
	o4iR0OmFpKhIXpDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705049784; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LkFGgBjC8CczIMntbkU12Hx1gXyfHUmfQ8gaFQ0MS70=;
	b=hlVwruvHF2eeUcJIqClHm4wu0Sr7OPH/Jl4rhDlQXXVvpYN0RhZOaHEAN8PduqmbSIUGR5
	whUjmhBbeXI0Bvo8nlzIRVWeJgTvZl4M6Xu1nRf2Y6kgDoe3q8P3TTC+beDYCB6yY4Uz98
	6qzf9DnnL33uoTMHCsHtyYqmV7e2i4o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705049784;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LkFGgBjC8CczIMntbkU12Hx1gXyfHUmfQ8gaFQ0MS70=;
	b=jrx+ewXjCJjxbL6cuRz+bpCe0N52FpY0X3jXRyL1rA1U2JdZoh11Ziq6KPeqzpLNC6XFBB
	o4iR0OmFpKhIXpDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9449B136A4;
	Fri, 12 Jan 2024 08:56:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iUxkILf+oGXaKwAAD6G6ig
	(envelope-from <dkirjanov@suse.de>); Fri, 12 Jan 2024 08:56:23 +0000
Message-ID: <64deebbd-93d0-47dc-835e-f719655e076c@suse.de>
Date: Fri, 12 Jan 2024 11:56:18 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ethernet: ravb: fix dma mapping failure handling
Content-Language: en-US
To: Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Sergey Shtylyov <s.shtylyov@omp.ru>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240112050639.405784-1-nikita.yoush@cogentembedded.com>
From: Denis Kirjanov <dkirjanov@suse.de>
In-Reply-To: <20240112050639.405784-1-nikita.yoush@cogentembedded.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hlVwruvH;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=jrx+ewXj
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.00 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[];
	 TAGGED_RCPT(0.00)[renesas];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: -2.00
X-Rspamd-Queue-Id: 551CA1FC0D
X-Spam-Flag: NO



On 1/12/24 08:06, Nikita Yushchenko wrote:
> dma_mapping_error() depends on getting full 64-bit dma_addr_t and does
> not work correctly if 32-bit value is passed instead.
> 
> Fix handling of dma_map_single() failures on Rx ring entries:
> - do not store return value of dma_map_signle() in 32-bit variable,
> - do not use dma_mapping_error() against 32-bit descriptor field when
>   checking if unmap is needed, check for zero size instead.

Hmm, something is wrong here since you're mixing DMA api and forced 32bit values.
if dma uses 32bit addresses then dma_addr_t need only be 32 bits wide


> 
> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> ---
>  drivers/net/ethernet/renesas/ravb_main.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> index 8649b3e90edb..4d4b5d44c4e7 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> @@ -256,8 +256,7 @@ static void ravb_rx_ring_free_gbeth(struct net_device *ndev, int q)
>  	for (i = 0; i < priv->num_rx_ring[q]; i++) {
>  		struct ravb_rx_desc *desc = &priv->gbeth_rx_ring[i];
>  
> -		if (!dma_mapping_error(ndev->dev.parent,
> -				       le32_to_cpu(desc->dptr)))
> +		if (le16_to_cpu(desc->ds_cc) != 0)
>  			dma_unmap_single(ndev->dev.parent,
>  					 le32_to_cpu(desc->dptr),
>  					 GBETH_RX_BUFF_MAX,
> @@ -281,8 +280,7 @@ static void ravb_rx_ring_free_rcar(struct net_device *ndev, int q)
>  	for (i = 0; i < priv->num_rx_ring[q]; i++) {
>  		struct ravb_ex_rx_desc *desc = &priv->rx_ring[q][i];
>  
> -		if (!dma_mapping_error(ndev->dev.parent,
> -				       le32_to_cpu(desc->dptr)))
> +		if (le16_to_cpu(desc->ds_cc) != 0)
>  			dma_unmap_single(ndev->dev.parent,
>  					 le32_to_cpu(desc->dptr),
>  					 RX_BUF_SZ,
> @@ -1949,7 +1947,7 @@ static netdev_tx_t ravb_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>  	struct ravb_tstamp_skb *ts_skb;
>  	struct ravb_tx_desc *desc;
>  	unsigned long flags;
> -	u32 dma_addr;
> +	dma_addr_t dma_addr;
>  	void *buffer;
>  	u32 entry;
>  	u32 len;

