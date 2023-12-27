Return-Path: <linux-kernel+bounces-12087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33AE981EFD5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 16:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B66401F21F30
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 15:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7966745979;
	Wed, 27 Dec 2023 15:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="foVj4Ffv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4916A45964;
	Wed, 27 Dec 2023 15:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-78109a21144so454966185a.0;
        Wed, 27 Dec 2023 07:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703691815; x=1704296615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TBCXKxvUXWJQToqFmz1xAaXGNoJI0qbk9JjCq2X05Fg=;
        b=foVj4FfvNwZUY9T6gprfxlcylO6MYYUZgE8E2WGycnH5KYEEoi3zkGJ2dAGQt6XxuA
         eSbrxRmt4Kz/1uYPEPkDpok3tO/iWMW100agURyVGxvBXGCpxGUXc8wkAi5sm8jRsucW
         AmXMRoD5x7CxlGf6/wjXTrpkSR5rAdxUd4GjUd7WR51d5hLizeShQPo3QNj4hdIwjhiC
         9OzRJSPs7fbrWRRLSRZjcve34GJRsuZEX50x8aZe0y28HexiGEqR84++daxkNugNoFB6
         PSysov/qPdJqLLPyH5CJH9QLrjdeb/Zvz2jwJj+N1pgXJi2ieac5DHvascZnrzM1OE14
         N0sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703691815; x=1704296615;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TBCXKxvUXWJQToqFmz1xAaXGNoJI0qbk9JjCq2X05Fg=;
        b=hCJXSjcEsYNLv7B3sW883eI9aFJbZn0kFLcjXzNtGqgI/Mly247RcJHoycUQArShnB
         8fnFO53Q3bkmbw6QYfTWB8lqggJk9ZwbwmP2yxFOsApWypl8OoWz2JforrN7ct+6G6EX
         Y/BwFOZei2U0c4qVUzHOHAg8ONDbWpPHaP7g03DaxIPuQJZcjH/+eNauGLJ94tDwMMCI
         0QrG9k5ce7kw65JuZO/Oj/xj1aLxn2UroA186JFm+gDtfoWpzYrSnqzPn4H15Bzb/zpj
         1iO7WADBdyun0J3OlcsXF3PbTFd9P2MnmM7Aq4M9ZSg8/CA2QjBeD5i/pWPxmjSRLmyi
         76vQ==
X-Gm-Message-State: AOJu0YwzYCl/FiMWyT+G8jbpu88e8kbrasJ7tpLpQQdD0fy4Ap3sUihm
	gMkLvW93rg/jfBpI2fdovv4=
X-Google-Smtp-Source: AGHT+IG9tJpj8kWpbPMBMwXnggcWk7l+AJHgsEEDNt2oG3A0S9U97AQlK74BQGim4xwZyRHz6paKoA==
X-Received: by 2002:a05:620a:f14:b0:781:65d9:ec8b with SMTP id v20-20020a05620a0f1400b0078165d9ec8bmr759485qkl.100.1703691815106;
        Wed, 27 Dec 2023 07:43:35 -0800 (PST)
Received: from localhost (48.230.85.34.bc.googleusercontent.com. [34.85.230.48])
        by smtp.gmail.com with ESMTPSA id h15-20020a05620a21cf00b007816608002asm227720qka.19.2023.12.27.07.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 07:43:34 -0800 (PST)
Date: Wed, 27 Dec 2023 10:43:34 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Michal Kubiak <michal.kubiak@intel.com>, 
 Larysa Zaremba <larysa.zaremba@intel.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 intel-wired-lan@lists.osuosl.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <658c46269aa52_a33e629442@willemb.c.googlers.com.notmuch>
In-Reply-To: <20231223025554.2316836-2-aleksander.lobakin@intel.com>
References: <20231223025554.2316836-1-aleksander.lobakin@intel.com>
 <20231223025554.2316836-2-aleksander.lobakin@intel.com>
