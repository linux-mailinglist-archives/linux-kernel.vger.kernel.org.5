Return-Path: <linux-kernel+bounces-13129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F470820018
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 16:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4750328471D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 15:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB5511CBD;
	Fri, 29 Dec 2023 15:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EO+B0mM7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743E0125A4
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 15:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50e7abe4be4so4672175e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 07:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703862321; x=1704467121; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LI8tZ4xmGQoPWoAmYH9zktwI7/vEBWrFa18ETiwGSuM=;
        b=EO+B0mM7HowwbGLsYgjiy6jEH+BRhfQiPlMyuey37QVzsI1X2GhFNdiBTHbkd/Lekv
         C9WA8Nx+iVJjkkXFGS/M3cyJgoTmhN7oTdn4i3rFMDw24tNx9AUf2aPYFTBz+OaKiwes
         V9o2FPUofR9ZPqIjRptKVCi68BZ2LSKtgJtcBTdP2Lqh8dwecGgLRoXYi+RGyDU5LJB/
         TX8DoEMQVkl3J2ySY3o8BkOHuBP8cXlwMlKZPJJF02LHwHp0EC30lVYcW7wN0J9tr/iK
         zCb+0Jpon49Fk8ZCy/gHQ+IjUkWIFCY18UzxM+Q7aKt+iWJAuxzs5OdqvmIyxulDNrAJ
         aSXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703862321; x=1704467121;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LI8tZ4xmGQoPWoAmYH9zktwI7/vEBWrFa18ETiwGSuM=;
        b=pjCbkyIoXo2IHUOraK4dTpCH6wCVD9gBs/42CeJThM+xWbS2ZW5ZDzVHi70sfgsMjh
         DQ0Rl+76DiSACFReB41pdBZgrwpRO71GxGucokfTpuJ9tRm7GoqHVdKUpsBuBCTGAbSj
         8u6ozHVYHx//jlaxgC0J6IvdonWRpCMBceRtACTSGFKTbXosiU/HyILTC1Qc1ICD5HAw
         Otz9rvY6Is0fVTJi6w2P8m6Sm2kq2TtA7osQCxxIMdom2rhcvRWOpqYVQHU1ml1lvPoa
         BUnSvJjQqZ86E+pULobsW1osYOrw7MVABPJRaRwOVkZz9ArsX2Dw48KloV2jYDRhJBjA
         H0dw==
X-Gm-Message-State: AOJu0Yx3XcGiCGacWsx+evyhjvPKVdAOj30pPUTlMu14H+j76E1Rp0uI
	6up5BalgeS5WZj9ad8WbGfVHQbJmG3928w==
X-Google-Smtp-Source: AGHT+IHtqF4araK/7HsfoTLOgdzip7g33hgiJXUjY4pAbP43QnQJKUFmRNfVvcHPMJ8E0UbKWjiL1w==
X-Received: by 2002:a05:6512:3592:b0:50e:6a07:5c02 with SMTP id m18-20020a056512359200b0050e6a075c02mr4698769lfr.15.1703862321464;
        Fri, 29 Dec 2023 07:05:21 -0800 (PST)
Received: from [192.168.199.125] (178235179036.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.36])
        by smtp.gmail.com with ESMTPSA id bg10-20020a170906a04a00b00a26a443e98esm8225174ejb.169.2023.12.29.07.05.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Dec 2023 07:05:21 -0800 (PST)
Message-ID: <11aa0b82-ddab-4b65-8f49-54e15e0ce44e@linaro.org>
Date: Fri, 29 Dec 2023 16:05:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sc8280xp: Correct USB PHY power
 domains
Content-Language: en-US
To: Johan Hovold <johan@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Johan Hovold <johan+linaro@kernel.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Konrad Dybcio <konrad.dybcio@somainline.org>
References: <20231227-topic-8280_pcie_dts-v1-0-13d12b1698ff@linaro.org>
 <20231227-topic-8280_pcie_dts-v1-2-13d12b1698ff@linaro.org>
 <ZY7DEpaIgvfL_A11@hovoldconsulting.com>
 <b730bf22-fa3a-4720-9fd1-79d2207d6812@linaro.org>
 <ZY7I1brn0chtOzis@hovoldconsulting.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <ZY7I1brn0chtOzis@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29.12.2023 14:25, Johan Hovold wrote:
> [ Please remember to trim your replies and add a newline before your
>   inline comments to make them readable. ]
> 
> On Fri, Dec 29, 2023 at 02:06:26PM +0100, Konrad Dybcio wrote:
>> On 29.12.2023 14:01, Johan Hovold wrote:
>>> On Wed, Dec 27, 2023 at 11:28:27PM +0100, Konrad Dybcio wrote:
> 
>>>> Fix the power-domains assignment to stop potentially toggling the GDSC
>>>> unnecessarily.
>>>
>>> Again, there's no additional toggling being done here, but yes, this may
>>> keep the domains enabled during suspend depending on how the driver is
>>> implemented.
> 
>> No, it can actually happen. (Some) QMP PHYs are referenced by the
>> DP hardware. If USB is disabled (or suspended), the DP being active
>> will hold these GDSCs enabled.
> 
> That's not a "toggling", is it? Also if the DP controller is a consumer of
> these PHY's why should it not prevent the PHYs from suspending?

As far as I'm concerned, "toggling" is the correct word for "switching it
on".. While the PHYs are indeed useful for getting displayport to work,
the USB controller itself may not be necessary there, so enabling its
power line would be a bit of a waste..

Konrad

