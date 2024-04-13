Return-Path: <linux-kernel+bounces-143607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 588368A3B61
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 09:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1679D285A42
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 07:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A811CD2F;
	Sat, 13 Apr 2024 07:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l8yenHvb"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2542417C6D
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 07:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712992189; cv=none; b=Wv6CU/AlqRWIYgPqSBVpzJpp/DEMMbW6Txc0OmivWdKTMO47C5vLOoY2OZiGocH9egG9hyv1NVETtmiA4xUoXz/zYqNnr62h7lC8vDmc06jlaF8tH9fDYJ27e+fSjJkrG/MhkaV6X+/t5BVsMT483fcZQzcVNqRtUZ0gH81lIOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712992189; c=relaxed/simple;
	bh=31TPNy+mcj7oxA1P6tKn0QIVaMJ40e7wFclNoiCV3u0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SjYFd69iu3U/8lgh3YepGUUMqaPdOuqbU+nAjOi3S0KYnVRHSk2OxenLUgtZdRRsrWrFrMnDu5krSjwMFlQahlgobdsWLOgR3PvIp4fOSSJLkwlTwMAv/O2i4Q74N4xBcmtPedorCBCrlwV4i7aczknfhtejhMfn3DvpeRFNfVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l8yenHvb; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dd02fb9a31cso1474360276.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 00:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712992185; x=1713596985; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NTeaQI+AbWOvMhpNjK5DyNPGOXCM20rO0Ym7AMK4y8I=;
        b=l8yenHvbGDLh+wI8Y8VyPMn3+0DkVemoPUi9sRzSNuAo4SlFbc4u5QfBvPT0SgEeT9
         PgFANCKZvVRGg73P2BbA05bMuLcYpWIVIB7Kj5R70elLOvaZ0ZVkaUkaORVX6gTrXisD
         eWcsISow/I3ITYNURS0SKY7Lm3yZS78VcJxPM8GikcLFskWAIEGXZZ+1fiaJuUXuneJ0
         blYvrrXZcyNZf+L92MLRwt/i2v2w9nDpsjMP5npy4dSpmKYbExZqamaLd7TsnmOVger8
         IADU+Or9TOwNNuYdJTI+vE1OJy3HRSbRkrJQD+uKOwqVK6riH167Wd1iE+QnYuFc9hDU
         xPew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712992185; x=1713596985;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NTeaQI+AbWOvMhpNjK5DyNPGOXCM20rO0Ym7AMK4y8I=;
        b=nZsyj/1LFGePNCAbnaaJlmTaiEZSs1GEqt9Fs0/PvUTxpAdpm+w/nLtOn6cs2R4tiE
         Y1CnMaiXuF6p4OYuvBtRKCiE7IB0/4F04OM2U/9zsKVbkDE0ZdRwTzBCzIlzw9pjDnBN
         AiIVuvB0SpzEW7yg5TtxEDqXRzJJQ1Ff9C3K6IL1KXqSCz9r/RpQgmfBTnEqqD9EFc6Q
         5AB75ZA+vJstibxEu4CcXo0nIgKR/mmMtjn1NFVkJ/Rxf/SWYj1rkfHu+/dBwvNdYJ+f
         iAiQHs2cW8oPkWhq22asS1fE6LzZ5ckyUVqqXZKSQGBGInT0rkRne+rc+yBMMqsPxajl
         DAbg==
X-Forwarded-Encrypted: i=1; AJvYcCV/FL1pw3yMDhU1Esa7jFHtwkwyNkSbExnos3MYklH7nOadlvVI82cVtxlYFj5wfGd3rxLOFsZ+VvaLoPKsFcDC9KoDSu+pMC8YdZ48
X-Gm-Message-State: AOJu0Ywj9VFCVtUKBa3cEL9ewuB8ONwXEII6k2252IGlLeUkN42tdXFQ
	LcSKOgi30nh5vaLkWLqvNSnOaIpmKgqwyp7M8DtYDg3nyW05Ytf/L0ESgCsnXuwMFftxSsxsyOf
	1vbvlr5N+NdQfekTfD+0tYNUb9DOPk2aDMIvkpw==
X-Google-Smtp-Source: AGHT+IGR3uOxfxvP+4H+JPxbSUh8CTrL3KHgDDxzmKk1XMdxnKdjOcYpmVZJQrPVbWLzF8Jn7f7zAYxjd8Hq1jMig34=
X-Received: by 2002:a25:2610:0:b0:ddd:6964:40c with SMTP id
 m16-20020a252610000000b00ddd6964040cmr4772224ybm.50.1712992185082; Sat, 13
 Apr 2024 00:09:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412222942.3874269-1-robh@kernel.org>
