Return-Path: <linux-kernel+bounces-157058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 086868B0C4E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C3311C23BD3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B508415ECEE;
	Wed, 24 Apr 2024 14:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bbXe+mpU"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81A715E811
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 14:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713968224; cv=none; b=lcfhk+Seu6aRo+hclI1Fp4O976Cy1r0mOYT3xIRJXyk4lEK0o5pDb2lzKK12U4IqPrioCFHSiBJiOzKd0HA7jC6z485vNzMDTR9dX82Xw0ipf+tiBvmybG75L9VetquvjnJcl1AdNXWRKI80ImR90pHhEdflu+e+8ib1oVrKVuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713968224; c=relaxed/simple;
	bh=+xPMvdpLmBFBT82L+2rB4j5nQBGY5IoRBac4o5nrhJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kzGgLJQXDMq6IN+5eOUOHGwU+rc23ZZ/C3TVZYFHLk3DfbcIW1i6aSpz2WQNynwztzP3iLGZ5dBiCJ96veuUtzgLuISpGnumGHbCexQohW9uPmxpCzwnZzcllwGPnG2rjkh9HJ0Y9K2eqDc+DNUOmPc6N6QbuSG/5/q/W8bzkBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bbXe+mpU; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56e6a1edecfso10393622a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 07:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713968220; x=1714573020; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=D+FFw7YxB1izHeLB8MpAI1EI5GFWFRCwf6sagsTPIHc=;
        b=bbXe+mpUAsf0TGKiMviAyDUFR4+5YvHDmNvmHii1Ad5FL0SfH4MvSrTqe/KIZM5ZAw
         Moby1IqqTPbKog6t2ORUzn0wf+5s+tc0zNNXBSthLE4fXLRvjZiAedVZ3Qvjw/QV1yHv
         2j0tfLpgq65xptUvOO0KFdm6CINLUvfMSwIYZvyX1r+HVzANl9AoQcPl45HIcKpLDsBa
         dC3Uy1glCz0hSh9Wci3Z0BCAoTjMOhALQhqCvEESjIxWeCa7EhBoY+lkoh7ZOi0tcamI
         Tukbf9iSQfV2lCRh6JQsS6HsTMaiQ7nKPntUvwqR7ak/xprwftdhXVV2LsZG9D82TL5h
         ZL+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713968220; x=1714573020;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D+FFw7YxB1izHeLB8MpAI1EI5GFWFRCwf6sagsTPIHc=;
        b=MZmve29u7CPIP1ZqyknD+9PXKcAP0fwAHG7meKEoNoaX9MAvSorxMuRYDddXcHvzK0
         P24If6/vl1323gunfTr3NpKOvz1fuLoMZkK5a+BuvPQsIv5HsOELX/gn/qwra6le7g8D
         OD6NoXSQxe//eGIyQS87K2m0qA9wlgeyeEEKGwW7kU/4OGuhhW9mkJuZUk1+mCZqXsVh
         3IlXvtkt/LLPiwTxDwkQKWJ3eKpXU8ccq97evOkICwNBe7M9Milu7HW0+ruFGd5xBfw/
         jIUN2/TCy+Ixaa+AL0kGwXoY4AhDVjJ+ymi04fhCqzdz6rK5Vyw7IbCeTnfvJqjTaWx+
         kgXA==
X-Forwarded-Encrypted: i=1; AJvYcCW7QsulQ+Q8xG6E1eq/EDfYx/niAZzAS/eBWc1uMb9iITip2rwLORmL+6wtaLo4+kWLxn4L8zAMmarWbN2kJHfwEKzz2HQdzXrM/qE2
X-Gm-Message-State: AOJu0YwpvW1UiOXyrLI6up5MdtyPj+qou1YTUMjCzWYqVHgzfwzRDQaL
	GkVxjZu+mQvlthCmPti++jrtnyXW3pVuyjkrO/F83dT3IEu2yzagnRKfjGdCZII=
X-Google-Smtp-Source: AGHT+IEOfsPQ7/Z1yv4Amm4JeBXw+SM4KXxokpxSErr9FzwFJ3mVhgmaCYRo+hfuU1OSFUWH+7v8TA==
X-Received: by 2002:a50:c356:0:b0:56e:2b1c:d013 with SMTP id q22-20020a50c356000000b0056e2b1cd013mr1585369edb.21.1713968220054;
        Wed, 24 Apr 2024 07:17:00 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id bf17-20020a0564021a5100b0056bf6287f32sm7886343edb.26.2024.04.24.07.16.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 07:16:59 -0700 (PDT)
Message-ID: <2a3d928d-3e18-4e3a-9f5b-94dbbaaf3652@linaro.org>
Date: Wed, 24 Apr 2024 16:16:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] dt-bindings: reset: Add binding constants for
 BLZP1600
To: Niko Pasaloukos <nikolaos.pasaloukos@blaize.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: James Cowgill <james.cowgill@blaize.com>,
 Matt Redfearn <matthew.redfearn@blaize.com>,
 Neil Jones <neil.jones@blaize.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20240424133230.19179-1-nikolaos.pasaloukos@blaize.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240424133230.19179-1-nikolaos.pasaloukos@blaize.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/04/2024 15:32, Niko Pasaloukos wrote:
> Add SCMI reset numbers according to the Blaize BLZP1600 SoC
> hardware specifications.
> 
> Reviewed-by: James Cowgill <james.cowgill@blaize.com>
> Reviewed-by: Matt Redfearn <matt.redfearn@blaize.com>
> Reviewed-by: Neil Jones <neil.jones@blaize.com>
> Signed-off-by: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
> ---
>  .../dt-bindings/reset/blaize,blzp1600-reset.h | 84 +++++++++++++++++++
>  1 file changed, 84 insertions(+)
>  create mode 100644 include/dt-bindings/reset/blaize,blzp1600-reset.h

This goes with patch adding the binding doc.

> 
> diff --git a/include/dt-bindings/reset/blaize,blzp1600-reset.h b/include/dt-bindings/reset/blaize,blzp1600-reset.h
> new file mode 100644
> index 000000000000..c500c2b0690c
> --- /dev/null
> +++ b/include/dt-bindings/reset/blaize,blzp1600-reset.h
> @@ -0,0 +1,84 @@
> +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
> +/*
> + * Copyright (C) 2023, Blaize, Inc.
> + */
> +
> +#ifndef DT_BINDING_RESET_BLZP1600_H
> +#define DT_BINDING_RESET_BLZP1600_H
> +
> +/* ARM SCMI resets */
> +
> +/* BLZP1600 reset numbers as defined in the hardware architecture */
> +
> +#define BLZP1600_A53_C0_HARD_RST 0
> +#define BLZP1600_A53_C0_SOFT_RST 1
> +#define BLZP1600_A53_C1_HARD_RST 2
> +#define BLZP1600_A53_C1_SOFT_RST 3
> +#define BLZP1600_A53_L2_CACHE_RST 4
> +#define BLZP1600_A53_DBG_RST 5
> +#define BLZP1600_GIC_RST 6
> +#define BLZP1600_CRYPTO_RST 7
> +/* reset 8 invalid */

Same concerns.

However another problem is lack of users of it. Your patchset looks
random - this goes to subsustem, but there is no device binding, no
driver, no DTS. Could be result of lack of threading. :/

Best regards,
Krzysztof


