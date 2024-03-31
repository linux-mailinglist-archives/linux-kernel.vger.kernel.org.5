Return-Path: <linux-kernel+bounces-126362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 490CD8935A8
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 21:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BBED1C21842
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 19:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED73E1474DA;
	Sun, 31 Mar 2024 19:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eWCTGzAo"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558941474C2
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 19:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711914771; cv=none; b=J2uF7Tj7mRqM4J9+4BpbnZzo1FE3l1I/ovPyD5YPnPJzSuSxQqIeX6NxhNyHoIVrP95UNIS/tnilWustfkmH5k3Opg2j7YBy8fngihUq+lhwI8ZWheLtNdAxuWueoVNtej5iezia9OisChra2Hj7rId1OR4VJJCTrfdLiRa2Me0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711914771; c=relaxed/simple;
	bh=EbTkIL/swUomdW9wMjBymcbkcR+Wh85BPB4Hiv4GyIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QvNnsGN5WzcopT+8mibIHIdtEvhs0O1XQdMxvxl16GFVamSWzZRWnNPE4Ky5t1lhVUNta3lceLsOvARg+d0oqZ3ZbEAytRXrDa+Yfe3j5gb1PzO/ZmzpwK4UKkplwYowPEeO3vqoOvok4CxJtA3MFpd+caQy7BO2qs+sVmfxGaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eWCTGzAo; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d485886545so56776481fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 12:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711914767; x=1712519567; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nEq5in0z0f4vlhEZW9aTuX+Y1gknTX4JajMY0JG06rs=;
        b=eWCTGzAo+OARMbFjfhmKlImQJ1gACaiCG60T2ORWjoaBXr6CTUvpQDTJW4saHpj2vl
         6UAmeF2e4k7IIbU68URZR02INWU6Zu+YVjm26K7UFsc/A2TYnFJz4rN+8QKFlM5yKUGp
         sIDYR+Ksa/VufEKZuMcvkDk2XygPV8yGvC/bZuz0OVcnwvzf1CWWTsBDzrWWcAvdeMor
         wSQTo5pmN49+RZ8g6VDvbcKzip/ls/Ae2TS0AJDE/mGQch38MV3KBXug+qYyaSQ6xmRI
         vrACr3U4n8rUNhJuNxGap6P2FKqQ7RPwxGKN/3DZBM17IdNRwudGRGaV5hcXqJoFY1HQ
         wNCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711914767; x=1712519567;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nEq5in0z0f4vlhEZW9aTuX+Y1gknTX4JajMY0JG06rs=;
        b=YFPMTusNYxEfslwNMGVSHorUFahXQIa7HPaJpriLTU4/m0n3fy3L/xwljtOhgxrQgg
         LrqbUp3Y4HVoYiA2xgn8TZ5GONtiliU5Jpe6oY81VJ/h9/Of1MPFKQZUP4uGfPNIn6YL
         PQO8KjKeCds8DscGb1zfU1Yj1+SMgA0Am4Kd3XCCW1aeTebwyiMxvV4EGu1aaNvvdmXU
         n9TL9Cz3FR9ZG30UDH4Es86sOLgT+FZl5vzjuJObz1D5BTTnnsDunTA35zVL8ZqR6x7X
         9O9cX8Don6ZwzLPLzq7b793kzlF4GdU5If7oDDwP93afLBvEd0aiMg2dWYJCmRN0XM7r
         0wjw==
X-Forwarded-Encrypted: i=1; AJvYcCUjYzjYJ8SY1LakWYjV8qOgc6fXQLk17sXNlXvY2mxpMgnRlTZF0OoxzEFxgrYpLeKpk5Qgec0DnDUV8cPxxVkl2mfZmB+sHDSVkhg7
X-Gm-Message-State: AOJu0YyX4YJRz651V78KI44YncFmwGxVjcMmNNxvQjLKQLakTP4ixGpM
	mLg6MWbSWcpv9RFLYR/fXvw6XTY3zozCn6cyY0vrn9k/m33K4693zn9S2UckPbxlpcGq/EqfFH3
	B
X-Google-Smtp-Source: AGHT+IEd0KTvxBQTNGk8inkxfvQV4qJPxaIOeWoWJQ237yA4vryNoS4fW54OHBuBpV3qMPD2rcjxeA==
X-Received: by 2002:a2e:3209:0:b0:2d4:aa55:72db with SMTP id y9-20020a2e3209000000b002d4aa5572dbmr5960652ljy.19.1711914767471;
        Sun, 31 Mar 2024 12:52:47 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id r17-20020a056402019100b0056c4a0ccaacsm4654926edv.83.2024.03.31.12.52.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Mar 2024 12:52:46 -0700 (PDT)
Message-ID: <eedeb8d5-3076-4e19-b935-813a341864e0@linaro.org>
Date: Sun, 31 Mar 2024 21:52:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] clk: imx: add i.MX95 BLK CTL clk driver
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
 <20240324-imx95-blk-ctl-v5-4-7a706174078a@nxp.com>
 <d3770f5e-f3cc-40fd-a211-b229be46d974@linaro.org>
 <DU0PR04MB941774D0A1CD037AB7108AAF88382@DU0PR04MB9417.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <DU0PR04MB941774D0A1CD037AB7108AAF88382@DU0PR04MB9417.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/03/2024 14:01, Peng Fan wrote:
>> Subject: Re: [PATCH v5 4/4] clk: imx: add i.MX95 BLK CTL clk driver
>>
>> On 24/03/2024 08:52, Peng Fan (OSS) wrote:
>>> From: Peng Fan <peng.fan@nxp.com>
>>>
>>
>> ...
>>
>>> +
>>> +static const struct of_device_id imx95_bc_of_match[] = {
>>> +	{ .compatible = "nxp,imx95-camera-csr", .data = &camblk_dev_data },
>>> +	{ .compatible = "nxp,imx95-display-master-csr", },
>>> +	{ .compatible = "nxp,imx95-lvds-csr", .data = &lvds_csr_dev_data },
>>> +	{ .compatible = "nxp,imx95-display-csr", .data =
>> &dispmix_csr_dev_data },
>>> +	{ .compatible = "nxp,imx95-vpu-csr", .data = &vpublk_dev_data },
>>> +	{ /* Sentinel */ },
>>> +};
>>> +MODULE_DEVICE_TABLE(of, imx95_bc_of_match);
>>> +
>>> +static struct platform_driver imx95_bc_driver = {
>>> +	.probe = imx95_bc_probe,
>>> +	.driver = {
>>> +		.name = "imx95-blk-ctl",
>>> +		.of_match_table = of_match_ptr(imx95_bc_of_match),
>>
>> Drop of_match_ptr(), causes warnings. From where did you copy such code?
>> Which mainline driver has such pattern?
> 
> I recall that when COMPILE_TEST is selected, OF is not selected, kernel
> robot reports warning. This may not be true now.
> 

This itself was never true. Any compilation, not robots, which you can
test by yourself will report warnings if your code is not correct. Don't
use random C syntax to suppress warnings, but actually something which
will work. of_match_ptr does not make sense without maybe_unused or
ifdef. But anyway of_match_ptr is not recommended.

Best regards,
Krzysztof


