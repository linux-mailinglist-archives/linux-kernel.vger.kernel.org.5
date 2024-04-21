Return-Path: <linux-kernel+bounces-152490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4748ABF35
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 14:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9C171F2108F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 12:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2006113FEE;
	Sun, 21 Apr 2024 12:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMjiKE98"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E605B134BD;
	Sun, 21 Apr 2024 12:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713703299; cv=none; b=aBHTEoU7A16IT1D7tVei00Y6cEDR7+wSUXDzQvOlQl782TCvcu0McYX+iA803OuRhkfXVcCj+Nn3cof5zXN6LLqSop8bRhl9NI/9qveOnpKucp1byu0Jd7OVLMBRu619lQLtMazUXiFGqAETqDd793CkF823Z7x+7WmXjFbx52o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713703299; c=relaxed/simple;
	bh=5nn5ZTbRNI17WXZk1uoDXhmQGmBLj4O06b+FRBZ6lbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Le+hHgoY2KB6giTErVX5XC3ShN7oiSMwdH1RYU9GQ94nrARPlAV9ptSCYllAARCoVI2C3Rx7ZCPRy0AWRzXKddBr3+pUx7NqSKcaJ328nAjiyggS7mRdnU9ZdxvvcZX4DtIYj9335mqiLo/56XOBJTa1B5TB0q6xOPALM0GVvXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eMjiKE98; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e8b03fa5e5so22912765ad.1;
        Sun, 21 Apr 2024 05:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713703297; x=1714308097; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F6Ps2aN6MCZCIs2EOfKowy6au+rDDkfSq1Sb07wmGTE=;
        b=eMjiKE98UeO/7NVK/dlQMY33jYAliYeGrfpIyc1kY4/mXiGMF/2VylynXk2gicCS9K
         gKigoJRSSC70ryWIHvfUU2mjfQ0/h21y80RKID7D6cdR/c+gcuCPhepxzRwYXI5qp2wq
         Ttk2ASbYmSG+DdOsxUAC1u4o6MvuuOg7ADi0ITVXPGNX0BFyRWtC/vkYsZpahBhSOL3V
         lJYdNETaA0BjaURY2KHTb8IyvQl3ZCBX4MGVtE0GOlQcjyy3JRhQDVfGQ4iejTti03KD
         HRJkO7RcdnY3YmvxQP6pY7Jmv1fcR4+Vux/v9wTtojSTbplJJzOdnJ9Um0TnRR8xkzYQ
         Hl1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713703297; x=1714308097;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F6Ps2aN6MCZCIs2EOfKowy6au+rDDkfSq1Sb07wmGTE=;
        b=f5q+6ccd+kF2PIbFG4n9LxevncUi13bttHAEHCSA2gyZgYgjPdUsIofmTo3lxfObCj
         TwzfH1jKjaJq/HTJECvRRHEGTYPKxWVaEjMv6ncR5B45Iikw0ouf4SeRv40zCw7MbUHd
         eBab/RFLuMdAYNiB4HeeaCmmX4S10WZfV4Hun+O8eOzdBCEEmpGJB0I4ZAQZIYOZXyY0
         Mxbom0qGrZV+v+hYrwKBWOaWFKHCshoQMCYwMQFnoknPm7sp3SdfJFMOsqkG1fLSIFU0
         ppaUYmOl3oSEeZr2HuBzlEumsn+ktqoD0hkCUFBypU9nXkD/qFMrmrGShji6B9ro4SJq
         UvFw==
X-Forwarded-Encrypted: i=1; AJvYcCW9tOHy8ySJFCFo5I1cMHaKEG225690G2Wsy3Da6Ib22Kv4sklSxdHWeJxebLsEeirYxpn0X5lk68rF1xtpe4jZ54XJcxUPOKcfSTPg7S5PUPK7kie/D34X5t2GORnxMnOECercVUo54b3knTQbahL4vk5BvknSoBVAZrV/XYDfw+bpOjRfdeL/l+he6lLVZFp6aFbyGXkBEKKOXTgIX0I1RUY=
X-Gm-Message-State: AOJu0YyoJXmhiuGux4U0Ym1IFoIRsBt4M1F7TkyDqaPXUGa8oixbkhnw
	xz7PMAlg38XxbQ+AkGZEmM44ENfL0QXNm0QSAmzHm4MLOskAkimX
X-Google-Smtp-Source: AGHT+IG7HZMh1J7lM1Rs1GW1Qd7h6wDjUcDqMV/1KWhlbtkcxmI/8blJXFnTkatcRPMkoBQPLFeOdQ==
X-Received: by 2002:a17:903:2441:b0:1e4:fd4:48db with SMTP id l1-20020a170903244100b001e40fd448dbmr11061791pls.43.1713703297232;
        Sun, 21 Apr 2024 05:41:37 -0700 (PDT)
