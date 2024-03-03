Return-Path: <linux-kernel+bounces-89732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE5386F4D2
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 13:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 983961C209F3
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 12:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC62FC14F;
	Sun,  3 Mar 2024 12:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="ZP5U4kxE"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F222BA27
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 12:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709468565; cv=none; b=XhcxxAU2pcddKjhKAEj7XarhYS3h/F4z4K4YP7jR3+ymJKKGuJmAzdld/IWOFRZgj1QTyzHB4xvqfnCLxoEfCpnVUa1ZlRCO/zOlcnGCiu+Nqg/WGdzMvcPaQRDQXqWl65ia7bsXqqDv821vAvpYGt5VyxeOfZU+DrbeFUS7fSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709468565; c=relaxed/simple;
	bh=AgQGKG1txHLWS8ImEhfnYrC9R9R6mULK4U8TwmPHZL8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LUHnxGwH6rdl9Zhm+FeJvzbQwR15LleK7j4IDPRDbMv8Sc0yv9noMvbr4XaC2tf6ERyzjXoZCP7qssakErqdUcsF5hlT5RYihMG4fMWxSAHc+KRH0Sog6M9qV4uFpoNH5YPPZfX7Cq/LmpOT58tOszXU0B+NGCUlsu90YPp8ZZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=ZP5U4kxE; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33d8739ddd4so1865108f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 04:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1709468562; x=1710073362; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LeuiFF7R2tbAvv2UiI2PaXeJiriCJov3tu3mur7RTtA=;
        b=ZP5U4kxEzdGczoHSJKE09oWCgmVV3ZluyAyDipgaxpKMHyrDq20im/Q/dHQqoNc/zL
         dEd4s5ZQNiKQ9KEU2mOF3Osiz4t6TvRCQgtHGFH6j5Yx1eHhcCHuqC7xaksKxHz5LCSx
         78HyPP2g8aiXYiHzSUO/CR++spE0Mcn7+D4Uc3ChGFR9afzaYzdxG0GBLCe3sOIjKklx
         zAsEoTyhtdAl4Bl6Z8e6zdXIPtKBUs0wARlco69aLJi2DzCcniVKLjwWUPAHyypu26M+
         JwVhZOkngpOYEq8HSGhvf1RKTAQaleW0XgnIy5V2vBHiIu4ueCDXE4p5YEI0A776l9uq
         RUUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709468562; x=1710073362;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LeuiFF7R2tbAvv2UiI2PaXeJiriCJov3tu3mur7RTtA=;
        b=oqNEwBp24J+opJmx5FSj8cF2fGYOQG+vuokvst/4Zi5q4ffgQBtj2ugBZ0VH2kWFnZ
         5HvMEM+OwYElGbvSlg2k4pX2DQqw/SgFobMgEVDeAZPjMXqjpcQ4eCMMe/u2lNfz8qof
         Z92pUKVeJ/3r4pJUx9iUx3JEf87dUoE7K0r1RJpwXVNWWEsnVp4q6/EN1ZpSxov8CRuC
         kYxj25eZuAcbMHt7AYKDzXJfADvORsRP8V6uUq+pHI+Zy9xC65ITsr3vLp1L36+SHG2O
         bEPawYE+3HHmFduidofR3sCe3QruZCw3wZGpj36AaH1IjPKNxAMzwxmfPsAtSc9a4hvr
         CfAQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0MeAJWSCYNkgyqgIOmATvMb3eYYOo9jH9fmCDCgkGdh8CqNC9iRpPcESjuow2JoxGcAxYwsHm/0DS40zP86Ht9sjmlOXGYZR2EWPU
X-Gm-Message-State: AOJu0Ywoio8wTn5Mff0tJR9TkAN7oM72z/muGaAnJBf3Rkyt8TTe0h9n
	qGilZ830cHmPC+viZDHoQF+OypNuwqQW1lvwzT0S6t7Cgz5WqAKcvvsv15hAWRA=
X-Google-Smtp-Source: AGHT+IF20EOBE7aJ/x79yakSrTL0/aE5yoWoNlwT5Z0ESnkPtvvcc9ML76lCqjtFRth7j+EnygarBw==
X-Received: by 2002:a5d:4150:0:b0:33e:164d:c8c3 with SMTP id c16-20020a5d4150000000b0033e164dc8c3mr4775457wrq.31.1709468561818;
        Sun, 03 Mar 2024 04:22:41 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.38])
        by smtp.gmail.com with ESMTPSA id dw2-20020a0560000dc200b0033ddfba0c67sm9477927wrb.41.2024.03.03.04.22.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Mar 2024 04:22:41 -0800 (PST)
Message-ID: <c4e00fb5-3124-4b2d-a096-11f6e5b86758@tuxon.dev>
Date: Sun, 3 Mar 2024 14:22:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 30/39] power: reset: at91-poweroff: lookup for proper
 pmc dt node for sam9x7
Content-Language: en-US
To: Varshini Rajendran <varshini.rajendran@microchip.com>, sre@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20240223171342.669133-1-varshini.rajendran@microchip.com>
 <20240223172920.673110-1-varshini.rajendran@microchip.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240223172920.673110-1-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 23.02.2024 19:29, Varshini Rajendran wrote:
> Use sam9x7 pmc's compatible to lookup for in the SHDWC driver.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
> Changes in v4:
> - Updated Acked-by tag
> ---
>  drivers/power/reset/at91-sama5d2_shdwc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/power/reset/at91-sama5d2_shdwc.c b/drivers/power/reset/at91-sama5d2_shdwc.c
> index 959ce0dbe91d..2121d7e74e12 100644
> --- a/drivers/power/reset/at91-sama5d2_shdwc.c
> +++ b/drivers/power/reset/at91-sama5d2_shdwc.c
> @@ -326,6 +326,7 @@ static const struct of_device_id at91_pmc_ids[] = {
>  	{ .compatible = "atmel,sama5d2-pmc" },
>  	{ .compatible = "microchip,sam9x60-pmc" },
>  	{ .compatible = "microchip,sama7g5-pmc" },
> +	{ .compatible = "microchip,sam9x7-pmc" },

Maybe would be better to add a phandle in DT instead of continuing
populating this array. But then the backward compatibility should be
preserved. I leave this to Sebastian.

>  	{ /* Sentinel. */ }
>  };
>  

