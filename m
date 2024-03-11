Return-Path: <linux-kernel+bounces-98940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 330FE87814D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C86171F21B7F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559DB3FBA8;
	Mon, 11 Mar 2024 14:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rqiaeyx/"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C908E3FB8A
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 14:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710165976; cv=none; b=DN+Z/9bjPi+Lk8zmwan91cqVka8eTjKGMGwJqRq4y7v5YAznqDWdrKbZKEU+TSJv0Dcimt9/8fsSRTfLzwqcIzOqk9KSJX1QgJrQKD8T+Rst5JOB1Io48PHWaKWwcVVt7+2TgiC5TRpDIpiGK7MgkOb4oAMI0ad/qaxV82KfR50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710165976; c=relaxed/simple;
	bh=lgogrjy9kuME3sQy/ONRQafuDu2sN7ANTyoJLy+/q8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AO7yi1LU+jKhRzLCBKaXixO5lgH9TVE7GBlUVKl2mFFJTDBhBSrbaONy2Cf+Mvwf7ZiZocZckJOpNPArucqfao29BkjRFEyiIv0z3SEpQf+msztuwivEDGLKyIvV/z5c199KWpgsTcvdXJ9TNkR2YZb6yVz5T+1ntnjNBazE4IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Rqiaeyx/; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33e92b3b5c9so1419793f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 07:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710165973; x=1710770773; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oEfxD47P17376HaVN5QCqzhMLDLW1AovPI/CpxbhNnI=;
        b=Rqiaeyx/toJ2p9H8V5k5s2lZeXjSAfevgDrstKqf93y2dT7tIAs/iGkzz6qP0JZ3pk
         zf0eLqXAO5sz0lepKscfarucRxQGY9k2TBseTtoAi3hU/MS57cnktaPnelI25RccclxD
         5wpvJm5HZQR8tH7KkCJzplv1680GxPSHqnP4yMMfy6rG6sJIvRYZ3cAtKmqAWBJDMNov
         fRB5XkKpQhKFl0D9MTfVyePcnw1ptr6DJzcIRxDKBZrQjOiD98jsn1x4U1AXNyCHMr8K
         F1dWlUO/8i+xu0bWwPqKe1EGbaTIHlmQTGO8uSBoxRf8SfUj/0Vj+uacunpD4eahTglG
         IAWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710165973; x=1710770773;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oEfxD47P17376HaVN5QCqzhMLDLW1AovPI/CpxbhNnI=;
        b=Wn9+dx5lsFI0EFxLT0nD29CKOg4BX3WjQzK4Oj2Z5z3WJhuNLtTh5KuI5otRHI+za5
         7TVgeYEQ3mFapErIt+mZ+UM0ViIITlQI93iS0+sX/iW8iAXW0rIsG5DWa76L1hOviQrP
         MJiSLEd3/ObN3dfd/JbfhlKSM6mQCfcKqU49x6VWiHgdN+EvjOrte6GqxkwevTjqpcGV
         czP3X/82BmU1lNSHjVL3AzkoNawPeMIiDGMSvzKAsCvXoUn+ONfgxpV1fvUcDKwRdgsZ
         eruEJHPGRu/VTe2MuEexPDpYu5rB9ejMD3Lv8hXqXxMVsINDevgHywUEB69kDJ+kcaUF
         QLkg==
X-Forwarded-Encrypted: i=1; AJvYcCUw35uHMGarN6lnJh7ObQ8HzW4qHEnG6IrwkqjPq9prssYBpVYduwdJh/mLbbWXss12r0UegrFOAV/09kmhUcUZ3nE2ZzYGfZ6RPbNn
X-Gm-Message-State: AOJu0Yyv1Zav7dRVTE8bV/DTP2kR1LuMQOmgbe1n+TOvrKX85lk4DIWX
	rnaM8Ok+g3scWEPj42/6au0IPplddQJx7N+0Dj3ZhlXg04EYBYmXKVkrSz8Hxos=
X-Google-Smtp-Source: AGHT+IG/g+fTjxWn4gTCH5rhKjgGvyr7sRc72LxPlTBMSdatMB2C+byQhEO6+eXSpLHPxb527WCirA==
X-Received: by 2002:adf:f1c8:0:b0:33d:f3c4:6002 with SMTP id z8-20020adff1c8000000b0033df3c46002mr4387671wro.1.1710165972907;
        Mon, 11 Mar 2024 07:06:12 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.35])
        by smtp.gmail.com with ESMTPSA id m18-20020adffa12000000b0033d8ce120f2sm6531216wrr.95.2024.03.11.07.06.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 07:06:12 -0700 (PDT)
Message-ID: <f6b8d9bc-d95a-4d85-a2bc-820b1206fcaf@linaro.org>
Date: Mon, 11 Mar 2024 14:06:10 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] MIPS: mobileye: eyeq5: add octal flash node to eval
 board DTS
Content-Language: en-US
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Vaishnav Achath <vaishnav.a@ti.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>
References: <20240308-cdns-qspi-mbly-v1-0-a503856dd205@bootlin.com>
 <20240308-cdns-qspi-mbly-v1-11-a503856dd205@bootlin.com>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20240308-cdns-qspi-mbly-v1-11-a503856dd205@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/8/24 17:18, Théo Lebrun wrote:
> Add SPI-NOR octal flash node to evaluation board devicetree.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  arch/mips/boot/dts/mobileye/eyeq5-epm5.dts | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/mips/boot/dts/mobileye/eyeq5-epm5.dts b/arch/mips/boot/dts/mobileye/eyeq5-epm5.dts
> index 6898b2d8267d..0e5fee7b680c 100644
> --- a/arch/mips/boot/dts/mobileye/eyeq5-epm5.dts
> +++ b/arch/mips/boot/dts/mobileye/eyeq5-epm5.dts
> @@ -21,3 +21,18 @@ memory@0 {
>  		      <0x8 0x02000000 0x0 0x7E000000>;
>  	};
>  };
> +
> +&ospi {
> +	flash0: flash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0>; /* chip select */
> +
> +		spi-max-frequency = <40000000>;
> +		spi-rx-bus-width = <8>;
> +		cdns,read-delay = <1>;
> +		cdns,tshsl-ns = <400>;
> +		cdns,tsd2d-ns = <400>;
> +		cdns,tchsh-ns = <125>;
> +		cdns,tslch-ns = <50>;

These cdns properties look bad, they bypass SPI NOR entirely. I'd check
if these timings can be determined at SFDP parsing time, then I'd pass
them to the SPI controller.

I see these properties are already accepted in the bindings file for few
years now. Something to improve later on.

