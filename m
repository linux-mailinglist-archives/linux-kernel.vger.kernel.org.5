Return-Path: <linux-kernel+bounces-6989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA4881A03A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8266E2813B3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEA8374F0;
	Wed, 20 Dec 2023 13:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="YG3rbgzw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3843716B
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 13:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3E6173F56B
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 13:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1703080107;
	bh=cLKk4FLFKZPRJCthkwAAXukNGNTHJtGoc9bArlIgi7E=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=YG3rbgzw2i1ydgEjZbvw0fg40ZB5odgx/Zixb7MyGGzNU948eIEF3pC9LBDmk+h7P
	 95wW8CkQRN2niRugjrT9UCmYcjbLfvpC5yQKyg23Qdey4WB9L8qvColruuelfQVaVw
	 bAftbul4TiYfx7ZaMCWWGMx1v1JARYmrypA8i0/6V5GjthULwYI6saXcqQTw9Het37
	 ntqIhh+Pe5kdDDIseZMYyswpak8AdNuBNGBMdN3GHQ7V6gHb0b+6KvMuZPY29cd8Qa
	 y+6JiXFQujZrWCzTH1koZ6D3f75vVPjec5RWn4cklZhSFcZlFkro0L8MXc1maiQi7g
	 Q6TRZpBC/CSAA==
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-5cf4696e202so77146057b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 05:48:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703080106; x=1703684906;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cLKk4FLFKZPRJCthkwAAXukNGNTHJtGoc9bArlIgi7E=;
        b=ONLDg01emmdRtRp3eiNf6+x4Iavvu3MuNTHyaU7udzH2/7hMCXpNa1r5G68c09AyvN
         GVrQ6FDUQdmzvXtI47gQ5knZnbf7Yj9NDB9R2VAmNnWAAPVEIiCYjthTU6ZC/ZPM+ADT
         QO0OSPvTN3/3TMljSVibNdK+8q/kw5UjdKcpYEPGmmIIRKsHOUH3qOYFEfwriDoPpAfL
         m0whfzREiX7l6uLi6cp6uJ/kLx5q5/7RWx/Y1rxNoyAoQ19MN+JMIIB8+sd1y79xi/4B
         W50LrvkgWQHIPNNZDyWKkVd2yQraLP1NSz6xMB8TI3tHcLzbsYP7UjR20Q/kyyfRNS3l
         6XqQ==
X-Gm-Message-State: AOJu0YxeT7YL084KH0c5+qjGMfWoWuhECIbvWFBghCk4nsTLvy0tFz6J
	iJtIZjLcXGphy6aa87G7IB29yeeT1dGaWbxvpqTW2b8vQBvW9sg0/y/2CSr1DX5SH7dcyA5MOZN
	8ekXg8Nm3wpBCGXa6VK6xoIYsITNoTGJ9/cjg7fg/y/iIoZaTWf2r3RFx6A==
X-Received: by 2002:a25:903:0:b0:dbc:dbc2:16bd with SMTP id 3-20020a250903000000b00dbcdbc216bdmr7636393ybj.62.1703080105361;
        Wed, 20 Dec 2023 05:48:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAc0XaKPCbNpSMKwITz2F/kdmz4jNbuavgxZb/kvZBD55MIEy+1R3WMm9C61a7/L2w9ih86rzWOb3+xyezKOI=
X-Received: by 2002:a25:903:0:b0:dbc:dbc2:16bd with SMTP id
 3-20020a250903000000b00dbcdbc216bdmr7636383ybj.62.1703080105113; Wed, 20 Dec
 2023 05:48:25 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 20 Dec 2023 05:48:24 -0800
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20231220004638.2463643-5-cristian.ciocaltea@collabora.com>
References: <20231220004638.2463643-1-cristian.ciocaltea@collabora.com> <20231220004638.2463643-5-cristian.ciocaltea@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Wed, 20 Dec 2023 05:48:24 -0800
Message-ID: <CAJM55Z-+2RY+owdd9YJM_CihKqDtAgykSDZN0tLZAGRTRGQhBA@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] riscv: dts: starfive: beaglev-starlight: Setup phy
 reset gpio
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
> The BeagleV Starlight SBC uses a Microchip KSZ9031RNXCA PHY supporting
> RGMII-ID which doesn't require any particular setup, other than defining
> a reset gpio, as opposed to VisionFive V1 for which the RX internal
> delay had to be adjusted.
>
> Co-developed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  .../boot/dts/starfive/jh7100-beaglev-starlight.dts    | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dts b/arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dts
> index 7cda3a89020a..b79426935bfd 100644
> --- a/arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dts
> +++ b/arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dts
> @@ -11,3 +11,14 @@ / {
>  	model = "BeagleV Starlight Beta";
>  	compatible = "beagle,beaglev-starlight-jh7100-r0", "starfive,jh7100";
>  };
> +
> +&mdio {
> +	phy: ethernet-phy@7 {
> +		reg = <7>;
> +		reset-gpios = <&gpio 63 GPIO_ACTIVE_LOW>;
> +	};
> +};
> +
> +&gmac {
> +	phy-handle = <&phy>;
> +};

..and here.

