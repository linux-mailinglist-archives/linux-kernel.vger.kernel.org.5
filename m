Return-Path: <linux-kernel+bounces-7912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D47AA81AF06
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C7022873AA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 07:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C50CA49;
	Thu, 21 Dec 2023 07:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p7iXb+7g"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340BEBE4D
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 07:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-da7ea62e76cso478649276.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 23:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703142196; x=1703746996; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lPoWLPGRoJ8TAvIq3rSYSVRoLky2Dc/xP/dnXpyq+Us=;
        b=p7iXb+7gJpq7FyH+kVjU13oWnAQG8uvCwO7I2BJAmdEwKu9RBX00URJPtYOwWnNGLE
         YgaWTYBlZpk5Dq+GVISIdNPvQK3wSuiy1ot0Lv/7LuhUlPdYtNn3qF8GpRStxwBbxXXY
         3StcrA55Z2VVrIWeocN9pbWEQ720WddLBV3iSu2x/PGo1Zc9kQ25wHkd+oI7xZZ0WKBa
         P8MwxTurJBWDDFPIEHKkn47tx9b5hmu19rh7aKNxb3E7cqgaajpP1ogJgqB08IZtMcwg
         B0AeMXPueKbSUZHJ8CLI/dFtaOl4hUDuHIneBxldnlT8LvY+CPU/gk4tRIdXPW4T18JU
         7kHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703142196; x=1703746996;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lPoWLPGRoJ8TAvIq3rSYSVRoLky2Dc/xP/dnXpyq+Us=;
        b=GvFlCYRBJT4yF/zw9vlsBWsEzAtFz1YLd6OAJ0EGShPt37ADnYojjDmtmjkDOYaSjk
         Wy+/FvlZMtn2Q8iq0P/uxY8GEuokkciZThEw2WToTDuWL48o60RARbcTBWRrKHMbREVC
         aoFpxLln08bgbuV+WpO5cxZnu2VX6ZVjDuEIhS2UDj835IXnsVKp+CytAQsQCc22T2S1
         72AioonZtS1I/1heaFn+bOhucBKdBUBPHzc81tBlgxaxLiqKWslW6RkVzCTfWJ/uLozI
         A8bfQ5g2eBTjuYWWGcdlpuuurrfrO5hqb2/HRt9wnWet2ir3K8MVY/aQJaBckpn9WpJw
         6DPg==
X-Gm-Message-State: AOJu0YwNRHg9LGShVjvi1MvOKmMkdoCSv+7iVyrVeu+jrajJLLpFVtjZ
	4f9izlArINAolVh5rqoJneuq8qeChH0/7nQ8af+91g==
X-Google-Smtp-Source: AGHT+IE47ttPlc1KbdGexvuAvgW1TXDOsv8bQFFLJoQS4RKAcV1L1htOBKX1GvBebXBNn/zwxaqzOiFyJMcGHWWhFQQ=
X-Received: by 2002:a25:c510:0:b0:dbd:5bfa:9681 with SMTP id
 v16-20020a25c510000000b00dbd5bfa9681mr713526ybe.37.1703142196127; Wed, 20 Dec
 2023 23:03:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220-sa8295p-gpu-v1-0-d8cdf2257f97@quicinc.com> <20231220-sa8295p-gpu-v1-1-d8cdf2257f97@quicinc.com>
In-Reply-To: <20231220-sa8295p-gpu-v1-1-d8cdf2257f97@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 21 Dec 2023 09:03:04 +0200
Message-ID: <CAA8EJprRjRJsV5hPR6mzjgucKa8UEthJd-y573aYJH0P8QRWqw@mail.gmail.com>
Subject: Re: [PATCH 1/8] dt-bindings: clock: qcom: Allow VDD_GFX supply to GX
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

On Thu, 21 Dec 2023 at 05:51, Bjorn Andersson <quic_bjorande@quicinc.com> wrote:
>
> In some designs the SoC's VDD_GFX pads are supplied by an external
> regulator, rather than a power-domain. Allow this to be described in the
> GPU clock controller binding.
>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  Documentation/devicetree/bindings/clock/qcom,gpucc.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml b/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
> index f369fa34e00c..013ef78d2b31 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
> @@ -53,6 +53,9 @@ properties:
>    power-domains:
>      maxItems: 1
>
> +  vdd-gfx-supply:
> +    description: Regulator supply for the VDD_GFX pads
> +
>    '#clock-cells':
>      const: 1

I think it might be good to restrict this property to a particular
platform (via if:not:properties:compatible:contains
then:properties:vdd-gfx-supply:false).


-- 
With best wishes
Dmitry

