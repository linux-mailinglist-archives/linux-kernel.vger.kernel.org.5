Return-Path: <linux-kernel+bounces-98160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BB08775D6
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 09:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23C13B20EBE
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 08:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00861CD3A;
	Sun, 10 Mar 2024 08:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yWrr1y2F"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B9E17758
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 08:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710060018; cv=none; b=lvXDop8jzIvQXUN8f0yuU8Ny0LXP8DycQR0X/9TvJMMlX86xMDzrk0x48TOPP2sr/6xmFh0j7mFuw+XZc6/gFFfrIh/jw6P6QeT4ZrthDfVXWQ8/j1vx3ldnwSRutgXSFHfjYbr/vO+aBEHOhCIULuMfR9ZxpqHlZFJQX8YwbpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710060018; c=relaxed/simple;
	bh=l09NvDnufSejDgbUZSC6DKpjR8j2UlyS+Cpr4/3LZAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CNBCl607yHpoTEt9SlBtEjUpNt7+KAUCCwTkNfWRXWa0RiCYhaQOJmbdTW9tY3nxB1Nw9Kf1dD0y9Untlb78fN0XajreHC5Dr3Uq79qVxztTpHNgSI+FWj/KyA/g40rz2B5oTpHHzr0nYKf5pwE+SoJiX6FNiBJwUsqEMH74REI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yWrr1y2F; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-412f1ccf8d8so27319895e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 00:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710060014; x=1710664814; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vaRopQBYu86yvcn5SLZXjKAGYfexBOPbHPZsUxiN77c=;
        b=yWrr1y2F922VqtJBgosAYtVsKZrDlLe+SH+Q2FQlVbZuOruqf/kzCb9sevklwJ473a
         ljlXUodpG/fhqKgFuH4W2OxAGWSPbiPF5lm2jl3bnPpETKB5/LtabUhn2joaKxwmbSeh
         Ks0q5IE9dcg73UPIoknL1LF2Ll+6ks/38kZxOmvZQvF4HrXCeiEaaFQCHsUycyGXbkjX
         DXDJUpvnBjWztlYuk9fyrQjxJ6thi7pFED5zaySVInvAbp/orEKMLYszogQMa4Hra2Rx
         cOb4nWshT+S6GFEqKmDxlZZ+/3RNBK2DsI5wlYB4FZvkd35t1wVkzesijS+FDnBwWR1e
         kKSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710060014; x=1710664814;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vaRopQBYu86yvcn5SLZXjKAGYfexBOPbHPZsUxiN77c=;
        b=FWnPHDuLPDRcSWHF5oE+pWD0VFbhttelfYmUu3ZBQkLCmuu5YP6tez8UIzhGKEttlo
         J49U9olR9I1KCnpVQk5cId2Nd/aXKmQCZDImaKzBLn9+OEX+Znsi6juDp0UtM4Kc+v2a
         LiD9o9kE+tRsjCxxeioLx13YKFGSAKTFFTtUHf8zIRrwcrWNUB0crXiCqeDMNtEPC5oG
         f1ideKs+MgQLJ3O0XTNpVDSiSo0vrGRaI2liampHzTapbexJZnAEpdU2yXHXeTNWkdlA
         eOvNod1XohihSkpl3GHxIOIL0l0DaF+Kyt3hm7e/hIXDimrufVjr7N1ja78XCPVfkAXg
         LJ3A==
X-Forwarded-Encrypted: i=1; AJvYcCU5vtvisZ4Uksvdgl/nf9Ir/AFMlzXyUHlaS+0n7jvypSew2C2RaE48oAhxQDU+81CRc7dJ0XTmBF1peWqbyGy9vnxJ2JZa+zvyQpLz
X-Gm-Message-State: AOJu0Yzj5FSsT3D9Zjtmfpo1Pb+ePpfDBeZE4rLVsHac0OWwjXQokdcn
	fIGakREbxbAulZPtbQ5a6CACCaLqZkAwumLC8qPWvktyiPvjaRHXaT1AeBKxT4U=
X-Google-Smtp-Source: AGHT+IH7tj1TTeteFJBpEyRXXnZxcaVWcUnOJhxNlnU/+0ISMRzviDw4Qxm02dUqk9KICRVZGTYKxQ==
X-Received: by 2002:a05:600c:1908:b0:413:28c1:7867 with SMTP id j8-20020a05600c190800b0041328c17867mr328470wmq.13.1710060013956;
        Sun, 10 Mar 2024 00:40:13 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id q14-20020a05600c46ce00b00412b4dca795sm5138534wmo.7.2024.03.10.00.40.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Mar 2024 00:40:13 -0800 (PST)
Message-ID: <e95c097b-0ced-4beb-ae4d-5239f9b1805a@linaro.org>
Date: Sun, 10 Mar 2024 09:40:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] dt-bindings: mfd: x-powers,axp152: document AXP717
Content-Language: en-US
To: Andre Przywara <andre.przywara@arm.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, Samuel Holland <samuel@sholland.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Chris Morgan <macromorgan@hotmail.com>, linux-kernel@vger.kernel.org,
 linux-sunxi@lists.linux.dev
References: <20240310010211.28653-1-andre.przywara@arm.com>
 <20240310010211.28653-3-andre.przywara@arm.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240310010211.28653-3-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/03/2024 02:02, Andre Przywara wrote:
> The X-Powers AXP717 is a PMIC used on some newer Allwinner devices.
> Among quite some regulators it features the usual ADC/IRQ/power key
> parts, plus a battery charger circuit, and some newly introduced USB
> type-C circuitry.
> Like two other recent PMICs, it lacks the DC/DC converter PWM frequency
> control register, that rate is fixed here as well.
> 
> Add the new compatible string, and add that to the list of PMICs without
> the PWM frequency property.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


