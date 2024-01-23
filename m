Return-Path: <linux-kernel+bounces-35238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 797AE838E40
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC16B1C2328B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BE15DF0A;
	Tue, 23 Jan 2024 12:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cACebxdL"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AFF5A787
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 12:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706012108; cv=none; b=erosymj3OKcNfR5DylEsgPVGJdzs6Rcd40GDbp/JcyRi3HRUu8jm7ymn8F/G/4J1DY/IOVSp17gnMDSkSro/MQPAvnf8pBIOchUAIqIrmSSBOcMOzHlQIzxTxlxDf6Cq8vYQR0/05gAihWf6ru5s0+B9b4BuE8siLcXfpG2r8Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706012108; c=relaxed/simple;
	bh=BYGRDUQ2oYvIYx1fG3CEeY7nYdsYyMhSfFnuUClPtBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i1oml2z3tOSKFYiN+885lyo0uvk7YsxsXmMsS7tKACrNm51VTEVgefcxk0S4kAiPwHB2JV+36Gts/dni5wkCq3XkvrWxq7Wm2yuPTULvzeWsGHFxBgUTwgfS6tG8OOTj1F1ddugQYvBtuSAh8bhOf7/GDlwI9F/2xVyynTU1AW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cACebxdL; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40e775695c6so41577125e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 04:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706012105; x=1706616905; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XbySdSqyixVey9XUJl2wI2fXpfFGflTsEKME/UI6qxs=;
        b=cACebxdLDkv07rdpMjBlPi/mQGNAcukQw6qZEijNW7zXTfVuadML47Obr8ANa6CWPr
         pnXO+k9UfXM4K3ysrORzPllMSQXq1OzjwM4adcaaM3TiyOr0xeudx9KPJuNr6o79Uy1a
         q/oNS1x03ecxYRz4WxzTB79d6SvTIINlgSJ3gr9BcY1aZxH6hohpVsGvmVpEY2TskeaG
         Oz8YTxbKB/m/TL8klYouJCZbtsjITmNPadeLzWqTAuKtoMRy9kWTXNoDFYViBduuJRSW
         GBCPE6kN+OCpmeD/xCt31PlhcEWLVyGME4daA47ju7KjGKQzyMNgAibLL2Lo3B4qI6cS
         sSbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706012105; x=1706616905;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XbySdSqyixVey9XUJl2wI2fXpfFGflTsEKME/UI6qxs=;
        b=ic8zn+cQ5aj+3rat0OkKouEyrwFwmzVWUwlwOhtA36+Ca9nZmsL5MMXSVoZKubWJMH
         3Uby2bT12khx6pQHUASYAlRoJ6bLuEL6USg520xEIJT6hTdBqYfA7pYC7iDvwXF1cJ+Q
         Y/KI3JqaOnkcyL0Hotbo1L9NOKvg9COvRvafDh+CT1UMANJ8l+vt1Uex4bF9+Kw0VB1V
         +/UOurxreXBtBhs79HW4Ol+U+QVVSQkOfxFhfG513bU0vUud+I4x9BLAI0XsqkpRZI1E
         DEX9HAh5b3F7f6j21U9+CZFYyCUMijCAw56TYdXkymzr6eOrPgwcVvUIpiQDCsph7qaY
         Edqw==
X-Gm-Message-State: AOJu0YwPF4LXl68ScZDBlGpaQ+ySI19h7aWsxwYJIw2tHR4jJL3raEJL
	NiJzCxcHm5SzI2gNygOr8Bq+50lXQZQRAubSKuXh4eU8IG1lbT++1njhT+mywQg=
