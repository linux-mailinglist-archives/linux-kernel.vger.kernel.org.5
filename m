Return-Path: <linux-kernel+bounces-23836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 959E582B289
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8C961C236ED
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7944F895;
	Thu, 11 Jan 2024 16:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zBp6Cmbf"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE794F5F8
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 16:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5f2d4aaa2fdso57310927b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 08:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704989603; x=1705594403; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B+Daz6PrvuXzuQhtp46Wp2CVwOFNa1LWR+N0jiqf7Gs=;
        b=zBp6Cmbf8MjmKcCprXH6T3VGG8amWI2Kc8/CyzykD+OOi0MzMdIvvv1nBpld5jqAhn
         CgWGN0npAFVryN5PGq+1lkLC/in8dSj8KELxtkRTJ5VZrfzCF9nWhFJ6mOifKOiVRhHq
         udpcjkmIoXo+J6iQyIgoQjfNh3b+gwbbvSAhOSaUgu63rcO29i2BbMG6D16T6wVd3xUP
         wgiHtAkfPBL5u5ngMkSLmj9c9ZaMzDFkIzqPfAQJWUvg/cGKW7M8UqjBarHm2uCOWclv
         0+z1WNWg0c98dfrpWhA/gq7Eyysm0gacVIcDGSAqB4L/785zEtjysZLXbeajFYTS0ITZ
         NvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704989603; x=1705594403;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B+Daz6PrvuXzuQhtp46Wp2CVwOFNa1LWR+N0jiqf7Gs=;
        b=Skluhr4GbUB4daxxIx8pcrVkFkcPSL2pC7KubW8xT+FXBZ1WDhsQ6XXkMA/W6i+64h
         SndiafY1hLsKVvlkLqPc23GsTnie0ReYtcFRuMfpn8DPVdTwkhf+Zjk9TPBVzwMU54m1
         et+qb+btDqU7BXD/jvUnGa/YD3mJiG93+y10GbC3b43HFrs1+4BYvZnAYyifnh4WmaBi
         6giS4oO3qBqVLDNi9TUV/5G7Qc8vZuoXW7WwHVW3Eh2RFcC6K8nPtADG0cJ0jvQpzVyY
         u1kC8xyQY2RSfZjJXXpJFcHFNfEsBTy/ijJnxtfdjLkTUrSwOJWwP4p0mGrxdkP/HKCY
         LBrQ==
X-Gm-Message-State: AOJu0YxS20wJ4duk/x8ZldliGLbdHlOQu3NcFlZ7VxZCq7elBjvAyikY
	v3HrwD0WopVV6G+wYG11Vp7uUiO8x7KPwwRS1THVlsBPS+a+NQ==
X-Google-Smtp-Source: AGHT+IFkymLkY8xSSCpUL+R1merpxL9ejSGb+RAwdZr892fFss/9KZidkd/S5FUeLMNl7Pznqnr21BDhsMcq4JZ6ka0=
X-Received: by 2002:a0d:cb94:0:b0:5e8:82f:c708 with SMTP id
 n142-20020a0dcb94000000b005e8082fc708mr15305ywd.56.1704989601413; Thu, 11 Jan
 2024 08:13:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110112059.2498-1-quic_luoj@quicinc.com> <20240110112059.2498-4-quic_luoj@quicinc.com>
 <4bc0aff5-8a1c-44a6-89d8-460961a61310@lunn.ch> <e893c298-fbfa-4ae4-9b76-72a5030a5530@quicinc.com>
In-Reply-To: <e893c298-fbfa-4ae4-9b76-72a5030a5530@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 11 Jan 2024 18:13:10 +0200
Message-ID: <CAA8EJppB4cDGv1BEfeacPpi37Ut+PLgWvCDeOSj4DU4Q5uC-1g@mail.gmail.com>
Subject: Re: [PATCH 3/6] arm64: dts: qcom: ipq5332: Add MDIO device tree
To: Jie Luo <quic_luoj@quicinc.com>
Cc: Andrew Lunn <andrew@lunn.ch>, andersson@kernel.org, konrad.dybcio@linaro.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	quic_kkumarcs@quicinc.com, quic_suruchia@quicinc.com, quic_soni@quicinc.com, 
	quic_pavir@quicinc.com, quic_souravp@quicinc.com, quic_linchen@quicinc.com, 
	quic_leiwei@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Jan 2024 at 18:00, Jie Luo <quic_luoj@quicinc.com> wrote:
>
>
>
> On 1/10/2024 9:35 PM, Andrew Lunn wrote:
> > On Wed, Jan 10, 2024 at 07:20:56PM +0800, Luo Jie wrote:
> >> Add the MDIO device tree of ipq5332.
> >>
> >> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> >> ---
> >>   arch/arm64/boot/dts/qcom/ipq5332.dtsi | 44 +++++++++++++++++++++++++++
> >>   1 file changed, 44 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> >> index bc89480820cb..e6c780e69d6e 100644
> >> --- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> >> +++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> >> @@ -214,6 +214,38 @@ serial_0_pins: serial0-state {
> >>                              drive-strength = <8>;
> >>                              bias-pull-up;
> >>                      };
> >> +
> >> +                    mdio0_pins: mdio0-state {
> >> +                            mux_0 {
> >> +                                    pins = "gpio25";
> >> +                                    function = "mdc0";
> >> +                                    drive-strength = <8>;
> >> +                                    bias-disable;
> >> +                            };
> >> +
> >> +                            mux_1 {
> >> +                                    pins = "gpio26";
> >> +                                    function = "mdio0";
> >> +                                    drive-strength = <8>;
> >> +                                    bias-pull-up;
> >> +                            };
> >> +                    };
> >> +
> >> +                    mdio1_pins: mdio1-state {
> >> +                            mux_0 {
> >> +                                    pins = "gpio27";
> >> +                                    function = "mdc1";
> >> +                                    drive-strength = <8>;
> >> +                                    bias-disable;
> >> +                            };
> >> +
> >> +                            mux_1 {
> >> +                                    pins = "gpio28";
> >> +                                    function = "mdio1";
> >> +                                    drive-strength = <8>;
> >> +                                    bias-pull-up;
> >> +                            };
> >
> > I don't know why i'm asking this, because i don't really expect a
> > usable answer. What sort of MUX is this? Should you be using one of
> > the muxes in drivers/net/mdio/mdio-mux-* or something similar?
> >
> >      Andrew
>
> Sorry for the confusion, the pin nodes are for the MDIO and MDC, these
> PINs are used by the dedicated hardware MDIO block in the SoC. I will
> update the node name from mux_0 to MDC, mux_1 to MDIO, to make it clear.
> The driver for this node is drivers/net/mdio/mdio-ipq4019.c, it is not
> related to the mdio-mux-* code.

Have you read Documentation/devicetree/bindings/pinctrl/qcom,ipq5332-tlmm.yaml
? Have you validated your DTSI files against DT schema? How many
warnings will you observe if you rename the mux_0 node to MDC?

-- 
With best wishes
Dmitry

