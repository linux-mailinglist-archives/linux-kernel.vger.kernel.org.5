Return-Path: <linux-kernel+bounces-21388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B96E7828E79
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 21:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A5C41F218AA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51FD3D96B;
	Tue,  9 Jan 2024 20:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OcmpfsTe"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06C13D57C;
	Tue,  9 Jan 2024 20:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40e4d64a431so12833875e9.0;
        Tue, 09 Jan 2024 12:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704831677; x=1705436477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SV192nZl7wwZqocnDFeUodUzhIyPq553m7hm6fzBgSg=;
        b=OcmpfsTeq4AjxwXO2RX4Ud+gF40byL+Sr5+5HQwwDjs4lXAgkopuOITAun895uOGyF
         B9EFO4ATp45z17GcD5kj2CUyqbGGPq2r+JE3iA5/TxuSCYKgLb42H+W5fX4f9Ll/JmzJ
         hNXmdfT/2yEGaWF0RsNvw+7Ds+aLoMDiqPglIkrtpnM44E/1zMD/Iqug5qXZU5Nlc/Zn
         VpebS7wldrXuLSPatSE9/O7C5bbuRw5+Hijnc+Dp35b4QfHGDUdYWrU+fUknem2IVUOM
         cX14JhNsLMfn+WOOAlCBH+SMyBDQWjbMiGZEEyodFg449dtRBDPh0UgMyiDk1v50/R2S
         6Dpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704831677; x=1705436477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SV192nZl7wwZqocnDFeUodUzhIyPq553m7hm6fzBgSg=;
        b=tDlTQSdar3P3SpzwnVrm/gJuBF5uWLCp93q2fzL7dT1jr0zpirTWGMhU3rAMHHhZB/
         aYnhRK7OsZkIdfcItI2/ErHxsqCpOfRQfOU1LE9dJftkcuwzJd/qZUl7chbzpebCBYWf
         zDiD9DeboXRCSHuOxwTlJZkN+CYlzypcfXr+WxL6fy7Wqf+ve0mzyzLflrmRLz03TZJ7
         Yvua3NwHuWmfd+RiYSi2va559VveoHNSNrSdMZzNOE6DW8WzDYF+1g2Rxk7XpwP0h6Py
         faIKDMD9gsZTuwAzggny/zVHfbwMF2k2BJz22/7mA8HAn4kzWvQm8wf1WLua4MDmyOMU
         n+QQ==
X-Gm-Message-State: AOJu0Yyf1bj6a5PYsmPUY0h+7ICRjS3/2jwMCGzTpS+J4HrHUi012/GH
	HZaA6QKkxonT72iOz8RlLCc=
X-Google-Smtp-Source: AGHT+IHG/BUU9h0G4AHEcZub4AHtt+rBOqTvADVCj3ASiPBNesPC+msk3izuB2XDdqx2MI2K3BGAfg==
X-Received: by 2002:a05:600c:4512:b0:40e:3549:9021 with SMTP id t18-20020a05600c451200b0040e35499021mr3368771wmo.33.1704831677080;
        Tue, 09 Jan 2024 12:21:17 -0800 (PST)
Received: from jernej-laptop.localnet (213-161-3-116.dynamic.telemach.net. [213.161.3.116])
        by smtp.gmail.com with ESMTPSA id f6-20020adfe906000000b0033609584b9dsm3213016wrm.74.2024.01.09.12.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 12:21:16 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Wei Xu <xuwei5@hisilicon.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 =?utf-8?B?6bqm5YGl5bu6?= <maijianzhang@allwinnertech.com>
Subject: Re: [PATCH v2] ARM: dts: sun8i: Open FETA40i-C regulator aldo1
Date: Tue, 09 Jan 2024 21:21:13 +0100
Message-ID: <1780716.VLH7GnMWUR@jernej-laptop>
In-Reply-To: <ZYqRZev1g_mztff2@debian.cyg>
References: <ZYqRZev1g_mztff2@debian.cyg>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Dne torek, 26. december 2023 ob 09:40:05 CET je Fuyao Kashizuku napisal(a):
> The USB PHY in the Allwinner R40 SoC seems to rely on voltage on the
> VCC-TVIN/OUT supply pins for proper operation, on top of its own supply
> voltage on VCC-USB. Without a 3.3V voltage supplied to VCC-TV*, USB
> operation becomes unstable and can result in disconnects.
> 
> The Forlinx FETA40i-C SoM connects both the VCC-TVOUT and VCC-TVIN pins
> to the ALDO1 rail of the PMIC, so we need to enable that rail for USB
> operation. Since there is no supply property in the DT bindings for
> the USB core, we need to always enable the regulator.
> 
> This fixes unstable USB operation on boards using the Forlinx FETA40i-C
> module.
> 
> Signed-off-by: Fuyao Kashizuku <fuyao@sjterm.com>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
> Changes in v2:
>  - Subject include board name.
>  - regulator name changed to vcc-3v3-tv-usb.
>  - explain why we need to enable the regulator.
>  - use full name of the commiter
>  - Link to v1: https://lore.kernel.org/lkml/ZYKjYypuAx7gNuam@debian.cyg/
> 
>  arch/arm/boot/dts/allwinner/sun8i-r40-feta40i.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/allwinner/sun8i-r40-feta40i.dtsi b/arch/arm/boot/dts/allwinner/sun8i-r40-feta40i.dtsi
> index 9f39b5a2bb35..c12361d0317f 100644
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
> +	regulator-name = "vcc-3v3-tv-usb";
> +};
> +
>  &reg_aldo2 {
>  	regulator-always-on;
>  	regulator-min-microvolt = <1800000>;
> 