In-Reply-To: <20240412222942.3874269-1-robh@kernel.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 13 Apr 2024 10:09:33 +0300
Message-ID: <CAA8EJpqbCOPZfFtMtjy5Sz7R=oR2=5xv9vt8Har3ThLRpot5Xw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: Split PMU nodes for heterogeneous CPUs
To: Rob Herring <robh@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 13 Apr 2024 at 01:30, Rob Herring <robh@kernel.org> wrote:
>
> Arm heterogeneous configurations should have separate PMU nodes for each
> CPU uarch as the uarch specific events can be different. The
> "arm,armv8-pmuv3" compatible is also intended for s/w models rather than
> specific uarch implementations.
>
> All the kryo CPUs are missing PMU compatibles, so they can't be fixed.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8956.dtsi |  4 ++--
>  arch/arm64/boot/dts/qcom/msm8976.dtsi | 10 ++++++++++
>  arch/arm64/boot/dts/qcom/sm4450.dtsi  | 11 ++++++++---
>  arch/arm64/boot/dts/qcom/sm8350.dtsi  | 14 ++++++++++++--
>  arch/arm64/boot/dts/qcom/sm8550.dtsi  | 19 +++++++++++++++++--
>  arch/arm64/boot/dts/qcom/sm8650.dtsi  | 14 ++++++++++++--
>  6 files changed, 61 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/msm8956.dtsi b/arch/arm64/boot/dts/qcom/msm8956.dtsi
> index 668e05185c21..fa36b62156bb 100644
> --- a/arch/arm64/boot/dts/qcom/msm8956.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8956.dtsi
> @@ -8,8 +8,8 @@
>
>  #include "msm8976.dtsi"
>
> -&pmu {
> -       interrupts = <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_HIGH)>;
> +&pmu_a72 {
> +       interrupts = <GIC_PPI 7 (GIC_CPU_MASK_RAW(0x30) | IRQ_TYPE_LEVEL_HIGH)>;
>  };
>
>  &tsens {
> diff --git a/arch/arm64/boot/dts/qcom/msm8976.dtsi b/arch/arm64/boot/dts/qcom/msm8976.dtsi
> index d2bb1ada361a..1ad102b1633c 100644
> --- a/arch/arm64/boot/dts/qcom/msm8976.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8976.dtsi
> @@ -226,6 +226,16 @@ pmu: pmu {
>                 compatible = "arm,armv8-pmuv3";
>                 interrupts = <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>;

I think these two lines were supposed to be dropped.

>         };
> +       pmu-a53 {
> +               compatible = "arm,cortex-a53-pmu";
> +               interrupts = <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
> +       };
> +
> +       pmu_a72: pmu-a72 {
> +               compatible = "arm,cortex-a72-pmu";
> +               interrupts = <GIC_PPI 7 (GIC_CPU_MASK_RAW(0xf0) | IRQ_TYPE_LEVEL_HIGH)>;
> +       };
> +
>
>         psci {
>                 compatible = "arm,psci-1.0";
> diff --git a/arch/arm64/boot/dts/qcom/sm4450.dtsi b/arch/arm64/boot/dts/qcom/sm4450.dtsi
> index 603c962661cc..411eb7577407 100644
> --- a/arch/arm64/boot/dts/qcom/sm4450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm4450.dtsi
> @@ -268,9 +268,14 @@ memory@a0000000 {
>                 reg = <0x0 0xa0000000 0x0 0x0>;
>         };
>
> -       pmu {
> -               compatible = "arm,armv8-pmuv3";
> -               interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
> +       pmu-a55 {
> +               compatible = "arm,cortex-a55-pmu";
> +               interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
> +       };
> +
> +       pmu-a78 {
> +               compatible = "arm,cortex-a78-pmu";
> +               interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
>         };
>
>         psci {
> diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> index a5e7dbbd8c6c..127fa9a935da 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> @@ -300,8 +300,18 @@ memory@80000000 {
>                 reg = <0x0 0x80000000 0x0 0x0>;
>         };
>
> -       pmu {
> -               compatible = "arm,armv8-pmuv3";
> +       pmu-a55 {
> +               compatible = "arm,cortex-a55-pmu";
> +               interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
> +       };
> +
> +       pmu-a78 {
> +               compatible = "arm,cortex-a78-pmu";
> +               interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
> +       };
> +
> +       pmu-x1 {
> +               compatible = "arm,cortex-x1-pmu";
>                 interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
>         };
>
> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> index 3904348075f6..8e7d0ac17a12 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> @@ -357,8 +357,23 @@ memory@a0000000 {
>                 reg = <0 0xa0000000 0 0>;
>         };
>
> -       pmu {
> -               compatible = "arm,armv8-pmuv3";
> +       pmu-a510 {
> +               compatible = "arm,cortex-a510-pmu";
> +               interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
> +       };
> +
> +       pmu-a710 {
> +               compatible = "arm,cortex-a710-pmu";
> +               interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
> +       };
> +
> +       pmu-a720 {
> +               compatible = "arm,cortex-a720-pmu";
> +               interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
> +       };
> +
> +       pmu-x3 {
> +               compatible = "arm,cortex-x3-pmu";
>                 interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
>         };
>
> diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> index ba72d8f38420..90102a41489d 100644
> --- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> @@ -394,8 +394,18 @@ memory@a0000000 {
>                 reg = <0 0xa0000000 0 0>;
>         };
>
> -       pmu {
> -               compatible = "arm,armv8-pmuv3";
> +       pmu-a520 {
> +               compatible = "arm,cortex-a520-pmu";
> +               interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
> +       };
> +
> +       pmu-a720 {
> +               compatible = "arm,cortex-a720-pmu";
> +               interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
> +       };
> +
> +       pmu-x4 {
> +               compatible = "arm,cortex-x4-pmu";
>                 interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
>         };
>
> --
> 2.43.0
>
>


-- 
With best wishes
Dmitry

