Return-Path: <linux-kernel+bounces-97873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CAF48770FC
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 13:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B5221F21673
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 12:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DC239ADF;
	Sat,  9 Mar 2024 12:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u9SXPXEe"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A216D38F83
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 12:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709986277; cv=none; b=cXLM4cn01BzPJFOqvEsGMg3qJ9ZAKxQ8h7/7SVjKtmj4Ezle+Kyzr+uthUNlPiC6kvEKpUOBI/kR4cth5SNU+YAH1MUUJPK2KYiFXDWGd70WaOpQjoeMYrUVP48lA5tlbff6vpLsjGVhU6SZSn1B6xveQTTPz6XgP8Kt/VJpJ+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709986277; c=relaxed/simple;
	bh=koasVkCLRizGMwk1JC6HI9AI0tvr26xMWf/HNQ+6SuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZMRWkBeHBdooPkT4JCKz3su5ih5r7Fl2q1/a92sja/W4OdZCocv59fCv0xRcCqoWCxktwLvhy3kFMp3P9qclkpyHi8a/yt2lFD6Buuujrpwhnx4vB0Xo/Rc6xD4Rr/hCmh4E7QBpLM6S1G+i2PeSwy4XAVNjxVAOTN2DMTzLH78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u9SXPXEe; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-563c595f968so3708587a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2024 04:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709986273; x=1710591073; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gT7va4yT6rvggyzPqnhzPRGXMexH6gR1hGohjfvpeOE=;
        b=u9SXPXEe7W60oeF70qjp0et/R+b8gjQtgh7iNqHrhF9gRm3ubippG10a6Kl+l8Oxtb
         jFsNISo+OpjUSHZ7uVwDuimdJKOQpDR7sEIVRaA3XKTbtuRLyiilBR1/xeaXGIIx16dl
         7JDE//hdbHP7Zvo5FglDMHiqOPheUdfKPfXlKPRQmqZFsxIZ1gElUvpPtJrVFJD/JBKr
         4hgxwuLw08Lj76YVAemOIhesN6t/XJ8iEmYNc8ngHIz/0MWojEHb9VvRBywIAcig7BTz
         h9TyuTg8bko7is5Fcht2S9pSb5QhNbsm2WBX7Heu5s48/3iQMUQi5gY3hUamntIGzp3m
         McHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709986273; x=1710591073;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gT7va4yT6rvggyzPqnhzPRGXMexH6gR1hGohjfvpeOE=;
        b=vsFgj4UsLCEGHUQc2vaisKYyVyEozwabhjxvznos97lst9f+K1FhVtJ7aewTbMo8U0
         H/vkbKGujdLPeENKtrOBFjxaPU+AikqYfXjD312p5G62IEa1ufVipsi3G7MvNFxJHa5w
         Z9k7tAvPZzKclWvFYobu3GnJJ0RSPG9iukJ+79vzJKG859h2e5IAZOxH9jLRUT49pywP
         4/ASMktmateDHxt/leBu75AQdrw98SO0cv1ypmKojCkgvGgD4KOIcHoTmHxr/XFN8Rbb
         BYKvXlBNf4SRnnwkB+JQolNkgEjpr3Sjqe1PlHF4HqhgIvY3S2EqHXuB+pR3ZItyVr2Q
         zApA==
X-Forwarded-Encrypted: i=1; AJvYcCXbER63dXmZEaFjDHNvSEGgMJJ746I06m4vET7BRYueZeGZJ8kWjJqB7n7RrbfoHt4FKqwBW0yy3BgRqU0j0yLXnIzoysHPL7qKvR2k
X-Gm-Message-State: AOJu0YzJWio8AHpWzZqsMlzPy/9hZia1Bc+zOW3qBt8GThRtbLAyF/0I
	1xoS9SHp8Pi+0cCsUM9At/fETf8nmFYrZxeQSgsY+t6Af1XKA7QBKw6cVAivRYQ=
X-Google-Smtp-Source: AGHT+IHhqrnyZB+1x1fGs1J3Z96cKmAEk4LVOPLx/Ohty3mQ9EjJdVq9cKnRPZqMfxEcNPOuuIM+ow==
X-Received: by 2002:a17:906:8407:b0:a3e:9def:5c8d with SMTP id n7-20020a170906840700b00a3e9def5c8dmr864568ejx.28.1709986273017;
        Sat, 09 Mar 2024 04:11:13 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id lg12-20020a170906f88c00b00a4432543b21sm819598ejb.198.2024.03.09.04.11.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Mar 2024 04:11:12 -0800 (PST)
Message-ID: <e70a3c8b-d7c6-418f-baad-fcc1414da3cd@linaro.org>
Date: Sat, 9 Mar 2024 13:11:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] dt-bindings: qspi: cdns,qspi-nor: add
 mobileye,eyeq5-ospi compatible
Content-Language: en-US
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Vaishnav Achath <vaishnav.a@ti.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>
References: <20240308-cdns-qspi-mbly-v1-0-a503856dd205@bootlin.com>
 <20240308-cdns-qspi-mbly-v1-1-a503856dd205@bootlin.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240308-cdns-qspi-mbly-v1-1-a503856dd205@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 08/03/2024 18:18, Théo Lebrun wrote:
> Add Mobileye EyeQ5 compatible.
> FIFO depth shall not be passed; hardware can detect it.
> 

Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching.
There is no subsystem as "qspi". Also order of tags is incorrect.


> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> index cca81f89e252..cf7abf48673a 100644
> --- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> +++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> @@ -61,6 +61,17 @@ allOf:
>          cdns,fifo-depth:
>            enum: [ 128, 256 ]
>            default: 128
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: mobileye,eyeq5-ospi
> +    then:
> +      properties:
> +        cdns,fifo-depth: false
> +    else:
> +      required:
> +        - cdns,fifo-depth
>  
>  properties:
>    compatible:
> @@ -74,6 +85,7 @@ properties:
>                - xlnx,versal-ospi-1.0
>                - intel,socfpga-qspi
>                - starfive,jh7110-qspi
> +              - mobileye,eyeq5-ospi

So everyone adds at the end...

Please put it after amd. With subject fixed and above:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


