Return-Path: <linux-kernel+bounces-52163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3538494C5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68038B246DC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 07:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24AF10A34;
	Mon,  5 Feb 2024 07:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m1uurVXk"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A32810A13
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 07:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707119318; cv=none; b=XLSGmk3/kuJXDSlZ6MCX/vnJXW1+BlHtBeW5UPX4QpHg6Gm/pcDTTKzHa7F4wwI4T2PYJ1cgUOPu3Efv69y+Ca+lqOIqh4HjpJPW2hTiJZRsAXH1xyvlMf0Lf1WDyvro+tKjTo9MQ6XBDf/Z5WLmJlnxVXDYu+SsAhxhhJn28r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707119318; c=relaxed/simple;
	bh=wMUoCmHVAaDGpBDtO1mN7scySuWqd627SunQSIwMcXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L77c6lA7NCeU0XB09V/EbxrS7QrcWGImr9XFHTIsWygcrG1alaQ4qxKExBDSBrAWKqxDuXjmRc3XZBI2K8TIiXp96Wc1D5XiZfjn8iCM0L9GbmgNmQcG04uti3HZc4hhzukQkOcMs4lcSDvdiqeh5r39lbESKa6tuBBeaJg+0Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m1uurVXk; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a37ce4b2b23so39076066b.3
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 23:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707119314; x=1707724114; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IxXfXM8mBHOyPEEJE6Y3LTPjVALjmp0awibe0Ro3Iyc=;
        b=m1uurVXkPLPoyxDEyeq2lqPPg/t1zwpHiPOKO/ETi5VPlQrrqDgigbLBWphrdGA6ye
         Hd7P0UkUzovjmgACPlbaQrFJYORZwMt1RdK8dnCCk9tgY9vS/8i/I3ZLC3jjiknNG6tQ
         USEIzTCCK1G7dtO3rOTXUaVEEJI3FLBMcEAUsPMxNorANp2Q59zJlD2vQ9RklTdNI5tg
         E+OAweGgVe2A6TKXpua00yjvlpAuQQhc2dGTnOmNXlWStXu0+lCJaE3g+DqwpIhSoVPc
         Isw+1yTP9EWIgzPX8aRtbD0xPoSBGaOLbXuAHO8619terh6v3Z6dxusa6RAq1gkTjgN2
         j2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707119314; x=1707724114;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IxXfXM8mBHOyPEEJE6Y3LTPjVALjmp0awibe0Ro3Iyc=;
        b=Jh8yjVCh6D9OmM9qwsI5/RBo/J/+Ura0XB6kM+DJMghEXCHaGfUifd+ErpIOqOE6ub
         i7AgbUspWf6aBxWN6avR4GPg4ogCXIvRCJ0p3E8TVe9PcdVLavyXTeEUUp0vnR4DlwG6
         gbKgP6wWK6KCmvQLzGjH33QCzq8jPAdfMSTRnZH+3ZuzuyDZLBtIXY1VDOeQKHMGAlex
         6tRX+YOYLABJrL8dISnRZbDeYSmsxaJB0jh0IP+17CxMY+dWs5j0b+E/2Mngrxj0mPO7
         OI4bf8LKbvVFdI9GsB/El2kQR+M6UQvJwYLWeoekUGRfQrUfRiYHi4gwemI3QExhKoCe
         y8Vg==
X-Gm-Message-State: AOJu0YxYKZXeIAc2CS/rO+0ZIS+WCtr4nvlKD5ZUdJeJGLkHGvawNyF2
	G3KDJYvGbwGL1BWSE3zOgo2zvR75Y4gvlvNqaPPXHze/oF5FteUHrQiLmvNDoys=
