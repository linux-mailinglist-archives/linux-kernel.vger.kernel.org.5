Return-Path: <linux-kernel+bounces-30405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC66831E46
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D032C1F26FE0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DCF2C84C;
	Thu, 18 Jan 2024 17:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B6bHaJes"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94532C6BB;
	Thu, 18 Jan 2024 17:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705598330; cv=none; b=hJCH1y8bbC191AhLb1udZM0YF7Y+wug8OwYQ8vzJjIMTOeGqzy66ya2xoQaYIaTmr5kXacdez7QLHsRLs2bu5OdIi7SpBPjXgDdv/4Rj3MBPC1L941iuIwg5q8Y/viPrlh3YGFfJNlnjUTPFVjmSFhQshMUT93TTVZ0VV4tcLYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705598330; c=relaxed/simple;
	bh=wiKCM0KpMtbV94mqpmp2BHhWEtb3v5SdLrOpS6npQLE=;
	h=DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding; b=MeSCk4YAc271/6jCJBzbJYl2SGpVOa4KHsclQ9JKfn2zIHRwtUsFqjmwCI7qWFXwidMVcFK/2hGPbU7kTwj5rng1dxlDk3TQmo6oWBrbQeKE3+e37o2mD6h9Ufd1pd9wJWttWSsNKul3hjgAS8VPblzr8RJRKGlcaa1OjdvydwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=B6bHaJes; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=+GJ43sxJEugFE+jhUQRT8P2K2kdj7Gi760KtJCGgVaM=; b=B6bHaJesLoX+dRJqr1VMvY54/7
	txiHLAC90r5qvAZRKhi5ldfeiNfPOPxIHQ/ucX58Wx4fyGN6YB90dfaC6Kb5vBBfqlwFqFgUFuNqd
	m+pxllZB+iovMcowk0U63YUQzr0+RxT/qsiLXac0jDatwmyYCy6yZMZjp4Bw2+TBOCMJRlv6CB9no
	DHE9c7Y5gRDJYp1C1v2I2DW+UzR5H26QWkOoTggNm5HofT21EVfBL+YEfO3nG/ugXvazW8QtzNCFr
	xrB9kTV1RsjLhcbQ195uXOgq1RpihTe5JjNjf2n1T/96YKXWdMxWEpnif8QPH9BsxMNym6DFNj/3R
	PbwmBbxQ==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rQW2R-003NJm-1H;
	Thu, 18 Jan 2024 17:18:47 +0000
Message-ID: <fbcfe7ef-8308-4390-9cf5-67ee25604bed@infradead.org>
Date: Thu, 18 Jan 2024 09:18:47 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] wifi: ath10k: fix htt_q_state_conf & htt_q_state
 kernel-doc
Content-Language: en-US
To: Jeff Johnson <quic_jjohnson@quicinc.com>, Kalle Valo <kvalo@kernel.org>
Cc: ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240118-ath10k-kerneldoc-v1-0-99c7e8d95aad@quicinc.com>
 <20240118-ath10k-kerneldoc-v1-3-99c7e8d95aad@quicinc.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240118-ath10k-kerneldoc-v1-3-99c7e8d95aad@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/18/24 08:12, Jeff Johnson wrote:
> Currently kernel-doc reports:
> drivers/net/wireless/ath/ath10k/htt.h:1488: warning: cannot understand function prototype: 'struct htt_q_state_conf '
> drivers/net/wireless/ath/ath10k/htt.h:1542: warning: cannot understand function prototype: 'struct htt_q_state '
> 
> Update the kernel-doc for these two structs to resolve the warnings.
> 
> No functional changes, compile tested only.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  drivers/net/wireless/ath/ath10k/htt.h | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/htt.h b/drivers/net/wireless/ath/ath10k/htt.h
> index 4a9270e2a4c8..eb0ce2f49315 100644
> --- a/drivers/net/wireless/ath/ath10k/htt.h
> +++ b/drivers/net/wireless/ath/ath10k/htt.h
> @@ -3,7 +3,7 @@
>   * Copyright (c) 2005-2011 Atheros Communications Inc.
>   * Copyright (c) 2011-2017 Qualcomm Atheros, Inc.
>   * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> - * Copyright (c) 2021, 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) 2021, 2023-2024 Qualcomm Innovation Center, Inc. All rights reserved.
>   */
>  
>  #ifndef _HTT_H_
> @@ -1474,15 +1474,19 @@ enum htt_q_depth_type {
>  #define HTT_TX_Q_STATE_ENTRY_MULTIPLIER		0
>  
>  /**
> - * htt_q_state_conf - part of htt_frag_desc_bank_cfg for host q state config
> + * struct htt_q_state_conf - part of htt_frag_desc_bank_cfg for host q state config
>   *
>   * Defines host q state format and behavior. See htt_q_state.
>   *
> + * @paddr: Queue physical address
> + * @num_peers: Number of supported peers
> + * @num_tids: Number of supported TIDs
>   * @record_size: Defines the size of each host q entry in bytes. In practice
>   *	however firmware (at least 10.4.3-00191) ignores this host
>   *	configuration value and uses hardcoded value of 1.
>   * @record_multiplier: This is valid only when q depth type is MSDUs. It
>   *	defines the exponent for the power of 2 multiplication.
> + * @pad: struct padding for 32-bit alignment
>   */
>  struct htt_q_state_conf {
>  	__le32 paddr;
> @@ -1518,7 +1522,7 @@ struct htt_frag_desc_bank_cfg64 {
>  #define HTT_TX_Q_STATE_ENTRY_EXP_LSB		6
>  
>  /**
> - * htt_q_state - shared between host and firmware via DMA
> + * struct htt_q_state - shared between host and firmware via DMA
>   *
>   * This structure is used for the host to expose it's software queue state to

                                                    its
fwiw.

>   * firmware so that its rate control can schedule fetch requests for optimized
> 

-- 
#Randy

