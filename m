Return-Path: <linux-kernel+bounces-91781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C33E871680
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE0C8282E0C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC17A7E78B;
	Tue,  5 Mar 2024 07:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BLolHZHW"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379947D3FE
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 07:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709622873; cv=none; b=U26GqW5XfG5nhqoRJBoA4Sk9vaM650ZbPJL3V2oJJ3/A6pWf8TL/Du2IU5EnTw6fzsCp/YdgBZqdN6xuoi3RDdnnu4jP/IC7e0hj8/UfcU5ZzpZ3iPdQ+LNjg7H0MYDSHJ828HK4R1KC5Dudz0Ew9gJFDgQjbM1YjUauOHZYnmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709622873; c=relaxed/simple;
	bh=8zx9t+nH72OZA2vYjFxrFWKNuMr2mmTTLimbqw0qty4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JWiTLDCZl28e3Rrzn+hdjbv/6UQUMvn+hRifakK7FBOzQKfrOQKsn8RAJPHCcW3mMIyeL4E74Yh3SSd61MZAr24tC8x/wbWXS9tKwgeVEcaqBdI1BjKvczKltKhDfBz28vJYR+RWr7fQU4A1JRlWgHqnEzsqaLiw/UnW02QcF8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BLolHZHW; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-512e4f4e463so5782073e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 23:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709622869; x=1710227669; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PJOEpSfM7W5q1u08Hp4JeXt1WjIFUvsNQIjWvP89284=;
        b=BLolHZHWYNhorfoV5ZgAittAmfqmJfkF80mKtJcEmRufKHkTqsRFDFgnhveNvbTr3J
         8mVHmuwTrnPA3xKyexCVSlrHnikSTJ841oA+MYAfiJuZgkq46eriwcYdAUEgOFalueRX
         283Fd5rinOmQg26MNeHfxw3LDR/7ep4/f+dSymzeNMjuYHIO7DVJGjJZgd5eJmkF4/JV
         S56nJcCXlwtWGd3x9Rip3yAyIFKRJ7hSyLpDF5VxAiioqfLUeM+n1VIRcBv+0ElPAQjU
         dyrJ8g1Sf/gaeZw6AMYv4ZKJEw8qlzYLGEFUCWgb+XNyWgtiWw9AGeHNqXhee9njDlkW
         76lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709622869; x=1710227669;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PJOEpSfM7W5q1u08Hp4JeXt1WjIFUvsNQIjWvP89284=;
        b=bQRKzThjlbDMJ+uMcR1PQRXprtzOFBvrUliAlz0ZobooToxa2RqM64lvms2T+gscOg
         Uc4mV7pWwOQP8jdggwWsn9QTpsarTnbb64mVU71uprr70E6mPLSxsgBufQW/YBRk7HTy
         IyPUpx6gLaKpJC1Mi1NobMJfddLzvOOeTG/SVU6rLwRfQvnwSwroFoc6EF/NhtIodomL
         6WW4q/JSzj4tV1sPnGkvVdV46P4zaisr7aBw8L/KsilpXX0N+WU+t99sFqhrERFIhwHC
         gWrtsfDWNrIPFbpnuhHgp+EJqBVwmPH3eJIABeVWcd4/Pw2q6aR+XkSiuT6ljjLw/NEd
         LY+Q==
X-Forwarded-Encrypted: i=1; AJvYcCV6CenJa2gM2DBnvpZT7so4/wWrAvIxTq6GTVWK2gY2hQS6oeremvUzzEQNgkMYBrc8iU92nEfuzwn2KGGSqmur7Iey3w5/7/8cbLCg
X-Gm-Message-State: AOJu0YwIRbF2eBQH7Ah5Np2oUPuaFmiEwz4eDch+3e4AkJfmnGaUuPbl
	JK5Z/d5Oic6EHlqz9z7quYLp8IArv+qvlBlnj0gzKbK5SvkuHKksCgfwyysBbi4=
X-Google-Smtp-Source: AGHT+IHp7CcumrNQVRnYzlCRiXUg8lu+RHMCE8Y1XizPlq7rAPckHF7i1dAaJAU1OL50XXyaeagM+A==
X-Received: by 2002:a05:6512:282c:b0:513:5217:6201 with SMTP id cf44-20020a056512282c00b0051352176201mr823592lfb.59.1709622869242;
        Mon, 04 Mar 2024 23:14:29 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id p5-20020a1709060dc500b00a4537466591sm2234731eji.32.2024.03.04.23.14.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 23:14:28 -0800 (PST)
Message-ID: <58cdfa7c-5483-4193-a5de-bb5fa72de637@linaro.org>
Date: Tue, 5 Mar 2024 08:14:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindindgs: clock: support NXP i.MX95 BLK CTL
 module
Content-Language: en-US
To: Peng Fan <peng.fan@nxp.com>, Rob Herring <robh@kernel.org>,
 "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Abel Vesa <abelvesa@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "imx@lists.linux.dev" <imx@lists.linux.dev>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240228-imx95-blk-ctl-v3-0-40ceba01a211@nxp.com>
 <20240228-imx95-blk-ctl-v3-1-40ceba01a211@nxp.com>
 <20240304143916.GA181628-robh@kernel.org>
 <DU0PR04MB941740A36E953A0E1AD690EC88222@DU0PR04MB9417.eurprd04.prod.outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <DU0PR04MB941740A36E953A0E1AD690EC88222@DU0PR04MB9417.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/03/2024 05:13, Peng Fan wrote:
>>> +
>>> +examples:
>>> +  # Clock Control Module node:
>>> +  - |
>>> +    #include <dt-bindings/clock/nxp,imx95-clock.h>
>>> +
>>> +    syscon@4c410000 {
>>
>> clock-controller@...
> 
> But this is a syscon, using clock-controller will trigger dt
> check warning.

Which warning?

>>
>> As that is the main feature/function.
>>
>>> +      compatible = "nxp,imx95-vpumix-csr", "syscon";
>>> +      reg = <0x4c410000 0x10000>;
>>> +      #clock-cells = <1>;
>>
>> Please make the example as full as possible. For example, add mux-controller
>> node. Do some of the blocks not have mux ctrl?
> 
> Yes. The blk ctrl is not just for clock, some registers has mux ctrl,
> such as Pixel_link_sel.

Then mux-controller should not be allowed for them.

Best regards,
Krzysztof


