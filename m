Return-Path: <linux-kernel+bounces-28519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D600A82FF9B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 05:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A01BB23CFE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 04:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384B363A5;
	Wed, 17 Jan 2024 04:38:55 +0000 (UTC)
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED13733C5;
	Wed, 17 Jan 2024 04:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705466334; cv=none; b=Vk3JBkCZ0jYRms4TzZekGk/FBnxFHatz4degYGrgE79WxenDIqMsg9t4+K0/jeBb7vyUOOFrZH2hz2by6+ItkhC+HAk/795MSUrE1kINWsif71svjlHJTEQbTwP4IvFU0AcZZs98VqH/eBLHc2eMOVTeuFRF0CtYOVkzmgC+cdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705466334; c=relaxed/simple;
	bh=OiO46qZq0Is2mnUaJvP4RWs7zVxEhEoqYSm44EehkgI=;
	h=Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Google-Smtp-Source:X-Received:Received:Received:X-Received:
	 MIME-Version:References:In-Reply-To:Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding; b=kbduiDGIT90Fbj8Fjl7GiuVWL+xZmapV28gkH9zd8/bKP8Ra4kAkyNWtE4uzuga/98bH8oVzQvzo2ITFuCrcLfIOHt4BD8cq9oOnAv5le+gdOTYO0DhdCPAM2STbJZuhXGidC+QWlLIgfuRkzvTzjnwGYSMTEfnJSOrxhyuHaPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5986f790b64so4993210eaf.3;
        Tue, 16 Jan 2024 20:38:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705466332; x=1706071132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xWM2eCTSdv+ykArKWuxIaHFUHWUoGfAR11YwSin65Ss=;
        b=cTY+Nb1v5meKuIqMTveM42v0RdZIRQ9h7zDXu79rJ0wfPNRqBTl2gNRxnZJrq1AHqr
         UtBztrWPvOxAVhL1Eir241mTgt6x2TM2gtSRnTjKYJrkjRUwrhFsTAJI3UFc5uBUI21I
         r87pCgyAY2k5/O9u6XErr8R27Vi/L/sYD43XZUoSDWKFowW0gI2De9YTISOKKhsorvsu
         uXqLIVyW144y7wGo3Z2ZmYoWo8bVXzV+zvuPO2rPKUOQkBILhsndX/9BOzXg82RZbhdX
         dMUfzsilvmyWfkBVONURuod4KfK35tILx/Yh/CX7lbws17w3frRgoIDzyWR4Iyge+kaL
         pqUg==
X-Gm-Message-State: AOJu0YwxMxdFwAGgELtOpMfIDbJfVwGn86BebisfH45WX6Z5f93zGOOn
	2IcEwHzi3/kD+1idFtrkx/0saAtNxj4=
X-Google-Smtp-Source: AGHT+IGHDJ8a8HOSRPJRWP5tFhCevJ9+R7B4pV2bhD5NQFlFC0HV5nuk/DGRxj8bc7OHOrCArlyOYw==
X-Received: by 2002:a4a:1781:0:b0:593:f906:614f with SMTP id 123-20020a4a1781000000b00593f906614fmr4494191ooe.4.1705466331774;
        Tue, 16 Jan 2024 20:38:51 -0800 (PST)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com. [209.85.210.48])
        by smtp.gmail.com with ESMTPSA id b22-20020a4ad896000000b005990885b67esm761937oov.34.2024.01.16.20.38.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 20:38:51 -0800 (PST)
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6dc20b4595bso7172901a34.0;
        Tue, 16 Jan 2024 20:38:51 -0800 (PST)
X-Received: by 2002:a05:6359:29c7:b0:175:9fdb:8345 with SMTP id
 qf7-20020a05635929c700b001759fdb8345mr5167276rwb.10.1705466330959; Tue, 16
 Jan 2024 20:38:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116204103.29318-1-twoerner@gmail.com> <20240116204103.29318-2-twoerner@gmail.com>
In-Reply-To: <20240116204103.29318-2-twoerner@gmail.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Wed, 17 Jan 2024 12:38:39 +0800
X-Gmail-Original-Message-ID: <CAGb2v67KfNR_U_Qz85aqY1D0DKE9mo-X_L8MGvT7cdcZGUHVUg@mail.gmail.com>
Message-ID: <CAGb2v67KfNR_U_Qz85aqY1D0DKE9mo-X_L8MGvT7cdcZGUHVUg@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: rock-pi-e: fix location of snps properties
To: Trevor Woerner <twoerner@gmail.com>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 4:41=E2=80=AFAM Trevor Woerner <twoerner@gmail.com>=
 wrote:
>
> A number of snps (Synopsys) properties are not in their correct location.

Nope. If you read the snps,dwmac.yaml binding file, you'll see that these
properties have been deprecated. They are properties pertaining to the PHY
and should be described under the PHY node. Support for reset GPIOs on PHY
devices in phylib has been there since v4.16. The snps prefixed properties
were deprecated in v5.3.

ChenYu

> Fixes: b918e81f2145 ("arm64: dts: rockchip: rk3328: Add Radxa ROCK Pi E")
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts b/arch/arm=
64/boot/dts/rockchip/rk3328-rock-pi-e.dts
> index 096cfa19036e..0739b8fec86e 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts
> @@ -150,8 +150,11 @@ &gmac2io {
>         phy-mode =3D "rgmii";
>         phy-supply =3D <&vcc_io>;
>         pinctrl-names =3D "default";
> -       pinctrl-0 =3D <&rgmiim1_pins>;
> +       pinctrl-0 =3D <&rgmiim1_pins>, <&eth_phy_reset_pin>;
>         snps,aal;
> +       snps,reset-gpio =3D <&gpio1 RK_PC2 GPIO_ACTIVE_LOW>;
> +       snps,reset-active-low;
> +       snps,reset-delays-us =3D <0 10000 50000>;
>         snps,rxpbl =3D <0x4>;
>         snps,txpbl =3D <0x4>;
>         tx_delay =3D <0x26>;
> @@ -165,13 +168,10 @@ mdio {
>
>                 rtl8211: ethernet-phy@1 {
>                         reg =3D <1>;
> -                       pinctrl-0 =3D <&eth_phy_int_pin>, <&eth_phy_reset=
_pin>;
> +                       pinctrl-0 =3D <&eth_phy_int_pin>;
>                         pinctrl-names =3D "default";
>                         interrupt-parent =3D <&gpio1>;
>                         interrupts =3D <24 IRQ_TYPE_LEVEL_LOW>;
> -                       reset-assert-us =3D <10000>;
> -                       reset-deassert-us =3D <50000>;
> -                       reset-gpios =3D <&gpio1 RK_PC2 GPIO_ACTIVE_LOW>;
>                 };
>         };
>  };
> --
> 2.43.0.76.g1a87c842ece3
>

