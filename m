Return-Path: <linux-kernel+bounces-7918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5967981AF28
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89FB91C21BED
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 07:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F13CD29D;
	Thu, 21 Dec 2023 07:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SOdfePte"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84497C2E3
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 07:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso272018276.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 23:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703142556; x=1703747356; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7FlHxB9ycdzSx3J7qd9DR/F+NC/7ujcGrvkDWkpFT4A=;
        b=SOdfePtevvjs4oBC3LuWIZZLJD+Otw7OovQdvaCHLIAuZazmeMtl9+Y+OwWxsMPfx2
         CSX/JWbpCeM1ZNQOK45nkrbAZI8Zb0W0yozcu2CeC4DrFZUmCOJPkPcXi0NL3kVftc/4
         QWlYgnSjibfxpETzDmZib0aGiqbes0IB3GYAFcCMUhXQr9IiVw23hSfFKtLp+OnL7ck7
         8f7yCA41bbOyflQeP1IC033Oy2JUmbvWW5hWA2w7eQB4w94Wustz/bxBfnUETppKCS6X
         iYpgIBr1EKI53fbiGiST60JSdAcvTFrgsyPLqU3jSEMn0kngr82xI+KQrWF01h+jF5EG
         i/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703142556; x=1703747356;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7FlHxB9ycdzSx3J7qd9DR/F+NC/7ujcGrvkDWkpFT4A=;
        b=iECRtF0TZ4gUqIw3ye6dsFbTCzbep/S1M65bPQ0iZcR0H7cIQDMGU1GrnXxSbyEPcG
         xtH8W51eID4xXdGNpaGsxeNjkzwYar4E0Z35Gm9dURDO1V4eeKJ7qY0YjOq26S4FR0F/
         0bnngZxdy0oS8s3MprvBbupaZSKHFKPNS1/Peo7oyFDY0oFW6hJkUh4IcOJsb24oiPJd
         v3kri+wSQ33/R5b7v0b6lyOCX7QvOFmiFlaShcERAf6CmPOzjggcACXQZiY0mQ16NHM1
         eUT2pvi8B47Rlk7rje0iUuB8JqpW9rfUymNmoxcoY4SSY9hQDzztSpDbe+xbqB0Odd+Y
         z7CQ==
X-Gm-Message-State: AOJu0YzbP9Q6jDXqTL8fa3xVj9xT+2IzvK5fG/7AMO+48qglr+jnGvHB
	Lc/MPVMslMhjr6XCMItmc9vVD6xGGeXFn+8pvpIgNw==
X-Google-Smtp-Source: AGHT+IHI6Gn2wy8/SWzwangQnRtcbelX3ONlareSqE9pUrFR2bGt1gHVhVZy5MqDQgRZzAuir+4F9MCMbVQTvd20YS8=
X-Received: by 2002:a25:d785:0:b0:da0:3d48:aa68 with SMTP id
 o127-20020a25d785000000b00da03d48aa68mr540126ybg.50.1703142556543; Wed, 20
 Dec 2023 23:09:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220-sa8295p-gpu-v1-0-d8cdf2257f97@quicinc.com> <20231220-sa8295p-gpu-v1-7-d8cdf2257f97@quicinc.com>
In-Reply-To: <20231220-sa8295p-gpu-v1-7-d8cdf2257f97@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 21 Dec 2023 09:09:05 +0200
Message-ID: <CAA8EJpqiW7Sw-=3FzVjZMh0UcYgXWQCqL5P4Bk0QqrVahJYzQA@mail.gmail.com>
Subject: Re: [PATCH 7/8] arm64: dts: qcom: sa8295p-adp: Enable GPU
To: Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Taniya Das <quic_tdas@quicinc.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Johan Hovold <johan+linaro@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Dec 2023 at 05:52, Bjorn Andersson <quic_bjorande@quicinc.com> wrote:
>
> With the necessary support in place for supplying VDD_GFX from the
> MAX20411 regulator, enable the GPU clock controller, GMU, Adreno SMMU
> and the GPU on the SA8295P ADP.
>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sa8295p-adp.dts | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> index e16406c9c19d..7775c5f4d2e8 100644
> --- a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> @@ -108,6 +108,13 @@ edp3_connector_in: endpoint {
>                         };
>                 };
>         };
> +
> +       reserved-memory {
> +               gpu_mem: gpu-mem@8bf00000 {
> +                       reg = <0 0x8bf00000 0 0x2000>;
> +                       no-map;
> +               };
> +       };
>  };
>
>  &apps_rsc {
> @@ -286,6 +293,28 @@ vdd_gfx: regulator@39 {
>         };
>  };
>
> +&gpucc {
> +       vdd-gfx-supply = <&vdd_gfx>;
> +       status = "okay";
> +};
> +
> +&gmu {
> +       status = "okay";
> +};
> +
> +&gpu {
> +       status = "okay";
> +
> +       zap-shader {
> +               memory-region = <&gpu_mem>;
> +               firmware-name = "qcom/sa8295p/a690_zap.mdt";

Can we please have .mbn here? Other than that, it looks good to me.

> +       };
> +};
> +
> +&gpu_smmu {
> +       status = "okay";
> +};
> +
>  &mdss0 {
>         status = "okay";
>  };
>
> --
> 2.25.1
>
>


-- 
With best wishes
Dmitry

