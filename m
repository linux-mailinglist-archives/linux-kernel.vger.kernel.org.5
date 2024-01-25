Return-Path: <linux-kernel+bounces-38634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9875C83C375
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDF651C23DCE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB904F88E;
	Thu, 25 Jan 2024 13:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ClJ8Nmz5"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58E950A74
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 13:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706188751; cv=none; b=e6I1WIwR8mBv71ijOQW7OiAHhAoWSCBVGgNj+TVtCoNctWPsSgFJT1D/r75ThzbD6VwbT/XiS/ibiBv51NikayBf1ezaj3MQc91/9/59AvMLgVHQCNwxHO+iy2MYsfklYTSq6S+BYF514+XkZXOhba24ArJXwBYDupc7+Cw87F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706188751; c=relaxed/simple;
	bh=8ZwYMGT29+2aOw1eN9EP3kUeI/wEb4MnmErpaR8lCeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ppPgprn0KKogxT8hOMhP4tKCeCVtFMVKoVEbfW5brtPLVL1L6A9zB5XwyLmVFEAwIabFz7vrhG/caPxi8pw8jWBcMOzhc7isQQVzcMj6OO+EqfVxg3LmLEhwn77zd5JIfT0ShfaV3RV29QAYdlZTG4Kjl0rM5AWiVEIpKqfc9zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ClJ8Nmz5; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dc226dca91aso6327283276.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 05:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706188749; x=1706793549; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=13Rb80VOvvaXUse1uPuWqVFXOg9vSOw6wfFVQXf5Clw=;
        b=ClJ8Nmz5ID7ZPKnkX5f5vXSnMoNUpuLYcmlEeJ+CeAYt5Bo3PEFQMcX8HHUZT+YZKj
         f8phtNVxvy7IK7/xDhW2lbUjBLmhhkFbpLv64FC5+jzIbKx3oX3Szf9G782iqaAB0wsG
         Oy92RETYDBJYX0utrKKlvj9kOvQvZPuZR3q5mPuixqpF4SjmzDfV7BemwjRtoKCfxwrL
         z5HW9AUXavSHmT30rO/K3b20+666aC3qVwl1rJc5yL14DI4ef3dNK0y7EGvY65+EyyNG
         leLX6HzlHmX/OaO4jv77pCyyK4c5aDtBi8Tp2JS3hEIEUDwXAoGYUNaziOR9dbukQv/M
         nP4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706188749; x=1706793549;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=13Rb80VOvvaXUse1uPuWqVFXOg9vSOw6wfFVQXf5Clw=;
        b=eXIzc8KAYEDc5893rDiwJBw7fRbPyyZeGOQrPowhSAmj1CcmZVU+mKaSlhDQppLTNb
         /Cc0kxoR4nFfMpFMm++zF11T7lwlVNXKcsKCto3JKoT84FmeEEImKHQFl5eUD+pywH9i
         EOCVDRuSmWVwwMXWAXI62MJf47pnhN1gHZ6ncJ17Nb90bLEveDnjqOmRg4kjGqfvY2RY
         6MdzXbxhK/zVNM6/PDSaKpAhFmffVxzATGtLoM67UlduqRQOrHJhyV+xZ9X/aaiVWL5Q
         wPpzlJdbBzPgf5IGTAF/LdaVmwLgqKrmPkvoj6bTj9vUillVMy7L3pRJOR3ar8/aroZA
         PpnQ==
X-Gm-Message-State: AOJu0YzbZK8750ZPPiutR/5G98kWKgFMAyTpAdEc1y8lpXZKtr6dnSzb
	6C2npsls2xGm9AeK6gQFQDfuswiG/kQ/IkJdUIME2dtGLBxP+Tw5zN/j9QxFdDgOb3aZcfB2kyT
	kii+75BI85kI81IOrWfZRqDmoQb5Hki5z7dMusYirfLnZtylt
X-Google-Smtp-Source: AGHT+IFsnb98+co8kdXhhrvZvf7JpU2va+eR8/Qjp+9lVnk0u3xiBR+WFtOcK5UiEHgsksEzWXz8zTLqItdwAHLViaw=
X-Received: by 2002:a5b:682:0:b0:dc2:8282:8893 with SMTP id
 j2-20020a5b0682000000b00dc282828893mr650947ybq.127.1706188748827; Thu, 25 Jan
 2024 05:19:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125130626.390850-1-krzysztof.kozlowski@linaro.org> <20240125130626.390850-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240125130626.390850-2-krzysztof.kozlowski@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 25 Jan 2024 15:18:57 +0200
Message-ID: <CAA8EJprfhZ3m6aKcPsQMAUjDFPPeqN_L-E6Tz604pYJqgSvDZA@mail.gmail.com>
Subject: Re: [PATCH 2/6] arm64: dts: qcom: sm8250: describe all PCI MSI interrupts
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Jan 2024 at 15:07, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Each group of MSI interrupts is mapped to the separate host interrupt.
> Describe each of interrupts in the device tree for PCIe hosts.  Not
> tested on hardware.
>
> PCIe0 was done already in commit f2819650aab5 ("arm64: dts: qcom:
> sm8250: provide additional MSI interrupts").
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8250.dtsi | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> index 760501c1301a..41f5e6eb2f6b 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> @@ -2248,8 +2248,16 @@ pcie1: pcie@1c08000 {
>                         ranges = <0x01000000 0x0 0x00000000 0x0 0x40200000 0x0 0x100000>,
>                                  <0x02000000 0x0 0x40300000 0x0 0x40300000 0x0 0x1fd00000>;
>
> -                       interrupts = <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>;
> -                       interrupt-names = "msi";
> +                       interrupts = <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 374 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>;
> +                       interrupt-names = "msi0", "msi1", "msi2", "msi3",
> +                                         "msi4", "msi5", "msi6", "msi7";
>                         #interrupt-cells = <1>;
>                         interrupt-map-mask = <0 0 0 0x7>;
>                         interrupt-map = <0 0 0 1 &intc 0 434 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
> @@ -2349,8 +2357,16 @@ pcie2: pcie@1c10000 {
>                         ranges = <0x01000000 0x0 0x00000000 0x0 0x64200000 0x0 0x100000>,
>                                  <0x02000000 0x0 0x64300000 0x0 0x64300000 0x0 0x3d00000>;
>
> -                       interrupts = <GIC_SPI 243 IRQ_TYPE_LEVEL_HIGH>;
> -                       interrupt-names = "msi";
> +                       interrupts = <GIC_SPI 243 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 264 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 278 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 289 IRQ_TYPE_LEVEL_HIGH>;
> +                       interrupt-names = "msi0", "msi1", "msi2", "msi3",
> +                                         "msi4", "msi5", "msi6", "msi7";

This part looks a bit suspicious. All other platforms have these
interrupts in a continuous range.

Other than that, LGTM

>                         #interrupt-cells = <1>;
>                         interrupt-map-mask = <0 0 0 0x7>;
>                         interrupt-map = <0 0 0 1 &intc 0 290 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
> --
> 2.34.1
>
>


-- 
With best wishes
Dmitry

