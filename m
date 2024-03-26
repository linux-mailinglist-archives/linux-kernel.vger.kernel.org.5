Return-Path: <linux-kernel+bounces-118902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C477488C0EA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A9EF3040FC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EF46CDA0;
	Tue, 26 Mar 2024 11:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jcwkBP5G"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E04679E5
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 11:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711453018; cv=none; b=fUa9vO07rbNRt7wDhcM+AoZWsX7DeH+YxEGLUubz31y63Tq5pto3b7nKhQoF+z4c8C4CkZ4KOlotigi/tIdC8nTBDVCO0s1M4soCA0GPNFe/Zsxc3f7/SubB90zDJmB/dS+TIdK1r803UhUDdCmccnQu0sMrl7lBh55nY97bC+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711453018; c=relaxed/simple;
	bh=d+zcnRYA986HEFjskgNZB6lfW0d1DX53vGBsO87NfCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WpF+zEACy+uWqKzmDUs17f7wMqvq7FTg6F6AAIsNsu3zoZ1mSW2waYcdNH/feiZ39J/32rbcOLjy/YjPaW0NU++D/B5hGyQnKQw3rhM19cncij+o6o9egn747VpNnA27pYiTvFg+FaQTsErf6V2Ciz37CzdQTm6L93QqnjSUBM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jcwkBP5G; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56c12c73ed8so2451656a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 04:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711453015; x=1712057815; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/MO23cTCZl2VkaX9Q4Bf8Z+K1+W2X16adrpEco2FUHY=;
        b=jcwkBP5Gvgm8bK5ctUDxh+VYqLNH3lqqK+CRTQEoQz/044OEZ0Xj5Ws3F8SrQFxbx+
         79wMNychj4cQRDxkg/+PzLLuYffRF/T0VrqNzCtzeCHgmW5k3BLcwwxcePCQidBopd/8
         whFfnlYfc2Cm79PEd2fWD+u9Iv5yP3FaspuN3B2TIBq9CCjxgUuufDg9ZbW8sDYVhCj+
         STImBLL0ErfzllJqet4bV5EdLMkE1KOdNrZHnjkowecw8AjRlzWh3LO3nnz3WPdF9BUu
         F9w1xeuXYZQxzZmotfo+y9TfLv+phpPY5WOq1zxxgCpf3kTGiZcdc4YtcfrpMs6NhAn2
         huDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711453015; x=1712057815;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/MO23cTCZl2VkaX9Q4Bf8Z+K1+W2X16adrpEco2FUHY=;
        b=JNtRZUWnmTbTuicGf0q8VGF3OxQOn8AsyhzgCvux6473bfixL5INGC6gN8JHfxpoz+
         1ADj6YQlnxHfFyrEKqFwEAmIj5ho3Jddy9C3b/bI41BmdVZX8c9fK3wf1GOGfW1Z6DLv
         vBBKw4X5KYkxPM8NCHXqIuPGrV1wJcp5o/coEkHCihYErnUbWh1xi9/c5Z6wN7Th0mPv
         5o+zGUY5Q8tNKhCw4Xh0Tu43aZHyqKrifShVgvaU8+lmi73Wkb/BmqBgbomzvvePFuGL
         llpFjdvDyxsNzlmOqqt/IdoztZ97ZgMrb04mxqbskBjJLREFjd4wbvY0OkB++BA/lume
         RpPg==
X-Forwarded-Encrypted: i=1; AJvYcCVy8gO7xnwVzAqPoz8LNEsnkCR2pAIT8I7eAwCOsYOj2z8EzGHOYg8jBSaAfrLRoXAZVPGyvsRTTO5ZZ4p1CerwW/SSCFWNQFvlaIE9
X-Gm-Message-State: AOJu0Yy8Y50kwHl822H5iEVJ8pF/3lPPV6nN9lEixy7gmx0BrZvcAmrx
	rf8vs6GK0xU3vSNak9FbL03T3Dca3RdsnBbZHvUQ48menZRVAzcN1KZQaPJuxB7kFoAsZV6uWp6
	3
X-Google-Smtp-Source: AGHT+IGsaCkiFSAJXRsLHPZz4DsVmUb3tHnSVxaNfe9BxvlYFvb/PqEId/8gllBS0u5njxDw5d+rhw==
X-Received: by 2002:a17:906:a94d:b0:a46:36ee:cfac with SMTP id hh13-20020a170906a94d00b00a4636eecfacmr6440245ejb.77.1711453014298;
        Tue, 26 Mar 2024 04:36:54 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.44])
        by smtp.gmail.com with ESMTPSA id lv16-20020a170906bc9000b00a464f709687sm4116229ejb.59.2024.03.26.04.36.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 04:36:53 -0700 (PDT)
Message-ID: <32cd6f33-b4e9-4b7a-bcea-b1f2e421d67e@linaro.org>
Date: Tue, 26 Mar 2024 12:36:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] dt-bindings: arm: aspeed: add ASUS X4TF board
To: Kelly Hung <ppighouse@gmail.com>, robh+dt@kernel.org
Cc: krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, joel@jms.id.au,
 andrew@codeconstruct.com.au, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org, kelly_hung@asus.com,
 Allenyy_Hsu@asus.com, Rob Herring <robh@kernel.org>,
 Zev Weiss <zweiss@equinix.com>, Conor Dooley <conor.dooley@microchip.com>
References: <20240326103549.2413515-1-Kelly_Hung@asus.com>
 <20240326103549.2413515-2-Kelly_Hung@asus.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240326103549.2413515-2-Kelly_Hung@asus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/03/2024 11:35, Kelly Hung wrote:
> Document the new compatibles used on ASUS X4TF.
> 
> Signed-off-by: Kelly Hung <Kelly_Hung@asus.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>

Where did it happen? Where did you receive this tag? Please provide link
to lore.


> Reviewed-by: Zev Weiss <zweiss@equinix.com>

Where did it happen? Where did you receive this tag? Please provide link
to lore.



Best regards,
Krzysztof


