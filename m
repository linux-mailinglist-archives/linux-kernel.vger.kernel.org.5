Return-Path: <linux-kernel+bounces-12698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F98A81F905
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 15:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF5F3285428
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 14:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E471C8EA;
	Thu, 28 Dec 2023 14:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kScjNj8+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9E4C8C3;
	Thu, 28 Dec 2023 14:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a23566e91d5so695927266b.0;
        Thu, 28 Dec 2023 06:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703773030; x=1704377830; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q9TWc0QsnvHfcGGIcrM2gkh4OZ1mQ1/Sz/XukIWBlW4=;
        b=kScjNj8+VolsoGzuodF90hrFmqPzm9iOoubydqYuQRgbdbp9RR8MoUZwjviUeru7Lm
         rVyq2fFQFpgMCOqpxpJb/AS5C3M4ZSxu8bPSrQ8zPiQDPm+zgK6mNxf17sJ3GmUXmTGU
         PK68on+HFC0JANC4hb4fdyaQm4UbD5/7yq0mFP9YG4/GekhqfczATLqfeeN4AEcQ87Ev
         Z7UI7Sn9ebALmkxGV22MnSSZAcH5KiXMB7wUC1VhnzH5Fg3rnnY5iP6f5cIQO5TyX/fG
         2q2uKbgx5a0DC2f1cSxEVvmMAu/oDgfUUWDC5UJCBDpvQbuYHWCJjUvkIM8iSRqzChDv
         9F6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703773030; x=1704377830;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q9TWc0QsnvHfcGGIcrM2gkh4OZ1mQ1/Sz/XukIWBlW4=;
        b=fMM876bbPAlBWenhLftzNIULixkWyUlf0vt2YOuQ1xfpLsKW1FqDhpE7KyX9OA/oey
         QUzb8LJMf/xNRqYZw+dULmOacoBkdbu2AzloeSl7yV9UhtmZhrM0VDydkd88ufhhV7jb
         aPcW4OhOSzs0Ai8MGxb7TVTIJpCCD1n2+xxi2Fa7W2biFDc4MZCkHqkjvhPq3MQzhRcM
         V1O8k82AOVAhs9C0EsoSXkCDWajUbS7iv0fL1yZMS69LVaRk+k6U4uCuwCHqFYxEx0wJ
         kKylge3nXS7BBKx5M0VKLhV4Ro6cgPHfgMnspPpjzi5jgFOgPmfVoHdGSsdTZKYdd4xs
         Ae3Q==
X-Gm-Message-State: AOJu0YxfsLyJoII4TF+gN8GYNuIbbGwcSgL4as/dS5igDo1A9mWKCFbw
	9qUYws2LymbnBNHoq/48SwA=
X-Google-Smtp-Source: AGHT+IHLGsuNiI8uBS5fHnHLhNvmxwuvjcdAObtMuWv0hfCKLMICdbJu8Xj1NI88jvFNjly1bxMkMg==
X-Received: by 2002:a17:906:6d15:b0:a26:fcf3:cf98 with SMTP id m21-20020a1709066d1500b00a26fcf3cf98mr1657221ejr.28.1703773029634;
        Thu, 28 Dec 2023 06:17:09 -0800 (PST)
Received: from ?IPV6:2a01:c22:7631:d500:84f:c992:adf1:8a6d? (dynamic-2a01-0c22-7631-d500-084f-c992-adf1-8a6d.c22.pool.telefonica.de. [2a01:c22:7631:d500:84f:c992:adf1:8a6d])
        by smtp.googlemail.com with ESMTPSA id fv34-20020a17090750a200b00a26ee889b3bsm3805603ejc.158.2023.12.28.06.17.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Dec 2023 06:17:09 -0800 (PST)
Message-ID: <4a9ae956-993b-4377-8ebe-ac655683c536@gmail.com>
Date: Thu, 28 Dec 2023 15:17:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] net: phy: micrel: Add workaround for incomplete
 autonegotiation
Content-Language: en-US
To: Asmaa Mnebhi <asmaa@nvidia.com>, davem@davemloft.net, marek.mojik@nic.cz,
 netdev@vger.kernel.org
Cc: davthompson@nvidia.com, linux-kernel@vger.kernel.org
References: <20231227231657.15152-1-asmaa@nvidia.com>
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20231227231657.15152-1-asmaa@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28.12.2023 00:16, Asmaa Mnebhi wrote:
> Very rarely, the KSZ9031 fails to complete autonegotiation although it was
> initiated via phy_start(). As a result, the link stays down. Restarting
> autonegotiation when in this state solves the issue.
> 
The patch isn't addressed to all relevant maintainers. Please use the
get_maintainers script.

You should use the net/net-next annotation to make clear whether this should
be treated as a fix (in this case add a Fixes tag) or net-next material.

> Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
> ---
> v1->v2:
> - Use msleep() instead of mdelay()
> 
>  drivers/net/phy/micrel.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
> index 08e3915001c3..9952a073413f 100644
> --- a/drivers/net/phy/micrel.c
> +++ b/drivers/net/phy/micrel.c
> @@ -1475,6 +1475,7 @@ static int ksz9031_get_features(struct phy_device *phydev)
>  
>  static int ksz9031_read_status(struct phy_device *phydev)
>  {
> +	u8 timeout = 10;
>  	int err;
>  	int regval;
>  
> @@ -1494,6 +1495,22 @@ static int ksz9031_read_status(struct phy_device *phydev)
>  		return genphy_config_aneg(phydev);
>  	}
>  
> +	/* KSZ9031's autonegotiation takes normally 4-5 seconds to complete.
> +	 * Occasionally it fails to complete autonegotiation. The workaround is
> +	 * to restart it.
> +	 */
> +        if (phydev->autoneg == AUTONEG_ENABLE) {
> +		while (timeout) {
> +			if (phy_aneg_done(phydev))
> +				break;
> +			msleep(1000);
> +			timeout--;

It's not too nice to do this synchronously. Even in the non-problem case this
will block the phylib state machine for seconds. Better find a way to do it
asynchronously.

> +		};
> +
> +		if (timeout == 0)
> +			phy_restart_aneg(phydev);
> +	}
> +
>  	return 0;
>  }
>  


