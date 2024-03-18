Return-Path: <linux-kernel+bounces-106466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 044EC87EF07
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFA531F22FBD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0D5374CB;
	Mon, 18 Mar 2024 17:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="JogwiI17"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1ECC55780;
	Mon, 18 Mar 2024 17:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710783334; cv=none; b=uSAp/L+X2LXIgdxAT2Gi0kLJlteqomXB1xcuOZfzrIbq8Xkp7yibdOIIWtU5wqJkdnGLRDq5X/5KkyNJpYCEKrMHcEzl0lw1vjcbHmX58ZtqCLCURSFX8tIk1HE6J9RGPDLqGPL9jR6eFryZvcBKsxrTirJ0e5V85ts/K7o6siU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710783334; c=relaxed/simple;
	bh=XoJNQUUFayCUG3xRrAmVCwbMxRg8KixIWe/vEYZcOPQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=dVR6nTDi4hQOKrzpLnGlrnNuV/TbKF7BK8o9R1ajht5KcOdjWshnkhQmzzwg9fZibLtODPmEtukOysyiadLp5wFe+EaanY5HBefm2gUkdHtOBxS9jVfx1fPFEo3fnnnY1nDA45rlP5b3zAH10D1qhQrl3RH954mqG7HoBOurxow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=JogwiI17; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1710783296; x=1711388096; i=markus.elfring@web.de;
	bh=zL2UFIO2avZuf4cHRjFFmzwc7ks5q6OVftTUkucV4BQ=;
	h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:
	 In-Reply-To;
	b=JogwiI17BOi49/yQuCytE7MPZ/qIpHhWfyoqhHAd1TiqdebvHZReeoEAEJSrIeEN
	 DX3zIUxRV8l7Bx7gh0YwFqKSx1gKdlhHNX1961842Z2I6fbVA2Qk+6VDWB76T92n0
	 F2v1Z+ULfkSf/50Zf0cCOiTaNmG7vzwMFcFjQhFGduQl6nnd9CocAGpnT/hY0pZgk
	 mKBXG4pRtCuoMQPwCwy8UmhLKG29gzFTUJIQ77MJ3llLubG0VDuNz2d93DZMhyk8p
	 keSdAdQ5byNbGHds15H2XdG5kOeOEfWCHr4jJu8WsJVf5XsQPOp8NM93EXwNwQj/Q
	 vSNz9+PuUCu6RYyE1g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MzkSZ-1qrOwA3vX7-00vVE0; Mon, 18
 Mar 2024 18:34:56 +0100
Message-ID: <7d834747-0004-4556-b260-c747074a5df6@web.de>
Date: Mon, 18 Mar 2024 18:34:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ayush Singh <ayushdevel1325@gmail.com>,
 Vaishnav M A <vaishnav@beagleboard.org>, devicetree@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, lorforlinux@beagleboard.org,
 greybus-dev@lists.linaro.org
Cc: LKML <linux-kernel@vger.kernel.org>, Alex Elder <elder@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Conor Dooley <conor+dt@kernel.org>,
 Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic
 <dragan.cvetic@amd.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jason Kridner <jkridner@beagleboard.org>, Johan Hovold <johan@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Mark Brown <broonie@kernel.org>, Nishanth Menon <nm@ti.com>,
 Rob Herring <robh@kernel.org>, Robert Nelson
 <robertcnelson@beagleboard.org>, Tero Kristo <kristo@kernel.org>,
 Vaishnav M A <vaishnav.a@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
References: <20240317193714.403132-5-ayushdevel1325@gmail.com>
Subject: Re: [PATCH v4 4/5] mikrobus: Add mikroBUS driver
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240317193714.403132-5-ayushdevel1325@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rGQO4fDn0vNN389tBnKe7onogTvUErLvvTXduyGL6pWKFdmDEqy
 MCYn5pkmCHDACrPUJoNy2C7GvGm1hYCvBujMK+WsDmVllQ2MYfQf5+4qeUPkILbJYGTHjoy
 cMNmBfhajyMkcoBbxdstbnNIoU6tToHIwCqiARcUKBEdM5V/z5GbrKM5TGJjdtTWsSdEl7J
 mBvYGlMAiI8JvT71ryP2A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7zD/DEBSM+I=;jR8jlBRRX3dOz59O2ZMyBlQGtol
 u0BPn49w8vjSOeOdVkdxwlyYABexe3OvWICT6qmI9Apqsf9MKaxT8EIV5+CV04pIdjvwBE896
 1ueen8J87DYHuiI3PzZnN+2NoQbCptvE68Jp6AymKTBzPe1vw2VjsReQIqjUJJiKlsQ2jAePP
 Yi/m9dWJ1XlzlQBGURVqOHxAn4n9S+bWzqs6W3pULZkbgnMH8BIU/XqkCnCxReW/TiGzEii/G
 EFpvohWYchriay7ZZv4oP+nPZ633qrUYakf2SIlL69r/Rrvi3Kzze5ppl5HJAmnYB5Wvy0IkZ
 5SLUhpV/0DsR4+SLaUn4EEFq2rjOdWZWriQKIBXcw8/FhoEUQq8tHOeaaxy/AF+wsSUp+15q+
 k10dFxBhHnOfJ2jBWXmNfsIqj1iGGquEu8QzAV69obc26noD1e9qnKhVzWZm8mil9YyHiLYSl
 sDcXCAaccEogysA0PlBqbwcWC38hnHB2qAU89hV63umMfwr/VqD3P30E6/haT6MScpodO0tz0
 rTIaj1KNEQp2qe2SYILnp1syn1GTieirb/cnkJmoFoITI/Y66OX+CAVdyeHaJYDMStfLSljUE
 NnEzzX0PWIkut/Rkg3FOEcPeovfKjha0PoMGYm/x3QDpmDXnMkuunqrxn37M1Hxh5CkcozJzO
 wrXAIyT4AoPvF55AwkS19hbVqbV9J8V5cXn6l0OYdxyjXn+HZZKcaXedRBYmazomRlXQa7dX/
 jFczj4w8pDvlGGnOeRqD3awYga8yynVb2zhc9y2ELKVi6jiWv1GLaNSm87XUSpL2l6Nc/Rc3T
 kES1V8VyySJ69k0OKaP1TK1gG/zBpZ9dRvmKLmTiF3McI=

=E2=80=A6
> +++ b/drivers/misc/mikrobus/mikrobus_core.c
=E2=80=A6
> +static int mikrobus_pinctrl_select(struct mikrobus_port *port,
> +				   const char *pinctrl_selected)
> +{
> +	struct pinctrl_state *state;
> +	int ret;
> +
> +	state =3D pinctrl_lookup_state(port->pinctrl, pinctrl_selected);
> +	if (IS_ERR(state)) {
> +		return dev_err_probe(&port->dev, PTR_ERR(state),
> +				     "failed to find state %s",
> +				     pinctrl_selected);
> +	}
=E2=80=A6

I suggest to reconsider the need for extra curly brackets here.

See also:
Section =E2=80=9C3) Placing Braces and Spaces=E2=80=9D
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?h=3Dv6.8#n197


Regards,
Markus