X-Google-Smtp-Source: AGHT+IFg6AdpL8JP+l2IT0GeSA2/bMT2+fhZ1Wv/iLLjQ1khFfEweOmoWKHaQUax2h/ibbZH23lxYQ==
X-Received: by 2002:a05:600c:4f52:b0:40e:6b7f:5ca9 with SMTP id m18-20020a05600c4f5200b0040e6b7f5ca9mr567647wmq.80.1706012104886;
        Tue, 23 Jan 2024 04:15:04 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id bi25-20020a05600c3d9900b0040ea5ae94acsm11653024wmb.27.2024.01.23.04.15.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 04:15:04 -0800 (PST)
Message-ID: <9da1e9bf-0b3e-481e-a9c5-016238ee93ca@linaro.org>
Date: Tue, 23 Jan 2024 13:15:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] dt-bindings: clock: support NXP i.MX95
Content-Language: en-US
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, abelvesa@kernel.org,
 mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com
Cc: devicetree@vger.kernel.org, linux-imx@nxp.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Peng Fan <peng.fan@nxp.com>
References: <20240122013239.1434383-1-peng.fan@oss.nxp.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240122013239.1434383-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/01/2024 02:32, Peng Fan (OSS) wrote:
> +
> +/* The index should match i.MX95 SCMI Firmware */
> +#define IMX95_CLK_32K                       1
> +#define IMX95_CLK_24M                       2
> +#define IMX95_CLK_FRO                       3
> +#define IMX95_CLK_SYSPLL1_VCO               4
> +#define IMX95_CLK_SYSPLL1_PFD0_UNGATED      5
> +#define IMX95_CLK_SYSPLL1_PFD0              6
> +#define IMX95_CLK_SYSPLL1_PFD0_DIV2         7
> +#define IMX95_CLK_SYSPLL1_PFD1_UNGATED      8
> +#define IMX95_CLK_SYSPLL1_PFD1              9
> +#define IMX95_CLK_SYSPLL1_PFD1_DIV2         10
> +#define IMX95_CLK_SYSPLL1_PFD2_UNGATED      11
> +#define IMX95_CLK_SYSPLL1_PFD2              12
> +#define IMX95_CLK_SYSPLL1_PFD2_DIV2         13
> +#define IMX95_CLK_AUDIOPLL1_VCO             14
> +#define IMX95_CLK_AUDIOPLL1                 15
> +#define IMX95_CLK_AUDIOPLL2_VCO             16
> +#define IMX95_CLK_AUDIOPLL2                 17
> +#define IMX95_CLK_VIDEOPLL1_VCO             18
> +#define IMX95_CLK_VIDEOPLL1                 19
> +#define IMX95_CLK_RESERVED20                20
> +#define IMX95_CLK_RESERVED21                21
> +#define IMX95_CLK_RESERVED22                22
> +#define IMX95_CLK_RESERVED23                23
> +#define IMX95_CLK_ARMPLL_VCO                24
> +#define IMX95_CLK_ARMPLL_PFD0_UNGATED       25
> +#define IMX95_CLK_ARMPLL_PFD0               26
> +#define IMX95_CLK_ARMPLL_PFD1_UNGATED       27
> +#define IMX95_CLK_ARMPLL_PFD1               28
> +#define IMX95_CLK_ARMPLL_PFD2_UNGATED       29
> +#define IMX95_CLK_ARMPLL_PFD2               30
> +#define IMX95_CLK_ARMPLL_PFD3_UNGATED       31
> +#define IMX95_CLK_ARMPLL_PFD3               32
> +#define IMX95_CLK_DRAMPLL_VCO               33
> +#define IMX95_CLK_DRAMPLL                   34
> +#define IMX95_CLK_HSIOPLL_VCO               35
> +#define IMX95_CLK_HSIOPLL                   36
> +#define IMX95_CLK_LDBPLL_VCO                37
> +#define IMX95_CLK_LDBPLL                    38
> +#define IMX95_CLK_EXT1                      39
> +#define IMX95_CLK_EXT2                      40
> +
> +#define IMX95_CCM_NUM_CLK_SRC               41

All my comments from previous version or for other patchsets you sent
recently apply.

Best regards,
Krzysztof


