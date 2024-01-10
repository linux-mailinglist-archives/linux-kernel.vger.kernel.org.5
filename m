Return-Path: <linux-kernel+bounces-21864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1F3829562
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 09:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A76F1F2792F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 08:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7199039FC8;
	Wed, 10 Jan 2024 08:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="Fq5zqGJp"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F5B2E846;
	Wed, 10 Jan 2024 08:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1704876557; x=1705481357; i=wahrenst@gmx.net;
	bh=JrxtgNBm17lkzeJK0VyXKPOipQio/lM15hZrD/6LL7Q=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=Fq5zqGJpM4otaxcM7t6mml3UaRN5tobVBoya0vmzzYJvxG/VHvGMYZ1A4h7ONm6K
	 qzovPGaiGIdme1BEyoR/72JjQc850jDJmmUoQ8elmPySYpMN/terfrnPnfvThbifO
	 Oq9a2pqpRPBlw3ch7KmTi5oQyEVWkKH4uybaoAfhkVMDBUwdN7g8QZjHquqEBFFpd
	 45Y2r6G0s4fqdrFqEiqX0M0SAHXZJ/iKRZFYrUzs8JEzQRGdXuKvNIuzjlg9F8F/N
	 3kbKGPbxD8SSkHY85SErFIYlUdmZe4SGErOqjuuUjU/g0V1b+8gDUwpk/TmfJxKaK
	 p4rL3/9Vs7CC5ztvWA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.167] ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M9Wuk-1rHyUz2hMa-005bwq; Wed, 10
 Jan 2024 09:49:17 +0100
Message-ID: <3794475b-8478-47f0-91e4-ef493876a2e3@gmx.net>
Date: Wed, 10 Jan 2024 09:49:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: 8250_bcm2835aux: Restore clock error handling
To: Jeremy Linton <jeremy.linton@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Adrien Thierry <athierry@redhat.com>, linux-serial@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20231220114334.4712-1-wahrenst@gmx.net>
 <1b0de096-101a-9764-0396-d8b86878badf@arm.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <1b0de096-101a-9764-0396-d8b86878badf@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:e2zavpBeluNK2KF0ytcSIarq8mJ83OJ3weeoWxTyrXHQZi8NwMG
 uThqdzdqw3oT+fJ2Q50kVt5l0gAspPnPNOop3pfTRtplfLlfYDIPQTjDixbzWzgXJjEDRbT
 eqODyP9U/Fv5hMehLGyebdjQR2FYtw3OyhKss6RCiLv/RGwp+wHhmMTNwIe6hn90A+YOc8i
 Rv9Ke6I7108+h00dJjk3w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fP5lHLrN6wU=;n6VAKI+CAS+mBnl+UmFnP5q+9Pr
 FYOxDBcqkWO2Zd9vRJe99JFze4jPTeALRCRMelnc3shgUWDuWHANvNX5R/kxkKp0nxjbZgxPL
 +xXlbJSErbaO0lP+iigXzLtmEeL4x42NLxP9LSqAyEgkxJ2U8UGVfC7EhOjAM7NWSuBCmqNP4
 zLKvSQDZ38hiX75/ESLFfyu+cY1Ax+cdDbJWgizqLr2e/q+dbNpWrRIIEmehO7Ujsojfd1pL2
 MZH8WMdX8EE/4vCNRtgzdGgoLUC9SCpF81OsNLvOE79knc2AyvVSONySYncZd9CgwL74v8Vmr
 qu/6W/UoONuuaa4dbCw16GoEDGbVtxFuYrOsoWoFRe8iVxwzk58b7SNT33vDG1F1LfUmCfBKR
 IxcVUx6najOEpv3ApfNpgII3WABMipXUt35k7VcQAGwkIJSnfhIRYsTtTwNWlXD6khqJjCcQ7
 7dbvm4orATr62nhLBdURyaZ8+9xndPsPipNtxSexSpu2K4qXNN216bJZAgZ8aLrJoAt8/ttdA
 QkeQGgjL71h6EMToL2GR6wm6J/C+7Cr6MOJp3u27jXRj9RfBCNbccTww8bZKKWyw4zZ0qN/E7
 x3FTkc44swB5KrtJAZXHzTAGgI1XPtd0GSDT49f1fka94Fd2i/9dqRRFMXBMj9b3LH7GhPhP9
 5yHU2jboanFOQtF4ub6uu+sn7CmVXbq75rVVJTSW2i8Sijd6Z8iAxn0KPPJM/FEvG7JLVTBlP
 p9//nFC0m4tngInUvElFkE0Mt0+IFQqaYhaekKf+CF46A8Hfku601nKJPGnmaN+x/526v1PCG
 4ajPZmeuOdV+Dp65AhYY5qbxn4IRmjIV5M9JHPmVGlNheRtuYAbN45+9YkZaX4ZumLFxfQgjl
 OtNPsFExI7NRC67ktoukLsw46uj/HEis67TbWsyu3QbnjshG7WL36YRyvR1s5kIvV6n6ZmmXf
 cHROKg0Pb2k6ghSELkNnei+0nwY=

Hi Jeremy,

Am 10.01.24 um 01:01 schrieb Jeremy Linton:
> Hi,
>
>
> On 12/20/23 05:43, Stefan Wahren wrote:
>> The commit fcc446c8aa63 ("serial: 8250_bcm2835aux: Add ACPI support")
>> dropped the error handling for clock acquiring. But even an optional
>> clock needs this.
>
> Right, the call was changed to _optional() during review but the error
> handling didn't get put back.
>
>>
>> Fixes: fcc446c8aa63 ("serial: 8250_bcm2835aux: Add ACPI support")
>> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
>> ---
>> =C2=A0 drivers/tty/serial/8250/8250_bcm2835aux.c | 2 ++
>> =C2=A0 1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/tty/serial/8250/8250_bcm2835aux.c
>> b/drivers/tty/serial/8250/8250_bcm2835aux.c
>> index 15a2387a5b25..4f4502fb5454 100644
>> --- a/drivers/tty/serial/8250/8250_bcm2835aux.c
>> +++ b/drivers/tty/serial/8250/8250_bcm2835aux.c
>> @@ -119,6 +119,8 @@ static int bcm2835aux_serial_probe(struct
>> platform_device *pdev)
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* get the clock - this also enables the=
 HW */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->clk =3D devm_clk_get_optional(&pde=
v->dev, NULL);
>> +=C2=A0=C2=A0=C2=A0 if (IS_ERR(data->clk))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return dev_err_probe(&pdev-=
>dev, PTR_ERR(data->clk), "could
>> not get clk\n");
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* get the interrupt */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D platform_get_irq(pdev, 0);
>> --
>
> And on ACPI machines it returns NULL, which passes the error check
> now, so it works on an ACPI based pi.
>
> Thanks!
>
> Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>
> Tested-by: Jeremy Linton <jeremy.linton@arm.com>

thanks for testing. The patch is already in linux-next.

Regards

