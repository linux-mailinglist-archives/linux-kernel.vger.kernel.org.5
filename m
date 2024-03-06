Return-Path: <linux-kernel+bounces-93401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0663872F40
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22E82B22697
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 07:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F8F5C5ED;
	Wed,  6 Mar 2024 07:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KKFO3nSk"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7040B5BAF7
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 07:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709709028; cv=none; b=hM4iQI998yWxWsUXVMi7G7TlDpFjRfr1i+RlJbqmFzIPuF7zHOdugpL1+H5PORgmZZifUl3cmU4B1Whuk+ZqYeMK/fI9+ABpw6P6US2EWr6d2QsyBxLLUyElrfg4GVD4WR9suI8Sd72IErpTivbdgezd0Ivy1UtrQjYs1gvMEdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709709028; c=relaxed/simple;
	bh=2oGH+pHCSLSGyNiEFWfxDSSylQn62idxl4CVzvAOR1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EcECYWokBgRvHlF8XE+rhJ32xmJ8S57lTcgk41PnO75+36vUEnw9sVr66N7ujFp/KAl7mXdPOlyvKlD7LxXGToHgWOxQlB8bCb14KBt7YmGSMxVpZ1AuyYcLywXoyuY/Yco5IGenjT0XPfck/AaCJGkU3FHw+yD4bfTly7kuDpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KKFO3nSk; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a3ddc13bbb3so94703466b.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 23:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709709023; x=1710313823; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+7sHPBpdrJDf2Gc17VKoGqLaSwAYgcISgsRt0u8Sj24=;
        b=KKFO3nSkY7HTsXOdoBDqe6nEyItt6IjfU3eZpF5/GeycM/TojpMK4l5XGqpN+kfRlp
         NqcKn28o9XZ40QhYSLzS0KvrrihNy/UqDQKRs9shz2PX+BGzHUT9KMJ/wHhmnI4XcUK/
         zIFS7oPNTCD8hWUDPEhHomcCmLih6qoAairjJgTtrljUbm+R5x3ZaaVDEvzgQIQTmsMF
         m9pnrESamACEReEavBhwoPPvoxQWYX7kvRdG7z7Lu8dLS9lTNcsHcT1DBJs+0G7Av0d8
         LKFYiiJ9lUAo2ngyE8UHNR6rhyClbvvBkBEL6uilXsjP5I3qpIlIsbadqX/KOCEE9QyW
         piVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709709023; x=1710313823;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+7sHPBpdrJDf2Gc17VKoGqLaSwAYgcISgsRt0u8Sj24=;
        b=D1uNmhWgG8ihc+zfYF1pnk2e05VTJitpnmnzMCdEpGaa1D5yKBldC5skIddRv9YpaL
         sK/xt+bLACAIFMpP1ikkUUX66TPhdLAKatH/XuQW6gn19CoB5sR4a6CUgYWCcHzFSWP+
         0kg61hQidTMj02fTYZwV3Sd2we6RaZOXgxZznugoe1KZojQujkL5BLNj36kh7Lf68kMz
         vseBpRLPb6iD8mlhgzDJAtOWlX+i9eXaIwmzWw8x7GDruI0WePpsjD3VtpGYgxuxCPm7
         96P1Ff9pZhNGKta2zRJr0DVRrm5+hnFvLDCg/+QDGFyCGInWFEfNWFnHcdop1Gb45Qt4
         yxgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAM7xrCacD7peg8nUKx8NtZaigaCJit9KTLh1/rmzWIbr18untdL4CV//RhhMQL9PU6braIK86ENWZXJISmx+Um87/XmszWQGRvkgT
X-Gm-Message-State: AOJu0YyWOfe/7RdHOur5UpcyyVDGm2YUu+azfoiPmi0b/sO9O5Y1ACw9
	ktR29pF4x6ilFNH1Zz3YSuFis2i+ccyiXXY4Ffk9vvG7VGvPJ4/Jr3mzsiksb9Y=
X-Google-Smtp-Source: AGHT+IE5YW6eQJl5g2nzEYPOoiZfVvqEc1aWd4ItlJscwo94R8AypB7f8YfkYCZ8yRpoQjMy5p0CpQ==
X-Received: by 2002:a17:906:4ac1:b0:a44:405b:1e17 with SMTP id u1-20020a1709064ac100b00a44405b1e17mr4501459ejt.34.1709709023068;
        Tue, 05 Mar 2024 23:10:23 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id s7-20020a170906a18700b00a44ba5557c1sm5172681ejy.131.2024.03.05.23.10.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 23:10:22 -0800 (PST)
Message-ID: <74debf9c-d83a-4e97-93c3-3a1322f1b5fe@linaro.org>
Date: Wed, 6 Mar 2024 08:10:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] dt-bindings: Add HEXIN Technologies Co., Ltd.
 vendor prefix
Content-Language: en-US
To: "JiaLong.Yang" <jialong.yang@shingroup.cn>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: shenghui.qu@shingroup.cn, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1709694173.git.jialong.yang@shingroup.cn>
 <f674ec19ce824dfc13258396931256c3d33cd207.1709694173.git.jialong.yang@shingroup.cn>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <f674ec19ce824dfc13258396931256c3d33cd207.1709694173.git.jialong.yang@shingroup.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/03/2024 07:16, JiaLong.Yang wrote:
> Update file vendor-prefixes.yaml to include hexin as a vendor prefix
> for "HEXIN Technologies Co., Ltd.".
> 
> Signed-off-by: JiaLong.Yang <jialong.yang@shingroup.cn>
> ---
> v1 --> v2: Not changes this file and give warning.
> v2 --> v3: Add this patch to fix the warning.
> 
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 1a0dc04f1db4..3a82104ac8a7 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -619,6 +619,8 @@ patternProperties:
>      description: HwaCom Systems Inc.
>    "^hxt,.*":
>      description: HXT Semiconductor
> +  "^hexin,.*":

Please fix order of entries.

Best regards,
Krzysztof


