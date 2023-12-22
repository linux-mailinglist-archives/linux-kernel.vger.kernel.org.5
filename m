Return-Path: <linux-kernel+bounces-9983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B710081CE20
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 18:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 724E228A176
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7EE32C1B6;
	Fri, 22 Dec 2023 17:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHp4XkA8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03502C1A6;
	Fri, 22 Dec 2023 17:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a2696852965so532968566b.0;
        Fri, 22 Dec 2023 09:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703267494; x=1703872294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g5PzFyYcX86yCLXNKDOjJWI+21oWYWqgqfLfuKAPKRg=;
        b=AHp4XkA8YvkzxWn/+lgU3ipxYjaq0bFxUmQQ5KGu+iXQeX+PNw7/l+T9uMmPJXP/yQ
         3OWpD0RArabhzXFOkiJDSIK1HOd83LMFZSMBhYvr3/w0zODt1CbNgV+aLy6jVPQixWF6
         acGWFzx5NroYf4aoCWI/by2xuvOKW/NyMlYVgCITxIFsxceouzXtUBArYQNvXPGxFj7z
         KmwtUO9IYxSdhs7bK3S6L8AmVh2NJTFy21NA0ca9RTxUg9TbMHvJEx7MlXxxHMA99LdR
         iZdic2Wf1k8HO+cNzzKliM5+IRDc2RK7S6o0x80VZxH6wPfkzzQcbiDc+SCJYbFq8RAE
         nGTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703267494; x=1703872294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g5PzFyYcX86yCLXNKDOjJWI+21oWYWqgqfLfuKAPKRg=;
        b=TrBvJvfO2/+FvGFO2618Er9aTLSYYWEbjpny7eQEm0F26pNO87fr7oKfK4eAofxi3y
         jLwJvzwOXlUnP8u/VaHr/PEhUkGbg9yjkVHVpqSvnOW1YjP/KR2yThQWPzjREWyeXG1L
         zX3OyPKg1Mv9GQtS8DsD5BbjNnG4RBJgBd8VaQU7HTc8nbEW8UcENv5bCxk4CCtbSRz+
         ugT4s+L30dVIUerc+usDfmCF6iyaIIQICN62z8H99ShuzREzd4Gx3wMJBccHzzYq5Mql
         GCZ+4R+DDDrkZ4VftCJQE7v+1GIlo5ubFUw4BlxHCjp6TrVp3Pg9z5WdzzsLZX6Gqf1A
         7PmQ==
X-Gm-Message-State: AOJu0Yz9jElpCfE5eP6KfWM8V6vcHorq3QZZgNG2o8wqh+P4vmcQMTtS
	cqlW/wY36XuCfTmVY2qT10s=
X-Google-Smtp-Source: AGHT+IEmmfJDl8r9eainIjCEsYgu5V4LJQxCLxpqL7aCrNTs+kDc9ivnEx+x6SbJCwhPn1EFWFUnwQ==
X-Received: by 2002:a17:906:4ed6:b0:a26:c590:1b4e with SMTP id i22-20020a1709064ed600b00a26c5901b4emr1013585ejv.36.1703267493630;
        Fri, 22 Dec 2023 09:51:33 -0800 (PST)
Received: from jernej-laptop.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id v27-20020a17090610db00b00a2689e28445sm2225366ejv.106.2023.12.22.09.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 09:51:32 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Alexandre TORGUE <alexandre.torgue@st.com>,
 Enric Balletbo i Serra <eballetbo@gmail.com>,
 Baruch Siach <baruch@tkos.co.il>, Paul Barker <paul.barker@sancloud.com>,
 fuyao <fuyao1697@cyg.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] ARM: dts: sun8i: r40: open the regulator aldo1
Date: Fri, 22 Dec 2023 18:51:30 +0100
Message-ID: <9259140.rMLUfLXkoz@jernej-laptop>
In-Reply-To: <ZYKjYypuAx7gNuam@debian.cyg>
References: <ZYKjYypuAx7gNuam@debian.cyg>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Dne sreda, 20. december 2023 ob 09:18:43 CET je fuyao napisal(a):
> the aldo1 is connect regulator pin which power the TV.
> The USB core use TV ref as reference Voltage.
> 
> Signed-off-by: fuyao <fuyao1697@cyg.com>

Subject line must have board name in it. Please also update message
as it's unclear.

Best regards,
Jernej

> ---
>  arch/arm/boot/dts/allwinner/sun8i-r40-feta40i.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/allwinner/sun8i-r40-feta40i.dtsi b/arch/arm/boot/dts/allwinner/sun8i-r40-feta40i.dtsi
> index 9f39b5a2bb35..8906170461df 100644
> --- a/arch/arm/boot/dts/allwinner/sun8i-r40-feta40i.dtsi
> +++ b/arch/arm/boot/dts/allwinner/sun8i-r40-feta40i.dtsi
> @@ -42,6 +42,13 @@ &pio {
>  	vcc-pg-supply = <&reg_dldo1>;
>  };
>  
> +&reg_aldo1 {
> +	regulator-always-on;
> +	regulator-min-microvolt = <3300000>;
> +	regulator-max-microvolt = <3300000>;
> +	regulator-name = "vcc-aldo1";
> +};
> +
>  &reg_aldo2 {
>  	regulator-always-on;
>  	regulator-min-microvolt = <1800000>;
> 





