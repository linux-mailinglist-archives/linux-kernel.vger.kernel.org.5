Return-Path: <linux-kernel+bounces-167345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB838BA83D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C70A8283298
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918591487F2;
	Fri,  3 May 2024 08:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jM2yaPZc"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294AC147C7F;
	Fri,  3 May 2024 08:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714723326; cv=none; b=KkPUbd4Hrsqae6v7++pLUJf4SmvlX5Qldkg+97EHFsF0aAyBMkcSx0n0ASIDyly/tDntvs+cChQiTXEThEl7Pd4iIWH3/X+6Mxwj31BNtMZOQEmKFt1NFz6m/32te6iEC7Ta20bN/8AjfvfQ/v+9l5GD0awuan+W5jhZPbz4vuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714723326; c=relaxed/simple;
	bh=mMegtZGzzl6saJDj1XbUSR6vwS5sry0AYzv6MQiMAqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IZ3RIarbRfww61177UGUfPPFngORMVZ3jRVDLTw+i8ZW+pSNd7X3Gpb4HcZdx1zZcVDGunFVW5nX6Bu0Wm07RAmTNH+Ii8xoLh9KwaZOTnT8NITQxxV2pTSUBYlLB+iVpgoe0BEstIu0Ol2/qzCOu6bb/vHbtYOIeb+lsSfKorA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jM2yaPZc; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a595199cb9bso399787366b.3;
        Fri, 03 May 2024 01:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714723323; x=1715328123; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O7VR0R6Dd9Cls/yOVc31au9glBIGmfh65HkhEJCpmCM=;
        b=jM2yaPZcWnSoR7q3mbrEVGlUCPIzbufVD7RDu/lthg9JdYW3ICFH5iZ79t5CpsmSes
         nz5E3polLmx8PFoQ/4OIMsEHkNIwkuxCsvZ15N3+HL8+r4L4ezRihCC/Jb4ddvsSQufs
         EhyEuWyGBKM6Tdq1z1ijLe8w1j00aw1edhEnz0AUgFQcKVdwLF8p3p2Qoh67BgOziKzs
         ywRLGkLvAQLxxgnFpGq4cZsF58PW3Z6mbBDy7zwEEzozT+ojFvB1uEnnRhXRV+JY1g4j
         C1UtT2MYWGFl9EbC6nUkwGUBmL8Wni2iTEnL9Zp5H6GsZAC4KzGMQ7lVfWL5PrdRuhWx
         M2wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714723323; x=1715328123;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O7VR0R6Dd9Cls/yOVc31au9glBIGmfh65HkhEJCpmCM=;
        b=CDRWZHcIMxK6cL4/LMfB6r0L+51hBhDAhMWRwUnq7R980ZPWXIfUgYKdoRNie/oDSF
         DKlc7fTwWigLON2nOMEZBFF+mxgnCtbNcvGBO/TUe5jYi3Vg7bPVUV9cVMdT2UGdtzC9
         rYTPtW29/VzmEyP0/kQDSRCe91rNXMEhDKkm4schjz3/ebtAWutaENynqFNBmcEdCcv4
         WsPgRPSmkhykUshTarfO2cI2U+R7SY6f53MBKO2cqLOE9hcqePKytyfQfIm1MHhQXF4W
         hingfiu/N95F/o6aAia6oCNEJ9eWBkrtxtEYeUcMPGj7aV/wtW0Bv8SA5M60FpDzSHer
         m7Hg==
X-Forwarded-Encrypted: i=1; AJvYcCWUt6mE4FuRujH8fcD2oEtwcSBSqTcfNUIGHG8NHI9HI8FC/YRSCIgdEmVQH0Y0uw7N5fw03yLWLxChZKKRTkMspWmEyDB02RgYC9ygOVyU0VGhCPdQ8WtcOhNHTohT7auCtGdCuGRwkyl6AsZKYVDTfiTpMoJKtxZ/OAQCXqYlaqf7l3s=
X-Gm-Message-State: AOJu0YxegXx7SMkAantOTUGkU5bSGbI7NjLSpXZBcXKyJWhEQqMOIuPD
	GLTNQEsLCWjxIQ0kq6K56H3QyqLFfszMG33qNzfBFRSz7D+3vLo=
X-Google-Smtp-Source: AGHT+IFT/vjg3gQPLCM/xYelNdutZZJSVCcpo9b91OQ0v+WPciUzGBo+JPLz0QP130mkuAxdvHOSdg==
X-Received: by 2002:a17:906:29d4:b0:a58:c559:3d06 with SMTP id y20-20020a17090629d400b00a58c5593d06mr1105060eje.55.1714723323134;
        Fri, 03 May 2024 01:02:03 -0700 (PDT)