Received: from [10.66.66.2] (ec2-3-111-32-5.ap-south-1.compute.amazonaws.com. [3.111.32.5])
        by smtp.gmail.com with ESMTPSA id u7-20020a17090341c700b001e2a7fb6e01sm6275894ple.44.2024.04.21.05.41.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Apr 2024 05:41:34 -0700 (PDT)
Message-ID: <0fa7ef43-29c2-439b-b82f-5c287001f850@gmail.com>
Date: Sun, 21 Apr 2024 18:11:27 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] ASoC: dt-bindings: tegra30-i2s: convert to dt schema
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Thierry Reding
 <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>
Cc: Thierry Reding <treding@nvidia.com>, linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240420175008.140391-1-sheharyaar48@gmail.com>
Content-Language: en-US
From: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>
In-Reply-To: <20240420175008.140391-1-sheharyaar48@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/20/24 11:20 PM, Mohammad Shehar Yaar Tausif wrote:
> Convert NVIDIA Tegra30 I2S binding to DT schema.
>
> Signed-off-by: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>
> ---
>   .../bindings/sound/nvidia,tegra30-i2s.txt     | 27 --------
>   .../bindings/sound/nvidia,tegra30-i2s.yaml    | 68 +++++++++++++++++++
>   2 files changed, 68 insertions(+), 27 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra30-i2s.txt
>   create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra30-i2s.yaml
>
> diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra30-i2s.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra30-i2s.txt
> deleted file mode 100644
> index 38caa936f6f8..000000000000
> --- a/Documentation/devicetree/bindings/sound/nvidia,tegra30-i2s.txt
> +++ /dev/null
> @@ -1,27 +0,0 @@
> -NVIDIA Tegra30 I2S controller
> -
> -Required properties:
> -- compatible : For Tegra30, must contain "nvidia,tegra30-i2s".  For Tegra124,
> -  must contain "nvidia,tegra124-i2s".  Otherwise, must contain
> -  "nvidia,<chip>-i2s" plus at least one of the above, where <chip> is
> -  tegra114 or tegra132.
> -- reg : Should contain I2S registers location and length
> -- clocks : Must contain one entry, for the module clock.
> -  See ../clocks/clock-bindings.txt for details.
> -- resets : Must contain an entry for each entry in reset-names.
> -  See ../reset/reset.txt for details.
> -- reset-names : Must include the following entries:
> -  - i2s
> -- nvidia,ahub-cif-ids : The list of AHUB CIF IDs for this port, rx (playback)
> -  first, tx (capture) second. See nvidia,tegra30-ahub.txt for values.
> -
> -Example:
> -
> -i2s@70080300 {
> -	compatible = "nvidia,tegra30-i2s";
> -	reg = <0x70080300 0x100>;
> -	nvidia,ahub-cif-ids = <4 4>;
> -	clocks = <&tegra_car 11>;
> -	resets = <&tegra_car 11>;
> -	reset-names = "i2s";
> -};
> diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra30-i2s.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra30-i2s.yaml
> new file mode 100644
> index 000000000000..3809e4049fe1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/nvidia,tegra30-i2s.yaml
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/nvidia,tegra30-i2s.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NVIDIA Tegra30 I2S controller
> +
> +maintainers:
> +  - Thierry Reding <treding@nvidia.com>
> +  - Jon Hunter <jonathanh@nvidia.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - nvidia,tegra124-i2s
> +          - nvidia,tegra30-i2s
> +      - items:
> +          - enum:
> +              - nvidia,tegra114-i2s
> +              - nvidia,tegra132-i2s
> +          - const: nvidia,tegra124-i2s
> +          - const: nvidia,tegra30-i2s
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    const: i2s
> +
> +  nvidia,ahub-cif-ids:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description: |
> +      The list of AHUB CIF IDs for this port, rx (playback)
> +      first, tx (capture) second. See nvidia,tegra30-ahub.txt for values.
> +    minItems: 2
> +    maxItems: 2
> +    items:
> +      $ref: /schemas/types.yaml#/definitions/uint32
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - resets
> +  - reset-names
> +  - nvidia,ahub-cif-ids
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2s@70080300 {
> +            compatible = "nvidia,tegra30-i2s";
> +            reg = <0x70080300 0x100>;
> +            nvidia,ahub-cif-ids = <4 4>;
> +            clocks = <&tegra_car 11>;
> +            resets = <&tegra_car 11>;
> +            reset-names = "i2s";
> +    };
> +...

There was a mistake in setting items type under 'nvidia, ahub-cif-ids'. 
It has been fixed in v2 patch. Sorry for the mistake.
v2 : 
https://lore.kernel.org/all/20240421123037.75680-1-sheharyaar48@gmail.com


