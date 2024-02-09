Return-Path: <linux-kernel+bounces-59713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4948084FAD2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBF8A2859FC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760797BB19;
	Fri,  9 Feb 2024 17:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t4e2zs4d"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315857BAF3
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 17:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707498876; cv=none; b=UhRJ4ki+Nvx01u8PGOpywftd0gZxG/TrDLdY+Yet83JNYaJJYZdPjkyF+A+sMC4xyCJB4k29kfWWMoFJSuuQcMUL7XO0SvVvL1yU0zjb4etO6kSg/OD3Xaetth9ATTBepDCXHndSiGVK6xPzz1ZVX0IGIGxuptqBUPY9XipLQ6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707498876; c=relaxed/simple;
	bh=8zaCR8O41K02r3ojsjLx+ja3Hf6OnvwNbDj913/XFkQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JH9Lz35aNYWzLZ3DOoATkmS6iht0YAks6Xqltf2zCGz2dMeQueQCIEbykBQWxyyXc5BBopWBzHhbvqjflubJ4MULp5GQNsHyq7eQYy6LDTeolGLB9lvNo2WgsPh1C2M11D8NmTGeAZHUyAO/U//Oh7LdNckUPY//WYl0F4VU4s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t4e2zs4d; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-60499a12ca0so12658427b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 09:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707498873; x=1708103673; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3WqcxEXG8TSNrlTn9gKFAz+5r+7V+KkZ4U4GAUZ3UpU=;
        b=t4e2zs4dqiCsyRyp8s89NVoCCPLNxY+EV3IX3sBj3R/cz6DdgHC7eLPnkq0PVyinYv
         wdMR9Eqm2siSUtmd03TY+k8MKoGI9yFs/jvNt4PfKxFehkLdggM96cc/1ERbX4fe7BeK
         ETgRtPta7g0wBR6mxjGT372cheeIoCW0YivjZSZKJiWkTiP5dISHqT657hPh6YNqOSpa
         tiqtdh7Zs6zEZBPoyu6IrPDGsTDO6DJmFCUaRPRcJSiXnAXJWguhXNoKDEXSXDclJMhO
         KrjfcUOGtwsr9Bn7hggsX/iztBVJhKYggg1t8hQRoRlwEfzYe3FPn5cEeHkdYI6IN2lG
         3JtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707498873; x=1708103673;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3WqcxEXG8TSNrlTn9gKFAz+5r+7V+KkZ4U4GAUZ3UpU=;
        b=Ej2BR8tUVJLKCPjzbeN+hdNl9GLKCZAH5eZ8rsu2GU9t11ws+tx1C6Mk61n6YUBjNq
         wMdodG0f2Elb8L4B6HKY9FK9HnHcRglrStkdcFUwPOPdmBDjH4/TLRDL8A4tjyHEiXbA
         is9VWreVhyKfn6Q6ppp3MMY/9cbKU7HaE+hxchIRLM/v0qXtf12vcQHuYuKon+ut3FGU
         iXI9JMbFN/NhttKWjlU6qUBorbm9NYTOxe8s/FT+q5JkdDk0paZgMriQ8+MviFRScLpa
         PL2JGHBiZGzW2S7krvuZBtRKy6GyRGjEAblSfkYFSwKqukhmMtc3OfTIvJ37rFBLuzN0
         z6xg==
X-Forwarded-Encrypted: i=1; AJvYcCVjiToqqPsLNzbzOi1/dUZpPLfalQ02LgKFlhi4Zfgg1VlRz3rBByEpUI4tmw1u/5MD53Q5y65+tW9xgohXjWBIsL+zrybB5F2cO0nR
X-Gm-Message-State: AOJu0Yxw8r8Rj89YlhGNo4Q71NqHwDMftDbrWB8rC0P0QG3u4kLJhYFi
	En5auvS7jvmdlkDWUAwWpcw7XmgAxFo2lEN0oBwqBN7ZcIwlnBR8QSPiK9NRZnhoy7k3hxHyS3X
	Xu5dyo5vui+AgTETARXEcLdsDL4jZPmYsjGMneA==
