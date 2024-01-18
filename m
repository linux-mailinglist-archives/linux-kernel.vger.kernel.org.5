Return-Path: <linux-kernel+bounces-30403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB589831E43
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9F94B22466
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BE12C851;
	Thu, 18 Jan 2024 17:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1gy+RV3R"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CCF2C841;
	Thu, 18 Jan 2024 17:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705598226; cv=none; b=k8+0aZsCTgIWbCk0BaY6DX7sJQIhnZr57sm78o5gWkP12r6zjLji6p3sqFVGNTTePqlocO4Hm3pxpifNj5do4q66R0LUQNAOwTS01KFDFjb6fG6ZdjBLYAATP12x1cefMqMoO2Pzv+RWcw0PUrNaW7unXQQ55LtP7TKXwtmEbTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705598226; c=relaxed/simple;
	bh=xzS7KgMyxS+q27HZS7IF+gpTTD0lHiDbJUUAbO/M+No=;
	h=DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding; b=F21B8iKQyn0fqDwx97xrhb5DWv2s1bX6G9y8Rgwe8ebrwkKFPms+2dMCGalnbE9HlMnxJLBKG7ZJZ1C+8+KBiUedD8oGvvExxLdXXGSlexDjMWIMYHpJX2SBlshvY0dlbFcb3d3Y3TOkvP5QD8H+0OP9TfzLuoi6Iu7SGnWj0oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1gy+RV3R; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=ZwnPUB1SZKfhgOedNF5DZLlFWvgucJS8NHyeCiQMdLc=; b=1gy+RV3RgIUDcW1HfTLt+ro2yC
	ogrr2vPEDTcCFnvGM1LWXuX9cotS0ojK7G9e7RMJAOvDMJc1afBGJJutsiOgKaM/cE7nYReoBKPVJ
	H92fYHz3ywBAxD3Yq+LaTBRJ4BK9snx0/r0U6H6KvYmEb5vzLxJEZ9wfSA3XfHC9Y8cycQcdtOta8
	wTudkhOaygtosTS1H15QHpWfPAjiJKuulv4iuallY0sbrq2Fau3rI9XiE/kvj98rimm8ZZTVYnvYp
	6zdVfYCxDhjBaWQt43eUpDMh9yWkHB9+2V1Zc45/NOSFmEO45JBRmjwuCNOC4M7GYiOcCFYM7DdpL
	YTeMOEYA==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rQW0l-003N7E-0B;
	Thu, 18 Jan 2024 17:17:03 +0000
Message-ID: <a59d0fd8-1351-4fc0-a177-1c96cbff4675@infradead.org>
Date: Thu, 18 Jan 2024 09:17:02 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] wifi: ath10k: correctly document enum
 wmi_tlv_tx_pause_id
Content-Language: en-US
To: Jeff Johnson <quic_jjohnson@quicinc.com>, Kalle Valo <kvalo@kernel.org>
Cc: ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240118-ath10k-kerneldoc-v1-0-99c7e8d95aad@quicinc.com>
 <20240118-ath10k-kerneldoc-v1-2-99c7e8d95aad@quicinc.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240118-ath10k-kerneldoc-v1-2-99c7e8d95aad@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/18/24 08:12, Jeff Johnson wrote:
> Currently kernel-doc reports the issue:
> drivers/net/wireless/ath/ath10k/wmi-tlv.h:2363: warning: cannot understand function prototype: 'enum wmi_tlv_tx_pause_id '
> 
> Update the enum wmi_tlv_tx_pause_id documentation to fix this issue.
> 
> No functional changes, compile tested only.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/net/wireless/ath/ath10k/wmi-tlv.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/wmi-tlv.h b/drivers/net/wireless/ath/ath10k/wmi-tlv.h
> index 83a8f07a687f..8a2f87d0a3a3 100644
> --- a/drivers/net/wireless/ath/ath10k/wmi-tlv.h
> +++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.h
> @@ -3,7 +3,7 @@
>   * Copyright (c) 2005-2011 Atheros Communications Inc.
>   * Copyright (c) 2011-2017 Qualcomm Atheros, Inc.
>   * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
> - * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) 2022, 2024 Qualcomm Innovation Center, Inc. All rights reserved.
>   */
>  #ifndef _WMI_TLV_H
>  #define _WMI_TLV_H
> @@ -2343,7 +2343,7 @@ struct wmi_tlv_adaptive_qcs {
>  } __packed;
>  
>  /**
> - * wmi_tlv_tx_pause_id - firmware tx queue pause reason types
> + * enum wmi_tlv_tx_pause_id - firmware tx queue pause reason types
>   *
>   * @WMI_TLV_TX_PAUSE_ID_MCC: used for by multi-channel firmware scheduler.
>   *		Only vdev_map is valid.
> 

-- 
#Randy

