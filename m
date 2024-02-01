Return-Path: <linux-kernel+bounces-47955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C65384552D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97F55B25921
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B584DA1D;
	Thu,  1 Feb 2024 10:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VkaeJJeM"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C12E15B99C
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 10:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706782935; cv=none; b=WASxDh7XskgvEH/hu02cjDsNQ+EwFq4UVghaNeUKdzhYpHGhgzqR002kEjaC7MpMSUof/cLNYh1GOVwrWN4VvVRIaWSAchwz2aEQEf+F5hWa0x6+6fQahDxNlWvZWBUr1iSIZwrkKRtlo/EZo9YbdcsDQ3XlGV7BquncC4ZA3Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706782935; c=relaxed/simple;
	bh=U2M/5VjfZroqlBAA+pCyLM/Bh/kzwKLYBNVqZQrwV6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m4PnHs6ci5omY3fQ0Op5XWe94cDL7PP5/xsV3JbfqsKWjdC4ISHJFoaFoS5zCAMt7MWkbprhrhKi9KFlVzsJydv8ahrI7x/fCSwfKe03BhHGBWXajx9FmYmxOySzSIb1hW0DQCjBlbVBl7mfOz7sU8QBsFH9eHbbF4v+VD+8DwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VkaeJJeM; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a26f73732c5so103240766b.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 02:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706782932; x=1707387732; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N1dWG3aU2KUqi5LvwiCZ7SXAnfblbf10qXS/8UmvwJY=;
        b=VkaeJJeMQgibKRhlBBewNQOkVs96ZV9hIx9S4IKCLd6QhEiX2wlXpvXyhGhA59wyv0
         ukgu63z6RRJtWAFkCJxq93nmEwXnozkKLEW5Uiq+OTaqAjTAtVni5tNnQ9pSHKM1qurc
         MJk2sU9JTampJqDG0MjGHCY2nqCobyDzncCT+jv3BDXb0rnAf2Z0LrDO3WZMNJQmMg2G
         1GaYY86UU0ZD3zP9dECv/RcfVqESE2qZDWnnMwfd/HfkwljTrLBjyLfQoM5RogyTiHtq
         ydjmm8wIRLeIc/xDbBIYdaG4Zzx+Gp0N1EO1VY8isMOCxLziA/3c1v4Opb+6cdtly6gR
         KuRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706782932; x=1707387732;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N1dWG3aU2KUqi5LvwiCZ7SXAnfblbf10qXS/8UmvwJY=;
        b=v3O+E+TXpQ7HNxVJPbGc6VR6mnqQ4g5+I5IKyQ+IziuXCASRKxZZ+jypbBtSHZIrvz
         W+foSRGHdoXF8t/LOKQdVlcpIyc+iFOY0iYJ5WktffNJ9JmnmXTM0y3s6d2xIztpkAGm
         pduMGJi/q3WeFM3Rvikkqj/4mpFJySYZOTc3M7F7W7q1+lc++5HCuLIJoJqyqmqnpz5t
         iwegZtISulFuE0PY7Sh8MQxQmyuuVFV8FFKXI3C/EFJ7LDuf8l+nVXX/UPADj1HSpa/u
         gADBb4eGupD54Ct/CRhu1QyLLGOByD6uejNdf4rEJAe49LCtd/qfu5E5RkqVVznFS0H+
         1e7A==
X-Gm-Message-State: AOJu0Yx2x/ggNoUSI5bxLT1OureIxu1Z+b5oXaiZiBpeKP0/CN+VnwkN
	pBOoKxs/rurSuXRYNO96ey0U5BA2uhAJgTZ95ZyiUit4ZvFr6YpcPHKvT02DDdI=
X-Google-Smtp-Source: AGHT+IG+1ffvQtGV4A8q1007OBt+gGwIH+8e2bbFpd49ECS73rLqb7hhfM72nz5L3mDSytR57dn2jQ==
X-Received: by 2002:a17:906:7d0:b0:a34:b006:72ce with SMTP id m16-20020a17090607d000b00a34b00672cemr1249488ejc.44.1706782932190;
        Thu, 01 Feb 2024 02:22:12 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWmPhpTsoAra4GT6fX3p54Ns8C7lT6HXZMvYxOaMUYoQxQyxtXkaSv/bdEb/2nu3YnL280elaCLsNdunAmBEbJYdcqIxXPgkZQDqxIv32N4XXtUf/Z5e8cmvclDTUy6FgzfPpBeQa4aIxgypBBKizLaXPYtsLp8S/DzNNGSPQDNbKCtfGj/awoAO9zG4e/s/vX83TzGqAIZFR5GnwWNQbHN3jACrvuf4ZlJvYwBYL3qcbri1wpJSlWbWRvSFObqgsd0f8rF70FPW5BWvqEF/mnJytLtfegKhykwBUsZ8MQiWpNsd9xE/fFBT+wOGhaLuklsxW5nJqPQHN1V3eWgAU1SdH9jR5kNOLBczoHePQu1LGRv7TaJEIAFi8WZHtEtGiLPGp+KgFv0EWLt71dLba6OjIedNN/4PxgJTJkQjNk=
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id vo5-20020a170907a80500b00a3689bde88esm1213314ejc.153.2024.02.01.02.22.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 02:22:11 -0800 (PST)
Message-ID: <1bcba074-0fd4-4f0d-997b-a0c8e5d881cb@linaro.org>
Date: Thu, 1 Feb 2024 11:22:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] ARM: tegra: Add device-tree for LG Optimus 4X HD
 (P880)
Content-Language: en-US
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Thierry Reding
 <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 Kees Cook <keescook@chromium.org>, Maxim Schwalm <maxim.schwalm@gmail.com>,
 devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20240201092033.10690-1-clamor95@gmail.com>
 <20240201092033.10690-4-clamor95@gmail.com>
 <523895fd-5a7d-4467-9a51-b5f85668f0af@linaro.org>
 <CAPVz0n3VnEAxHviOF1RVzMybVEe=BdMcpPFpZXvpoU7HizTNog@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAPVz0n3VnEAxHviOF1RVzMybVEe=BdMcpPFpZXvpoU7HizTNog@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 01/02/2024 10:51, Svyatoslav Ryhel wrote:
> чт, 1 лют. 2024 р. о 11:22 Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> пише:
>>
>> On 01/02/2024 10:20, Svyatoslav Ryhel wrote:
>>> +     pinmux@70000868 {
>>> +             pinctrl-names = "default";
>>> +             pinctrl-0 = <&state_default>;
>>> +
>>> +             state_default: pinmux {
>>> +                     /* WLAN SDIO pinmux */
>>> +                     host_wlan_wake {
>>
>> Not much improved around this.
>>
> 
> All existing tegra pinmux nodes are bind this way. Ask Thierry Reding
> about this pls.

What does it mean? Are you override node or not? If not, why it cannot
have proper name?

Best regards,
Krzysztof


