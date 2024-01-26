Return-Path: <linux-kernel+bounces-40634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B9883E370
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 21:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 272371C227F5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 20:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF9B2420B;
	Fri, 26 Jan 2024 20:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mecka.net header.i=@mecka.net header.b="cC5EMOIy"
Received: from mecka.net (mecka.net [159.69.159.214])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA5422EF4;
	Fri, 26 Jan 2024 20:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.159.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706301392; cv=none; b=HC5GGeKW93B4wtsTzMMLsyV7OUrCcr+1iu0wwS+BRwcceljfOGKIWZppqIcAFlrAjU6hGmw7B3NdaaFQj8d2JqGv4tHQVO3I+TJpfqTb3Mmy96uVlYV4iG3REvhRWLGn5pVwNyqP2L8oPZiu0Mev3ytdAa1jvjaxox3dT9XHsIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706301392; c=relaxed/simple;
	bh=bS0tHXldnDP7fP1hTCX/Dobr7gSKMxZIXrqw5AcghSc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fDqV2YXgYDVe7BuvVuzTKwqmwhCVZrZSnPcf903307HLtIvUKVcRwNPlx6Jmd05vvoasP+KUfbYdaZ61seoclFdi1KoskG69eHQZgkI+iZMjD9aVyReeZ3bZ0KF8WlLAjleVvRcjqwFAQlPpnNOignyK+a8umNROoDGQySlRSeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mecka.net; spf=pass smtp.mailfrom=mecka.net; dkim=fail (0-bit key) header.d=mecka.net header.i=@mecka.net header.b=cC5EMOIy reason="key not found in DNS"; arc=none smtp.client-ip=159.69.159.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mecka.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mecka.net
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mecka.net; s=2016.11;
	t=1706301020; bh=bS0tHXldnDP7fP1hTCX/Dobr7gSKMxZIXrqw5AcghSc=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=cC5EMOIy3hGOaPaCp40VoGhD5wRmepADo9Sbans8FHbyxXIaD3Q5dVXYhZfj9eJl/
	 AIoAKjkp9uMqM78/RAeaUZsBJVFREknowDoPzrSCT7/1UB/WmIsOD/QXgxt8cWmWw2
	 Eji+gCm8xZ9MGRSItCu24/ELJUT1shgjLwMGC257hAEA88z2h/NK+DwykNNaPhw+YB
	 f/U5TY4llR8Q0kNJoTVmZ2x8aFzQJ6McVmc8R+BRyy3ppEKx4ESSQ1GZyg0zoTwh9l
	 ZOkeJ8i02kjKcxbBUs/WZMFjA1wADIp/3dmurR5t37ZzVmzeM9aa5ggKUsvSY6Sesf
	 fJnapb/MbfYGw==
Received: from mecka.net (unknown [185.147.11.134])
	by mecka.net (Postfix) with ESMTPSA id B135B3B4E7E;
	Fri, 26 Jan 2024 21:30:19 +0100 (CET)
Date: Fri, 26 Jan 2024 21:30:18 +0100
From: Manuel Traut <manut@mecka.net>
To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>,
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
Message-ID: <ZbQWWp3nmorbEVFl@mecka.net>
References: <20240102-pinetab2-v3-0-cb1aa69f8c30@mecka.net>
 <20240102-pinetab2-v3-4-cb1aa69f8c30@mecka.net>
 <vj3elmkt6czisvwqouv2hhvut2va5jw6bbj5kjyxawvrnrdfwm@tlpo3dp3qcyb>
 <ZZgqF5hLO8UThPep@mecka.net>
 <elumjkchw5m6rcb73l4ouemjgk7nsgkeu576ybbkc5nbvcpiyi@txkepy7wqops>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <elumjkchw5m6rcb73l4ouemjgk7nsgkeu576ybbkc5nbvcpiyi@txkepy7wqops>

Hello Ondřej,

On Fri, Jan 05, 2024 at 05:48:46PM +0100, Ondřej Jirman wrote:
> On Fri, Jan 05, 2024 at 05:11:03PM +0100, Manuel Traut wrote:
> > On Wed, Jan 03, 2024 at 10:42:54AM +0100, Ondřej Jirman wrote:
> > > Hello Manuel,
> > > 
> > > a few more things I noticed:
> > > 
> > > On Tue, Jan 02, 2024 at 05:15:47PM +0100, Manuel Traut wrote:
> > > > From: Alexander Warnecke <awarnecke002@hotmail.com>
> > > > 
> > > > +	leds {
> > > > +		compatible = "gpio-leds";
> > > > +
> > > > +		pinctrl-names = "default";
> > > > +		pinctrl-0 = <&flash_led_en_h>;
> > > > +
> > > > +		led-0 {
> > > > +			gpios = <&gpio4 RK_PA5 GPIO_ACTIVE_HIGH>;
> > > > +			color = <LED_COLOR_ID_WHITE>;
> > > > +			function = LED_FUNCTION_FLASH;
> > > > +		};
> > > 
> > > This LED is supplied by VCC5V_MIDU, so maybe this should be a regulator-led
> > > supplied by gpio (FLASH_LED_EN_H) controlled regulator-fixed named f_led which
> > > is in turn supplied by VCC5V_MIDU.
> > > 
> > > https://megous.com/dl/tmp/9bf0d85d78946b5e.png
> > 
> > regulator-leds are controlled by turning on or off the regulator. However
> > VCC5V_MIDU is also used by other devices (USB, HDMI, ..) so I guess this is
> > not what we want. I would keep it as is.
> 
> It's used by the LED. gpio-leds will not ensure it's on when you enable the LED.
> 
> In practice this may only come up if someone tries to save power by unloading
> dwc3 USB driver, when using PT2 outside of the keyboard case. Otherwise
> VCC5V_MIDU will be enabled by DWC3 driver's use of PHY API.
> 
> In any case, I'm not saying you should use VCC5V_MIDU directly in regulator-led,
> but as a vin-supply to a new regulator-fixed node (which would be describing
> this "fixed voltage regulator" https://megous.com/dl/tmp/cc65ec81ab9af163.png ).

Sorry for the late response, I was busy with other things in the last weeks.

I changed it to be a regulator led and will post a v4 soon.

