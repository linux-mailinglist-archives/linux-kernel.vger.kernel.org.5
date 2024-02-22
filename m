Return-Path: <linux-kernel+bounces-77126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 295B9860177
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D427B1F236BB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A0014B817;
	Thu, 22 Feb 2024 18:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H1m+0TQz"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2797214B80B
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 18:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708625961; cv=none; b=H5A+VnlooDTahTVhwq1dQ2ofl1x8KWAhs2pTSGeJGuAsAc86izwLEMa0wuc9hE4kZpFZObxwtuDi/kGNMlTt0TyE6RIZx2bhqMtyqWDlTGMai3ZvYamNS09+w5KbUIt+hdoPXOS4KoyOV/Z3JnhOFHByKKh6GgW62e9AswEzAqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708625961; c=relaxed/simple;
	bh=8Lm3P+RDepHiTO8L626GHQbPCca4fo/i8jkGkEUCadY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VqIAm2dkanTZqTOr7hIJItaKl8Tbosil3qGXljkppkil6o4yCa52c9BFCvTfecbhjk7P36onhkBgALy2xE2YPKbsekrDKXrxbBYKeLGGpUDn0wiJ5FlShI79aItBZsiR7qhVbH4g0PPLAAbEjWvrENgqW2USmY1q+rB6kHV3o0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H1m+0TQz; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a3122b70439so1435166b.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 10:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708625957; x=1709230757; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fnt7mBEcQTg1itf/UcmVLmTBAuiQOtUjoqGvfpujsU4=;
        b=H1m+0TQzXaffHGVnhKAlWGPADS4NFrco1V9FUtBi6RWt3rSZNPldOZK3hk9FVa67tO
         TZ+zIpDRTTQqQRisk/gLc0wrb62RdjmQ7eNjCSWNT6zCZBpXUZk1LLTf0vCaFmnwRCW2
         M5/PlLzmknh8VPej+WG34a7qqay6PJKsqC+c/TNdVjWflWIEAt8q1Iiex2zkzSSo4+bZ
         oUEfiUR9qa20cXYKnMvEShhybqCxwHQSRKy3q4QvzT7XFW5xbj0vSckq9/Ci2noSuz1K
         CDnXihM2kNs7ECGlhWVxoJgrhw++rjkmkb1gbxeYcLf6IwA1UdNO/qBBDwidVVUbmLnh
         mw3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708625957; x=1709230757;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fnt7mBEcQTg1itf/UcmVLmTBAuiQOtUjoqGvfpujsU4=;
        b=RsjUlb80Z7BWP1t71eu5SiYJy3LcSnVyKU+ZA69LtRkoDjQSQGhvZrCzerkGqGv5Ci
         xUSR5Lxw3k9043X/S5WspvAfRXF5kBalxWX5BfFQhcsB4dzrz0IAvIRCf6bVMZCQqPb9
         XGldlWxFzuPHKcbcPqbnsYNnUT9gBUIj63nx42o1QKNdgJAEBbOPxnZKoTkDFfsEvD2+
         qEENMVJp0aKcoabZywUoErnEV0xecifW9ZmdbMVOeMwQgylAlEdH3nSqHBKQU9Qkev3l
         7edSgL6XDNak45Fb4E0ngMMD41h6XWo3lnw6N0khHNfyraEG7MIpEGRtzQSleZsZTQX8
         faQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHcnn5/e6biqog20A5EjPSrfZistR1QdRITOabFnPuT2ZgWd9Ikffp0/wh5pMUE64dbI49W2uuCspLRsn9FkLXuwCb0fOJtP5X/l/V
X-Gm-Message-State: AOJu0YxDOD+nY1WWdqQK1dhk55ScW7I8u9gqlSWfwFheXqTMsruUWZdD
	5QA9joXaXWBvTZN/p6yfiRJCmpGRrZ1EN1OJ6VBAy0gtrElO2/3zkqjbkrKoJ44=
X-Google-Smtp-Source: AGHT+IGt759iDgX+1kiQPkkQGa4sZQSdTpZEZf451omHQcL2RwDX8ZdPK9kXpIYsnquNTOvEw8AEEw==
X-Received: by 2002:a17:906:168a:b0:a3e:f04c:5dfa with SMTP id s10-20020a170906168a00b00a3ef04c5dfamr6718126ejd.62.1708625957604;
        Thu, 22 Feb 2024 10:19:17 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id j20-20020a170906411400b00a3efdb625cesm2762457ejk.124.2024.02.22.10.19.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 10:19:17 -0800 (PST)
Message-ID: <b46048ee-60d5-4f3f-8267-c977e912da28@linaro.org>
Date: Thu, 22 Feb 2024 19:19:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/8] dt-bindings: clock: histb-clock: split into two
 header files
Content-Language: en-US
To: forbidden405@outlook.com, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: David Yang <mmyangfl@gmail.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240222-clk-mv200-v3-0-f30795b50318@outlook.com>
 <20240222-clk-mv200-v3-3-f30795b50318@outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240222-clk-mv200-v3-3-f30795b50318@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/02/2024 17:41, Yang Xiwen via B4 Relay wrote:
> +#endif	/* __DTS_HI3798CV200_SYSCTRL_H */
> diff --git a/include/dt-bindings/clock/histb-clock.h b/include/dt-bindings/clock/histb-clock.h
> index e64e5770ada6..56b39eb99d2c 100644
> --- a/include/dt-bindings/clock/histb-clock.h
> +++ b/include/dt-bindings/clock/histb-clock.h
> @@ -1,70 +1,13 @@
>  /* SPDX-License-Identifier: GPL-2.0-or-later */
>  /*
> - * Copyright (c) 2016 HiSilicon Technologies Co., Ltd.
> + * DEPRECATED
> + *
> + * Each CRG driver should have its own clock number definitions header file.
> + * This file is only reserved for backward compatibility for Hi3798CV200
>   */
>  
> -#ifndef __DTS_HISTB_CLOCK_H
> -#define __DTS_HISTB_CLOCK_H

These should stay.

Best regards,
Krzysztof


