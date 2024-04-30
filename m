Return-Path: <linux-kernel+bounces-163510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2288B6C52
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC1601F21F16
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 07:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24E640BF5;
	Tue, 30 Apr 2024 07:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uf3+Na7u"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2723FE37
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 07:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714463939; cv=none; b=pUIje9hHghZ7yrvGaBDR8c9AouO+gRJcEMKcHM3WfhLfu+qZ5ViEM3nf2JhlCUUKVhVdmK/tLRXUd1R6kKSxXL871+szQr1qhPXZivTiLzS35r4PjGfRttAABF2qOGTTwYBp7QWmB5Ps5ATdy+aOOll++ukoB1ajogfWxB65L6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714463939; c=relaxed/simple;
	bh=hhKHIJC6+whpa+tQuWvAtS2rmhpOqavtc9tfLnFqM30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lfZAb0vWAJfIA86HqvWb14f2DEQMt+LgEnDEO42mv9Q6/Q69JKVCQPdccja7JnPESTztZcXhJgCpIh1bKw5ms2lnnV8r6iPEF/qQn01RG5W2dsVRpJ6h8z1KQ9tAmQgXitqDQSnyXh71BjMTa4tuWcmDKY2YMmKJ82Fpcwz2CC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Uf3+Na7u; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a519e1b0e2dso727645566b.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 00:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714463936; x=1715068736; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ndVw2ElrESy+7IyKTzMceMe7Vd6EB9jr3Li9gLFc5Jw=;
        b=Uf3+Na7u/HWSK8UQb/IJ0dv9sgaG4tvT+LwRF8KsUSASW2QVrUWUANXkpoQNUxoK1Z
         vn5X0A2tQzukTyLCl547JiDKsj9tVGgrbWxRAc5HqxtlVDt/0uEkvtMmNx863biU/Mme
         2TFQ7sMqLy/qgrz8zqdHa/3Z7Mt/QQ0l9Y4JmOHvI7grg9FU/7/5bZvCvGPtFh8XK6lO
         2BKSpgGiLZVSbD/7O2ZdwHBDmFiVvIARqcT8sLt1uScr7ikUnRmb7J/C1CIeyH3EqmNF
         PcGhr8hq1eHYyQTYUn2TZpCJGUmdx6MUb5BVahWVlH7Pb9hR/k6rrRhVCPMrVZwLpNI+
         2h2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714463936; x=1715068736;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ndVw2ElrESy+7IyKTzMceMe7Vd6EB9jr3Li9gLFc5Jw=;
        b=ijRQbeXakdTsUck80bNK5GoXAU8ld1Vkf6tNQswX0Fm58hhsBUiDB2bjmPYgIr4I7Q
         XBcvk+vx2/aEv4JMMgNts1ruzIGw6pUdmJiq5ZMH7jYQFoqRLLuap4xaEwO456oNv6GB
         GCUN0nmbtv8vuN7A6I7IgU4ka0BCgHVFyEKp5LRF9paMRxmk4y86QhBvfHen/xSQtcGr
         /mZ9hzeiIMQAvddo7dZHNevczsugEZQbBNuSFSE6UdGL5FrQ2Nkq+J9zqIBk8JNkhRmw
         GUY5m1DC57Yv8u8rBVkGSnDWf8H1RZCz5jAzuP7zNWFYgg0x3QUm5FTbzFOTSrcEDkha
         L2Sw==
X-Gm-Message-State: AOJu0YzQ3JX7zrmV65FWvBSR9q0jlywfb/6Skb77K54P0kIs+TqcFIUE
	6funMmateNJHsKUHplk/46qGU9qpZBeWXmjHrJjyPvd31gk3oV6g3rnv49lQ+/RmLRk6MI5z518
	qe4A=
X-Google-Smtp-Source: AGHT+IFtNTiVmObbrSHEi2FaMWq9W2qGkl5bUdGZaWud+Aa3pxe75uBgXT4XNaUqOsCWv44IsriYcg==
X-Received: by 2002:a17:906:354e:b0:a58:ee74:be38 with SMTP id s14-20020a170906354e00b00a58ee74be38mr5977807eja.17.1714463935701;
        Tue, 30 Apr 2024 00:58:55 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id bt15-20020a170906b14f00b00a51eed4f0d7sm14835811ejb.130.2024.04.30.00.58.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 00:58:55 -0700 (PDT)
Message-ID: <fb5a7670-0a52-4f15-8029-092ae0abe98c@linaro.org>
Date: Tue, 30 Apr 2024 09:58:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH v3 2/5] spi: cadence: Add MRVL overlay
 bindings documentation for Cadence XSPI
To: Witold Sadowski <wsadowski@marvell.com>, Conor Dooley <conor@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "broonie@kernel.org" <broonie@kernel.org>, "robh@kernel.org"
 <robh@kernel.org>,
 "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "pthombar@cadence.com" <pthombar@cadence.com>
References: <20240329194849.25554-1-wsadowski@marvell.com>
 <20240418011353.1764672-1-wsadowski@marvell.com>
 <20240418011353.1764672-3-wsadowski@marvell.com>
 <20240418-sacrament-cornea-fd6fd569827e@spud>
 <CO6PR18MB4098C815325699975B1BD794B01B2@CO6PR18MB4098.namprd18.prod.outlook.com>
 <20240429-quickstep-hypnotic-5b8d1fbeb920@spud>
 <CO6PR18MB40985FCD4A28467DA36E07C0B01B2@CO6PR18MB4098.namprd18.prod.outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CO6PR18MB40985FCD4A28467DA36E07C0B01B2@CO6PR18MB4098.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/04/2024 00:59, Witold Sadowski wrote:
> 
>>
>> Confusing wording aside, using the same generic compatible for different
>> SoCs is what I trying to avoid. I don't mind there being a fallback
>> compatible that's generic, but I want to see specific compatibles here for
>> the individual SoCs.
>>
>> If you did actually mean that only the packaging is different between the
>> devices, then I don't think you need specific compatibles for each
>> different package, but you should have one for the SoC itself IMO.
> 
> We can have SoC A, B with common xSPI block, and both of them can share
> Same dtb node with compatible property "marvell,cn10k,xspi-nor" for
> example. I don't think it will be beneficial to have different compatible
> name for each different SoC, for example "marvell,t98,xspi-nor", if all
> other parts will be the same. Or am I not correct?

Please see writing bindings (or any presentation for DTS and bindings):
you are expected to have SoC specific compatibles for every block in the
SoC. There are many examples in recent bindings, so take a look there.

Best regards,
Krzysztof


