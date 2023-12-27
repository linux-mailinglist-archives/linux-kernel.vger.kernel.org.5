Return-Path: <linux-kernel+bounces-11997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8E681EEA9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 12:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC77A1C2242F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 11:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A123446BE;
	Wed, 27 Dec 2023 11:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iHsBF6p4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42332446AC
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 11:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40d41555f9dso52790485e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 03:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703677816; x=1704282616; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ia0P3iyf0oVBaYiGItsgj3qtRaubr/Bd22f7FB2O5mg=;
        b=iHsBF6p4XXHMmAsTnKai0nDLV/7Qrq28IqVnzVEvmFiK62A3FYm4WzuTDUbccEoNkC
         XRl2qACoda2E4QMI2QtQQC86N8jgCk4jyBxchQLTBjLSa2y+A30EVrpIArqP8a4rnkqT
         3uYAfMsWtOooO1dm/q4nvEUMQrmslNwKGxTwaSrO6VYsed/0PCJND4/Vqi+FwLOQaUQq
         QkUbTdjofEU2gS3T6g3TQaRnwrVoPjI9LZUVtyT3dxPq13efdHmnNiRarMgAke+53CBL
         ed2YJ17TvN75TU02XOHtyPtMLET2H1FTgLtSBbhEVVix0Hgy5qvKi9FdSTq3DGDWNeUF
         FKRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703677816; x=1704282616;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ia0P3iyf0oVBaYiGItsgj3qtRaubr/Bd22f7FB2O5mg=;
        b=X3QwVBzPowqbD6EabWcWtOvHVlz/RgTBQMX89ArRetsLjK6dIVbZRhYj9X/5HCrrts
         XdBZEetvmgK9BEkhFjTIReReGcL0JWL9pshdJ85yc1BvXI4eB+O+yLWWTUuS7rIwsHuS
         r1ahyxjg+1GvdyiJruZ4ylAJ1ytmb2VlhVgQsCVGzbpcd55uqHwhl3PgN11nvdAn5Iho
         og6+YOHyhUBX32eqAvYf+40Gt9yZDABn7a6ErkONDBamzXtDz5WehwnziwyhhQBYr9sr
         4SKZxVbbcmXruqQN9A3Hs9pun47wGXh34SrvANtx3NKYP7VLuARq1StwVIT+wjuHbuWl
         Eu+Q==
X-Gm-Message-State: AOJu0Yx05JI9TkSJui314mCZLKqBGWt97BQMUqF12vRwQIpazXtK91Pk
	8MHhMTjJDQE6+bDe9D+Y0o7QNtuXEgMg1g==
X-Google-Smtp-Source: AGHT+IGFVYzWyYdH/z06O4cT5xdXHgEmV+v0nOPZ5U4+ZnpMyRqJJ3l93Rt0oGznxOWE1GexkuLc/g==
X-Received: by 2002:a05:600c:a01:b0:40d:30c0:dda8 with SMTP id z1-20020a05600c0a0100b0040d30c0dda8mr4877846wmp.170.1703677816602;
        Wed, 27 Dec 2023 03:50:16 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id p2-20020a05600c1d8200b0040596352951sm32460032wms.5.2023.12.27.03.50.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Dec 2023 03:50:16 -0800 (PST)
Message-ID: <1adf1fc6-1b9d-4174-beac-5b6b9edb4dd7@linaro.org>
Date: Wed, 27 Dec 2023 12:50:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/8] dt-bindings: marvell: a38x: add solidrun armada
 385 clearfog gtr boards
Content-Language: en-US
To: Josua Mayer <josua@solid-run.com>, Andrew Lunn <andrew@lunn.ch>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231226-support-clearfog-gtr-l8-sfp-v3-0-fd1ac2d6bf2e@solid-run.com>
 <20231226-support-clearfog-gtr-l8-sfp-v3-2-fd1ac2d6bf2e@solid-run.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231226-support-clearfog-gtr-l8-sfp-v3-2-fd1ac2d6bf2e@solid-run.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/12/2023 19:11, Josua Mayer wrote:
> Add DT compatible for SolidRun Armada-385 based Clearfog GTR L8 and S4
> boards.
> 
> Despite similar name these two boards are designed differently from the
> armada 388 clearfog base and pro, they only share a name and general use
> case.
> 
> Signed-off-by: Josua Mayer <josua@solid-run.com>
> ---
>  Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml b/Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml
> index 5af222e6db18..5bc69c4fe34d 100644
> --- a/Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml
> +++ b/Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml
> @@ -30,4 +30,12 @@ properties:
>            - const: marvell,armada385
>            - const: marvell,armada380
>  
> +      - description: SolidRun Armada 385 based single-board computers
> +        items:
> +          - enum:
> +             - solidrun,clearfog-gtr-l8

When I pointed out in your previous versions that you do not test
patches, I did it in hope to encourage testing patches...

Standard boiler plate:

It does not look like you tested the bindings, at least after quick
look. Please run `make dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).
Maybe you need to update your dtschema and yamllint.

Best regards,
Krzysztof