Subject: Re: [PATCH RFC net-next 01/34] idpf: reuse libie's definitions of
 parsed ptype structures
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Alexander Lobakin wrote:
> idpf's in-kernel parsed ptype structure is almost identical to the one
> used in the previous Intel drivers, which means it can be converted to
> use libie's definitions and even helpers. The only difference is that
> it doesn't use a constant table, rather than one obtained from the
> device.
> Remove the driver counterpart and use libie's helpers for hashes and
> checksums. This slightly optimizes skb fields processing due to faster
> checks.
> 
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  drivers/net/ethernet/intel/Kconfig            |   1 +
>  drivers/net/ethernet/intel/idpf/idpf.h        |   2 +-
>  drivers/net/ethernet/intel/idpf/idpf_main.c   |   1 +
>  .../ethernet/intel/idpf/idpf_singleq_txrx.c   |  87 +++++++--------
>  drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 101 ++++++------------
>  drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  88 +--------------
>  .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  54 ++++++----
>  7 files changed, 110 insertions(+), 224 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
> index c7da7d05d93e..0db1aa36866e 100644
> --- a/drivers/net/ethernet/intel/Kconfig
> +++ b/drivers/net/ethernet/intel/Kconfig
> @@ -378,6 +378,7 @@ config IDPF
>  	tristate "Intel(R) Infrastructure Data Path Function Support"
>  	depends on PCI_MSI
>  	select DIMLIB
> +	select LIBIE
>  	select PAGE_POOL
>  	select PAGE_POOL_STATS
>  	help
> diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
> index 0acc125decb3..8342df0f4f3d 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf.h
> +++ b/drivers/net/ethernet/intel/idpf/idpf.h
> @@ -385,7 +385,7 @@ struct idpf_vport {
>  	u16 num_rxq_grp;
>  	struct idpf_rxq_group *rxq_grps;
>  	u32 rxq_model;
> -	struct idpf_rx_ptype_decoded rx_ptype_lkup[IDPF_RX_MAX_PTYPE];
> +	struct libie_rx_ptype_parsed rx_ptype_lkup[IDPF_RX_MAX_PTYPE];
>  
>  	struct idpf_adapter *adapter;
>  	struct net_device *netdev;
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
> index e1febc74cefd..6471158e6f6b 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_main.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
> @@ -7,6 +7,7 @@
>  #define DRV_SUMMARY	"Intel(R) Infrastructure Data Path Function Linux Driver"
>  
>  MODULE_DESCRIPTION(DRV_SUMMARY);
> +MODULE_IMPORT_NS(LIBIE);
>  MODULE_LICENSE("GPL");
>  
>  /**
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
> index 8122a0cc97de..e58e08c9997d 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
> @@ -636,75 +636,64 @@ static bool idpf_rx_singleq_is_non_eop(struct idpf_queue *rxq,
>   * @rxq: Rx ring being processed
>   * @skb: skb currently being received and modified
>   * @csum_bits: checksum bits from descriptor
> - * @ptype: the packet type decoded by hardware
> + * @parsed: the packet type parsed by hardware
>   *
>   * skb->protocol must be set before this function is called
>   */
>  static void idpf_rx_singleq_csum(struct idpf_queue *rxq, struct sk_buff *skb,
> -				 struct idpf_rx_csum_decoded *csum_bits,
> -				 u16 ptype)
> +				 struct idpf_rx_csum_decoded csum_bits,
> +				 struct libie_rx_ptype_parsed parsed)
>  {
> -	struct idpf_rx_ptype_decoded decoded;
>  	bool ipv4, ipv6;
>  
>  	/* check if Rx checksum is enabled */
> -	if (unlikely(!(rxq->vport->netdev->features & NETIF_F_RXCSUM)))
> +	if (!libie_has_rx_checksum(rxq->vport->netdev, parsed))
>  		return;
>  
>  	/* check if HW has decoded the packet and checksum */
> -	if (unlikely(!(csum_bits->l3l4p)))
> +	if (unlikely(!csum_bits.l3l4p))
>  		return;
>  
> -	decoded = rxq->vport->rx_ptype_lkup[ptype];
> -	if (unlikely(!(decoded.known && decoded.outer_ip)))
> +	if (unlikely(parsed.outer_ip == LIBIE_RX_PTYPE_OUTER_L2))
>  		return;
>  
> -	ipv4 = IDPF_RX_PTYPE_TO_IPV(&decoded, IDPF_RX_PTYPE_OUTER_IPV4);
> -	ipv6 = IDPF_RX_PTYPE_TO_IPV(&decoded, IDPF_RX_PTYPE_OUTER_IPV6);
> +	ipv4 = parsed.outer_ip == LIBIE_RX_PTYPE_OUTER_IPV4;
> +	ipv6 = parsed.outer_ip == LIBIE_RX_PTYPE_OUTER_IPV6;
>  
>  	/* Check if there were any checksum errors */
> -	if (unlikely(ipv4 && (csum_bits->ipe || csum_bits->eipe)))
> +	if (unlikely(ipv4 && (csum_bits.ipe || csum_bits.eipe)))
>  		goto checksum_fail;
>  
>  	/* Device could not do any checksum offload for certain extension
>  	 * headers as indicated by setting IPV6EXADD bit
>  	 */
> -	if (unlikely(ipv6 && csum_bits->ipv6exadd))
> +	if (unlikely(ipv6 && csum_bits.ipv6exadd))
>  		return;
>  
>  	/* check for L4 errors and handle packets that were not able to be
>  	 * checksummed due to arrival speed
>  	 */
> -	if (unlikely(csum_bits->l4e))
> +	if (unlikely(csum_bits.l4e))
>  		goto checksum_fail;
>  
> -	if (unlikely(csum_bits->nat && csum_bits->eudpe))
> +	if (unlikely(csum_bits.nat && csum_bits.eudpe))
>  		goto checksum_fail;
>  
>  	/* Handle packets that were not able to be checksummed due to arrival
>  	 * speed, in this case the stack can compute the csum.
>  	 */
> -	if (unlikely(csum_bits->pprs))
> +	if (unlikely(csum_bits.pprs))
>  		return;
>  
>  	/* If there is an outer header present that might contain a checksum
>  	 * we need to bump the checksum level by 1 to reflect the fact that
>  	 * we are indicating we validated the inner checksum.
>  	 */
> -	if (decoded.tunnel_type >= IDPF_RX_PTYPE_TUNNEL_IP_GRENAT)
> +	if (parsed.tunnel_type >= LIBIE_RX_PTYPE_TUNNEL_IP_GRENAT)
>  		skb->csum_level = 1;
>  
> -	/* Only report checksum unnecessary for ICMP, TCP, UDP, or SCTP */
> -	switch (decoded.inner_prot) {
> -	case IDPF_RX_PTYPE_INNER_PROT_ICMP:
> -	case IDPF_RX_PTYPE_INNER_PROT_TCP:
> -	case IDPF_RX_PTYPE_INNER_PROT_UDP:
> -	case IDPF_RX_PTYPE_INNER_PROT_SCTP:
> -		skb->ip_summed = CHECKSUM_UNNECESSARY;
> -		return;
> -	default:
> -		return;
> -	}
> +	skb->ip_summed = CHECKSUM_UNNECESSARY;
> +	return;

Is it intentional to change from CHECKSUM_NONE to CHECKSUM_UNNECESSARY
in the default case?

I suppose so, as idpf_rx_csum (the splitq equivalent) does the same
(bar CHECKSUM_COMPLETE depending on descriptor bit).

