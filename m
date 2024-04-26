Return-Path: <linux-kernel+bounces-159838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DED748B3500
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EEFD28914B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCBD142E68;
	Fri, 26 Apr 2024 10:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FPfqnhJG"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E240814290A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 10:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714126197; cv=none; b=tcHfJH3sfDpCw6Bj5H9RwL5JQU6VJEPwq7YVu7SUMXarMNbYTvB9WZYAByiJwYKgcVS7pWI7yPQRNJCpsGZMVzOuydCPYgouVxdfxebXo616nMaQsJWU/77/sAGqycy21jvUSDp3bVdSEMhH1vISTpEELbZLmAymJutW2+0SVUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714126197; c=relaxed/simple;
	bh=E2spRI7PbCirbH2m7G8+Y/fvI8R84R/W4WJUamXU9pw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AUpfxqLbpp3UC/blb6RU7G4DWcVQ3AYrjU6kcGYJPfyFEgiiIr3jQhMlcMor4KqzDzH5bfLQrVBEagIjgmGVk4FIiYh+BcsGfn+Q6TXuKBzB5NGu9KIiVii3LcK0gpziWEgKaxOPSweqX/SnEcp3zSj03J2jpQkS91SdwLeueRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FPfqnhJG; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41b869326daso3372475e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 03:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714126194; x=1714730994; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E2spRI7PbCirbH2m7G8+Y/fvI8R84R/W4WJUamXU9pw=;
        b=FPfqnhJG1VTTWLVNc+0nGuVZQAuo8Oiy2X3BdjLj4M0ulNXaNFJ15Oyliik1atHOEi
         aNHO9w4IEquZDvjg0h9bJI93XXJUUGtFBsswgvdd4MNIw4ei5q3Xfr4n00O92XidC6UW
         sUxcrJKwAibddd8hCgGi7qXDRW+eepYLvxqxoRRwfjPHRUl+hkN9b9z8k/EN4+IkYPhr
         fSJ6TNvFYldJW51B+TdgrQcqwT2hLWuUMKsddaioEpu36669nSHTrGCPFG9nMlTgKap+
         DXf0TWO2dMU0bYxo993F3HyQDGGkuL/e/e1rOFu7Js4l4Rok1Nk8/CXAFYP18/Cx1wxX
         qUQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714126194; x=1714730994;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E2spRI7PbCirbH2m7G8+Y/fvI8R84R/W4WJUamXU9pw=;
        b=NCEzy2K/dzDTtOcWCgcLBn4ms1NHMRd83EqXOhqw1AORnfgVddAbTgWWXR7ZPIYk/y
         xF6BTCywjhVDCQMoWmLUnWyW8DJ6/f6IHnTODQFjL5F/pZyD8tOZ9ixC8KQ4JuG6MQmv
         u21ydF05Pc9VnaiNX6QdpBVq2KrDbOQwSROEdfJ3WYRt+u66FpVOawt6o0ODaVQ0xRdx
         8Bi1lsVponp4DfpUZLYP9Z2QKt6WYV4xNeIa28810BkmSbNMNzDrwLp5fQFln5D+/C7V
         gCRL1isIySNFicTmUSQRWWFLdkqPYTYWLwUQTqu6ul5GehsA81AX7t9dDX3KG6QAcvjS
         OgJA==
X-Forwarded-Encrypted: i=1; AJvYcCUdDOO3BN7BUKgr7jf5dQzfcyX9YIl9u8Pkp0U8ICSvEVZs9BBjB9ZCcZ62NIInPCcq2h6UsN93UA32Bs0DsqEGLPtxeT+9bjIu4+dt
X-Gm-Message-State: AOJu0Yy30E20sT/V2Wh3PY3KflgNDIcwtIhMftBOBU1XXHduQNWuoSv5
	YsRPuVkMLbludCcU9vD3iU9puP+Ht9/985+V2WJ/9oTjpd2tlqyrrURJBwQ6mZI=
X-Google-Smtp-Source: AGHT+IFRnwNNKXBZjV+Cwrmrc+VfzmRCGNSCdK4TtlDzJm1Haw409IyA6ZAy8usn71YFgNMeRsuU/Q==
X-Received: by 2002:a05:600c:470a:b0:41b:8b3b:7a3e with SMTP id v10-20020a05600c470a00b0041b8b3b7a3emr1575369wmo.22.1714126194449;
        Fri, 26 Apr 2024 03:09:54 -0700 (PDT)
Received: from [10.1.1.109] ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id m5-20020a05600c4f4500b0041a0f3d996bsm20655600wmq.47.2024.04.26.03.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 03:09:54 -0700 (PDT)
Message-ID: <a9cce8beb999c3dcab73b66efeea64c7d9f05bb9.camel@linaro.org>
Subject: Re: [PATCH v2 5/5] clk: samsung: gs101: add support for cmu_hsi2
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, Krzysztof
 Kozlowski <krzk@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, Will McVicker
	 <willmcvicker@google.com>, kernel-team@android.com, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 26 Apr 2024 11:09:52 +0100
In-Reply-To: <20240426-hsi0-gs101-v2-5-2157da8b63e3@linaro.org>
References: <20240426-hsi0-gs101-v2-0-2157da8b63e3@linaro.org>
	 <20240426-hsi0-gs101-v2-5-2157da8b63e3@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-04-26 at 11:03 +0100, Andr=C3=A9 Draszik wrote:
> From: Peter Griffin <peter.griffin@linaro.org>
>=20
> CMU_HSI2 is the clock management unit used for the hsi2 block.
> HSI stands for High Speed Interface and as such it generates
> clocks for PCIe, UFS and MMC card.
>=20
> This patch adds support for the muxes, dividers, and gates in
> cmu_hsi2.
>=20
> The following clocks are marked CLK_IS_CRITICAL as disabling
> them results in an immediate system hang.
> CLK_GOUT_HSI2_HSI2_CMU_HSI2_PCLK
> CLK_GOUT_HSI2_LHM_AXI_P_HSI2_I_CLK
>=20
> The following clocks are marked CLK_IGNORE_UNUSED as they are
> needed for UFS to be functional.
> CLK_GOUT_HSI2_SSMT_HSI2_ACLK
> CLK_GOUT_HSI2_SSMT_HSI2_PCLK
> CLK_GOUT_HSI2_LHS_ACEL_D_HSI2_I_CLK
> CLK_GOUT_HSI2_SYSMMU_HSI2_CLK_S2
> CLK_GOUT_HSI2_XIU_D_HSI2_ACLK
> CLK_GOUT_HSI2_XIU_P_HSI2_ACLK
>=20
> CLK_GOUT_HSI2_GPIO_HSI2_PCLK is marked CLK_IGNORE_UNUSED until
> the exynos pinctrl clock patches land then it can be removed.
>=20
> Some clocks in this unit have very long names. To help with this
> the clock name mangling strategy was updated to include removing
> the following sub-strings.
> - G4X2_DWC_PCIE_CTL_
> - G4X1_DWC_PCIE_CTL_
> - PCIE_SUB_CTRL_
> - INST_0_
> - LN05LPE_
> - TM_WRAPPER_
> - SF_
>=20
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> [AD: resolve merge conflicts]
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>

Reviewed-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>


