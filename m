Return-Path: <linux-kernel+bounces-130995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 893198981AC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9B6C1C25B03
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 06:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E9D548F5;
	Thu,  4 Apr 2024 06:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mTPLZwWl"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255945676F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 06:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712213686; cv=none; b=dchc7d8AcLtuwYGdCrIQ7i5Gzj1up43TkFzgDBeMicznm3ooeICYtfSn+o0Gs13PPEXYxrnBOlXeTFAlYBu9NcHUv/W6DDKOQYwy9aiOxrOKz5olPAh0XCEbkUkptU7Jhd1Xew6qJbe4CpeGP6E2LT1y5qBEkRwysarzHNRioaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712213686; c=relaxed/simple;
	bh=9xhx+jdd/qq0Fo4bEtf5KVRExUB55aknQqMAJ/ufCCo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=n93wQrRN+fD3U9WDmgrbZPJIH/DU1oEcYyQvWs/EJEPbm8/JxU4EYUwRaW5+IziaX7v/ncryK5bxYvjBNrPUi2akUbvOx53SVu6BkUI5rhPKx2BUcfngSIr3yyZ1FphjVP/GIdu1/RgZ+huOtGfTiCESZ9IfAdNqVoudIbqZu6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mTPLZwWl; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a472f8c6a55so84119266b.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 23:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712213683; x=1712818483; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P917Eg3QLhHgdqQkTHbrOp8hwSdLSTfQryLlL3QH5Uo=;
        b=mTPLZwWlBIiu/NDiXPEu98pVYni+PlVuyR7MNUVoVZbpH+e6s3MOb4M5C1FbWBDIly
         95ECX/+aStNkKDAN2pwFx2b+Zby53ua3v2rGcFZHO9grWr39ZnOc4DUttmsJHg5XWIb7
         EtOAp1pZpKPSJ+hZrKtfA815f4CKAQjaw5dZ2p6uuPJ9MVx+ajbf1NxXL4sH8SydelNf
         IauCsoN/aZju9JMRwu+yLbDXAHVEa6+w6umdY6nLt7b/FZzwdqoQz2xFLTGGSdQKMOX9
         ITbv35iAN1SJL2Hmgauy42lJRMzg3CqmzYTXqSg87XCZ5fJaRzpPch5gQBF+P4LSGCVW
         Qhhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712213683; x=1712818483;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P917Eg3QLhHgdqQkTHbrOp8hwSdLSTfQryLlL3QH5Uo=;
        b=laFRz0a+miSXf7QzSrFriRJFgUGOgDB8W8weJRgVR3QUJZ5OIasM5KM4ptFymLvYn7
         T5xaXGMOU1LifGALfiJ+gZCnLoZhwxqcJA+6NlYGbw8tQtHzPmPG9yUNpGQaJktDpte/
         Fzs0LMyJ3c1aE2IV7EICs3qVoYVGv5erzrmyeZZ9K1GASzqwZzsfHy435H+ZbZdtmACz
         rsLwJOP1ocS+sDznCdp0WPWepotMHdkqb6imjeigfyVsM9jwGBaeK8AA+ShUi4k5cosu
         e4QvUngJzNkame8Wp0x58xa8hr47ZtWok6aHty1ETx2vyv2ls1SkjubsxxolmtLka79v
         18Gw==
X-Forwarded-Encrypted: i=1; AJvYcCXNt6A0Pb/mIjQoXPyB08urk/pY0VvwqlKauYckKcGwFqtXulzfw/Yg71iS+LSS82EggBUKrTpO6BgBDO8E+fJFtGHmw2c45dBvjDo+
X-Gm-Message-State: AOJu0YyYtZXB5XocbvxXcfH4I83D2d2r7ejv5sEKYs7dto5MZL6BxxqK
	Zo9d0/WPRDKNYJCP7WyI5xT8oOwe6sTveX62m4GXeDb9ARJs56BAp++22+skIao=
X-Google-Smtp-Source: AGHT+IGGaiVzx9SFI5+PeYOKaINJuxBht7x3e1J9GOSqsR2AT7OwMhSH9yXnxZABS7oWTyM8p/QEyQ==
X-Received: by 2002:a17:906:1c56:b0:a4e:5a23:24d with SMTP id l22-20020a1709061c5600b00a4e5a23024dmr886746ejg.38.1712213683443;
        Wed, 03 Apr 2024 23:54:43 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id gl20-20020a170906e0d400b00a46c39e6a47sm8717864ejb.148.2024.04.03.23.54.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 23:54:42 -0700 (PDT)
Message-ID: <f5fa1872-0bae-4f04-aa94-27db937516e9@linaro.org>
Date: Thu, 4 Apr 2024 08:54:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] dt-bindings: media: imx-jpeg: add
 clocks,clock-names,slot to fix warning
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Frank Li <Frank.Li@nxp.com>, Mirela Rabulea <mirela.rabulea@nxp.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 "open list:NXP i.MX 8QXP/8QM JPEG V4L2 DRIVER" <imx@lists.linux.dev>,
 "open list:NXP i.MX 8QXP/8QM JPEG V4L2 DRIVER"
 <linux-media@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240404035205.59492-1-Frank.Li@nxp.com>
 <af602862-5120-4717-adb6-694ada09e8d8@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <af602862-5120-4717-adb6-694ada09e8d8@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/04/2024 08:26, Krzysztof Kozlowski wrote:
> On 04/04/2024 05:52, Frank Li wrote:
>> Fix below DTB_CHECK warning.
>>
>> make CHECK_DTBS=y freescale/imx8qxp-mek.dtb
>>   DTC_CHK arch/arm64/boot/dts/freescale/imx8qxp-mek.dtb
>> arch/arm64/boot/dts/freescale/imx8qxp-mek.dtb: jpegdec@58400000: 'assigned-clock-rates', 'assigned-clocks', 'clock-names', 'clocks', 'slot' do not match any of the regexes: 'pinctrl-[0-9]+'
>> 	from schema $id: http://devicetree.org/schemas/media/nxp,imx8-jpeg.yaml#
> 
> No, that's not the reason to add properties. Add them if they are valid.

And for the clocks, instead pick up this patch:
https://lore.kernel.org/all/20230721111020.1234278-3-alexander.stein@ew.tq-group.com/

Please check for same work on lore before working on old issues. dfn in
lore is your friend.

Best regards,
Krzysztof


