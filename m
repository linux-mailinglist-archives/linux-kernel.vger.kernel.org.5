Return-Path: <linux-kernel+bounces-94342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80906873DA3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1BE71C21EA1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8D513C9D4;
	Wed,  6 Mar 2024 17:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efxBbrOE"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D183A139569;
	Wed,  6 Mar 2024 17:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709746933; cv=none; b=pOYD3BBPCU3L+zhGJ4p4OnRU7Glo2eKIMNCpKQCxAosAynjUhjKGWmUnteLFgeTj+oj11bGZrND/by/UCu4tw2GRnlDPADowvux2AHsvzmHFkrAvgWGZDrIL/TPAUpFJPRWg+KJmlI2CeyGVXzgI1xDgVGFpOncE2Wg/FKX5KE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709746933; c=relaxed/simple;
	bh=XCnhPj2fK38RW068ZA7Azta24iCeZaL58zBR3pb2O9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sUeaaJUGRiYQN0dOiuyFCAs8ZwF48JV/8QwNhuCCVYeYn/ZAif5ijVQMjYSMzzgkyqlV1Gicz/br918Xke9LJU66kvoPrSY2C0nOiErAkFVY0ZO7B9Wix922Xgcv7jJUzsjiF90HP254w82Cf00iZujkB77BC0f35aKCW/riUb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=efxBbrOE; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6901114742bso393366d6.2;
        Wed, 06 Mar 2024 09:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709746931; x=1710351731; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cP96RrcztrNAzMbEhfXoCNnB/B/rAwamum1tutFUVu8=;
        b=efxBbrOEAxh/RB0JqEoOb3uQMVm/igqShZoBifbXkRurITEHjWPSx9yUVO+Q/EFFWm
         WMRnnwi3dkMa5/HAdpJ3iOjKNl58UKcdI5Gn01LQDfGrzf3RYa+R4R3JAB3gVWDdaLQe
         0HYu/Xe2BCrXYQWnPkVr+EObnJpjkcm+sb+5YfDtl79CYulPlk+We/w8lMjsHqcNHCCC
         y8FU8hzCzbhugJRQ3e8Vsvu/iE6op4IgH/ErAyIXle9OmQh1BiQFZnige/trbKEUjYG6
         Q+hHcIcp35D7BsBWM2I20qBdFrpm2S9sAKBS4lsKospNhioVpN1zXauzoEoYcxZNpYGI
         rQpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709746931; x=1710351731;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cP96RrcztrNAzMbEhfXoCNnB/B/rAwamum1tutFUVu8=;
        b=NO9kfp5YDZUyyNjQf7jo8kypVDwhwYc5SvM4c/lVeAIxHNPJ7T2Nae/O/M91m701tQ
         96LGeLusxKtW1VFBpiDVCamv6duk0okBCpmdv3gz252sZSYX4/roe+ZAmYW4NAOXO345
         ro3j8VhQp0JdAYtg2cgGyAvDxA+iIRF6TCcwT88MPideDq2dbctCtko/J9E1MxuKafhG
         ZOKW4USfgKzil37i7ZcTSCIbPJ3VBn7fAC68bwfRT/GR6O1vvSjo+lvNa8wUQUQdOHo+
         20MAyIl5x1n9y/vCTSF+lmY7Q879IPaY8nQZ4rV2NY982k+Slrhn7MU0Za6a1tAZn6qj
         B/3w==
X-Forwarded-Encrypted: i=1; AJvYcCW1oeqJyTSKNJF89P56X3vFd4TB8bxyGPOSrzd3UaQBwawgGf9oKRz6QuLPH9AQpgqZLjkmNLxcxwDbd03E6En1+2qVbfFSuM8WWBOc3cSmoDaxdveNmpiRNUcKOUMj+SEl7vmsAR1Z5A==
X-Gm-Message-State: AOJu0Yzlz5V65eXK4HpX6gB8IrQ3K066ZCcCAfLXdRApU2RcxuL2fCmy
	PFFWpnE4aM7nSnAZ0dzRVjhZCoyuXowsQj7gMYYH08TXoBa0bUM2
X-Google-Smtp-Source: AGHT+IEdVVnjOkVxsshHgJLZVHna+BAO8gJvdt0HEpxKUw8ATSAgs42Yfrkygg+W6m2PVqJ1V92CMQ==
X-Received: by 2002:ad4:4990:0:b0:690:7e04:7874 with SMTP id u16-20020ad44990000000b006907e047874mr5613328qvx.2.1709746930844;
        Wed, 06 Mar 2024 09:42:10 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id kr9-20020a0562142b8900b0068fcd643b9dsm7654626qvb.22.2024.03.06.09.42.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 09:42:09 -0800 (PST)
Message-ID: <fc8a079f-10f1-4b2e-abc1-0a043eb1876e@gmail.com>
Date: Wed, 6 Mar 2024 09:42:02 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: dwmac-imx: add nxp,phy-wol
Content-Language: en-US
To: Catalin Popescu <catalin.popescu@leica-geosystems.com>,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com, xiaoning.wang@nxp.com,
 linux-imx@nxp.com, alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 mcoquelin.stm32@gmail.com
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 bsp-development.geo@leica-geosystems.com, m.felsch@pengutronix.de
References: <20240306172409.878928-1-catalin.popescu@leica-geosystems.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240306172409.878928-1-catalin.popescu@leica-geosystems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/6/24 09:24, Catalin Popescu wrote:
> Add support for PHY WOL capability to dwmac-imx MAC driver.
> 
> Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
> ---
>   Documentation/devicetree/bindings/net/nxp,dwmac-imx.yaml | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/nxp,dwmac-imx.yaml b/Documentation/devicetree/bindings/net/nxp,dwmac-imx.yaml
> index 4c01cae7c93a..6cf373772eb1 100644
> --- a/Documentation/devicetree/bindings/net/nxp,dwmac-imx.yaml
> +++ b/Documentation/devicetree/bindings/net/nxp,dwmac-imx.yaml
> @@ -71,6 +71,12 @@ properties:
>       description:
>         To select RMII reference clock from external.
>   
> +  nxp,phy-wol:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      If present, indicates that PHY supports WOL(Wake-On-LAN), and PHY WOL will be enabled.
> +      Otherwise, MAC WOL is preferred.

This is encoding a policy in Device Tree, which is not acceptable, see 
my comment about your second patch.

pw-bot: cr
-- 
Florian


