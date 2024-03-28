Return-Path: <linux-kernel+bounces-122306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1E188F4E8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D4211C256F0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 01:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748BB224D0;
	Thu, 28 Mar 2024 01:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D4GNVCUX"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245B5A921
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 01:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711590727; cv=none; b=EgOIExFFzq+9UXMpjoKEixQ+OStOk52W5rx/H4P+l24R5te4VipDfj9sKfL0sC5H9NeKoT2iBx3+js1xe22dP9jR9tD6a+1W3KmsK3s56VK8eNhSib/c6eOM52AyyLi+BxXFfmeIZ8iiitYz//3xPDDDWZSqIhxRw7rf1/GDfvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711590727; c=relaxed/simple;
	bh=mkM6R0KgpBbz4KudbiA6fw95cLUuvRuwLR/2IvSvuQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nQGQnP/laNB5d2RGJ8qrQiclcX05Xd/E3QmXqoXeCA+lTRyos70qDphv+qYTW3bzAGbto9kZ21ZiVsSagKD/P+yi9+5HbZ0X8m81g1zrN6wR3QSDSAfmh/+XkHJn+/M3QuA0RUu8PTRTgJMVsHQ1rJUFoSmx/01jPcmItbRzQeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D4GNVCUX; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-ddaebc9d6c9so484899276.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 18:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711590725; x=1712195525; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xeRupraePyxNUCGKwkTwjgmBsjpIgZkoxz4iGu5JFgM=;
        b=D4GNVCUXFpdKjKpZy4B4yr8vhONdvnIwjwp34MmdMERiVmsLzVW3kPf2NudIFy2BR+
         UJ/yK0TsAFi2HUP8/puMsIEbzcrglnwrpDD1Kzg5sqwROPppvCjdm1Buw9MnfCK2JrhK
         zPYdWB6GZjXx4ZfXn6KmoCRrAei2VActP8/S9zEVnthJSBj0xXRuTLA3vL3Z6l6Wq2Mj
         stx5sdnH3F1rnExa8Bub81vBYPd1JKW8NFjWc7ih6snNSJCY1iHfowqRWFJu2wPmdtU5
         IaNqDFSf+odUP/xp4jlncO4JdWzNZJC9UZb+BZaqykyi52jF7GPz2n8s7b4Eo+s20Tfz
         So1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711590725; x=1712195525;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xeRupraePyxNUCGKwkTwjgmBsjpIgZkoxz4iGu5JFgM=;
        b=q1ETSE/GtBDB+NoZJf1vF3DEWDvfUDe6fXkMV5LzsyBwlikqjcxLJpUmd6PcMf8CyH
         U9iGnxyaxc27VPUPMheSza42Le5ICgewof6F6BoPSUnttaauf9xNzrk4xsd+pctKyx7I
         T0tFKtdUDgKgly4WWcMM36+7Dba+6Ar72zhGBoi/BzSg43JrHIzOXYCO/0nEIDfEzu9/
         hsDwAFUd83L6TLoLTOEiBeRTJO80P3gsUZqTIvtqjHGT+zlwt6435aetZRYhKqQPm0NI
         JhMjGBYKlADogqDxKJXY0U9GbrwyxsGTko8lM2g6876w4Y6p5kPzbsZ53wQWIqeQnRmO
         UsMg==
X-Forwarded-Encrypted: i=1; AJvYcCVQSfU4D7zequcmNBQgUzWO98wOPbqflTGSuMDUofaJ25/fTax5R/tT3ZPnsMzUdEmZgQ83kPQrlUvOAaFB4o4s50E11Xe14D1W5UXh
X-Gm-Message-State: AOJu0YzIhUMX3MfZz0zh2v9Ch7G0NqmkgeeO7yckZ165PyNtmAKGlcIq
	dN96FLt8lIqMLAD6PYvAQcPoirfutSw6hScuNWtWDcYJnf1YqBzzlpmvmlGuppksOqvxxHnuu7o
	UYb/CEjy8xaVgqcbK356eU6fUiihgZItO8htJcg==
X-Google-Smtp-Source: AGHT+IHT/ujAoEbhu8rLTehIuWRBp/B6kdAP54AQCRbG7T5Aw1Z01ibd0Fm1N0Q2G2mnLCjO54IRJqd2ObldP8kjPj4=
X-Received: by 2002:a25:29c4:0:b0:dd1:2f58:292b with SMTP id
 p187-20020a2529c4000000b00dd12f58292bmr1517178ybp.9.1711590725160; Wed, 27
 Mar 2024 18:52:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326-rb3gen2-dp-connector-v2-0-a9f1bc32ecaf@quicinc.com> <20240326-rb3gen2-dp-connector-v2-2-a9f1bc32ecaf@quicinc.com>
In-Reply-To: <20240326-rb3gen2-dp-connector-v2-2-a9f1bc32ecaf@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 28 Mar 2024 03:51:54 +0200
Message-ID: <CAA8EJpoe7A94608V1GdQ-oU9UXagHPm0mVBUe4Yxi=HF2pMd7w@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] arm64: dts: qcom: qcs6490-rb3gen2: Add DP output
To: Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: cros-qcom-dts-watchers@chromium.org, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Mar 2024 at 04:04, Bjorn Andersson <quic_bjorande@quicinc.com> wrote:
>
> The RB3Gen2 board comes with a mini DP connector, describe this, enable
> MDSS, DP controller and the PHY that drives this.
>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 40 ++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> index 63ebe0774f1d..f90bf3518e98 100644
> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> @@ -39,6 +39,20 @@ chosen {
>                 stdout-path = "serial0:115200n8";
>         };
>
> +       dp-connector {
> +               compatible = "dp-connector";
> +               label = "DP";
> +               type = "mini";
> +
> +               hpd-gpios = <&tlmm 60 GPIO_ACTIVE_HIGH>;

Is it the standard hpd gpio? If so, is there any reason for using it
through dp-connector rather than as a native HPD signal?

> +
> +               port {
> +                       dp_connector_in: endpoint {
> +                               remote-endpoint = <&mdss_edp_out>;
> +                       };
> +               };
> +       };
> +
>         reserved-memory {
>                 xbl_mem: xbl@80700000 {
>                         reg = <0x0 0x80700000 0x0 0x100000>;
> @@ -471,6 +485,25 @@ &gcc {
>                            <GCC_WPSS_RSCP_CLK>;
>  };
>
> +&mdss {
> +       status = "okay";
> +};
> +
> +&mdss_edp {
> +       status = "okay";
> +};
> +
> +&mdss_edp_out {
> +       data-lanes = <0 1 2 3>;
> +       link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
> +
> +       remote-endpoint = <&dp_connector_in>;
> +};
> +
> +&mdss_edp_phy {
> +       status = "okay";
> +};
> +
>  &qupv3_id_0 {
>         status = "okay";
>  };
> @@ -511,3 +544,10 @@ &usb_1_qmpphy {
>  &wifi {
>         memory-region = <&wlan_fw_mem>;
>  };
> +
> +/* PINCTRL - ADDITIONS TO NODES IN PARENT DEVICE TREE FILES */
> +
> +&edp_hot_plug_det {
> +       function = "gpio";
> +       bias-disable;
> +};
>
> --
> 2.25.1
>


-- 
With best wishes
Dmitry

