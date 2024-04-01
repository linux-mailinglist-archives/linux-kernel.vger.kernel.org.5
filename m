Return-Path: <linux-kernel+bounces-126577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB118939CA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 11:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EC2C1F22507
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 09:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCB910A31;
	Mon,  1 Apr 2024 09:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BMpYC52C"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6206E10A08
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 09:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711965107; cv=none; b=YwtPiWAQAoLoAYugZA2pBTmE1/KGs/PU7cMbRM/WcDcLUO56Z48cMkcfAo+S99JbLxpROq2Bp/q9YkJW0wZsdK+xdPi/Cuxi0q8+D0YLfOpCa5Nno8bT87HnAyyTpcwUMyJyO4rjP0Ay/j/uKWv11Dy6xQm2GyrKM+aWGWaiRFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711965107; c=relaxed/simple;
	bh=Z/fDI7u4ASepE5PkwvvEezq2L8x53f4d2VHoI/MP91I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Usg6znWnY3IqWcumVnpsk7yfIpcIg0kA1LSCtX9S/6Ra4JMY6S6zVTcGR2x7NjKPNaciJ7A9TFo/n6dKcglF1cJXC4wZgljsJmyUeZXQt1uaiMoBaEA04AM/yyLk+j4bM2pLqZXd2VFVQjlOsg2LNLTyl5cukQ6bbxgHPEryVtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BMpYC52C; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56c404da0ebso5592328a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 02:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711965104; x=1712569904; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Dzql5prZwnt+vohd76RG25/DjYuQd5VmqrQyYq+ATkM=;
        b=BMpYC52CsPF3LQ06ZKd440cTt+Aj180h4pF0Nc+X7uR2eZ4q4xC7XJXzAvoHNSqRfp
         AEfBkchyK7IuNeBpAPm1bOz3ptjEqOKuu62E11ALYY2Ll6sq6xdrLTxWqjYpEdCfBWJx
         JxyBzQELHUS5sCPXas8WQTPTk7tfBcx7A5x/1Xt0bDkKWm1TRudo6xz+MxWNjLaLdSlZ
         Pf6i2mV2pxsCCqGzY0IqvcSZXyOFwcnatHJOYHOTVPf6ozIBA0cg5m+djuUpLOb4Ug3O
         hMO2iHPppc5cdfXsFzSndZDxgIJwdgL4HaoDNEHBRGPZb9k/bDYuV9Gsf92uWWrjCjpG
         lzNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711965104; x=1712569904;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dzql5prZwnt+vohd76RG25/DjYuQd5VmqrQyYq+ATkM=;
        b=HZ2G6V9nBXtKYKU7QgelecIrXymHr4sdcVv9GPVV1rHsckml6PWor5tAOHoGY3rxSt
         Z/CpImKDj6a+tkfqinsyAgJp8C5oKEtTbfEuNhniN3iQqVd433SB6IUcXhhohk4gSzMd
         AeaLjJ16c0i9nxuuLqc37rd0JdKu5PCGunzXD2ZzMyBIcgvGj20L3O7BP2o8LlIdii5F
         wkiOyRuli/rU6TxfiZJNxlbuJS9QcX/i7SphNPai766lemCfvDLkNr5WrR1X95TS3G32
         w1MIQVEC2i36mphKC1g7AeSX876BJMN5h+vwgvSwFcXXy+SuAjelEU8zK/VAn8kMzjRC
         40BQ==
X-Forwarded-Encrypted: i=1; AJvYcCXffRYMH8CeyLcb+XED3QicPpGjC7g2z/rl38Yj3+5wqTz9/+xh8non7N0071FuB8IVI1AOS8KaBQwXvafwbw+yW/J+RT/XlNJprIP3
X-Gm-Message-State: AOJu0Yxc7O1GgsJrKTqBPN3oHkLaJTP0G728Nxo+Ap80XyCd02ib4dCa
	ClzAoDt/H/H1mecEi8omrAnQDR2oDQPifD1m2iAE1dGLB126GNOaBImIVtdEmDM=
X-Google-Smtp-Source: AGHT+IExQYQm0NtAZHBPONy7nCXeQvXeh7zREgZ48G/YhMdHAfJzfcWm7cIICaIC6PIwA+ynBGZlzg==
X-Received: by 2002:a17:906:1253:b0:a4d:ff5f:98ad with SMTP id u19-20020a170906125300b00a4dff5f98admr5550248eja.37.1711965103725;
        Mon, 01 Apr 2024 02:51:43 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id gl20-20020a170906e0d400b00a46c39e6a47sm5158120ejb.148.2024.04.01.02.51.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Apr 2024 02:51:43 -0700 (PDT)
Message-ID: <c5bc1d09-22f7-4e47-b87c-af412eb57278@linaro.org>
Date: Mon, 1 Apr 2024 11:51:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] dt-bindings: clock: add i.MX95 clock header
To: Peng Fan <peng.fan@nxp.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Abel Vesa <abelvesa@kernel.org>
Cc: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "imx@lists.linux.dev" <imx@lists.linux.dev>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240324-imx95-blk-ctl-v5-0-7a706174078a@nxp.com>
 <20240324-imx95-blk-ctl-v5-3-7a706174078a@nxp.com>
 <31b493d1-ad74-48c7-8585-9df323418ae3@linaro.org>
 <DU0PR04MB9417AD4C2F5644FAE6D5A762883F2@DU0PR04MB9417.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <DU0PR04MB9417AD4C2F5644FAE6D5A762883F2@DU0PR04MB9417.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/04/2024 09:26, Peng Fan wrote:
>> Subject: Re: [PATCH v5 3/4] dt-bindings: clock: add i.MX95 clock header
>>
>> On 24/03/2024 08:52, Peng Fan (OSS) wrote:
>>> From: Peng Fan <peng.fan@nxp.com>
>>>
>>> Add clock header for i.MX95 BLK CTL modules
>>>
>>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>>> ---
>>>  include/dt-bindings/clock/nxp,imx95-clock.h | 32
>> +++++++++++++++++++++++++++++
>>>  1 file changed, 32 insertions(+)
>>>
>>> diff --git a/include/dt-bindings/clock/nxp,imx95-clock.h b/include/dt-
>> bindings/clock/nxp,imx95-clock.h
>>> new file mode 100644
>>> index 000000000000..83fa3ffe78a8
>>> --- /dev/null
>>> +++ b/include/dt-bindings/clock/nxp,imx95-clock.h
>>> @@ -0,0 +1,32 @@
>>> +/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
>>> +/*
>>> + * Copyright 2024 NXP
>>> + */
>>> +
>>> +#ifndef __DT_BINDINGS_CLOCK_IMX95_H
>>> +#define __DT_BINDINGS_CLOCK_IMX95_H
>>> +
>>> +#define IMX95_CLK_VPUBLK_WAVE			0
>>> +#define IMX95_CLK_VPUBLK_JPEG_ENC		1
>>> +#define IMX95_CLK_VPUBLK_JPEG_DEC		2
>>> +#define IMX95_CLK_VPUBLK_END			3
>>
>> No improvements, so again: drop counting.
> 
> Could you please give more details on what you think needs
> to be addressed here? I may overlook your comments before,
> but I search v1-v4, not find comments on the headers,
> except the one file name align with binding if 1:1 match.

Drop all defines which count number of clocks.

Best regards,
Krzysztof


