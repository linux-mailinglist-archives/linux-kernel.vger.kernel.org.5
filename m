Return-Path: <linux-kernel+bounces-29434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BB0830E2C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 21:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 815831C2167C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B2F250F8;
	Wed, 17 Jan 2024 20:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MO3CwRkw"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB8725542
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 20:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705524494; cv=none; b=fAX0p1btwD2gR8p9kKvfhdwJ678/2EYV9ixhO21fMQmJvTnhkivlLZhF32HCcS+LzJMcu73E6gbhegj73ICNb8Xje373C6ycNCBYIFsktiNa7CWCoWVkb1eaqiUj5CyIlq4KwK1XYB44e8cRn3248mKI/LFx2LXJ/LABQ5EIxGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705524494; c=relaxed/simple;
	bh=nBSMqib0vx/t6LIPdWb68W3eBAp9SDyqSB85Ypn6WZo=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type; b=NmjSoQTcjRJqfeD+6axgpuHeU5QjEOHM1ouxGSb3K2XGrMH5/J8FIFnTAs64wpfHi2rsfuqPcLa3F/5OaLP6dtidHe+thK0xdBIu7fgXJmTa4NggKH/UbUlz8sBfzZN6dqxVs1q1elyHCP3VYXZY9QlPc3d1j1cto+LAqZud2Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MO3CwRkw; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5ff6d3504d5so9041387b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 12:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705524491; x=1706129291; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8C61/CVBZybL4d7jDWa4SEthmuklcb9ycEMool3g1U8=;
        b=MO3CwRkwB87dV/GiJbY/21JYmD53/MioyY8fPruE2sVvgTPUfBUGD76RujJNB7oULU
         A5CdixGRaO8t6xKoLXVJ+kQzF/tyfVbloCkJ5ijV5eXVaT5z3ZVaCssp8rlFGf5X3KTz
         w1iSai/oWTkh5jJhEXoq1H83TgU9T7TUvCJaiFnwuWkyu8KnlJYxFwvZMcyyXtlr5tGZ
         kdl5zwKvkl+iFz6skkvSj70CEFKrW5vPIqqbaLZ1dKXK0TDykFyVEAp5NvdcHKGmai4C
         PYI5ZqVmP1jE6neROwiOZ3NDeGQbHyGnpDbt+FCNuMO2TuZmM/vOs10BBZxSBRPaHmW2
         j+cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705524491; x=1706129291;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8C61/CVBZybL4d7jDWa4SEthmuklcb9ycEMool3g1U8=;
        b=jyu8DHmpibISUzkERwrvOSkaZcuMfQHWjaomqOPZG8ZsNKx5/78k01HOYSQZqr8mSy
         kc8WtN2KZaMrJwQWnpSHQ/IPuJOfSEJYEUo80PuPrWwi5Wlt7rIqnNECjKyorrEliu0A
         vFTwbjah4MM4hnAV5IYF4i8M9alAQ/cAUWYBpk97PCrIFn9ARGUe0UKK3XIPt3J28TwR
         Q8+wbu4aAyOlFnOcn/BriO8L/xXegfYs8z+BHAj0qaxytot+NSpkqixh9/l0fyYg10+l
         I5h1S/C1KxzPyeRGlHBPAC6ITgEj2SC1u2upt7q3YfHdm00bgdKbm53naN+69kLJInPa
         eARQ==
X-Gm-Message-State: AOJu0YwnCoiQu+AWGYpcaM8Ds8Nw/MHOASP3qfT8Qct+xd2C5aY1EgQN
	1POeI8cbggPfoR6XSt3wallPWklZZ3q8GhuphMqxvrHBUeySvg==
X-Google-Smtp-Source: AGHT+IFH9aLIollE5z7rcJcIrH0LLrrTJJh1FWfQ583YbLbX3/A24BFq7vRO+v64P0FgvpJ1Pg5F4vCYZ+aUakfyk7U=
X-Received: by 2002:a81:8d45:0:b0:5f9:f9b4:2f20 with SMTP id
 w5-20020a818d45000000b005f9f9b42f20mr6262366ywj.96.1705524490901; Wed, 17 Jan
 2024 12:48:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117173458.2312669-1-quic_sibis@quicinc.com> <20240117173458.2312669-8-quic_sibis@quicinc.com>
