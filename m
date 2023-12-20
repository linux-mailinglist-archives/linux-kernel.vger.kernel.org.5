Return-Path: <linux-kernel+bounces-6803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7576819DC6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 060CF1C21116
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404E621340;
	Wed, 20 Dec 2023 11:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kW/MYHzA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F690210F3;
	Wed, 20 Dec 2023 11:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40d38f03712so1577295e9.2;
        Wed, 20 Dec 2023 03:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703070976; x=1703675776; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V1l9W12oVHW6Mudh64wfNHZpVn/IQivfs/Wow957VWA=;
        b=kW/MYHzAOkw8dS3GGUcGXImYshzE2EkqAuQZrYxyo+f4qJuUVUHfXzjDa1NZ3dnVm0
         LPfthXQg/IZ/C7wgb4w6C7lF49kzURBwPoTNk1zam/UjfaE0AslLKOPASktLa582AMUp
         uVjvcStWEJwKb1scslB/5Am0FjXJF5tC8WZZPUyeEkw8VIQyB4EHAowmZzur39NIIKvr
         yXSDmL0dPH7Z21NCDj1oFYZxJpPUmdfbQGDzcSnmifTkAafEp/wUeVBySfKk1fnG4JXx
         8DvY0ez3ApcLOdVsNr460RGk/XEyQ8Vg4uH2EbU/W8lM0Ijc+PLB0Rg+iv3a4rA+huXy
         6pVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703070976; x=1703675776;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V1l9W12oVHW6Mudh64wfNHZpVn/IQivfs/Wow957VWA=;
        b=NCGEBNDkToUHHUpQn0h8TmpAicQFxGoBE4OBII6SoeTnMhYTn3U0kEoTtGhOBbPBSb
         LcHwhRP6yyX4U9vgHfUbG/urbyvk2POmBwXrA9mzj2+o4nfVsSxthY9UPZ0uWTLwrMqE
         vTKiXNeo3k5pH5LdjWLYkahKBTpL3bsWbsTsxcdM2+8rUr/QCQotsgu8aASE+1/+6qQ8
         vUXKjeNm3tzKWs6vTcH08lIlgP71pmhPrMNGFpMvC8yukq/shVf8/F53t8calmhH/c2K
         pjMrjI2JCWfwTMHsi/38kGTFfrrZSThfCovHggWDG8/51X39ZBsc2Bpv5Yev62UU++9e
         GPxQ==
X-Gm-Message-State: AOJu0YwAZD9MLxXdT4aaWIKVHYMJWa6WH+ogJUY3Pnp4sB5mpJjR86xx
	uVqh5peP6coiAuQjWfoV/A==
X-Google-Smtp-Source: AGHT+IF5wvzfwQ+hjD/XU60WGWTBgHhchDr15sag5KKIqkbkYic8Aa8RlY878ZK2ZIERBVuyftN2RQ==
X-Received: by 2002:a05:600c:3795:b0:40b:578d:2496 with SMTP id o21-20020a05600c379500b0040b578d2496mr9056448wmr.27.1703070976123;
        Wed, 20 Dec 2023 03:16:16 -0800 (PST)
Received: from ?IPV6:2a02:810b:f40:4300:7b59:686f:618b:4bd? ([2a02:810b:f40:4300:7b59:686f:618b:4bd])
        by smtp.gmail.com with ESMTPSA id e7-20020a05600c4e4700b0040c41846919sm7051751wmq.41.2023.12.20.03.16.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Dec 2023 03:16:15 -0800 (PST)
Message-ID: <da10e2fc-3179-4bd5-88ed-b4d5f64a7191@gmail.com>
Date: Wed, 20 Dec 2023 12:16:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] ARM: dts: rockchip: Add psci for rk3036
To: Andy Yan <andyshrk@163.com>, heiko@sntech.de
Cc: krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 zhengxing@rock-chips.com, Andy Yan <andy.yan@rock-chips.com>
References: <20231218105523.2478315-1-andyshrk@163.com>
 <20231218105523.2478315-2-andyshrk@163.com>
Content-Language: en-US, de-DE
From: Alex Bee <knaerzche@gmail.com>
In-Reply-To: <20231218105523.2478315-2-andyshrk@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andy,
Am 18.12.23 um 11:55 schrieb Andy Yan:
> From: Andy Yan <andy.yan@rock-chips.com>
> 
> The system will hang at bringup secondary CPUs
> without psci node.
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> 
> ---
> 
> (no changes since v1)
> 
>   arch/arm/boot/dts/rockchip/rk3036.dtsi | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/rockchip/rk3036.dtsi b/arch/arm/boot/dts/rockchip/rk3036.dtsi
> index 78686fc72ce6..5344803442a1 100644
> --- a/arch/arm/boot/dts/rockchip/rk3036.dtsi
> +++ b/arch/arm/boot/dts/rockchip/rk3036.dtsi
> @@ -67,6 +67,11 @@ display-subsystem {
>   		ports = <&vop_out>;
>   	};
>   
> +	psci {
> +		compatible = "arm,psci-1.0";
> +		method = "smc";
> +	};
> +
I don't think that's an good idea. You most likely need that because you 
have downstream bootloader installed on this board. PSCI implementation 
takes place in TEE-OS for Rockchips ARM SoCs. There is no support for 
RK3036 in upstream op-tee OS. It's pretty much the same for RK3128 and 
RK3288.
If you use upstream u-boot it should be good as-is.

Alex
>   	timer {
>   		compatible = "arm,armv7-timer";
>   		arm,cpu-registers-not-fw-configured;


