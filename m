Return-Path: <linux-kernel+bounces-167754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F998BAEAB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A24811F24578
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 14:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6F4155309;
	Fri,  3 May 2024 14:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MTnG/V4G"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D853154BEF
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 14:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714745841; cv=none; b=HsedwOZrG641KMLkKCTrh9XtoE4+jqoD5KLov6ewvrMzZJoLMmXyVSI0IZugzagUvzIjO3tSUixTPTx8f6u/lBovNs/Rbhpq4juUf/25cDbGE0xSHStL9VrPpfbe6gbO/Ux8BWhGIt26dmG6hYv5Du/7K5KrYXHRj7/ZJMZ/aGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714745841; c=relaxed/simple;
	bh=HLNnngZtVS6/xr3NuvGsRGtSiLzoXBl1xah47pEzPZI=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=GaqJAtagPQxxrjSbVi1U59zjoio31DXCSRbVPzhutG+BiQKymb1eh5f3wDAx10W18rLceJWc3al2mhZkxpobNkq0QVMHPLZWU6giGWsQqplW5H6kTUIIqP47WFjwAsnzX6PNRNzweiRIgTPJq9If8i1lh88GacRek5jTRqAuM4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MTnG/V4G; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41b5e74fa2fso60834245e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 07:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1714745838; x=1715350638; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=mi/mhU22fI9RIiTkHOJlpI4wXPcoOgAYplYoLc68pRk=;
        b=MTnG/V4GfEwxnz6XzmWaSRJFCh9rgeuoYuNfuF+3FNf4EM9eNrLbUt3E+pz/uW7fzr
         WuBktsanSuC+04gOm4ES/4Wk/7paT+BwVqyb8Q8R0neestq6jt2KFEf/PTgSaQ0YEsrj
         PHelwMoPaEfj0F8SauB6KyuTWGJcEbStaI7iWEfnxXZSwF31sDC1UgcyRqq7QlbwBJjD
         qPEMEtOXZVaKnaJELQSaC96XRE8cGDyr93bHF6G7M+4HCz4roDnrcbWihoet0jSrvg78
         hbKFUZZC/1qX6gaSBiAzixROJzjnVTVkK5i4JAFuCoj049kY9J/jtrn6TiiS/nt/2mdC
         PpNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714745838; x=1715350638;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mi/mhU22fI9RIiTkHOJlpI4wXPcoOgAYplYoLc68pRk=;
        b=UZ0Hr6dtQ3q3Eq3RC5h0Sb3lDseenJqX8VwISRoVlrLn3YS4D/2K2ghRKeEG/CsaVv
         t6HqwXTu7/qJznQ4LA0tr4FEZlGk9rY5IEA+VkQrS/jvC4FzfnQkYHjWlmyeFdmPKd9e
         OoQUTtIis8ettEbAkChp6hENNsh+OqEqA6YP10xbqby1Ld0ECejdmAu4KtN7M37+D1hY
         70+eqhG8JlAVGxzY+aaUxQOIs0o+4UToAzSvmFt9bD9arX81gj44MegiOgV84uvCe8/I
         sKunkQGy3Qk4J2+RHajerR0/BcepKwlVNJLr7SkUa1yoMf+y1ADxQ5beXeVJjwEGCibF
         /WVg==
X-Forwarded-Encrypted: i=1; AJvYcCWD515fLkz/wjLEaeF+oLmCWnagoG3DwyBGVfkqGvUCyOTBLfpwmf6B4iVQy8rafXC/AsPvLUjhqQZBHlUCKu+MdR4BHcdomJjMmlNk
X-Gm-Message-State: AOJu0YwSXuy0AYwDmIw8XFvVQiWs2mo43UYiLzwp8a7oE1g0fFfj8Lx6
	49rFkO5vlKaNQzslIjtWiVL013a9u2RbM9EAU1KgrtDVwB4+n5lgo+TBPayDYJI=
X-Google-Smtp-Source: AGHT+IGl8A3CNGIOXabjv5H9Oz2zuPwg61o4PRCCpsIbyOo0AUsxBa9pb1Pfsk4BzFD31YbUj0yF7g==
X-Received: by 2002:a05:600c:4706:b0:41a:b56c:2929 with SMTP id v6-20020a05600c470600b0041ab56c2929mr2348971wmo.34.1714745837574;
        Fri, 03 May 2024 07:17:17 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:1b85:e590:355b:9957])
        by smtp.gmail.com with ESMTPSA id r12-20020a05600c458c00b0041bfa2171efsm5781969wmo.40.2024.05.03.07.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 07:17:17 -0700 (PDT)
References: <20240430064438.2094701-1-xianwei.zhao@amlogic.com>
User-agent: mu4e 1.10.8; emacs 29.2
From: Jerome Brunet <jbrunet@baylibre.com>
To: Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Neil Armstrong
 <neil.armstrong@linaro.org>, Jerome Brunet <jbrunet@baylibre.com>, Michael
 Turquette <mturquette@baylibre.com>, Stephen  Boyd <sboyd@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v8 0/5] Add C3 SoC PLLs and Peripheral clock
