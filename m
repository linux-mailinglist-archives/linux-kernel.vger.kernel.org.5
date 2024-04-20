Return-Path: <linux-kernel+bounces-152343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 757BA8ABCA6
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 20:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D27B7281541
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 18:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DEE63BB35;
	Sat, 20 Apr 2024 18:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YcDURYgR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F389625;
	Sat, 20 Apr 2024 18:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713636822; cv=none; b=EpAvdfM19QeP/69EDm+w1pdr493Q+pGLs84mDcA4kY9Luhya0QKzDiN3mgEJe+lY66uyHpKJDNsxNYuXGaM6jSS+8GHV2ifL+YNLkxTRDdbhOJOGKWjWQKr+jGhEIz8pccFR28WEv/cJspKl25MXo1wRrlphuMCibZKFzQQ8zOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713636822; c=relaxed/simple;
	bh=LLY1ufaNAgXRjxi0qxQeE3KwJWeLbKrkAlWFeDzMeEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=boS9a5J3FMctT8fz0f9YEK4ZiX8hSQzmv9gpzyib3XYJWVXE3M17Y3p0pmYmA/vhJ3uAHEz8wnEdNgud8iL/OAbW+4MSw2GwROn93T9qzeX9sY8binMLFw2xWYNPCC0zdpZyJxBoVrUPpqF08fF6jF/cCh+SFCIsLk965pvOS68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YcDURYgR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77F65C072AA;
	Sat, 20 Apr 2024 18:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713636820;
	bh=LLY1ufaNAgXRjxi0qxQeE3KwJWeLbKrkAlWFeDzMeEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YcDURYgRbGwl2pXd4sTKLUIYHdOD3pLeZwythdxoZnP9G4f24eKBgL9r9+lZyHbcR
	 DkaitPP2GAdDMafn11I9xN7TZfeyeOusIjDrVc3TF37WDxPlbekF5buhj5HNhED7Hq
	 EsbWCBmJ6jdLO0si3kcMQ6jdDpcrzsgX+QvT4OiyQt3zNP8RmDQjcZYQfSukEkRoNC
	 xTvlP46nWwN34BdrW70XlUvSw7PXgI0XPXwIfF5hsg2P/lsmgp3DvCOivgd/Vh7PIj
	 TzV4pqS8nMM4Yo9Ey3t86Z5ec3+ycoppqmEur5BeASXNphR+S6iRtW+yiyTI8qta13
	 N2+mxC+/xRWpw==
Date: Sat, 20 Apr 2024 13:13:38 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] arm64: defconfig: qcom: enable X1E80100 sound card
Message-ID: <6sfk3n65fbq444ezbuj53litc3lizuhqbmk6mwyngja3orw4fu@ez2bqiub5235>
References: <20240403094422.15140-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403094422.15140-1-krzysztof.kozlowski@linaro.org>

On Wed, Apr 03, 2024 at 11:44:22AM +0200, Krzysztof Kozlowski wrote:
> Enable the sound machine driver for Qualcomm X1E80100 sound card, used
> on several boards with X1E80100 (e.g. X1E80100 CRD).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 

I'm completely lost on your strategy for these sound card drivers!

Why is x1e a separate driver when we're shoehorning in qc*6490 into the
sc8280xp?
Why does Srini answer me that the compatible should contain the device
name (qcom,qcs6490-rb3gen2-sndcard) while you're at the same time adding
a platform-based compatible for x1e.
 
PS. The only answer I get out of `diff -u sc8280xp.c x1e80100.c` is that
we're going to blow some speakers on X1E devices. (And is this
limitation applicable to qc?6490 devices?)



Obviously unrelated to this patch, which I will pick.

Regards,
Bjorn

> ---
> 
> The driver and bindings were posted here:
> https://lore.kernel.org/alsa-devel/20231204100116.211898-1-krzysztof.kozlowski@linaro.org/T/#t
> 
> Resending because I did not Cc Bjorn/Konrad/MSM.
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 94e677800899..4df6a724349f 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -956,6 +956,7 @@ CONFIG_SND_SOC_SM8250=m
>  CONFIG_SND_SOC_SC8280XP=m
>  CONFIG_SND_SOC_SC7180=m
>  CONFIG_SND_SOC_SC7280=m
> +CONFIG_SND_SOC_X1E80100=m
>  CONFIG_SND_SOC_ROCKCHIP=m
>  CONFIG_SND_SOC_ROCKCHIP_I2S_TDM=m
>  CONFIG_SND_SOC_ROCKCHIP_SPDIF=m
> -- 
> 2.34.1
> 

