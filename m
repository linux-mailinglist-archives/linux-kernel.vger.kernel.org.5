Return-Path: <linux-kernel+bounces-41515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B8B83F330
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 03:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7628F1C2142F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 02:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9549633E8;
	Sun, 28 Jan 2024 02:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekkuEtNm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F33469E;
	Sun, 28 Jan 2024 02:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706409988; cv=none; b=MzngP4JpxmyVe2fOVMi0LcnFOfIafxcQnPfm64aDxI+H7kMVCtjdkjhYTcQwWWJv3my5HB2M9fSLMT2d3MfbpD1NLS6yeSAU1dXQgznUY7bL+plDijelAhNY+IV1r9KMDkB8gXlI49qTnXVeHleHy3Q9e7f0Tw5olGqT4P32zAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706409988; c=relaxed/simple;
	bh=XnuWDgu/gKqnvw3vLWc64kzWM3OFBScvj3GiIupgVyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJaU8rkLLLFIq34EIPH25bnSO7hTpcdQxM4IG/ZPLcYQoSNPCameBAWskepX+UBNvKHFxJmxGdF6A3NypoTQHzkOyyspc/3xUhPNAeLbDsvKVQaIzDzsEDSzllb8Y7dzUnWnsnDQVy5LfmxGU0GJHbmRbTT577WfN9MlerLP+x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekkuEtNm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17B51C433F1;
	Sun, 28 Jan 2024 02:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706409988;
	bh=XnuWDgu/gKqnvw3vLWc64kzWM3OFBScvj3GiIupgVyw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ekkuEtNm7fKAadlCzQSnsYyn2ZphjymLYQ3A7Z/Cf5OPr31oYoS2CgeTZTUHq2B/q
	 0AD6f7Kq0DUIMQU0WxCdCZK442OoW4QBwTRWrpws12R4whPQDepPJA679gXyoqpECo
	 Z0F/GOYbq7OCi9AIUzWn70UsQZgX5E09B6YbJf8S2ZC3iMsNO6g7n5xfY1OMdB9VSk
	 KrF2VfL78iJqKJMD8OInDG1tbckIqFuePCHIxfUxBsfUTWkwMVKBv351J+XepDJyit
	 tU5zlQpcVu/ptSyoSZpv0zTQI1PmJjA3rprfeuTVNB/DqBoXmtFuh6GTUk5+mu6dUi
	 tqgaPEkP4HLtw==
Date: Sat, 27 Jan 2024 20:46:25 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Devi Priya <quic_devipriy@quicinc.com>
Cc: agross@kernel.org, konrad.dybcio@linaro.org, lee@kernel.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	thierry.reding@gmail.com, baruch@tkos.co.il, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, u.kleine-koenig@pengutronix.de, 
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH 0/4] Enable pwm support for IPQ5332 & IPQ9574 SoCs
Message-ID: <okn4ejzcwxgrcuoo4u2tx4adx37mle25urh2s2dda7huqfeans@gzzra4y776v4>
References: <20231006045317.1056625-1-quic_devipriy@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006045317.1056625-1-quic_devipriy@quicinc.com>

On Fri, Oct 06, 2023 at 10:23:13AM +0530, Devi Priya wrote:
> Enable pwm support for IPQ5332 & IPQ9574 SoCs and document the
> pwm compatibles.
> While at it, use qcom,ipq6018-pwm as the fallback compatible and extend the
> simple-mfd support for ipq5332 & ipq9574 targets.
> 
> This series depends on the below series which adds support
> for the PWM driver on IPQ targets:
> https://lore.kernel.org/linux-arm-msm/20231005160550.2423075-1-quic_devipriy@quicinc.com/

I've kept this series in my inbox, hoping that you would work out the DT
bindings with the maintainers. Dropping them now, please resend the DTS
patches once the bindings are in order.

Thanks,
Bjorn

> 
> Devi Priya (4):
>   dt-bindings: pwm: Document the pwm compatible for ipq5332 & ipq9574
>   dt-bindings: mfd: qcom,tcsr: Extend simple-mfd & pwm support for IPQ
>     targets
>   arm64: dts: qcom: ipq9574: Add pwm support
>   arm64: dts: qcom: ipq5332: Add pwm support
> 
>  .../devicetree/bindings/mfd/qcom,tcsr.yaml        |  9 ++++++---
>  .../devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml |  9 ++++++++-
>  arch/arm64/boot/dts/qcom/ipq5332.dtsi             | 15 ++++++++++++++-
>  arch/arm64/boot/dts/qcom/ipq9574-rdp418.dts       | 12 ++++++++++++
>  arch/arm64/boot/dts/qcom/ipq9574.dtsi             | 15 ++++++++++++++-
>  5 files changed, 54 insertions(+), 6 deletions(-)
> 
> -- 
> 2.34.1
> 

