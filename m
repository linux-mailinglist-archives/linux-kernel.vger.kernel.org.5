Return-Path: <linux-kernel+bounces-30621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EF983221C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 00:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 634251C2340E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 23:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FE11DFC1;
	Thu, 18 Jan 2024 23:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nk6aAywy"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FE91DA47;
	Thu, 18 Jan 2024 23:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705618998; cv=none; b=cXnj2+Ei4GNJjOOwuEWs9aM38OTZ0il03rvOeWJQPS1KO6ixORRsDIhFmY0qbK2AY3jxFfAwyujHNAyroqGjTD3aPCGmd3LOkHgZO8anx5EXddPskXU88Yb9Zhm8RZE+7CJK+95cy/e0VYuEroDEYd9CDIuY1EARPFOyFmf8WEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705618998; c=relaxed/simple;
	bh=tDueEf0mYOdG+aCC8zSYpIQRvWAjlO5ZOs1NRXPd51c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hkKytCwIaiGfLFoEQIdH+o/hmbiLqgOHrKI4UP+XUnTUkDvpie7W4Dov3raVOZWmcZf4h6r/OrJkOOgmoE+THEnDMRQbOwhDDm3oJ9cVn+kBkzJ2ZwGNAmjubX/X4wzaK++JVGYLwz2CvmRkJU1Wv3Aa5V3zB3I5l9DWpGfHo4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nk6aAywy; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-427ca22a680so1273731cf.3;
        Thu, 18 Jan 2024 15:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705618995; x=1706223795; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GyY99aUjw/FofKAReIAGskDK6rAgz6yENKbvjBb0zfs=;
        b=Nk6aAywyDJLwp3NhKit6hd366A2OYO97IMSksDnxYT0zzLCza5oxMx8UbTrDwyCya/
         lF0j+qO1eQpHIjWpQW3ObFjH+LrO7buz67h30QO/SBHsFY0AvEpibsYjuNvSMOGOmLTV
         a1UzyZ6AnrayKsfMxGe/97Yih94ObzseY6KpA27FrZ+A77Mcnj1k/bTC8MBL1YPsgUc/
         vCTZxnaLWeopIIKB7sPK8yscX46cIbvoC9+QKQ2AzGkWO6PqWFvFEiUmVsLtfRmEqY0E
         q0VOAmP9sj1BJ+lC5lbdhrY41xe+qx21vPzhSHVTvi5KYT9InX2vKQApKgt+SwjLsokG
         logw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705618995; x=1706223795;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GyY99aUjw/FofKAReIAGskDK6rAgz6yENKbvjBb0zfs=;
        b=Kd8GBq9qVDF3zNIKMxd6N7nDGhbrBhhPlr7xAuiuS2gcHXbSQZi3gFFb4pBSvCP+Ve
         0G8VFv31NKLr6fx9F/0h+Fw4qOYqb9WtmQbAQpnqZeeIGmmOwch6B7npzNQ5Sgb6vHNE
         Ec0kIBtZMkHl4mLzKOaAUnFUMv5LEgS/lOta1MBB57YfNEo2IPXUh5lQUMrnETsbIMM5
         +bmn8Va2fxyG5f/akXwyAD1MXM9rczUSjQEfaJ5S5lyaSH4MLsLa68Ys6eAuChFxQ0yi
         QcAbMYdvr1vfO2daiNmSciTG5aIdtr72pt4QarodDHpdoIs49kNe5iVYuVh+UiTp1rXd
         0sMg==
X-Gm-Message-State: AOJu0YyY5bJmB2KdwJ6Kn2YjPZNA5xhzVYtyjAMuu0zmcMKhQg5jJZzC
	1lgGyo90g5H9Dk2vFvPfqHZqQcZ4T94JUfOLP4m8BWo8K6+Z9nmJ
X-Google-Smtp-Source: AGHT+IEOliJbiyiCQYLSMyfo06XQ48TVJ8jLZHaJ8slgAVZ5eveV12CzJq0tjpTX/BkZeKyYSUcasQ==
X-Received: by 2002:a05:622a:1c10:b0:42a:20ab:da20 with SMTP id bq16-20020a05622a1c1000b0042a20abda20mr1020521qtb.52.1705618995652;
        Thu, 18 Jan 2024 15:03:15 -0800 (PST)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id gc9-20020a05622a59c900b004181138e0c0sm7195712qtb.31.2024.01.18.15.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 15:03:14 -0800 (PST)
Date: Thu, 18 Jan 2024 18:03:12 -0500
From: Trevor Woerner <twoerner@gmail.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: rock-pi-e: fix location of
 snps properties
Message-ID: <20240118230312.GB14779@localhost>
References: <20240116204103.29318-1-twoerner@gmail.com>
 <20240116204103.29318-2-twoerner@gmail.com>
 <CAGb2v67KfNR_U_Qz85aqY1D0DKE9mo-X_L8MGvT7cdcZGUHVUg@mail.gmail.com>
 <20240117054705.GA33225@localhost>
 <852071ad-24e8-40a8-9b10-623abf1dc4bf@kwiboo.se>
 <df78489b-7546-46ea-b09f-39a80692a962@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <df78489b-7546-46ea-b09f-39a80692a962@kwiboo.se>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu 2024-01-18 @ 08:31:30 AM, Jonas Karlman wrote:
> On 2024-01-17 09:15, Jonas Karlman wrote:
> > On 2024-01-17 06:47, Trevor Woerner wrote:
> >> On Wed 2024-01-17 @ 12:38:39 PM, Chen-Yu Tsai wrote:
> >>> On Wed, Jan 17, 2024 at 4:41 AM Trevor Woerner <twoerner@gmail.com> wrote:
> >>>>
> >>>> A number of snps (Synopsys) properties are not in their correct location.
> >>>
> >>> Nope. If you read the snps,dwmac.yaml binding file, you'll see that these
> >>> properties have been deprecated. They are properties pertaining to the PHY
> >>> and should be described under the PHY node. Support for reset GPIOs on PHY
> >>> devices in phylib has been there since v4.16. The snps prefixed properties
> >>> were deprecated in v5.3.
> >>
> >> If that's the case, then the bindings and the drivers are out of sync in both
> >> U-Boot and Linux. I discovered this issue while working with older and newer
> >> revisions of the rock-pi-e board. The first three spins of the rock-pi-e have
> >> the rtl8211e PHY but the last one (v1.21) has the rtl8211f PHY.
> >>
> >> With the existing layout nothing works in U-Boot and in Linux the rtl8211e
> >> works but not the rtl8211f. With this patch both the rtl8211e and the rtl8211f
> >> PHYs work using the exact same device trees on both older and newer rock-pi-e
> >> boards in both U-Boot and Linux.
> > 
> > For linux this is probably related to the same chicken-and-egg reset
> > issue outlined at [1]. The phy is not reset before it is probed and
> > cannot be probed because it is not reset.
> > 
> > As for U-Boot the designware/gmac_rockchip ethernet driver may need some
> > adjustments to properly integrate with eth-phy uclass to properly reset
> > the phy described in a ethernet-phy node before it can be probed.
> > 
> > Following config options is disabled for rock-pi-e-rk3328 defconfig:
> > 
> > # CONFIG_DM_ETH_PHY is not set
> > # CONFIG_PHY_REALTEK is not set
> > 
> > Also the driver needs to be updated to make use eth-phy uclass for it to
> > work correctly. More similar to how the dwc_eth_qos driver works related
> > to ethernet phy.
> 
> I have just sent out a U-Boot series that fix ethernet on the v1.21
> revision of the ROCK Pi E board, see [2].

Thank you! I have tested your patches both in U-Boot and Linux and they work
perfectly.

> Would expect that ethernet also starts to work in linux with those
> patches applied to U-Boot. I only tested and verified ethernet in U-Boot.
> 
> Hopefully someone can take a closer look at the issue on linux side
> so that it does not need to depend on PHY being reset by the bootloader.

Yes, as you suspected this is exactly what happened: providing a fix in U-Boot
caused everything to work again in Linux. It would appear as though Linux is
expecting the PHY to be reset/setup/configured by the bootloader in the case
of this board/SoC/PHY.

> [2] https://lore.kernel.org/u-boot/20240118071949.927089-1-jonas@kwiboo.se/T/
> 
> Regards,
> Jonas
> 
> > 
> > [1] https://lore.kernel.org/linux-rockchip/47d55aca-bee6-810f-379f-9431649fefa6@kwiboo.se/
> > 
> > Regards,
> > Jonas
> > 
> >>
> >> Comparing the rock-pi-e's dts file with the one from the roc-rk3328-cc board,
> >> which also uses the layout in this patch, and which also uses the rtl8211e
> >> external PHY, is what led me in this direction.
> >>
> >>>
> >>> ChenYu
> >>>
> >>>> Fixes: b918e81f2145 ("arm64: dts: rockchip: rk3328: Add Radxa ROCK Pi E")
> >>>> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> >>>> ---
> >>>>  arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts | 10 +++++-----
> >>>>  1 file changed, 5 insertions(+), 5 deletions(-)
> >>>>
> >>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts
> >>>> index 096cfa19036e..0739b8fec86e 100644
> >>>> --- a/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts
> >>>> +++ b/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts
> >>>> @@ -150,8 +150,11 @@ &gmac2io {
> >>>>         phy-mode = "rgmii";
> >>>>         phy-supply = <&vcc_io>;
> >>>>         pinctrl-names = "default";
> >>>> -       pinctrl-0 = <&rgmiim1_pins>;
> >>>> +       pinctrl-0 = <&rgmiim1_pins>, <&eth_phy_reset_pin>;
> >>>>         snps,aal;
> >>>> +       snps,reset-gpio = <&gpio1 RK_PC2 GPIO_ACTIVE_LOW>;
> >>>> +       snps,reset-active-low;
> >>>> +       snps,reset-delays-us = <0 10000 50000>;
> >>>>         snps,rxpbl = <0x4>;
> >>>>         snps,txpbl = <0x4>;
> >>>>         tx_delay = <0x26>;
> >>>> @@ -165,13 +168,10 @@ mdio {
> >>>>
> >>>>                 rtl8211: ethernet-phy@1 {
> >>>>                         reg = <1>;
> >>>> -                       pinctrl-0 = <&eth_phy_int_pin>, <&eth_phy_reset_pin>;
> >>>> +                       pinctrl-0 = <&eth_phy_int_pin>;
> >>>>                         pinctrl-names = "default";
> >>>>                         interrupt-parent = <&gpio1>;
> >>>>                         interrupts = <24 IRQ_TYPE_LEVEL_LOW>;
> >>>> -                       reset-assert-us = <10000>;
> >>>> -                       reset-deassert-us = <50000>;
> >>>> -                       reset-gpios = <&gpio1 RK_PC2 GPIO_ACTIVE_LOW>;
> >>>>                 };
> >>>>         };
> >>>>  };
> >>>> --
> >>>> 2.43.0.76.g1a87c842ece3
> >>>>
> 

