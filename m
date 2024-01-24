Return-Path: <linux-kernel+bounces-36869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E3683A7E8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 251341C22D99
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9029F1AADE;
	Wed, 24 Jan 2024 11:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="YkiNUsek"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5BF1AAB1;
	Wed, 24 Jan 2024 11:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706095960; cv=none; b=eCmN1hv3AurH1GOp8HjYXSVtfEGgEDHLX1fv1vS1eu2z2PldYmbKuLiaMnUxAFpW8F0FIGeDXo++RxkslbEttD7WrO0VBkyEWwKm/LHR+f8/a5/SvtLwQ7fVNWDAEbAWOt5a7eZT+pJWBJBUQGD6qIbgBPwTWxzsPa44kO2Ut7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706095960; c=relaxed/simple;
	bh=/BslgvVYpKPVNWdle14groKEbP1WS7QPlBDCktTNY6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WnlEgb234Ig0Xrkbj9WPd7SxIg1p0Le2AAj3xJOsKra0sfLKxQ/9Vhor/S30dNEWcgvuwktIkc4sCy2vZAMJFGjY0549xpNhcjFLdglQf09kVqmea0zZXJDD9hFjeM4sQ6zMqZB9yF/6k3mdCr6ZAMFwEYbNDzCOfzzfmFORoN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=YkiNUsek; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1706095922; x=1706700722; i=wahrenst@gmx.net;
	bh=/BslgvVYpKPVNWdle14groKEbP1WS7QPlBDCktTNY6s=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=YkiNUsekQHvkiImjKEgoQTqATU0p9x1J4775//i6NN3asbAh6qVZqWcBo2lkeAWX
	 KC+2HMvLKf2URrfxhF6aj8H3r5m+9tj/Q0EYaVWnUwzI/KgpMjs9MAMQkpjx698hh
	 LocwPpcR5s2gTHVaSRTAZg6qJy98bZT7/IdopkBmYu7kKUzTMuXmN/5SJtImzCPpt
	 oQoSIy+YtA4uvk273Hzb/3MFft46IfRBUKXMsiVGfIUOESYhLHOH8A0yRKWomjSF1
	 vq6G44W3QgSesOP7Ws/4Tw/21pWrXZAYzvR7cs1V4K0s/tUdgxbCnYyjYtABN/LIJ
	 ee0cwiSXZ1akKlM+KQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.167] ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MXXuH-1rb0sn2F1L-00Z1nK; Wed, 24
 Jan 2024 12:32:02 +0100
Message-ID: <a37db0e2-4b17-4935-a9a6-f7741e91e42c@gmx.net>
Date: Wed, 24 Jan 2024 12:31:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] dt-bindings: gpio: gpio-vf610: add gpio-line-names
To: Mathieu Othacehe <othacehe@gnu.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 Li Yang <leoyang.li@nxp.com>, Primoz Fiser <primoz.fiser@norik.com>,
 Christoph Stoidner <c.stoidner@phytec.de>, Wadim Egorov <w.egorov@phytec.de>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Conor Dooley <conor.dooley@microchip.com>
References: <20240124074930.26101-1-othacehe@gnu.org>
 <20240124074930.26101-3-othacehe@gnu.org>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20240124074930.26101-3-othacehe@gnu.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:NO507OUp8tLlmKolQz3sc5PuTIxw9mI+LCtA6ydOdiIOAV9YNwi
 c4gKzu5jDGqoPlorHhcbBpB7N7Hf3C6TcBu9XfqREqVOF1naJ4ku7qJChPPakMUmTUvF3Sr
 IuXfBjlnAZiIFcD7Jb4CNh7LQ2sFWgulLLQKekutizycyJNR6FhfXSjxXPQgyHYKShN+37N
 2KcwbXY7ZLwXT4+2kJ/kQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4Gt+aTtZ98s=;SX+2vTwj3CF/hpWVFrcickHZ5Wd
 i6HSYYTbauWG2V4eP2qNAgZzzRDvxMezApKhT/BA5kt8uIhikHGGxRZNR14NtW5NbyUhty8J5
 DdJGQkpqV6VKTj2vr+fZi2bDpQEALY+g1oq/6Ym9YbV8O3taHOvl9LFeBETLNC9b5e/ZcCM8J
 BN8+lr0sUK4Yu7xNyJlCUXBHeGkMzZ9YbX+I7lnypVaExpApgDBQSAsGQ5ehR8T141/viYMLl
 BbK4sPV8THsKwbSikSuPTRupSTmfDYqxQ/tX+TCV4kS3Xto2BGRsTbEayRdJ43kwz4wqyG2Px
 mNzvI4TRoSZ/9X0vjpezhNjcQPepElcjo5kG9RCrTvOwKCRh8M9vMM5XlT1jtgW/JX9/RON7O
 aECe8t9ITFTkSxppZ1zZdjOVGU3YqCMwNc3RXdaLNWcLgQODPXo5III63m5IgKthpRf4/62M3
 xN+JU815radyM7h1J8C7sQx06Z5ExUx71L5GJsBqFw4qhtfnYYWK4f9gGjhV7gYdj30Ax+408
 TiDAbqlQOjXoUkDviT+s2swUYAY0vvlmoD6xWK5PO48CROI5165wyVN2cAlrmdyEAneau16YZ
 sZsw4DjKflt6b7wyscJisE/7puji3lJHs+0PQQYr+oamcmENCmY2Nt/iwO0dLRlA2lP3jq32W
 e9JlTysgSHdzQzy0LkXjmq9amb7TwP4GlLw7iKyXFnMeu0WSl/0lTQc3kenw1+ffUdH1mjXYt
 oxhOn8Q0muJCKZBQb1Hlc1zlasQnHoMcttB3E/KkgwghnTdxsAn4qWtXX+Pzz8Ud0m6tAzZ4f
 qf9GMG5Nw0AIgjyEhqBJFXXv5efjGtQqKn9y2F/Ns7ULthOgm9IeY1IzgJj1c/FMP0+vXHWig
 NbyRS7YGmUj6uAzRnUjf9wH+W+C10x9RndeK72XldEap25ZNjaH3J4GNqpRZOTq9rl7UByoTe
 oKjNjUEmuZCeHTEf0LYmSmrQP1s=


Am 24.01.24 um 08:49 schrieb Mathieu Othacehe:
> Describe common "gpio-line-names" property to fix dtbs_check warnings
> like:
>
> /home/mathieu/linux/arch/arm64/boot/dts/freescale/imx93-phyboard-segin.dtb:
> gpio@43830000: 'gpio-line-names' does not match any of the regexes:
> '^.+-hog(-[0-9]+)?$', 'pinctrl-[0-9]+' from schema $id:
> http://devicetree.org/schemas/gpio/gpio-vf610.yaml#
>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>

Reviewed-by: Stefan Wahren <wahrenst@gmx.net>

