Return-Path: <linux-kernel+bounces-10690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F1A81D8C9
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 11:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA759282493
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 10:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3A323C3;
	Sun, 24 Dec 2023 10:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Nv0o5wXe"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFCB2105
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 10:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E597C3F593
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 10:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1703415022;
	bh=dRjx8VHHb0t27RVkqdYIaU34XdXmnq6meYjdKYyMtPA=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=Nv0o5wXe+/6CHPZ0yR7/04fuoAY63q8UP3xFEEvaR8giEz/Z6EamC0wAb8CLZcjpU
	 6wyjuIvSAoBUAScW5WnxaK3LtBof2//srbDBF4TsdRTuG2LS1v2lkCKc9k/tmtAz2m
	 cRkOA6K09B1yMcpTHl04tHQ7q/F6hX5bIy1FAMawq1N4uHFRJ2vP4cQ77fQ9suStd7
	 ftp7L1SlzO9xsbg5XZm0Cr6jbXdg5a3sEwPOSXg6x5f6yZaOH3wRSur4ODPz3XHyhY
	 ANtuCglCjtO1cf3DYpyT9PraJU5dQn9jn4diTbrhXweDlhTin3aTQOPCxx9VNvE82p
	 V/4tKE4hZ57iA==
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4278740faedso39889451cf.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 02:50:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703415022; x=1704019822;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dRjx8VHHb0t27RVkqdYIaU34XdXmnq6meYjdKYyMtPA=;
        b=m8EXe323eTseho+F1lyIg8QAV6Ao69FZHzlhtsy4DEO9uK1poZpJPUkCxITcmetUvf
         R3Ov2es7o+tJEwl1W4a2M9o/4DBgnDRpiGtXoXjSBT0lYM/2e0U/OH/GRc/GIM7iAlgV
         1D6W6YVWhAGxUyT1e1u2UKxuYtyglF84Zb4n7ChCubbQlTbsXd6+sTN4sf3Aq9qCNkW9
         ojvV2KGczX5TEzDrAtVAJauGRoiVW8z5IXne8NdNAv+FdwSBe6sIbKF887gve6B3h0XO
         yPiSIVrcmMrWFFgusATgOU2mhJ7fSMVdd6Yr9YHNoNH8EtfW1vsWiK2nem3aY3qhFS5W
         E8gA==
X-Gm-Message-State: AOJu0Yxi2VknHgi85Kt+nfKyQ3AxCn0cpe625i+cdacDsWsSYGPKPRzG
	7yGQ9+kz1odODzwf4XrVTq2s+i4C7vwBlAHCavMgMIWryEoOxSThGR8VbFgkhbV018s+wpatmLG
	wXgIPc2N25Fj5DfaOvsAIObREdMMuf3NdfbOZBt3vegw5/yxyG2tj81Egkl4ynblm
X-Received: by 2002:a05:622a:182:b0:425:76df:7e6f with SMTP id s2-20020a05622a018200b0042576df7e6fmr5609347qtw.119.1703415021914;
        Sun, 24 Dec 2023 02:50:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJ96r2eapvbnKdZyEB77jqFXRuTWzy2bUJJjzd8WXSuigvwDiMsomMEGU5kDYipZ+1aQleLT61MirQghPeNG0=
X-Received: by 2002:a05:622a:182:b0:425:76df:7e6f with SMTP id
 s2-20020a05622a018200b0042576df7e6fmr5609335qtw.119.1703415021493; Sun, 24
 Dec 2023 02:50:21 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 24 Dec 2023 02:50:21 -0800
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20231222094548.54103-5-william.qiu@starfivetech.com>
References: <20231222094548.54103-1-william.qiu@starfivetech.com> <20231222094548.54103-5-william.qiu@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Sun, 24 Dec 2023 02:50:21 -0800
Message-ID: <CAJM55Z8aGviAN0FzEPYtOuV_8q=OvVpNbid195BJTfVMnrA7aA@mail.gmail.com>
Subject: Re: [PATCH v10 4/4] riscv: dts: starfive: jh7110: Add PWM node and
 pins configuration
To: William Qiu <william.qiu@starfivetech.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-pwm@vger.kernel.org
Cc: Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Hal Feng <hal.feng@starfivetech.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Content-Type: text/plain; charset="UTF-8"

William Qiu wrote:
> Add OpenCores PWM controller node and add PWM pins configuration
> on VisionFive 2 board.
>
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>

Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

> ---
>  .../jh7110-starfive-visionfive-2.dtsi         | 22 +++++++++++++++++++
>  arch/riscv/boot/dts/starfive/jh7110.dtsi      |  9 ++++++++
>  2 files changed, 31 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> index b89e9791efa7..e08af8a830ab 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> @@ -323,6 +323,12 @@ reserved-data@600000 {
>  	};
>  };
>
> +&pwm {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pwm_pins>;
> +	status = "okay";
> +};
> +
>  &spi0 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&spi0_pins>;
> @@ -513,6 +519,22 @@ GPOEN_ENABLE,
>  		};
>  	};
>
> +	pwm_pins: pwm-0 {
> +		pwm-pins {
> +			pinmux = <GPIOMUX(46, GPOUT_SYS_PWM_CHANNEL0,
> +					      GPOEN_SYS_PWM0_CHANNEL0,
> +					      GPI_NONE)>,
> +				 <GPIOMUX(59, GPOUT_SYS_PWM_CHANNEL1,
> +					      GPOEN_SYS_PWM0_CHANNEL1,
> +					      GPI_NONE)>;
> +			bias-disable;
> +			drive-strength = <12>;
> +			input-disable;
> +			input-schmitt-disable;
> +			slew-rate = <0>;
> +		};
> +	};
> +
>  	spi0_pins: spi0-0 {
>  		mosi-pins {
>  			pinmux = <GPIOMUX(52, GPOUT_SYS_SPI0_TXD,
> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> index 45213cdf50dc..1b782f2c1395 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> @@ -829,6 +829,15 @@ i2stx1: i2s@120c0000 {
>  			status = "disabled";
>  		};
>
> +		pwm: pwm@120d0000 {
> +			compatible = "starfive,jh7110-pwm", "opencores,pwm-v1";
> +			reg = <0x0 0x120d0000 0x0 0x10000>;
> +			clocks = <&syscrg JH7110_SYSCLK_PWM_APB>;
> +			resets = <&syscrg JH7110_SYSRST_PWM_APB>;
> +			#pwm-cells = <3>;
> +			status = "disabled";
> +		};
> +
>  		sfctemp: temperature-sensor@120e0000 {
>  			compatible = "starfive,jh7110-temp";
>  			reg = <0x0 0x120e0000 0x0 0x10000>;
> --
> 2.34.1
>

