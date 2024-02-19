Return-Path: <linux-kernel+bounces-71506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 893CD85A65B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 314941F210A1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF17A37141;
	Mon, 19 Feb 2024 14:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T+7XFfNH"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F01E381AF
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 14:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708354167; cv=none; b=fGtylhm4LiIXJJjxWrTMDz357qgrWpVFuyv2AR+Mya90SFuvNvgclQD7qZG2HRN9lS0HW/3XVubFEj5E0EolgI18hlwXzTiUaS9/oer1xzISM2tiVoDYI2Xy+gG9NdcdMJ/EfIk2HYE1+KRU8vwWDAl3lTH6ntu7tS2cbPcntvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708354167; c=relaxed/simple;
	bh=cXd+iZRHyG6Z54ZlDyEkvwRUedt1tgiayxTf/h55RT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mlzEILyDU6FeSngCnRK0Tc/UHe+c8dM+jrttYNoxN1gywdOt6jV1SsoCgyco2mtNN/IDUS+TyoZQV0w6UNL+ncV1mr9ov1rKMJF+xvjixl98+VU1QompIPWR+L6kL6GizCeZaEfTAnmcKmSwLO3gSyPagokvhDuRg2ofuK4oQjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T+7XFfNH; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-60837b7a8ddso10743017b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 06:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708354164; x=1708958964; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WJI1teD2wPawZOQzTgWhX+w1Ti/ZVP+Yv2CET7JvPGw=;
        b=T+7XFfNH+2GtsSPl6mG8MdV/ceKdv1OvdsBLSf+Ewyxm0AL+v8SxbPgD2v1HonArrw
         w2OFiWkRO+QS6bU6K5kOXWuNyrVBwjZuApMC0n1K6Gh441xwBe9l2uMFwcckuEqasDvI
         9/u7T2mOpWX3VY6b2X9vyhQOnma4eBCvZHUtsqfIzhT5gi1E01mbJHf55AM5WqSB2zTL
         F7UY03EiR64zzb3YFCO8sGcNhEM+1MHE4TjsPTIsbn0Cr9NVayrv0HBgCcIGpg7niw2A
         xWf6ISKI/sGbax+kBx/u+/Ni1pIvE8cNFCcA89hMKmk035tpkxJ8jJOmwMu8/BzEGMyy
         UOfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708354164; x=1708958964;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WJI1teD2wPawZOQzTgWhX+w1Ti/ZVP+Yv2CET7JvPGw=;
        b=vNhM7mhZ/j6MRS3eCWiRMiKqtbJDUygzoAdYznly6Py0Wofm+T/PtawMn9eDQCLu7n
         jvrnbilbLxvRSZodhpacDyMNG3K92DUzaWyXNaPKSwNYSw0X7L9Z0LsmkBRMy8eLJLl4
         WSB5z1nT8bYX+4ah80nfCHsgLs/GdthEPeyLTyUZyEqkfebYJ5NWvsYkmcQdiZWhkVBQ
         1OKZgI0UnokvidSSe5j6JkrIMvwLokr/A2jdC/e+6HeKB6R5esvrKTjEIpA1ACkhhZ4B
         GT1I4fwu2HYejKm9qe4Btg1ILYdk/YfZB9iJ66syqkXb6Ezhd8Y8bD+EyHYcKBT97P5c
         4ukQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAxp59H3tDhbu76ozggLB3VoF16c6m+ai4NQnjhXfy0dBxflzhjsyjBMbJrEDlqQ3SVJmkaUlmdBJoTo2zYT+u6ZS4YCarCqloxTBh
X-Gm-Message-State: AOJu0YzZcqLsEfB93j3PZtFMdmICHibAsjmxitquMsJsdLXdaG19BS6M
	oTnqZghq0ZxJV/j/T2g/aPfndzvpDJCiUWbw6kO0LyZgeS3daTkgXFP0NkgZ9MZfdgWgqDOiZb9
	bNhJkMDuVpeZVEMbf2yRdq7N6a5/ay3YNJX+xaA==
X-Google-Smtp-Source: AGHT+IHr/IUKFhapXnOD7toFxlQf0Om4NTc3bUIZPM42rFzdOhQ5udZqS0lilrwVoRYH1x47luPm3EintARWerYH8fE=
X-Received: by 2002:a81:ad1d:0:b0:604:a47e:6e52 with SMTP id
 l29-20020a81ad1d000000b00604a47e6e52mr12358877ywh.32.1708354164616; Mon, 19
 Feb 2024 06:49:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219-topic-rb1_gpu-v1-0-d260fa854707@linaro.org> <20240219-topic-rb1_gpu-v1-8-d260fa854707@linaro.org>
In-Reply-To: <20240219-topic-rb1_gpu-v1-8-d260fa854707@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 19 Feb 2024 16:49:13 +0200
Message-ID: <CAA8EJppPvXfkz=wVca8aFBhFaVUe9+OiVzcQUq7D8zPbK+T1FQ@mail.gmail.com>
Subject: Re: [PATCH 8/8] arm64: dts: qcom: qrb2210-rb1: Enable the GPU
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
> Enable the A702 GPU (also marketed as "3D accelerator by qcom [1], lol).

Is it not?

>
> [1] https://docs.qualcomm.com/bundle/publicresource/87-61720-1_REV_A_QUALCOMM_ROBOTICS_RB1_PLATFORM__QUALCOMM_QRB2210__PRODUCT_BRIEF.pdf
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

With the exception of the commit message:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  arch/arm64/boot/dts/qcom/qrb2210-rb1.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)


-- 
With best wishes
Dmitry

