Return-Path: <linux-kernel+bounces-72679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA4685B725
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 877A71F25E54
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DD85FB91;
	Tue, 20 Feb 2024 09:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c3bxW6jq"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A815F475
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 09:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708420761; cv=none; b=hxn2K7M9r2S8qc4WBjt0htfNFFhTM1Y4JGKIeqqtvUfpNjD89o+voI1RqUzuZihWz7lV+CzIZTkPmCtp8/Z5xVBKfZWPbx6RPVTaepH8txEt4R9L/JJ63sASxm/ywHUgBdG2NQUCUuxZUymrX6ZBG///WMmLl6g1WacdSAri0sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708420761; c=relaxed/simple;
	bh=vHDeoeY6rVvgUPwaKy4miw3a+/4Wz+3FToMeykblxHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WAoltXnM+t+eeljhIXJytr2nDwbEpf1/x8XSQEQN9xveioR5jBew9eM9j0DpLdKmPv8dW/s/HeJNaQSbQVf0KsOtI8xDV+4XpD7TeJXmDfCBBdnoZQMivrmV2gi4CXj/15xkrpBjr/0TlxqyDm9nPOt+iX2o72QKQVujxEBaaoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c3bxW6jq; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-60866ce76dfso2683687b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 01:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708420759; x=1709025559; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0gsEdTOg81nU4mrHxMiAVDV5UIPBJ/nXolBaH3QcjCw=;
        b=c3bxW6jqw/kJ3PpXF2122zK1p8MtJvA6fxW/+qJw2S9Lhif/orfomP8Zk+5wG3/IQI
         /vM+PaaRHxMh/IxTwo4eZ7XXLBTYHMf0f1uND5TnYU41GRIfh2ByH3GedqP/TwM+8XUm
         D1yPHa8Eb2f0cqDwhJR4L6mhE7tUEACF1/MEbX0RTchrEH3Yo7I49UW9BIeuUV9Oj8jf
         JbNs3CBV9Pyu7hVt0/x9pq7OEtZVNkzetoVUwu8QbBHD3SCUGbWzQpYY/sD4Ujf6PTmq
         z9e8FudIrGU00xLVGFzFJ/enPynhVrELmpX/cvEdqzrAnK9vGPfcjkFkMg5JMpIhtP8r
         kAiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708420759; x=1709025559;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0gsEdTOg81nU4mrHxMiAVDV5UIPBJ/nXolBaH3QcjCw=;
        b=sOrDUK/EBaP6eRIqpol2C2IhZyfj3tvamOkFzbO7dGEcowumxKHIpEmG7ikANcEITU
         RmXwWII3rj1aWqySqtreeQBcJYLm4zDDqofLmdwojWs6t/My8YAc2N+SElqvPCdp0Bmx
         A/EvyiXaUPIDQYE2BrS4zXQ0xEz+0CiHlT7hZ5QEiIuwPPnlKNq/CKhk7NJ67s1801Vc
         zheoZJywW1YMG/90uFZdf19RF2B/96ODL7q0FEXiSIF1tYipZvo3U6N2IBDx3TuultsA
         dVO8bfblEbBBxM7W0bTuFX8vG46WRwouNEBrd8qyjpedbhPqI/guPCWeqTzATWzDlc0t
         rZRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWv7vpQl0rMRq2OYYJB3D4LZQlgeQr7aJ0LaXzuT1AWBF4jsa0LCnzZrLjTq5GrEIIq6bWXR+diXphkt3e5osxJXbsNNnkq/o7L49Ic
X-Gm-Message-State: AOJu0YzOEiFgaCBVw2ggf64xToRYRHtgdNosozt3jW+o/AenxxPdd5Lo
	rO/FP2rkrUpLS6wQI3SuzB3B1z3LKszADKFB8JCGhvo+3OO8coRSzutrQlAR36wFNgUPq/MHKZj
	IGtec3oeNizHcmep2P0/3e+TMiL5JX+y9nqZX0FXOSv/Up8tO
