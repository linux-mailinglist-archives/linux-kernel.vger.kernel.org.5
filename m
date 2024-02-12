Return-Path: <linux-kernel+bounces-61296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DAD8510A4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0E0E1F2258C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7F41803D;
	Mon, 12 Feb 2024 10:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qOhFy4mv"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BF7179B8
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 10:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707733389; cv=none; b=ow5m95U5Y1BUY3q/vfqcPwEzG4nFg2F00hVS3oiM/z8X7MI3oY/u+nR0PEttWjls3VyjZTmLrE0aIwVaaXG9IC1bqZ2zy+5glWbl4A2NW4P/FgF11jDRWMs874Y00P0M1eT6+l34kk0WhC68dreDwBRwrAtcdOSo2o+TpZOrIdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707733389; c=relaxed/simple;
	bh=a9CCjCey7VU07BGZDd+yNPJ0xKfeA/X6uFHTDRjYnXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CQfV2Y5LtgsbbLYu8+9EKGz0AZ5LYlqPtISbktOC0Q2myZKTsWvcVLSsFVrX9XZmEWqFfl4q+FXhT278ZG3GTOWA463URXyp8a7Y/x4zzdtpeSNicEvzV3idaR1CcPOzOXI9Bi7yK8ulRSQtL1SroQ2gQCW8hlHbxEJh/BBtFl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qOhFy4mv; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51165a488baso3934305e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 02:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707733386; x=1708338186; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=n9fh2iXaf9mWXqm/97L5o2MUUaqTpGZ/oXWiM893Shg=;
        b=qOhFy4mvogElewDfOwDnbQXAY1j8UtBKel3P19vGrYaizYlhoY4SFproiPswLz+p1b
         rI0YvV86qolkLIeWdpgY/2P8drheyVEN4CZHOkEwqZv0EaTVA5Clhi4x4w5/HzaMgJ00
         LiOE/E1+gqp5aNGzspQgvJEaxA6kkscmeHtVmCUv15qeUBbVFYFoVeejB2jUQ5zugDBh
         FL1uY6gPtWqGSP5hICexTS+TWiGkbg6vMEOt22M3A9kJlSughg1PnytSS4XxBOfbFMkk
         AVDkc2Lu1Mu/mRl91pwVQOscfG7mgWx2y0UCT3mtnFhfe7aBZ9Xz7OIZu2oa7tXyA3rq
         PcqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707733386; x=1708338186;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n9fh2iXaf9mWXqm/97L5o2MUUaqTpGZ/oXWiM893Shg=;
        b=hClLSB0aCizCioFsq+pzF+iEzgsB2KhpvI8oOi84C6BEeclLHEkT+Dg7a5ccv4qGhV
         Do2Z951dzgO11ATknm5fFoSbw8pNQAh+xwJXJw0bvYt3bfzYAiS41BoE8eQpEc2rbJsm
         J8ptaanolEOcPfn5C9Tr7yTFJtFGoO4M3f92Rmf98gWepC8Hok97bSL32h+3pY3EB7qF
         Knd6MrpQ5Y19q9pl9SCktff8Ss3ZBcBGBObxD2ZTEENsdVxtPie+lf0t1j7+/00/poXp
         vOxVReJT6vfbOYnUj08xHMjaN+cxvhnceNc+oLRcvCH0tyunRkp1Ke+mwMEIRe5ZboGa
         1fmQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+n1OEajLD6puqPpj9yp5USRBh87GkgxUbj3jEwfQM3FtYaq6gqiCFmDCNSPVsGQ5UV/Vv7v4rPWEqcBvVE3d+nULqH1fwnPUZqjPi
X-Gm-Message-State: AOJu0Yw+Z7ucLOMRdnmYOCtOXIGNLUL19tEKoyt32FLlQV6wWlyocN20
	sYVLocgOAKmQGvleuvhKJ8UvC/9I2fvXv5jZ/3G9uWKU3LxR+iqKBikjq+D/gaM=
