Return-Path: <linux-kernel+bounces-164555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 486028B7F3E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E63131F25CF1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547EE18130C;
	Tue, 30 Apr 2024 17:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ur0wHqG2"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3020E537E4
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 17:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714499429; cv=none; b=n/I17XijUDtnmJSi1WTydMvZKBeKQHrkeMVT0DkR8ouTIeXKKmiuZPtjym+82IG9crfs1mCviEYo6XB6ZwkZ0PdTTuoFIlBZ5f9hU5f0c0TYpunkhCwaaHRiKSEhngG4viDJ2FdKNyN1snbeO+Rnnw2WuTXDvqMAjBChjrzuxeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714499429; c=relaxed/simple;
	bh=MC6kuUNtvdgO8awbXMD83ojLho7cU3kwpSqW388XSgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gGxzKDvFYMJ+mmTZ09CG9d7tI7iSsAdvUvSfb+UBdOCK4cXI7loll3T26liWR909ebDwTTUBNNTOggBTKT82DbqR/9zddIHTXC9F0uSU7pJ7z9IRtbBtCAmGDydHoDRksIj/1mbcHPl2PdNrFEKy48IRbMEDmNoy88Af8P36pZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ur0wHqG2; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-de5b1e6beceso5193038276.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 10:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714499427; x=1715104227; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sD/quSO4976C2GH4MU0N7jDR6o6VrMEFs0/aJ59+F6w=;
        b=Ur0wHqG26bKE3y1w5azx/A/2gim77chbNjyw7Gfnu13ubsKEIFQXJWYsR6+a4bTuQj
         OBlPq8GD05lR6IOK6T3yER3lBkzZLi0kxorxjr3COioRHQ4sXl0f3O8dzZKSrOib3CGg
         z5Y7jSkC3vlHKfFwWY/SlLF5QEuvK8pLdgpesoA5LkPjjknLtkAYRMHzHKXLXNtPk4PN
         rk7tdoqn56nZFFi+spxlfbM35x8jSdaSpE8xbzoHiiV9Pk7xeXzIU3akgag3C6ak/mlz
         FuetgMtXgg568d5nPUsSsuh9gdVFE3rtb0qjVRuDcejkXsvg/TfIjwB1jHyINy1S0Z5h
         9rgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714499427; x=1715104227;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sD/quSO4976C2GH4MU0N7jDR6o6VrMEFs0/aJ59+F6w=;
        b=QMhIRvTRwvxhi2EFX2FOIDaplVmScz6q6TkV7HXdE+LYwA3q/Dnox/ZlDJHQbWmxYz
         mURLeH/7GhzIL3NBFPiAKSqT/RqUsUdXpKDvWSqURYIv7glRDRZovQcyOfAHCED0rX4l
         8izM2bDikQEERthVJsbMMoMBcHYXdgWPY8uzKK2ZQcHyeojuSwixNExy9VFxjyAi6HUe
         h0DPHiZncnZO5Qvpl9rJDLXoPJ58uuuNOoAJYIU4WUvA+hd2FA8DtmR7OLIUow2eKijh
         1cl6MudiXP0KUPoeC/3eAggwvHrnE0t0cG2+YCkVErX4tD9ViuLyO7SCaN8KLbCEPf1A
         TsMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyfK6k955o/zYKOwuozYAJKCjVWuB/soAQT9OdEsTtCZVVkmRzbnA5KOldZRCSz4XqWCGkag4U4Cak5WDyzMHQa33WKrx9hlxDvsPE
X-Gm-Message-State: AOJu0YzprV1xNeDHHHUkC4fXZhn04pPTkWXb0TzMGsaIFcSYWegXHBQR
	ofGi9FXX5W1gjsoC8dqErR5fBWsZ8AScqxC8f1HuPF3OjxG39iyRHwehqLIr6IBKW/PqsLL040R
	L5rRvftF3krFZkNBGy9gLy+44qSr7BaGpX3fq8g==
X-Google-Smtp-Source: AGHT+IHyb1eFObq3rdLSvzRk9V3jcbKnDdCig9If6eEhZckR6Mp4DGotDQyqqCg8Z+/G5Qwqg5BT/kNFhil6WvkeiMY=
X-Received: by 2002:a25:8409:0:b0:de5:a062:ba8d with SMTP id
 u9-20020a258409000000b00de5a062ba8dmr309405ybk.11.1714499427026; Tue, 30 Apr
 2024 10:50:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1714494711-10322-1-git-send-email-quic_msarkar@quicinc.com> <1714494711-10322-3-git-send-email-quic_msarkar@quicinc.com>
In-Reply-To: <1714494711-10322-3-git-send-email-quic_msarkar@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 30 Apr 2024 20:50:15 +0300
Message-ID: <CAA8EJprnO84T+mbUD-T55T0zU0ngWFnpa4i8EfWxu0UzJZuzgw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] arm64: dts: qcom: sa8775p: Set max link speed to
 gen4 for ep pcie
To: Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc: andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, konrad.dybcio@linaro.org, 
	manivannan.sadhasivam@linaro.org, quic_shazhuss@quicinc.com, 
	quic_nitegupt@quicinc.com, quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com, 
	quic_krichai@quicinc.com, quic_vbadigan@quicinc.com, 
	quic_schintav@quicinc.com, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Apr 2024 at 19:33, Mrinmay Sarkar <quic_msarkar@quicinc.com> wrote:
>
> Adding this change to set max link speed to gen4 as sa8775p supports
> gen4 so that pcie link can be enumerated as gen4.

Previous patches mentioned stability issues. Were they solved?


>
> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sa8775p.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> index 0c52180..aad2cd7 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> @@ -3730,7 +3730,7 @@
>                 power-domains = <&gcc PCIE_0_GDSC>;
>                 phys = <&pcie0_phy>;
>                 phy-names = "pciephy";
> -               max-link-speed = <3>; /* FIXME: Limiting the Gen speed due to stability issues */
> +               max-link-speed = <4>;
>                 num-lanes = <2>;
>
>                 status = "disabled";
> @@ -3888,7 +3888,7 @@
>                 power-domains = <&gcc PCIE_1_GDSC>;
>                 phys = <&pcie1_phy>;
>                 phy-names = "pciephy";
> -               max-link-speed = <3>; /* FIXME: Limiting the Gen speed due to stability issues */

I think you've just sent a patchset which adds this node. Is there any
reason for setting the max-link-speed to 3 just to change it to 4
immediately?

> +               max-link-speed = <4>;
>                 num-lanes = <4>;
>
>                 status = "disabled";
> --
> 2.7.4
>
>


--
With best wishes

Dmitry

