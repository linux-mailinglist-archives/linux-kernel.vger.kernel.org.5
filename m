Return-Path: <linux-kernel+bounces-71518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C88E285A68A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 073361C21C53
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6F0381C8;
	Mon, 19 Feb 2024 14:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u9BZQrte"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE104376EC
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 14:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708354486; cv=none; b=G/ncwsOLaatFzpGgr0d3GxlDY2G22BiWnJyDP9v5CPM47cvzbrELLS1ePNTiwc99xs8R+OP250ydjKi+6beg0SBijz0GJErCaw5Vy0Am/Bm7AapT2qDg+zgu9dukBEVxG0A+nh8PWHGtBzcWPmrrKEfcjJlDnVA0yqKUbciaZAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708354486; c=relaxed/simple;
	bh=rIE0IP0T9iSOPWSlThQHOn9NtZrcV1Ogn8zpUtpc8js=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UnhAihCKDbtcODGCFUCcY6vnyUiMBIP41Qc/LGNG1HLUFYl4J9pMGUa2Se+on1uwVhGhu6FLGvEccygWoBdvVGiFy/UgadyOmzTTH4+09Rj6T8PeW2u7sO8x4Fe+AfK1yhFfzUluCeW0oWQw+WDSlUI3vJgAFgADKizH2YKmRzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u9BZQrte; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6084e809788so3197227b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 06:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708354484; x=1708959284; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/+Vf6X891RpEKNXrdBrteASyRB3a3/HliSNBQV8d1lo=;
        b=u9BZQrteEfrrR3r7IcyNbow5D73SHZ5BaLxnuMZdhkspfSLFm6DpB1kvbgYYabfLBD
         3Zi/MC5drv2x+vt1wBPCS3OI2yzd3axgnw5Y/PQsu6xsichkNyOYhfp1+Tdktzy8NL0a
         CrWVxzIaJwid4rXlhcWpNcR6CYU/8ptrtn2YWGZjHK9CP0xAjYXOkuEhhDNURI/LI3o8
         svEhklmqdIGDjm/DoUyzcJWyX2M4Qd8VPDePUJ23njm64YgFPQdRNtLmnXKibzXZ9R1d
         RV/6rdlN6ZlMyICoSqbEGgOFFWXxFgXQpiidlMGGCcq8OtSXXrg2bPKZMsIoKkoJgSuw
         Ocsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708354484; x=1708959284;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/+Vf6X891RpEKNXrdBrteASyRB3a3/HliSNBQV8d1lo=;
        b=ZVil8DDltNjHXofNloFEombxAB5CaIIcFXfHItfF97Ccx9642HL0LQ5SPO/8ky3wGk
         rkbhfI2wARJYR6xdLlR6bYa9uTX1Ow4991hgEozqgwLvo2NmxEAv3vkhaHUckAOSj+8Z
         /oySdOiN4cVee0mw3Dz5aMBRqVl4Eo6CLR1O8BPgA+qCeQkFm3OLewWkK6pJIZxfdlgb
         IWAW2ayLfu/E1p21EXzkyZBNyfglrKAhxOpnXtOvrTe2z2GoUYivBi/FresLZfsTfbHk
         uNGTqvvi1vbRo4jszMfruArleYOuPsBm48tYvIiDmG0ABsacAzNv3C3Eh2V94GA3dTBC
         YHlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEv9SzzKzYGIynWcaFY2XlDnO99O85Vq2s4FjZ3MyRhVT1DEkHmyRfds4X6Yytnud62mX454l+j434Y/N5HFoBQw0DC8Vv0T+aecM5
X-Gm-Message-State: AOJu0Yzv8wndf35ZyKonEaWOq8Mz7uQS9hFYUBAHFBKy4sOm+cS3oKC7
	fAROlloWbR3zfBTSfwZyZr5Xt57KBExngBGlXrR8FHJ3q0L8EDSgh9AD8d5fOWaCdoWYzYLb4da
	xMhn+u+0fRYcF3zuFRuwk3C8BqnchDE4nFLOGHQ==
X-Google-Smtp-Source: AGHT+IHg7XEOTTrtpgQqphtP3Xw9sPuPWwJbqow3gZN5qRELJzU++tbN2bRulnySBEDH7nL4PxT+8aS1knEIIJLBbCc=
X-Received: by 2002:a81:a185:0:b0:608:59a5:4ad1 with SMTP id
 y127-20020a81a185000000b0060859a54ad1mr39629ywg.22.1708354483969; Mon, 19 Feb
 2024 06:54:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219-topic-rb1_gpu-v1-0-d260fa854707@linaro.org> <20240219-topic-rb1_gpu-v1-4-d260fa854707@linaro.org>
In-Reply-To: <20240219-topic-rb1_gpu-v1-4-d260fa854707@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 19 Feb 2024 16:54:33 +0200
Message-ID: <CAA8EJpq46Wn+gWKL81_zMxyddUpJRuKHDrx=4Q2DvbwufmWHWA@mail.gmail.com>
Subject: Re: [PATCH 4/8] clk: qcom: Add QCM2290 GPU clock controller driver
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Marijn Suijten <marijn.suijten@somainline.org>, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Feb 2024 at 15:36, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> Add a driver for the GPU clock controller block found on the QCM2290 SoC.
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/clk/qcom/Kconfig         |   9 +
>  drivers/clk/qcom/Makefile        |   1 +
>  drivers/clk/qcom/gpucc-qcm2290.c | 423 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 433 insertions(+)
>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

