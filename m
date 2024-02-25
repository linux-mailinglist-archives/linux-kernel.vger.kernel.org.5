Return-Path: <linux-kernel+bounces-80184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B199862B7A
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 17:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C855D1C20B3C
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 16:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258A4179AE;
	Sun, 25 Feb 2024 16:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MbJHa2gx"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D99717721
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 16:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708877455; cv=none; b=RGi4BmQ34jayoa0LXuHsSLhFLpNgaO5mJHQu+aLDjIxg1d5VcFFThG9VCe7Xy4jqNJPoOrAj9/yDhqKBqxhsFk2lmlwQbk8oBP68Sx51v8Hi8zWKk6M+oR0D/HQtYHqezNf/a2ZZPVWqW5UQVpvmDhzOMyxbaLUUBcDGcOKGtiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708877455; c=relaxed/simple;
	bh=luqumiOYHe0YL8m3bzkjGWav4F4qaMkUn3HD+dcfHno=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HFITnNJ1rbVnR3p+hd7HEVILZpOcXb8Uj/Xh1HVzYhLI8pX4EKAW03wZ5IwNhe3/EV4GxwnSaLOQ1OsaL2ED/q8a58ursdG8dbIR6hDGIJHtfDWHzA38GGP/0RVz5vHESqsEbmYYzamNZJayyVE55iTG+2IkEIBVZARdSkJiRho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MbJHa2gx; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d22b8801b9so41150801fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 08:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708877451; x=1709482251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/aWIzeSndpV/EM9Pw+LqSurfkwfAu0VjRDqWKktMbdI=;
        b=MbJHa2gxisi8ZiZIaBo6jR49EGveha1DPX3/tZ8DCjKX7KcV6223SlX8ipmMLqkenJ
         /WfxHPNsoUgsmSPDf7fv/Pj3O7h/ppXPYuu5BeFXsTVj0vUEq09Vi+ehU8Mu7dNBqdpt
         mx0bLmkMKgy62O4VBPss7P+El3b2ithoyP6qr7NXvUsNUh1uFWGM8bh19ZeqjyGY7Yuh
         lOw6lI1s2QrwvRSJ93NtywdxarHHusvCKeVe8wY4V/UdSbeYVLq4ZZddXJV5cFCgpfp9
         9pQaEEacBN8C1bZ2816HugbocZsucfChIGRTH+lCrmwcbie2ovHGLwM9/GuK/3FTKg+S
         +sGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708877451; x=1709482251;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/aWIzeSndpV/EM9Pw+LqSurfkwfAu0VjRDqWKktMbdI=;
        b=bKtEco5FGg+ui4n2h36qFkS+b/O2kSn08fQ9+ntCRj3kB2jsPiiQLiNkhoUcjgnCuF
         yBR0gV3VEkKCmmGKh3mJzsO1dKeesHebrnalAGZMxb6RGfzppHXwX8kTCsjy+Zdnkw7g
         o0iowxBb7yvTn05QROfB+TP7roPK/Bqj1bkhZ0xVgPu7u3wkRKAU8VS3Se8w1STG2hP1
         djz8roZDoENwXrrmaeV3WcYhuqcnOI7vN3YmpRRnSmBlcs47/VLVLGECK9cPDuqwK2xR
         k601dV4dMDLV5dN09/Y3K7PWvfqdsbDJVe0J6ZTKDm4r8llT674O1O5INeHBT+1quoiO
         wn4g==
X-Forwarded-Encrypted: i=1; AJvYcCUtr1Rsrc7DBZUZQrNgsirfdh4Uph7LHnXcfeLn/a0TyyCoVnRA9snmxH5ita6zCqQHNzIlnlNc48GH/D8IuhKMcvBiiiz8qnkunAkf
X-Gm-Message-State: AOJu0YxOjkddEBw6YOpVT8vbaW0BpPqBDeO6RwpdlW/fXRVFl8cX1n1v
	WXtfQoEgCw4Qii4bdKQW20xWSw9zpql3C/aRgt/83X9KBxY7RfGMn4oGNUV+ERk=
X-Google-Smtp-Source: AGHT+IFoEJdAQ2LRJRMkWthTKYIaeFnY9O+OOfqYWxI/j5luvbJLjWNP2gFDQ3N4JSECfTVMRbkGtg==
X-Received: by 2002:a2e:8947:0:b0:2d2:4d0b:5bbf with SMTP id b7-20020a2e8947000000b002d24d0b5bbfmr2715823ljk.22.1708877450730;
        Sun, 25 Feb 2024 08:10:50 -0800 (PST)
Received: from [127.0.1.1] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id n21-20020a2e7215000000b002d2697570fcsm579184ljc.93.2024.02.25.08.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 08:10:50 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, 
 linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240224202053.25313-2-semen.protsenko@linaro.org>
References: <20240224202053.25313-1-semen.protsenko@linaro.org>
 <20240224202053.25313-2-semen.protsenko@linaro.org>
Subject: Re: (subset) [PATCH v3 01/15] dt-bindings: clock: exynos850: Add
 CMU_CPUCLK0 and CMU_CPUCL1
Message-Id: <170887744864.215710.16887740186318953401.b4-ty@linaro.org>
Date: Sun, 25 Feb 2024 17:10:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4


On Sat, 24 Feb 2024 14:20:39 -0600, Sam Protsenko wrote:
> Document CPU clock management unit compatibles and add corresponding
> clock indices. Exynos850 has two CPU clusters (CL0 and CL1), each
> containing 4 Cortex-A55 cores. CPU PLLs are generating main CPU clocks
> for each cluster, and there are alternate ("switch") clocks that can be
> used temporarily while re-configuring the PLL for the new rate. ACLK,
> ATCLK, PCLKDBG and PERIPHCLK clocks are driving corresponding buses.
> CLK_CLUSTERx_SCLK are actual leaf CPU clocks and should be used to
> change CPU rates. Also some CoreSight clocks can be derived from
> DBG_USER (debug clock).
> 
> [...]

Applied, thanks!

[01/15] dt-bindings: clock: exynos850: Add CMU_CPUCLK0 and CMU_CPUCL1
        https://git.kernel.org/krzk/linux/c/76dedb9c0bb3cf3c6d639d043d7ecc98816053cc

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