X-Google-Smtp-Source: AGHT+IGPqn0qOwME5A5LSEqJGUhcBrK5loyFtiw5abc2EMucdzkO4malL/Si43SjYjBl925JQ1d2/Vm0i+Z9o5EXBFk=
X-Received: by 2002:a25:2f52:0:b0:dcb:de9b:175 with SMTP id
 v79-20020a252f52000000b00dcbde9b0175mr13753374ybv.6.1708420759119; Tue, 20
 Feb 2024 01:19:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205115721.1195336-1-quic_jingyw@quicinc.com>
 <20240205115721.1195336-6-quic_jingyw@quicinc.com> <CAA8EJpr7tHXZHcH1Sbcy0-MCZfMxKBjaPXGdpg3cqyyFjTZOeA@mail.gmail.com>
 <9685991e-6577-4f96-a17f-b0a65d8d1260@quicinc.com>
In-Reply-To: <9685991e-6577-4f96-a17f-b0a65d8d1260@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 20 Feb 2024 11:19:08 +0200
Message-ID: <CAA8EJpqVQEktHuD5sYsRMiytPS+XfoHzVTBUuKqeavL4yW72Sg@mail.gmail.com>
Subject: Re: [RFC PATCH 5/6] arm64: dts: qcom: add base AIM500 dtsi
To: Jingyi Wang <quic_jingyw@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org, 
	robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	kernel@quicinc.com, Tingwei Zhang <quic_tingweiz@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 Feb 2024 at 11:17, Jingyi Wang <quic_jingyw@quicinc.com> wrote:
>
> Hi Dmitry,
>
> On 2/5/2024 10:23 PM, Dmitry Baryshkov wrote:
> > On Mon, 5 Feb 2024 at 14:00, Jingyi Wang <quic_jingyw@quicinc.com> wrote:
> >>
> >> Introduce aim500 board dtsi.
> >
> > So, is it a board or a module?
> >
> aim500 is a module, will fix the descrption.
>
> >>
> >> AIM500 Series is a highly optimized family of modules designed to
> >> support AIoT and Generative AI applications based on sm8650p with
> >> PMIC and bluetooth functions etc.
> >>
> >> Co-developed-by: Tingwei Zhang <quic_tingweiz@quicinc.com>
> >> Signed-off-by: Tingwei Zhang <quic_tingweiz@quicinc.com>
> >> Signed-off-by: Jingyi Wang <quic_jingyw@quicinc.com>
> >> ---
> >>  arch/arm64/boot/dts/qcom/sm8650p-aim500.dtsi | 409 +++++++++++++++++++
> >>  1 file changed, 409 insertions(+)
> >>  create mode 100644 arch/arm64/boot/dts/qcom/sm8650p-aim500.dtsi
> >>
> >> diff --git a/arch/arm64/boot/dts/qcom/sm8650p-aim500.dtsi b/arch/arm64/boot/dts/qcom/sm8650p-aim500.dtsi
> >> new file mode 100644
> >> index 000000000000..cb857da8653b
> >> --- /dev/null
> >> +++ b/arch/arm64/boot/dts/qcom/sm8650p-aim500.dtsi
> >> @@ -0,0 +1,409 @@
> >> +// SPDX-License-Identifier: BSD-3-Clause
> >> +/*
> >> + * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
> >> + */
> >> +
> >> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> >> +#include "sm8650p.dtsi"
> >> +#include "pm8550.dtsi"
> >> +#include "pm8550b.dtsi"
> >> +#define PMK8550VE_SID 8
> >> +#include "pm8550ve.dtsi"
> >> +#include "pm8550vs.dtsi"
> >> +#include "pmk8550.dtsi"
> >> +
> >> +/ {
> >> +       aliases {
> >> +               serial1 = &uart14;
> >> +       };
> >> +
> >> +       vph_pwr: vph-pwr-regulator { };
> >
> > Is this regulator a part of the module or a part of the carrier board?
> > If the latter is true, this must go to the carrier board DT file.
> >
>
> the vph_pwr regulator is defined in the aim500-aiot carrier board and used
> in aim500 module.

If it is defined in the carrier board, then please move it and
corresponding supply entries to the carrier board dts. Other devices
using the SoM can have different power tree.

While we are at it, could you please rename the node to regulator-vph-pwr?


-- 
With best wishes
Dmitry

