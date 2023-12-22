Return-Path: <linux-kernel+bounces-9867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF4881CC8E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4A90284D84
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 16:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685B9241F7;
	Fri, 22 Dec 2023 16:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QmQGT6PZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D9A241E2
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 16:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50e3c6f1c10so2489758e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 08:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703261253; x=1703866053; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B+wXRXUTOZMyl1LFRrfsL0kKZmHY+nM2UvjNpacptSo=;
        b=QmQGT6PZwNWz3t7aWO1wbiTK/l58LyWJ/c88heJYVDGhN2hk25jIXZGu74VuJ9p8sO
         eSm/XNO9gWZccs6cwaa7BnMbC7oroido4FSoimXMjaIfZtmZewPX5EKwqoQIbUU3RlIC
         YXIrIPoXqDlvqB5PmD2orEKptp4VddUUd/djtfM7o4N2xXkCRY8N7MUJiwIeTmG0A4Aq
         7iTOZR1WnIkxagDLZjU2EflLTnkof/v6XNvFpxhntZyiLZivfdOr4lO8K4qEYbyX5Cle
         rlUPMkS6eLCEX6HTNhUtXiNjPZDhLg/2vfxLEOZXWk8KiYYaL++ycNYwrpaeqbiuyzPp
         +udQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703261253; x=1703866053;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B+wXRXUTOZMyl1LFRrfsL0kKZmHY+nM2UvjNpacptSo=;
        b=V2kgoMtKn5bn8gh2gHsJPvQagm+5WX52HbjMpXiO8gM4HjIvzE/xjKDnYmgdeHDf3p
         d8kYANqj2wT4PTIyGyhAgxmbukKtd8IY8DFhXjLDvRqNU6wAiUI1Kpej7meYTA8V+yLy
         oWfXOIFjRPpPJDUlehtDoTmG7drBnfMXC4JfSodadn1LHhQdeiwm7rNSaQgYNJdsbGIy
         YOfVVu+FkjxSfTcaXGMS3B3EXlSLdCemMonOb/H1tjhYeQIHbofoxAn0NIgWq2I3nvmQ
         OcjV9nZof5xb/Afzp1tf6wfKZI7MpK1Hy3aRSH5n0oTN6TwplQKnIztvFRCWzaOsy7Nt
         TyJQ==
X-Gm-Message-State: AOJu0YwboruyTKAVpJBHsXcHRsyqKW9rIjuVLsuVs45aOPbhnriGO4jI
	hMW9gfR8Nzr+T2/KFC4XnG7L0dkgtb5V5w==
X-Google-Smtp-Source: AGHT+IG9zmrWqdLHelPmE88vblgo1ArESfXchHRQ7uFdNxlL7DHEWhHb84tBucYdOTEMaOyk6ACT4g==
X-Received: by 2002:a19:700e:0:b0:50e:5a39:bbeb with SMTP id h14-20020a19700e000000b0050e5a39bbebmr430335lfc.173.1703261253060;
        Fri, 22 Dec 2023 08:07:33 -0800 (PST)
Received: from [192.168.0.22] ([78.10.206.178])
        by smtp.gmail.com with ESMTPSA id zr16-20020a170907711000b00a26af905229sm1269203ejb.29.2023.12.22.08.07.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Dec 2023 08:07:32 -0800 (PST)
Message-ID: <d59a60d9-6bd3-4945-a345-0b01eaf1ead8@linaro.org>
Date: Fri, 22 Dec 2023 17:07:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] arm64: dts: rockchip: Fix some dtb-check warnings
Content-Language: en-US
To: Manuel Traut <manut@mecka.net>, Neil Armstrong
 <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>,
 Sam Ravnborg <sam@ravnborg.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Sandy Huang <hjc@rock-chips.com>, Mark Yao <markyao0591@gmail.com>,
 Diederik de Haas <didi.debian@cknow.org>, Segfault
 <awarnecke002@hotmail.com>, Arnaud Ferraris <aferraris@debian.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
References: <20231222-pinetab2-v1-0-e148a7f61bd1@mecka.net>
 <20231222-pinetab2-v1-5-e148a7f61bd1@mecka.net>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231222-pinetab2-v1-5-e148a7f61bd1@mecka.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/12/2023 12:05, Manuel Traut wrote:
> devicetree checks show some warnings:
> 
> video-codec@fdea0400: 'interrupt-names' is a required property
> from schema $id: http://devicetree.org/schemas/media/rockchip-vpu.yaml#
> 
> hdmi@fe0a0000: Unevaluated properties are not allowed ('power-domains' were unexpected)
> from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,dw-hdmi.yaml#
> 

...

> @@ -819,7 +820,6 @@ hdmi: hdmi@fe0a0000 {
>  		clock-names = "iahb", "isfr", "cec", "ref";
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&hdmitx_scl &hdmitx_sda &hdmitxm0_cec>;
> -		power-domains = <&power RK3568_PD_VO>;
>  		reg-io-width = <4>;
>  		rockchip,grf = <&grf>;
>  		#sound-dai-cells = <0>;
> @@ -1123,7 +1123,7 @@ i2s2_2ch: i2s@fe420000 {
>  		dmas = <&dmac1 4>, <&dmac1 5>;
>  		dma-names = "tx", "rx";
>  		resets = <&cru SRST_M_I2S2_2CH>;
> -		reset-names = "m";
> +		reset-names = "tx-m", "rx-m";

That's not correct. Look at line above. How many entries it has?

Do not fix warnings just to make the warning disappear. Your change here
clearly suggests you did just that.

Best regards,
Krzysztof


