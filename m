Return-Path: <linux-kernel+bounces-105778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5A287E437
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 08:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46A141F212EA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 07:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D9A22F1C;
	Mon, 18 Mar 2024 07:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mBfV+HVw"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F88122EF0
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 07:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710747719; cv=none; b=N2KMjxDC/ZG/+TMi4gRW85wv3uq0y7RKGKbut0BqV/Kb+7RerkUrQM8BGagPDIaWS9FO7mFwmQcrU/HyQq+m96D29kr8wvLU/PjHYQ9eYRAjTsRw1jmo+q0Wjg+ReQk6ENN+d0xtpkO9JMWtygbg5Q/EIhtDV3xIgoujXioN47s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710747719; c=relaxed/simple;
	bh=PINzWdH0Ne7ORYZjAwoSX8t/RRcw1lLoN8REYVtAW7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nlWK6MPHOE/KgaL3aWv8g7ePR3wM2Ezm2PqX6FvOwCJbz0uNvWKZ6fyvAplH/QKz6UZqXQ93NLx3YkZOSRNOMJC9W+/h48l/lX4abKav99SIdAg1YvH2y1ElH1nFr5FRZ6FSoLoBn0WL7upwFM9QWSOP1sUXPCKJEHLeQmtdQ1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mBfV+HVw; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a3ddc13bbb3so920051066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 00:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710747716; x=1711352516; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c72fdTUZtGgEqYLgWdMw4Z3JQurOW9liWuFGsNI6KVg=;
        b=mBfV+HVwCgsHX52KuLR6rkiqPJQEahdfe+7kCtN9QFqzlIoP//KK/BO71WomHEn8rW
         jDwjotzx5Wt0gX4XHjR3yEZgdEyLEMZVt4xQUQD1NNGuBnibkoS7ZcdOOuQxfpulWtvJ
         +1GfvaMtVGRnZ4H+W1oXVCA91sIGS1Y3jCmYdYOZJnx1qlZn5+IxRDRltJ2IJ1dHZrDG
         hq/EF3v9uT81K2NAWiecbEJ8whHNT1dde5EAxLofVi6zdReGI+090prmoPpt0kpoJpi+
         UoFP2jFLou1UFyPFz+7Oe+y9zDJrcWQ/q2v+MT2erpuUNyaEflBQP51cTG8ZKOsBt726
         itDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710747716; x=1711352516;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c72fdTUZtGgEqYLgWdMw4Z3JQurOW9liWuFGsNI6KVg=;
        b=EfFDH4zZN5GKvK+j217Ogh7hM1wE/4mMLOV6ydBUlPaN6aXK4fqtajnXIHfLNxRbWT
         8boSIBrgYIeg82I6+UUNkUy/VppOxg4M9csI6My2k+byAgyphktTv8F9dAVi6YgiWLKT
         FHzAQbFCuqQKZ2vMiZ6XAq76Bwslfy3bAbwIyWb2Wr4/CR2x1SgaH8criwCjdxRdY5b9
         x7z81sGpMvoBD9P9yNUMk5LXhmykU9YzCMujhM8hgFPDJJXl4IKy58PpJjOhcLlafM+T
         rzjIC3Bqedva41yq/Lz8WR5e56P8K+PLwb3zVvsmQGu3hNcittLJ50VgqorSDRz/XGoX
         gB8g==
X-Forwarded-Encrypted: i=1; AJvYcCVaSrqPoVu9bJBpAL5nDQS5cRGVOESqa6PMpG6oUse8Ekqco+YuewM+PSThw6dNbW++9TWIQHkckq3jIZePdSfEi3kpYED6o7PKF5MH
X-Gm-Message-State: AOJu0YxeqcEd6YPh4UWQ5h+sLKDQqO32ki4gBVPQK6jFt/2mSSwACe3j
	iA2gblFKPyoJFMMi5k1InylF88Q4atQG5dYNPbpdihkn/2QZEl43Y6h6V6EjFYs=
X-Google-Smtp-Source: AGHT+IGksPpLOMb3TcnP90t1eD27JwWBE7KI1x8yQDxO+JrHME9wevbX26wxSebKQDpK5VYvLcqZyA==
X-Received: by 2002:a17:906:e942:b0:a45:ab98:aec with SMTP id jw2-20020a170906e94200b00a45ab980aecmr9473404ejb.10.1710747715638;
        Mon, 18 Mar 2024 00:41:55 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id bn8-20020a170907268800b00a46be7fb6b8sm789126ejc.43.2024.03.18.00.41.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 00:41:55 -0700 (PDT)
