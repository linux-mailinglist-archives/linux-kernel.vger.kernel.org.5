Return-Path: <linux-kernel+bounces-23585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E23E582AEAE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 799512835D6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB8915AC8;
	Thu, 11 Jan 2024 12:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdQDS2z7"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D5E156FA;
	Thu, 11 Jan 2024 12:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-557bfc7f7b4so7033788a12.0;
        Thu, 11 Jan 2024 04:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704976020; x=1705580820; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UcsS30oLNF+15HonMizYeXd7X0XQ7B9Q4Oyta+50u+k=;
        b=AdQDS2z7qVwEoyrrZnuBcBvbA+jXaiK/EDLq7jAUQy4gxyvfhcfVT/H1DmdeQjFj2L
         mQVSp9LYqvljRf+arDiu3yHTYamXb+l1FHTHv+dUuQyXIOE9uOhPKcP241gUxp8MpzLJ
         w4mWJqeH+629FgeyS1hrlVaXizJQwTBcFFWG0Vwg87P0quAc31jIOCWTT5iDQj0xQrwN
         ZyGykit81Vs2DNGByr7TnFsA/uHsEPXtQX/LOCIuSJWPCGA9gNIKJEmsvbzwlaqvj49t
         ZJE7nspAYMq8eoBfy9ApjzDJBNNf7ZYjFP5PdI5vjnZW3sLF2oXOiQmZdYZLhLGL+04V
         L+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704976020; x=1705580820;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UcsS30oLNF+15HonMizYeXd7X0XQ7B9Q4Oyta+50u+k=;
        b=hY1aH8H8AKogZ/V9HHCtk/aU2Ml/9sESpyPZDzufSYjPZf3jypZQ/NXaqoEIyEtKon
         YhzVMyrvtEIUQjn2Z+J8V7P+TsVbPBG6RlJLChvPr8iLHPCR0DE5kmVUUnWW/iUOH2IP
         tcedXYgJzZ5COT0HicPo/F4nP0+YEFg3WOntgBsPRitRBt5CQ5aIkOWUdTZjIUIayGQY
         tXWaGk16jZlCIsCo1xaucvRa5cSaEqmi6Ys9/bPWHkTRYwO7R5da+AWGswQGMTzpU6uf
         fgF9umLv64+QjQbd2TEBiytqvwivaHYmhce9GAdzFL7Rh40tq73RjkMIIf8OVucQT5bv
         xxPA==
X-Gm-Message-State: AOJu0YwwUaTAImUbL9hiRtei8NJNRO1WAddBf+L3YRjVviApQDPmIQB9
	SpkWW4tWZOknKyJPbd5RcPs=
X-Google-Smtp-Source: AGHT+IErfTC0KKSKgyzGQNzugPo9s7gpZFwlhHDqDTeAhAgqO7SVNL84UAAMThS0PCKWyYCLKcO6ow==
X-Received: by 2002:a17:906:fb05:b0:a2a:e479:3fc with SMTP id lz5-20020a170906fb0500b00a2ae47903fcmr788447ejb.45.1704976019880;
        Thu, 11 Jan 2024 04:26:59 -0800 (PST)
Received: from [192.168.26.149] (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.googlemail.com with ESMTPSA id y20-20020a170906471400b00a29430458efsm527531ejq.65.2024.01.11.04.26.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 04:26:58 -0800 (PST)
Message-ID: <cbb1a43b-bda7-4c84-8e08-df02130b2812@gmail.com>
Date: Thu, 11 Jan 2024 13:26:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: mtd: partitions: make partition an NVMEM
 provider
To: Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Ansuel Smith <ansuelsmth@gmail.com>, linux-mtd@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240111121940.15628-1-zajec5@gmail.com>
Content-Language: en-US
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <20240111121940.15628-1-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Cc Srini & Greg (please keep them in loop in case or replies)

On 11.01.2024 13:19, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> MTD partition provides flash device data and can be used as NVMEM
> device.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>   .../bindings/mtd/partitions/partition.yaml       | 16 +++++++++-------
>   1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/partitions/partition.yaml b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
> index 1ebe9e2347ea..7b1d84ce5ef5 100644
> --- a/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
> +++ b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
> @@ -57,13 +57,15 @@ properties:
>         user space from
>       type: boolean
>   
> -if:
> -  not:
> -    required: [ reg ]
> -then:
> -  properties:
> -    $nodename:
> -      pattern: '^partition-.*$'
> +allOf:
> +  - $ref: /schemas/nvmem/nvmem.yaml
> +  - if:
> +      not:
> +        required: [ reg ]
> +    then:
> +      properties:
> +        $nodename:
> +          pattern: '^partition-.*$'
>   
>   # This is a generic file other binding inherit from and extend
>   additionalProperties: true


