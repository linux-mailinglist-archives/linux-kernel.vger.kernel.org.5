Return-Path: <linux-kernel+bounces-44189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B43841E8D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 224061C24F0D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9EC58210;
	Tue, 30 Jan 2024 09:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TiXxLxYk"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374DC58205
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 09:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706605220; cv=none; b=DeqR2aGM+9DnLEIrPFrJJiY1fohaB2hcbzZVLAOfsYYVcPuNhC7CV4NWIPI0JMwiPdpT/f41wUx9pU9oDz0w+b86o8Af16EVp73MV6mcS24fsDBPuig4sRdBVaoRt/RMT6KK4CNX4RmzyOJ9Doka6zL1wFV+Z3eF3SuwJ+K893c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706605220; c=relaxed/simple;
	bh=TchTJhuSnN3V+faXCv1nvr5qgtMhSTqDaiAafcwJDhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=du9eM5KwZCexJSrH1QqPoxeo8/sPmyEM0GFpAxQWRMs3rJ1p8epwnxvoz74h0ihWgNfqMJUplLAtpidqNEgHW4Kgz6nLsa1sCaOPc3yJ6DCdUqNJ49ELA4bk+vnoGEa+yg5sSTy3Niv4ksgJ65pduleZoOirSyF6rZrVgEk0Muw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TiXxLxYk; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55ef011e934so2704094a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 01:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706605217; x=1707210017; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KhL/RwrrrFuTkcUoehGkisCUcv3sHGalEb7hpgS14ag=;
        b=TiXxLxYkv+wJ56ZJwGfudT2zlmAAyZPArI8inwVFZsVyhC2/8LN4bYJRh7bG8FhdBV
         8JA2s+nLvyfqiPkA4D7j0TebZ0/3dTftX8MKeZEG6L2LIyVU67qq5gTlCup3NHQg53Sd
         eEmvLGtsYajymGbkzgqBuZwLBW3P2BVjHxn1fIpey2F84Izixuj50AvufN8AlqmYt9n2
         LUhII0VrVObXeRlWSR92/kh0DA0s1+0evWiMoOQMkNtxt723Xc7k8KJ87nD9DWUVS/47
         xNuQ7pYU9hJRYCdPS+To/IRyf/4pMywpeiLYbbVWsd2Q85TWn9Q7PBMI/1udtY819J65
         4lbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706605217; x=1707210017;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KhL/RwrrrFuTkcUoehGkisCUcv3sHGalEb7hpgS14ag=;
        b=NEjVYwctkh8YnyiQ8NJAHjWyF49uXB1+PFNfUu76ey+4dNREfP2xoVMh4IiTJ+esh0
         QJSRoR7a8xh2SOQpDnc8bufC9HzC3zsh7izM0XylJMDEFAoTafgOx7CG66VYmRdTuHva
         479ke6Kw2JP36s2EgM1d/jrQjijP1AQhCbv96elC/FnDJohkWHhMEfoaUOMcL4QElqws
         pzacX0fQRMVud0wrK7G0qGhfliQLZByc2sKrt67L8KYTTG/22fiGWPjSpei6J+ARrSKN
         sEUYkLDAgBSsUbuhhbrNF/qKsgqYdIS+SABoDZZ00IZHEbigyaGUgvqfKaT7uxN3lJSd
         EKIg==
X-Gm-Message-State: AOJu0YzpDirZ31VQSGyUFLrUdQ8q3xiYt6fdBq45MLRXzYxqRKHlpKGW
	jjKtLDYkEi8RVlTNPi3gJrZp8phXeUm46BYDJqz2d9X1jbfGYWa6k16NEeaeNLY=
X-Google-Smtp-Source: AGHT+IH8GLcfn7u5cLqn55BcZiPw3cv5ghUJUsIBz378REWJfPZ7UgY70S+5auyNl4/KqBplWNJkBA==
X-Received: by 2002:a05:6402:3594:b0:55d:2ecf:eb1b with SMTP id y20-20020a056402359400b0055d2ecfeb1bmr6230846edc.1.1706605217393;
        Tue, 30 Jan 2024 01:00:17 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id f19-20020a056402195300b0055e96290001sm3700180edz.27.2024.01.30.01.00.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 01:00:16 -0800 (PST)
Message-ID: <e434e7da-24ac-4f24-82f4-2ca52b2b5111@linaro.org>
Date: Tue, 30 Jan 2024 09:00:15 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/7] dt-bindings: samsung: exynos-sysreg: gs101-peric1
 requires a clock
Content-Language: en-US
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 peter.griffin@linaro.org, mturquette@baylibre.com, sboyd@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
 willmcvicker@google.com, semen.protsenko@linaro.org,
 alim.akhtar@samsung.com, s.nawrocki@samsung.com, tomasz.figa@gmail.com,
 cw00.choi@samsung.com, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240129174703.1175426-1-andre.draszik@linaro.org>
 <20240129174703.1175426-5-andre.draszik@linaro.org>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20240129174703.1175426-5-andre.draszik@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/29/24 17:46, André Draszik wrote:
> Otherwise it won't be accessible.
> 
> Signed-off-by: André Draszik <andre.draszik@linaro.org>
> Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
> Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
> 
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
> v2: collect Reviewed-by: tags
> ---
>  .../devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml   | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
> index 33d837ae4f45..c0c6ce8fc786 100644
> --- a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
> +++ b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
> @@ -73,6 +73,7 @@ allOf:
>            contains:
>              enum:
>                - google,gs101-peric0-sysreg
> +              - google,gs101-peric1-sysreg
>                - samsung,exynos850-cmgp-sysreg
>                - samsung,exynos850-peri-sysreg
>                - samsung,exynos850-sysreg

