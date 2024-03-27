Return-Path: <linux-kernel+bounces-121996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B87D88F07B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BED0B240BC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBFB1534FC;
	Wed, 27 Mar 2024 20:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T4I57VPY"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65869152DEA
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 20:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711572497; cv=none; b=uTei29hAZm0xd2nbm5jH9tnLXOvGm2L454+6w90GEQC8WTWrL13jO0jW/R7o61fec+XMemOBKLby6qKWqWskMMFU6Ir8yWNyzgCK9m0gMcIDGJRfGjT9zDnEibl727OgWP/UvvHok9m+zeCKVHNmpFHTd6o2xAybv9UhDdqnHVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711572497; c=relaxed/simple;
	bh=bBSihwyj6QqaoBrlVdzXuT1LwFsR3kDiWQ0i1Mjpbw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fyfKK/jcQrIAEla0E+9UYlgoQjlMvcxAdqPzYneFALORDa37Oi+KjJFqo7pjGxpMQSxa2bwejv0e5i1oE/NABWMUe5nnCPsiyGIySxR1tkn6s82c1BRuek7c5ox0v08mL+xy0z2m10QyrT0ckFzB6YmGhRYlWXHMLslejJ+8s0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T4I57VPY; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a46ea03c2a5so53697866b.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 13:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711572494; x=1712177294; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SUD3QukZ9tgzgqeBxO31WDQxtggejKllhzLhWk9Mxfw=;
        b=T4I57VPY9a6twZp78LZt0Qgz4uaE1LAz/1jPQDK8uXdwmHK8G6z+djWXaOpccLGJp4
         hozvYyPAGOsFJ2tq930hG+aiL+oR/5yu3ye/3/bLtHQ9DYhLlcbpRXIBxe67A95qF7Ed
         DWR4FHtXCU+Mvtm0Fz0350uINLgAcYAID70le4sra349S4Tzk9kMeVAtHnn1Hl4YVAPW
         uSVvEk3D6saZPSiJB0XDVJagvJabKS4clxU8VvfdkrBf7paSPQW3yaeKH3venVVxt7Pc
         UA3ZM8w8zYKd98kxUyLLG5Q2gekuhNO+mYcG4k4vEk07xu27KU2/vaAn7v9rcHQiVfkg
         l/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711572494; x=1712177294;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SUD3QukZ9tgzgqeBxO31WDQxtggejKllhzLhWk9Mxfw=;
        b=m8SzhOy5kDJeOdN2RGK4n7eRxu6uKNK3c31vuyU6Mi3v3GixdsuZD3xkKQ6BIAB6mc
         8aQTJcNpvm1FYAt0S9lCFozDoFSTCXlcBtTgDWQinEysuMqHkBcP0jRofjSkxClTLIvz
         mHmu1LHfmkXJ5YFaCFP3BXkwDCII1FF3GFfMFuyDOZYDGx3ivnGFxmeOxpwtMMUEF+Jx
         mjAuNffxUi0lrJ/b3C88jP1+H7HrmSQ438fl4vLyjpvS9B4PLBn9sDqy1KIwnblYunfl
         JFs9EI4VV3Q6DYifLuTbTEJ7WfQN9cny5/Zt3/qWJghUjDZT49vdwmTSVyb5sGB22gG6
         HrJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMyTpvr/OKnPUpgZIba9YjWD8IopuECAdKpyk0yenvgYXCumvlVMAH4czyAUfAJGBlnl7CxPx9Vw1zlcBj/Gb1p2KNZEjsdRpx9Kxt
X-Gm-Message-State: AOJu0YysfI12sOMbTiEC19JoVgNaq0gJVksRiYrw5XOhM6dLotpat7Jd
	fBPJFq9AfDc+JIn63xnbBAsoYs/eu+4R0OhxOwtN0z7+0bEOG1ZZuEh2NfvcyLE=
X-Google-Smtp-Source: AGHT+IEYcDHAUGTZ+wcna45N+/LrIFKC5kbIuK+RvWvpeI+gdVZeTbUdyF4KUyJQz+c8qnZzQm6yvQ==
X-Received: by 2002:a17:906:7252:b0:a46:a28d:2f49 with SMTP id n18-20020a170906725200b00a46a28d2f49mr362565ejk.32.1711572493672;
        Wed, 27 Mar 2024 13:48:13 -0700 (PDT)
Received: from [192.168.92.47] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id w17-20020a17090633d100b00a4df82aa6a7sm2026882eja.219.2024.03.27.13.48.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 13:48:13 -0700 (PDT)
Message-ID: <e1d8d30f-483a-4e3b-882c-147cea40c532@linaro.org>
Date: Wed, 27 Mar 2024 21:48:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] power: supply: mm8013: fix "not charging"
 detection
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20240303-power_supply-charge_behaviour_prop-v2-0-8ebb0a7c2409@weissschuh.net>
 <20240303-power_supply-charge_behaviour_prop-v2-1-8ebb0a7c2409@weissschuh.net>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240303-power_supply-charge_behaviour_prop-v2-1-8ebb0a7c2409@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3.03.2024 4:31 PM, Thomas Weißschuh wrote:
> The charge_behaviours property is meant as a control-knob that can be
> changed by the user.
> 
> Page 23 of [0] which documents the flag CHG_INH as follows:
> 
>   CHG_INH : Charge Inhibit      When the current is more than or equal to charge
>                                 threshold current,
>                                 charge inhibit temperature (upper/lower limit) ：1
>                                 charge permission temperature or the current is
>                                 less than charge threshold current ：0
> 
> So this is pure read-only information which is better represented as
> POWER_SUPPLY_STATUS_NOT_CHARGING.
> 
> [0] https://product.minebeamitsumi.com/en/product/category/ics/battery/fuel_gauge/parts/download/__icsFiles/afieldfile/2023/07/12/1_download_01_12.pdf
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---

The patch is now queued, so I won't leave any additional tags,
but thanks for taking care of this, Thomas!

Konrad

