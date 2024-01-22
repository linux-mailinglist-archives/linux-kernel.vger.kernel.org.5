Return-Path: <linux-kernel+bounces-33018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F346B836347
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9B2E290F8D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007BC383BC;
	Mon, 22 Jan 2024 12:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="PTPR8+Tr"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FBE1C20;
	Mon, 22 Jan 2024 12:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705926776; cv=none; b=kbnYQ2bWG4ziq3bf++mLRJ3HlOCqTMhOj5Y/NRFa3dGddEHCZMAIYjpYIQT9Y51P2BAcKAc4Li6A9gQlvyuNy3gbQFm4S94MShogx24Oni19CFBwFaMkoTcDzrw+bfyKnsNzpcojEFkNwo2HPAWyeYvZaRYQqr2ZJ1q5NEfkTds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705926776; c=relaxed/simple;
	bh=m4yg/uTaxSFSsVGNh/moyXbzRJ66JeZYtZp5y+z2OmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lj1AowVARc3bC5Ikgr24fCL6Qn2ahs4S5VqOVu1osGtQYqoJnygJDNJ+Q1VJSilR17hShIt1JK/+IS+Z3gyRbV3Y85PJg/dHDR6g9soWMqbQa3Kab/pLVSB1xnNkDt5UMR2J4t47MeZFM7PqfKnkG54y+BT9dY5MMi1vnmGfClQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=PTPR8+Tr; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1705926742; x=1706531542; i=wahrenst@gmx.net;
	bh=m4yg/uTaxSFSsVGNh/moyXbzRJ66JeZYtZp5y+z2OmQ=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=PTPR8+TrpMhuxLd3fX+WJU9QjJg/4PnPhEnFgXrfFTZA/O7jEBypK3rIroNNFUlP
	 xuK0oED/0dp5/8nSAeghlwtOV6seKmI9ESb42dmnlDsJ3II9uoPk5ggTDCETptFIT
	 I2lspeXHnvOIifoHDmf1K58HhCzZR7wvcTto0Vk3OobI0eJQn1Rm4RNZHLtsx1Wug
	 mVJ4RGkIAkWWFwXkDwK7zF/oE9kgN1dQzZ7nxxfgIkJWVRrhxyHdDwvzANZcQfLuE
	 JNeE+Uj2Pz+MpeY5OcV/HUyn5CraWXEvRwEVzsaauawYiAdyUAZolvW8rkQmIRwJi
	 bdB25tGOdlrtbcgErg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.167] ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQ5rU-1rnqAX3ke0-00M26S; Mon, 22
 Jan 2024 13:32:21 +0100
Message-ID: <83233559-8c31-4568-a943-8bdb9ca20bdc@gmx.net>
Date: Mon, 22 Jan 2024 13:32:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] dt-bindings: gpio: gpio-vf610: add gpio-line-names
To: Mathieu Othacehe <othacehe@gnu.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 Li Yang <leoyang.li@nxp.com>, Primoz Fiser <primoz.fiser@norik.com>,
 Christoph Stoidner <c.stoidner@phytec.de>, Wadim Egorov <w.egorov@phytec.de>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240122095306.14084-1-othacehe@gnu.org>
 <20240122095306.14084-3-othacehe@gnu.org>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20240122095306.14084-3-othacehe@gnu.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:V6p4+fte5woXIrETEXXt1d44iD0rPrg6HritPpkFjcyrZVeQQtT
 if8ShQfNrShhUKFrD23chAIxUt/4B2URyUKW5LkQ6C6ebJUhowj+WSM81QgAUvJz15plLQr
 ZNe9a0zKBUl0JCYj6+m9rIwVnrpGJH7G71fPecDO2sgUq+wHkbMssZcZzSAPFSRn+2VFUuW
 DwAYN9SC4sYpPrMv1Q8jA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XCv6kFjnUmY=;V93RjjE7MKqQtGGse44zMWh6okp
 tkQrq4OHr6nhBKDy5hqJpqmXFkMFFW0MPkmlx2PtUHVvEZBLIaeKw7HpJtBI5hpQL8QitCkA2
 IOeJGhp9ACGcdPjqvtpSf8uYk3YW8HpE+Bz3mD9PH5ktD/J4sUIOY7oYSJSLz0+REtKjQdfpV
 zk6q6to/xVry9UUXiq1dxyzq/YpYQKwh2ZM7pdmVTyO8fauonwGYrzwk17s7Ohw3JN/XLGfH5
 yYyo49iEV8BAoGEOsQFRG6cQW6HTVPMq8pC0ZXm+KnvemLgtX61QyuLbTLRWexZimmb0FSz//
 qGvfmDzJQC0l/mt65rDv//slz8Q+eJxY4Aevoun3XR7jyuON8+zx7E0EYL2kqp1yFXSgqpxSc
 TIsPPfICEOTGTbKeQ8lEndGUR/UtYuZeBnPLFcn937oa0u9+B5yVrQtIWZUGFfJKmqIh0Kr+S
 4zZOh6w1V5Tq5UZkIXbFgvv0DVtqSW8gJ7yPMQ8xAELWRmjTIu+vuxpCoznDd83rycb8jNx1M
 qQSdB3TcHbpQTDn6810gkvpUWxuJ/YgY6WzW50pxoLv0ETmwe3hjVjdBnPJOy/SM0zAZAPTQL
 Z7sz71jRzYPbhUJiItF+WOoprWl3FMzok2MJuectAQ/0fchHQV3M0dHb9S1ebk9d6a1IvFaft
 kDLkvyejhsWZTxFmyu/C+3SY4ADV/owilYq9Pc7azZacMh+ubEmeu6FkOUVzotjRaPzURtDMr
 x92j6gyO14xiu7C2Axe7/98zek00m1t3UMqSZ4U4ppKmnv5BUAZ8QHO8qsh23M7tWgvuobFuC
 mkyopOSu+mSZp/EbxOsvCl7oxUGdb+Izp9II20CciQuCilXP88aZ3OmpNtnHRbnWYqSmB2FNf
 lO6AZ12sl5/NVQYRbceuiSS6UK/biF/2BIWKZbwU863y1DrIDZN2GI1dYLTsqL8eOUHZTpQZM
 va38KA==

Hi Mathieu,

Am 22.01.24 um 10:53 schrieb Mathieu Othacehe:
> Describe common "gpio-line-names" property to fix dtbs_check warnings
> like:
>
> /home/mathieu/linux/arch/arm64/boot/dts/freescale/imx93-phyboard-segin.d=
tb:
> gpio@43830000: 'gpio-line-names' does not match any of the regexes:
> '^.+-hog(-[0-9]+)?$', 'pinctrl-[0-9]+' from schema $id:
> http://devicetree.org/schemas/gpio/gpio-vf610.yaml#
>
> Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
> ---
>   Documentation/devicetree/bindings/gpio/gpio-vf610.yaml | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml b/Do=
cumentation/devicetree/bindings/gpio/gpio-vf610.yaml
> index a27f92950257..7230ba1a386a 100644
> --- a/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml
> +++ b/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml
> @@ -50,6 +50,7 @@ properties:
>       const: 2
>
>     gpio-controller: true
> +  gpio-line-names: true
thanks for addressing this. Could you please add an extra newline
between gpio-controller and gpio-line-names?
>
>     clocks:
>       items:


