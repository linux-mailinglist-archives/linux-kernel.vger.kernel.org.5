Return-Path: <linux-kernel+bounces-14851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6130822330
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 22:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E9D1B20B68
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 21:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0E7168AD;
	Tue,  2 Jan 2024 21:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="Fi02OVej"
X-Original-To: linux-kernel@vger.kernel.org
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7B816439;
	Tue,  2 Jan 2024 21:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1704230330; bh=NkgNNWrU5A+qrlyuoridyMA0T+gww6nA9Sf4hu63gmI=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
	b=Fi02OVej7qHAlyYnp+pT6vaLbwXZjF/w4bjtOyReDOlrriSZqpWmfDA2KgpkXwriC
	 L8prIzUKpNvdjwZg3bEywTq+VGwN3nVUNanL4DcEnx9xMHrMCbuzzRo8NkpTxFhUJw
	 GglC0TZWR+N0WyOOckCsdRESaRUwgzH1WTQZLBbg=
Date: Tue, 2 Jan 2024 22:18:48 +0100
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Manuel Traut <manut@mecka.net>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Sandy Huang <hjc@rock-chips.com>, Mark Yao <markyao0591@gmail.com>, 
	Diederik de Haas <didi.debian@cknow.org>, Segfault <awarnecke002@hotmail.com>, 
	Arnaud Ferraris <aferraris@debian.org>, Danct12 <danct12@riseup.net>, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3 4/4] arm64: dts: rockchip: Add devicetree for Pine64
 PineTab2
Message-ID: <qwndrkppuctp2mybnibbf6fppp6abzimqs4hirrwjauig34why@gawjwsbauffm>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	Jonas Karlman <jonas@kwiboo.se>, Manuel Traut <manut@mecka.net>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Sandy Huang <hjc@rock-chips.com>, Mark Yao <markyao0591@gmail.com>, 
	Diederik de Haas <didi.debian@cknow.org>, Segfault <awarnecke002@hotmail.com>, 
	Arnaud Ferraris <aferraris@debian.org>, Danct12 <danct12@riseup.net>, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20240102-pinetab2-v3-0-cb1aa69f8c30@mecka.net>
 <20240102-pinetab2-v3-4-cb1aa69f8c30@mecka.net>
 <775vjfucu2g2s6zzeutj7f7tapx3q2geccpxvv4ppcms4hxbq7@cbrdmlu2ryzp>
 <903e9d0c-a00c-4214-9f0e-dd676b13b428@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <903e9d0c-a00c-4214-9f0e-dd676b13b428@kwiboo.se>

On Tue, Jan 02, 2024 at 09:56:20PM +0100, Jonas Karlman wrote:
> Hi Manuel and Ondřej,
> 
> On 2024-01-02 19:07, Ondřej Jirman wrote:
> > Hello Manuel,
> 
> [...]
> 
> >> +
> >> +&sfc {
> >> +	pinctrl-names = "default";
> >> +	pinctrl-0 = <&fspi_dual_io_pins>;
> >> +	status = "okay";
> >> +	#address-cells = <1>;
> >> +	#size-cells = <0>;
> >> +
> >> +	flash@0 {
> >> +		compatible = "jedec,spi-nor";
> >> +		reg = <0>;
> >> +		spi-max-frequency = <24000000>;
> > 
> > That's a bit on the low side. The flash chip should work for all commands up to
> > 80MHz https://megous.com/dl/tmp/b428ad9b85ac4633.png and SGM3157YC6 switch
> > for the FSPI-CLK should have high enough bandwidth, too.
> 
> I agree that this is a little bit on the low side, it was a safe rate
> that I used for U-Boot. U-Boot required an exact rate of the supported
> sfc clk rates: 24, 50, 75, 100, 125 or 150 MHz.
> 
> Please also note that the SPI NOR flash chip used in PineTab2 is not a
> GigaDevice GD25LQ128E, it should be a SiliconKaiser SK25LP128, same as
> found in the Pine64 PinePhone Pro.

According to this http://en.siliconkaiser.com/pro/  it should maybe go up to
133MHz. No idea what's the difference between LP vs LE variant. So it may work
with 100 MHz.

On Pinephone Pro variants with nerfed SPI CLK signal integrity (any variant with
RE instead of a RESET button - so all production batches), anything above 10 MHz
has real trouble working. But this should not be the case here with PT2, looking
at the schematic...

Anyway, it's a nice to have.

> > 
> >> +		spi-rx-bus-width = <2>;
> > 
> > GD25LQ128E supports quad I/O. Maybe try 4 if it will work.
> 
> The schematic only shows fspi D0 and D1 connected, and use the D2 line
> for eMMC_RSTn, so spi-rx-bus-width = <2> should be correct.

Ah, I see.

regards,
	o.

> > 
> >> +		spi-tx-bus-width = <1>;
> >> +	};
> >> +};
> >> +
> 
> Regards,
> Jonas

