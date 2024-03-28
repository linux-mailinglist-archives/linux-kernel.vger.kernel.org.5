Return-Path: <linux-kernel+bounces-122431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 133D388F759
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 06:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 429F31C2651E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 05:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CFB48CFC;
	Thu, 28 Mar 2024 05:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AR4OYyaz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBB53FBA7;
	Thu, 28 Mar 2024 05:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711604356; cv=none; b=WKeAoMDuKl8R4P4yJialjLEIvc8POg4GbJ12zClhf+a395HDkOnKAsfvMjtF0TWd/WY+dAHvq3QFjKH3Hdj7347/HOduKdpCJejOmE6h+nONccWmPKF5377bAe+RmwRhN89X5nRlGQiFKRtNBl/yisAuYxuEBfVAd79x2hNII1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711604356; c=relaxed/simple;
	bh=1TbVjwG6FjPG/Z+RHTuE5W+27StHygVuGEX2BEaRZIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kNg0CmXVLoRshmWs2HW0vVK3SnAnjwreftxKQX0GS8rmGnKeniE5c8QjCiuJGV7/aTe2HwWkzCuBcREkMhcF13z0yWVSYPmJ/yh36oh1jVUruyqW5XeQzD7gvhiDBBHCcUzPHt1yeUuznHgt7sT1YSFQbOWpbGl8iSkRCPFbwvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AR4OYyaz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AF8EC433B2;
	Thu, 28 Mar 2024 05:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711604356;
	bh=1TbVjwG6FjPG/Z+RHTuE5W+27StHygVuGEX2BEaRZIQ=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=AR4OYyazeXF+nobr/ZHjH1xHqId0IihH3wDnZu58NmTUN8qUbZnULVfxduNtn4RNj
	 A+QXAVhj/cxydxEEOjGVMngiqE5wUxh4YSnl+qj226koCR9aiVKhc+VLYBTLPk/GXw
	 KnUt0bG/hba5VuK9cMKjdjmHpQxlwCmzYmS80xv34YeNcyhEjSabxXsJcT6f5gQV7d
	 BoG9LB1TAYMZlQcFmUqPbgT6tTBPcxLFcYvTkLaAHV9/ftuCxQMTesUWOvksfqFJBp
	 ce/J8F6NlhI4h4pXNGDWZ3NCCsTp6bSwJyOI6i+avQsPeBEgrmEGR0lwPHQRrEHsls
	 3Zk6jxRbtYXVw==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d46dd5f222so7451341fa.1;
        Wed, 27 Mar 2024 22:39:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXw9B30hY6hDzShBkN9Usiyjm1fk/D0knLeB+M4oEjExManYscmxyw3YuSxHd55L6HFB6f87Y4Gptyf0L4RvnATwsco2x8pUII763BBMbQMXgorFXAp0WBAZhOGYZIngTsEuACwb02H9w==
X-Gm-Message-State: AOJu0YxaKqyhxvI1nw9yCkG1J0qXtYWtQ1NnbjY3yCXTS+MWsKgsXqK7
	kmFVYnc2kd5oGU9myIDlShKIsjG/F2v+AbPvAW8Dmg/hFmW2Xl4M+zK23sQ6KvxxGgFamNHgvBg
	KEpcSrIgdQ2jPOrOH6hSkljooBtM=
X-Google-Smtp-Source: AGHT+IHNSdF8hndCSvCQ2ourQ5vvSJzuTkZn1875zvnJtAV/TEo1f+17uBEMHEz4TNCvw6DWTrnRTDW1SKXSjV/JKIY=
X-Received: by 2002:a2e:9d96:0:b0:2d4:7a3:67a7 with SMTP id
 c22-20020a2e9d96000000b002d407a367a7mr1272069ljj.22.1711604354573; Wed, 27
 Mar 2024 22:39:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327192641.14220-1-dev@folker-schwesinger.de> <20240327192641.14220-2-dev@folker-schwesinger.de>
In-Reply-To: <20240327192641.14220-2-dev@folker-schwesinger.de>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Thu, 28 Mar 2024 13:39:02 +0800
X-Gmail-Original-Message-ID: <CAGb2v64cF2fuW7vKq_=AhY+ciAp8t=fxT23AFJWB1qOv1xWuNw@mail.gmail.com>
Message-ID: <CAGb2v64cF2fuW7vKq_=AhY+ciAp8t=fxT23AFJWB1qOv1xWuNw@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: rockchip: Add enable-strobe-pulldown to
 emmc phy on ROCK Pi 4
To: Folker Schwesinger <dev@folker-schwesinger.de>
Cc: Vinod Koul <vkoul@kernel.org>, Yogesh Hegde <yogi.kernel@gmail.com>, 
	Heiko Stuebner <heiko@sntech.de>, Chris Ruehl <chris.ruehl@gtsys.com.hk>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Dragan Simic <dsimic@manjaro.org>, 
	Christopher Obbard <chris.obbard@collabora.com>, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 4:33=E2=80=AFAM Folker Schwesinger
<dev@folker-schwesinger.de> wrote:
>
> Commit 8b5c2b45b8f0 disabled the internal pull-down for the strobe line
> causing I/O errors in HS400 mode for various eMMC modules.
>
> Enable the internal strobe pull-down for ROCK Pi 4 boards. Also re-enable
> HS400 mode, that was replaced with HS200 mode as a workaround for the
> stability issues in:
> cee572756aa2 ("arm64: dts: rockchip: Disable HS400 for eMMC on ROCK Pi 4"=
).
>
> This was tested on ROCK 4SE and ROCK Pi 4B+.
>
> Fixes: 8b5c2b45b8f0 ("phy: rockchip: set pulldown for strobe line in dts"=
)
> Signed-off-by: Folker Schwesinger <dev@folker-schwesinger.de>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi b/arch/ar=
m64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
> index 281a12180703..b9d6284bb804 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
> @@ -194,6 +194,7 @@ &cpu_b1 {
>  };
>
>  &emmc_phy {
> +       rockchip,enable-strobe-pulldown;
>         status =3D "okay";
>  };
>
> @@ -648,7 +649,8 @@ &saradc {
>  &sdhci {
>         max-frequency =3D <150000000>;
>         bus-width =3D <8>;
> -       mmc-hs200-1_8v;

Shouldn't this be kept around? The node should list all supported modes,
not just the highest one. Same for the other patch.

ChenYu

> +       mmc-hs400-1_8v;
> +       mmc-hs400-enhanced-strobe;
>         non-removable;
>         status =3D "okay";
>  };
> --
> 2.44.0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

