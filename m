Return-Path: <linux-kernel+bounces-6574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64421819A85
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19A5B1F231BA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9D68801;
	Wed, 20 Dec 2023 08:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xpg6flGd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3016D1DA30
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 08:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-67f6729a57fso3922106d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 00:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703061025; x=1703665825; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1Hp6hDzkalXVHzwngj1E6hzkyPfyrhHPSKm/09FW//U=;
        b=xpg6flGdC6L6KsRJO5OnDssAeTK3ZU4VlSq3/jHTELFuPXXQwo3d7PcJOWYeD4pgbV
         eOwoTODwiCZj7d1e850z+3XBq12Mhnw2xd+zosfPzmlUq9jXgs602VDPvoeXmKdoBFBj
         NbdJyxGl2bZJCbEUFL0lITcdXelj96bHftBs3uTJxCUByPgju7HezzVSORe6BvwQ9Njc
         ApvMAEjSS44Iw3Ml/ypywmmyvi1lYSCppMFclKB3FdXpPJRVq7vHnXCD+bZnGQLzwSMC
         BN3bBaPgEAfDQpYVe5vzKfV70qWUIMUpc7b5Ud2GvGAJfO9gO5m/EDiTuujMPws9+0pw
         Bk9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703061025; x=1703665825;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Hp6hDzkalXVHzwngj1E6hzkyPfyrhHPSKm/09FW//U=;
        b=WhWJChcUq4jcBBtXkHGQLnPA2saEr4B9VeDf1yk3y5otp+tArPZSVYxbL9AMuWdMwp
         hr0LcO8rDVeZdrpuppigTKSZjrbBH46gQzVhUG7tOh0vpeHhRJ14XHWl3dY6UK0wxGUf
         MfbaI3kVKhIrzZO/mJu9n4pCXUcBgPcp2R8NPGgCF6ZtJPR4K0khXHgfbDdg5zA5Nmpg
         KGZU9QApfnSrmxq7NRJOGHhNS4g6RGRauIK9zN0F8Bfq9KSALtCzOHu4275fqwWHd6vW
         2BFQPZUBVBWLocUSg11T3uLQ2rU6mC+huHHY0BtpmRHXn3HNJUa9A+CwwKz8Wm5u71ck
         JsSA==
X-Gm-Message-State: AOJu0YyG46f6kG1rbP+W9EElvUhsiCQ4pVsyoXJBFpPR8hhk33G6IwSH
	nF5N18qleE019ZVyP6KrbIF0
X-Google-Smtp-Source: AGHT+IFNevoZVeM1/edc6wy5TXyKSe8NyJmPi6C99OU7tYcOeZmMpqFAymznJYajCZJ9JJkwWkRivA==
X-Received: by 2002:ad4:5aac:0:b0:67f:1ba0:5be8 with SMTP id u12-20020ad45aac000000b0067f1ba05be8mr4253954qvg.55.1703061025183;
        Wed, 20 Dec 2023 00:30:25 -0800 (PST)
Received: from thinkpad ([117.217.177.154])
        by smtp.gmail.com with ESMTPSA id p12-20020ad45f4c000000b0067f19dce377sm4759432qvg.30.2023.12.20.00.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 00:30:24 -0800 (PST)
Date: Wed, 20 Dec 2023 14:00:14 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: andersson@kernel.org, vkoul@kernel.org, sboyd@kernel.org,
	mturquette@baylibre.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, quic_cang@quicinc.com
Subject: Re: [PATCH v2 14/16] arm64: dts: qcom: sc8280xp: Fix UFS PHY clocks
Message-ID: <20231220083014.GB3544@thinkpad>
References: <20231218120712.16438-1-manivannan.sadhasivam@linaro.org>
 <20231218120712.16438-15-manivannan.sadhasivam@linaro.org>
 <e905c463-6f89-4939-981a-7a360ed31669@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e905c463-6f89-4939-981a-7a360ed31669@linaro.org>

On Wed, Dec 20, 2023 at 01:35:27AM +0100, Konrad Dybcio wrote:
> On 18.12.2023 13:07, Manivannan Sadhasivam wrote:
> > QMP PHY used in SC8280XP requires 3 clocks:
> > 
> > * ref - 19.2MHz reference clock from RPMh
> > * ref_aux - Auxiliary reference clock from GCC
> > * qref - QREF clock from GCC
> > 
> > Fixes: 152d1faf1e2f ("arm64: dts: qcom: add SC8280XP platform")
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 18 ++++++++++++------
> >  1 file changed, 12 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > index cad59af7ccef..37344abbe8bf 100644
> > --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > @@ -2256,9 +2256,12 @@ ufs_mem_phy: phy@1d87000 {
> >  			compatible = "qcom,sc8280xp-qmp-ufs-phy";
> >  			reg = <0 0x01d87000 0 0x1000>;
> >  
> > -			clocks = <&gcc GCC_UFS_CARD_CLKREF_CLK>,
> > -				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
> > -			clock-names = "ref", "ref_aux";
> > +			clocks = <&rpmhcc RPMH_CXO_CLK>,
> > +				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>,
> > +				 <&gcc GCC_UFS_CARD_CLKREF_CLK>;
> GCC_UFS_REF_CLKREF_CLK

I'm not sure about this CLK. So I kept it as it is until I verify it.

- Mani

> 
> ?
> 
> Konrad

-- 
மணிவண்ணன் சதாசிவம்

