Return-Path: <linux-kernel+bounces-167320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F21F08BA7D3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FE771C2175D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 07:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2091F1474B9;
	Fri,  3 May 2024 07:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4RSiuhw"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB789139CF1;
	Fri,  3 May 2024 07:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714721512; cv=none; b=JrWTLZC1Qv3LvPuodqZ5sPb3esB41AfFXMk0O2IITGeuBGH4UIgPHa9Vdljtf9xwivWzx5lbxhz5u9zL56zUqzvfSPcqo7w4ZhU01Tacj/DqfRLj+ZHwkcaR25znrBb2BXX0zAa4K3bklW55dVel38xSCsF6y0iVBUlKYmbN9PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714721512; c=relaxed/simple;
	bh=z8iGdLewHVDyU+iakSdGIIswwj50C1Gpp+xOcNLZtdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PqYnTRNsMHGRx5WytjPERoOne+FdQPD1sHw/NLvHINp1zLfizISptZcLRjel/IO7SWOAJxjxcP+peyW1gbMY/6/1xIGHSg/VFmCHBaKL0KUgbC3ZDo1FV7zNZKQaj159LAF1W/DU5cOsZ/Epl1ACUDDyMI1lnzGkU0gG35WLd98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K4RSiuhw; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51f0f6b613dso2177949e87.1;
        Fri, 03 May 2024 00:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714721509; x=1715326309; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8nIAbUzFZ0W2jGneqHDrLTTJJlX3iJTnQjqRXAlljl4=;
        b=K4RSiuhwvtuQIrqxbHRaKqFpZpAN0pDIA032PPcTHNfDW/cqRebUzAOC4OyUtFWOVj
         TePY8OAl4zp4EDlYbgEtlest416t4A7hmRAPf5DRVkSl6aU9MOxG15syAmWkECyn+1B+
         pfFcpGACn5etKYbk0S/+4FV7h8Buw8HiKNfE46ol63DN2nFeVccfG8M7kSjJjp9ra5kx
         fGceH30VDXwjQPq6Fdd30gTU73NRz2H3c6fY05PlFAjxAI1N9y1/FSoHoDbUfMTnEDtx
         DHMnOuWo9OjWWnFken/0UAXfFmyff7wKhUhKP8rZRpArU2p5laV7b3+HlIWBgoqXe0lb
         1t0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714721509; x=1715326309;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8nIAbUzFZ0W2jGneqHDrLTTJJlX3iJTnQjqRXAlljl4=;
        b=M8FfsIeiMf98Z7l01ktiUpirpnZPgvsM3YrGeu7PJSDQfOS6KGM0OToEdkL4pppzS2
         iZ0iR5H548/EaV5h19kfvTIay7Ec5fD4WsvSyGQFxQ10/PJb3xb87j/XMPWwMsXtZvoG
         E49vRjwhwTyaCdg0h+oZQY0rtUIc8icQycsRp3kq4h1+lAeXfNaY1Pqln+tOjN3JaMw3
         xPtmFsC978Yzk36Yotilp8teT7upbD7BeEwTpTmL9DQE2m1rg3IJAElj0Ul82lEgI0u9
         oAALp5aBeyOq0p34CdWiVPjnIflbS9fxR/9/f3n0aDlMxo2Ao2z4FPMBBi1cr5fhuBeW
         AbOg==
X-Forwarded-Encrypted: i=1; AJvYcCVOC+0KsrCeYM5DGt7aDDX90GYQIXKArbg2dPD/4fDW7/kTtnwi5XXBEWqWk6xnKSUP5SJLE6mDNjALUBDUq9i67PO0fbb4T0bgr7LDqteZo7JFGJEQaWE7XZnQjUPCP7lVCiFju8NaqtrctXlrg3OgxZo/hY/bWxkD9GhuAO4YwQ/Uza8xLT61oD1RYZK229CBCXCY2k0qbh350WarP9IbrQ6MeQCijyeZZK8nRcc=
X-Gm-Message-State: AOJu0Yzryiny1W5AjynLvydE7uxWZEwZE57f16sppyEfXscVcnFr1Ag3
	avTIl5zUBUokxlBJEVj3hcbA4a+76SRIYOzIZj5veKtxCqIEBDxk
