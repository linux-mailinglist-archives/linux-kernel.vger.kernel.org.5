Return-Path: <linux-kernel+bounces-25681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED2A82D489
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 08:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 019C11F2150F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 07:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BD96AA2;
	Mon, 15 Jan 2024 07:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oIrkWxrU"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8BB63AE
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 07:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a2821884a09so703386366b.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 23:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705303445; x=1705908245; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PvuHUaA4z/E3GMVXik3pZT0dq5C3GN9SWjTPsSxtY9w=;
        b=oIrkWxrUJlIC4zSAsuFFqyZ0jufd+PU8UhE5hFQ8ItyQre7y1ddQAj9EhrCpGQYRZ3
         4LC5WTDQqU5ITQQ5YDDBNR/ttRD0/TK4+GK5DRyF6CANiilSLmzw6F+iVn+xsUxYpNQB
         o4sG2K53DVg6G1vWl4YWaJJe47AZtAm77p31PtNsOr6mw3jrrmYRu83yEdlZuR2rTkCC
         qqT3ic8APCB1pkyCrL9FoND36t95kfo4qrs7uL9g1bJzYDsTVo9QtDGEdK6pC3PcWBuX
         HuhzdXab83qAnRq/FsSKtAvxh6iZBv55L0VfahosoQH6D+tSiD5y4GPZC2R4elhWuzvf
         kmYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705303445; x=1705908245;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PvuHUaA4z/E3GMVXik3pZT0dq5C3GN9SWjTPsSxtY9w=;
        b=vpCjm/p0yn/10TxM0lmU3+NtNIKjAko8n9pA7C/jl3X0aEtGszzizkoX74u88OYHHB
         VI2QwjEpzcWZbVVVZt2iX7LOEEmSxC2hJShGQZQCLxA8VVsfsJ1BYyoVuzgPk/gezM9t
         b76Z7HvDhAMzxD42xVjnnVtbvI1qXEoB10X9p6L+VpqNBO14z/B4aODc1xw+p/ZmhRuG
         Y9DqntICn7RrjlEldNkY3E8gPQiYIMrooNO4oeK9asm2yFnBc9980Lb0xI5MOZTRcpcR
         vGZ0T4KVUb75Vg43S+j7LSPsjGZAEC5z9g7pEm2OlgxFczMMZrCuPSwSJDRoosrZw6lW
         aSWw==
X-Gm-Message-State: AOJu0Yx89+0Eu0AEWM4sw53R6LZlMq6MIRNJbtBzC12/ewF8t2Zrosg4
	bVhdafaPRl1QH6JMKig0ybv8nvamcEvAmg==
X-Google-Smtp-Source: AGHT+IERT4GBwuxqReY5Crqo1ydyMoaJn0qS7TClwaeiapqVLsxc2pqc4WVzSUfCdQx+eAQCgE2+fg==
X-Received: by 2002:a17:907:a70d:b0:a2d:3579:ecfb with SMTP id vw13-20020a170907a70d00b00a2d3579ecfbmr1274272ejc.31.1705303445408;
        Sun, 14 Jan 2024 23:24:05 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id t19-20020a1709067c1300b00a2ca9d38654sm4030783ejo.85.2024.01.14.23.24.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jan 2024 23:24:04 -0800 (PST)
Message-ID: <b7458f01-8022-4ed4-8404-9e7d6f567ff4@linaro.org>
Date: Mon, 15 Jan 2024 08:24:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] dt-bindings: perf: fsl-imx-ddr: Add i.MX95
 compatible
Content-Language: en-US
To: Xu Yang <xu.yang_2@nxp.com>, Frank Li <frank.li@nxp.com>,
 "will@kernel.org" <will@kernel.org>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "john.g.garry@oracle.com" <john.g.garry@oracle.com>,
 "jolsa@kernel.org" <jolsa@kernel.org>,
 "namhyung@kernel.org" <namhyung@kernel.org>,
 "irogers@google.com" <irogers@google.com>
Cc: dl-linux-imx <linux-imx@nxp.com>,
 "mike.leach@linaro.org" <mike.leach@linaro.org>,
 "leo.yan@linaro.org" <leo.yan@linaro.org>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "mingo@redhat.com" <mingo@redhat.com>, "acme@kernel.org" <acme@kernel.org>,
 "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
 "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
References: <20231208085402.2106904-1-xu.yang_2@nxp.com>
 <DU2PR04MB882292D4D284A000A9342EA58C6C2@DU2PR04MB8822.eurprd04.prod.outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <DU2PR04MB882292D4D284A000A9342EA58C6C2@DU2PR04MB8822.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/01/2024 07:03, Xu Yang wrote:
> 
>> Subject: [PATCH v2 1/4] dt-bindings: perf: fsl-imx-ddr: Add i.MX95 compatible
>>
>> i.MX95 has a DDR pmu. This will add a compatible for it.
>>
>> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
>>
>> ---
>> Changes in v2:
>>  - no changes
>> ---
>>  Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml b/Documentation/devicetree/bindings/perf/fsl-
>> imx-ddr.yaml
>> index e9fad4b3de68..1bc7bf1c8368 100644
>> --- a/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
>> +++ b/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
>> @@ -20,6 +20,7 @@ properties:
>>            - fsl,imx8mn-ddr-pmu
>>            - fsl,imx8mp-ddr-pmu
>>            - fsl,imx93-ddr-pmu
>> +          - fsl,imx95-ddr-pmu
>>        - items:
>>            - enum:
>>                - fsl,imx8mm-ddr-pmu
>> --
>> 2.34.1
> 
> A gentle ping.

What do you mean? Weren't you asked to fix things, were you? Why do you
ping then?

Best regards,
Krzysztof


