Return-Path: <linux-kernel+bounces-118595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 197C788BD05
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C89A22E490A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62081C2BE;
	Tue, 26 Mar 2024 09:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VhbUcvXP"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9723317722
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 09:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711443613; cv=none; b=rOo/yeiDKnH8WApAZYvXvnwKfoysQ5XsQwEqK6pdCTqJbq02gIpvzSqK6oZ2bcvj0/EnqjPUk8SLe/9l959DrGZGQM5w9FeKZy5/p2CMc6r9XrQrzZZd/lKM10ZyX8EuV8++PoJCz7r15T3se+7FKIsUH7QGVf6ago7B6XrXLIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711443613; c=relaxed/simple;
	bh=aeF2NGTij5If1PKU12QjxNSfCgLheAL5j7HQ6bmibUI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rlSDw92Bu40/lU/sTNG4Pe04vc+AsXpE42KPLEVaEdwKM7PxDqS5TTCNWZI3DJaVjcfGIY4NdWkzpN+eqXFJO13vBrd82drtWsDCYnZElV5YtPucuPmFpq4yHGvSMHaP3LX9pPJXCYh4LeBDKk++tviw2YV3LV9DJ/EesWvbCFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VhbUcvXP; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a4749eecff7so286147766b.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 02:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711443608; x=1712048408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F4Nl3F9buqLWWf/KucUiB+H6du4zgHC1jQU4GH+Nt64=;
        b=VhbUcvXP0S1DEmFQ3hIPaQicYrk5YT7mVSDeN/EqmiOK7pfrNhzk6o2rjLNrErTPNs
         TqR47sRnL8g/6Ftnuk+EPAGqaafus2/dT0CD+6qlw0dlHBQLuFeAfi/qRzbq2+p8zJ3d
         xrrwNo9ZzDlDNA6M9SotqRtYg8ei8m6ms6C9qTvoBUtD1i1E4jcqK0MGkUidLjc4sbGo
         jJP0sGtUOWTjxfc0QZKW7ZzmhZf/SPZSxzkgSJs7FOD0jIba3nlw6yiXZLgoeG6GqnHN
         HTphWr1FZTR4QxnEWZYv9CiasG2dkQfB0mbnIsGcvlWhuHj8QBjZifGbMCpXoXwEzQPK
         C53Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711443608; x=1712048408;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F4Nl3F9buqLWWf/KucUiB+H6du4zgHC1jQU4GH+Nt64=;
        b=Ny/unJvBWu4aMXKQx5UNuChecApSf1sFqj3dwwjF36hIW8A/hkNNtypBrPR+W90tYA
         nqBvixfSSdsCpZoW0YZF+jhI+UgqNGOpkxTtLdyYmE9EMkg0Hodhqde9V7WL64M7J/Db
         c3Gy1NjQ+GyFhWxqT9iXoRvEhCtA2/skTVN8Vu4ofzQyMZpNQnFdaKp0sW3l+OrzDb2K
         ttKt0jPjzpTfhAelz+vmsb2qwqNQ0M3g5ig8EDsD6rl9fvef0Oxd5yAGe/goA14NqEmm
         uuINnHz153VbvNe6e7IIIRFAcYfSZ1XQxH/glyQKcyRAUGxIRzNJJmQBKz4EL3s/Z5ac
         46WA==
X-Forwarded-Encrypted: i=1; AJvYcCWhT/p+Cb+DhvF1nBHlmrZEkHSzENH44ysykG09DhTUexHcWNCb9Pe+RQ/SKFcA5cG+Cxh3hBra+omxrwlU2veIPjfi6bAL51w5gkGl
X-Gm-Message-State: AOJu0YyAFC4axkqe9cddDBt+b67eHPY+kHxHI4w7L3uzKKMBj47Kg26g
	GL5jxCYTp4OJPZli4GSwwq52WilgorqjRlDfklcTLxwRVh/pkXk6S95hWZBcN5Q=
X-Google-Smtp-Source: AGHT+IGHbr/J30tOPNsBgLbO6NK9FwXqFdmdVip9nvl59imBHyDVqix+jCYmkJwMT7KQ8cMPh+dvZA==
X-Received: by 2002:a17:907:7246:b0:a4d:f7ec:65bd with SMTP id ds6-20020a170907724600b00a4df7ec65bdmr437983ejc.41.1711443607808;
        Tue, 26 Mar 2024 02:00:07 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.44])
        by smtp.gmail.com with ESMTPSA id e25-20020a170906845900b00a4673706b4dsm4010129ejy.78.2024.03.26.02.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 02:00:06 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, 
 linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240301015118.30072-1-semen.protsenko@linaro.org>
References: <20240301015118.30072-1-semen.protsenko@linaro.org>
Subject: Re: [PATCH v4 1/3] clk: samsung: Implement manual PLL control for
 ARM64 SoCs
Message-Id: <171144360581.95110.13664376466376764034.b4-ty@linaro.org>
Date: Tue, 26 Mar 2024 10:00:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Thu, 29 Feb 2024 19:51:16 -0600, Sam Protsenko wrote:
> Some ARM64 Exynos chips are capable to control PLL clocks automatically.
> For those chips, whether the PLL is controlled automatically or manually
> is chosen in PLL_CON1 register with next bits:
> 
>     [28]  ENABLE_AUTOMATIC_CLKGATING
>     [1]   MANUAL_PLL_CTRL
>     [0]   AUTO_PLL_CTRL
> 
> [...]

Applied, thanks!

[1/3] clk: samsung: Implement manual PLL control for ARM64 SoCs
      https://git.kernel.org/krzk/linux/c/7fa37084061fef80dab81bc062c6ec0fa8c26b2d
[2/3] clk: samsung: exynos850: Add CMU_CPUCL0 and CMU_CPUCL1
      https://git.kernel.org/krzk/linux/c/dedf87341ad66fa6889fedcf610b6941d2d3bcb6
[3/3] arm64: dts: exynos: Add CPU clocks for Exynos850
      https://git.kernel.org/krzk/linux/c/704094c5981287c85dfdb0bf53abdfcdcc1f8597

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