X-Google-Smtp-Source: AGHT+IFlLX3CeBCPvENEbK1xgGBy6h2tY9ws8EbkNh72didKb0RgKv7r4DlH7yMQ6VO70GccFPPZng==
X-Received: by 2002:ac2:41c4:0:b0:511:7a72:6524 with SMTP id d4-20020ac241c4000000b005117a726524mr4118011lfi.15.1707733385777;
        Mon, 12 Feb 2024 02:23:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXumGYap/VaSfGXEQkZIx0T40X+6CIc/yC8ajgt/Id01JfOVBERCHqTaXq5bYZaTkZM6jxerfDomh9UcKAZ1VKbfZ1pJgEoojnf+ffqCXHHZcPEmyCLxWFLvkbpAfBcuU4GUA8gF6L7FHWIgOUaC59ujUWbGCml47+YCac1nzQWHaLiCtC846GfmFEzjqqHgzntWcPoY5iwGhz1K62u0mugH3tEmoYbrSI9QCrrLRoPlR5pNWqpRULQUupNfhPgg3uZILlalrj7r8tTT7jok2Kkaxkvhi2pn5obqR5rjC6Hi9f05iKS7P016D0odhnigG618n/VLDzgVSrFEAyMVa0FHbijexfBe7w5TN+fYtzgdeSdf7Nr9Y6l09hvFaz8lsguxbFBGjaF/Y0PHiDKv0UD4n3IF/Op2OeJrWgs8Sty2EY3IglUCjo+Bcrf6L8Ha9TobMz88DrL+rIttd6SvKP4ub2yGgCxZcoyc4G0eV3Pu4ll2UHPmuv0g+XT9506ylRSff2Tp0mPFPwMax0AIaHB4/4tiYaL5Zoak9eRAZ6TIIHthHWDeCwzPAp5vGrGnHkeadm4uFgSm4j64Mljk0OfGI2g0NZ/U+G8Td9dkvrSvKxhpDQTC6iVj4mI/0nvGkNjH2Bgc4K5xm4c3Oi61PS8+ZMKQ8emA4BmmMYC6bsNk/A/jqvDRBFEFdYwjROn7QvkQEZPJmyzfnIEpyWkB9zNWjf4D8gFm71AiKPGHdlKOsAuofZe/leyoKCCOeXMVk/8tXZ+x7bbSgSqzUvvtJnZjGRWFQl+NUyO9APtXRaY6KzQBwuu6qc583FJ11Q/YduTcj8NIT8N0HXRGsAVLsOgEUkKCJS0sKHroB8R5QuK
Received: from [192.168.1.20] ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id n5-20020a05600c3b8500b00410e90e82ebsm1230545wms.4.2024.02.12.02.23.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 02:23:05 -0800 (PST)
Message-ID: <cedecdb7-fe4a-42ea-9a11-faa82f84b57d@linaro.org>
Date: Mon, 12 Feb 2024 11:23:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [linux][PATCH v6 3/3] dt-bindings: mfd: atmel,hlcdc:
 Convert to DT schema format
To: Lee Jones <lee@kernel.org>, sam@ravnborg.org, bbrezillon@kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, daniel@ffwll.ch, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 claudiu.beznea@tuxon.dev, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, thierry.reding@gmail.com,
 u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
 Dharma Balasubiramani <dharma.b@microchip.com>
Cc: hari.prasathge@microchip.com, manikandan.m@microchip.com,
 Conor Dooley <conor.dooley@microchip.com>
References: <20240202001733.91455-1-dharma.b@microchip.com>
 <20240202001733.91455-4-dharma.b@microchip.com>
 <170738899221.920003.15342446791449663430.b4-ty@kernel.org>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <170738899221.920003.15342446791449663430.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/02/2024 11:43, Lee Jones wrote:
> On Fri, 02 Feb 2024 05:47:33 +0530, Dharma Balasubiramani wrote:
>> Convert the atmel,hlcdc binding to DT schema format.
>>
>> Align clocks and clock-names properties to clearly indicate that the LCD
>> controller expects lvds_pll_clk when interfaced with the lvds display. This
>> alignment with the specific hardware requirements ensures accurate device tree
>> configuration for systems utilizing the HLCDC IP.
>>
>> [...]
> 
> Applied, thanks!
> 
> [3/3] dt-bindings: mfd: atmel,hlcdc: Convert to DT schema format
>       commit: cb946db1335b599ece363d33966bf653ed0fa58a
> 

Next is still failing.

Dharma,
You must explain and clearly mark dependencies between patches.

Lee,
Can you pick up two previous patches as well?

Best regards,
Krzysztof


