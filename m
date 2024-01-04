Return-Path: <linux-kernel+bounces-16395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5350A823DD7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 09:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D18471F24C1F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 08:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02A51E524;
	Thu,  4 Jan 2024 08:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L+F+CNn/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E4720314
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 08:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a28aa47bd15so27486666b.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 00:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704358086; x=1704962886; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yz8L5rcS/oZQG0JzRb54lfQRZQgbbjO7+jKrtemXPv4=;
        b=L+F+CNn/ILzYTfOsS7ybnHoe/BDWHJj8peDKWfmwAtrKegKWrxeIdw2ow0/+5j6pg2
         ViCjI/tSdLQ16bQ5RUc4ag/CPNZP7l3BsE3pm75eDg9P4YPslBcUqKHnx8aD9POckrdM
         8Dy4W+Jnj8o8xo4IZBZKid5qKdJaJ3BtNDBEx7xpTOT2WEyrOB7+5qPQc4ax09mvZWdK
         o4PBV7uQs2h7Dbah03PNaGIV5SSnzxogQjlnZ8hteBjEV0tM4Zd5LYuhkV9s7mxJQJly
         mYPtrqApwJHp1tATNylfba0RexVMPhsQp2XwM/37qmoejBf7LCR5LefZORdHA252Irvs
         Xvhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704358086; x=1704962886;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yz8L5rcS/oZQG0JzRb54lfQRZQgbbjO7+jKrtemXPv4=;
        b=Ja5ZamZ+OiFA+3iGnTwsgsr/dySgskLsQuN+9OZPjwr5X2/fGuBTV+M+PZE1GdUfpl
         KPBYDwZmWmHTM/ksFArCZOIHnd6BZ0iKElGAfdB+SzYZAiSO7GnTqoq2mvQbKiQFYGDj
         8vgNCaXVaYJIIa9hNb3jD0l1zL1QSc5NtVFnfnByPR+hsNKbIapRf8SvdsL66cfxV4Kp
         36UX4VcIyFeiSdbkL7UjVlE9BPz8rqSXpiS6sG3wl2kyDEREnq97O1f0nk33ALWPjvQc
         q2/N38Wzu6zrvF+8ZrYH+Pia1GnoSXie9e8+1TaMhu92MKXfoCD+xz5AtZOcw/8Cecn+
         ESzg==
X-Gm-Message-State: AOJu0Yw6vGE+n5H0rqPg6+29vJ5Iv2jrgvrbBf3sFv+j5PO7AaY8p9fe
	LWUwYZNTd+fRmJuWOStiKp4OOLcqU7B31w==
X-Google-Smtp-Source: AGHT+IErboZlZUNTK/tkXvn3hKifzKAK/kYmSKAFSgzlTSjZGbp/TRrtj4IWK+r9w/xjGiFvDysZmQ==
X-Received: by 2002:a17:906:33d9:b0:a23:6244:8370 with SMTP id w25-20020a17090633d900b00a2362448370mr156939eja.142.1704358085794;
        Thu, 04 Jan 2024 00:48:05 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id ka24-20020a170907921800b00a26a80a58fcsm13126060ejb.196.2024.01.04.00.48.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 00:48:05 -0800 (PST)
Message-ID: <71cf6e71-6273-4305-8fc4-44df6ce35eda@linaro.org>
Date: Thu, 4 Jan 2024 09:48:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] clk: sprd: Add dt-bindings include file for UMS9620
Content-Language: en-US
To: Chunyan Zhang <chunyan.zhang@unisoc.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>
References: <20231229085156.1490233-1-chunyan.zhang@unisoc.com>
 <20231229085156.1490233-3-chunyan.zhang@unisoc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231229085156.1490233-3-chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/12/2023 09:51, Chunyan Zhang wrote:
> This file defines all UMS9620 clock indexes. It should be included in
> the DTS file(s) in which there're devices using these clocks.
> 

Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching.

A nit, subject: drop second/last, redundant "bindings". The
"dt-bindings" prefix is already stating that these are bindings.


> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
>  include/dt-bindings/clock/sprd,ums9620-clk.h | 515 +++++++++++++++++++

This is part of previous patch.


>  1 file changed, 515 insertions(+)
>  create mode 100644 include/dt-bindings/clock/sprd,ums9620-clk.h
> 
> diff --git a/include/dt-bindings/clock/sprd,ums9620-clk.h b/include/dt-bindings/clock/sprd,ums9620-clk.h
> new file mode 100644
> index 000000000000..ed566e1208d7
> --- /dev/null
> +++ b/include/dt-bindings/clock/sprd,ums9620-clk.h
> @@ -0,0 +1,515 @@
> +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
> +/*
> + * Unisoc UMS9620 platform clocks
> + *
> + * Copyright (C) 2020-2023, Unisoc Inc.
> + */
> +
> +#ifndef _DT_BINDINGS_CLK_UMS9620_H_
> +#define _DT_BINDINGS_CLK_UMS9620_H_
> +
> +#define CLK_26M_AUD		0
> +#define CLK_13M			1
> +#define CLK_6M5			2
> +#define CLK_4M3			3
> +#define CLK_4M			4
> +#define CLK_2M			5
> +#define CLK_1M			6
> +#define CLK_250K		7
> +#define CLK_16K			8
> +#define CLK_RCO_100M_25M	9
> +#define CLK_RCO_100m_20M	10
> +#define CLK_RCO_100m_4M		11
> +#define CLK_RCO_100m_2M		12
> +#define CLK_RCO_60m_20M		13
> +#define CLK_RCO_60m_4M		14
> +#define CLK_RCO_60m_2M		15
> +#define CLK_PHYR8PLL_GATE	16
> +#define CLK_PSR8PLL_GATE	17
> +#define CLK_CPLL_GATE		18
> +#define CLK_V4NRPLL_GATE	19
> +#define CLK_TGPLL_GATE		20
> +#define CLK_MPLLL_GATE		21
> +#define CLK_MPLLM_GATE		22
> +#define CLK_MPLLB_GATE		23
> +#define CLK_MPLLS_GATE		24
> +#define CLK_DPLL0_GATE		25
> +#define CLK_DPLL1_GATE		26
> +#define CLK_DPLL2_GATE		27
> +#define CLK_GPLL_GATE		28
> +#define CLK_AIPLL_GATE		29
> +#define CLK_VDSPPLL_GATE	30
> +#define CLK_AUDPLL_GATE		31
> +#define CLK_PIXELPLL_GATE	32
> +#define CLK_PMU_GATE_NUM	(CLK_PIXELPLL_GATE + 1)

Drop this and all other numbers. Not a binding and you cannot change it,
if you ever want to add missing clock.


Best regards,
Krzysztof