X-Google-Smtp-Source: AGHT+IGlBUMGQI5I4F6oHplktugB49kdqMcBdbQmnt8gsyL4F/vKpp0sd9GKbghrIKZLdKcwMXCLNQ==
X-Received: by 2002:a17:906:32d5:b0:a37:1639:b879 with SMTP id k21-20020a17090632d500b00a371639b879mr4766336ejk.3.1707119314386;
        Sun, 04 Feb 2024 23:48:34 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWWBCluFlbbwGHrl442Xwlx1yqDnaZzEr22oL8y1OVaRZNMFQgMqQI209VodyjP3vpBTYk3tH78bz1wDBT6cUG+itE2SP0iGmjgyxOqyQWLivENqe2sFapmEvzoepyOxew4TTAhIIGXgAmrhWiczA8srPU7RewYYgsmtssapjzpu/B1O++2/uOaFhhEUR6FPyajVMWo85hLc8THrtE32zqSL/PTBF+riUH1iCMbZJ4Bh+3rndoOzwxQesH4FTIjM+KtrX1fT/d81g3AFQ5H5ojisiFvY+srJfYgVVHDn5M=
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id vw4-20020a170907a70400b00a353d1a19a9sm4001879ejc.191.2024.02.04.23.48.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Feb 2024 23:48:33 -0800 (PST)
Message-ID: <e7ac77fe-b722-4b88-911c-c8300776370e@linaro.org>
Date: Mon, 5 Feb 2024 08:48:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] dt-bindings: power: supply: st,stc3117
Content-Language: en-US
To: Bhavin Sharma <bhavin.sharma@siliconsignals.io>, sre@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240205051321.4079933-1-bhavin.sharma@siliconsignals.io>
 <20240205051321.4079933-2-bhavin.sharma@siliconsignals.io>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240205051321.4079933-2-bhavin.sharma@siliconsignals.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/02/2024 06:13, Bhavin Sharma wrote:
> Signed-off-by: Bhavin Sharma <bhavin.sharma@siliconsignals.io>

You cannot have empty commits.

Subject: It's empty? What happened there?

> ---
> Changelogs :
> 
> v2 -> v3
> - Resolved DTC warnings and errors
> - Formatted the changelogs
> - Added monitored battery properties
> - Replaced 'additionalProperties' with 'unevaluatedProperties'
> - Replaced '&i2c6' with 'i2c'
> 
> v1 -> v2
> - String value is redundantly quoted with any quotes (quoted-strings)
> - Found character '\t' that cannot start any token
> ---

Please run scripts/checkpatch.pl and fix reported warnings. Some
warnings can be ignored, but the code here looks like it needs a fix.
Feel free to get in touch if the warning is not clear.

>  .../bindings/power/supply/st,stc3117.yaml     | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/st,stc3117.yaml
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/st,stc3117.yaml b/Documentation/devicetree/bindings/power/supply/st,stc3117.yaml
> new file mode 100644
> index 000000000000..9ab0b0d6b30e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/st,stc3117.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: GPL-2.0-only

Dual license, just like checkpatch asks.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/supply/st,stc3117.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: STMicroelectronics STC3117 Fuel Gauge Unit Power Supply
> +
> +maintainers:
> +  - Bhavin Sharma <bhavin.sharma@siliconsignals.io>
> +  - Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
> +
> +allOf:
> +  - $ref: power-supply.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - st,stc3117
> +
> +  reg:
> +    maxItems: 1

Are you going to answer my questions or just ignore them?

> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    bat: battery {

Drop node


> +       compatible = "simple-battery";
> +       device-chemistry = "lithium-ion-polymer";
> +       energy-full-design-microwatt-hours = <16800000>;
> +       charge-full-design-microamp-hours = <4000000>;
> +       voltage-min-design-microvolt = <3000000>;
> +    };
> +
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      stc3117@70 {

Still wrong name.

This is a friendly reminder during the review process.

It seems my or other reviewer's previous comments were not fully
addressed. Maybe the feedback got lost between the quotes, maybe you
just forgot to apply it. Please go back to the previous discussion and
either implement all requested changes or keep discussing them.

Thank you.


Best regards,
Krzysztof


