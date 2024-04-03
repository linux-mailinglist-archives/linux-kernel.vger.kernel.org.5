Return-Path: <linux-kernel+bounces-129656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD67896E00
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96271290F58
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1AFC143869;
	Wed,  3 Apr 2024 11:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IyGuMKYC"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EB073506
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 11:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712143297; cv=none; b=L9f8ykgJIPmUwtrhDeKlCp3ILvoLQ1p0uNq/kFgqgB/wAdRAF73vI7ImW16VJyaKdaFIE7ePZ0/BfbvgVJKX828+ahpXu8FX9UGld1swlrZrBViOlksjW9+o7H33vsfPFQ6L9zm/1eCDyObveKS+xi4o/Yj7jAue2s2+dtGtaNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712143297; c=relaxed/simple;
	bh=14A2zGvt71HCwM6O6gK42NmYjcKdFxMOyjGXH9M8uaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OK7/1dIEEX+jIXjCw2Qqnv0S3JqBs9UdRbm4tSNc40ILPWnbBdgDW5yQDnVzfNPxamMIHKkkNYs6hYc0nlCEtQI9DEP1G8NKOWQa8yQyXBo+d08jx+dm9OQVbBWjKYzKzEImX509+uYDRMTel0TibqiGpRzvHYwZX4nF4lGBCFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IyGuMKYC; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dcc80d6004bso5737886276.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 04:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712143294; x=1712748094; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lF+T4bxnDZj7vHWxhdfHcPO4VDzU3zVkWYi0IqT5ix0=;
        b=IyGuMKYCNcOdj5zfUJMfwLXjQxs/QumlNmkmfT3cw1Til7Omi0PtrwB/QZHbGgMzKX
         SjRMQWV+hxVdIFkbklSq+gOhEywIm0JKTe8lKi4D9AHXowyOd4fuR8/kH3CfFgfJpayj
         LLiUy2+frpgvRV4C8icpjezhPAT5ekYkBpETxXo+4qtTBBTNRkoGBaYQROZYcWRgY1Ay
         ttB+RYBzWxe6OqOVDXQugdOkbNVbp7Tb9R7UKTUXRAKVWdKDn0l3CiDaeTIRoWusCO+L
         hvb8jNJ+ML76ZA4v9mRde7zB7y0WpQ7Y1m05K30IqUjnTXFibl3XWOVpjcW23ipUjuxp
         nZ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712143294; x=1712748094;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lF+T4bxnDZj7vHWxhdfHcPO4VDzU3zVkWYi0IqT5ix0=;
        b=ulMdw766v6wcKRNwxYtHdLeHUkeakKDnD7qgtOz0LkSU35Gn3viMVhNmEkPqrBRoWl
         qTS1bIBwozcoE3ETJHP0gdvNhs8uGZIFXGyl1UP+5KJGqCk/rIEAVp1ouX7q8DA3L96k
         WQWYM41/P2NZpjI7JaUfiZ6GOJ0mFoftdjmU4iQSpwitFv/W97HckGSlBeu4tLw4g1Na
         CIBKxcJBG0GrLyfboVSAC+E+FkqTiEmyscxxL2zVNmDd8NfHLA9zScd0U9NVs3AYkg6X
         viY5/CKUPauqRvPOFtd+FtSejvniVgMNmpeZWOTIMF742/hVvYh1sbg68ggxBG6IC9yi
         Og0A==
X-Forwarded-Encrypted: i=1; AJvYcCX1BPe/ew+tJa64QUn5S1q+xp3wR1V8XieKvp6HwDPIKcUwblDY3os74kXu5S4VYF/W1mbnnEieKgyzeXCXnLXZzKlDlM4+i6FSiU60
X-Gm-Message-State: AOJu0Yw4DSHv4gApHllszchx0mpUOjQEUI7HEfRTl9cNsEtQoKzE2M0Q
	fXfcclJCMjencQa6TwzIg2yta/IAfd3skd9HB61QEc9ATEpPi48izDymBKmBrTvRkiO1L3Uq7Hr
	N7Mx/8J/uOtC/u5leooa/GjckSPvZ71YnGAsEiA==
X-Google-Smtp-Source: AGHT+IFtc7mBgFp3kaw9P5n/Or46d3MjVihrSW5DyRrTli9K6KFjlNUz651nVrW1gUHor3EUrMSY621ZfPcAB6Oktbw=
X-Received: by 2002:a25:b198:0:b0:dcf:56c3:336e with SMTP id
 h24-20020a25b198000000b00dcf56c3336emr13726871ybj.35.1712143294469; Wed, 03
 Apr 2024 04:21:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328095044.2926125-1-quic_sibis@quicinc.com>
 <20240328095044.2926125-6-quic_sibis@quicinc.com> <Zgvnh0J2a_fBH0bR@bogus>
In-Reply-To: <Zgvnh0J2a_fBH0bR@bogus>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 3 Apr 2024 13:20:58 +0200
Message-ID: <CAPDyKFous+aoopf+=ZRugR78jyekobODqn7tqWRCyirPD+=eYw@mail.gmail.com>
Subject: Re: [PATCH 5/5] arm64: dts: qcom: x1e80100: Enable cpufreq
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Sibi Sankar <quic_sibis@quicinc.com>, cristian.marussi@arm.com, andersson@kernel.org, 
	konrad.dybcio@linaro.org, jassisinghbrar@gmail.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	quic_rgottimu@quicinc.com, quic_kshivnan@quicinc.com, conor+dt@kernel.org, 
	quic_gkohli@quicinc.com, quic_nkela@quicinc.com, quic_psodagud@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Apr 2024 at 13:10, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Thu, Mar 28, 2024 at 03:20:44PM +0530, Sibi Sankar wrote:
> > Enable cpufreq on X1E80100 SoCs through the SCMI perf protocol node.
> >
> > Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> > ---
> >  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 27 ++++++++++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> > index 4e0ec859ed61..d1d232cd1f25 100644
> > --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> > @@ -68,6 +68,7 @@ CPU0: cpu@0 {
> >                       compatible = "qcom,oryon";
> >                       reg = <0x0 0x0>;
> >                       enable-method = "psci";
> > +                     clocks = <&scmi_dvfs 0>;
> >                       next-level-cache = <&L2_0>;
> >                       power-domains = <&CPU_PD0>;
> >                       power-domain-names = "psci";
>
>
> Any reason why you wouldn't want to use the new genpd based perf controls.
> IIRC it was added based on mainly Qcom platform requirements.
>
> -                     clocks = <&scmi_dvfs 0>;
>                       next-level-cache = <&L2_0>;
> -                     power-domains = <&CPU_PD0>;
> -                     power-domain-names = "psci";
> +                     power-domains = <&CPU_PD0>, <&scmi_dvfs 0>;
> +                     power-domain-names = "psci", "perf";
>
>
> And the associated changes in the scmi dvfs node for cells property.
>
> This change is OK but just wanted to check the reasoning for the choice.

To me, it seems reasonable to move to the new binding with
#power-domain-cells for protocol@13. This becomes more future proof,
as it can then easily be extended to be used beyond CPUs.

That said, I just submitted a patch [1] to update the examples in the
scmi DT doc to use  #power-domain-cells in favor of #clock-cells. I
don't know if there is a better way to promote the new bindings?
Perhaps moving Juno to use this too?

Kind regards
Uffe

[1]
https://lore.kernel.org/all/20240403111106.1110940-1-ulf.hansson@linaro.org/