X-Google-Smtp-Source: AGHT+IFsUViOgQWBfed0iW3it0Tz8tCjvrW37J5LJ5nqlT1r2qRnsl694GKdCGtShTdCqT/cBC7gsQ==
X-Received: by 2002:a05:6512:3ba:b0:51c:d528:c333 with SMTP id v26-20020a05651203ba00b0051cd528c333mr570067lfp.20.1714721508677;
        Fri, 03 May 2024 00:31:48 -0700 (PDT)
Received: from [172.16.183.82] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id x27-20020ac259db000000b0051d71292d5bsm450650lfn.74.2024.05.03.00.31.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 00:31:47 -0700 (PDT)
Message-ID: <017b2462-f9c9-42c0-bfd9-1a0e76d2ea3d@gmail.com>
Date: Fri, 3 May 2024 10:31:46 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: mfd: Use full path to other schemas
Content-Language: en-US, en-GB
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-renesas-soc@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20240503072116.12430-1-krzysztof.kozlowski@linaro.org>
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20240503072116.12430-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/3/24 10:21, Krzysztof Kozlowski wrote:
> When referencing other schema, it is preferred to use an absolute path
> (/schemas/....), which allows also an seamless move of particular schema
> out of Linux kernel to dtschema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   .../bindings/mfd/actions,atc260x.yaml         |  6 +--
>   .../devicetree/bindings/mfd/brcm,cru.yaml     |  8 ++--
>   .../devicetree/bindings/mfd/brcm,misc.yaml    |  2 +-
>   .../bindings/mfd/canaan,k210-sysctl.yaml      |  6 +--
>   .../bindings/mfd/delta,tn48m-cpld.yaml        |  4 +-
>   .../devicetree/bindings/mfd/iqs62x.yaml       |  4 +-
>   .../bindings/mfd/kontron,sl28cpld.yaml        | 10 ++--
>   .../devicetree/bindings/mfd/max77650.yaml     |  8 ++--
>   .../bindings/mfd/maxim,max77686.yaml          |  2 +-
>   .../bindings/mfd/maxim,max77693.yaml          |  2 +-
>   .../bindings/mfd/richtek,rt4831.yaml          |  4 +-
>   .../bindings/mfd/ricoh,rn5t618.yaml           |  6 +--
>   .../bindings/mfd/rockchip,rk805.yaml          |  2 +-
>   .../bindings/mfd/rockchip,rk808.yaml          |  2 +-
>   .../bindings/mfd/rockchip,rk817.yaml          |  2 +-
>   .../bindings/mfd/rockchip,rk818.yaml          |  2 +-
>   .../bindings/mfd/rohm,bd71815-pmic.yaml       |  2 +-
>   .../bindings/mfd/rohm,bd71828-pmic.yaml       |  4 +-
>   .../bindings/mfd/rohm,bd71837-pmic.yaml       |  2 +-
>   .../bindings/mfd/rohm,bd9571mwv.yaml          |  2 +-
>   .../bindings/mfd/rohm,bd9576-pmic.yaml        |  2 +-

For the ROHM stuff,
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

>   .../bindings/mfd/samsung,s2mpa01.yaml         |  2 +-
>   .../bindings/mfd/samsung,s2mps11.yaml         | 12 ++---
>   .../bindings/mfd/samsung,s5m8767.yaml         |  4 +-
>   .../devicetree/bindings/mfd/st,stmfx.yaml     |  2 +-
>   .../devicetree/bindings/mfd/st,stpmic1.yaml   |  4 +-
>   .../bindings/mfd/stericsson,ab8500.yaml       | 48 +++++++++----------
>   .../bindings/mfd/stericsson,db8500-prcmu.yaml | 40 ++++++++--------
>   .../devicetree/bindings/mfd/ti,tps65086.yaml  |  4 +-
>   29 files changed, 99 insertions(+), 99 deletions(-)
>
Thanks!

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


