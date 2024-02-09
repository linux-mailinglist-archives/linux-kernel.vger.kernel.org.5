Return-Path: <linux-kernel+bounces-59663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9828284FA0F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1929B2790B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071CC1272D7;
	Fri,  9 Feb 2024 16:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="z2L+VNsn"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18959126F12
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 16:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707497261; cv=none; b=R40RD2PClBDqp2RmeRwlN7eK7e3b+U9dn23eubGpevcE/4oPgfbNDJWtMqrQnc1MuiGI/99bJW3i138A4qQB6AFoh5hEsexGvGufvetw35otK4M2cizavUnm2uD8JooQLobdiCjYvAZIzLzRQtPuxDqPp1WXvMrJ/fckJku1jzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707497261; c=relaxed/simple;
	bh=EHXtj1I/ftcXpEO8P5eZSzW0ZOjuoTciVti/3T08k9Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=jh5HHW3VvjQ94FHZliB0DKg9YN2Q3Q/Ca66XNmO5ac8tomIqv2Xl/dnEWerWapYSrRMdSNqbdxmLx7XQQEXT0xHDGMx3l+1DSdn0unWlKPb4sXUegqJqF98/LPEr73TR5wqmHlON/bclM5Mdp7d/JUnjdflIdsxIi4zMEBT1y2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=z2L+VNsn; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55790581457so1890513a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 08:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1707497256; x=1708102056; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YS2EbtbXUftbNC7P72t+SNTFrO2JWyL4uRnQqEk6u2o=;
        b=z2L+VNsnhCeOiZ+z2OF44qlosMZ50231zmorUxoMm1Tyj+orcgf+eF/KmcltCkBCHz
         kNihexsswhZfEVZ0AwuAeOIg27AB4hz2dm0+cZX2QOFoG7CoGPdJzeEa2pX0CR5AAK2s
         nqJTJTFN0s4klM+8jPU71ydHy1irxWDXcnpFjDQATtNm6Y2TlGDnSDetjfmAV7DLTNOu
         +Ymo6cLTwzQJ6GqhlZHYWowbowRyHR2g/fQp8jYo7MO4JNgEqp+LY+Gz0Ychz+GSx//d
         EFpjun++7KzQs7sRZQXFUkSY/BHcOnxjShUGnW4wHLfO21vUBjrQ/MqSU0GpF0LkomiZ
         I0ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707497256; x=1708102056;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YS2EbtbXUftbNC7P72t+SNTFrO2JWyL4uRnQqEk6u2o=;
        b=AYQkNS+foFTYvvxvssQdmQGORe6JaBi87ouGmN9LaiqCNIjOmu824gRwoytfkdFODk
         aOwTuwNSaMUaY0OBJCncluGb99S4s3rMTc9KrFRD901iQOxYtpWIgYeMV+jPpVNgUitH
         aceXz627FJy8p3GpNjoKYc+QEaEqqRHW2pSpTw71xu5WhXpn+1+6bT81BROM89AtwvuL
         5KEQ3ElIMkkTnkpF1asDhmiukVmDExeKdgnW4xGgtnJ6mQ01cuXuXu2WKeNetM5xILgy
         kKpuS6xBVB0Smj9HIoBuVH8ISEcWiXJ0mrwwKlLjnX4/4/Dj0RrjmbrRhvQ+WyGQejaQ
         WVfw==
X-Forwarded-Encrypted: i=1; AJvYcCUEptmJ50RHpz59yeJ2KUlkRrXdqYqXQVegpyqNpG5kllWB2TAstc94yqDZMZAQpnmPg+Wq54C5TMJbWtu+/PgGwin1AMPh3HbyRlnJ
X-Gm-Message-State: AOJu0YyG5soVQfmQZmFzmz66hQJv5xZuFTrqlc0m4I1Y65n6n04j9gVg
	03cc0UQ6irq/HZthDeUaSZCAgCW1zeRy/WZ102ru+tcojWF5B5VwMbKaTQhmK88=
