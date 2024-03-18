Return-Path: <linux-kernel+bounces-106178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7EF87EA59
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC6551C2183F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 13:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82B04AECD;
	Mon, 18 Mar 2024 13:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cZQKAkzU"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61D2487A5
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 13:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710769738; cv=none; b=FU/KoFYfErPUVYM88gRfYV/4Dz0G+zxM8fFBkMUSxj0p6rl1QmkBehT8Mb2x1bDrfow7ukUqafazm7EV2ZSpJQgo4z6AmrBifZ9pk6tVPdsKr+zntkLo0oAypFFrim0IK2CcLbb5ONab0sC5pEGthQdbIKtZE0/IONIeVUeGWJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710769738; c=relaxed/simple;
	bh=R2UaOpKnY97aWVhZ/hgFlH9poNa+7COfnT3VW02GUGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s5u250QVX/i8oOQcBL/7oJEGT98iFx7oAF7XxOpotsMdzk7M+Wa9LWoTACqeS1MX537OzaTMBLP+dqhUyVE3jWznUVTBSSDuAvhV3sEex7n0xUFD2y8wFgb7SYvONhDzPHmvkC20AU6M01zG/lDwxvfirZQotnHSmbPHeWENwTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cZQKAkzU; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so3565475276.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 06:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710769734; x=1711374534; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V3FYhI19+7mXvMPKmKsCyQbdJxb3cWwyAzFHyh7qwU8=;
        b=cZQKAkzUxWZ3DiR2+CMXuDmMSWC1MZpfCZmvrHvdd3Lz6yu4xL0TUE6I8U2qJoQuqp
         gR1C3iF8TrOC8gOKApo2HaV/oaE8gr2z/qe6U4B5A1hPrD5PoGxta9VsAwR2T8DI5wWv
         l/Y7ve+R7fE9UWq/LljsR6glDc5e6FYQNLu1WRvETPB/eE+Z533dEnsZrdDC79oHAaFj
         ascsj6lIhV5shoOLJXIAEcOjPpHQKFZskuv7QeLR0x1o/xH1BHMwqA4I2SWUD2UB4SBs
         TzAFfOB9FyAHUNV7B1xyK/7WBPHcv4g4SIXNoEIyUaxo0ZC0r+KxoxE9M0PEcK0wyvUa
         TWGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710769734; x=1711374534;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V3FYhI19+7mXvMPKmKsCyQbdJxb3cWwyAzFHyh7qwU8=;
        b=J3DU6/ZtV8UPZdS31oi8I8+Z8Leer9AQl5ruyxXnu6FxhOEM00QuI3eqX9Dnnai4tZ
         XsxbIqP0EeV26NitMB+Awt8bJmbmnRBedh03xweEgJ1iiwoWtT6+C8WiAgbcs35hWmzo
         GAzAQqfazTyr2qQfxBO11uC3yYpp1IjkZfO3BAs/8LIaemN8VKeycnwi934r5ZoRZXDQ
         B05SATcSQfNOdj40BAEFSpbGs3t/9ZgvUml1d7B14D3+gxZPlr4wwHWQ6HUNrUuMNeUi
         aFTeAdfSIst4DRes6p3QmBfqp8frqlqIUFCboAGMiVDXOlMVc47BII/ygD/YuXNGaW5o
         g1kg==
X-Forwarded-Encrypted: i=1; AJvYcCVqMeVlLV0xttY3RjT7o/qMHP3q+7eIRW227RU7OKM6CRtO6uCvJegQPD27tcYU2ZMBpC2HnhbAnaHWmjjfPqyiAv/9SIVunmGgzWZP
X-Gm-Message-State: AOJu0YxaJ946eM7sml0/KTSHpSAQWo79BXccE7lJbvvJXE/VnqHT5NQZ
	FXzYdMAH6yQb7WTC9JFWn3cp6RHPsgraEt9OBe8jGZLJiTQXs/5XZCmAtITp98zeqOAQieWjr+v
	98CsN2iaqdaPuZOimaWPg84xNkYjhGMyCxZhKEw==
X-Google-Smtp-Source: AGHT+IHIKdJh6Ea44QB/HJYggMw6MDwULWny87xsrwu5PR/MnhdaDTL0l9BRYsgBrUOoIuoSQyIdEFoMdSPlHuMn2yY=
X-Received: by 2002:a25:db08:0:b0:dc7:4460:878a with SMTP id
 g8-20020a25db08000000b00dc74460878amr8986047ybf.3.1710769734613; Mon, 18 Mar
 2024 06:48:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318-apss-ipq-pll-cleanup-v1-0-52f795429d5d@gmail.com> <20240318-apss-ipq-pll-cleanup-v1-1-52f795429d5d@gmail.com>
In-Reply-To: <20240318-apss-ipq-pll-cleanup-v1-1-52f795429d5d@gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 18 Mar 2024 15:48:43 +0200
Message-ID: <CAA8EJppE8Pt8XX-e9=b5g-4+GGbw8pEgg6Jyj--HDCmC1n5N1w@mail.gmail.com>
Subject: Re: [PATCH 1/5] clk: qcom: apss-ipq-pll: reuse Stromer reg offsets
 from 'clk_alpha_pll_regs'
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Mar 2024 at 13:20, Gabor Juhos <j4g8y7@gmail.com> wrote:
>
> The register offset array defined locally for the
> CLK_ALPHA_PLL_TYPE_STROMER_PLUS is the same as the
> entry defined for CLK_ALPHA_PLL_TYPE_STROMER in the
> 'clk_alpha_pll_regs' array.
>
> To avoid code duplication, remove the local definition
> and use the global one instead.
>
> No functional changes.
>
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---
> Depends on the following patches:
>  - "clk: qcom: apss-ipq-pll: use stromer ops for IPQ5018 to fix boot failure"
>    Link: https://lore.kernel.org/r/20240315-apss-ipq-pll-ipq5018-hang-v2-1-6fe30ada2009@gmail.com
>  - "clk: qcom: clk-alpha-pll: Stromer register cleanup"
>    Link: https://lore.kernel.org/r/20240311-alpha-pll-stromer-cleanup-v1-0-f7c0c5607cca@gmail.com
> ---
>  drivers/clk/qcom/apss-ipq-pll.c | 24 ++++++------------------
>  1 file changed, 6 insertions(+), 18 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

