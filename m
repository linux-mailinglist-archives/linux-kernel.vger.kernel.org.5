Return-Path: <linux-kernel+bounces-81018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0DA866F1A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7083D1C23EFB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589DB84A4F;
	Mon, 26 Feb 2024 09:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VeiK6zdT"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7047D82877
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 09:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708938785; cv=none; b=F9bGxDvilbjE2X1OtAC/lu4GcK/cjUh77dlGVMBb2wnbAKJpc+QdNnzOluDQ41T/ivhPYB1MJCPS0ciELw3xVhDwn5ZcqnTVZ7tWl0ieN89gHnaikN2uhYgdRZN4oGmcqjeRbTnMzNTSUWecU6o9Z07voWLRKJylFcMkm+Zh7qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708938785; c=relaxed/simple;
	bh=KWGbGG8rfrPPvdpe7G9H/psbmmodTAi/gM+lU2rSfZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oicfK9pPPsxmSzHkdEUk925M+I0QbadRpvDE/pAmjOmxQ5hZWX9YQET9O5j7zEipdqr2gqsd/u8p05MWNQA8y/hQnu2aLsHgHmeASVslEsWfjxK5o2lwtPdc3sIse+klmsbkPS/PKLp0jw8CgOH+950JQFGneefU778N7FJ4rgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VeiK6zdT; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-42e7fa59fa2so3049651cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 01:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708938782; x=1709543582; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ecRoWB6BvHUhdzEjksTvnhXSI1/zwOKVS+LkVvmOMPQ=;
        b=VeiK6zdTqFj55xYZ506gR2kNCHhVwYGOZFuqjRKF8+p7mTzcIh95YmhuZwbjfADuBQ
         l0sUS01sKxbcO+V5wAqPyh+AXwfJDq4RVYyZEEJM1K/d1yRQHCjPvFnzdZYqvygrQxec
         lhkz3YborMaKIWsbP6Ur0eFRf2hxb0F92w7Z6MPDbaaKl2ShnzUXc6Ur+cw8eCwEjIqE
         4eIp4dzMYq8eiDEUYC8+0AMm5Ua0IPWPtsPQDSwhL/WvgS86tmrHvUz4tEPwUMATLO2U
         zBnZtFHqvBUvtG09wyaw8AZkjBu7L13AnT7Z8tYw4CVkELzD12L4whaaSXoR96Ao2txl
         jR3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708938782; x=1709543582;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ecRoWB6BvHUhdzEjksTvnhXSI1/zwOKVS+LkVvmOMPQ=;
        b=OLigmTrTmNcYy8KgbkGKXyPDtE2LdRyhueNPFdF8Xd+cegZew/+aKgsCduH/1WyIJU
         GStYGMazHYm4FuIvjspw/u2tQJQOcAo6fXfjEkT5izTa9mPbUx1Z4q45dI8e1Kdu5nsh
         XoRRfbmGSXEQ6+KFD9IO3baEToYXh4eIP442LtT2FfugG5zXQdIhBV+E4J4b6tosklbE
         LWITn6/+7sBthw2BrHfRaw2B3LxlqOTBDXpEf4KdDFhZ+NsY+ufKX+oaewMCSlY5o5ZD
         XKWqKHB63YbkwZtqI6y4NqmsDaRKWmgom6+ZYqpzANcmtQ5gjPaVKhXYsjN8TwY571+9
         pQhg==
X-Forwarded-Encrypted: i=1; AJvYcCUzVIkHJOob5/PaaGuTkmL/7CYRA4w8VH0IovQUQuGCvnOGl6swKLzJl6H5uMj6zIEkpjZDO8Ing+cg5glzhaEvJ7cnMxE7ABv+C1gc
X-Gm-Message-State: AOJu0Yyr+DkN2XKnAMRp24JhKZA7QDt1oEJA44kbHLMumGxZ3qR8W6jD
	g4xqyjRC99/XGft4zZMPupJrUrLGz7fcwAOu1le6EVZzRiiKY7OGRe8CH8hF5Vc=
