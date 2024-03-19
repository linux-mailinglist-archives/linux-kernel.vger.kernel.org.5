Return-Path: <linux-kernel+bounces-107431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3ED987FC6A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 016AB1C2232D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568327EF14;
	Tue, 19 Mar 2024 10:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YasTVj+t"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D632E7EF00
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 10:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710845797; cv=none; b=Ynz8qJu1zUuHGf/7q9eONOzUskQdPhaScFMi36o2IY2LSUAiYHVEYEp2pYb5gifd7EIM3qzOKYJerucSbdSNk4/KQJEvs61KAR1rJ2A+GnFMEpylgExNMQE1waifYCU5UAOWAG8pVpo7BciG8a5GDs/cJvfbWwb4JUC6a3V2mK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710845797; c=relaxed/simple;
	bh=KptxkJXC1arZeNKLVXicN5mMHTUf6wme44t1NrkRC0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MMm/VzbOf5jOBlQNsMS639hoipDV6lB6bH8HF6z3NxFQiuTQoEJfzIlIzy2MWaAbGpH6bKyhwNBEt0jb+7v70ufo0nJsjtwWUedHiDSbXZgNZ53UxD6MOJVQnnszYoyGy0JTIZF3e9D3BSKm4PvFKpwEtzyt342hYnW3E+cFzzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YasTVj+t; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-60a104601dcso56866907b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 03:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710845794; x=1711450594; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zjyRBDM4rca1Hn1dUAPckcwaeF45z8MIXNEItXXFgrI=;
        b=YasTVj+tjt0X/RQBTw3jpfqtOBOUiEuAar/1zzG/Nqs+WkQ3fnQg3DJilPy3KRr4cW
         d2/g+Jc2py4JvZcXEGS15fpNLcGrwy5b+fft4gC+fAN9mnyVzlroGVKB2POaKQhm9Y+m
         r1UXYSMmT8IR9Zg9yjfkVi7534h+Xnsk95UKl+l0SPtLGr3l+fhGR2+BoTTiw06NCMMd
         4sEpblMrEfH1JTy5YmCruKo9WIoCe2LFxRaBsCWexhw7bICp+OX4m6HFTexkdxNKps1C
         0cYWbSxuj1huS0JXlG9vJJSX81uwmCoAqP/4Lhe60uQ9CZr9z1SnhJ+N/mQ8bWrH5N2a
         42sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710845794; x=1711450594;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zjyRBDM4rca1Hn1dUAPckcwaeF45z8MIXNEItXXFgrI=;
        b=IBBQZZ5T9NgSmRJChkztbBmA0aZA8orUblTTmmirFVD7E+Ll5rsWFOF2he4TEJVPpU
         xG7VRjVJU8bm5190M78iktVcyDY4zqdEqbC/oiAPKi8WdmouWZwwp+jzaIBr6S2RYUIj
         H5jMhv5dB9oKaS2+mvLE76VQWNgQUKALbYrZc7edvGcPcoozFAuu/sdfzedlSttvX6je
         DrejBdPb28ZQTp8Ozcw3FpzA5gS+TYO21fyXXZK8QREus8vtgWgYwm6/HvqK3nQ9wIuL
         Eyx7pt1F9EkaL8Uxo6E/A7dCY89qiNyWpFW0bNYyjRR745tFB4uxw6t+JIEU3USpm3fF
         Sk/Q==
X-Forwarded-Encrypted: i=1; AJvYcCV1nUCLRgMYNkOHmx7XRDyHWlAbiS5v2Un63P8vXUqOFrlL4mAx76/OvmUqTZQxWuJNHzCQlKCXGgJb/mRl0Jn7HnSwWIl+oDn4/G71
X-Gm-Message-State: AOJu0YzDx+gmkz8MBNNd8qPF4k7lLBB5+vn5Nrcp95yLGLulF8soLmFU
	MRvJGDnO0+qh0PSEXLn1eTHgXPa0UVAW+ivWytZZbFyHZNekcvB6Q1MRCVqN0yU4wU6pxLWq8Zd
	hp4CbeaWiwLp/Vc+mcZ4OkiPSbJf67kDXNWqxUw==
X-Google-Smtp-Source: AGHT+IGLAi/wNKvsr+sWkLaHawQcUlFEisvPkSzOVYcmxJ5wQ1Tc0+84fuygPF+bFom0zO8GoP0F6i9rRzr+wibkNF8=
X-Received: by 2002:a5b:bc4:0:b0:dcb:fe58:a08b with SMTP id
 c4-20020a5b0bc4000000b00dcbfe58a08bmr12096526ybr.15.1710845793910; Tue, 19
 Mar 2024 03:56:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v1-0-926d7a4ccd80@linaro.org>
 <20240319-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v1-6-926d7a4ccd80@linaro.org>
In-Reply-To: <20240319-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v1-6-926d7a4ccd80@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 19 Mar 2024 12:56:22 +0200
Message-ID: <CAA8EJproDAz92=4=c3r+8kJbEVXesZCbrtLsr8ZJWh6axzF9TA@mail.gmail.com>
Subject: Re: [PATCH 6/7] arm64: dts: qcom: sm8550: remove pcie-1-phy-aux-clk
 and add pcie1_phy pcie1_phy_aux_clk
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Mar 2024 at 12:46, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> Remove the dummy pcie-1-phy-aux-clk clock and replace with the pcie1_phy
> provided QMP_PCIE_PHY_AUX_CLK.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8550-hdk.dts |  4 ----
>  arch/arm64/boot/dts/qcom/sm8550-mtp.dts |  4 ----
>  arch/arm64/boot/dts/qcom/sm8550-qrd.dts |  8 --------
>  arch/arm64/boot/dts/qcom/sm8550.dtsi    | 13 ++++---------
>  4 files changed, 4 insertions(+), 25 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