Date: Fri, 03 May 2024 16:12:34 +0200
In-reply-to: <20240430064438.2094701-1-xianwei.zhao@amlogic.com>
Message-ID: <1jv83v2d5f.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


On Tue 30 Apr 2024 at 14:44, Xianwei Zhao <xianwei.zhao@amlogic.com> wrote:

> Changes since V7 [1]:
>  - Remove included head file not used.
>  - Link to v7: https://lore.kernel.org/all/20240424050928.1997820-1-xianwei.zhao@amlogic.com
>

Overall this v8 looks good. Please address the remaining comments.

There is no need to rush sending a v9. Please allow some time for other
to review this. I will not apply a v9 until the -rc1 is out anyway.

> Changes since V6 [12]:
>  - Add pad src for rtc clock.
>  - Add SCMI clock controller support, move some clock node in SCMI,such as GP1 PLL DDR USB etc.
>  - Fix some spelling mistake.
>  - Use lower case for bindings and update some input clocks desc.
>  - Update some clock comments.
>  - Delete prefix "AML_" for macro definition.
>  - Addd some clock annotation and some clock flag CRITICAL.
>  - Add maximum for regmap_config.
>  - Delete some unused register definition and unused clock inputs. 
>  - Drop patch subject redundant "bindings". Suggested by Krzysztof.
>  - Not reference header file "clk.h" and replace comment. Suggested by Jerome.
>  - Modify description about board in Kconfig file help item. Suggested by Jerome.
>  - Link to v6: https://lore.kernel.org/all/20231106085554.3237511-1-xianwei.zhao@amlogic.com
>
> Changes since V5 [3]:
>  - Fix some typo and modify formart for MARCO. Suggested by Jerome.
>  - Add pad clock for peripheral input clock in bindings.
>  - Add some description for explaining why ddr_dpll_pt_clk and cts_msr_clk are out of tree.
> Changes since V4 [10]:
>  - Change some fw_name of clocks. Suggested by Jerome.
>  - Delete minItem of clocks.
>  - Add CLk_GET_RATE_NOCACHE flags for gp1_pll
>  - Fix some format. and fix width as 8 for mclk_pll_dco.
>  - exchange gate and divder for fclk_50m clock.
>  - add CLK_SET_RATE_PARENT for axi_a_divder & axi_b_divder.
>  - add CLK_IS_CRITICAL for axi_clk
>  - Optimized macro define for pwm clk.
>  - add cts_oscin_clk mux between 24M and 32k
>  - add some missing gate clock, such as ddr_pll.
> Changes since V3 [7]:
>  - Modify Kconfig desc and PLL yaml clk desc.
>  - Fix some format.Suggested by Yixun and Jerome.
>  - Add flag CLK_GET_RATE_NOCACHE for sys_clk.
>  - Optimized macro define for pwm clk.
>  - Use flag CLK_IS_CRITICAL for axi_clk.
>  - Add some description for some clocks.
>  - Use FCLK_50M instead of FCLK_DIV40.
> Changes since V2 [4]:
>  - Modify some format, include clk name & inline, and so on.
>  - Define marco for pwm clock.
>  - Add GP1_PLL clock.
>  - Modify yaml use raw instead of macro.
> Changes since V1 [2]:
>  - Fix errors when check binding by using "make dt_binding_check".
>  - Delete macro definition.
>
> Xianwei Zhao (5):
>   dt-bindings: clock: add Amlogic C3 PLL clock controller
>   dt-bindings: clock: add Amlogic C3 SCMI clock controller support
>   dt-bindings: clock: add Amlogic C3 peripherals clock controller
>   clk: meson: c3: add support for the C3 SoC PLL clock
>   clk: meson: c3: add c3 clock peripherals controller driver
>
>  .../clock/amlogic,c3-peripherals-clkc.yaml    |  120 +
>  .../bindings/clock/amlogic,c3-pll-clkc.yaml   |   59 +
>  drivers/clk/meson/Kconfig                     |   29 +
>  drivers/clk/meson/Makefile                    |    2 +
>  drivers/clk/meson/c3-peripherals.c            | 2365 +++++++++++++++++
>  drivers/clk/meson/c3-pll.c                    |  746 ++++++
>  .../clock/amlogic,c3-peripherals-clkc.h       |  212 ++
>  .../dt-bindings/clock/amlogic,c3-pll-clkc.h   |   40 +
>  .../dt-bindings/clock/amlogic,c3-scmi-clkc.h  |   27 +
>  9 files changed, 3600 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,c3-peripherals-clkc.yaml
>  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml
>  create mode 100644 drivers/clk/meson/c3-peripherals.c
>  create mode 100644 drivers/clk/meson/c3-pll.c
>  create mode 100644 include/dt-bindings/clock/amlogic,c3-peripherals-clkc.h
>  create mode 100644 include/dt-bindings/clock/amlogic,c3-pll-clkc.h
>  create mode 100644 include/dt-bindings/clock/amlogic,c3-scmi-clkc.h
>
>
> base-commit: ba535bce57e71463a86f8b33a0ea88c26e3a6418


-- 
Jerome