In-Reply-To: <20240117173458.2312669-8-quic_sibis@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 17 Jan 2024 22:47:59 +0200
Message-ID: <CAA8EJpo5F==whKMVFgPAM+=DpB+=KzPhKt-poGXuHxy-KSxe8Q@mail.gmail.com>
Subject: Re: [RFC 7/7] arm64: dts: qcom: x1e80100: Enable LLCC/DDR dvfs
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: sudeep.holla@arm.com, cristian.marussi@arm.com, andersson@kernel.org, 
	konrad.dybcio@linaro.org, jassisinghbrar@gmail.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	quic_rgottimu@quicinc.com, quic_kshivnan@quicinc.com, conor+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Jan 2024 at 19:37, Sibi Sankar <quic_sibis@quicinc.com> wrote:
>
> Enable LLCC/DDR dvfs through the Qualcomm's SCMI vendor protocol.

Could you please post DT bindings?

>
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 48 ++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> index 6856a206f7fc..3dc6f32fbb4c 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> @@ -329,6 +329,54 @@ scmi_dvfs: protocol@13 {
>                                 reg = <0x13>;
>                                 #clock-cells = <1>;
>                         };
> +
> +                       scmi_vendor: protocol@80 {
> +                               reg = <0x80>;
> +
> +                               memlat {

This doesn't look like a generic node name.

> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;

> +
> +                                       memory@0 {
> +                                               reg = <0x0>; /* Memory Type DDR */
> +                                               freq-table-khz = <200000 4224000>;
> +
> +                                               monitor-0 {
> +                                                       qcom,cpulist = <&CPU0 &CPU1 &CPU2 &CPU3 &CPU4 &CPU5 &CPU6 &CPU7 &CPU8 &CPU9 &CPU10 &CPU11>;



> +                                                       qcom,cpufreq-memfreq-tbl = < 999000 547000 >,
> +                                                                                  < 1440000 768000 >,
> +                                                                                  < 1671000 1555000 >,
> +                                                                                  < 2189000 2092000 >,
> +                                                                                  < 2156000 3187000 >,
> +                                                                                  < 3860000 4224000 >;

These tables should be rewritten as OPP tables.


> +                                               };
> +
> +                                               monitor-1 {
> +                                                       qcom,compute-mon;
> +                                                       qcom,cpulist = <&CPU0 &CPU1 &CPU2 &CPU3 &CPU4 &CPU5 &CPU6 &CPU7 &CPU8 &CPU9 &CPU10 &CPU11>;
> +                                                       qcom,cpufreq-memfreq-tbl = < 1440000 200000 >,
> +                                                                                  < 2189000 768000 >,
> +                                                                                  < 2156000 1555000 >,
> +                                                                                  < 3860000 2092000 >;
> +                                               };
> +                                       };
> +
> +                                       memory@1 {
> +                                               reg = <0x1>; /* Memory Type LLCC */
> +                                               freq-table-khz = <300000 1067000>;
> +
> +                                               monitor-0 {
> +                                                       qcom,cpulist = <&CPU0 &CPU1 &CPU2 &CPU3 &CPU4 &CPU5 &CPU6 &CPU7 &CPU8 &CPU9 &CPU10 &CPU11>;
> +                                                       qcom,cpufreq-memfreq-tbl = < 999000 300000 >,
> +                                                                                  < 1440000 466000 >,
> +                                                                                  < 1671000 600000 >,
> +                                                                                  < 2189000 806000 >,
> +                                                                                  < 2156000 933000 >,
> +                                                                                  < 3860000 1066000 >;
> +                                               };
> +                                       };
> +                               };
> +                       };
>                 };
>         };
>
> --
> 2.34.1
>
>


--
With best wishes
Dmitry

