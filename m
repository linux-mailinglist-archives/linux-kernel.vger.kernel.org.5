Return-Path: <linux-kernel+bounces-157851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1658B174E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 01:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54C3A1F22426
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 23:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7C516F28F;
	Wed, 24 Apr 2024 23:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g1dLJazu"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD8C16EBEF
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 23:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714002000; cv=none; b=VwHi1kQd5aL6Jy/Vz+cbAM2AXy0hBpNOqlph7qsWjB8IYiz+WVPHOo37V96BS6M1+9KI35X+5HMFfh44fUwVPI9Vmexfgkk+ubr9cLEYFemoy2fHCcWoMJeH4xoHamcI/z7DS3OPAivdgJb+7ge2yo9tHsrH/tPFQW6Mey6VSy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714002000; c=relaxed/simple;
	bh=S333S4sIPV+E0xMd8ucx9SmBeKuTCXKxVi0OsYUitzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DRP5E1DwcJ8JvYmBW53K7JD6gBK97fLsk8OWZvsRGaQ5OS4juO8Wl7yUsRigHCRcYPuqAt4jCUNs4GdiSaBs+PUjqJD78Rn+xM6Sok5ao9a/1jtQaXVs2Ezsz3kMqcmc5JAQtqHrMK/+ryvgpZct3utOP+afSYG9cGjiM5gXDk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g1dLJazu; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dbed179f0faso1220339276.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 16:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714001998; x=1714606798; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4lbiDAQdRMQUnTwkJFNqDelP8XC5ywPFYlZpytL71Sk=;
        b=g1dLJazu1CFtSqM0QQvvJ4p2y2NZv6pcjxhWVOlMEKcy8jKpk7uFslZJUoIgjvIP3o
         opyqK+tv/sToA5osY3JxwmSGsGImu9fn8aKys52uSiBSO1xquqsHPCmIERFY+XhIvq2T
         sbuAQgqEkX7x/PfcmAGXNjCT0rBpWAS8KpvcDSchr5HRXEyi+r3p9mkgztN4QaWP3T0t
         zI2SnUfzUBk2uQMzxVvsaH3Y4adtdHP1h99SedZyqV0MX/yVwlPM4nTZcKZJ9NRp1pwR
         D1dG+GPa98Q+5lyr8JbBOyZtwNBugoJ5aZKdFmkaA9VHkr6qxYnAyXWQomM9Gfy3MSwa
         0+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714001998; x=1714606798;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4lbiDAQdRMQUnTwkJFNqDelP8XC5ywPFYlZpytL71Sk=;
        b=syR6/K37lTmkDp4iDkmbR5+bqhzZg41Gx06dFqMX4nmvkUSQh8FrgPbfaWIOOT2vho
         eOjMgCpMLaHA8sqDPGdmG2u+pNvpzQ+B1bHQweJ2hjd958hFHO3iF8vdOEvHafDNcFBH
         a6pGNm/m+rldh/gcB+b2Hot6PrMLKgme16NmifbcuGQxOj8luc0vH0bGK5hPFoeuQamx
         PAvmSPTR6iI2ULSNcrTVdXwvQpB7h9IUnVEPmD/KVNfqnUUiAuvGKtwXW9l/GvD62mZ3
         v6Kar2KtZsY1H8SmfKI3PJ9MUVBUaeo6rXFAvZnTZujEsI0bLd/gp5DtGyeEPkH4ZkkX
         d0fw==
X-Forwarded-Encrypted: i=1; AJvYcCVVlTPgBYIauKa69diwgS9hTPaiJauP+e67+B5wzEsp8SwJL1GpgtFACymIwo8UooAXR3Xe9dwBgRmLSjOHB5/uRYR/V5bAgnVQxqhN
X-Gm-Message-State: AOJu0YzqWLlq/S+t7SehBRdcym5Net/+OCMQK0qc3fSzYyGM4dQyKR8+
	c6MLhyG8dt3K95Mn+uvGDyDQQfDdBavBSxEK3OmqmviNOsSbnEiOkhPDSh5kX0OQLVnXvhZdYar
	QofSQbEL/MkDMqffTpV4iNnyb4FVI4YakJ+Q78g==
X-Google-Smtp-Source: AGHT+IFbCEKpEBJRqFVkfoarP6YfnOgjBQGtumnt+gwnMFyhoUY0mANCP/DL9e2l0oGwk5Nf7M7RID79c6RIpYBEm9M=
X-Received: by 2002:a25:c7ca:0:b0:de5:8427:d66f with SMTP id
 w193-20020a25c7ca000000b00de58427d66fmr1166099ybe.4.1714001997820; Wed, 24
 Apr 2024 16:39:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424-ayn-odin2-initial-v1-0-e0aa05c991fd@gmail.com> <20240424-ayn-odin2-initial-v1-6-e0aa05c991fd@gmail.com>
In-Reply-To: <20240424-ayn-odin2-initial-v1-6-e0aa05c991fd@gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 25 Apr 2024 02:39:47 +0300
Message-ID: <CAA8EJppXj=DyT0hEW05mAjgzHS+H2iiJ-M=MfJPgkWfztX=V8g@mail.gmail.com>
Subject: Re: [PATCH 06/10] arm64: dts: qcom: sm8550: Add UART15
To: wuxilin123@gmail.com
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Junhao Xie <bigfoot@classfun.cn>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Tengfei Fan <quic_tengfan@quicinc.com>, 
	Molly Sophia <mollysophia379@gmail.com>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Apr 2024 at 18:30, Xilin Wu via B4 Relay
<devnull+wuxilin123.gmail.com@kernel.org> wrote:
>
> From: Xilin Wu <wuxilin123@gmail.com>
>
> Add uart15 node for UART bus present on sm8550 SoC.
>
> Signed-off-by: Molly Sophia <mollysophia379@gmail.com>
> Signed-off-by: Xilin Wu <wuxilin123@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8550.dtsi | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

