Return-Path: <linux-kernel+bounces-128626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1A6895D2D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FBEFB25645
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB61915D5D3;
	Tue,  2 Apr 2024 19:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtQm2YaS"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536B015CD53;
	Tue,  2 Apr 2024 19:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712087821; cv=none; b=QqEeXcbgza/dkAunEUTFihJxOppRGiqHNNSZJQMbrJXU2tpq17PGa0TbMA+LQpQoDYh5jpEAKkI6/Q2i6fTTQ18Oq+W2a2OmNlVp0zw8Bh324lO1xHmRCbyOkm2qxVCha+hkIlk7Nn+98OtC3QXXLbsj/uXgrYX30wuhRV5h7yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712087821; c=relaxed/simple;
	bh=H+CJwRc2912b6nD2Ih3u13fV2MljjiN6PEppvJcgp20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s9oNaqv9t0XU86LNxvj7ot7rMo7Hhu0XlYNBGkaM0GYQgZpzM5c1DGreZwwxVyV3AcXwDaXbuL37/J5eAarChSmLyM/Sw61lkmn3WB9lDO6i+StCsdtn7STrAOoOuxBucf+cxtrwGn1Hv6nOz+aaXf9vaeeKB5vyox7dHEGteOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KtQm2YaS; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a4644bde1d4so755222066b.3;
        Tue, 02 Apr 2024 12:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712087817; x=1712692617; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tVIGx7ik4JbWBNp+SY29/AwVMNtIA1b6xEQoLQV5riA=;
        b=KtQm2YaS21CdKI47hT4Mu28X9YkzJqih6DbvX8u9jLFgJjHqwojvanyYi62Oqel0Dv
         CtA8eagmj7UlOUpafv48rRom4ePni/mRFjXk/V+SJRw+IEANe+q6aA1zvV/x3mF5Hj22
         u+c6Y284ss7t9+Wn4k6CevXXKQJj90mpqf+tI8N4CQY66b2QghKi7EJV5aFImXXmU+oI
         AULP1CbiWEzEmqPK/B26JnN4M/8dNc/QyB00f9gZtVgu7aXsVGTr4E/CCNZWXwGwYowT
         sxVWBc5fdSOfwLpXJTV8vnlL0zqV20z9Hj2EWo0MKmSieByXgea18gTb9T+JAvZyDwOS
         c0ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712087817; x=1712692617;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tVIGx7ik4JbWBNp+SY29/AwVMNtIA1b6xEQoLQV5riA=;
        b=Rhyy/auXGn9QAcNAyurgHN9OYyY5PLFFtb7cbuleOEHWbs0LSfDy0d0Q0mQxbql6QW
         sS2GKPBT6zRsBLNF6ubGDY18phsyDOD3tUIc/Vw8ZStPeFeNkRnpdhkKH3PqKunn3fNb
         tJEqdTuR87t9PC0eCx6F+x+yOMmke9v90AEdWoKO0O10ctETJPaB8vm5zR7AGLNrW4P0
         H5fuQoUuKeu4xLsIcHzZbhX4cxJpHXa5yC9dYpLoS9MF4gHCtw4N/nL7D0SDaSXKcV39
         6S3oQRsqgc9VN1peeJfjbx6DFpiw1Z2B8LQPsBzDz/yPI2GkvYFrB+5mjRoKN4CcV0v5
         6tNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAUBIn8T0K5wHZCL+yoKVMyWgyZM8j6Bi3JupE0Xyrcgonfqe4rnVg1489+bIuO258JZdM4qxieOfLn9u+MyT+O6tziMUkl3xOaP9o1j0esUVfJvkXQ4pbLDuZtjM++aIhHEAELWaB7DTY4zQ5pWvzkqcLxUgAuqfmjJbUTAoC2W1/pZkPYrA=
X-Gm-Message-State: AOJu0YxOzNjXxXXsMNmCY4lGEDw+PgGoRx8cqOlcPtfx3UVazBcsnO0G
	5isRjC2YUOFx+wnmoKYfnVi41Ajo/6Rwjp5uNPyEIaV5sfu+SLoQlJe6brF7
X-Google-Smtp-Source: AGHT+IHd34X6G0IdGs3i8h40+amOyl+iU7TtyG8nE4zHIVY0wUHrry8OcOvNzFNz5x84BnJUYlloOQ==
X-Received: by 2002:a17:906:594:b0:a47:32b3:18c5 with SMTP id 20-20020a170906059400b00a4732b318c5mr7875589ejn.68.1712087817348;
        Tue, 02 Apr 2024 12:56:57 -0700 (PDT)
Received: from [192.168.26.149] (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.googlemail.com with ESMTPSA id l3-20020a1709067d4300b00a466af74ef2sm6871329ejp.2.2024.04.02.12.56.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 12:56:56 -0700 (PDT)
Message-ID: <3f817155-3660-439f-b6e5-8d32c866f5cf@gmail.com>
Date: Tue, 2 Apr 2024 21:56:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] dt-bindings: phy: qcom,ipq8074-qmp-pcie: add ipq9574
 gen3x2 PHY
Content-Language: en-US
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: ansuelsmth@gmail.com, robimarko@gmail.com, linux-arm-msm@vger.kernel.org,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240402192555.1955204-1-mr.nuke.me@gmail.com>
 <20240402192555.1955204-5-mr.nuke.me@gmail.com>
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <20240402192555.1955204-5-mr.nuke.me@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

One minor mistake (I believe)

On 2.04.2024 21:25, Alexandru Gagniuc wrote:
> @@ -61,6 +61,43 @@ required:
>     - clock-output-names
>     - "#phy-cells"
>   
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,ipq6018-qmp-pcie-phy
> +              - qcom,ipq8074-qmp-gen3-pcie-phy
> +              - qcom,ipq8074-qmp-pcie-phy
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 3
> +        clock-names:
> +          items:
> +            - const: aux
> +            - const: cfg_ahb
> +            - const: pipe
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,ipq9574-qmp-gen3x2-pcie-phy
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 5

This should probably be minItems: 5.
You already have maxItems: 5 at global property.


> +        clock-names:
> +          items:
> +            - const: aux
> +            - const: cfg_ahb
> +            - const: pipe
> +            - const: anoc
> +            - const: snoc
> +
>   additionalProperties: false
>   
>   examples:


