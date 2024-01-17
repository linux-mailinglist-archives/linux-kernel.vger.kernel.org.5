Return-Path: <linux-kernel+bounces-28547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD5B82FFF0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 06:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0C4C288D11
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 05:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD3879DE;
	Wed, 17 Jan 2024 05:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOMF+y+z"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93018EBE;
	Wed, 17 Jan 2024 05:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705470431; cv=none; b=lkxecKhAdfXxMxnfz51haMdnm9YF8zOHTsLb9mnswncSjlKuiSQnF2CvkrPmgV5gbiMYN7S+EQKc1q5mkAC1jBSD7lEI7jnNCmLbTRdMQV7dayprlGbstxcRkjKVwxg1xXbJDRQ29i1Q9BHnmxMcKjnxY5Dr3/v4nyfETfgE16w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705470431; c=relaxed/simple;
	bh=oXA2GTgsVsU2xclKxA77TA8zgEClSSfaeN4f19Ec868=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 User-Agent; b=h8r4hxDlUJGUnPWSsAwBLBbkKUn6A7iAamirRgki53M9emfAZSoPFcXak7AI3lE7sVO9hltj4zFIBeD0n4Fj51s+65IIHPJLPspDkRfHKzXmytHy7U79X8gumlV6Sv4Vf6IZo4583Jj95nAADF9pdeCYwqtf4+eOQfbQXTQNqZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MOMF+y+z; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-42a0f043eb2so2216161cf.0;
        Tue, 16 Jan 2024 21:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705470428; x=1706075228; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NLg+aXsh2F0/DjmYHbFuq7D/rUE0pQFTinmVwgl39Oo=;
        b=MOMF+y+zjRvgS1s9463mdyJshLCwevYOzZmgrl949SSD6POVcEan6WqMZCGMw11sXT
         JJ0dQiJgzB6qvm2TnrEH1lt617Vm3ZMkMVa8WDvKJnOR8Acn3dkcQKwLI+ejvgQTa6B9
         G7H2nZbPU4w254IzHkeAWvfb9FbNhMaVkcX89i+A+aLmGHO/0s3irv++ztT7z/g8SW1P
         fKUSw0D8dctE01HmWgEVmNPF3VOmi+nhqcJRK1L8106bX+bRmzs4cJGnn7dDoB7Q9gUs
         1Tda4U9ueKizbXydLiGOfmsUIta72nfvIMaYMbOaBT0IOtUHIlxGzeP5sDNVahXPzUQr
         UowQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705470428; x=1706075228;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NLg+aXsh2F0/DjmYHbFuq7D/rUE0pQFTinmVwgl39Oo=;
        b=h1iR9faZgmrbnkA8s1r1pwF1O+bF0J6FaFkIHuqX9rVrwfcMQL4apPj9YmDbFh3e6+
         xLQH8AyReZH1Nwfw5J264Cmnp5dCkHS1asHgkJfxWMgikhEwGxb5h9tX2kI5n5wQY1LH
         AET+dFqqq2bgMcushcsDfMC7UexjansBjAfwqTK2tsHznO3v1uw8VQ5q6BKklJi+gQLO
         1zw7i2wYKAyu/VVTuUYuj/Q/XljoGpKL16AeJA3XvB+ypl4Tt4w4KkV1ybGfSCOY/jNf
         FTAwq9WV+c8d81yCeoIMNdYLum87Ftre7OUaI5EKpItF/5DPiy4hfCNxDN09wZqQ9gRB
         AsvQ==
X-Gm-Message-State: AOJu0YyX+g4ir9NTSbrP8N/cgFU6mTsBYfA7m/ZH2DEqFTkGDiaq39wh
	HEFZLd2DPggTcAjtZWMbpJE=
X-Google-Smtp-Source: AGHT+IEJCuMB08dGt2M9bJ+G0jaj2GLb8/ivEHIbJaOnDDZol2LjIsH1lHTGT2BS1iuDR/ZqGx7f3Q==
X-Received: by 2002:a05:622a:44f:b0:429:febc:aca5 with SMTP id o15-20020a05622a044f00b00429febcaca5mr317795qtx.63.1705470428278;
        Tue, 16 Jan 2024 21:47:08 -0800 (PST)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id bx3-20020a05622a090300b004299d262017sm5494807qtb.66.2024.01.16.21.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 21:47:07 -0800 (PST)