X-Google-Smtp-Source: AGHT+IG5KS/lj1TIzuJzr6YyKgAoDATn+QTG722b2AW5Wb9VXy3fFbOF5K7XJkl+GNVP9f0gf2LiOw==
X-Received: by 2002:ac8:5909:0:b0:42e:8bb3:33b7 with SMTP id 9-20020ac85909000000b0042e8bb333b7mr871347qty.11.1708938782433;
        Mon, 26 Feb 2024 01:13:02 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id o6-20020ac85546000000b0042e637083b7sm2221677qtr.26.2024.02.26.01.12.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 01:13:02 -0800 (PST)
Message-ID: <13aeb2ff-72f4-49d9-b65e-ddc31569a936@linaro.org>
Date: Mon, 26 Feb 2024 10:12:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] media: dt-bindings: Add Intel Displayport RX IP
Content-Language: en-US
To: =?UTF-8?Q?Pawe=C5=82_Anikiel?= <panikiel@google.com>, airlied@gmail.com,
 akpm@linux-foundation.org, conor+dt@kernel.org, daniel@ffwll.ch,
 dinguyen@kernel.org, hverkuil-cisco@xs4all.nl,
 krzysztof.kozlowski+dt@linaro.org, maarten.lankhorst@linux.intel.com,
 mchehab@kernel.org, mripard@kernel.org, robh+dt@kernel.org,
 tzimmermann@suse.de
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 chromeos-krk-upstreaming@google.com, ribalda@chromium.org
References: <20240221160215.484151-1-panikiel@google.com>
 <20240221160215.484151-9-panikiel@google.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240221160215.484151-9-panikiel@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 21/02/2024 17:02, Paweł Anikiel wrote:
> The Intel Displayport RX IP is a part of the DisplayPort Intel FPGA IP
> Core. It implements a DisplayPort 1.4 receiver capable of HBR3 video
> capture and Multi-Stream Transport. The user guide can be found here:
> 
> https://www.intel.com/programmable/technical-pdfs/683273.pdf
> 
> Signed-off-by: Paweł Anikiel <panikiel@google.com>
> ---
>  .../devicetree/bindings/media/intel,dprx.yaml | 160 ++++++++++++++++++
>  1 file changed, 160 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/intel,dprx.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/intel,dprx.yaml b/Documentation/devicetree/bindings/media/intel,dprx.yaml
> new file mode 100644
> index 000000000000..31025f2d5dcd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/intel,dprx.yaml
> @@ -0,0 +1,160 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/intel,dprx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Intel DisplayPort RX IP
> +
> +maintainers:
> +  - Paweł Anikiel <panikiel@google.com>
> +
> +description: |
> +  The Intel Displayport RX IP is a part of the DisplayPort Intel FPGA IP
> +  Core. It implements a DisplayPort 1.4 receiver capable of HBR3 video
> +  capture and Multi-Stream Transport.
> +
> +  The IP features a large number of configuration parameters, found at:
> +  https://www.intel.com/content/www/us/en/docs/programmable/683273/23-3-20-0-1/sink-parameters.html
> +
> +  The following parameters have to be enabled:
> +    - Support DisplayPort sink
> +    - Enable GPU control
> +  The following parameters' values have to be set in the devicetree:
> +    - RX maximum link rate
> +    - Maximum lane count
> +    - Support MST
> +    - Max stream count (only if Support MST is enabled)
> +
> +properties:
> +  compatible:
> +    const: intel,dprx-20.0.1
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  intel,max-link-rate:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Max link rate configuration parameter

Please do not duplicate property name in description. It's useless.
Instead explain what is this responsible for.

Why max-link-rate would differ for the same dprx-20.0.1? And why
standard properties cannot be used?

Same for all questions below.

> +
> +  intel,max-lane-count:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Max lane count configuration parameter
> +
> +  intel,multi-stream-support:
> +    type: boolean
> +    description: Multi-Stream Transport support configuration parameter
> +
> +  intel,max-stream-count:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Max stream count configuration parameter
> +
> +  port:
> +    $ref: /schemas/graph.yaml#/properties/port
> +    description: SST main link

I don't understand why you have both port and ports. Shouldn't this be
under ports?

> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: MST virtual channel 0 or SST main link
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: MST virtual channel 1
> +
> +      port@2:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: MST virtual channel 2
> +
> +      port@3:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: MST virtual channel 3
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +allOf:
> +  - if:
> +      required:
> +        - intel,multi-stream-support
> +    then:
> +      required:
> +        - intel,max-stream-count
> +        - ports
> +    else:
> +      required:
> +        - port


Best regards,
Krzysztof


