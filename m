Return-Path: <linux-kernel+bounces-155258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CABFB8AE7A5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07ED21C23626
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0EA134CC0;
	Tue, 23 Apr 2024 13:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TgYB3Kad"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C6E12C528
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 13:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713877875; cv=none; b=c9W6kEIkmkNJOKIlkxI9r3q87LGk/EqBxVd4+8uqnDQsfeWRnsfglGVuYWN5Lfin0w6rPBsjOzwK8AcMO/pMjVuf+qvYiCt3r+nSrs48Iqr38YSb1sAvREAs9LOMLvNpayQ6TnAxvXaXrYBPtu/HeNW7HxJwsH++Uadx8eMDCrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713877875; c=relaxed/simple;
	bh=EKiFUNWp2CVL7UdhgyBqmC8Xr2ctOjFiU0OMBH/KQs8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JjeMtUHR0mn9dk5oCMK5SKT7dfJ/yX+mXcBxyXUZG5gEvyKepDznBoiLzWVk92sd3hUgrcBplfun2u97BroQMF2k0OQRRmK6hDIk3HfvlGT0ZpgHJpQIKnRxYva+DxYJ4/mdSGgg2KbxgVBKe8lbAimKAZWhyo8Vubn/2Jo1EjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TgYB3Kad; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d8b194341eso56094551fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 06:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713877871; x=1714482671; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ljVofaMz5XK05sXcsxWO2zq54dDkOVWRiaigypPdLmw=;
        b=TgYB3Kade/ZeRX24pgwtEgyFUiYPjqgVxorw6P9BaCZ4/m8ZoTCb8mQLzrG7cY5KcC
         4AjDcN2I/IjPIir+AOPjP4bLAlmyHrAdpcZlmBY/hTn1+csCKFD+KiIIQLEyPS2Eomcv
         8qgvA8yH3AVX+dEZUImgxgwW58S0V3JCMNHYDXhJo9/GjVdd250fVt7Z6aOTHpWUyuLZ
         8cvgk2zsrCIO39iPSVgOuaHPfMOg1sH9Wh8hiz4jCPRGro3APlKflCiH1DQBeKLEE6zf
         yzThZMy4QQdYOT5nDxEGPKcpiQ+Qk8uVFk6VGTWaxBV/AtRUFCBt5G5V2oeQzw/fhQmX
         MXMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713877871; x=1714482671;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ljVofaMz5XK05sXcsxWO2zq54dDkOVWRiaigypPdLmw=;
        b=OsI8TSU8gRwnbdL3dB8+Izo343pMW38w96mwHAzi3/3NWyiU/6CqdX4ivBuCQVX1xI
         rVaF+osvE0qloPiZciu5YF+QPVCxhqaenpUIaZT6tjKM5Gm8VZ464umfQHoP/RIIMILH
         utEl7vOZcSZN29q9lsrXvxJbh/cRHpOztqVJikBPoFManJGKC5ZjZ1KAVKr6Q7ckIiHS
         U9v8EGUIvNoswnruoYN0K4ryUimoaOIdrELopkqXoviS8BkNVGqR01kpzPu8+m9IGTHG
         Wu3PFqXigsVF2seGrn52gaF0nZJLAgXXokdAapqCBTXSbs21E7GmcHIfvVtiqk0FNPAv
         2Edw==
X-Forwarded-Encrypted: i=1; AJvYcCV7NzDAMW6Df+cjQ+UsiyFwFft9v5Nrkx1yIuep0EkiU8wz+WQ9fT330khhCdnttHnLD09rkVBxqkRh+rq+raRZvaj1P7dGzfn9Cg7K
X-Gm-Message-State: AOJu0Yxwj7ITxuxr0mjOr+ryVlBavufst7KI1+2abW1OtPBuB1jThr1r
	cv4+3cweXTPF4278L6Lv2PGNcXhrnrLOBjhcmrChYObbxbTlJQH9HC9ZGVK2qMiOB5TQ6JwU62X
	G
X-Google-Smtp-Source: AGHT+IH6+a300iDdirczkNG89v3OWEFzlKL6UcHimIG4AYRQ19LBvrY3ZDkgjW/buxJ28WPKLxuKTg==
X-Received: by 2002:a2e:9995:0:b0:2da:46ca:25ad with SMTP id w21-20020a2e9995000000b002da46ca25admr8218339lji.44.1713877871520;
        Tue, 23 Apr 2024 06:11:11 -0700 (PDT)
Received: from [172.30.205.0] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id r28-20020a2e8e3c000000b002d28db9ce7bsm1741252ljk.20.2024.04.23.06.11.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 06:11:10 -0700 (PDT)
Message-ID: <3054961d-251e-4e70-b907-4949cfacca96@linaro.org>
Date: Tue, 23 Apr 2024 15:11:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: sm7225-fairphone-fp4: Enable USB
 role switching
To: Luca Weiss <luca.weiss@fairphone.com>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240329-fp4-tcpm-v2-0-d7f8cd165355@fairphone.com>
 <20240329-fp4-tcpm-v2-3-d7f8cd165355@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240329-fp4-tcpm-v2-3-d7f8cd165355@fairphone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/29/24 13:26, Luca Weiss wrote:
> Configure the Type-C and VBUS regulator on PM7250B and wire it up to the
> USB PHY, so that USB role and orientation switching works.
> 
> For now USB Power Delivery properties are skipped / disabled, so that
> the (presumably) bootloader-configured charger doesn't get messed with
> and we can charge the phone with at least some amount of power.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

nits:

> +	usb-role-switch;

this is a common property of the dwc3 host


[...]

>   	vdda-phy-supply = <&vreg_l22a>;
>   	vdda-pll-supply = <&vreg_l16a>;
> +	orientation-switch;

and this is a common property of the QMPPHY

Could you move them to the node definition?

Konrad

