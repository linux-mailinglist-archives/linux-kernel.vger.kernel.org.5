Return-Path: <linux-kernel+bounces-41132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C7F83EC4D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 10:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BF83282F04
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 09:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414E91EA8A;
	Sat, 27 Jan 2024 09:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mecka.net header.i=@mecka.net header.b="E5zqKQbg"
Received: from mecka.net (mecka.net [159.69.159.214])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55561E88B;
	Sat, 27 Jan 2024 09:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.159.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706347875; cv=none; b=PCUJPfsZFoMOJ2SJu4ZNLH7JEZJywzoJrbD1jo5e2qruyTSNsKo7PmqQ4KD5eYrknFwCZ7oUwN9nrOOHYE66nCVAXMBEQQvcFf2whWz2bUffEmT1dgTqti2Rslv4jcyBgzUB0wcuIdAaSwF0YK97ifIEv4t6BTZ4uyyNFACu42Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706347875; c=relaxed/simple;
	bh=ZKfXwd9FW0rWdUEIALu0OP8KvDADbdtz+p95WviJSc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fyuioiQsHZA0v4N1ZvbbZdwcSCee5lHRm0Eh1djD5i9vQ99YIu81ymIhUtpEL2EgwxUxLxDm0/KOjV42DKZozZwgfJ+cK7p05AYWAQgH+f3Zi7RBDiFgbnbCn5eHEbZ1ftbtUndMjxaQ7KHHZCqaEKZMp2JV3G4mtbIkyWBXtOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mecka.net; spf=pass smtp.mailfrom=mecka.net; dkim=fail (0-bit key) header.d=mecka.net header.i=@mecka.net header.b=E5zqKQbg reason="key not found in DNS"; arc=none smtp.client-ip=159.69.159.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mecka.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mecka.net
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mecka.net; s=2016.11;
	t=1706347870; bh=ZKfXwd9FW0rWdUEIALu0OP8KvDADbdtz+p95WviJSc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E5zqKQbgtz/Vq1FfeGeVWFW44FAQes1TM4fjycxZbs1PXj/kVBhPZtt8C/MCLa5XM
	 dai1JImK0gvTG3CT70igLp2rBfb57qbRrPLdvZba717th93qWGahfDoSPH4YxzXy3o
	 KFLVR2c/ArebjwwBnqxAOeAtAR7PvYD0LYY6uiOcH8I94rBblNT04Edw8a4onAr+Ui
	 fYBHN55OgbOXxjVOCIvNjCAajRO1CrZrvjnBCMu+xHqEC4DExZ/uHvnMUiudhwP5m+
	 S/9hkxTVl5vu66m9D3t65iwe/mRLoQov1gFs/bJPNdYvl2v6JKRQOKRP4DWuu9e4WG
	 z4X7wSbggV/gw==
Received: from mecka.net (unknown [185.147.11.134])
	by mecka.net (Postfix) with ESMTPSA id A981E3BF3AE;
	Sat, 27 Jan 2024 10:31:09 +0100 (CET)
Date: Sat, 27 Jan 2024 10:31:08 +0100
From: Manuel Traut <manut@mecka.net>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
	Mark Yao <markyao0591@gmail.com>,
	Diederik de Haas <didi.debian@cknow.org>,
	Segfault <awarnecke002@hotmail.com>,
	Arnaud Ferraris <aferraris@debian.org>,
	Danct12 <danct12@riseup.net>, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3 4/4] arm64: dts: rockchip: Add devicetree for Pine64
 PineTab2
Message-ID: <ZbTNXL6s_wQugVC5@mecka.net>
References: <20240102-pinetab2-v3-0-cb1aa69f8c30@mecka.net>
 <20240102-pinetab2-v3-4-cb1aa69f8c30@mecka.net>
 <775vjfucu2g2s6zzeutj7f7tapx3q2geccpxvv4ppcms4hxbq7@cbrdmlu2ryzp>
 <903e9d0c-a00c-4214-9f0e-dd676b13b428@kwiboo.se>
 <ZZVjzwgANJMdHnuo@mecka.net>
 <6efe305c-4ab4-43c1-ab6d-64bdf1d81a2f@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6efe305c-4ab4-43c1-ab6d-64bdf1d81a2f@kwiboo.se>

Hi Jonas,

On Wed, Jan 03, 2024 at 03:19:25PM +0100, Jonas Karlman wrote:
> Hi Manuel,
> 
> On 2024-01-03 14:40, Manuel Traut wrote:
> > Hi Jonas and Ondřej,
> > 
> >>>> +&sfc {
> >>>> +	pinctrl-names = "default";
> >>>> +	pinctrl-0 = <&fspi_dual_io_pins>;
> >>>> +	status = "okay";
> >>>> +	#address-cells = <1>;
> >>>> +	#size-cells = <0>;
> >>>> +
> >>>> +	flash@0 {
> >>>> +		compatible = "jedec,spi-nor";
> >>>> +		reg = <0>;
> >>>> +		spi-max-frequency = <24000000>;
> >>>
> >>> That's a bit on the low side. The flash chip should work for all commands up to
> >>> 80MHz https://megous.com/dl/tmp/b428ad9b85ac4633.png and SGM3157YC6 switch
> >>> for the FSPI-CLK should have high enough bandwidth, too.
> >>
> >> I agree that this is a little bit on the low side, it was a safe rate
> >> that I used for U-Boot. U-Boot required an exact rate of the supported
> >> sfc clk rates: 24, 50, 75, 100, 125 or 150 MHz.
> >>
> >> Please also note that the SPI NOR flash chip used in PineTab2 is not a
> >> GigaDevice GD25LQ128E, it should be a SiliconKaiser SK25LP128, same as
> >> found in the Pine64 PinePhone Pro.
> > 
> > The schematics for v2.0 reference a GD25LQ128EWIGR. I never checked the jedec
> > id. How did you retrieve this information, or is it maybe a difference in v0.1
> > and 2.0?
> 
> This was when working on mainline U-Boot for the PineTab2 (and other
> rk356x devices). See [1] for a pending U-Boot patch that is waiting on a
> proper mainline linux devicetree for the PT2.
> 
> The JEDEC ID is reported as 0x257018 on my v2.0 production unit, and
> does not match the JEDEC ID for GD25LQ128E (0xc86018) referenced in
> the schematics.
> 
> I found that the JEDEC ID 0x257018 was referenced in prior patches
> related to the SK25LP128 SPI NOR flash chip used in Pine64 PinePhone Pro.
> 
> I have only ever tested the 24 MHz rate, but I am expecting that e.g.
> 100 MHz also should work. Will not be able to test on my PT2 until at
> earliest next week.
> 
> [1] https://github.com/Kwiboo/u-boot-rockchip/commit/66562d6eaf2c11a9f97fcdba379d3ceda8aa70ef

I found the time to verify that 100 MHz is also working.
Will include this in v4

Thanks for your help
Manuel

