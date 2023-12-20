Return-Path: <linux-kernel+bounces-6988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A03481A037
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8832B23A3E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370BE381A5;
	Wed, 20 Dec 2023 13:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="v6sb8UKr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01F2381CA
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 13:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2E0173F2C1
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 13:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1703080089;
	bh=Wf8bdqHDddS6qx2uHaD55Uu+LiLQy0d/grCj6aFu9Gk=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=v6sb8UKrkMrX9XqrfNjORAFlrEzG8f9yApgLKydLqLa2LqNVeEc0xSNWXp4aGr8tm
	 RThnzaCJyvWyJ9os4TJ8KvVbXmI7+RrLf11Yb0JkcUiI+rQs9+Xm4CbAAbTJOyoHav
	 KTkqnwYLBBKqsTIJDWlBdmfvsSWTR6keDzRTJdMXESJXG1N8h/VQuhORKmonLOP0kT
	 U7FsMx5PQq1zB1Qqkv0d75OytNxM41IcshkaSq7NXcGtW7TgggxUsgAV87a0gtypWw
	 EzErnDnX9wAqj3FNFJBYvfa3UCTkTKDtVvqogT4WabmLETvLlnWO0AxoPANgrv2OE5
	 Q4B1rTkVnO3Zg==
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6dbad18d6d5so363638a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 05:48:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703080088; x=1703684888;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wf8bdqHDddS6qx2uHaD55Uu+LiLQy0d/grCj6aFu9Gk=;
        b=BsKrSRNBue8XCecFAl3j/5fCH6F+tpUbgtkzvz64EjIyyTocXHr9vK8BV1tylfxhWh
         cJoWKWw+j1X/1LqCF+l95udh40yrn2+eWfa4c561GbP2tQnup5avpGi6X59soeUD3hmn
         9D9tCuJqiTnO4h3qsicmas+Fh6jw7EKrnzay6orGnsUDpi6eqtNJRgKPbUaUDvvH1PEA
         8sZH4L1VAR/0Ua3rhf6mIk0D22X7oiPkbMUvTclScRWbT4/vIzIoKMWRT6zhSv7cihq4
         n+ZoJQqy79gAXWUu60VcXGiPVheQG7mQGMPuBsAepfOkLTvMrCFak7qIE9REE2ccg2Qx
         P75w==
X-Gm-Message-State: AOJu0YwXGmnQutbEDoKe4WXVUfL0H3LRjDyXNdWcJhkpkN213gcpJuAk
	KJkfGlWCvjpwYTT1CIHA+DZg6IOtUGqpSBHXmtpZpD0GkjRvZoNPAb/qxMOzztH0tfIDF1dPUyt
	2fC7/aYfMPaOGbbKGte86zR/qP3AWOr491szcS+hBYcXvrDPCr4hVnrP2mw==
X-Received: by 2002:a05:6830:3446:b0:6db:b23a:b416 with SMTP id b6-20020a056830344600b006dbb23ab416mr98112otu.21.1703080087908;
        Wed, 20 Dec 2023 05:48:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGYA6vAaZ3TBzIgMihk2AMB3yObL8Bh76u3ZiGRAugO4EV1+9YbXqh1VlfLWf1FVtHqBXVwZ+TVgOncMeSajCQ=
X-Received: by 2002:a05:6830:3446:b0:6db:b23a:b416 with SMTP id
 b6-20020a056830344600b006dbb23ab416mr98097otu.21.1703080087626; Wed, 20 Dec
 2023 05:48:07 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 20 Dec 2023 05:48:07 -0800
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20231220004638.2463643-4-cristian.ciocaltea@collabora.com>
References: <20231220004638.2463643-1-cristian.ciocaltea@collabora.com> <20231220004638.2463643-4-cristian.ciocaltea@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Wed, 20 Dec 2023 05:48:07 -0800
Message-ID: <CAJM55Z-CWHs1XMOYLOYQmB8qjZ=a3fhyGv3hJAN7bbbDQdEy0g@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] riscv: dts: starfive: visionfive-v1: Setup
 ethernet phy
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
	Emil Renner Berthing <kernel@esmil.dk>, Conor Dooley <conor@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Richard Cochran <richardcochran@gmail.com>, 
	Andrew Lunn <andrew@lunn.ch>, Jacob Keller <jacob.e.keller@intel.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kernel@collabora.com, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>
Content-Type: text/plain; charset="UTF-8"

Cristian Ciocaltea wrote:
> The StarFive VisionFive V1 SBC uses a Motorcomm YT8521 PHY supporting
> RGMII-ID, but requires manual adjustment of the RX internal delay to
> work properly.
>
> The default RX delay provided by the driver is 1.95 ns, which proves to
> be too high. Applying a 50% reduction seems to mitigate the issue.
>
> Also note this adjustment is not necessary on BeagleV Starlight SBC,
> which uses a Microchip PHY.  Hence, there is no indication of a
> misbehaviour on the GMAC side, but most likely the issue stems from
> the Motorcomm PHY.
>
> While at it, drop the redundant gpio include, which is already provided
> by jh7100-common.dtsi.
>
> Co-developed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  .../jh7100-starfive-visionfive-v1.dts         | 22 ++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/boot/dts/starfive/jh7100-starfive-visionfive-v1.dts b/arch/riscv/boot/dts/starfive/jh7100-starfive-visionfive-v1.dts
> index e82af72f1aaf..4e396f820660 100644
> --- a/arch/riscv/boot/dts/starfive/jh7100-starfive-visionfive-v1.dts
> +++ b/arch/riscv/boot/dts/starfive/jh7100-starfive-visionfive-v1.dts
> @@ -6,7 +6,6 @@
>
>  /dts-v1/;
>  #include "jh7100-common.dtsi"
> -#include <dt-bindings/gpio/gpio.h>
>
>  / {
>  	model = "StarFive VisionFive V1";
> @@ -18,3 +17,24 @@ gpio-restart {
>  		priority = <224>;
>  	};
>  };
> +
> +/*
> + * The board uses a Motorcomm YT8521 PHY supporting RGMII-ID, but requires
> + * manual adjustment of the RX internal delay to work properly.  The default
> + * RX delay provided by the driver (1.95ns) is too high, but applying a 50%
> + * reduction seems to mitigate the issue.
> + *
> + * It is worth noting the adjustment is not necessary on BeagleV Starlight SBC,
> + * which uses a Microchip PHY.  Hence, most likely the Motorcomm PHY is the one
> + * responsible for the misbehaviour, not the GMAC.
> + */
> +&mdio {
> +	phy: ethernet-phy@0 {
> +		reg = <0>;
> +		rx-internal-delay-ps = <900>;
> +	};
> +};
> +
> +&gmac {
> +	phy-handle = <&phy>;
> +};

Alphabetical ordering here, please.

/Emil

