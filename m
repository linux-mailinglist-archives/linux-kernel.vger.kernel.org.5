Return-Path: <linux-kernel+bounces-5143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2470818703
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BD87286F20
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C613E171B9;
	Tue, 19 Dec 2023 12:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wTZJctSb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD3518645
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 12:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-54c7744a93fso5448617a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 04:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702987591; x=1703592391; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/exb5wVX9siMDyUcgM5UGDFi2b5saHGKkBIlCfEkmUg=;
        b=wTZJctSbPTCNee+qKneBxja3I1fmxXLC74rWXhSKhZRpJu99k7xKy7HA7cIbYwpG+o
         bQ8bPtCGwno+C37JXT354F2XnFf8M3VjCWzc2c3YZIh1z4UYulkZ2ox/+K+ZgB2R5xb7
         OURO0uXZXqS2y1dSoM3clb/ataos/wItTh3ZPx5SC9KqMmT4VbSCQ3mCb20/iZ1ScFcd
         7oI6hGd1rmermNy4Qrbk9E9ZRndVIMNzsUk1wZvqsOlIwvshxnu+8fGEuqckFLdD2wYP
         8Axfn38dK1vVuwSC0xE3D0T245rdUdMw3Fp/em8EV75DMEZmFBwCyl4+Z4jSokDRBm57
         ya7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702987591; x=1703592391;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/exb5wVX9siMDyUcgM5UGDFi2b5saHGKkBIlCfEkmUg=;
        b=W5ATILbF0Hr4vSz5ex4+g02Ul7UM83lTBXzq8VPe2cAX5sLlcXizzTv0i+etgbSpYy
         B/KXhgD3m7ez3nqCtLOw6lC/Jjn8BJyg/d92mrqX8omPnQ+LRSNB70c7uSn7H9BwOBcf
         V88hey6RNN8SEES9vPuSeVrs1HkrSaXIYlOz4erY4/XSolcW0/QD9ybD7aGvyfqM20LE
         RP3/GOfMWbBrFsjN/8rxenSxyYeHkvxuhugJuIKLdAuZPz6iu5VlT7dU5lPr+FDs87Iy
         pEzNFGSsGZxzTOmjSK1r/SXQoAKbng62RfC0mq+G50bK4qKb/colMHYwFEk3R8/OLg04
         mTZw==
X-Gm-Message-State: AOJu0YwcPLgpCUElBckXo2MbDlep6hcSDtDi+HGdWYuoKSS8fownEDjl
	LeiBgcTpxd2w+OUKnupzc0j0tQ==
X-Google-Smtp-Source: AGHT+IF6CdAeGP0WSJV+oc6kbgx/fFcGs4VJZwum8AjL3WAlT6tNIgmXHK5cfvA71s5C7jrixbLcUQ==
X-Received: by 2002:a17:906:518b:b0:a23:648b:34f5 with SMTP id y11-20020a170906518b00b00a23648b34f5mr1240276ejk.16.1702987590959;
        Tue, 19 Dec 2023 04:06:30 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id rg8-20020a1709076b8800b00a1f7cbf2896sm14306470ejc.176.2023.12.19.04.06.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 04:06:29 -0800 (PST)
Message-ID: <58ded02d-a5d2-40e2-b575-dc520a7553cf@linaro.org>
Date: Tue, 19 Dec 2023 13:06:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] clk: samsung: Fix typo error and extra space
To: Varada Pavani <v.pavani@samsung.com>, mturquette@baylibre.com,
 sboyd@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, s.nawrocki@samsung.com, tomasz.figa@gmail.com
Cc: linux-samsung-soc@vger.kernel.org, alim.akhtar@samsung.com,
 aswani.reddy@samsung.com, pankaj.dubey@samsung.com
References: <20231219115834.65720-1-v.pavani@samsung.com>
 <CGME20231219115858epcas5p469e925738bcb93ee88842fdea0f9d3f0@epcas5p4.samsung.com>
 <20231219115834.65720-2-v.pavani@samsung.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231219115834.65720-2-v.pavani@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/12/2023 12:58, Varada Pavani wrote:
> Remove extra spaces and fix spelling mistakes in 'drivers/
> clk/samsung/clk-cpu.c' and 'drivers/clk/samsung/clk-cpu.h'
> 
> Signed-off-by: Varada Pavani <v.pavani@samsung.com>
> ---
>  drivers/clk/samsung/clk-cpu.c | 6 +++---
>  drivers/clk/samsung/clk-cpu.h | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/samsung/clk-cpu.c b/drivers/clk/samsung/clk-cpu.c
> index 3e62ade120c5..18568b8b1b9b 100644
> --- a/drivers/clk/samsung/clk-cpu.c
> +++ b/drivers/clk/samsung/clk-cpu.c
> @@ -19,7 +19,7 @@
>   * clock and the corresponding rate changes of the auxillary clocks of the CPU
>   * domain. The platform clock driver provides a clock register configuration
>   * for each configurable rate which is then used to program the clock hardware
> - * registers to acheive a fast co-oridinated rate change for all the CPU domain
> + * registers to achieve a fast co-oridinated rate change for all the CPU domain
>   * clocks.
>   *
>   * On a rate change request for the CPU clock, the rate change is propagated
> @@ -181,7 +181,7 @@ static int exynos_cpuclk_pre_rate_change(struct clk_notifier_data *ndata,
>  	 * If the old parent clock speed is less than the clock speed of
>  	 * the alternate parent, then it should be ensured that at no point
>  	 * the armclk speed is more than the old_prate until the dividers are
> -	 * set.  Also workaround the issue of the dividers being set to lower
> +	 * set. Also workaround the issue of the dividers being set to lower

Why? The double-space is correct.

>  	 * values before the parent clock speed is set to new lower speed
>  	 * (this can result in too high speed of armclk output clocks).
>  	 */
> @@ -303,7 +303,7 @@ static int exynos5433_cpuclk_pre_rate_change(struct clk_notifier_data *ndata,
>  	 * If the old parent clock speed is less than the clock speed of
>  	 * the alternate parent, then it should be ensured that at no point
>  	 * the armclk speed is more than the old_prate until the dividers are
> -	 * set.  Also workaround the issue of the dividers being set to lower
> +	 * set. Also workaround the issue of the dividers being set to lower

Why?

>  	 * values before the parent clock speed is set to new lower speed
>  	 * (this can result in too high speed of armclk output clocks).
>  	 */
> diff --git a/drivers/clk/samsung/clk-cpu.h b/drivers/clk/samsung/clk-cpu.h
> index fc9f67a3b22e..e0a1651174e6 100644
> --- a/drivers/clk/samsung/clk-cpu.h
> +++ b/drivers/clk/samsung/clk-cpu.h
> @@ -33,7 +33,7 @@ struct exynos_cpuclk_cfg_data {
>   * @hw:	handle between CCF and CPU clock.
>   * @alt_parent: alternate parent clock to use when switching the speed
>   *	of the primary parent clock.
> - * @ctrl_base:	base address of the clock controller.
> + * @ctrl_base: base address of the clock controller.

Why only here and not in other places?

Best regards,
Krzysztof


