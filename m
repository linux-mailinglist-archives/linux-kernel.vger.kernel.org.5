Return-Path: <linux-kernel+bounces-72798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0731B85B8C3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9079E283028
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571C6612CC;
	Tue, 20 Feb 2024 10:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qFdiNDyu"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47C660EC1
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 10:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708424142; cv=none; b=bb6L4H2pHN9gGCGTDrNbWCKDesz1vo1dM6BiJIi4dsljA3qa5dUDmWKzQPiKBM6zaTTBseSwx8Gg317aTcsltLwMdYM0Be/IYst4H8S6SMZ8FYsG4Eq8rR52dekCJdrT1T/WIZqWKYM8zNA8aZ73rwAqZFjPWnLXuzrqQCh4msM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708424142; c=relaxed/simple;
	bh=uX2B0jP0D9M3Y2CGYkBKjo7RKMPBfIlTWEJRP/Scmak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=av5BwjbelagBitra2nJVpCoHwy0x0nEx419PeweKiLsv6aNbx8A1HBHGt3nNt6eBHgK5n9PwDntJsGgmfKwdqdEhDrnHJYqO/7jfJF9d13aj5x/saiPnKVtrt0U4j8i4DtuSXSQAeiy4QldzgX+P6l9+U6N71QJeLIkkbTCsLEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qFdiNDyu; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33adec41b55so2570971f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 02:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708424139; x=1709028939; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JWJIZkQ84H8VrrzMRLDDOWJxtugaAQv5s0ibRozT2KI=;
        b=qFdiNDyuiag2avdVEarM1BPoggIEJcFnzoK3+0Q7SFWuJtgv/1eN8GQ7vAeZeT+M8/
         BWfgUJWZA0S3JGUDQ1yfZTyczHmPbazjMiAZ8KJ55ulEf3qDPxXnkKZ7LjHow4X1Tby0
         QBPoM5PejNOMThc7LtQ7mt7Ap5xuVMEskWsd2z5E1A1Wt0QlgBYvlM06UYZceBKFGolu
         pXWBjpxz+7tsBn8LlVFFxoXCJ9IANVV3od/Xul3m+i7fv73l44YouTAlLKRhfrZHWJ9b
         V8zQ9sHtdQDGBkdzzCzsCc1posOgYaM3sA0NztNxbh+aOCUeNmtOoLClIbSm6GaYe/Xn
         087w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708424139; x=1709028939;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JWJIZkQ84H8VrrzMRLDDOWJxtugaAQv5s0ibRozT2KI=;
        b=PpQ2W2K//ZlyF0MMsgvgUeAEeybL9hd1b4AlIwWCkguREX+Vlk3nEbNbxNwjUqBAM/
         wSpti7i0x+U+HvYKlTgyPb0YamgUBOiY3cdBF+9hL5BN/VxkJB8422Rp5U3Y2aTEk9vf
         7AokAOql/+64XspaPtmG7grdtbkbCRL2SekCTahUgzmJuNzHRt9qynjl0OU9e6zRmeNR
         O3TvPV6p/Kf+6aPmW5MbzcsRKbRxLscvweHwEAaBU+fgLK0w6DkL89cmZ+cl0EmRM1bF
         /XFWxYb3o0DbosNgDZ6DgPYFRZHE7kPeO8kdUxLTjap1nDJJM6ymEO5W5cZqcCfgjuEY
         Tb4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVLj+O79Er97rpA3q+EoNAwB1ReDoTkZb7k+096cMY/mv/kLSFGUpnAUIuC3CQPUDGJYZNyzKKsK5l3kT+V5JPGbsosKcT/L6Y/8jij
X-Gm-Message-State: AOJu0YyoC8L1g8Vq/2BherGAqrvEY+z5kqL5lv0vepFOGnWbtWkp/dtY
	Ej5D5Z9C1fi2nZ2yLuDQF6dsIsrKw11xATuOHOQ7IiMddHdQwcICwWo87grI5dc=
X-Google-Smtp-Source: AGHT+IGJg8qH0Yu/rNhLaWzJq+ABwDfAPQCR6z70mOJdMl+dygJ2RGw2p6lzBaeuADWC2hhX4pwOJw==
X-Received: by 2002:a5d:5f91:0:b0:33d:4c06:8614 with SMTP id dr17-20020a5d5f91000000b0033d4c068614mr4455641wrb.37.1708424139333;
        Tue, 20 Feb 2024 02:15:39 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id v4-20020a5d6784000000b0033d39626c27sm8491785wru.76.2024.02.20.02.15.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 02:15:38 -0800 (PST)
Message-ID: <ec0f1536-098c-42da-993a-a98f68f4eff1@linaro.org>
Date: Tue, 20 Feb 2024 11:15:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 5/5] dt-bindings: clock:
 hisilicon,clock-reset-controller: add Hi3798MV200 SoC support
Content-Language: en-US
To: forbidden405@outlook.com, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: David Yang <mmyangfl@gmail.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240217-clk-mv200-v2-0-b782e4eb66f7@outlook.com>
 <20240217-clk-mv200-v2-5-b782e4eb66f7@outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240217-clk-mv200-v2-5-b782e4eb66f7@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/02/2024 13:52, Yang Xiwen via B4 Relay wrote:
> From: Yang Xiwen <forbidden405@outlook.com>
> 
> This SoC is similar to Hi3798CV200.
> 
> Also document the specific DLL regs and add an example for it.
> 
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
>  .../clock/hisilicon,clock-reset-generator.yaml     | 36 ++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/hisilicon,clock-reset-generator.yaml b/Documentation/devicetree/bindings/clock/hisilicon,clock-reset-generator.yaml
> index d37cd892473e..8ee844574eda 100644
> --- a/Documentation/devicetree/bindings/clock/hisilicon,clock-reset-generator.yaml
> +++ b/Documentation/devicetree/bindings/clock/hisilicon,clock-reset-generator.yaml
> @@ -44,12 +44,17 @@ properties:
>            - hisilicon,hi3519-crg
>            - hisilicon,hi3798cv200-crg
>            - hisilicon,hi3798cv200-sysctrl
> +          - hisilicon,hi3798mv200-crg
> +          - hisilicon,hi3798mv200-sysctrl
>        - const: syscon
>        - const: simple-mfd
>  
>    reg:
>      maxItems: 1
>  
> +  ranges:
> +    maxItems: 1
> +
>    '#clock-cells':
>      const: 1
>  
> @@ -87,6 +92,12 @@ properties:
>      description: |
>        Reset controller for Hi3798CV200 GMAC module
>  
> +patternProperties:
> +  '.*-dll@[0-9a-f]+':
> +    type: object
> +    description: |
> +      eMMC/SD delay-locked-loop (DLL) register subnode

NAK, now all of the syscons have the DLL node?

Best regards,
Krzysztof