Received: from ?IPV6:2a02:810b:f40:4600:3a49:8f56:d30a:65e? ([2a02:810b:f40:4600:3a49:8f56:d30a:65e])
        by smtp.gmail.com with ESMTPSA id kt1-20020a170906aac100b00a52295e014bsm1440683ejb.92.2024.05.03.01.02.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 01:02:02 -0700 (PDT)
Message-ID: <69945c53-1fa5-4fde-b488-6056c5471095@gmail.com>
Date: Fri, 3 May 2024 10:01:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] Add RK816 PMIC support
To: Lee Jones <lee@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>, Heiko Stuebner <heiko@sntech.de>,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Chris Zhong <zyw@rock-chips.com>, Zhang Qing <zhangqing@rock-chips.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20240416161237.2500037-1-knaerzche@gmail.com>
Content-Language: en-US
From: Alex Bee <knaerzche@gmail.com>
In-Reply-To: <20240416161237.2500037-1-knaerzche@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Lee,

it looks like all patches except the MFD ones have been reviewed/acked by
now. I hope I integrated your feedback to v3 [0] in a way you were
expecting. Also I was hoping this whole series could be go though the MFD
tree, since all the none-MFD patches depend on the changes mfd-header.

Please let me know if there is anything left for me to do.

Thanks,

Alex

[0] 
https://lore.kernel.org/lkml/20240323132757.141861-2-knaerzche@gmail.com/T/#m1bb23196c192289f898aebc64ccf62edb9ef5b5a

Am 16.04.24 um 18:12 schrieb Alex Bee:
> This series aims to add support for Rockchip RK816 PMIC series. As per
> datasheet it's targeted for RK3126/RK3128 (RK816-1), RK1108 (RK816-2) and
> PX3-SE (RK816-3) but might be used for other SoCs as well. The MFD consists
> of an integrated RTC, a GPIO controller, two 32k clock outputs, a power
> key, 3 buck- and 6 ldo regulators, 3 regulator-switches, and charger with
> integrated fuel gauge. Charger and fuel gauge are not part of this series.
> Two of the switches (otg/boost) are part of the binding, but not of
> the driver. They must only ever be enabled if no battery charging is
> happening, but it will be enabled automatically if a battery is attached
> and an external power source is connected. Thus that needs some
> incorporation of a yet to be added charger driver.
> Integration in the existing rk8xx-infrastructure was pretty straightforward
> and only needed very little tweaking. In order to not further bloat the
> driver(s) too much with additional `#define`s I tried to re-use existing
> ones wherever possible.
>
> The patches are loosely based on the vendor's implementation, verified
> against the datasheet and tested/measured on a RK3126 board.
>
> I'd like to gently ping pinctrl and regulator maintainers: please have a
> look at this series. I've now added Sebastian Reichel to the recipients, as
> he recently added RK806 support and re-worked parts of the rk8xx drivers.
>
> changes since v1:
>    - integrated Krzysztof's feedback for the bindings and the resulting
>      driver changes
>    - fixed a sparse warning
>
> link to v1:
> https://lore.kernel.org/lkml/20240321143911.90210-2-knaerzche@gmail.com/
>
> changes since v2:
>    - integrated Krzysztof's feedback to v2 of the bindings and the resulting
>      driver changes
>
> link to v2:
> https://lore.kernel.org/lkml/20240323085852.116756-1-knaerzche@gmail.com/
>
> changes since v3:
>    - integrated Krzysztof's feedback to the bindings of v3
>    - integrated Lee's feedback to the mfd part of v3
>
> link to v3:
> https://lore.kernel.org/lkml/20240323132757.141861-2-knaerzche@gmail.com/
>
> Please see individual patches for details about the changes.
>
> Alex Bee (5):--
>    dt-bindings: mfd: Add rk816 binding
>    mfd: rk8xx: Add RK816 support
>    pinctrl: rk805: Add rk816 pinctrl support
>    regulator: rk808: Support apply_bit for
>      rk808_set_suspend_voltage_range
>    regulator: rk808: Add RK816 support
>
>   .../bindings/mfd/rockchip,rk816.yaml          | 274 ++++++++++++++++++
>   drivers/mfd/Kconfig                           |   4 +-
>   drivers/mfd/rk8xx-core.c                      | 104 +++++++
>   drivers/mfd/rk8xx-i2c.c                       |  45 ++-
>   drivers/pinctrl/pinctrl-rk805.c               |  69 +++++
>   drivers/regulator/rk808-regulator.c           | 218 +++++++++++++-
>   include/linux/mfd/rk808.h                     | 144 +++++++++
>   7 files changed, 851 insertions(+), 7 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/mfd/rockchip,rk816.yaml
>

