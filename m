Return-Path: <linux-kernel+bounces-105449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8944087DDFF
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 16:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A67E1C20D44
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 15:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FA31CA84;
	Sun, 17 Mar 2024 15:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CvL5RKc2"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22621C68F;
	Sun, 17 Mar 2024 15:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710689828; cv=none; b=N8i3hOVVLDvwi4ZGvuA1tW5H8lYyun8UvB6MlvBmumhf/b/8k1h7UCylozTBIVbXts6pGRW4i4czuKgPHUGbLPmeaRMn/4cU0+IQOA3jRm8XPm0HoDkqcfzYfxkfF1DVkKXMSdxfkIjwLOt2rg4rc/yJtsWmVd0BY5VCaMyxCsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710689828; c=relaxed/simple;
	bh=mINZzG8MsiPOIqLtvTwJWSlmXsjd0rm5zc6iBGJqlvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QbnKyKHwYwTpvhB0lqaYnmR6HsLX+ZSNluonjz0S1NvAP2ZC7/Zv2xXWnDq4EebYW3J8dCY0pTVPmlPMO79u8V09XnIgjPB16aHRQjXxNhnUGIWniWN5X3uNeDwMG7uUVowaFu1WpdsQDEgc0luI1cy09aNvGrGa1IFcnYKnzr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CvL5RKc2; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d47a92cfefso46687481fa.1;
        Sun, 17 Mar 2024 08:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710689825; x=1711294625; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TUArIiut1cWPP+AwimO/LFgXs0A/dh0M6eE5ulhPRso=;
        b=CvL5RKc2NEfoUNxE2v4PouF/9oeLMgzSYqtV6o9eDyWeKwtSGfWqydVcRQ9eeP1D4r
         SKjHj/baoCaUoXZdPxsj1pbQHSG6qHyLqsUnwN06DoWWwifgUb1V+vF5SXYXyBiwiEL7
         e8ynrqzrdQufr4cPkf/YO7ntLyNret6j3fc6Nax3gYLoFsiHMYulamTDF41VqWYhmgH/
         Nqg1SBRXgrcViq5XN4D9WV/QyTB8hbgabQxvfno6dBYIPp4zR/zdOAV3wuNdS+ythBZq
         7fLvJziwWvhctNIb7gBiB/4HVSm+tG0e5LSk6/D4hl61rRT+8I3GqTgJZ5byf9pTS0Md
         Rl6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710689825; x=1711294625;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TUArIiut1cWPP+AwimO/LFgXs0A/dh0M6eE5ulhPRso=;
        b=Ygk2sUE74io/S7kmjD19hs1vbUwE9a1a3OEbydYt1AmaqK8QHf7JWDhG3uLifuXIbk
         ks3iJ4qoPgreXdM2uyIoRCeqiegKOmhibnMile05WPP7IzOWP/+Gw7rmZPlNO640GKyE
         Mfcx/VNa3bdQ+P9/0iZCx+Wv1gTMSVZaUNxlp0pmZzgEp6tQuazHLY+igpnWXBQEHVGL
         szvPWKUvc0CWYr8lww+kV8wJvb5yhXACtNuE5Kchv3WMYDmb1mD4bUtOfTL4pgp25J42
         i11e6I7Xqh116M2aWRBbb5Eq99klgpcUfBY8RUZ3GW0h4yA2KkQRL++GfAVf3+pWi5Fh
         6qWg==
X-Forwarded-Encrypted: i=1; AJvYcCWJpZkSbOR4Rxy90MQMi+ADud/9P0PzeMmhlRG+XGbLPdtD7Krkbz/coAKnqgdRzp6Y8SOwp8Tz0nXs354vj3T7oU0MBShi9QEtzzMT
X-Gm-Message-State: AOJu0YwIxAE/v+fN2uqW/YG18QCSxGKTjaj5K5WzDK59V1vuAXh5Lf0D
	yR18frI7oyHUXMOvvAbx9JcKV7sDktlrtasgaEoIrfiYtVjTF8ev91O/GW6qBRknZg==
X-Google-Smtp-Source: AGHT+IE8iVEBLsbeBWUw0aacjQEV/qt7NW/hXDIvCewyz3XIiPcSWcGo7/r3YlriRP4Z0ignZ10RzQ==
X-Received: by 2002:a05:6512:3283:b0:513:c97c:d5f with SMTP id p3-20020a056512328300b00513c97c0d5fmr5528365lfe.12.1710689824967;
        Sun, 17 Mar 2024 08:37:04 -0700 (PDT)
Received: from [192.168.100.117] (89-76-44-138.dynamic.chello.pl. [89.76.44.138])
        by smtp.gmail.com with ESMTPSA id t10-20020a1709064f0a00b00a46b6a8fc25sm762569eju.64.2024.03.17.08.36.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Mar 2024 08:37:04 -0700 (PDT)
Message-ID: <f4f02cb2-6263-4bd4-a798-c92c31f7b363@gmail.com>
Date: Sun, 17 Mar 2024 16:36:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm64: dts: allwinner: h616: add support for T95
 tv boxes
Content-Language: pl
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
References: <20240317-add-t95-axp313-support-v2-0-e38032811758@gmail.com>
 <20240317-add-t95-axp313-support-v2-3-e38032811758@gmail.com>
 <1860c559-5a5c-4673-9d08-253f0945762b@linaro.org>
From: Kamil Kasperski <ressetkk@gmail.com>
In-Reply-To: <1860c559-5a5c-4673-9d08-253f0945762b@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

W dniu 17.03.2024 o 15:57, Krzysztof Kozlowski pisze:
> On 17/03/2024 02:34, Kamil Kasperski wrote:
>> Add dtsi file for T95 tv boxes and add initial
>> support for T95 5G AXP313A variant with a board name
>> H616-T95MAX-AXP313A-v3.0
>>
>> internal NAND chip is connected to NAND controller
>> I can't see any nand in sun50i-h616.dtsi, so access to
>> internal memory is not implemented.
> Please wrap commit message according to Linux coding style / submission
> process (neither too early nor over the limit):
> https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597
>
>> Signed-off-by: Kamil Kasperski <ressetkk@gmail.com>
>> ---
>>  arch/arm64/boot/dts/allwinner/Makefile             |   1 +
>>  arch/arm64/boot/dts/allwinner/sun50i-h616-t95.dtsi | 109 +++++++++++++++++++++
>>  .../dts/allwinner/sun50i-h616-t95max-axp313.dts    |  85 ++++++++++++++++
>>  3 files changed, 195 insertions(+)
>>
>> +
>> +	reg_vcc3v3: vcc3v3 {
>> +		/* discrete 3.3V regulator */
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vcc-3v3";
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +		regulator-always-on;
>> +	};
>> +
>> +	wifi_pwrseq: wifi_pwrseq {
> No underscores in node names. From where did you copy this code?

arch/arm64/boot/dts/allwinner/sun50i-h618-transpeed-8k618-t.dts#L44
Seems this one needs a fixup.

>> +		compatible = "mmc-pwrseq-simple";
>> +		clocks = <&rtc CLK_OSC32K_FANOUT>;
>> +		clock-names = "ext_clock";
>> +		pinctrl-0 = <&x32clk_fanout_pin>;
>> +		pinctrl-names = "default";
>> +		reset-gpios = <&pio 6 18 GPIO_ACTIVE_LOW>; /* PG18 */
>> +	};
>> +};
>> +
>
> Best regards,
> Krzysztof
>


