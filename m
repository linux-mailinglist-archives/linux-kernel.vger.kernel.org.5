Return-Path: <linux-kernel+bounces-30406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79427831E48
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC8191C253FB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476E62C851;
	Thu, 18 Jan 2024 17:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="azqb5UJo"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BDB2C842;
	Thu, 18 Jan 2024 17:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705598382; cv=none; b=L5MzOKq03IDfuAOW6A28D1UngeFznSnQLaSoGj2MhD2u24xfHzzQDk8QvZFHEP5kAnsuO7xWf28VAPI4hlkyTqKk+piNiQd13g0IfInT8c6PhzG7+WpwuNdM/Cjwm+dxFAsx+h06wLnBcy6Iw1s9hF74I2JxPNae2OtxXKtYFoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705598382; c=relaxed/simple;
	bh=wxViSIc8sAyCdtDvj61WsLgmK9qSkut+EIwT5HgTCB0=;
	h=DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding; b=RNNJJ2fXvdF6YDqg5Ynw0Rbbnizkf8N95x9H1EH04TWGmcmw0gFwZKwnerX00EGe+qyPSY4EFrzmYk8QSsjboIfODAyVUwFk3c6Ub2ocjCFBbuvCtROORcKlRBrm2VObdRKWuKaCeW3u8X0lCkaAjxxjYiHKJU3mfWmorv8HDjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=azqb5UJo; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=le1zjJIbWJzNyw/sI9c24dewS/cRUdNZEzjWw/lERjU=; b=azqb5UJoJsqka4IyHtn9zlOXtz
	3L8AGCLehVm2tSWpL9X2Mm0g+3eOt1ATsVy4I35YDfvZJd0Sx3c0trOA157BD+ie9U6w7Z2dJ9yPX
	8lx7mfasPrpzRtlXDEicqe6rzkSP1qkER8Bq3O8LLeqUlA1g/mqMUj+wDw7S9CSte7XaTV7jfKFHD
	eUR+yjvSZHa6n548iKnt3I1U2SR9q5XIJuy8SECP9FpyPvUzPMyfL1du7R42agel63hKA1+Wvdkql
	GkmA3qqkW+ux5MDxyruHEzPll5NKH61PB+i9hWCqTtDhZ3rt6HHCfimKc+XxHzCEgs3Vhkw22Po1o
	yRGnm1xA==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rQW3H-003NJm-2n;
	Thu, 18 Jan 2024 17:19:39 +0000
Message-ID: <d4fc5d68-c6a0-46fc-a11c-a97a33ea27e0@infradead.org>
Date: Thu, 18 Jan 2024 09:19:39 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] wifi: ath10k: Fix htt_data_tx_completion kernel-doc
 warning
Content-Language: en-US
To: Jeff Johnson <quic_jjohnson@quicinc.com>, Kalle Valo <kvalo@kernel.org>
Cc: ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240118-ath10k-kerneldoc-v1-0-99c7e8d95aad@quicinc.com>
 <20240118-ath10k-kerneldoc-v1-4-99c7e8d95aad@quicinc.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240118-ath10k-kerneldoc-v1-4-99c7e8d95aad@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/18/24 08:12, Jeff Johnson wrote:
> Currently kernel-doc reports:
> drivers/net/wireless/ath/ath10k/htt.h:911: warning: Cannot understand  * @brief target -> host TX completion indication message definition
>  on line 911 - I thought it was a doc line
> 
> This is because even though struct htt_data_tx_completion uses the
> kernel-doc marker "/**", it doesn't actual use kernel-doc syntax for
> the documentation. Rather than try to update this legacy driver
> documentation to use kernel-doc style, just replace the comment
> marker.
> 
> No functional changes, compile tested only.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/net/wireless/ath/ath10k/htt.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/htt.h b/drivers/net/wireless/ath/ath10k/htt.h
> index eb0ce2f49315..603f6de62b0a 100644
> --- a/drivers/net/wireless/ath/ath10k/htt.h
> +++ b/drivers/net/wireless/ath/ath10k/htt.h
> @@ -906,7 +906,7 @@ struct htt_data_tx_completion_ext {
>  	__le16 msdus_rssi[];
>  } __packed;
>  
> -/**
> +/*
>   * @brief target -> host TX completion indication message definition
>   *
>   * @details
> 

-- 
#Randy