X-Google-Smtp-Source: AGHT+IG9zOiYIYM/FYll97ufxp+MZpdExZ7lLXkZ0kzyNUppWY10G7rrXWC7YcsMeVL5SCwYkcal4Ne4S4nySZh2/9o=
X-Received: by 2002:a81:9204:0:b0:604:1693:80df with SMTP id
 j4-20020a819204000000b00604169380dfmr2372634ywg.10.1707498872897; Fri, 09 Feb
 2024 09:14:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209-qcm6490-gcc-protected-clocks-v1-1-bd3487b2e7b1@quicinc.com>
 <CZ0P9E67Q6AQ.TU3Q2Y8VTWUK@fairphone.com>
In-Reply-To: <CZ0P9E67Q6AQ.TU3Q2Y8VTWUK@fairphone.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 9 Feb 2024 19:14:21 +0200
Message-ID: <CAA8EJpqkPKYX51-DAkc7A8Kpzmnk82HhFs78TkCxzo6dfubHFA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: qcs6490-rb3gen2: Declare GCC clocks protected
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Bjorn Andersson <quic_bjorande@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Taniya Das <quic_tdas@quicinc.com>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Feb 2024 at 18:47, Luca Weiss <luca.weiss@fairphone.com> wrote:
>
> On Fri Feb 9, 2024 at 5:21 PM CET, Bjorn Andersson wrote:
> > The SC7180 GCC binding describes clocks which, due to the difference in
>
> SC7180 -> SC7280?
>
> With that fixed:
>
> Reviewed-by: Luca Weiss <luca.weiss@fairphone.com>
>
> > security model, are not accessible on the RB3gen2 - in the same way seen
> > on QCM6490.
> >
> > Mark these clocks as protected, to allow the board to boot.
>
> So the board never was able to boot before this patch?

Seems so, we had a similar patch in the meta-qcom repo for those
boards: https://github.com/Linaro/meta-qcom/blob/master/recipes-kernel/linux/linux-yocto/qcm6490-dtsi/0001-PENDING-arm64-dts-qcm6490-Update-the-protected-clock.patch

>
> >
> > Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> > ---
> > I did notice Taniya's patch [1] after writing this patch. I'd prefer to
> > merge this minimal set asap, to make the board boot, unless there's a
> > strong argument for including those other clocks in the protected list.
> >
> > [1] https://lore.kernel.org/linux-arm-msm/20240208062836.19767-6-quic_tdas@quicinc.com/
> > ---
> >  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> > index 8bb7d13d85f6..97b1586f9f19 100644
> > --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> > +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> > @@ -413,6 +413,24 @@ vreg_bob_3p296: bob {
> >       };
> >  };
> >
> > +&gcc {
> > +     protected-clocks = <GCC_CFG_NOC_LPASS_CLK>,
> > +                        <GCC_EDP_CLKREF_EN>,
> > +                        <GCC_MSS_CFG_AHB_CLK>,
> > +                        <GCC_MSS_GPLL0_MAIN_DIV_CLK_SRC>,
> > +                        <GCC_MSS_OFFLINE_AXI_CLK>,
> > +                        <GCC_MSS_Q6SS_BOOT_CLK_SRC>,
> > +                        <GCC_MSS_Q6_MEMNOC_AXI_CLK>,
> > +                        <GCC_MSS_SNOC_AXI_CLK>,
> > +                        <GCC_QSPI_CNOC_PERIPH_AHB_CLK>,
> > +                        <GCC_QSPI_CORE_CLK>,
> > +                        <GCC_QSPI_CORE_CLK_SRC>,
> > +                        <GCC_SEC_CTRL_CLK_SRC>,
> > +                        <GCC_WPSS_AHB_BDG_MST_CLK>,
> > +                        <GCC_WPSS_AHB_CLK>,
> > +                        <GCC_WPSS_RSCP_CLK>;
> > +};
> > +
> >  &qupv3_id_0 {
> >       status = "okay";
> >  };
> >
> > ---
> > base-commit: b1d3a0e70c3881d2f8cf6692ccf7c2a4fb2d030d
> > change-id: 20240209-qcm6490-gcc-protected-clocks-ee5fafdb76b3
> >
> > Best regards,
>


-- 
With best wishes
Dmitry