Message-ID: <b2793d2d-d0ae-406f-b024-06d3a327ed35@linaro.org>
Date: Mon, 18 Mar 2024 08:41:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] net: stmmac: Add NXP S32 SoC family support
Content-Language: en-US
To: Wadim Mueller <wafgo01@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 Chester Lin <chester62515@gmail.com>, =?UTF-8?Q?Andreas_F=C3=A4rber?=
 <afaerber@suse.de>, Matthias Brugger <mbrugger@suse.com>,
 NXP S32 Linux Team <s32@nxp.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Richard Cochran <richardcochran@gmail.com>,
 Andrew Halaney <ahalaney@redhat.com>, Simon Horman <horms@kernel.org>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Johannes Zink <j.zink@pengutronix.de>, Shenwei Wang <shenwei.wang@nxp.com>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Swee Leong Ching <leong.ching.swee@intel.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-clk@vger.kernel.org
References: <20240315222754.22366-1-wafgo01@gmail.com>
 <20240315222754.22366-3-wafgo01@gmail.com>
 <2316e61d-ad7d-46fb-9f55-67964552855a@linaro.org>
 <20240317232615.GB22886@bhlegrsu.conti.de>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240317232615.GB22886@bhlegrsu.conti.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/03/2024 00:26, Wadim Mueller wrote:
> On Sun, Mar 17, 2024 at 03:53:19PM +0100, Krzysztof Kozlowski wrote:
>> On 15/03/2024 23:27, Wadim Mueller wrote:
>>> Add support for NXP S32 SoC family's GMAC to the stmmac network driver. This driver implementation is based on the patchset originally contributed by Chester Lin [1], which itself draws heavily from NXP's downstream implementation [2]. The patchset was never merged.
>>>
>>> The S32G2/3 SoCs feature multiple Ethernet interfaces (PFE0, PFE1, PFE2, and GMAC) which can be routed through a SerDes Subsystem, supporting various interfaces such as SGMII and RGMII. However, the current Glue Code lacks support for SerDes routing and pinctrl handling, relying solely on correct settings in U-Boot. Clock settings for this SoC are managed by the ATF Firmware.
>>
>>
>> Please run scripts/checkpatch.pl and fix reported warnings. Some
>> warnings can be ignored, but the code here looks like it needs a fix.
>> Feel free to get in touch if the warning is not clear.
>>
>> Read how commit msg should be wrapped.
>>
>> Please wrap commit message according to Linux coding style / submission
>> process (neither too early nor over the limit):
>> https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597
>>
>>>
>>> Changes made compared to [1]:
>>>
>>>     Rebased onto Linux 6.8-rc7
>>>     Consolidated into a single commit
>>>     Minor adjustments in naming and usage of dev_err()/dev_info()
>>>
>>> Test Environment:
>>> The driver has been successfully tested on the official S32G-VNP-RDB3 Reference Design Board from NXP, utilizing an S32G3 SoC. The firmware and U-Boot used were from the BSP39 Release. The official BSP39 Ubuntu 22.04 Release was successfully booted. A network stress test using iperf [3] was also executed without issues.
>>>
>>> [1] https://patchwork.kernel.org/project/netdevbpf/patch/20221031101052.14956-6-clin@suse.com/#25068228
>>> [2] https://github.com/nxp-auto-linux/linux/blob/release/bsp39.0-5.15.129-rt/drivers/net/ethernet/stmicro/stmmac/dwmac-s32cc.c
>>> [3] https://linux.die.net/man/1/iperf
>>> [4] https://github.com/nxp-auto-linux/u-boot
>>> [5] https://github.com/nxp-auto-linux/arm-trusted-firmware
>>>
>>> Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
>>> ---
>>>  drivers/net/ethernet/stmicro/stmmac/Kconfig   |  12 +
>>>  drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
>>
>> That's totally unrelated to DTS. Do not mix independent work in one
>> patchset. This targets net-next, not SoC, so please send it as separate
>> patchset when net-next reopens, so after merge window.
>>
> 
> Let me try to explain why I was thinking that both should be part of the
> same patchset. 
> 
> The DTS file patch [1/3] is refering to a NIC for which there is no
> upstream driver (or lets call it better glue code for the real driver) available. 

That's not valid reason. You only need to mention where the bindings are
for dwmac.

> 
> This patch here is supposed to add support for this driver. So without this part the DT
> node named "gmac0" of [1/3] is not of much use. Thats why I was thinking they

Does not matter. DTS is independent description of hardware. Do you want
to say that without driver support in Linux you could not add the DTS?
No, that's irrelevant.


> should be part of one patchset.
> 
> But your statement also totally makes sense to me.

You unnecessary grow the CC list - it is already way too big (please
trim it to maintainers only and CC lists) - and make applying more
complicated, e.g. suggesting there is some dependency.

DTS *must* go via arm-soc, not net-next, combining it here increases the
risk it will go via wrong tree.


Best regards,
Krzysztof


