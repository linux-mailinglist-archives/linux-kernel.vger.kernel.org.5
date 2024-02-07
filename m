Return-Path: <linux-kernel+bounces-56095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E29C84C5E1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 08:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 059A928B0B2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 07:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFDF200B8;
	Wed,  7 Feb 2024 07:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uDem5nXC"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12C120303
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 07:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707292688; cv=none; b=peq7kNtij6aIZ4ERFDymtsitHWIXfmj1HjUn62X5sE7BqGI171HpIyX+cMkvkc2gIJjvjRFcsKIjHz2VQPSa15zCyogor4Fa4voss2GtSO83dZb1m7XPgMIRWShpc8b91nGaUdbbUdWBcTd/2bfSCSq4spADSK8wiRRQcDvV6sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707292688; c=relaxed/simple;
	bh=MCSpeewmE+j3/rytl3OjrJdIrcbi5ZMzLaK558jb5eo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DTWt/AKQsqpI5PLGxP69lTWrxYgQSk59AMriHXxwG60qSy/m1Ks+brJ+OzWyR/DhTSnIhb1E8l/97tz8CJPjOXHLIt/g+o3UNpTeUDwKTxpilf27S/ZTV/s9Tnd/eJ6T2CV7qP0Ud+woVblYXtbfC/oSuMGztj/xFEAA1bAMzVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uDem5nXC; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3394bec856fso814531f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 23:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707292685; x=1707897485; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=efejXOz8gCY+wvZXYadjG5gx4t/4ddj+jd7SccrGXh0=;
        b=uDem5nXCph4mf/f+lo5C+jFNkOH9YxqNZBMquNiAXSMQaXxE5jqXGTN5/1063MM+6g
         ooPUcl515L6qbYfELTEbJ2thuyzBmEnuKfp2+sdcJ8lhqQCnod23qbZTnuzGwZi+i6Uu
         qEmp4WnPAiI3rt3Ot5Yt9lwWvFZtSoF/p4SrmvdvJwD5W7kcAF+LBGlcVXwdvUgd2Gh6
         BkYkKSGL3+Gfpnml6RSBF8m8vNRoHzsB/m1/DP6E1zpdcqigkpQ0g/mgdVWR2Lalf5pG
         9lR6IzjkYaURTVA2SsAsN+MBGy/iVrXfPtvwyIYbKgAzKyQt8YU5G73293Bf0XMWIWBP
         Wp+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707292685; x=1707897485;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=efejXOz8gCY+wvZXYadjG5gx4t/4ddj+jd7SccrGXh0=;
        b=nGa3yq01/TUjLxSoR+3R9bQNsIrAAxqjEuAU0Z/uQHtydiHeXoeqMpS3FeS0jLNNSC
         F81MtuxutlWg6TRMMy9w6d/fTq60L4FzoeFzLojBZWmJMcyQSiMKReymFwhDzKROSXdZ
         04nLBSkdYaHqE2/dNqSvkYE6W+WfMnSl5O5FTF5JSAKbVdC+65HkAtxz4pGIr2oFox8n
         P84QYDBwO8oIPMgyq6zuzlj+qJ3EEROG5OWfsZGqwySR3/ZNYQdMJqPJZBA3HD/PyiOk
         LeS8bAzI7WBtKLo/BMRJCEYqcWZ6Z1CN8BadJPnfD/SJhfbrt9HC3vG8c5nQb73r9Xr/
         ZaAA==
X-Gm-Message-State: AOJu0YyBV7ltkDg5/KdweAVdk2BtA59diB0uXmU3lVv/jW4bPNdr+Y22
	RsagaelBHTkw3G6P6m2eu/L2nTonQE3If8qgdc4SrjK002B2nk26G9N7eXBNVZk=
X-Google-Smtp-Source: AGHT+IFb6ObjpyOJxVq3L4ZUhu1tH0PEKzQnvH127fjCv02vWQ+jK5c5H5/RbUaZFyctNrx8Fg/RAg==
X-Received: by 2002:adf:e6cc:0:b0:33b:4d2d:e97c with SMTP id y12-20020adfe6cc000000b0033b4d2de97cmr1067582wrm.2.1707292685259;
        Tue, 06 Feb 2024 23:58:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXCcCnmeFicXReM+CUJJGa7IKi/BrvFp3SKxW+oiU1lhtcInakBAQqLG0q8Q8bg9AKN0gbyDyIR38woYgEHNBC1NMuX5ftwiKqId96/NPlhZWUNuKt56xdVXHl2tHKDtSEDcaVmospl2X9MZKdf91BT1WJNpFmDykOJODVtDPQgIypxKdF/tQM+fZlgFC8DeY0R8u27CCXiKbb3EhMP5SDR+wxx+6IPn5PLbJQU8Dr+VJ/bxmXHvR1sY0XPsejc2JOdkiMl2X8woGTD2j6gpHoH32vBxGxh1NZiOdcoAij8tvWP+sr+vqljTcpzlr8GFBnIbHD7XamnX7NaH9364stVQHiZlT3NkjgKKFQbisR+pftr0AwNFDrdlR4A2/MD+WmdpfZJNlMzqKS0UjgZ6mVUOuM2Okr83kLlouOHTAA=
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id v16-20020a05600c445000b0040ff7e3170asm1193518wmn.2.2024.02.06.23.58.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 23:58:04 -0800 (PST)
Message-ID: <ef617fb5-8086-4f86-b855-e27fd69751fd@linaro.org>
Date: Wed, 7 Feb 2024 08:58:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] dt-bindings: hwinfo: ti,k3-socinfo: Add nvmem-cells
Content-Language: en-US
To: Markus Schneider-Pargmann <msp@baylibre.com>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Santosh Shilimkar <ssantosh@kernel.org>
Cc: Andrew Davis <afd@ti.com>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240206143711.2410135-1-msp@baylibre.com>
 <20240206143711.2410135-3-msp@baylibre.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240206143711.2410135-3-msp@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/02/2024 15:37, Markus Schneider-Pargmann wrote:
> The information k3-socinfo requires is stored in an efuse area. This
> area is required by other devices/drivers as well, so using nvmem-cells
> can be a cleaner way to describe which information are used.
> 
> If nvmem-cells are supplied, the address range is not required.
> Cells chipvariant, chippartno and chipmanufacturer are introduced to
> cover all required information.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Reviewed-by: Andrew Davis <afd@ti.com>
> ---
>  .../bindings/hwinfo/ti,k3-socinfo.yaml        | 23 ++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/hwinfo/ti,k3-socinfo.yaml b/Documentation/devicetree/bindings/hwinfo/ti,k3-socinfo.yaml
> index dada28b47ea0..f085b7275b7d 100644
> --- a/Documentation/devicetree/bindings/hwinfo/ti,k3-socinfo.yaml
> +++ b/Documentation/devicetree/bindings/hwinfo/ti,k3-socinfo.yaml
> @@ -26,9 +26,24 @@ properties:
>    reg:
>      maxItems: 1
>  
> +  nvmem-cells:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array

You do not need to redefine the type. You need constraints, so maxItems.

> +
> +  nvmem-cell-names:
> +    items:
> +      - const: chipvariant
> +      - const: chippartno
> +      - const: chipmanufacturer


Best regards,
Krzysztof


