Return-Path: <linux-kernel+bounces-57559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A53A284DAB7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 157091F2351D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 07:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556946995A;
	Thu,  8 Feb 2024 07:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L05W6Rja"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC8A69DFC
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 07:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707377541; cv=none; b=LcDYGce8WINaQ1lbwLbyzfO7RZnYm02uC+2mdr/NP/MWdC5YqrYcu0DQpz0GH5ZY/m6wiqyNnDvYzi90NFNMIxbgYCbZP6VZC6VAlmqNkHQU21/ZlkCsuwwsm+IIfb7YQkxt+sKRyTekUjJVL9qtPAdru+3fDhpc3T+OEbMjY+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707377541; c=relaxed/simple;
	bh=uLkeIwhidF0+HPRxCS8SSoTPkZq8KV/kmA8Upd2Vrhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aEbGb/YDOswMfsDuu6XsXXNKikm1UWB/+kVaWZCfFw1yzMjlJuNyQZij4iwdVjY/RqlmwBRDVECCGGG8+mxvBKA+q99ueYc7SqHbx+QQ54B9ynOAVTVi/tAJJHXumb/GpoACe1uexLcPcykpuuzJ6HIGNC1YD+NMTz4Vtp1kEqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L05W6Rja; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-51171c9f4c0so10153e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 23:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707377538; x=1707982338; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6HgVkffXGaVubbouENe7n1eeWInbNkSOz9ofktE7wXI=;
        b=L05W6RjamIE+6pET3brr3O4wHZibMc3lbf4qt/9jFwK5oKKPwB2TOm+yzlOGuMp4lC
         C6IMpBAJ/XwhNKYXJ3J311eaiWVyXdHkP0Q6B/ViNE4z78VMzH/6mCNoyGGHL4JCG28E
         knD9SBOyZASg0btT+B4U3BlHgVIN84Ww49cLL9atYCYjW+nCav+813Zr6HlnSk6BPqur
         G8WDPVMSADCEoGGwK75B/yfM8Dmcyr8XYWmjmD2g6V0dCY7UYjqHK/9PDASU2b1Ql+sK
         r2w6a1woUP/lFS2BFctclvGePR8rrqLOCHRQeSfST/GScmI/rMuhc7LMkLc5MjyeTyXu
         mMAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707377538; x=1707982338;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6HgVkffXGaVubbouENe7n1eeWInbNkSOz9ofktE7wXI=;
        b=vlI+kAorw2v1bHwfT4z5KpTtTr4GdKt8gCh3QI6/mSmHUvgIVtqBuii1C+1p5rzxmE
         DiyCWrT8iZYJ4BNj3DnUAybcjlP+doI8aogcNJkSDABO+4i6P5GPcuBdAyBBVgLqcpYh
         l4H0JtRe3RRpmcjEgrQJITJrBJu2wqiBv/SeE8ESsqio2W2tPbx4KmBjBob6/nRAwpIU
         D8hZnsj+g1HyGb1K5vH04iLdcKkmwjxKo2WIVhHu+QZtIFRCVYkdTJx2BcZCxSTcHs2z
         r8fdyym/flAoHnrLXNRySS6DsdalOSzzEUqFGIZnQ5PLONDgTInmG+Y09p96JyEhf0KA
         IhOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwfxglPkd7zCP0T83+dlNXevhjNL6rYvbXs+e2KJDp/eu3AiT3XLxRvz6rhGMhgIDzkI2OgeTr8LoeZTy2SlAnZopL3WbeToNFNeLX
X-Gm-Message-State: AOJu0YymcWviUQ94Cj8VZ0IFwSrjiFAJpbzxebicgoo0MmW6bw0GLZ02
	4VSw+47w9rcGDYioknOZv5APCVUgb8jiugozlzJ8BdIdG7GJaAJDhaTRCiARQAQ=
X-Google-Smtp-Source: AGHT+IFbfXThW+ICkeJEZNslqMuZmqAw6idkxpWRqNoHAsOfvbmF2/fv/09jUfNegjHA17qPLVGRog==
X-Received: by 2002:ac2:4e92:0:b0:511:51ec:8684 with SMTP id o18-20020ac24e92000000b0051151ec8684mr5308602lfr.50.1707377537748;
        Wed, 07 Feb 2024 23:32:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXelVdasAyTuzkjNojKgNXUhxeUH1oY/uux+wAYDGo9vYAdPjigVX/lhb2RghJpUm1J69QVxTzwMhjbOhkrKgvj0dVGp8Ymbp1t3PeGBbt8rQ3kcucMlSXBKJCMukgCCTh2VpDRKHoO+L4wAnb/GbHUOsvwH+b/KTOQO0NiXR/THjmdCPi68H01bo3mUaX7ezLf9YPg5fzwxFJH1hqPPSFDI/jq28DKl36s+uhBb+92yUClLzEjZA5C75+Pm6wml0Ts9BmP6UNziTA4iFDWyKibVe1krqUq3j4HVL7zx2uXtAMBpx16gjyULW57Jxbw0mLSwR0JLNDfyLecFvgsmvYihw4ao+UtWRhodNnL2A1hGVSJ4/Rp9wPuDgrO1OdDf/BAE8zR8K4gwph4myJmEs6bwknkblcx+PZGpZffFdGRXswP+18PWPJSK0InR/9C6KkI0QzU35SJAMNs5YmjqsivOqXymuEqnku3STCuISJDphXmSOsSQfaFstQL3+YF0RPSzIih/ITeYxSXKxs7V84mHjTEOQbgwE8nY1vFnn+9C4QwBtxfy7yraQkDwl6QGUUelPm2mGVhB0CVcbhAHKb79ETstVf7jS0r2Hw=
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id j18-20020a5d4652000000b0033b2276e71csm2995398wrs.62.2024.02.07.23.32.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 23:32:17 -0800 (PST)
Message-ID: <cd8c2f79-2307-4ad8-90c7-747d40f14ede@linaro.org>
Date: Thu, 8 Feb 2024 08:32:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] dt-bindings: trivial-devices: Add qca,qca4024
Content-Language: en-US
To: =?UTF-8?Q?Pawe=C5=82_Owoc?= <frut3k7@gmail.com>,
 Rob Herring <robh+dt@kernel.org>
Cc: Robert Marko <robimarko@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 Guenter Roeck <linux@roeck-us.net>, Peter Yin <peteryin.openbmc@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Michal Simek <michal.simek@amd.com>, Marek Vasut <marex@denx.de>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
 Fabio Estevam <festevam@denx.de>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org
References: <ZcH9u7Vo2sFERIHJ@finisterre.sirena.org.uk>
 <20240207224546.44030-1-frut3k7@gmail.com>
 <20240207224546.44030-2-frut3k7@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240207224546.44030-2-frut3k7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 07/02/2024 23:45, Paweł Owoc wrote:
> Add Qualcomm QCA4024 to trivial devices.
> 
> Signed-off-by: Paweł Owoc <frut3k7@gmail.com>
> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index 79dcd92c4a43..c6362e981920 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -309,6 +309,8 @@ properties:
>            - plx,pex8648
>              # Pulsedlight LIDAR range-finding sensor
>            - pulsedlight,lidar-lite-v2
> +            # Qualcomm QCA4024 Multi-mode Bluetooth and 802.15.4 SoC
> +          - qca,qca4024


As I wrote, Bluetooth chip is not a trivial device. This one
particular exposes several interfaces to the host, needs a clock and
power supply.

Best regards,
Krzysztof


