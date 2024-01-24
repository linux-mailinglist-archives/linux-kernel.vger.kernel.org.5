Return-Path: <linux-kernel+bounces-36510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC9D83A213
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 07:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5594D1F26487
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 06:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC88FBE4;
	Wed, 24 Jan 2024 06:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NCXhHkKE"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4416CBE69
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 06:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706077959; cv=none; b=H+64ocrlbIsNB0PQqyuv0mVSYqtsXQr3a3+2tYP2fJJmvY4U4UFNWeHGKHON6WNvExZNVIrO1ZhfvLB9NaXt0JaTiwjwt5R6P7e9LTUPpd1nAd+w51pRGCX9yhqg5Zs7s8FwkDboi5Gi32PjuQyGw0eQEseJKqH611dfm2TsUR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706077959; c=relaxed/simple;
	bh=W2A6Spf2jYLp0Om551ROYCkUMUGNSA0Xbwv1wks76g8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tOuqTSteDSH/naTfCLhm17igmzIabKwbgvmR3UPiWjFHlhfqRrgPeOhP3eNuoFhzXtZjaeQqjSA7mBX4PjJzG3EN1IyONQgUv3O9EcHF4NB8InNs4Fkwgt44hH4j6DPO1UsPB8RSI3Vr8uV2jN371YkamTLk3M5c8mudSqxv9M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NCXhHkKE; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40ec715f1efso832285e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 22:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706077956; x=1706682756; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RbAT8z/Z9mzjHZAanqmmp59HdJKjGmfrVSvJnkugrds=;
        b=NCXhHkKEFGqPHJBlR6Cc0o46T3GSKaAGzg9T36Ckt5UZvf43aR8AY8X9cdMOxkuXRj
         miwSLRKmCrDkRi7O3WJ1q0Ot65PZcWKR+dMHENcFSHmSDgG0jyrRoav1kZGhNuLp5d2y
         X+JKZFqOhWQFKzYjRzAd4hqTK1iqPP3ra+rjjafGt0keyjcZ4hVGoMFnPriG3IyOEjpY
         Hrj8iA/r3wrPMmw3MuI7tBNQsi0g4mdVp40ZgU/F3woxQORO1qr5LWpyGMzDkEnstulb
         kN/Q8Ge1NN/1bcYiAUzSpHPuLk0F/6oZ08XUDECpIBZAm3fYPLZQot69UyVnensahqkj
         6cJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706077956; x=1706682756;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RbAT8z/Z9mzjHZAanqmmp59HdJKjGmfrVSvJnkugrds=;
        b=awd7WtBS0Bw6NThrOW2pND5IkXHjQzjJGsvCkWmAbGxL7X0wYhvHPM3onZ+0Vfuatx
         wDoGZtmidKfpQBIZ9DxErIidisFoM3DmeEgefxEPWogacbPIp6ljJ9JddsLhflG68M7D
         F2ds0RcduX2+oFxhU0DRrxxJWyWnaAKybuzgNRnpnAExyU5YXSjbTccOfZ9ioHpZt/1Z
         IIRVElwO7DGqy9DHRW9hGgfZvWjxZPSL9R/R//Lgv3tubbPDK/yJjzMhTnmyjVzAeG8X
         ly4ESH1TkUY9Ggrpo79jtWPJS2Upvjwh7ChNxzto7eZTvJvWoEZZZfVGRmjw7NAC0Ua7
         lurg==
X-Gm-Message-State: AOJu0YygYmTzg8JvO4t4UIN1SdPH5P/XH5YeTp0hwNJmmP7pCCJnu4+s
	7j+yhOAB8wYrlxG8Fe+pDuh5AA4fYaCRvYwh5a8KbcyCkMBq+HC9+bbt4iplYDc=
X-Google-Smtp-Source: AGHT+IF1pY971lIXL9bV04ZP9uV3BjbYP/RorxUyM06IpSBhjN85T7dfZN2WdsKvttVXPMoz0Ispiw==
X-Received: by 2002:a7b:cc93:0:b0:40e:51e:7295 with SMTP id p19-20020a7bcc93000000b0040e051e7295mr1062828wma.82.1706077956521;
        Tue, 23 Jan 2024 22:32:36 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id hg14-20020a05600c538e00b0040e5cf9a6c7sm44673594wmb.13.2024.01.23.22.32.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 22:32:36 -0800 (PST)
Message-ID: <14ab8da0-5b3d-4878-84fd-ad7b7d150eb6@linaro.org>
Date: Wed, 24 Jan 2024 06:32:34 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] dt-bindings: spi: samsung: Add Exynos850 SPI
Content-Language: en-US
To: Sam Protsenko <semen.protsenko@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Andi Shyti <andi.shyti@kernel.org>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Tomasz Figa <tomasz.figa@gmail.com>, Chanwoo Choi <cw00.choi@samsung.com>,
 linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
References: <20240120012948.8836-1-semen.protsenko@linaro.org>
 <20240120012948.8836-3-semen.protsenko@linaro.org>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20240120012948.8836-3-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/20/24 01:29, Sam Protsenko wrote:
> Document samsung,exynos850-spi compatible which will be used on
> Exynos850 SoC. Exynos850 doesn't have ioclk, so only two clocks are
> needed (bus clock and functional SPI clock).
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

As Krzysztof mentioned, I see lots of spi dt-bindings patches prefixed
with ``spi: dt-bindings:``, so probably it is better to follow that.

> ---
>  Documentation/devicetree/bindings/spi/samsung,spi.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/samsung,spi.yaml b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
> index 79da99ca0e53..f71099852653 100644
> --- a/Documentation/devicetree/bindings/spi/samsung,spi.yaml
> +++ b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
> @@ -22,6 +22,7 @@ properties:
>            - samsung,s5pv210-spi # for S5PV210 and S5PC110
>            - samsung,exynos4210-spi
>            - samsung,exynos5433-spi
> +          - samsung,exynos850-spi
>            - samsung,exynosautov9-spi
>            - tesla,fsd-spi
>        - const: samsung,exynos7-spi

