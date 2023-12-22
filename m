Return-Path: <linux-kernel+bounces-9411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0227481C525
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 07:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 032CB1C2480A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 06:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B00129A2;
	Fri, 22 Dec 2023 06:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="loxT0zeP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD93B20FB
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 06:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dbd4a10735eso1518240276.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 22:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703226715; x=1703831515; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vCM/h4yYLpqYLQHgVTJ6ZW6j4tyIyXT15IwAZIQWc30=;
        b=loxT0zePEqx4ohyr82lOWFREUge4iYi39hPYgoWyffbqkKCSBO8E72u5zzCQhw3A7O
         jBgn+fRYuA0tf2cxP5u/dRpR0LRbFo7tKijvklUGze/hYjB4qPXzWccDM1Cb/688OhUZ
         dAdEDqAN7gKf9UjgOln5j5Hd0bUZP/V5yGIFkg8iZh94ZcFBrBEhrIeVQJdLeFj9PnTW
         lWmrbUFBZddO9qYjIKVLOFOr0zvlreQofjt+sIZb769G8ek+DW4455oBkyrrD+rbqiXE
         WuXh2XSpg5v8XMnQ3UAi1SMLqDamMZvVSxqkSOlLdBxcI1kE4H0qH1dsVIBLgmpso8t8
         HK7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703226715; x=1703831515;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vCM/h4yYLpqYLQHgVTJ6ZW6j4tyIyXT15IwAZIQWc30=;
        b=U5PHi1NQbMYJmYy0lSe2Pdb3WqBylaF4nw91P/TFyoj92JufQjmblPeZJ/WRc7B66m
         ydD17DO+fzRLePOURvFTJtxdz9ESt0LvsQHIlxYlwnlaWizumHEhj3IdAIpNH3nVBDPE
         Ahh7FQFJtevUSB92Ryl2B3Bo8HVvF1VAB6+VL8Ya5a2EvKazAqNQA7Oh8mawi7kumaYm
         P+188KjS7/QFsRsZ7cpAdhLFy42O7f1NeIs5B1YJp3MA4RCtmSHGJQ4NzuM5DMJ+0gQe
         xW80J7yF44jxRDLCDq0j0f6uZLmPWjqSBZU+zEYW+BidCZY8kuYaiOQNH1JfVjFkidZb
         Tirg==
X-Gm-Message-State: AOJu0Ywx4VtvdTJWtu/43xxnDPepS4NHfqlezPh8lK/I7sj6jWH8YyGi
	NJzZrLrm72S2W3EHCHSIleMmC/6L+Buq02FhnhsYdKKwb7HS1g==
X-Google-Smtp-Source: AGHT+IHWuCHREWIfwkcn+VELqW2vW8cFEReTiA2Ka8sG+C0iAo/h4D1Bm+ZdcD+w9WKZAgevrzb3L60bmxd8fcpm3mA=
X-Received: by 2002:a25:ae47:0:b0:dbc:ef63:5e1c with SMTP id
 g7-20020a25ae47000000b00dbcef635e1cmr712464ybe.18.1703226714680; Thu, 21 Dec
 2023 22:31:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220-sa8295p-gpu-v2-0-4763246b72c0@quicinc.com> <20231220-sa8295p-gpu-v2-7-4763246b72c0@quicinc.com>
In-Reply-To: <20231220-sa8295p-gpu-v2-7-4763246b72c0@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 22 Dec 2023 08:31:43 +0200
Message-ID: <CAA8EJpqswNNDUj3tJu6qTYN+g7LoG7L5gMgUQvZfb3cxZRnF+Q@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] arm64: dts: qcom: sa8295p-adp: Enable GPU
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

On Fri, 22 Dec 2023 at 06:40, Bjorn Andersson <quic_bjorande@quicinc.com> wrote:
>
> With the necessary support in place for supplying VDD_GFX from the
> MAX20411 regulator, enable the GPU clock controller, GMU, Adreno SMMU
> and the GPU on the SA8295P ADP.
>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sa8295p-adp.dts | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

