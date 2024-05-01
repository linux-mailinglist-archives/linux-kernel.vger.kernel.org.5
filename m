Return-Path: <linux-kernel+bounces-165612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 261788B8E93
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 18:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 824D8B21759
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17D614286;
	Wed,  1 May 2024 16:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W02y2Q1k"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6CD10A2A;
	Wed,  1 May 2024 16:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714582515; cv=none; b=QAgyAnb7u++z//8RejmYKbGJrF1H9uovgbnsIjCc/PVkmYQLXX7pLFtlNJEExag7EAHndvfXGeT/KTw1tel9R9Behd6jJMnPciBlHP1jMxjbDEaRrX0+2dOwLHHUPvXnLrHat60iKPM4r0P1NY3X62ypz6AROSWpAAu/xvYfP1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714582515; c=relaxed/simple;
	bh=n7XUF133JhwS4bpUwuJ8J8zY3R9sbB7Raf2N13RdULY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=in3I++bqgb1MxqM3F+SSEufoevGH9E9+GPZYgfu3L+t+jNdCIzdg6nCitfwcLdhJi95nxnTC/INfu2nGVkApzLFYmkWX/XmsiXhTtIbGwbDVdSK4Q+3qself1d2ysI24juf9bhRTQ8TS2W8BWT09hPewIaRl37tuEJ/yyVzmg1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W02y2Q1k; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3c709e5e4f9so4333203b6e.3;
        Wed, 01 May 2024 09:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714582512; x=1715187312; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Ec4/pRdCc3AjS+q+CimTNZ6GJ4xqHg3tVlcEEpinlVc=;
        b=W02y2Q1kwrPAm4zau25lhvlhNti2lpImSsS4KHJCj8lwBs4Je0OdzbXzJX0pfcc9C9
         ooDhoJ4j2l2dvkxPAoqz+XEHRG0AHuU+1prvvVO9rNcUiE/T9pvMEcdBnIoeWvArnvWN
         l7CPEUiZffPlEXCQ/yd3Svabm8m7tAbAK9y+ordAj1tRtfj5rPNQYIfJhmhqY2gczPgs
         l6Ho6xtJMWd78LPf3jXP7OqJ5E7lOwkIEJyVBOu6gtCucS7k2qdSZN66J6aPx7iMPgsY
         GFeu5fp6X0RGVAJRuLScH5bllO6NlLt3zkufAsL3fSYplznI7pEp8aJO9dab0cRHP2Qo
         wgHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714582512; x=1715187312;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ec4/pRdCc3AjS+q+CimTNZ6GJ4xqHg3tVlcEEpinlVc=;
        b=EmZBa8sBLiuH9t0ingvsR0VrM3jZ6gtF4iDOHNDSzpjPUC6U+uwi0eUAw4sRg0knGc
         JCxZkf4J282d/dZdPdXnAS9l+n83AuWJ9jNRH95Ij7dZlT6FVfLTcVsrTBvbY9xrVqCk
         spnQm7nhC6v32g9Tgov4eIEl0Q2hB9i1ccUayCtJdP2q2KT0uWwShMRzd0mqF3MSWRs1
         SyouDTDpryrhl/h4Qd8i4iuE96lIU8xIJ4RLECqKPUvdyteCZjFL8PgfTV71Q7yA7Y+Q
         7nZwwiQFtgRwxaq3vNpo1OtS/wDfxOWU3LvQ0/lE1tnruQvWn/lXKdmkt7WAtlNwniUM
         FYrg==
X-Forwarded-Encrypted: i=1; AJvYcCWdC93B7+W8siHBEvW5knpImnfmsD3RBg9/jitGeG8V2OwbMQ6G7RVVq4RxiSp1kJ+mlI1oZYDtewCgCkcMvY31HPXBG3Yle+sdTBpiua2FOdsUElhRG38Cr44iC0qQyh6ugiignBAmdk/tnTY=
X-Gm-Message-State: AOJu0Ywb2KV5dLBUWRs6se4SD3S9OEsZk/ra/KCR+foB+CjNFW4avxdJ
	mVBC3q4ZfNgb4Jq89XJGWLfK33lIskGyllbwfwOU5MRl2IJIkb0B
