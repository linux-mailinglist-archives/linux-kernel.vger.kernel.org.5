Return-Path: <linux-kernel+bounces-40246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C967583DD22
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73A3128880E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394CB1CD3C;
	Fri, 26 Jan 2024 15:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aLofyxyn"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC881D52B
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 15:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706281936; cv=none; b=YGueBJbdSY7PEz892lvQFSxlmsbydeVMzIsrV97Ujnx0G2dBwBpII85YnNz6xgjLohKwnoEtH/coew7RMP+UM6CrkCCOe34HDVWRciSoJEWDYnQum6dKKlLQ60A62G58b3p3jSbC/O+W2jEICzB5lz+u77MZbgYy56hrlQKaB4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706281936; c=relaxed/simple;
	bh=Gahe+ilgy0UV51VonJOuKA+Z40S1X6L9UkwYRrD6D48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sgL4/UhOk34zuLml9BmmMo1e+4SkI2xwBV9S1aMf9SzDryJYg99SEeDmwYtpbyjbleWaSS9jWH6qGsOKzkbytL25Bp4xBjeWRy3yTfkG12cXdYHLwlyQX+52y9R34LQLJadbIpPG5YaVlu83aF5lInzYrN/G51Xw/i+GSM1FZLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aLofyxyn; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2cf296932d8so8529471fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 07:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706281933; x=1706886733; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iYL9bSeqnWvDrf0wVv9gF1ha7moZQcSL5iboxbxlXjo=;
        b=aLofyxynrk2Fdgt5KjSbF89Smk/zeu7PA0aV49hfuyxUi15jOLm7VV/fW7kvLh20dQ
         8yrXrjxHJmbrGcIz4EZqsy8XtbAPr1cQqmeIOmymbL5wOOXn/hzp67/uIYqeLH2cz5ou
         3Tz3D05Y8H/WvEk4of2IMlZbHWkdILVlDh6GHPHFWQHfb0NTKGszK9AgjqlciY6nGt6q
         Dk9JvOzBd+8o6iMWyQQw+3uuhXzt81L5mFQXgyLhp9I0ypXtL2kSjq1/dzFTbwBX3CbM
         2iITiotleIowRk2DUxc11d69cvYEJRZ7UJPb/AahMX5CFEr33t30zeJDOr5ni7Anovy4
         BC7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706281933; x=1706886733;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iYL9bSeqnWvDrf0wVv9gF1ha7moZQcSL5iboxbxlXjo=;
        b=fY6M/oSfvZho0XiSQxCkQozh7W8JgalJht/C9hV+4o0upgGONRM5ZkdQ2mGR92dBBQ
         UKncAmJFAY9tGXnpKyS7xqT+1qUUgp6YiZhXNS9xvLrIigzTAB5+/kOAK/qH3f53Z5al
         vi8m6lObzyl4FxELkJ0ghqn2USzAXeM2Kse03ziwvNFgGKwp8I9pk29rRAR1N6/G5lyH
         jqp7tfUYaBwg18+bjdAHm0NK8Lhh5Auvkxa0lWupqzNT1Gr2qtWyIPy6mKRK0K5Igbhj
         DjLPdn9luBvceQP6ouVwG+9Up3A/XJhBbrO/KkxHz/yObnmzGJJxCSq0WB4Qsa5v+cjp
         2UpA==
X-Gm-Message-State: AOJu0YwN2GOEeznj8lXSRM6sTKKk8r4EE76bTRppIYu7kISIeynAlSyB
	2Wlg4KvqeAJc7xPB2v+pxuzd2oSxebvTsWzDHtECj9ZKrjwMooMAMp1f4tHPpAg=
X-Google-Smtp-Source: AGHT+IGqqMimYnKB5rUMwA7WUMOKAcK+ed0NAAsAyhbSDICoER2BwlCLiBlOJBHVyK/2eaNTmmSUYg==
X-Received: by 2002:a2e:9382:0:b0:2cf:30c3:ef0a with SMTP id g2-20020a2e9382000000b002cf30c3ef0amr942735ljh.31.1706281932690;
        Fri, 26 Jan 2024 07:12:12 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id c14-20020a0564021f8e00b0055d81121180sm112820edc.38.2024.01.26.07.12.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 07:12:12 -0800 (PST)
Message-ID: <42514aad-5b2c-49bb-a6e7-af44652d9dd0@linaro.org>
Date: Fri, 26 Jan 2024 16:12:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: dts: ti: k3-am62/a/p: use sub-node for
 USB_PHY_CTRL registers
Content-Language: en-US
To: Roger Quadros <rogerq@kernel.org>, nm@ti.com, vigneshr@ti.com
Cc: afd@ti.com, kristo@kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, srk@ti.com,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240126125951.18585-1-rogerq@kernel.org>
 <20240126125951.18585-2-rogerq@kernel.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240126125951.18585-2-rogerq@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/01/2024 13:59, Roger Quadros wrote:
>  		power-domains = <&k3_pds 178 TI_SCI_PD_EXCLUSIVE>;
> @@ -648,7 +648,7 @@ usbss1: dwc3-usb@f910000 {
>  		reg = <0x00 0x0f910000 0x00 0x800>;
>  		clocks = <&k3_clks 162 3>;
>  		clock-names = "ref";
> -		ti,syscon-phy-pll-refclk = <&wkup_conf 0x4018>;
> +		ti,syscon-phy-pll-refclk = <&usb1_phy_ctrl 0x0>;
>  		#address-cells = <2>;
>  		#size-cells = <2>;
>  		power-domains = <&k3_pds 179 TI_SCI_PD_EXCLUSIVE>;
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
> index fef76f52a52e..bd09662a3c29 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
> @@ -19,6 +19,16 @@ chipid: chipid@14 {
>  			compatible = "ti,am654-chipid";
>  			reg = <0x14 0x4>;
>  		};
> +
> +		usb0_phy_ctrl: syscon@4008 {
> +			compatible = "syscon";

Not allowed alone and should cause warnings.

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check W=1` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

Best regards,
Krzysztof


