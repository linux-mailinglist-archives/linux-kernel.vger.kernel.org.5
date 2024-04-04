Return-Path: <linux-kernel+bounces-131239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C07898505
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 188D8B21614
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB6A76F1B;
	Thu,  4 Apr 2024 10:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ohci9FTI"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD7A26AC2
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 10:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712226713; cv=none; b=FMM9O3RSuEmM6A28mchLhl667abEmTaCs2i/o/e97OOI2lQykHAQSNMvHPkX4CkdYZslDSP8QQ/fYDRczMhnH2pmZimtlrGuw1LIY9KTWODpnDVo2aQL4IRU3O1a0mWZgrC6naaJ+4oK0p0IwPVoqHjL93SBiRIbOyGKtGu6sdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712226713; c=relaxed/simple;
	bh=kclDvjc/IkpTFcFaLKLNXo4JHCk88Y92ueEN+YD7Gwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lWujsy5r9zZRYqXPAcvtwM9byM0ZnnlfU06/UgA0uFMu6yYWfDMDMUVrRQUq0olfMP7unl8OgvY9PvmgAsr6rzweOhWvE9g10w5tj8wGSivsfqu707UWOt84Ij3Qq+vVj9fUnMiUAbQUVlOhEsW0SgoU3jkyh2i682j7m7yU11Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ohci9FTI; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a450bedffdfso108811766b.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 03:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712226710; x=1712831510; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ejfPUiMbZ+VXCFA0N0LIaJrBvhVfb3UObLj4vbm6hQ4=;
        b=Ohci9FTI+fMzcwNEJGV/Jf9OQnYCKKGEBwoN2hF+2AROY+fvpDdHNZwJxeLUyL7urY
         oeMgarMBue7C4qI6+RVW/A3E+BedA0b6bvZjA1oekD2ItuI5f2hByc1NzctQ63wXn/QY
         OnWwObDHeHdRvOWqat2EfZWpu4NE45HetMiDbTs9ZT/Y4Q7XmEwIypV7MUjKDpL39KGX
         tyTEtwsc7X26+uDFBW365OsTvAdDyFcI4zkpIQt6RiHtHMjZdvvZHi58ldtT6rXmRVim
         G4/djmN+fmvdior1VkleHPg0X3Vbwc1BvQ4Td7mwtvtICCo0RogRtLVJMgRlTiR6m63m
         hCmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712226710; x=1712831510;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ejfPUiMbZ+VXCFA0N0LIaJrBvhVfb3UObLj4vbm6hQ4=;
        b=C75R857yMBIsQt2A9m2YKvnSFG0FG+gIlD8lJQeP6Ec3sHx6Eax3m5Cz73eakRAFOg
         cAb6jNngqbY2iPL5hRxCbu1yk+YBb1xKR3tM8NDzC758bPMOuxJ6FRaR0zR6+1pO3GpQ
         1YeQ5lID+Lk0Xj/NZwys8zNkF1w5j2cusAdXm4O+77dKwz46tiejJQJ8MU6O6hDPsNDo
         dku7jW5Xelz6BKhvLM2Bk8ia5GAb9tcHGUAbl0D8mDXu0IjfrRr1TUBsDYbzB6DO0KI+
         aenzyNEM5AxVXcHIdL/aOVPlMmPIBTc+SkWIbky3+Qyx6FwGoco3gUqnjJRpSsvhPV5O
         o1IA==
X-Forwarded-Encrypted: i=1; AJvYcCUksarDXXiuqt1xM52mTuW0WYZyYPK5o5w54z6C5gPxwu+zCEl51h9FoKA8xKf4Fwd+4GD4ixettRGgNRqcMI17GLJJmgk+GYNO0Pnw
X-Gm-Message-State: AOJu0YxnsX0nCo50n0uhK+NRB7ZzaRSJZkQ+fgli8NPW/jbeaO9sPUAY
	QIAzMBoKhtbdU0W4CNSJeQtA/tWY9e7qNPWn233yM8VyuVTGeKxnDGaBCgOh4Lw=
X-Google-Smtp-Source: AGHT+IGf+SuhD4QMbKzZLyX+b2w938/WHZgqqWnUuEVC+eYR9iyY5YI6eNyEfU0L9ojnOZ5u+08JLg==
X-Received: by 2002:a17:906:1999:b0:a51:9149:29d2 with SMTP id g25-20020a170906199900b00a51914929d2mr469709ejd.6.1712226709906;
        Thu, 04 Apr 2024 03:31:49 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id g4-20020a17090669c400b00a4673706b4dsm8899480ejs.78.2024.04.04.03.31.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 03:31:49 -0700 (PDT)
Message-ID: <e80f2073-d5b5-40b2-9a48-bbe29e84d17c@linaro.org>
Date: Thu, 4 Apr 2024 12:31:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am62p: use eFuse MAC Address for
 CPSW3G Port 1
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: afd@ti.com, nm@ti.com, vigneshr@ti.com, kristo@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com
References: <20240404081845.622707-1-s-vadapalli@ti.com>
 <18eb0e55-38ad-44f9-90b7-1917d8c0d5bb@linaro.org>
 <75b53dda-23aa-4915-944a-4d9a619bd165@ti.com>
 <903ad855-ab26-4ef3-80bd-249917056188@linaro.org>
 <a0df1035-8616-413d-9058-e6163bdf06cc@ti.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <a0df1035-8616-413d-9058-e6163bdf06cc@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/04/2024 12:16, Siddharth Vadapalli wrote:
>>> I was following the convention that other mfd-syscon compatible nodes
>>> seemed to be using:
>>> https://github.com/torvalds/linux/blob/41bccc98fb7931d63d03f326a746ac4d429c1dd3/arch/arm64/boot/dts/ti/k3-am65-main.dtsi#L502
>>> The node is:
>>> dss_oldi_io_ctrl: dss-oldi-io-ctrl@41e0
>>> corresponding to the compatible:
>>> "ti,am654-dss-oldi-io-ctrl"
>>> which was added by commit:
>>> https://github.com/torvalds/linux/commit/cb523495ee2a5938fbdd30b8a35094d386c55c12
>>
>> So if that one was wrong, then what? I don't know really what type of
>> device is it, but just because one contributor called it that way, does
>> not mean you should keep going. Maybe investigate why that contributor
>> did not decide to follow Devicetree spec recommendation?
> 
> Yes, it doesn't justify the convention. I seem to have picked a wrong
> example when figuring out the convention for naming the node. I plan to
> name it as:
> ethernet-mac-efuse
> while retaining the label "cpsw_mac_efuse" since CPSW is the name of the
> Ethernet Switch on the SoC. Please let me know if it is acceptable. I
> will post the v3 patch based on your feedback.

Label is fine, there is no restriction/guideline on labels, so choose
descriptive or something useful for you. Just the node name. If this is
syscon, then usually system-controller. If this is efuse, then maybe
efuse, even though previously I was looking at this more as a syscon.

Best regards,
Krzysztof