X-Google-Smtp-Source: AGHT+IF5sGCr+6OKVRAEX0KZ/AHP9d7gkTzcFk5ZwZW3/HwE/UOgc6fWvwpyDR/BdUf+IRQXRh8oBA==
X-Received: by 2002:aca:120c:0:b0:3c7:2a72:34bd with SMTP id 12-20020aca120c000000b003c72a7234bdmr3163499ois.30.1714582512145;
        Wed, 01 May 2024 09:55:12 -0700 (PDT)
Received: from [192.168.0.189] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id ct3-20020a056808360300b003c5db0dabb7sm3995600oib.40.2024.05.01.09.55.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 09:55:11 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <22b0713e-49f2-482a-b145-e460b5632a7c@lwfinger.net>
Date: Wed, 1 May 2024 11:55:08 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: fix remapped ce accessing issue on 64bit OS
To: Ziyang Huang <hzyitc@outlook.com>, kvalo@kernel.org
Cc: jjohnson@kernel.org, linux-wireless@vger.kernel.org,
 ath11k@lists.infradead.org, linux-kernel@vger.kernel.org
References: <TYZPR01MB55563B3A689D54D18179E5B4C9192@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
Content-Language: en-US
From: Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <TYZPR01MB55563B3A689D54D18179E5B4C9192@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/1/24 11:14 AM, Ziyang Huang wrote:
> On 64bit OS, when ab->mem_ce is lower than or 4G far away from ab->mem,
> u32 is not enough to store the offsets, which makes ath11k_ahb_read32()
> and ath11k_ahb_write32() access incorrect address and causes Data Abort
> Exception.
> 
> Let's use the high bits of offsets to decide where to access, which is
> similar as ath11k_pci_get_window_start() done. In the future, we can merge
> these functions for unified regs accessing.
> 
> Signed-off-by: Ziyang Huang <hzyitc@outlook.com>
> ---
>   drivers/net/wireless/ath/ath11k/ahb.c | 34 ++++++++++++++++++++-------
>   drivers/net/wireless/ath/ath11k/hal.c | 17 +++++---------
>   drivers/net/wireless/ath/ath11k/hw.c  | 14 +++++------
>   drivers/net/wireless/ath/ath11k/hw.h  |  7 +++++-
>   4 files changed, 45 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
> index 7c0a23517949..9e59b4de93a9 100644
> --- a/drivers/net/wireless/ath/ath11k/ahb.c
> +++ b/drivers/net/wireless/ath/ath11k/ahb.c
> @@ -198,12 +198,30 @@ static const struct ath11k_pci_ops ath11k_ahb_pci_ops_wcn6750 = {
>   
>   static inline u32 ath11k_ahb_read32(struct ath11k_base *ab, u32 offset)
>   {
> -	return ioread32(ab->mem + offset);
> +	switch (offset & ATH11K_REG_TYPE_MASK) {
> +	case ATH11K_REG_TYPE_NORMAL:
> +		return ioread32(ab->mem + FIELD_GET(ATH11K_REG_OFFSET_MASK, offset));
> +	case ATH11K_REG_TYPE_CE:
> +		return ioread32(ab->mem_ce + FIELD_GET(ATH11K_REG_OFFSET_MASK, offset));
> +	default:
> +		BUG();

Do you really want to crash the system here? A dev_warn() or something similar 
would log the situation. I suspect this case is never taken, but a system crash 
is not a good response if it is.

> +		return 0;
> +	}
>   }
>   
>   static inline void ath11k_ahb_write32(struct ath11k_base *ab, u32 offset, u32 value)
>   {
> -	iowrite32(value, ab->mem + offset);
> +	switch (offset & ATH11K_REG_TYPE_MASK) {
> +	case ATH11K_REG_TYPE_NORMAL:
> +		iowrite32(value, ab->mem + FIELD_GET(ATH11K_REG_OFFSET_MASK, offset));
> +		break;
> +	case ATH11K_REG_TYPE_CE:
> +		iowrite32(value, ab->mem_ce + FIELD_GET(ATH11K_REG_OFFSET_MASK, offset));
> +		break;
> +	default:
> +		BUG();

Ditto.

Larry