X-Google-Smtp-Source: AGHT+IFdPmgOHCT/0MFCqCZlYRKA93K1cTA0cR1BinAm0OJqzNzuL19dDB38K/uyJqgnTY5HzgZVnA==
X-Received: by 2002:a17:906:eb4b:b0:a38:1e9c:8268 with SMTP id mc11-20020a170906eb4b00b00a381e9c8268mr1717317ejb.32.1707497256373;
        Fri, 09 Feb 2024 08:47:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW9vtWbpCadcgc7v/uKttpKKPq1Ka3kDrbFVVV1WQ1nUVJebKCAovVxij4CT7oUg06reXmf+oAd1oVn88kvImGMoMz4MjHMQ6scR0v0z4TFh5mwRBWEAGDzPv6s4EuZqDw8wT0GYFdEt+bsflAkU6ZqUU81YQyLuePkblA0jKw4Q7tkt6hHk5MSndlcU430mAB0YZMwQ5OQ3jj/l8ppgsVpZuYL1JOwVggeBvrP/s1XzrVh2mecs+IbTfN+eWWyjgU0ABhVrE0fWxrK24w9VCY5Fqs+cQewKjn+hc1c5fb/RAKSuu4OGuacOWDwXuhwUZsszmSj5n1TH/eSNWd/jM5isRMwdUjVaUdg0uSADCepWPEU98T0QV8=
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id vo5-20020a170907a80500b00a3be3b27d0bsm859880ejc.49.2024.02.09.08.47.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 08:47:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 09 Feb 2024 17:47:35 +0100
Message-Id: <CZ0P9E67Q6AQ.TU3Q2Y8VTWUK@fairphone.com>
To: "Bjorn Andersson" <quic_bjorande@quicinc.com>, "Bjorn Andersson"
 <andersson@kernel.org>, "Konrad Dybcio" <konrad.dybcio@linaro.org>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Taniya Das" <quic_tdas@quicinc.com>
Cc: "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>,
 <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: qcs6490-rb3gen2: Declare GCC clocks
 protected
From: "Luca Weiss" <luca.weiss@fairphone.com>
X-Mailer: aerc 0.15.2
References: <20240209-qcm6490-gcc-protected-clocks-v1-1-bd3487b2e7b1@quicinc.com>
In-Reply-To: <20240209-qcm6490-gcc-protected-clocks-v1-1-bd3487b2e7b1@quicinc.com>

On Fri Feb 9, 2024 at 5:21 PM CET, Bjorn Andersson wrote:
> The SC7180 GCC binding describes clocks which, due to the difference in

SC7180 -> SC7280?

With that fixed:

Reviewed-by: Luca Weiss <luca.weiss@fairphone.com>

> security model, are not accessible on the RB3gen2 - in the same way seen
> on QCM6490.
>
> Mark these clocks as protected, to allow the board to boot.

So the board never was able to boot before this patch?

>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
> I did notice Taniya's patch [1] after writing this patch. I'd prefer to
> merge this minimal set asap, to make the board boot, unless there's a
> strong argument for including those other clocks in the protected list.
>
> [1] https://lore.kernel.org/linux-arm-msm/20240208062836.19767-6-quic_tda=
s@quicinc.com/
> ---
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/bo=
ot/dts/qcom/qcs6490-rb3gen2.dts
> index 8bb7d13d85f6..97b1586f9f19 100644
> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> @@ -413,6 +413,24 @@ vreg_bob_3p296: bob {
>  	};
>  };
> =20
> +&gcc {
> +	protected-clocks =3D <GCC_CFG_NOC_LPASS_CLK>,
> +			   <GCC_EDP_CLKREF_EN>,
> +			   <GCC_MSS_CFG_AHB_CLK>,
> +			   <GCC_MSS_GPLL0_MAIN_DIV_CLK_SRC>,
> +			   <GCC_MSS_OFFLINE_AXI_CLK>,
> +			   <GCC_MSS_Q6SS_BOOT_CLK_SRC>,
> +			   <GCC_MSS_Q6_MEMNOC_AXI_CLK>,
> +			   <GCC_MSS_SNOC_AXI_CLK>,
> +			   <GCC_QSPI_CNOC_PERIPH_AHB_CLK>,
> +			   <GCC_QSPI_CORE_CLK>,
> +			   <GCC_QSPI_CORE_CLK_SRC>,
> +			   <GCC_SEC_CTRL_CLK_SRC>,
> +			   <GCC_WPSS_AHB_BDG_MST_CLK>,
> +			   <GCC_WPSS_AHB_CLK>,
> +			   <GCC_WPSS_RSCP_CLK>;
> +};
> +
>  &qupv3_id_0 {
>  	status =3D "okay";
>  };
>
> ---
> base-commit: b1d3a0e70c3881d2f8cf6692ccf7c2a4fb2d030d
> change-id: 20240209-qcm6490-gcc-protected-clocks-ee5fafdb76b3
>
> Best regards,


