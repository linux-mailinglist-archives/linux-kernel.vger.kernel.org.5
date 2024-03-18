Return-Path: <linux-kernel+bounces-106487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A4087EF59
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 577BDB217CC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB7B55E5F;
	Mon, 18 Mar 2024 17:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="V0+kA6Ha"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CA455C07;
	Mon, 18 Mar 2024 17:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710784721; cv=none; b=akglDLlIlhG5at42Y4tSdh8eNopnHqyTZK5B9D4pG0PWmvIqvgY+Gtfy7hBaVvHBB3HMo8l4OqZ+xqAw4dtRaglhiT6WL2YR7RG5Fvwz3vkSb3Srr4zbJI0J+iAkIX19/+LpkgMhJBMV4FcHMh5xZfe79l57Zk1Hj8OMnwTWeZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710784721; c=relaxed/simple;
	bh=TPxnDE5bkgZGAxq2z8iGbeup3QwNkwr5USo3SDnON2c=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=DWiDlyPewrB3iklEiLu6BL7pf0/fKZJEbisx0nYciDFrz8F90bepAhrO12X+dgE5Pxt4aP2iAd/CPr45o0lFoW5HfoHe9IaqaXfKwIGkhFs33nigZgbCrhXm0KwEUnTT8Ns8CaaIHFP4/8uuZQ54KAZrrg7c5ksxUJ+KypzqRqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=V0+kA6Ha; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1710784692; x=1711389492; i=markus.elfring@web.de;
	bh=EY0Hjw4+w2olzLszyx5nxJuGBBuLjuPZp0CFP/bSy4c=;
	h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:
	 In-Reply-To;
	b=V0+kA6HaGYAa/C6ly7UFSp2H0nnpDWqAKynSkm9PMW1zp4uwDho8xbcsfVta02IC
	 TECMyfpHJAgb6tzjOatfb4qt4pKi5/jxsWJBWHFhKpSrdkp538aOPB6WOYHfVjOyy
	 qIT67Jp8LptmP5kgPUS6JDfSSdeVkGMpSYzZbTdb55Vl0cj/BrGPqo+0CcqbnCpWU
	 leM7PVYh0icWowhyZfGGQKJff78MCjMUTx/hmO4gqEvwGILyUlNBeeRIMZrDWYkB5
	 pPUbMmuiGZk200j+p9N1ctRaN8P6SDZN3pBPF/GuNoCOzlmVtewNGA2UcpsHYo0zv
	 eiW33T1QVzxs8Zhb5w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MEUW8-1rXUSX3rQo-00GPBA; Mon, 18
 Mar 2024 18:58:12 +0100
Message-ID: <4fe6f68a-786c-4e3d-b97d-847d6965d1d3@web.de>
Date: Mon, 18 Mar 2024 18:58:10 +0100
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
X-Provags-ID: V03:K1:r2F2bDMqhKgRohtQ/KunHakzfn6SdVEejCaMS6iHsj0TxlpYJDf
 RrWyxna0jlyusRSuyumnI75ggM8jsvsRXuSkQ+/ETO/lUp0oSXC9pz2E4IlOZ9wQh6jBCds
 bS85YDJhYeS6L89hUauyhAwrYwYEqHG2jr+keShniaDz4CFsK+CsnljCojrVTaPQA/g3eCA
 Ml3JtrgsjHUHmOJ/28sfw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ghagHPhdV3o=;yuht04V33nbPduIWJm5LROvF4bF
 /mLWU5oe42zYF7JLibuZkzWFb+gf+YmBIGHGdYu4UCfnOp1aiD+sRl3R7M76F3vkCAhgLNcOF
 YjrgrL7+payvk4Wh2j/YXEAp39TNY52nowu6jOq3so6bt55wnnr5IqPCqWTUA6dhWuzeAwgBY
 SCwBY2LDqW/iwYqiS+5uqWMvA47t+fIgy2ir9HyQBMjF/UUtv/cfjIft4uDta4ez6rPWaBBmh
 qaUoej3dKW0eeEUNPLLWqqasPR+aYU6deVd+jKgXBCDFV8J8nofHQiO0aosdcgnILhANO1boy
 jgUU6rkvVXubH6a6U7HQwbdKWNoi2Iy8gQ5PbyoQwlzWno8Yx4FJJKNv1saruY0/YAbamVukN
 u/CSjXJfPAseIQrjvH49stmGF7mDfANdB7bAvwpkdB8wbzOn4t8zRWLRfbDYXDuf592Qpd5eo
 39pT6uzskfyulbIaJXoT/dGDq8ctIlTfqRSIGFfHYuCyxqA3HDTJVaY8s/cBK+RUqXcB5k+yW
 MAJmdQt3fCxZkTVTfPkzdNdL+5UnmM2uilI9Fuf7Gz9fRmTe+xl4aD+xqrnEr9ZepO0VLu9vF
 owmdMlWsWtxpofgSPasQq0DC3kgfG2amOqvHHIO0gFJYk7iXrJzp4RzkfWfhJIw/RglljeDdP
 w9aSMI+WiY6LOREuBw7/GjP/jhF4xDv0Upy68hS4CyIAXctr0/7OysI0PRa1iiRayjj7DhR4z
 1HtmAUAxid+S57vX0IMxdlzb52Tfl0xs4rwm+MEh4WjqI8sQUReeKqpeAPExHAMVh831maXZV
 Hik+fmwx5psU57Jpl6tquYdXEHmYGXV+ZW7IKksyULOdc=

=E2=80=A6
> +++ b/drivers/misc/mikrobus/mikrobus_core.c
=E2=80=A6
> +static int mikrobus_pinctrl_setup(struct mikrobus_port *port,
> +				  struct addon_board_info *board)
> +{
> +	int ret;
> +
> +	if (!board || board->pin_state[MIKROBUS_PIN_PWM] =3D=3D MIKROBUS_STATE=
_PWM)
> +		ret =3D mikrobus_pinctrl_select(port, "pwm_default");
> +	else
> +		ret =3D mikrobus_pinctrl_select(port, "pwm_gpio");
=E2=80=A6

How do you think about to avoid the specification of a bit of duplicate so=
urce code here
by using conditional operator expressions?

	ret =3D mikrobus_pinctrl_select(port,
				      ((!board ||
					board->pin_state[MIKROBUS_PIN_PWM] =3D=3D MIKROBUS_STATE_PWM)
				      ? "pwm_default"
				      : "pwm_gpio"));


Regards,
Markus