Date: Wed, 17 Jan 2024 00:47:05 -0500
From: Trevor Woerner <twoerner@gmail.com>
To: Chen-Yu Tsai <wens@csie.org>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: rock-pi-e: fix location of
 snps properties
Message-ID: <20240117054705.GA33225@localhost>
References: <20240116204103.29318-1-twoerner@gmail.com>
 <20240116204103.29318-2-twoerner@gmail.com>
 <CAGb2v67KfNR_U_Qz85aqY1D0DKE9mo-X_L8MGvT7cdcZGUHVUg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGb2v67KfNR_U_Qz85aqY1D0DKE9mo-X_L8MGvT7cdcZGUHVUg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed 2024-01-17 @ 12:38:39 PM, Chen-Yu Tsai wrote:
> On Wed, Jan 17, 2024 at 4:41 AM Trevor Woerner <twoerner@gmail.com> wrote:
> >
> > A number of snps (Synopsys) properties are not in their correct location.
> 
> Nope. If you read the snps,dwmac.yaml binding file, you'll see that these
> properties have been deprecated. They are properties pertaining to the PHY
> and should be described under the PHY node. Support for reset GPIOs on PHY
> devices in phylib has been there since v4.16. The snps prefixed properties
> were deprecated in v5.3.

If that's the case, then the bindings and the drivers are out of sync in both
U-Boot and Linux. I discovered this issue while working with older and newer
revisions of the rock-pi-e board. The first three spins of the rock-pi-e have
the rtl8211e PHY but the last one (v1.21) has the rtl8211f PHY.

With the existing layout nothing works in U-Boot and in Linux the rtl8211e
works but not the rtl8211f. With this patch both the rtl8211e and the rtl8211f
PHYs work using the exact same device trees on both older and newer rock-pi-e
boards in both U-Boot and Linux.

Comparing the rock-pi-e's dts file with the one from the roc-rk3328-cc board,
which also uses the layout in this patch, and which also uses the rtl8211e
external PHY, is what led me in this direction.

> 
> ChenYu
> 
> > Fixes: b918e81f2145 ("arm64: dts: rockchip: rk3328: Add Radxa ROCK Pi E")
> > Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts
> > index 096cfa19036e..0739b8fec86e 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts
> > +++ b/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts
> > @@ -150,8 +150,11 @@ &gmac2io {
> >         phy-mode = "rgmii";
> >         phy-supply = <&vcc_io>;
> >         pinctrl-names = "default";
> > -       pinctrl-0 = <&rgmiim1_pins>;
> > +       pinctrl-0 = <&rgmiim1_pins>, <&eth_phy_reset_pin>;
> >         snps,aal;
> > +       snps,reset-gpio = <&gpio1 RK_PC2 GPIO_ACTIVE_LOW>;
> > +       snps,reset-active-low;
> > +       snps,reset-delays-us = <0 10000 50000>;
> >         snps,rxpbl = <0x4>;
> >         snps,txpbl = <0x4>;
> >         tx_delay = <0x26>;
> > @@ -165,13 +168,10 @@ mdio {
> >
> >                 rtl8211: ethernet-phy@1 {
> >                         reg = <1>;
> > -                       pinctrl-0 = <&eth_phy_int_pin>, <&eth_phy_reset_pin>;
> > +                       pinctrl-0 = <&eth_phy_int_pin>;
> >                         pinctrl-names = "default";
> >                         interrupt-parent = <&gpio1>;
> >                         interrupts = <24 IRQ_TYPE_LEVEL_LOW>;
> > -                       reset-assert-us = <10000>;
> > -                       reset-deassert-us = <50000>;
> > -                       reset-gpios = <&gpio1 RK_PC2 GPIO_ACTIVE_LOW>;
> >                 };
> >         };
> >  };
> > --
> > 2.43.0.76.g1a87c842ece3
> >

