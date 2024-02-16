Return-Path: <linux-kernel+bounces-69053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D4B8583DD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 218FAB27AA5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DB913329C;
	Fri, 16 Feb 2024 17:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yj9IDzlD"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B75130AEC;
	Fri, 16 Feb 2024 17:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708103638; cv=none; b=FlrkwhPdD/vUeMJr1FAdCv4kvjSCN6Fo0WDrCymQNtMM9KIWtYKvFqAcftEWfVTidWHdaMi9jNRiFfyf7ReXZCKBX+CrVqc9NtmNkxzKfFzmRc3ekUOXcaKVa+9ifcqotUv797Zp/lmDq4c1QfF3l7pFK/p9N6i7rrqTvb9HOQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708103638; c=relaxed/simple;
	bh=fYAA8xilO4KnYgQIZVtA9ts8YuATLRGZ6f+s+rtRDWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H8DZPeP6ZVcMP/bNcQr9bJ4fTAZHzgzkB+9iIL2Rt6bH7B62qw0/TyOLJYd0sPj/rD+VWUo2d/fb6gSoq56kmXICtZfzQnpdnziW1s8leoyVKJbmkRds5p+uFNa6X1faqgsxfw31aIWR5UFUzkCzCzebxaLg0Z4OJaHG3C/juYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yj9IDzlD; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-42dd6f6518fso3968381cf.1;
        Fri, 16 Feb 2024 09:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708103635; x=1708708435; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pjvfE09Bk+j8kTulAxyHuFEo7lsn+ZYbAj8sdSsLEQI=;
        b=Yj9IDzlDG1aTmi1TACel/VWh7ehQQRcrkkRID722mJoaDb9qQniQl8kQlyiuccb4RY
         O+ckjz5lQgij8YH/mSwvOtn75+HDH8DCR33XBqVlGaGEAf/KQqvuc8lyNhRhBeuondYr
         9pYLapqMVkzr+mUdLFH8wB4VfIadgWh9MRjuKXAV49LN3AYM8lrp4xbBlA1G2DL4K14i
         3CNSl54/HW4uAtgVjsiy8145urN8dBpziQjH8nV793upmMPs1RbndAS1pjtywD4WCHQz
         GcHdmv/fY55CAQm/XepslWuMP2OeRKiEulCRuavuQiaawEswV8ibx3WdzKyqYRgavOSD
         uzUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708103635; x=1708708435;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pjvfE09Bk+j8kTulAxyHuFEo7lsn+ZYbAj8sdSsLEQI=;
        b=fTLPq0CeUy1Tre5piqqHf8S541lM22tpPEnrTkTCNcl2ZwubIEpZBuMD0Q9Qk5yxE8
         xgB4xtoSWPIJbu/c5wKf9KqlQSg6yxEjC8WZflZfCv3vpuG65gnObjGDPMDWP4TsdYIw
         xw3cxOoPb2KWpkIGS3Rp49TZUG7mJFoPcXl0wWsjnlFVkghxuSvOdMZv6C0NptKygUqp
         HaYtoqsPbQe02K8xxUbMw8igPAc0TYH/H2pKo860UnpayZXx+Xbnucq1vdTXLNrN36nf
         XLASuAnj9+kzxRzQwjpg7McVvtdDBBttBf3k51Gm6E8T8YGF5Zm0abPJHRujk20FR/ES
         3TyQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3+UY3GuchyrjShmRMB8rtI3A49OvxwGB9whyjVemZrKX4GhO3u7VvK63IL5YU8n3NpXSfkaPE/ZxM5xgcYa8OVW1dqv8LhhRpZb7Y
X-Gm-Message-State: AOJu0Yx5h9TGubp3NwIAliJEnQcSpa61IBYx8LFLIpvDMfA/DCvTo4pN
	8o6v3N4ckZaHiUJE8k5AC7FTlDCLfaeMcCxRqobL4x02zgbGhUJy
X-Google-Smtp-Source: AGHT+IGwY7as3MWB8rYJ4I9pgzQYCKHYP5+MPcdYB0dE1tHD/o8J8JD84q4msCMJqeg9XyYibSA/xg==
X-Received: by 2002:a05:622a:15d6:b0:42c:7c75:b73b with SMTP id d22-20020a05622a15d600b0042c7c75b73bmr6001337qty.18.1708103635473;
        Fri, 16 Feb 2024 09:13:55 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id y20-20020ac85f54000000b0042c5512c329sm105660qta.17.2024.02.16.09.13.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 09:13:54 -0800 (PST)
Message-ID: <61bdd802-abe4-4544-8e48-9493a6bb99c8@gmail.com>
Date: Fri, 16 Feb 2024 09:13:51 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: stmmac: mmc_core: Assign, don't add interrupt
 registers
Content-Language: en-US
To: Jesper Nilsson <jesper.nilsson@axis.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel@axis.com
References: <20240216-stmmac_stats-v1-1-7065fa4613f8@axis.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240216-stmmac_stats-v1-1-7065fa4613f8@axis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/16/24 07:24, Jesper Nilsson wrote:
> The MMC IPC interrupt status and interrupt mask registers are of
> little use as Ethernet statistics, but incrementing counters
> based on the current interrupt and interrupt mask registers
> makes them worse than useless.
> 
> For example, if the interrupt mask is set to 0x08420842,
> the current code will increment by that amount each iteration,
> leading to the following sequence of nonsense:
> 
> mmc_rx_ipc_intr_mask: 969816526
> mmc_rx_ipc_intr_mask: 1108361744
> 
> Change the increment to a straight assignment to make the
> statistics at least nominally useful.
> 
> Signed-off-by: Jesper Nilsson <jesper.nilsson@axis.com>
> ---
>   drivers/net/ethernet/stmicro/stmmac/mmc_core.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/mmc_core.c b/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
> index 6a7c1d325c46..6051a22b3cec 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
> @@ -280,8 +280,8 @@ static void dwmac_mmc_read(void __iomem *mmcaddr, struct stmmac_counters *mmc)
>   	mmc->mmc_rx_vlan_frames_gb += readl(mmcaddr + MMC_RX_VLAN_FRAMES_GB);
>   	mmc->mmc_rx_watchdog_error += readl(mmcaddr + MMC_RX_WATCHDOG_ERROR);
>   	/* IPC */
> -	mmc->mmc_rx_ipc_intr_mask += readl(mmcaddr + MMC_RX_IPC_INTR_MASK);
> -	mmc->mmc_rx_ipc_intr += readl(mmcaddr + MMC_RX_IPC_INTR);
> +	mmc->mmc_rx_ipc_intr_mask = readl(mmcaddr + MMC_RX_IPC_INTR_MASK);
> +	mmc->mmc_rx_ipc_intr = readl(mmcaddr + MMC_RX_IPC_INTR);

So in premise I agree with the patch, that incrementing those is not the 
right way to go about them. However these registers are currently 
provided as part of the statistics set, but they should instead be 
accessed via the register dumping method.

In either case you will get at best a snapshot of those two registers at 
any given time and I suppose this can help diagnose a stuck RX 
condition, but not much more than that.
-- 
Florian


